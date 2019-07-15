#!/bin/bash
test -f ~/secrets.tar.gz.enc || curl -o ~/secrets.tar.gz.enc https://cloud.scimetis.net/s/$KEY/download
openssl enc -aes-256-cbc -d -in ~/secrets.tar.gz.enc | tar -zxv --strip 2 secrets/docker-mail-stack/fetchmailrc \
secrets/docker-mail-stack/users secrets/docker-mail-stack/15-lda.conf secrets/docker-mail-stack/feed2imaprc
sudo chown root. fetchmailrc users 15-lda.conf feed2imaprc
sudo chmod a-r feed2imaprc
# --force-recreate is used to recreate container when crontab file has changed
unset VERSION_DOVECOT VERSION_FETCHMAIL VERSION_FEED2IMAP VERSION_CRON
VERSION_DOVECOT=$(git ls-remote ssh://git@git.scimetis.net:2222/yohan/docker-dovecot.git| head -1 | cut -f 1|cut -c -10) \
VERSION_FETCHMAIL=$(git ls-remote ssh://git@git.scimetis.net:2222/yohan/docker-fetchmail.git| head -1 | cut -f 1|cut -c -10) \
VERSION_FEED2IMAP=$(git ls-remote ssh://git@git.scimetis.net:2222/yohan/docker-feed2imap.git| head -1 | cut -f 1|cut -c -10) \
VERSION_CRON=$(git ls-remote ssh://git@git.scimetis.net:2222/yohan/docker-cron.git| head -1 | cut -f 1|cut -c -10) \
 sudo -E bash -c 'docker-compose up -d --force-recreate'
# /!\ We cannot remove the secrets files or restarting the container would become impossible.
