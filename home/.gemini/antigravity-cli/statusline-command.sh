#!/bin/bash
# Antigravity CLI (agy) statusline script
# Shows active model (with High/Low tier), token usage, context progress bar, and quota limit with reset time.

JSON_INPUT=$(cat)

jq -r '
  # @function to_k
  # @description トークン数を "k" 単位の文字列に整形する
  # @param {number} val - トークン数
  # @returns {string} フォーマット後の文字列（例: "12.3k"）
  def to_k(val): (val / 100) | round / 10 | tostring | . + "k";

  # @function make_bar
  # @description 10段階のプログレスバー文字列を生成する
  # @param {number} filled - 塗りつぶすブロック数 (0〜10)
  # @returns {string} 10文字のバー文字列
  def make_bar(filled):
    (if filled > 10 then 10 elif filled < 0 then 0 else filled end) as $f |
    [range($f) | "█"] + [range(10 - $f) | "░"] | join("");

  # @function format_model
  # @description モデル表示名を短縮しつつ High/Low 等の tier 情報を保持する
  # @param {string} name - モデル表示名
  # @returns {string} 短縮・整形されたモデル名
  def format_model(name):
    if (name | contains("High")) then
      ((name | sub(" \\(High\\)"; "")) + " (High)")
    elif (name | contains("Low")) then
      ((name | sub(" \\(Low\\)"; "")) + " (Low)")
    elif (name | contains("Standard")) then
      ((name | sub(" \\(Standard\\)"; "")) + " (Std)")
    else
      name
    end;

  # @function format_reset
  # @description ISO8601形式のUTC時刻をローカル時刻に変換してリセット表示用文字列を返す
  # @param {string} iso_str - ISO8601形式のUTC日時文字列
  # @returns {string} 当日なら "HH:MM"、別日なら "MM/DD HH:MM"
  def format_reset(iso_str):
    if iso_str == null or iso_str == "" then ""
    else
      (iso_str | try (
        fromdateiso8601 as $ts |
        (now | strflocaltime("%Y-%m-%d")) as $today |
        ($ts | strflocaltime("%Y-%m-%d")) as $reset_day |
        if $today == $reset_day then
          ($ts | strflocaltime("%H:%M"))
        else
          ($ts | strflocaltime("%m/%d %H:%M"))
        end
      ) catch "")
    end;

  # カラーエスケープシーケンス
  "\u001b[0m" as $reset |
  "\u001b[1m" as $bold |
  "\u001b[32m" as $green |
  "\u001b[33m" as $yellow |
  "\u001b[31m" as $red |
  "\u001b[36m" as $cyan |
  "\u001b[90m" as $gray |

  # モデル表示名
  format_model(.model.display_name) as $model |

  # トークン消費量
  to_k(.context_window.total_input_tokens) as $in |
  to_k(.context_window.total_output_tokens) as $out |

  # コンテキスト占有率とカラー判定
  .context_window.used_percentage as $used_pct |
  ($used_pct / 10 | round) as $ctx_filled |
  (if $used_pct < 30 then $green elif $used_pct < 70 then $yellow else $red end) as $ctx_color |
  (($used_pct * 10 | round / 10 | tostring) + "%") as $ctx_str |
  make_bar($ctx_filled) as $ctx_bar |

  # 利用中モデルに対応するクォータ情報を優先して取得
  ((.model.id // "") | ascii_downcase) as $mid |
  (if ($mid | contains("claude") or contains("gpt") or contains("sonnet") or contains("opus")) then
    (.quota["3p-5h"] // .quota["gemini-5h"] // .quota["3p-weekly"] // .quota["gemini-weekly"] // {})
  else
    (.quota["gemini-5h"] // .quota["3p-5h"] // .quota["gemini-weekly"] // .quota["3p-weekly"] // {})
  end) as $q_obj |

  ($q_obj.remaining_fraction // 1.0) as $q_frac |
  ($q_frac * 10 | round) as $quota_filled |
  (if $q_frac > 0.8 then $green elif $q_frac > 0.3 then $yellow else $red end) as $quota_color |
  (($q_frac * 100 | round | tostring) + "%") as $quota_str |
  make_bar($quota_filled) as $quota_bar |

  # リセット時刻が存在する場合のみ表示用テキストを組み立てる
  format_reset($q_obj.reset_time) as $reset_time_str |
  (if $reset_time_str != "" then " " + $gray + "(resets " + $reset_time_str + ")" + $reset else "" end) as $reset_display |

  # 出力フォーマット
  "\($bold)[\($cyan)\($model)\($reset)\($bold)]\($reset) \($gray)Usage:\($reset) In: \($in) \(" | ")Out: \($out) \(" | ")Ctx: \($ctx_color)[\($ctx_bar)] \($ctx_str)\($reset) \(" | ")Quota: \($quota_color)[\($quota_bar)] \($quota_str)\($reset)\($reset_display)"
' <<< "$JSON_INPUT"
