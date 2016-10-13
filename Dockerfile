FROM registry.ng.bluemix.net/ibmnode:latest
COPY ./ bluechatter
WORKDIR bluechatter
RUN npm install -d --production
EXPOSE 80
ENV PORT 80
ENV DOCKER true
CMD ["node", "app.js"]

# Set password length and expiry for compliance with vulnerability advisor
RUN sed -i 's/ˆPASS_MAX_DAYS.*/PASS_MAX_DAYS   90/' /etc/login.defs
RUN sed -i 's/PASS_MIN_DAYS\t0/PASS_MIN_DAYS\t1/'  /etc/login.defs
RUN sed -i 's/sha512/sha512 minlen=8/' /etc/pam.d/common-password
