﻿
Процедура ОбработкаПроведения(Отказ, Режим)
	
	Движения.ДоступныеСредства.Записывать = Истина;
	Движения.ДоступныеСредства.БлокироватьДляИзменения = Истина;
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	ДоступныеСредстваОстатки.ПлатежнаяСистема КАК ПлатежнаяСистема,
	|	ДоступныеСредстваОстатки.Валюта КАК Валюта,
	|	ДоступныеСредстваОстатки.СуммаВВалютеОстаток КАК СуммаВВалюте
	|ИЗ
	|	РегистрНакопления.ДоступныеСредства.Остатки(
	|			&Дата,
	|			ПлатежнаяСистема = &ПлатежнаяСистема
	|				И Валюта = &Валюта) КАК ДоступныеСредстваОстатки");
	Запрос.УстановитьПараметр("Валюта",Валюта);
	Запрос.УстановитьПараметр("ПлатежнаяСистема",ПлатежнаяСистема);
	Запрос.УстановитьПараметр("Дата", Дата);
	
	ВыборкаДетали = Запрос.Выполнить().Выбрать();
	
	ОсталосьСписать = Сумма;
	Пока ВыборкаДетали.Следующий() Цикл
		
		Движение = Движения.ДоступныеСредства.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
		Движение.Период = Дата;
		Движение.ПлатежнаяСистема = ПлатежнаяСистема;
		Движение.Валюта = Валюта;
		Движение.СуммаВВалюте = Сумма;
		
	КонецЦикла;
	
	Движения.ДоступныеСредства.Записать();

	Если Не КонтрольОстатков.ОстаткиВалютыДостаточны(ПлатежнаяСистема, Валюта, Дата, "Объект.Сумма", Сумма) Тогда
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
КонецПроцедуры
