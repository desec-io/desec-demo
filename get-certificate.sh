#!/usr/bin/bash
#doitlive prompt: $
#doitlive speed: 3

# envsubst '$DOMAIN' < get-certificate.sh > tmp.get-certificate.sh
# TOKEN=my_token doitlive play tmp.get-certificate.sh

TOKEN=YourTokenString
http https://desec.io/api/v1/domains/ Authorization:"Token $TOKEN"
http POST https://desec.io/api/v1/domains/ Authorization:"Token $TOKEN" name:='"$DOMAIN"'

curl https://raw.githubusercontent.com/desec-io/certbot-hook/master/hook.sh > hook.sh
chmod 755 hook.sh
./hook.sh
touch .dedynauth
./hook.sh
echo DEDYN_TOKEN=$TOKEN >> .dedynauth
./hook.sh
echo DEDYN_NAME=$DOMAIN >> .dedynauth
./hook.sh
sudo certbot --manual --text --preferred-challenges dns --manual-auth-hook ./hook.sh -d "$DOMAIN" -d "www.$DOMAIN" --dry-run certonly

http GET https://desec.io/api/v1/domains/$DOMAIN/rrsets/ Authorization:"Token $TOKEN"
http DELETE https://desec.io/api/v1/domains/$DOMAIN/ Authorization:"Token $TOKEN"
rm .dedynauth hook.sh
