Kubernetes - это технология, которая позволяет автоматизировать развертывание и масштабирование контейнеризированных приложений, а также управление ими.
Kubernetes - это менеджер контейнеров.

API сервер - входная точка для запуска в Kubernetes
Мастер - смотрит в API сервер. 
Кублет - нода агент, который стоит на всех серверах кластера и отправляет инфу докер демону о том, что нужно запустить какой-то контейнер.

Абстракции Kubernetes (YAML): .
  POD - минимальная абстракция, с которой работаей Kubernetes. Тут запускаются приложения. .
  В POD может быть несколько контейнеров. 
  1 POD = 1 контейнер 

  ReplicaSet - родитель POD, управляет тем, в каком кол-ве наше приложение должно запускаться. .
  Lables - метка 
  Selector - инструкция для репликасет, глядя в него понимает, какие POD его.

  Deployment - это родитель ReplicaSet. Нужен, чтобы нормально обновлять версии приложения. .
    Probes - контроль за состоянием приложения во время его жизни, старта, готово ли приложение. .
    Resources - содержит лимиты и резервировать запросы. .
      Limits - кол-во ресурсов, которые POD может использовать
      Reguets - кол-во ресурсов, которые резервируются для POD на ноде (CPU, memory)
    Secret - сущность для хранения паролей, токены, сертификаты и т.д. .
  
  ConfigMap - сущность, которая хранит настройки приложения. .
  Можно указывать про настройки монтирования, про тома.

  Service - умеет объединять разрозненные поды со случайными ip адресами объединить и каким-то образом и распределять на них трафик .
  Ingress - для получения запросов с наружим. Описывает правила доступа к нашему приложению .
  PV/PVC - описывает том, на котором хранятся наши данные (БД) .
  StorageClass - манифест, в котором описывается параметры доступа к провайдеру хранения данных .

Компоненты кластера .
  Etcd - тут хранится вся информация о нашем кластере, все настройки .
    Etcdctl - утилита упраления кластером ETCD
    Требует быстрых дисков 

  API server - центральный компонет Kubernetes .
    Единственный, кто общается с Etcd
    Работает по REST API 
    Авторизация и аутентификация 

  Controller-manager - набор контроллеров .
    Node controller - контролирует состояние нод 
    Replication controller - контролирует репликасеты
    Endpoints controller
    И другие..
    GarbageCollecor - сборщик музыка

  Scheduler - назначает PODы на нады, учитывая: .
    QoS
    Affinity/anti-Affinity - смотрит на правила, где нужно запсукать приложения
    Requested resources - учитывает лимиты, запросы, зарезервированные ресурсы

  Kubelet - работает на каждой ноде .
    Единственный компонент, работающий не в Docker 
    Отдает команды Docker daemon 
    Создает PODы

  Kube-proxy - управляет сетевыми правилами на нодах .
    Смотрит в Kube-API
    Стоит на всех серверах 
    Фактически реализует Service (ipvs и iptables) 

  Контейнеризация - docker .
  Сеть .
  DNS .

Сеть Kubernetes .
  Network plugin (Flannel, Calico) .
    Обеспечивает связь между нодами и подами 
    Раздает IP-адреса подам
    Реализует шифрование между нодами 
    Управляет Network Policies

Kubespray .
  Это сценарий для установки Kubernetes 

Продвинутые абстракции .
  DeamonSet: .
    - запускает поды на всех нодах кластера 
    - при добавлении ноды - добавляет под 
    - при удалении ноды GC удаляет под 
    - описание практически полностью соответствует Deployment  (кол-во реплик не указываем, кол-во реплик = кол-во узлов в кластере)
    - tolerations - зараза и сопротивляемость 
  
  StatefulSet .
    - позволяет запускать группу подов (как Deployment)
    - гарантирует их уникальность
    - гарантирует их последовательность
    - PVC template
    - при удалении не удаляет PVC 
    - используется для запуска приложений с сохранением состояния 
      - Rabbit 
      - DBs
      - Redis
      - Kafka 
  
  InitContainers .
    - позволяет выполнить настройки перед запуском основного приложения
    - выполняются по порядку описания в манифесте
    - можно монтировать те же тома, что и в основных контейнерах 
    - можно щапускать от другого пользователя 
    - должен выполнить дейтсвие и остановиться

  Headless Service .
    - spec.clusterIP: None
    - резолвится в IP всех экдпоинтов
    - создает записи с именами всех эндпоинтов


  Job .
    - создает POD для выполнения задачи (обычно испоьзуют для единоразового использвания (env настроить))
    - перезапускает PODы до успешного выполнения задачи
    - или истечения таймаутов (activeDeadLineSeconds, backoffLimit) 

  CronJob .
    - создает Job по расписанию  (cron формат)
    - важные параметры:
      - startingDeadlineSeconds - стремная опция. Работает не так, как описано в доке. Никогда лучше не испоьзовать.
      - concurrencyPolicy - Allow/Forbit запуск экземпляов в одно и тоже время. Использовать Forbit
      - successfulJobsHistoryLimit - кол-во успешных выполненных задач сохраняем 
      - failedJobsHistoryLimit - кол-во неудачных выполненных задач сохраняем

  Role Based Access Control (RBAC) .
    - ServiceAccount - (в Kubernetes нет юзеров) сущность придумана для того, чтобы приложения Kubernetes работали под ServiceAccount
    - Role - описывает, что можно делатьв разделе Kubernetes (правила)
    - RoleBinding - в сущности указывается связь ServiceAccount с Role
    - ClusterRole - то же самое, что и Role, толко действует на весь кластер 
    - ClusterRoleBinding - то же самое, что и RoleBinding, толко действует на весь кластер

  Задача мониторинга: .
  - на каждой ноде автоматически запускается агент 
  - управляются агенты из одной точки
  - конфигурируются так же из одной точки 

