Итераторы  .
Это интерфейс доступа к элементам коллекций и потоков данных. Он требует реализации единственного метода – «дай мне следующий элемент». 

Генераторы .
Это функция, которая будучи вызванной в функции next() возвращает следующий объект согласно алгоритму ее работы. 

1. Генераторное выражение
g = (2 * i for i in range(5))
print(next(g))
print(next(g))
print(next(g))
print(next(g))

2. Генераторные функции

Это функции, где есть хотя бы одно выражение yield. Когда мы запускаем генератор, функция выполняет до первого выражения yield. 
То, что мы передали в yield будет возвращено наружу. Генератор при этом встанет «на паузу» до следующей итерации. 
При следующей итерации выполнение генератора продолжится до очередного yield.

def fib():
    a, b = 0, 1
    while 1:
        yield a
        a, b = b, a + b

fib_g = fib()

print(next(fib_g))
print(next(fib_g))
print(next(fib_g))
print(next(fib_g))

Декораторы .
Это "обёртки", которые дают нам возможность изменить поведение функции, не изменяя её код.
