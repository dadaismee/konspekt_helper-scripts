#!/bin/bash

# Search for .json files in the parent directory
json_files=($(find ../ -maxdepth 1 -type f -name "*.json" 2>/dev/null))

# function confirm_installation() {
#   read -p $'\nПривет! Этот скрипт поможет скопировать путь до библиотеки Zotero. Чтобы это сделать, убедитесь, что:\n\n1. Вы экспортировали библиотеку Zotero в папку Service\n2. Файл называется латинскими символами и в его названии нет пробелов (!)\n\nЕсли библиотек больше одной, выберите нужную, указав её номер и нажав Enter.\n\nНажмите Enter, чтобы продолжить, и Esc, чтобы остановить: ' -s -n 1 key
#   echo
#   if [ "$key" = "" ]; then
#     return 0
#   else
#     return 1
#   fi
# }
#
# # Check if the user wants to proceed with the installation
# confirm_installation
# if [ $? -ne 0 ]; then
#   echo "Вы отменили действие (︶︹︶)"
#   exit 1
# fi
#
# Check if there are any .json files
if [ ${#json_files[@]} -eq 0 ]; then
  echo -e '\nФайлы библиотеки Zotero в формате JSON не найдены. экaпортируйте её из Zotero, как это показано в уроке 1.5. Перейти в урок? Нажмите Enter для продолжения или Esc для отмены.'

  # Read user input
  read -s -n1 key
  echo

  if [ "$key" = $'\e' ]; then
    echo 'Отмена...'
    exit
  fi

  if [ "$key" = '' ]; then
    # Open the Zotero Style Repository in the default browser
    open https://konspekt.zenclass.ru/courses/731e4edc-9279-40a8-ad40-668820810803/edit/structure/lessons/29287a9c-a081-49c8-8d48-29cb2ff6c0d6
  else
    echo 'Неверный ввод. Отмена...'
    exit
  fi
      exit 1
  fi

# If there is only one .json file, use that
if [ ${#json_files[@]} -eq 1 ]; then
    json_file="${json_files[0]}"
else
    # Prompt the user to choose a .json file
    echo "Найдено несколько файлов. Выберите нужный:"
    select json_file in "${json_files[@]}"; do
        if [ -n "$json_file" ]; then
            break
        else
            echo "Invalid choice. Please try again."
        fi
    done
fi

# Get the absolute path of the selected .json file
absolute_path=$(realpath "$json_file")

# Copy the selected .json file path to the clipboard
echo -n "$absolute_path" | pbcopy

# Check if pbcopy succeeded
if [ $? -eq 0 ]; then
    echo -e "\nГотово! Можно вставлять в окно настроек плагина Pandoc в Obsidian!"
else
    echo "Failed to copy the path to the clipboard."
fi
