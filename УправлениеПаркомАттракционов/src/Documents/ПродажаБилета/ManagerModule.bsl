
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Процедура заполняет табличный документ для печати.
//
// Параметры:
//	ТабДок - ТабличныйДокумент - табличный документ для заполнения и печати.
//	Ссылка - Произвольный - содержит ссылку на объект, для которого вызвана команда печати.
Процедура Билет(ТабДок, Ссылка) Экспорт

	Макет = ПолучитьМакет("Билет");
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ПродажаБилета.Номер,
		|	ПродажаБилета.Дата,
		|	ПродажаБилета.Аттракцион,
		|	ПродажаБилета.СуммаДокумента
		|ИЗ
		|	Документ.ПродажаБилета КАК ПродажаБилета
		|ГДЕ
		|	ПродажаБилета.Ссылка В (&Ссылка)";
	Запрос.Параметры.Вставить("Ссылка", Ссылка);
	Выборка = Запрос.Выполнить().Выбрать();

	ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
	Шапка = Макет.ПолучитьОбласть("Шапка");
	
	ТабДок.Очистить();

	ВставлятьРазделительСтраниц = Ложь;
	Пока Выборка.Следующий() Цикл
		Если ВставлятьРазделительСтраниц Тогда
			ТабДок.ВывестиГоризонтальныйРазделительСтраниц();
		КонецЕсли;
		
		ПараметрыОбласти = Новый Структура;
		ПараметрыОбласти.Вставить("Дата", Формат(Выборка.Дата, "ДЛФ=D;"));
		ПараметрыОбласти.Вставить("номер", УдалитьЛидирующиеНули(Выборка.Номер));

		ОбластьЗаголовок.Параметры.Заполнить(ПараметрыОбласти);
		ТабДок.Вывести(ОбластьЗаголовок);
		
		Шапка.Параметры.Заполнить(Выборка);
		ТабДок.Вывести(Шапка, Выборка.Уровень());	
		
		ВставлятьРазделительСтраниц = Истина;
	КонецЦикла;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытий

// Код процедур и функций

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Код процедур и функций

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция УдалитьЛидирующиеНули(Номер)
	Результат = Номер;
	Пока СтрНачинаетсяС(Результат, "0") Цикл
		Результат = Сред(Результат, 2);
	КонецЦикла;
	Возврат Результат;
КонецФункции

#КонецОбласти

#КонецЕсли


