# Третье индивидуальное домашнее задание по АВС
## Вариант 6, Пономарев Степан Алексеевич, БПИ216
### Задание:
Разработать программу,вычисляющую с помощью степенного ряда с точностью не хуже 0,05% значение функции 1/e^x для заданного параметра x. 
#### Результаты:    
##### На 7 баллов:
![img](/7-1.png)
![img](/7-2.png)
- Приведено решение программы на языке C (находится в файле 7.c)

С помощью командной строки и приведённых ниже команд, получаем исходный .s-файл, а также исполняемый файл: \
$gcc -O0 -Wall -fno-asynchronous-unwind-tables 7.c -o 7 \
$gcc -O0 -Wall -fno-asynchronous-unwind-tables -S 7.c -o 7.s \
$gcc 7.s -o


###### Описание функций
\
double f(double x) -- функция принимает на вход вещественный параметр и возвращает значение функции для этого параметра

###### Рефакторинг
Был осуществлён рефакторинг программы (с последующим добавлением комментариев) с целью максимального использования регистров. Были изменены некоторые команды. К примеру, movl был заменён на movq. Были изменены регистры, контактирующие с новыми регистрами. Например, movl eax, -24(%rbp) изменён на movq rax, r12, были использованы регистры xmm для хранения вещественных чисел. Написанная программа находится в файле Refactoring.s

Демонстрируем результаты тестов новой и предыдущих программ\
![img](/res.png)

По результатам тестирования делаем однозначный вывод, что программы работают эквивалентно и правильно.
- Команды для проверки:
gcc Refactoring.s
gcc ./a.out

- Сравним размеры 7.s и Refactoring.s: \
7.s -- 162 строки, 3,25 Кб \
Refactoring.s -- 166 строк, 2,96 Кб


Также были добавлены дополнительные файлы для тестирования программы -- "test_1.txt", "test_2.txt". \
Полученная ранее в результате компиляции программа на ассемблере реализована в виде двух единиц компиляции. Это файлы "7-1.s" и "7-2.s". Одна часть содержит код с функцией "f", другая часть содержит main. Полученные файлы были скомпилированы, запущены и работали корректно.

Команды для проверки:\
gcc 7-1.s 7-2.s \
gcc ./a.out input.txt out.txt
