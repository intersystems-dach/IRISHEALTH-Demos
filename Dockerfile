FROM intersystems/irishealth-community:2024.1

COPY --chown="${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP}" ./projects /opt/irisbuild/projects
COPY --chmod=765 ./install_projects.sh /opt/irisbuild/install_projects.sh

RUN iris start IRIS \
    && /opt/irisbuild/install_projects.sh \
    && iris stop IRIS quietly

COPY --chown="${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP}" ./password.txt  /home/irisowner/password.txt
RUN /usr/irissys/dev/Container/changePassword.sh /home/irisowner/password.txt \
    && rm /home/irisowner/password.txt.done
