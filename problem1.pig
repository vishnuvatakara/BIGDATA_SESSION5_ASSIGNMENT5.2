REGISTER '/home/acadgild/vishnu/piggybank.jar';
 
A = load '/home/acadgild/vishnu/DelayedFlights.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',','NO_MULTILINE','UNIX','SKIP_INPUT_HEADER');
 
B = foreach A generate (int)$1 as year, (int)$10 as flight_num, (chararray)$17 as origin,(chararray) $18 as dest;
 
C = filter B by dest is not null;
 
D = group C by dest;
 
E = foreach D generate group, COUNT(C.dest);
 
F = order E by $1 DESC;
 
Result = LIMIT F 5;
 
A1 = load '/home/acadgild/vishnu/airports.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',','NO_MULTILINE','UNIX','SKIP_INPUT_HEADER');
 
A2 = foreach A1 generate (chararray)$0 as dest, (chararray)$2 as city, (chararray)$4 as country;
 
joined_table = join Result by $0, A2 by dest;
 
dump joined_table;
