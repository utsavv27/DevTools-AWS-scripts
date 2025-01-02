#!/bin/bash
certbot renew --quiet --post-hook "systemctl reload apache2" || echo "Certbot renewal failed" >> /var/log/renew-cert.log

# Schedule this script to run again after 80 days
echo "/etc/apache2/sites-available/renew-cert.sh" | at now + 80 days || echo "at command failed" >> /var/log/renew-cert.log
