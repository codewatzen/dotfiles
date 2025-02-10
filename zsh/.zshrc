# ==============================================
# Environment Variables
# ==============================================
export CONFIG="${HOME}/.config"
export TERM="tmux-256color"                 # Support 256 colors in tmux
export BROWSER="firefox"

# ==============================================
# Shell Configuration
# ==============================================
# Path to your existing bash configuration
[ -f "$HOME/.profile" ] && source "$HOME/.profile"

# ==============================================
# Plugin & Configuration Sourcing
# ==============================================
# Load custom functions and aliases
source "${CONFIG}/.aliasrc"
source "${CONFIG}/functions/.funcsrc"

# Zsh plugins
source "${CONFIG}/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "${CONFIG}/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# ==============================================
# History Configuration
# ==============================================
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

# History management options
setopt EXTENDED_HISTORY        # Record timestamp and duration
setopt SHARE_HISTORY           # Share history across sessions
setopt HIST_EXPIRE_DUPS_FIRST  # Remove duplicates first when trimming
setopt HIST_IGNORE_DUPS        # Ignore repeated commands
setopt HIST_IGNORE_ALL_DUPS    # Remove older duplicates
setopt HIST_FIND_NO_DUPS       # Skip duplicates in search
setopt HIST_IGNORE_SPACE       # Don't record commands starting with space
setopt HIST_SAVE_NO_DUPS       # Prevent saving duplicates
setopt HIST_VERIFY             # Show command before execution

# ==============================================
# Shell Behavior Options
# ==============================================
setopt AUTO_CD              # Change directories without cd
setopt AUTO_PUSHD           # Maintain directory stack
setopt PUSHD_IGNORE_DUPS    # Avoid duplicates in directory stack
setopt PUSHD_SILENT         # Suppress directory stack output
setopt CORRECT              # Suggest command corrections
setopt CDABLE_VARS          # cd to variable-stored paths
setopt EXTENDED_GLOB        # Enhanced pattern matching
setopt NULL_GLOB            # Allow patterns to expand to nothing
setopt NO_BEEP              # Disable error beeps
setopt NO_MATCH             # Warn on failed globs
setopt NOTIFY               # Immediate job status reports

# ==============================================
# Key Bindings & Input
# ==============================================
# Use Emacs-style key bindings
bindkey -e

# Custom key bindings
bindkey '^I'   complete-word              # Tab completion
bindkey '^[[Z' autosuggest-accept         # Shift+Tab to accept suggestion

# ==============================================
# Completion System
# ==============================================
# Initialize completion system
autoload -Uz compinit
compinit

# Completion settings
_comp_options+=(globdots)  # Include hidden files in completion
zstyle ':completion:*' squeeze-slashes true  # Clean path completions

# ==============================================
# Prompt Configuration
# ==============================================
# Initialize Starship prompt
eval "$(starship init zsh)"

if command -v fastfetch 2&>/dev/null; then 
	fastfetch
fi 
