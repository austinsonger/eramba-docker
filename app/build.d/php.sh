#!/bin/bash
set -Eeuo pipefail

# mv "etc/php.ini-production" "etc/php.ini" && \
sed -i '/^;memory_limit /s/^;//' etc/php.ini && \
sed -i 's/^\(memory_limit\s*=\s*\).*$/\14096M/' etc/php.ini && \
sed -i '/^;post_max_size /s/^;//' etc/php.ini && \
sed -i 's/^\(post_max_size\s*=\s*\).*$/\1300M/' etc/php.ini && \
sed -i '/^;upload_max_filesize /s/^;//' etc/php.ini && \
sed -i 's/^\(upload_max_filesize\s*=\s*\).*$/\1300M/' etc/php.ini && \
sed -i '/^;max_execution_time /s/^;//' etc/php.ini && \
sed -i 's/^\(max_execution_time\s*=\s*\).*$/\1300/' etc/php.ini && \
sed -i '/^;max_input_vars /s/^;//' etc/php.ini && \
sed -i 's/^\(max_input_vars\s*=\s*\).*$/\13000/' etc/php.ini && \
sed -i '/^;max_input_time /s/^;//' etc/php.ini && \
sed -i 's/^\(max_input_time\s*=\s*\).*$/\1600/' etc/php.ini && \
ln -s /usr/bin/wkhtmltopdf /usr/local/bin/wkhtmltopdf