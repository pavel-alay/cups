FROM ubuntu

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y \
    cups \
    printer-driver-foo2zjs-common \
    avahi-daemon

RUN useradd --groups=lp,lpadmin admin 
RUN echo 'admin:admin' | chpasswd

ADD docker-entrypoint.sh /
ADD HP_LaserJet_M1120n_MFP.ppd /etc/cups/ppd/
ADD HP_LaserJet_M1120n_MFP.ppd.O /etc/cups/ppd/
ADD printers.conf /etc/cups/

RUN /usr/sbin/cupsd \
  && while [ ! -f /var/run/cups/cupsd.pid ]; do sleep 1; done \
  && cupsctl --remote-admin --remote-any --share-printers \
  && kill $(cat /var/run/cups/cupsd.pid)

ENTRYPOINT ./docker-entrypoint.sh
