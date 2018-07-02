# Start the ssh-agent as soon as the terminal opens.
# This way SSH keys get added so that you can have SSH access to GitHub and other SSH-based services.
eval "$(ssh-agent -s)"
eval "$(ssh-add ~/.ssh/id_rsa)"

# Initialize rbenv.
eval "$(rbenv init -)"

# rw - Ruby Workspace.
alias rw="cd ~/workspace/ruby"

# bes - Runs Ruby RSpec unit tests.
alias bes="bundle exec rspec"

# Sets $BUNDLER_EDITOR so that you can run `bundle open <gemname>
# Otherwise the following error will appear:
#
# $ bundle open i18n
# To open a bundled gem, set $EDITOR or $BUNDLER_EDITOR
#
# N.B. Setting `EDITOR` may cause problems with `git rebase -i HEAD~<n>`
export BUNDLER_EDITOR='subl'