# Use PHP-FPM 8.1 as the base image
FROM php:8.1.0-fpm

RUN docker-php-ext-install calendar

# Arguments defined in docker-compose.yml
ARG user
ARG uid

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libicu-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libzip-dev \
    libpq-dev \
    && docker-php-ext-install calendar zip intl pdo_mysql mbstring exif pcntl bcmath gd pdo_pgsql soap \
    && docker-php-ext-configure intl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Node.js and npm from NodeSource
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install the latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Redis
RUN pecl install redis && docker-php-ext-enable redis

# Install Xdebug 3
# RUN pecl install xdebug \
#     && echo "zend_extension=xdebug.so" > /usr/local/etc/php/conf.d/xdebug.ini

# # Configure Xdebug
# RUN echo "zend_extension=xdebug.so" > /usr/local/etc/php/conf.d/xdebug.ini \
#     && echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/xdebug.ini \
#     && echo "xdebug.client_host=172.17.0.1" >> /usr/local/etc/php/conf.d/xdebug.ini \
#     && echo "xdebug.idekey=VSCODE" >> /usr/local/etc/php/conf.d/xdebug.ini \
#     && echo "xdebug.discover_client_host=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
#     && echo "xdebug.log=/tmp/xdebug.log" >> /usr/local/etc/php/conf.d/xdebug.ini \
#     && echo "xdebug.log_level=7" >> /usr/local/etc/php/conf.d/xdebug.ini \
#     && echo "xdebug.client_port=9003" >> /usr/local/etc/php/conf.d/xdebug.ini \
#     && echo "xdebug.start_with_request=yes" >> /usr/local/etc/php/conf.d/xdebug.ini
# Create system user to run Composer, Artisan, and npm commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && chown -R $user:$user /home/$user

# Give $user ownership of the working directory
WORKDIR /var/www
RUN chown -R $user:$user /var/www

# Switch to the new user
USER $user