FROM nginx:alpine

# Copy the Eaglercraft HTML files to nginx web directory
COPY *.html /usr/share/nginx/html/

# Create a simple index page that lists available clients
RUN echo '<!DOCTYPE html>' > /usr/share/nginx/html/index.html && \
    echo '<html><head><title>Eaglercraft WASM-GC</title></head><body>' >> /usr/share/nginx/html/index.html && \
    echo '<h1>Eaglercraft 1.12.2 WASM-GC</h1>' >> /usr/share/nginx/html/index.html && \
    echo '<p>Available clients:</p>' >> /usr/share/nginx/html/index.html && \
    echo '<ul>' >> /usr/share/nginx/html/index.html && \
    echo '<li><a href="2373359741_339e3a29603b8f3f25169349d4444a73_Eaglercraft_1_12_2_WASM_Offline_Download.html">Eaglercraft 1.12.2 WASM-GC Client</a></li>' >> /usr/share/nginx/html/index.html && \
    echo '<li><a href="2373359741_339e3a29603b8f3f25169349d4444a73_Eaglercraft_1_12_2_WASM_Offline_Download (2).html">Eaglercraft 1.12.2 WASM-GC Client (Copy 2)</a></li>' >> /usr/share/nginx/html/index.html && \
    echo '</ul>' >> /usr/share/nginx/html/index.html && \
    echo '<p>Click on a client link above to start playing Eaglercraft!</p>' >> /usr/share/nginx/html/index.html && \
    echo '</body></html>' >> /usr/share/nginx/html/index.html

# Copy nginx configuration for proper MIME types and headers
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]