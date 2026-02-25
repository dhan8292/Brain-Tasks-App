FROM nginx:alpine

# Copy your local Vite build output (usually /dist)
COPY dist/ /usr/share/nginx/html

# Copy custom config to fix SPA routing (explained below)
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

