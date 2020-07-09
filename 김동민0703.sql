join 8
SELECT countries.region_id, region_name, country_name
FROM countries, regions
WHERE countries.region_id = regions.region_id
AND countries.region_id = '1';

join 9
SELECT countries.region_id, region_name, country_name, city
FROM countries, regions, locations
WHERE countries.region_id = regions.region_id
AND countries.country_id = locations.country_id
AND countries.region_id = '1';

join 10
SELECT countries.region_id, region_name, country_name, city, department_name
FROM countries, regions, locations, departments
WHERE countries.region_id = regions.region_id
AND countries.country_id = locations.country_id
AND locations.location_id = departments.location_id
AND countries.region_id = '1';

join 11
SELECT countries.region_id, region_name, country_name, city, department_name, CONCAT(first_name, last_name) name
FROM countries, regions, locations, departments, employees
WHERE countries.region_id = regions.region_id
AND countries.country_id = locations.country_id
AND locations.location_id = departments.location_id
AND departments.department_id = employees.manager_id
AND countries.region_id = '1';


join 12
SELECT employee_id,CONCAT(first_name, last_name) name, employees.job_id, job_title
FROM employees, jobs
WHERE employees.job_id = jobs.job_id;

join 13
SELECT m.manager_id mgr_id, CONCAT(g.first_name, g.last_name) mgr_name, m.employee_id, 
CONCAT(m.first_name, m.last_name) name, jobs.job_id, job_title
FROM employees m, employees g, jobs
WHERE m.job_id = jobs.job_id
AND g.employee_id = m.manager_id;

