FROM registry.ng.bluemix.net/ibmnode:latest
COPY ./ bluechatter
WORKDIR bluechatter
RUN npm install -d --production
EXPOSE 80
ENV PORT 80
ENV DOCKER true
CMD ["node", "app.js"]

# Secure Container
# Set password length and expiry for compliance with vulnerability advisor
RUN sed -i 's/ˆPASS_MAX_DAYS.*/PASS_MAX_DAYS   90/' /etc/login.defs
RUN sed -i 's/sha512/sha512 minlen=8/' /etc/pam.d/common-password

# If you would like to run node-inspector to debug the application
# Comment out the above CMD call and uncomment the below 4 lines
#RUN npm install -g node-inspector
#EXPOSE 8080
#EXPOSE 5858
#CMD ["./debug.sh"]
