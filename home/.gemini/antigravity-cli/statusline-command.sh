#!/bin/bash
# Antigravity CLI (agy) statusline script
# Shows active model (with High/Low tier), token usage, context progress bar, and quota limit.

JSON_INPUT=$(cat)

jq -r '
  # Helper to format numbers to "k"
  def to_k(val): (val / 100) | round / 10 | tostring | . + "k";

  # Helper to build a progress bar (10 blocks)
  def make_bar(filled):
    (if filled > 10 then 10 elif filled < 0 then 0 else filled end) as $f |
    [range($f) | "█"] + [range(10 - $f) | "░"] | join("");

  # Helper to format Model display name and keep High/Low indicator
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

  # Color Escape codes
  "\u001b[0m" as $reset |
  "\u001b[1m" as $bold |
  "\u001b[32m" as $green |
  "\u001b[33m" as $yellow |
  "\u001b[31m" as $red |
  "\u001b[36m" as $cyan |
  "\u001b[90m" as $gray |

  # Model Display Name (Formatting to keep tier info)
  format_model(.model.display_name) as $model |

  # Token usages
  to_k(.context_window.total_input_tokens) as $in |
  to_k(.context_window.total_output_tokens) as $out |

  # Ctx usage and color
  .context_window.used_percentage as $used_pct |
  ($used_pct / 10 | round) as $ctx_filled |
  (if $used_pct < 30 then $green elif $used_pct < 70 then $yellow else $red end) as $ctx_color |
  (($used_pct * 10 | round / 10 | tostring) + "%") as $ctx_str |
  make_bar($ctx_filled) as $ctx_bar |

  # Quota usage and color
  (.quota["gemini-5h"].remaining_fraction // 1.0) as $q5h_frac |
  ($q5h_frac * 10 | round) as $quota_filled |
  (if $q5h_frac > 0.8 then $green elif $q5h_frac > 0.3 then $yellow else $red end) as $quota_color |
  (($q5h_frac * 100 | round | tostring) + "%") as $quota_str |
  make_bar($quota_filled) as $quota_bar |

  # Output format
  "\($bold)[\($cyan)\($model)\($reset)\($bold)]\($reset) \($gray)Usage:\($reset) In: \($in) \(" | ")Out: \($out) \(" | ")Ctx: \($ctx_color)[\($ctx_bar)] \($ctx_str)\($reset) \(" | ")Quota: \($quota_color)[\($quota_bar)] \($quota_str)\($reset)"
' <<< "$JSON_INPUT"
