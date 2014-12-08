#!/bin/sh
rm -rf $HOME/.vim/bundle/vundle

for name in *; do
  target="$HOME/.$name"
  if [ -e "$target" ]; then
    if [ ! -L "$target" ]; then
      echo "WARNING: $target exists but is not a symlink."
    fi
  else
    if [ "$name" != 'install.sh' ] && [ "$name" != 'README.md' ]; then
      echo "Creating $target"
      ln -s "$PWD/$name" "$target"
    fi
  fi
done

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim -u ~/.vimrc.bundles +BundleInstall +qa

### Customization

echo "Enter the name of the computer: "
read computer_name

remove_and_link(){
  local target="$2"
  local source="$1"

  if [[ -d "${target}" && ! -L "${target}" ]] ; then
    mv "${target}" "${target}.old"
  fi

  ln -snf "${source}" "${target}"
}

# Messages
remove_and_link "$HOME/Dropbox/SoftwareSettings/Messages.$computer_name" "$HOME/Library/Messages"

# Skype
remove_and_link "$HOME/Dropbox/SoftwareSettings/kategengler.$computer_name.skype" "$HOME/Library/Application Support/Skype/kategengler"

# KeyRemap4Mac
remove_and_link "$HOME/Dropbox/SoftwareSettings/KeyRemap4MacBook" "$HOME/Library/Application Support/KeyRemap4MacBook"

# iTerm2
remove_and_link "$HOME/Dropbox/SoftwareSettings/iterm.plist" "$HOME/Library/Preferences/com.googlecode.iterm2.plist"

# Adium
remove_and_link "$HOME/Dropbox/Adium 2.0" "$HOME/Library/Application Support/Adium 2.0"

# RubyMine
remove_and_link "$HOME/Dropbox/RubyMine Config/RubyMine60" "$HOME/Library/Preferences/RubyMine70"

# SSH Config
remove_and_link "$HOME/dotfiles/ssh_config" "$HOME/.ssh/config"

if [[ ! -d "$HOME/dev" ]]; then
  mkdir "$HOME/dev"
fi
