delayed_flights = load '/home/kanika/Desktop/datasets/DelayedFlights.csv' using PigStorage(',');
origin_dep_delay = foreach delayed_flights generate $16 as Departure_delay, $17 as origin;
group_origin = group origin_dep_delay by origin;
average_delay = foreach group_origin generate group as origin, AVG(origin_dep_delay.Departure_delay) as average;
airport_data = load '/home/kanika/Desktop/datasets/airports.txt' using PigStorage(',');
airport = foreach airport_data generate $0 as abbr, $2 as city, $4 as country;
join_data = JOIN average_delay by origin, airport by abbr;
joined_data = foreach join_data generate average_delay::origin, airport::city, airport::country, average_delay::average;
order_data = order joined_data by average desc;
limit_data = limit order_data 10;
dump limit_data;

