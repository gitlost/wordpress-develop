#!/usr/bin/env bash

# ImageMagick version to use
IMAGEMAGICK_VERSION='6.7.0-10'

install_imagemagick() {
	curl -O "https://www.imagemagick.org/download/releases/ImageMagick-$IMAGEMAGICK_VERSION.tar.xz" -f
	tar xvf "ImageMagick-$IMAGEMAGICK_VERSION.tar.xz"
	rm "ImageMagick-$IMAGEMAGICK_VERSION.tar.xz"
	cd "ImageMagick-$IMAGEMAGICK_VERSION"

	./configure --prefix="$HOME/opt/$TRAVIS_PHP_VERSION"
	make
	make install

	cd "$TRAVIS_BUILD_DIR"
}

# Install ImageMagick if the current version isn't up to date
PATH="$HOME/opt/$TRAVIS_PHP_VERSION/bin:$PATH" identify -version | grep "$IMAGEMAGICK_VERSION" || install_imagemagick

# Debugging
ls "$HOME/opt/$TRAVIS_PHP_VERSION"

# Install Imagick for PHP
echo "$HOME/opt/$TRAVIS_PHP_VERSION" | pecl install imagick
