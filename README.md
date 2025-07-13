## Запуск PetClinic у Vagrant через `start.sh`

Цей проєкт автоматизує розгортання бази даних (MySQL) та Spring Boot застосунку **PetClinic** у двох окремих віртуальних машинах (`DB_VM` та `APP_VM`) за допомогою Vagrant.

### Передумови:
- Встановлено **Vagrant**
- Встановлено **VirtualBox**
- Надано права на виконання скрипта: `chmod +x start.sh`

### Як запустити:
1. Перейдіть у директорію проєкту:
   cd ваш_каталог_проєкту

2. Запустіть скрипт:
   ./start.sh

3. Введіть дані, коли буде запитано:
   - Назва бази даних (наприклад: petclinic)
   - Ім’я користувача бази (наприклад: testsvit)
   - Пароль до бази

### Що робить скрипт:
- Створює віртуальну машину `DB_VM`, встановлює та налаштовує MySQL
- Створює базу даних, користувача та призначає права
- Конфігурує MySQL для зовнішнього доступу
- Створює віртуальну машину `APP_VM`, клонує репозиторій Spring PetClinic
- Збирає застосунок за допомогою Maven та запускає його

### Як відкрити застосунок:
Відкрийте браузер і перейдіть за адресою:
http://localhost:8080
або
http://192.168.56.20:8080

### Щоб зупинити віртуальні машини:
vagrant halt

### Щоб знову запустити:
vagrant up

## Результат роботи

### 1. Vagrantfile:
![Vagrantfile](https://github.com/SvitLanaSvit/DevOps_spring-petclinic-vagrant/blob/main/Screenshots/1.png)

### 2. Скрін git репозиторія з проектом PetClinic
![GIT](https://github.com/SvitLanaSvit/DevOps_spring-petclinic-vagrant/blob/main/Screenshots/2.1.png)
![GIT](https://github.com/SvitLanaSvit/DevOps_spring-petclinic-vagrant/blob/main/Screenshots/2.2.png)

### 2. Скрін підключення з однієї віртуалки до бази даних, яка на іншій
![connection](https://github.com/SvitLanaSvit/DevOps_spring-petclinic-vagrant/blob/main/Screenshots/3.png)

### 4. Усі налаштування виконуються автоматично за допомогою скриптів.
Жодних додаткових ручних дій поза межами Vagrantfile та скриптів (start.sh, db_vm.sh, app_vm.sh) не виконувалося.
Тому немає потреби у скріншотах ручного налаштування, оскільки вся конфігурація автоматизована і повністю описана в репозиторії.

### 5. Скрін роботи аплікації на 8080 порту з прикладом додавання своїх даних
![app](https://github.com/SvitLanaSvit/DevOps_spring-petclinic-vagrant/blob/main/Screenshots/5.1.png)
![app](https://github.com/SvitLanaSvit/DevOps_spring-petclinic-vagrant/blob/main/Screenshots/5.2.png)
![app](https://github.com/SvitLanaSvit/DevOps_spring-petclinic-vagrant/blob/main/Screenshots/5.3.png)

### 6. Скрін сайту з існуючими й своїми доданими даними
![app](https://github.com/SvitLanaSvit/DevOps_spring-petclinic-vagrant/blob/main/Screenshots/6.1.png)
![app](https://github.com/SvitLanaSvit/DevOps_spring-petclinic-vagrant/blob/main/Screenshots/6.2.png)



