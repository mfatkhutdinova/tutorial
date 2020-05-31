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




