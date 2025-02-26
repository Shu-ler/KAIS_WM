Процедура СоздатьПартнераИКонтрагента(КонтрагентСсылка, НаВыгрузку)
	Перем КонтрагентОбъект;
	Перем Партнер;
	Перем Наименование;
	Перем ЮрФизЛицо;
	Перем ИндексКонца;
	ИндексКонца = СтрНайти(НаВыгрузку.КлиентСайта, "  ");
	Наименование = ?(ИндексКонца = 0, НаВыгрузку.КлиентСайта, Лев(НаВыгрузку.КлиентСайта, ИндексКонца));
	Наименование = СокрЛП(Наименование);

	ЮрФизЛицо = Перечисления.ЮрФизЛицо.ЮрЛицо;

	Если СтрНачинаетсяС(Наименование, "Индивидуальный предприниматель ") Тогда

		Наименование = СтрЗаменить(Наименование, "Индивидуальный предприниматель ", "");
		ЮрФизЛицо = Перечисления.ЮрФизЛицо.ИндивидуальныйПредприниматель;

	ИначеЕсли СтрНачинаетсяС(Наименование, "ИП ") Тогда

		Наименование = СтрЗаменить(Наименование, "ИП ", "");
		ЮрФизЛицо = Перечисления.ЮрФизЛицо.ИндивидуальныйПредприниматель;

	КонецЕсли;

	ПартнерСсылка = Справочники.Партнеры.ПустаяСсылка();

	Партнер = Справочники.Партнеры.СоздатьЭлемент();
	Партнер.Заполнить(Неопределено);
	Партнер.Наименование = Наименование;
	Партнер.НаименованиеПолное = Наименование;
	Партнер.Клиент = Истина;

	Попытка

		Партнер.Записать();
		ПартнерСсылка = Партнер.Ссылка;

	Исключение

		ОбщегоНазначения.СообщитьПользователю(ОписаниеОшибки());

	КонецПопытки;

	КонтрагентОбъект = Справочники.Контрагенты.СоздатьЭлемент();
	КонтрагентОбъект.Заполнить(Неопределено);
	КонтрагентОбъект.МФ_КодКАИС = НаВыгрузку.КлиентКод;
	КонтрагентОбъект.Наименование = Наименование;
	КонтрагентОбъект.ЮрФизЛицо = ЮрФизЛицо;
	КонтрагентОбъект.Партнер = ПартнерСсылка;

	Попытка

		КонтрагентОбъект.Записать();
		КонтрагентСсылка = КонтрагентОбъект.Ссылка;

	Исключение

		ОбщегоНазначения.СообщитьПользователю(ОписаниеОшибки());

	КонецПопытки;
КонецПроцедуры