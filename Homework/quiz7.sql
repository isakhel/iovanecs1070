--1

select *

from payment

where amount >= 9.99;

 

 

-- 2

-- this part finds the max amount


--this part finds the films that cost 11.99

select *

from film

where (select MAX (amount)
from payment);

 

--3

select first_name, last_name, email, address, city, country

from staff

left join address

on staff.address_id = address.address_id

left join city

on address.city_id = city.city_id

left join country

on city.country_id = country.country_id;