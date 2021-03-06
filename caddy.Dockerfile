FROM quay.io/spivegin/php7

WORKDIR /opt/tlm/html 


RUN git clone https://github.com/DanielnetoDotCom/YouPHPTube.git &&\
    chown -R www-data:www-data .
    

EXPOSE 80

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/bin/entry.sh"]