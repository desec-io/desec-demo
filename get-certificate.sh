#!/usr/bin/bash
#doitlive prompt: $
#doitlive speed: 3

# envsubst '$DOMAIN' < get-certificate.sh > tmp.get-certificate.sh
# TOKEN=my_token doitlive play tmp.get-certificate.sh

TOKEN=YourTokenString
http https://desec.io/api/v1/domains/ Authorization:"Token $TOKEN"
http POST https://desec.io/api/v1/domains/ Authorization:"Token $TOKEN" name:='"$DOMAIN"'

curl https://raw.githubusercontent.com/desec-io/certbot-hook/master/hook.sh > hook.sh
chmod +x hook.sh
./hook.sh
touch .dedynauth
./hook.sh
echo DEDYN_TOKEN=$TOKEN >> .dedynauth
./hook.sh
echo DEDYN_NAME=$DOMAIN >> .dedynauth
./hook.sh
certbot --config-dir cb/config --logs-dir cb/logs --work-dir cb/work --manual --text --preferred-challenges dns --manual-auth-hook ./hook.sh -d "$DOMAIN" -d "www.$DOMAIN" certonly

http GET https://desec.io/api/v1/domains/$DOMAIN/rrsets/ Authorization:"Token $TOKEN"
openssl x509 -in cb/config/live/$DOMAIN/chain.pem -text -noout

http DELETE https://desec.io/api/v1/domains/$DOMAIN/ Authorization:"Token $TOKEN"
rm -rf .dedynauth hook.sh cb
