#!/bin/bash

# Визначаємо масив з URL вебсайтів для перевірки
sites=("https://google.com"
    "https://facebook.com"
    "https://twitter.com")

# Файл для запису результатів
logFile="website_status.log"

# Очищаємо файл логів перед записом нових результатів
> "$logFile"

# Перебираємо сайти у масиві
for site in "${sites[@]}"; do
  # Використовуємо curl з флагом -L для отримання HTTP статус коду, слідуючи за перенаправленнями
  statusCode=$(curl -L -s -o /dev/null -w "%{http_code}" $site)
  
  # Перевіряємо, чи код відповіді є 200
  if [ $statusCode -eq 200 ]; then
    echo "$site is UP" | tee -a "$logFile"
  else
    echo "$site is DOWN" | tee -a "$logFile"
  fi
done

echo "Results are logged in $logFile"
