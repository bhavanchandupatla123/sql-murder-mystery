-- SQL Murder Mystery
-- Portfolio investigation by Bhavan Chandupatla
-- Database: sql_detective_game

USE sql_detective_game;

-- ------------------------------------------------------------
-- 1. Find the murder report
-- ------------------------------------------------------------
SELECT *
FROM crime_scene_report
WHERE crime_date = '2018-01-15'
  AND crime_type = 'murder'
  AND city = 'SQL City';

-- Clue:
-- Witness 1 lives at the last house on Northwestern Dr.
-- Witness 2 is named Annabel and lives on Franklin Ave.

-- ------------------------------------------------------------
-- 2. Identify witness 1
-- ------------------------------------------------------------
SELECT *
FROM person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number DESC
LIMIT 1;

-- Expected: Maya Rao

-- ------------------------------------------------------------
-- 3. Identify witness 2
-- ------------------------------------------------------------
SELECT *
FROM person
WHERE name LIKE 'Annabel%'
  AND address_street_name = 'Franklin Ave';

-- Expected: Annabel Miller

-- ------------------------------------------------------------
-- 4. Read both witness interviews
-- ------------------------------------------------------------
SELECT p.name, i.transcript
FROM person p
JOIN interview i
  ON p.person_id = i.person_id
WHERE p.name IN ('Maya Rao', 'Annabel Miller');

-- Key clues:
-- * male suspect
-- * Get Fit Now membership begins with 7B
-- * checked in on 2018-01-09
-- * vehicle plate contains H42
-- * a wealthy woman hired him
-- * she attended the SQL Symphony Gala three times in Dec 2017

-- ------------------------------------------------------------
-- 5. Find gym members whose membership begins with 7B
--    and who checked in on 2018-01-09
-- ------------------------------------------------------------
SELECT
    g.membership_id,
    g.person_id,
    g.member_name,
    c.check_in_date,
    c.check_in_time,
    c.check_out_time
FROM get_fit_now_member g
JOIN get_fit_now_check_in c
  ON g.membership_id = c.membership_id
WHERE g.membership_id LIKE '7B%'
  AND c.check_in_date = '2018-01-09';

-- ------------------------------------------------------------
-- 6. Match the H42 vehicle clue
-- ------------------------------------------------------------
SELECT
    p.person_id,
    p.name,
    g.membership_id,
    d.plate_number,
    d.car_make,
    d.car_model
FROM person p
JOIN get_fit_now_member g
  ON p.person_id = g.person_id
JOIN get_fit_now_check_in c
  ON g.membership_id = c.membership_id
JOIN drivers_license d
  ON p.license_id = d.license_id
WHERE g.membership_id LIKE '7B%'
  AND c.check_in_date = '2018-01-09'
  AND d.plate_number LIKE '%H42%';

-- ------------------------------------------------------------
-- 7. Inspect the candidate interviews
-- ------------------------------------------------------------
SELECT
    p.name,
    i.transcript
FROM person p
JOIN interview i
  ON p.person_id = i.person_id
WHERE p.name IN ('Daniel Reed', 'Victor Hale');

-- Daniel Reed admits he was paid to carry out the crime.

-- ------------------------------------------------------------
-- 8. Find people who attended the SQL Symphony Gala
--    exactly three times in December 2017
-- ------------------------------------------------------------
SELECT
    p.person_id,
    p.name,
    COUNT(*) AS gala_visits
FROM person p
JOIN facebook_event_checkin f
  ON p.person_id = f.person_id
WHERE f.event_name = 'SQL Symphony Gala'
  AND f.event_date >= '2017-12-01'
  AND f.event_date < '2018-01-01'
GROUP BY p.person_id, p.name
HAVING COUNT(*) = 3;

-- ------------------------------------------------------------
-- 9. Add the mastermind description:
--    female, red hair, Tesla Model S, very high income
-- ------------------------------------------------------------
SELECT
    p.person_id,
    p.name,
    d.hair_color,
    d.gender,
    d.car_make,
    d.car_model,
    inc.annual_income,
    COUNT(f.checkin_id) AS gala_visits
FROM person p
JOIN drivers_license d
  ON p.license_id = d.license_id
JOIN income inc
  ON p.ssn = inc.ssn
JOIN facebook_event_checkin f
  ON p.person_id = f.person_id
WHERE d.gender = 'female'
  AND d.hair_color = 'red'
  AND d.car_make = 'Tesla'
  AND d.car_model = 'Model S'
  AND f.event_name = 'SQL Symphony Gala'
  AND f.event_date >= '2017-12-01'
  AND f.event_date < '2018-01-01'
GROUP BY
    p.person_id,
    p.name,
    d.hair_color,
    d.gender,
    d.car_make,
    d.car_model,
    inc.annual_income
HAVING COUNT(f.checkin_id) = 3
ORDER BY inc.annual_income DESC;

-- Final conclusion:
-- Murderer  : Daniel Reed
-- Mastermind: Olivia Sterling
