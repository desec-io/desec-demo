#!/usr/bin/bash
#doitlive prompt: $
#doitlive speed: 5

TOKEN=YourTokenString
http https://desec.io/api/v1/domains/ Authorization:"Token $TOKEN"
http POST https://desec.io/api/v1/domains/ Authorization:"Token $TOKEN" name:='"demo.dedyn.io"'
dig +short +dnssec SOA demo.dedyn.io @ns1.desec.io
dig +short +dnssec A demo.dedyn.io @ns1.desec.io
http POST https://desec.io/api/v1/domains/demo.dedyn.io/rrsets/ Authorization:"Token $TOKEN" type:='"A"' records:='["127.0.0.1", "127.0.0.2"]' ttl:=60
dig +short +dnssec A demo.dedyn.io @ns1.desec.io
http DELETE https://desec.io/api/v1/domains/demo.dedyn.io/ Authorization:"Token $TOKEN"
dig +short +dnssec SOA demo.dedyn.io @ns1.desec.io

