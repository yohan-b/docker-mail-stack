#!/bin/bash

doveadm expunge -u admin mailbox Trash savedbefore 30d
echo `date +"%F %T"` "Trash purged"

doveadm expunge -u admin mailbox Feeds.phoronix savedbefore 60d
doveadm expunge -u admin mailbox Feeds.hardwarefr savedbefore 60d
doveadm expunge -u admin mailbox Feeds.pcinpact_articles savedbefore 60d
doveadm expunge -u admin mailbox Feeds.planet_debian savedbefore 60d
doveadm expunge -u admin mailbox Feeds.planet-fr_debian_net savedbefore 60d
doveadm expunge -u admin mailbox Feeds.planetkde savedbefore 60d
doveadm expunge -u admin mailbox Feeds.le_monde savedbefore 60d
doveadm expunge -u admin mailbox Feeds.hardwarefr_articles savedbefore 60d
doveadm expunge -u admin mailbox Feeds.lesnumeriques savedbefore 60d
doveadm expunge -u admin mailbox Feeds.planet_libre savedbefore 60d
doveadm expunge -u admin mailbox Feeds.fedora-fr savedbefore 60d
doveadm expunge -u admin mailbox Feeds.pcinpact savedbefore 60d
doveadm expunge -u admin mailbox Feeds.dotkdeorg savedbefore 60d
doveadm expunge -u admin mailbox Feeds.reddit_science savedbefore 60d
doveadm expunge -u admin mailbox Feeds.reddit_technology savedbefore 60d
doveadm expunge -u admin mailbox Feeds.ars_technica savedbefore 60d
doveadm expunge -u admin mailbox Feeds.cinema_france savedbefore 60d
doveadm expunge -u admin mailbox Feeds.cinema_usa savedbefore 60d
echo `date +"%F %T"` "Old feeds purged"
exit 0

