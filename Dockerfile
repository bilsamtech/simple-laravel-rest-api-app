# Use the official PHP image with Apache
FROM php:8.1-apache

# Install system dependencies and PHP extensions needed by Laravel
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    git \
    curl && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd pdo pdo_mysql

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Update the default apache site with the config we created.
COPY ./docker/apache.conf /etc/apache2/sites-available/000-default.conf

# Set the working directory in the container
WORKDIR /var/www/html

# Copy the application code to the container
COPY . .

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install application dependencies
RUN composer install --no-dev --optimize-autoloader

# Change ownership of the application to the Apache user
RUN chown -R www-data:www-data /var/www/html

# Expose port 80 to access the application
EXPOSE 80
