FROM nginx:alpine

# Serve the static prototype + vendored libs; no app server needed.
COPY nginx.conf            /etc/nginx/conf.d/default.conf
COPY index.html            /usr/share/nginx/html/
COPY vendor/               /usr/share/nginx/html/vendor/

# Cloud Run sends traffic to whatever port the container listens on.
# We hardcode 8080 (the Cloud Run convention) and configure nginx to match.
EXPOSE 8080
