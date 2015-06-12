FROM frvi/dashing

ENV CONSUL_TEMPLATE_HOME /etc/consul-template
ENV PATH $PATH:$CONSUL_TEMPLATE_HOME/bin
ENV DASHING_AUTH_TOKEN MY_AUTH_TOKEN
ENV CONSUL_SERVER_URL consul:8500
ENV URL_PATTERN http://{__SERVICE_NAME__}.{__IP__}.xip.io{__PORT__}/{__SERVICE_NAME__}/

RUN apt-get update && \
    apt-get install -y curl && \
    mkdir $CONSUL_TEMPLATE_HOME && \
	curl -L https://github.com/hashicorp/consul-template/releases/download/v0.9.0/consul-template_0.9.0_linux_amd64.tar.gz | \
	tar xvz -C $CONSUL_TEMPLATE_HOME && \
	cd $CONSUL_TEMPLATE_HOME && \
	mv consul-template_0.9.0_linux_amd64 bin && \
	mkdir $CONSUL_TEMPLATE_HOME/consul-template.d/ && \
	mkdir $CONSUL_TEMPLATE_HOME/ctmpl/

COPY consul/ctmpl $CONSUL_TEMPLATE_HOME/ctmpl
COPY consul/config $CONSUL_TEMPLATE_HOME/consul-template.d
COPY dashing /dashing
COPY start.sh /start.sh

VOLUME ["/dashing/assets/images", "$CONSUL_TEMPLATE_HOME/ctmpl"]

CMD /start.sh

