#!/usr/bin/env bash

set -ex

# ImageMagick/Imagick versions to use
IMAGEMAGICK_VERSION='6.7.0-10'
IMAGICK_VERSION='3.4.3'

if [[ $TRAVIS_PHP_VERSION == 7.1 ]]; then
	IMAGEMAGICK_VERSION='6.9.7-10'
elif [[ $TRAVIS_PHP_VERSION == 7.0 ]]; then
	IMAGEMAGICK_VERSION='6.9.6-8'
elif [[ $TRAVIS_PHP_VERSION == 5.6 ]]; then
	IMAGEMAGICK_VERSION='6.9.5-10'
elif [[ $TRAVIS_PHP_VERSION == 5.5 ]]; then
	IMAGEMAGICK_VERSION='6.8.8-10'
elif [[ $TRAVIS_PHP_VERSION == 5.4 ]]; then
	IMAGEMAGICK_VERSION='6.7.9-10'
elif [[ $TRAVIS_PHP_VERSION == 5.3 ]]; then
	IMAGEMAGICK_VERSION='6.6.9-10'
elif [[ $TRAVIS_PHP_VERSION == 5.2 ]]; then
	IMAGEMAGICK_VERSION='6.5.4-10'
	IMAGICK_VERSION='3.1.0'
fi

install_imagemagick() {
	curl -O "https://www.imagemagick.org/download/releases/ImageMagick-$IMAGEMAGICK_VERSION.tar.xz" -f
	tar xf "ImageMagick-$IMAGEMAGICK_VERSION.tar.xz"
	rm "ImageMagick-$IMAGEMAGICK_VERSION.tar.xz"
	cd "ImageMagick-$IMAGEMAGICK_VERSION"

	./configure --prefix="$HOME/opt/$TRAVIS_PHP_VERSION" --with-perl=no
	make
	make install

	cd "$TRAVIS_BUILD_DIR"
}

# Install ImageMagick if the current version isn't up to date
PATH="$HOME/opt/$TRAVIS_PHP_VERSION/bin:$PATH" identify -version | grep "$IMAGEMAGICK_VERSION" || install_imagemagick

# Debugging
ls "$HOME/opt/$TRAVIS_PHP_VERSION"

# Install Imagick for PHP
echo "$HOME/opt/$TRAVIS_PHP_VERSION" | pecl install -f "imagick-$IMAGICK_VERSION"
