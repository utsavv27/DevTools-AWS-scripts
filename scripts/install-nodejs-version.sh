
#!/bin/bash
sudo apt update
sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/.bashrc
nvm list-remote
nvm install v20.10.0