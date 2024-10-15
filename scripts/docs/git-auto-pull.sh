#!/bin/bash
cd path-to-repo || exit
git pull origin main  # Replace 'main' with your branch name if necessary
chmod +x /path/to/your/repository/git-auto-pull.sh
crontab -e
*/5 * * * * /path/to/your/repository/git-auto-pull.sh >> /path/to/your/repository/git-auto-pull.log 2>&1
/path/to/your/repository/git-auto-pull.sh
crontab -l
