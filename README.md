# homework09
Я решил реализвать скрипт, показывающий как работает NICE

Основная функция для создания нагрузки

![image](https://user-images.githubusercontent.com/98701086/163350152-cb3cc3ce-0a5d-45f9-80a5-d90b3edce667.png)

Значение nice для процесса bzip2 передается в нее через параметр

Далее считываем количество CPU на машине, для того, что бы сообщить какое количество процессов нужно будет запускать.
Вывод информации, и запрос массива значений nice, для создаваемых процессов

![image](https://user-images.githubusercontent.com/98701086/163350661-523a4d27-6c2a-4ab1-8043-13b70ade0531.png)

Запуск процессов с заданными nice. Запоминаю в какое время стартанул процесс

![image](https://user-images.githubusercontent.com/98701086/163350856-2fdf22e7-d965-4c0f-b1c3-350a9b909756.png)

Запуск проверки, что процесс жив, по наличию /proc/$pid. Так же запоминю, когда процесс завершился

![image](https://user-images.githubusercontent.com/98701086/163351155-b418f41b-ae9c-4746-9fcd-7ae46cc79ec3.png)

Вывод информации

![image](https://user-images.githubusercontent.com/98701086/163351227-4e8bfc44-495c-4048-83ad-6f66ca91c552.png)

Хочу отметить, что очень понравилась возможность удаления из массива элемента pidchs=( ${pidchs[@]/$pidch} )
