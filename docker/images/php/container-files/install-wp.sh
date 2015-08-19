#!/bin/bash

if [ ! -L /var/www/wp/wp-content ]
then
    rm -fr /var/www/wp/wp-content
    echo "rm wp-content"
    cd /var/www/wp
    echo "cd"
    ln -s /var/www/wp-content/ wp-content
    echo "ln wp-content"
fi
exit 1