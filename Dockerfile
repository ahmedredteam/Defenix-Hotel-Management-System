FROM php:8.2-apache

# Set working directory
WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    zip \
    unzip \
    curl \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions required by QloApps
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install \
    pdo_mysql \
    curl \
    gd \
    soap \
    simplexml \
    dom \
    zip \
    && docker-php-ext-enable pdo_mysql curl gd soap simplexml dom zip

# Enable Apache mod_rewrite for URL rewriting
RUN a2enmod rewrite

# Set PHP configuration for optimal performance
RUN echo "memory_limit = 256M" >> /usr/local/etc/php/conf.d/custom.ini && \
    echo "upload_max_filesize = 16M" >> /usr/local/etc/php/conf.d/custom.ini && \
    echo "post_max_size = 16M" >> /usr/local/etc/php/conf.d/custom.ini && \
    echo "max_execution_time = 500" >> /usr/local/etc/php/conf.d/custom.ini && \
    echo "allow_url_fopen = On" >> /usr/local/etc/php/conf.d/custom.ini && \
    echo "opcache.enable = 1" >> /usr/local/etc/php/conf.d/custom.ini && \
    echo "opcache.memory_consumption = 256" >> /usr/local/etc/php/conf.d/custom.ini && \
    echo "opcache.max_accelerated_files = 20000" >> /usr/local/etc/php/conf.d/custom.ini

# Install OPcache for performance
RUN docker-php-ext-install opcache

# Copy QloApps application files into container
COPY --chown=www-data:www-data . /var/www/html/

# Create necessary directories
RUN mkdir -p /var/www/html/log && \
    mkdir -p /var/www/html/upload && \
    mkdir -p /var/www/html/cache && \
    mkdir -p /var/www/html/download

# Set permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html && \
    find /var/www/html -type d -exec chmod 755 {} \; && \
    find /var/www/html -type f -exec chmod 644 {} \;

# Configure Apache virtual host
RUN echo '<Directory /var/www/html>\n\
    Options Indexes FollowSymLinks\n\
    AllowOverride All\n\
    Require all granted\n\
</Directory>' > /etc/apache2/conf-available/qloapps.conf && \
    a2enconf qloapps

# Expose port
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
