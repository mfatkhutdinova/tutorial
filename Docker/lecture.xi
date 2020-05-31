Прелесть docker в том, не нужно заботиться о софте, который установлен на сервере или виртуалке. Мы переносим софт со всеми тонкостями на другой сервер и он работает.
Все требуемое ПО на своей локальной машине. 

Images (образы) - Схемы нашего приложения, которые являются основой контейнеров. 

Docker file - это текстовый файл, содержащий набор операций, которые могут быть использованы для создания  docker образа. 

Containers (контейнеры) - Создаются на основе образа и запускают само приложение. 
Мы создали контейнер командой docker run, и использовали образ busybox, скачанный ранее. Список запущенных контейнеров можно увидеть с помощью команды docker ps.

Docker Daemon (демон Докера) - Фоновый сервис, запущенный на хост-машине, который отвечает за создание, запуск и уничтожение Докер-контейнеров. 
Демон — это процесс, который запущен на операционной системе, с которой взаимодействует клиент.

Docker Client (клиент Докера) - Утилита командной строки, которая позволяет пользователю взаимодействовать с демоном. 
Существуют другие формы клиента, например, Kitematic, с графическим интерфейсом.

Docker Hub - Регистр Докер-образов. Грубо говоря, архив всех доступных образов. 
Если нужно, то можно содержать собственный регистр и использовать его для получения образов.

Docker-compose - предназначен для быстрой настройки и запуска различных вариантов сред разработки docker. Расширение yml.
Освободит от необходимости сопровождать все вспомогательные  скрипты, предназначенные для организации работы, включая запуск, установление соединений, обновлений, установки контейнера.
 
Демон Docker - это сервер Docker, который ожидает запросов к API Docker. 
Демон управляет образами, контейнерами, сетями и томами.

Тома Docker - наиболее предпочтительный механизм постоянног хранения даных, потребляемых и производимых приложениями.
Том — это файловая система, которая расположена на хост-машине за пределами контейнеров.

Контейнер Docker - это образ Docker, вызванный к жизни.
Это - самодостаточная ОС, в которой имеется самое необходимое и код приложения.

Дюжина инструкций Dockerfile
FROM — задаёт базовый (родительский) образ.
LABEL — описывает метаданные. Например — сведения о том, кто создал и поддерживает образ.
ENV — устанавливает постоянные переменные среды.
RUN — выполняет команду и создаёт слой образа. Используется для установки в контейнер пакетов.
COPY — копирует в контейнер файлы и папки.
ADD — копирует файлы и папки в контейнер, может распаковывать локальные .tar-файлы.
CMD — описывает команду с аргументами, которую нужно выполнить когда контейнер будет запущен. Аргументы могут быть переопределены при запуске контейнера. В файле может присутствовать лишь одна инструкция CMD.
WORKDIR — задаёт рабочую директорию для следующей инструкции.
ARG — задаёт переменные для передачи Docker во время сборки образа.
ENTRYPOINT — предоставляет команду с аргументами для вызова во время выполнения контейнера. Аргументы не переопределяются.
EXPOSE — указывает на необходимость открыть порт.
VOLUME — создаёт точку монтирования для работы с постоянным хранилищем.

С помощью кэширования ускорятеся сборка образа.