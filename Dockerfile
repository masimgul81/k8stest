FROM nginx:latest
COPY ./web-app/. /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
# This Dockerfile uses the latest Nginx image, copies the web application files into the appropriate directory, exposes port 80, and starts Nginx in the foreground.