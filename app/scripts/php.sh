#!/bin/bash

mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" && \
sed -i '/^;memory_limit /s/^;//' $PHP_INI_DIR/php.ini && \
sed -i 's/^\(memory_limit\s*=\s*\).*$/\14096M/' $PHP_INI_DIR/php.ini && \
sed -i '/^;post_max_size /s/^;//' $PHP_INI_DIR/php.ini && \
sed -i 's/^\(post_max_size\s*=\s*\).*$/\1300M/' $PHP_INI_DIR/php.ini && \
sed -i '/^;upload_max_filesize /s/^;//' $PHP_INI_DIR/php.ini && \
sed -i 's/^\(upload_max_filesize\s*=\s*\).*$/\1300M/' $PHP_INI_DIR/php.ini && \
sed -i '/^;max_execution_time /s/^;//' $PHP_INI_DIR/php.ini && \
sed -i 's/^\(max_execution_time\s*=\s*\).*$/\1300/' $PHP_INI_DIR/php.ini && \
sed -i '/^;max_input_vars /s/^;//' $PHP_INI_DIR/php.ini && \
sed -i 's/^\(max_input_vars\s*=\s*\).*$/\13000/' $PHP_INI_DIR/php.ini && \
sed -i '/^;max_input_time /s/^;//' $PHP_INI_DIR/php.ini && \
sed -i 's/^\(max_input_time\s*=\s*\).*$/\1600/' $PHP_INI_DIR/php.ini && \
ln -s /usr/bin/wkhtmltopdf /usr/local/bin/wkhtmltopdf && \