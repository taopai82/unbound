FROM alpine:latest
RUN apk add --update unbound && wget -O /usr/share/dns-root-hints/named.root https://www.internic.net/domain/named.root
RUN sed -i 's/verbosity: 1/verbosity: 0/g; \
	s/# do-ip6: yes/do-ip6: no/g; \
	s/# edns-buffer-size: 4096/edns-buffer-size: 1472/g; \
	s/# prefetch: no/prefetch: yes/g; \
	s/# private-add/private-add/g; \
	s/# interface: 2001:DB8::5/interface: 0.0.0.0/g; \
	s/# access-control: 0.0.0.0\/0 refuse/access-control: 0.0.0.0\/0 allow/g' /etc/unbound/unbound.conf
CMD ["unbound","-d"]
EXPOSE 53
