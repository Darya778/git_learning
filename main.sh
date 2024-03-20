#!/bin/bash

# Директория, которую будем мониторить
directory="/path/to/directory"

# Название процесса
process_name="your_process_name"

# Функция для мониторинга использования памяти и записи информации в файл
monitor_memory_usage() {
    while true; do
        # Получаем PID процесса
        pid=$(ps aux | grep $process_name | grep -v grep | awk '{print $2}')
        
        # Получаем суммарный объем использованной памяти процесса
        memory_usage=$(ps -p $pid -o rss= | awk '{sum+=$1} END {print sum}')
        
        # Записываем информацию в файл
        echo "$(date): $memory_usage" >> memory_usage.log
        
        # Проверяем файлы в директории и удаляем те, которые старше 60 дней
        find $directory -type f -mtime +60 -exec rm {} \;
        
        # Пауза в 1 минуту
        sleep 60
    done
}

# Запускаем функцию мониторинга
monitor_memory_usage
