# Fix broken MySQL installations on OS X El Captain
# 4272016

ps -ax | grep mysql

# Kill all mysql instances
pkill mysql
pkill mysqld
pkill mysqld_safe

# Remove all traces of MySQL
brew uninstall --force mysql
brew remove mysql
brew cleanup
sudo rm /usr/local/mysql
sudo rm -rf /usr/local/var/mysql
sudo rm -rf /usr/local/mysql*
sudo rm ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
sudo rm -rf /Library/StartupItems/MySQLCOM
sudo rm -rf /Library/PreferencePanes/My*
launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
rm -rf ~/Library/PreferencePanes/My*
sudo rm -rf /Library/Receipts/mysql*
sudo rm -rf /Library/Receipts/MySQL*
sudo rm -rf /private/var/db/receipts/*mysql*

# Prepare homebrew
brew doctor
brew update

# Install MySQL via homebrew
brew install mysql
unset TMPDIR
mysqld -initialize --verbose --user=whoami --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp
mysql.server start
/usr/local/Cellar/mysql/5.7.12/bin/mysql_secure_installation
brew services start mysql

