umba-2c

    Генерирует исходник на C для входного файла. Пердназначен для генерации кроссплатформенных "ресурсов"
    для приложения.
    Изначально была реализована для того, чтобы зашить в прошивку самодельного веб-сервера для микроконтроллера
    статичные странички и картинки, отсюда опции добавления mime-type'а и last-modified, но потом идея понравилась,
    и стала применяться и для обычных исполняемых файлов.
    Умеет форматировать ресурс в виде строки (использует C-escape), в виде массива char'ов, hex/dec.
    Ресурс двоичный/текстовый, для текстовых может делаться замена перевода строки и сжатие пробелов,
    возможно наверно надо добавить коррекцию/конвертацию Tab'ов/в Tab'ы, нормализацию отступов (как в umba-tabtool).
    Умеет кодировать данные в base64, умеет простецкое "шифрование" XOR'ом - длина XOR ключа 1/2/4 байта,
    стартовый seed и increment. Предназначено, чтобы скрывать в EXE текстовые данные от простого просмотра.


umba-2rcfs

    Сканирует заданные каталоги, генерирует единый файл для регистрации builtin ресурсов во встроенной в EXE файловой системе.
    Пользователь должен определить макросы CUSTOM_UMBA_RCFS_REGISTER_RESOURSE/CUSTOM_UMBA_RCFS_REGISTER_RESOURSE_XORED.
    Xor-шифрует как данные, так и имена файлов ресурсов, если указано.
    Тип входного файла bin/text - определяется масками, если не подходит ни под одну - используется заданная по умолчанию.
    Во многом повторяет umba-2c утилиту.
    Идея в том, что необходимые ресурсы проще носить с собой в EXE, чем хранить где-то в файловой системе пользователя.
    Если нужна пользовательская кастомизация, то тогда просто ищутся и подсасываются пользовательские файлы
    во встроенную RCFS, при этом можно проверять корректность синтаксиса пользователских файлов - например - JSON-конфиги,
    вне зависимости от их далее интерпретируемого содержимого.
    Умеет в XOR-шифрование как для данных, так и для имен файлов ресурсов.
    Имена файлов ресурсов указываются относительно скан-корня - если в разных скан-корнях будет файл с одинаковым подпутём/именем
    - будет ошибка компиляции сгенерированного сишника.


umba-brief-scanner

    Производит сканирование заданных каталогов на предмет поиска файлов по маске (include/exclude files)
    В каждом файле производит поиск комментария специального вида:
        /*(*|!) (\|@)file
                (\|@)brief Brief desription of the file
        */

    Производится поиск entry points типа main/DllMain/etc, --entry-name=... задает имя и тип возвращаемых значений

    В результирующий отчет (txt|html) выводится список файлов с их описанием, файлы с entry points идут первыми.

    Есть возможность группировки по пути.

    Основные опции

    --main - генерировать только entry points в отчёте.

    --update[=FILE] - в выходном txt файле можно дописывать описания файлов, и если оно не появляется в сорцах
      - берётся из предыдущей версии brief-файла

    --split-group - группирует/делит на группы


umba-enum-gen

    Генератор enum'ов. На входе - задаём имена абы как, хоть в параметре командной строки, хоть в .txt файле, 
    на выходе - отформатированно по всем правилам - PascalCase, camelCase etc.
    Сериализация и десериализация значений, как и наборов значений, enum-флаги, для флагов - bitwise операторы.
    Шаблоны для генерации - user/custom/base (builtins) варианты для lang/template версий.
    Автоматически производится поиск файла с опциями 'umba-enum-gen-flags.txt', который обрабатывается
    после встроенных файлов опций, но перед всеми непосредственно указанными опциями.


umba-make-headers

    Простая утилита.
    Генерирует include файлы согласно namelist.txt (который пишется руками), со ссылкой на C++/Qt документацию.
    Сгенерированное надо подсовывать среде, которая умеет в это.
    std::back_inserter лежит в <iterator>, но помнить это никто не делает.
    Просто пишем в среде '#include "std/ba' - среда подсказывает, '#include "std/back_inserter'
    В свою очередь, в файле 'std/back_inserter' лежит #include на <iterator>, и комментарий со ссылкой на cppreference
    (или на кутишные доки).
    Ссылка на доку в 95% случаев работает.
    Готовченко тут:
    https://github.com/al-martyn1/_std_headers
    https://github.com/al-martyn1/_qt_headers
    https://github.com/al-martyn1/_qt5_headers
    https://github.com/al-martyn1/_qt6_headers
    Примеры namelist.txt там же, для каждого случая.


umba-pretty-headers

    Парсит заданные входные файлы, для каждого типа или свободной функции или дефайна создаёт include-файл в output каталоге.
    Развитие утилиты umba-make-headers. Используется Clang-tooling. Текущая версия Win32/64 собрана на MSVC2019,
    если студия нужной версии/Clang не установлены, то могут быть проблемы (проблемы могут быть, даже если всё в 
    порядке вроде бы - как решать - хз, но у меня работает, на предыдущей работе не работало, но я уволился)
    Неплоха, чтобы посмотреть, что вообще в проекте с типами и иерархиями имен и пространств имён творится, и что есть что.


umba-sort-headers

   Сортировка incude'ов. Ничего не трогает, в тч кодировку. Макс попортятся переводы строк, но и тут мы старались делать нежно.
   Пробелы и пустые строки игнорируются. Все иное, в тч пустой комент - это брик для сортировки иклудов, 
   инклуды сортируются только в рамках блока без бриков. Всякие #ifdef'ы - тоже брики.
   Можно задавать приоритет сортировки - "user" и <system>
   Хорошая практика - в хидере сортировать всё, в файле реализации - первым идёт его хидер (чтобы проверить его самододостаточность),
   затем - отсортированные внешние зависимости - чтобы проще ориентироваться.


umba-subst-macros

   Задаём макросы в командной строке. Парсим файл, подставляем - профит. Макросы похожи на макросы проектов VisualStudio - $(MacroName).
   Неизвестные макросы можно пропускать как есть, либо вырезать.
   Ключик --raw позоляет делать замены без макросов - тупая текстовая подстановка. Из конкретного файла делаем шаблон в --raw режиме, 
   потом шаблон используем для генерации по шаблону при помощи макросов. Профит.


umba-tabtool

   --check - только проверки с выводом отчета. Возвращает не нулевой код возврата, можно использовать при коммита в хуках, например.
   Конвертит TAB'ы в пробелы и наоборот.
   Нормализация TAB'ов - конвертит пробелы в TAB'ы, потом наоборот, потом опять наоборот, с учетом TAB-дельты.

   Умеет исправлять некратное табам количество пробелов, так, 3 пробела дополняются до четырёх при -tab-delta=1, а 2 и меньше - обрезаются.


umba-tr

   Поддержка легковесной системы перевода (локализации) сообщений в стиле Qt - marty_tr.
   Собирает файлы из дерева каталогов/файлов в единый файл перевода в формате JSON. Иерархия трёх уровневая - LangTag/Category/MessageId,
   где MessageId - собственно сам текст сообщения (на англиском). LangTag может быть как в формате локали en-US, так и в виде виндового
   LangId - 0x0409/0x409/0409/409. Если категория в файле не задана (пустая), то подставляется путь конкретного файла относительно корня поиска.
   Единый JSON-файл перевода затем следует добавить в ресурсы приложения при помощи umba-2c и использовать с использованием библиотеки 
   https://github.com/al-martyn1/marty_tr


