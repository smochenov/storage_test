﻿
#Область ПрограммныйИнтерфейс

// Получается индекс пиктограммы файла - индекс в картинке КоллекцияПиктограммФайлов.
//
// Параметры:
//  РасширениеФайла - Строка - расширение файла строкой.
// 
// Возвращаемое значение:
//  Число - Индекс картинки в общей картинке КоллекцияСтрокПиктограммФайлов.
//
Функция ПолучитьИндексПиктограммыФайла(Знач РасширениеФайла) Экспорт

	Если ТипЗнч(РасширениеФайла) <> Тип("Строка")
	 Или ПустаяСтрока(РасширениеФайла) Тогда
		Возврат 10;
	КонецЕсли;

	РасширениеФайла = РасширениеБезТочки(РасширениеФайла);

	Расширение = "." + НРег(РасширениеФайла) + ";";

	Если СтрНайти(".mxl;",Расширение) <> 0 Тогда
		Возврат 6; // Текстовый Файл.

	ИначеЕсли СтрНайти(".txt;.log;.ini;", Расширение) <> 0 Тогда
		Возврат 10; // Текстовый Файл.

	ИначеЕсли СтрНайти(".ico;.wmf;.emf;",Расширение) <> 0 Тогда
		Возврат 14; // Картинки.

	ИначеЕсли СтрНайти(".htm;.html;.url;.mht;.mhtml;",Расширение) <> 0 Тогда
		Возврат 17; // HTML.

	ИначеЕсли СтрНайти(".doc;.dot;.rtf;",Расширение) <> 0 Тогда
		Возврат 18; // Файл Microsoft Word.

	ИначеЕсли СтрНайти(".xls;",Расширение) <> 0 Тогда
		Возврат 20; // Файл Microsoft Excel.

	ИначеЕсли СтрНайти(".ppt;.pptx;",Расширение) <> 0 Тогда
		Возврат 22; // Файл Microsoft PowerPoint

	ИначеЕсли СтрНайти(".jpg;.jpeg;.jp2;.jpe;",Расширение) <> 0 Тогда
		Возврат 42; // jpg.

	ИначеЕсли СтрНайти(".bmp;.dib;",Расширение) <> 0 Тогда
		Возврат 44; // bmp.

	ИначеЕсли СтрНайти(".tif;.tiff;",Расширение) <> 0 Тогда
		Возврат 46; // tif.

	ИначеЕсли СтрНайти(".gif;",Расширение) <> 0 Тогда
		Возврат 48; // gif.

	ИначеЕсли СтрНайти(".png;",Расширение) <> 0 Тогда
		Возврат 50; // png.

	ИначеЕсли СтрНайти(".pdf;",Расширение) <> 0 Тогда
		Возврат 52; // pdf.

	ИначеЕсли СтрНайти(".odt;",Расширение) <> 0 Тогда
		Возврат 54; // Open Office writer

	ИначеЕсли СтрНайти(".odf;",Расширение) <> 0 Тогда
		Возврат 56; // Open Office math

	ИначеЕсли СтрНайти(".odp;",Расширение) <> 0 Тогда
		Возврат 58; // Open Office Impress

	ИначеЕсли СтрНайти(".odg;",Расширение) <> 0 Тогда
		Возврат 60; // Open Office draw

	ИначеЕсли СтрНайти(".ods;",Расширение) <> 0 Тогда
		Возврат 62; // Open Office calc

	ИначеЕсли СтрНайти(".docx;",Расширение) <> 0 Тогда
		Возврат 68; // Файл Microsoft Word docx.

	ИначеЕсли СтрНайти(".xlsx;",Расширение) <> 0 Тогда
		Возврат 70; // Файл Microsoft Excel xlsx.

	Иначе
		Возврат 76;
	КонецЕсли;

КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Преобразует расширение файла в нижний регистр без точки.
//
// Параметры:
//  Расширение - Строка. Расширение для преобразования.
//
// Возвращаемое значение:
//  Строка.
//
Функция РасширениеБезТочки(Знач Расширение)

	Расширение = НРег(СокрЛП(Расширение));

	Если Сред(Расширение, 1, 1) = "." Тогда
		Расширение = Сред(Расширение, 2);
	КонецЕсли;

	Возврат Расширение;

КонецФункции

// Разбивает строку на несколько строк по разделителю. Разделитель может иметь любую длину.
//
// Параметры:
//  Строка                 - Строка - текст с разделителями;
//  Разделитель            - Строка - разделитель строк текста, минимум 1 символ;
//  ПропускатьПустыеСтроки - Булево - признак необходимости включения в результат пустых строк.
//    Если параметр не задан, то функция работает в режиме совместимости со своей предыдущей версией:
//     - для разделителя-пробела пустые строки не включаются в результат, для остальных разделителей пустые строки
//       включаются в результат.
//     Е если параметр Строка не содержит значащих символов или не содержит ни одного символа (пустая строка), то в
//       случае разделителя-пробела результатом функции будет массив, содержащий одно значение "" (пустая строка), а
//       при других разделителях результатом функции будет пустой массив.
//  СокращатьНепечатаемыеСимволы - Булево - сокращать непечатаемые символы по краям каждой из найденных подстрок.
//
// Возвращаемое значение:
//  Массив - массив строк.
//
// Примеры:
//  РазложитьСтрокуВМассивПодстрок(",один,,два,", ",") - возвратит массив из 5 элементов, три из которых  - пустые
//  строки;
//  РазложитьСтрокуВМассивПодстрок(",один,,два,", ",", Истина) - возвратит массив из двух элементов;
//  РазложитьСтрокуВМассивПодстрок(" один   два  ", " ") - возвратит массив из двух элементов;
//  РазложитьСтрокуВМассивПодстрок("") - возвратит пустой массив;
//  РазложитьСтрокуВМассивПодстрок("",,Ложь) - возвратит массив с одним элементом "" (пустой строкой);
//  РазложитьСтрокуВМассивПодстрок("", " ") - возвратит массив с одним элементом "" (пустой строкой);
//
Функция РазложитьСтрокуВМассивПодстрок(Знач Строка, Знач Разделитель = ",", Знач ПропускатьПустыеСтроки = Неопределено, СокращатьНепечатаемыеСимволы = Ложь) Экспорт
	
	Результат = Новый Массив;
	
	// Для обеспечения обратной совместимости.
	Если ПропускатьПустыеСтроки = Неопределено Тогда
		ПропускатьПустыеСтроки = ?(Разделитель = " ", Истина, Ложь);
		Если ПустаяСтрока(Строка) Тогда 
			Если Разделитель = " " Тогда
				Результат.Добавить("");
			КонецЕсли;
			Возврат Результат;
		КонецЕсли;
	КонецЕсли;
	//
	
	Позиция = Найти(Строка, Разделитель);
	Пока Позиция > 0 Цикл
		Подстрока = Лев(Строка, Позиция - 1);
		Если Не ПропускатьПустыеСтроки Или Не ПустаяСтрока(Подстрока) Тогда
			Если СокращатьНепечатаемыеСимволы Тогда
				Результат.Добавить(СокрЛП(Подстрока));
			Иначе
				Результат.Добавить(Подстрока);
			КонецЕсли;
		КонецЕсли;
		Строка = Сред(Строка, Позиция + СтрДлина(Разделитель));
		Позиция = Найти(Строка, Разделитель);
	КонецЦикла;
	
	Если Не ПропускатьПустыеСтроки Или Не ПустаяСтрока(Строка) Тогда
		Если СокращатьНепечатаемыеСимволы Тогда
			Результат.Добавить(СокрЛП(Строка));
		Иначе
			Результат.Добавить(Строка);
		КонецЕсли;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции 

#КонецОбласти


