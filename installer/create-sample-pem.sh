#! /usr/bin/env bash


cat << EOF > ./.sample.pem
-----BEGIN RSA PRIVATE KEY-----
-----END RSA PRIVATE KEY-----
EOF
chmod 400 ./.sample.pem

# add env
MYACCOUNT=$(id | awk -F"[()]" '{print $2}')
MYCONF='/'$MYACCOUNT'/.bashrc'
CUR_DIR=$(pwd)'/usr/bin'

RESULT=$(cat $MYCONF | grep -i 'path')
if [[ $RESULT ]]
then
        PATHRESULT=$(cat $MYCONF | grep -i $CUR_DIR)
        if [[ ! $PATHRESULT ]]
        then
                VALUES=$(echo $RESULT | awk -F"[=]" '{print $2}')
                REP_STRING=$VALUES':'$CUR_DIR
                sed -i 's/^PATH/# PATH/' $MYCONF
                echo "" >> $MYCONF
                echo $REP_STRING >> $MYCONF
        fi
else
        echo "" >> $MYCONF
        echo "PATH="\$PATH:"$CUR_DIR" >> $MYCONF
fi