Публикация приложений .
  Kubernetes Service: .
    - ClusterIP - настройка взаимодействий PODов внутри. Не внешне 
    - NodePort - публикация внешне (порты от 3000 до 32000)
    - LoadBanalcer - публикация внешне, но в облаках 
    - ExternalName - можно перенаправлять запросы на другие сервисы (почти не используется)
    - ExternalIPs - при создании сервиса на всех серверах кластера создаются по аналогии с Service type: Node Port правило трансляции, 
      который говорит, что трафик, приходящий на адресс ExternalIPs надо отправлять в PODы. Эти правила будут создавны на всех серверах.
      Это решает админ кластера с задачей балансера. 
    - Headless - none 

  Ingress .
    - IngressController - работает на принципе балансера 
    - манифест, в котором описано правило для IngressController 
    - annotations - возможность передать какую-то специфическую информацию контроллеру или оператору (то, что не влезает в манифест)

  Cert-manager .
    - начинался как способ получить сертификат от LetsEncrypt
    - автоматизирует получение SSL/TLS-серификатов от различных удостовуряющих центров (LetsEncrypt)
    - интергрируется с IngressController
    - автоматизирует продление сертификатов 

NameSpace .
  - возможность разделить окружение 
  - используется для разделения команд, проектов и русорсов кластера 
  - два одинаковы объекта с одинаковыми именами не могут быть созданы в одном namespace 
  - ресурсы задаются в рамках namespace через ResourceQuota 

Helm .
  - хорош тем, что если при релизе что-то упало, то сразу откатывается назад. И не надо никуда лезть 
  - темпейтирует приложение 
  - пакетный менеджер 
  - декларативный 
  - CNCF 
  - состоит из Helm + Tiller в (v2)
  - система плагинов 
  - есть важные фичи для построения CD 
    - watch 
    - rollback 

  Пакет у Helm: .
  - набор теймпетированных манифестов 
  - файл со значениями переменных 
  - мета 
  все это архивированно в .tgz, который называется чартами 
  В values.yml задаются все переменные, что можно гибко использовать в Deployment.

  Основы работы с Helm .
    helm search - поиск чарта 
    helm install - установка чарта 
    helm upgrade - обновление чарта 
    helm get - скачать чарт
    helm show - показать инфу о чарте 
    helm list - список утсановленных чартов 
    helm uninstall - удалить чарт 

  Тестирование релиза .
    1. Создаем папку templates/tests 
    2. Кладем туда манифесты объектов k8s, которые будут тестить рлиз 
    3. Манифесты должны содержать аннотацию helm.sh/hook : test 
    4. Запускаем в CI helm test <release name>

Хранение данных на примере ceph .
  Подключение к подам SC/PVC/PV .
    Storage class - хранит параметры подключения 
    PersistentVolumeClaim - описывает требования к тому 
    PersistentVolume - хранит параметры и стату тома 
    Provisioner - параметр SC, плагин создания томов 

Disaster recovery Kubernetes = аварийное восстановление Kubernetes .
  Как можно сломать kubernetes? .
    - серверы с k8s сгорели, уборщица выдернула кабель
    - залезли руками в логику k8s, в etcd 
    - джуниор удалил namespace kube-system
    - протухли kubernetes-сертификаты
    - криво обновили версию кластера

  На что нужно обратить внимание? .
    - отказоустойчивость сетап kubernetes
        кол-во компонентов = кол-ву etcd мастеровых 
        Kubelet, kubeproxy через nginx 

    - резервирование ingress-controller'a 

    - сертификаты кластера
        это те, что лежат в /etc/kubernetes/pki 
        в старых версиях kubernetes сертификаты протухли 
        пользуйтесь нашим форком Kubespray: https://github.com/southbridgeio/kubespray
        с версии 1.15 стало легче дить, а с 1.17 совсем легко

    - регламентные работы (обновление кластера или ПО)
        убеждаемся, что у нашего приложения >1 реплик
        эвакуируем поды с нужной ноды (kubectl drain)
        проводим обновдение
        снимаем ноду с обслуживания (kubectl uncordon)

    - обновление версии кластера:
        пробуем на dev-среде/стенде и читаем Changelog!
        обновляем основную мастер-ноуды на 1 версию
        обновляем остальные мастер-ноды на 1 версию
        в kubespray для этого есть отдельный сценарий 

    - бэкапы
        что бэкапим?
        манифесты
        секреты
        сертификаты и настройки узлов
        образы контейнеров
        содержимое value 
        БД 
        можно использвать утилиту Hepito Velero

   - расширенные инструменты k8s (PSP, PDB, RQ..)
  
  Полезные штуки .
    1. PodDisruptionBudgets - ограничиваем кол-во недоступных инстансов приложения
    2. Pod Security Policy - контролируем возможности подов (privileged, hostNetwork)
    3. PriorityClass - приоритизуем более важные поды над менее важными. MUST HAVE!
    4. LimitRange - ставим дефолтные лимиты на ресурсы подов (CPU, RAM) MUST HAVE!
    5. ResourceQuota - ограничиваем ресурсы в namespace и кол-во объектов (подов, сикретов)
    6. Network Policy - "файервол" внутри кубернетес   

  Выводы: .
    - иметь описанный регламент по типовым работам 
    - размещаться в хорошем ДЦ
    - настроить отказоустойчивый сетап 
    - иметь dev-стенд, где экспериментировать 
    - покрыться мониторингами, делать бэкапы 
    - держать руку на пульсе, иметь актуальные знания 
    - пользоваться всеми фишками кубернетес
