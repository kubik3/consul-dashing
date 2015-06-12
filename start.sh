#!/bin/bash

#Updating values
find ${CONSUL_TEMPLATE_HOME} -type f -exec sed -i 's|__CONSUL_TEMPLATE_HOME__|'$CONSUL_TEMPLATE_HOME'|g' {} +

find ${CONSUL_TEMPLATE_HOME} -type f -exec sed -i 's|__URL_PATTERN__|'$URL_PATTERN'|g' {} +
find ${CONSUL_TEMPLATE_HOME} -type f -exec sed -i 's|{__SERVICE_NAME__}|" \$name "|g' {} +
find ${CONSUL_TEMPLATE_HOME} -type f -exec sed -i 's|{__PORT__}|:" \$Port "|g' {} +
find ${CONSUL_TEMPLATE_HOME} -type f -exec sed -i 's|{__IP__}|" \$Address "|g' {} +

find ${CONSUL_TEMPLATE_HOME} -type f -exec sed -i "s/__YOUR_AUTH_TOKEN__/${DASHING_AUTH_TOKEN}/g" {} +

find /dashing -type f -exec sed -i "s/YOUR_AUTH_TOKEN/${DASHING_AUTH_TOKEN}/g" {} +

find ${CONSUL_TEMPLATE_HOME} -type f -exec sed -i "s/__CONSUL_URL__/${CONSUL_SERVER_URL}/g" {} +

#Running Dashing
/run.sh & 

sleep 10

#Running Consul Template
consul-template -config "${CONSUL_TEMPLATE_HOME}/consul-template.d/" -retry 10s && fg