-- { echoOn }
-- empty
select parseDateTimeInJodaSyntax(' ', ' ', 'UTC') = toDateTime('1970-01-01', 'UTC');

-- era
select parseDateTimeInJodaSyntax('AD 1999', 'G YYYY', 'UTC') = toDateTime('1999-01-01', 'UTC');
select parseDateTimeInJodaSyntax('ad 1999', 'G YYYY', 'UTC') = toDateTime('1999-01-01', 'UTC');
select parseDateTimeInJodaSyntax('Ad 1999', 'G YYYY', 'UTC') = toDateTime('1999-01-01', 'UTC');
select parseDateTimeInJodaSyntax('AD 1999', 'G yyyy', 'UTC') = toDateTime('1999-01-01', 'UTC');
select parseDateTimeInJodaSyntax('AD 1999 2000', 'G YYYY yyyy', 'UTC') = toDateTime('2000-01-01', 'UTC');
select parseDateTimeInJodaSyntax('AD 1999 2000', 'G yyyy YYYY', 'UTC') = toDateTime('2000-01-01', 'UTC');
select parseDateTimeInJodaSyntax('AD 1999', 'G Y'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('AD 1999', 'G YY'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('AD 1999', 'G YYY'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('BC', 'G'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('AB', 'G'); -- { serverError CANNOT_PARSE_DATETIME }

-- year of era
select parseDateTimeInJodaSyntax('2106', 'YYYY', 'UTC') = toDateTime('2106-01-01', 'UTC');
select parseDateTimeInJodaSyntax('1970', 'YYYY', 'UTC') = toDateTime('1970-01-01', 'UTC');
select parseDateTimeInJodaSyntax('1969', 'YYYY', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('2107', 'YYYY', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('+1999', 'YYYY', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }

select parseDateTimeInJodaSyntax('12', 'YY', 'UTC') = toDateTime('2012-01-01', 'UTC');
select parseDateTimeInJodaSyntax('69', 'YY', 'UTC') = toDateTime('2069-01-01', 'UTC');
select parseDateTimeInJodaSyntax('70', 'YY', 'UTC') = toDateTime('1970-01-01', 'UTC');
select parseDateTimeInJodaSyntax('99', 'YY', 'UTC') = toDateTime('1999-01-01', 'UTC');
select parseDateTimeInJodaSyntax('01', 'YY', 'UTC') = toDateTime('2001-01-01', 'UTC');
select parseDateTimeInJodaSyntax('1', 'YY', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }

select parseDateTimeInJodaSyntax('99 98 97', 'YY YY YY', 'UTC') = toDateTime('1997-01-01', 'UTC');

-- year
select parseDateTimeInJodaSyntax('12', 'yy', 'UTC') = toDateTime('2012-01-01', 'UTC');
select parseDateTimeInJodaSyntax('69', 'yy', 'UTC') = toDateTime('2069-01-01', 'UTC');
select parseDateTimeInJodaSyntax('70', 'yy', 'UTC') = toDateTime('1970-01-01', 'UTC');
select parseDateTimeInJodaSyntax('99', 'yy', 'UTC') = toDateTime('1999-01-01', 'UTC');
select parseDateTimeInJodaSyntax('+99', 'yy', 'UTC') = toDateTime('1999-01-01', 'UTC');
select parseDateTimeInJodaSyntax('+99 02', 'yy MM', 'UTC') = toDateTime('1999-02-01', 'UTC');
select parseDateTimeInJodaSyntax('10 +10', 'MM yy', 'UTC') = toDateTime('2010-10-01', 'UTC');
select parseDateTimeInJodaSyntax('10+2001', 'MMyyyy', 'UTC') = toDateTime('2001-10-01', 'UTC');
select parseDateTimeInJodaSyntax('+200110', 'yyyyMM', 'UTC') = toDateTime('2001-10-01', 'UTC');
select parseDateTimeInJodaSyntax('1970', 'yyyy', 'UTC') = toDateTime('1970-01-01', 'UTC');
select parseDateTimeInJodaSyntax('2106', 'yyyy', 'UTC') = toDateTime('2106-01-01', 'UTC');
select parseDateTimeInJodaSyntax('1969', 'yyyy', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('2107', 'yyyy', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }

-- week year
select parseDateTimeInJodaSyntax('2106', 'xxxx', 'UTC') = toDateTime('2106-01-04', 'UTC');
select parseDateTimeInJodaSyntax('1971', 'xxxx', 'UTC') = toDateTime('1971-01-04', 'UTC');
select parseDateTimeInJodaSyntax('2025', 'xxxx', 'UTC') = toDateTime('2024-12-30', 'UTC');
select parseDateTimeInJodaSyntax('12', 'xx', 'UTC') = toDateTime('2012-01-02', 'UTC');
select parseDateTimeInJodaSyntax('69', 'xx', 'UTC') = toDateTime('2068-12-31', 'UTC');
select parseDateTimeInJodaSyntax('99', 'xx', 'UTC') = toDateTime('1999-01-04', 'UTC');
select parseDateTimeInJodaSyntax('01', 'xx', 'UTC') = toDateTime('2001-01-01', 'UTC');
select parseDateTimeInJodaSyntax('+10', 'xx', 'UTC') = toDateTime('2010-01-04', 'UTC');
select parseDateTimeInJodaSyntax('+99 01', 'xx ww', 'UTC') = toDateTime('1999-01-04', 'UTC');
select parseDateTimeInJodaSyntax('+99 02', 'xx ww', 'UTC') = toDateTime('1999-01-11', 'UTC');
select parseDateTimeInJodaSyntax('10 +10', 'ww xx', 'UTC') = toDateTime('2010-03-08', 'UTC');
select parseDateTimeInJodaSyntax('2+10', 'wwxx', 'UTC') = toDateTime('2010-01-11', 'UTC');
select parseDateTimeInJodaSyntax('+102', 'xxM', 'UTC') = toDateTime('2010-02-01', 'UTC');
select parseDateTimeInJodaSyntax('+20102', 'xxxxM', 'UTC') = toDateTime('2010-02-01', 'UTC');
select parseDateTimeInJodaSyntax('1970', 'xxxx', 'UTC'); -- { serverError VALUE_IS_OUT_OF_RANGE_OF_DATA_TYPE }
select parseDateTimeInJodaSyntax('1969', 'xxxx', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('2107', 'xxxx', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }

-- century of era
select parseDateTimeInJodaSyntax('20', 'CC', 'UTC') = toDateTime('2000-01-01', 'UTC');
select parseDateTimeInJodaSyntax('21', 'CC', 'UTC') = toDateTime('2100-01-01', 'UTC');
select parseDateTimeInJodaSyntax('19', 'CC', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('22', 'CC', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }

-- month
select parseDateTimeInJodaSyntax('1', 'M', 'UTC') = toDateTime('2000-01-01', 'UTC');
select parseDateTimeInJodaSyntax(' 7', ' MM', 'UTC') = toDateTime('2000-07-01', 'UTC');
select parseDateTimeInJodaSyntax('11', 'M', 'UTC') = toDateTime('2000-11-01', 'UTC');
select parseDateTimeInJodaSyntax('10-', 'M-', 'UTC') = toDateTime('2000-10-01', 'UTC');
select parseDateTimeInJodaSyntax('-12-', '-M-', 'UTC') = toDateTime('2000-12-01', 'UTC');
select parseDateTimeInJodaSyntax('0', 'M', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('13', 'M', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('12345', 'M', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
--- Ensure MMM and MMMM specifiers consume both short- and long-form month names
select parseDateTimeInJodaSyntax('Aug', 'MMM', 'UTC') = toDateTime('2000-08-01', 'UTC');
select parseDateTimeInJodaSyntax('AuG', 'MMM', 'UTC') = toDateTime('2000-08-01', 'UTC');
select parseDateTimeInJodaSyntax('august', 'MMM', 'UTC') = toDateTime('2000-08-01', 'UTC');
select parseDateTimeInJodaSyntax('Aug', 'MMMM', 'UTC') = toDateTime('2000-08-01', 'UTC');
select parseDateTimeInJodaSyntax('AuG', 'MMMM', 'UTC') = toDateTime('2000-08-01', 'UTC');
select parseDateTimeInJodaSyntax('august', 'MMMM', 'UTC') = toDateTime('2000-08-01', 'UTC');
--- invalid month names
select parseDateTimeInJodaSyntax('Decembr', 'MMM', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('Decembr', 'MMMM', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('Decemberary', 'MMM', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('Decemberary', 'MMMM', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('asdf', 'MMM', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('asdf', 'MMMM', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }

-- day of month
select parseDateTimeInJodaSyntax('1', 'd', 'UTC') = toDateTime('2000-01-01', 'UTC');
select parseDateTimeInJodaSyntax('7 ', 'dd ', 'UTC') = toDateTime('2000-01-07', 'UTC');
select parseDateTimeInJodaSyntax('/11', '/dd', 'UTC') = toDateTime('2000-01-11', 'UTC');
select parseDateTimeInJodaSyntax('/31/', '/d/', 'UTC') = toDateTime('2000-01-31', 'UTC');
select parseDateTimeInJodaSyntax('0', 'd', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('32', 'd', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('12345', 'd', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('02-31', 'M-d', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('04-31', 'M-d', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
-- The last one is chosen if multiple day of months are supplied.
select parseDateTimeInJodaSyntax('2 31 1', 'M d M', 'UTC') = toDateTime('2000-01-31', 'UTC');
select parseDateTimeInJodaSyntax('1 31 20 2', 'M d d M', 'UTC') = toDateTime('2000-02-20', 'UTC');
select parseDateTimeInJodaSyntax('2 31 20 4', 'M d d M', 'UTC') = toDateTime('2000-04-20', 'UTC');
--- Leap year
select parseDateTimeInJodaSyntax('2020-02-29', 'YYYY-M-d', 'UTC') = toDateTime('2020-02-29', 'UTC');
select parseDateTimeInJodaSyntax('2001-02-29', 'YYYY-M-d', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }

-- day of year
select parseDateTimeInJodaSyntax('1', 'D', 'UTC') = toDateTime('2000-01-01', 'UTC');
select parseDateTimeInJodaSyntax('7 ', 'DD ', 'UTC') = toDateTime('2000-01-07', 'UTC');
select parseDateTimeInJodaSyntax('/11', '/DD', 'UTC') = toDateTime('2000-01-11', 'UTC');
select parseDateTimeInJodaSyntax('/31/', '/DDD/', 'UTC') = toDateTime('2000-01-31', 'UTC');
select parseDateTimeInJodaSyntax('32', 'D', 'UTC') = toDateTime('2000-02-01', 'UTC');
select parseDateTimeInJodaSyntax('60', 'D', 'UTC') = toDateTime('2000-02-29', 'UTC');
select parseDateTimeInJodaSyntax('365', 'D', 'UTC') = toDateTime('2000-12-30', 'UTC');
select parseDateTimeInJodaSyntax('366', 'D', 'UTC') = toDateTime('2000-12-31', 'UTC');
select parseDateTimeInJodaSyntax('1999 1', 'yyyy D', 'UTC') = toDateTime('1999-01-01', 'UTC');
select parseDateTimeInJodaSyntax('1999 7 ', 'yyyy DD ', 'UTC') = toDateTime('1999-01-07', 'UTC');
select parseDateTimeInJodaSyntax('1999 /11', 'yyyy /DD', 'UTC') = toDateTime('1999-01-11', 'UTC');
select parseDateTimeInJodaSyntax('1999 /31/', 'yyyy /DD/', 'UTC') = toDateTime('1999-01-31', 'UTC');
select parseDateTimeInJodaSyntax('1999 32', 'yyyy D', 'UTC') = toDateTime('1999-02-01', 'UTC');
select parseDateTimeInJodaSyntax('1999 60', 'yyyy D', 'UTC') = toDateTime('1999-03-01', 'UTC');
select parseDateTimeInJodaSyntax('1999 365', 'yyyy D', 'UTC') = toDateTime('1999-12-31', 'UTC');
select parseDateTimeInJodaSyntax('1999 366', 'yyyy D', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
--- Ensure all days of year are checked against final selected year
select parseDateTimeInJodaSyntax('2001 366 2000', 'yyyy D yyyy', 'UTC') = toDateTime('2000-12-31', 'UTC');
select parseDateTimeInJodaSyntax('2000 366 2001', 'yyyy D yyyy', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('0', 'D', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('367', 'D', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }

-- hour of day
select parseDateTimeInJodaSyntax('7', 'H', 'UTC') = toDateTime('1970-01-01 07:00:00', 'UTC');
select parseDateTimeInJodaSyntax('23', 'HH', 'UTC') = toDateTime('1970-01-01 23:00:00', 'UTC');
select parseDateTimeInJodaSyntax('0', 'HHH', 'UTC') = toDateTime('1970-01-01 00:00:00', 'UTC');
select parseDateTimeInJodaSyntax('10', 'HHHHHHHH', 'UTC') = toDateTime('1970-01-01 10:00:00', 'UTC');
--- invalid hour od day
select parseDateTimeInJodaSyntax('24', 'H', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('-1', 'H', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('123456789', 'H', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }

-- clock hour of day
select parseDateTimeInJodaSyntax('7', 'k', 'UTC') = toDateTime('1970-01-01 07:00:00', 'UTC');
select parseDateTimeInJodaSyntax('24', 'kk', 'UTC') = toDateTime('1970-01-01 00:00:00', 'UTC');
select parseDateTimeInJodaSyntax('1', 'kkk', 'UTC') = toDateTime('1970-01-01 01:00:00', 'UTC');
select parseDateTimeInJodaSyntax('10', 'kkkkkkkk', 'UTC') = toDateTime('1970-01-01 10:00:00', 'UTC');
-- invalid clock hour of day
select parseDateTimeInJodaSyntax('25', 'k', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('0', 'k', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('123456789', 'k', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }

-- hour of half day
select parseDateTimeInJodaSyntax('7', 'K', 'UTC') = toDateTime('1970-01-01 07:00:00', 'UTC');
select parseDateTimeInJodaSyntax('11', 'KK', 'UTC') = toDateTime('1970-01-01 11:00:00', 'UTC');
select parseDateTimeInJodaSyntax('0', 'KKK', 'UTC') = toDateTime('1970-01-01 00:00:00', 'UTC');
select parseDateTimeInJodaSyntax('10', 'KKKKKKKK', 'UTC') = toDateTime('1970-01-01 10:00:00', 'UTC');
-- invalid hour of half day
select parseDateTimeInJodaSyntax('12', 'K', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('-1', 'K', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('123456789', 'K', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }

-- clock hour of half day
select parseDateTimeInJodaSyntax('7', 'h', 'UTC') = toDateTime('1970-01-01 07:00:00', 'UTC');
select parseDateTimeInJodaSyntax('12', 'hh', 'UTC') = toDateTime('1970-01-01 00:00:00', 'UTC');
select parseDateTimeInJodaSyntax('1', 'hhh', 'UTC') = toDateTime('1970-01-01 01:00:00', 'UTC');
select parseDateTimeInJodaSyntax('10', 'hhhhhhhh', 'UTC') = toDateTime('1970-01-01 10:00:00', 'UTC');
-- invalid clock hour of half day
select parseDateTimeInJodaSyntax('13', 'h', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('0', 'h', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('123456789', 'h', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }

-- half of day
--- Half of day has no effect if hour or clockhour of day is provided hour of day tests
select parseDateTimeInJodaSyntax('7 PM', 'H a', 'UTC') = toDateTime('1970-01-01 07:00:00', 'UTC');
select parseDateTimeInJodaSyntax('7 AM', 'H a', 'UTC') = toDateTime('1970-01-01 07:00:00', 'UTC');
select parseDateTimeInJodaSyntax('7 pm', 'H a', 'UTC') = toDateTime('1970-01-01 07:00:00', 'UTC');
select parseDateTimeInJodaSyntax('7 am', 'H a', 'UTC') = toDateTime('1970-01-01 07:00:00', 'UTC');
select parseDateTimeInJodaSyntax('0 PM', 'H a', 'UTC') = toDateTime('1970-01-01 00:00:00', 'UTC');
select parseDateTimeInJodaSyntax('0 AM', 'H a', 'UTC') = toDateTime('1970-01-01 00:00:00', 'UTC');
select parseDateTimeInJodaSyntax('0 pm', 'H a', 'UTC') = toDateTime('1970-01-01 00:00:00', 'UTC');
select parseDateTimeInJodaSyntax('0 am', 'H a', 'UTC') = toDateTime('1970-01-01 00:00:00', 'UTC');
select parseDateTimeInJodaSyntax('7 PM', 'k a', 'UTC') = toDateTime('1970-01-01 07:00:00', 'UTC');
select parseDateTimeInJodaSyntax('7 AM', 'k a', 'UTC') = toDateTime('1970-01-01 07:00:00', 'UTC');
select parseDateTimeInJodaSyntax('7 pm', 'k a', 'UTC') = toDateTime('1970-01-01 07:00:00', 'UTC');
select parseDateTimeInJodaSyntax('7 am', 'k a', 'UTC') = toDateTime('1970-01-01 07:00:00', 'UTC');
select parseDateTimeInJodaSyntax('24 PM', 'k a', 'UTC') = toDateTime('1970-01-01 00:00:00', 'UTC');
select parseDateTimeInJodaSyntax('24 AM', 'k a', 'UTC') = toDateTime('1970-01-01 00:00:00', 'UTC');
select parseDateTimeInJodaSyntax('24 pm', 'k a', 'UTC') = toDateTime('1970-01-01 00:00:00', 'UTC');
select parseDateTimeInJodaSyntax('24 am', 'k a', 'UTC') = toDateTime('1970-01-01 00:00:00', 'UTC');
-- Half of day has effect if hour or clockhour of halfday is provided
select parseDateTimeInJodaSyntax('0 PM', 'K a', 'UTC') = toDateTime('1970-01-01 12:00:00', 'UTC');
select parseDateTimeInJodaSyntax('0 AM', 'K a', 'UTC') = toDateTime('1970-01-01 00:00:00', 'UTC');
select parseDateTimeInJodaSyntax('6 PM', 'K a', 'UTC') = toDateTime('1970-01-01 18:00:00', 'UTC');
select parseDateTimeInJodaSyntax('6 AM', 'K a', 'UTC') = toDateTime('1970-01-01 06:00:00', 'UTC');
select parseDateTimeInJodaSyntax('11 PM', 'K a', 'UTC') = toDateTime('1970-01-01 23:00:00', 'UTC');
select parseDateTimeInJodaSyntax('11 AM', 'K a', 'UTC') = toDateTime('1970-01-01 11:00:00', 'UTC');
select parseDateTimeInJodaSyntax('1 PM', 'h a', 'UTC') = toDateTime('1970-01-01 13:00:00', 'UTC');
select parseDateTimeInJodaSyntax('1 AM', 'h a', 'UTC') = toDateTime('1970-01-01 01:00:00', 'UTC');
select parseDateTimeInJodaSyntax('6 PM', 'h a', 'UTC') = toDateTime('1970-01-01 18:00:00', 'UTC');
select parseDateTimeInJodaSyntax('6 AM', 'h a', 'UTC') = toDateTime('1970-01-01 06:00:00', 'UTC');
select parseDateTimeInJodaSyntax('12 PM', 'h a', 'UTC') = toDateTime('1970-01-01 12:00:00', 'UTC');
select parseDateTimeInJodaSyntax('12 AM', 'h a', 'UTC') = toDateTime('1970-01-01 00:00:00', 'UTC');
-- time gives precendent to most recent time specifier
select parseDateTimeInJodaSyntax('0 1 AM', 'H h a', 'UTC') = toDateTime('1970-01-01 01:00:00', 'UTC');
select parseDateTimeInJodaSyntax('12 1 PM', 'H h a', 'UTC') = toDateTime('1970-01-01 13:00:00', 'UTC');
select parseDateTimeInJodaSyntax('1 AM 0', 'h a H', 'UTC') = toDateTime('1970-01-01 00:00:00', 'UTC');
select parseDateTimeInJodaSyntax('1 AM 12', 'h a H', 'UTC') = toDateTime('1970-01-01 12:00:00', 'UTC');

-- minute
select parseDateTimeInJodaSyntax('8', 'm', 'UTC') = toDateTime('1970-01-01 00:08:00', 'UTC');
select parseDateTimeInJodaSyntax('59', 'mm', 'UTC') = toDateTime('1970-01-01 00:59:00', 'UTC');
select parseDateTimeInJodaSyntax('0/', 'mmm/', 'UTC') = toDateTime('1970-01-01 00:00:00', 'UTC');
select parseDateTimeInJodaSyntax('60', 'm', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('-1', 'm', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('123456789', 'm', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }

-- second
select parseDateTimeInJodaSyntax('9', 's', 'UTC') = toDateTime('1970-01-01 00:00:09', 'UTC');
select parseDateTimeInJodaSyntax('58', 'ss', 'UTC') = toDateTime('1970-01-01 00:00:58', 'UTC');
select parseDateTimeInJodaSyntax('0/', 's/', 'UTC') = toDateTime('1970-01-01 00:00:00', 'UTC');
select parseDateTimeInJodaSyntax('60', 's', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('-1', 's', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }
select parseDateTimeInJodaSyntax('123456789', 's', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }

-- integer overflow in AST Fuzzer
select parseDateTimeInJodaSyntax('19191919191919191919191919191919', 'CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC', 'UTC'); -- { serverError CANNOT_PARSE_DATETIME }

-- { echoOff }
