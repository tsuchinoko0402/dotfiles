#!/bin/bash
# Antigravity CLI (agy) statusline script
# Shows active model, token usage, context size, and quota limit.

JSON_INPUT=$(cat)

jq -r '
  # Helper to format numbers to "k"
  def to_k(val): (val / 100) | round / 10 | tostring | . + "k";

  # Color Escape codes
  "\u001b[0m" as $reset |
  "\u001b[1m" as $bold |
  "\u001b[32m" as $green |
  "\u001b[33m" as $yellow |
  "\u001b[31m" as $red |
  "\u001b[36m" as $cyan |
  "\u001b[90m" as $gray |

  # Model Display Name
  (.model.display_name | sub(" \\(High\\)"; "")) as $model |

  # Token usages
  to_k(.context_window.total_input_tokens) as $in |
  to_k(.context_window.total_output_tokens) as $out |

  # Ctx usage and color
  .context_window.used_percentage as $used_pct |
  (if $used_pct < 30 then $green elif $used_pct < 70 then $yellow else $red end) as $ctx_color |
  (($used_pct * 10 | round / 10 | tostring) + "%") as $ctx_str |

  # Quota usage and color
  (.quota["gemini-5h"].remaining_fraction // 1.0) as $q5h_frac |
  (if $q5h_frac > 0.8 then $green elif $q5h_frac > 0.3 then $yellow else $red end) as $quota_color |
  (($q5h_frac * 100 | round | tostring) + "%") as $quota_str |

  # Output format
  "\($bold)[\($cyan)\($model)\($reset)\($bold)]\($reset) \($gray)Usage:\($reset) In: \($in) \(" | ")Out: \($out) \(" | ")Ctx: \($ctx_color)\($ctx_str)\($reset) \(" | ")Quota: \($quota_color)\($quota_str)\($reset)"
' <<< "$JSON_INPUT"
