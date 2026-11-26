# Prompt in the terminal's 16 ANSI colors, which pywal16 sets (or the terminal's
# defaults without it), so it follows every colorscheme change on its own.

# Arrow in the marker color (10) after a successful command, the error color (1)
# after a failed one, then the directory in the accent (5); %1{...%} tells zsh the
# arrow is one column wide
PROMPT="%(?:%F{10}%B%1{➜%}%b:%F{1}%B%1{➜%}%b)%f %F{5}%B%c%b%f"
PROMPT+=' $(git_prompt_info)'

# Branch in overlay0 (8), dirty mark in modified (11)
ZSH_THEME_GIT_PROMPT_PREFIX="%F{8}%1{%} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%f "
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{11}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
