#!/bin/bash
test -f ~/secrets.tar.gz.enc || curl -o ~/secrets.tar.gz.enc "https://cloud.scimetis.net/s/${KEY}/download?path=%2F&files=secrets.tar.gz.enc"
openssl enc -aes-256-cbc -d -in ~/secrets.tar.gz.enc | tar -zxv --strip 2 secrets/docker-mail-stack/fetchmailrc-orange \
secrets/docker-mail-stack/users secrets/docker-mail-stack/15-lda.conf secrets/docker-mail-stack/feed2imaprc \
secrets/docker-mail-stack/fetchmailrc-scimetis
sudo chown root. fetchmailrc-orange fetchmailrc-scimetis users 15-lda.conf feed2imaprc
sudo chmod a-r feed2imaprc

unset VERSION_DOVECOT VERSION_FETCHMAIL VERSION_FEED2IMAP
VERSION_DOVECOT=$(git ls-remote https://git.scimetis.net/yohan/docker-dovecot.git| head -1 | cut -f 1|cut -c -10)
VERSION_FETCHMAIL=$(git ls-remote https://git.scimetis.net/yohan/docker-fetchmail.git| head -1 | cut -f 1|cut -c -10)
VERSION_FEED2IMAP=$(git ls-remote https://git.scimetis.net/yohan/docker-feed2imap.git| head -1 | cut -f 1|cut -c -10)

rm -rf ~/build
mkdir -p ~/build
git clone https://git.scimetis.net/yohan/docker-dovecot.git ~/build/docker-dovecot
sudo docker build -t dovecot:$VERSION_DOVECOT ~/build/docker-dovecot
git clone https://git.scimetis.net/yohan/docker-fetchmail.git ~/build/docker-fetchmail
sudo docker build -t fetchmail:$VERSION_FETCHMAIL ~/build/docker-fetchmail
git clone https://git.scimetis.net/yohan/docker-feed2imap.git ~/build/docker-feed2imap
sudo docker build -t feed2imap:$VERSION_FEED2IMAP ~/build/docker-feed2imap
VERSION_DOVECOT=$VERSION_DOVECOT \
VERSION_FETCHMAIL=$VERSION_FETCHMAIL \
VERSION_FEED2IMAP=$VERSION_FEED2IMAP \
 sudo -E bash -c 'docker-compose up -d --force-recreate'
# --force-recreate is used to recreate container when a file has changed
# /!\ We cannot remove the secrets files or restarting the container would become impossible.
rm -rf ~/build
