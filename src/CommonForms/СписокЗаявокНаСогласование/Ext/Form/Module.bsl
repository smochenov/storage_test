﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.ТекущаяДата = ТекущаяДата();
	СписокЗадач.Параметры.УстановитьЗначениеПараметра("ТекущаяДата", Параметры.ТекущаяДата);
	
	ТекущийТипОтображения        = 0;	
	СписокЗадачПустой            = НетТекущихЗадач();
	ОписаниеПоследнегоОбновления = "Обновлено 5 минут назад";
	
	
	
КонецПроцедуры

&НаСервере
Функция НетТекущихЗадач()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	ЗаявкаНаСогласование.Ссылка КАК Ссылка
		|ИЗ
		|	Документ.ЗаявкаНаСогласование КАК ЗаявкаНаСогласование
		|ГДЕ
		|	НЕ ЗаявкаНаСогласование.ПометкаУдаления
		|	И НЕ ЗаявкаНаСогласование.Выполнена";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда 
		Возврат Истина;
	КонецЕсли;
	
	Возврат Ложь;
		
КонецФункции	

&НаКлиенте
Процедура УправлениеФормой()
			
	//Если СписокЗадачПустой Тогда
	//	Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.СтраницаВсеЗадачиЗавершены;
	//Иначе
		Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.СтраницаСписокЗадач;
	//КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	УправлениеФормой();
	
КонецПроцедуры

&НаКлиенте
Процедура ТекущийТипОтображенияПриИзменении(Элемент)
	//для тестов
	
	Если ТекущийТипОтображения = 1 Тогда 
		Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.СтраницаСписокЗадач;
	Иначе
		Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.СтраницаВсеЗадачиЗавершены;
	КонецЕсли;	
	
	
КонецПроцедуры


&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	Оповестить();
КонецПроцедуры

