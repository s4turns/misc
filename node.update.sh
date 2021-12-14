sudo apt update
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
nvm ls-remote
echo What version do you want to install?

read ver

nvm install $ver
