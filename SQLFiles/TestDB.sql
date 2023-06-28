/*
Indicates that the database called "sql_airbnb"
should be used for following statements
*/
USE `sql_airbnb`;

-- Selects all columns of the table "Account"
SELECT *
FROM Account;

-- Gives back the number of users in the "Account" table
SELECT COUNT(AccountID)
-- Rename the column
AS NumberOfUsers
FROM Account;

-- Selects all columns of the table "OfficialIdentificationType"
SELECT *
FROM OfficialIdentificationType;

-- Selection of three columns of the table "Account"
SELECT FirstName, LastName, DateCreated
FROM Account
-- Displays the records that meet the condition
WHERE OfficialIdentificationID = 5
-- Sorts the records in reference to the column
ORDER BY DateCreated;

-- Selection of three columns of the table "Account" and one column of the table "OfficialIdentificationType"
SELECT a.FirstName, a.LastName, a.DateCreated, o.OfficialIdentification
-- AS rename the tables
FROM Account AS a
-- Allows you to extract data from both tables at the same time.
JOIN OfficialIdentificationType As o
-- Logical statement to combine the tables
ON o.OfficialIdentificationID = a.OfficialIdentificationID
-- Displays the records that meet the condition
WHERE o.OfficialIdentificationID = 5
-- Sorts the records in reference to the column
ORDER BY DateCreated;

-- Selects all columns of the table "Language"
SELECT *
FROM Language;

-- Gives back the number of users in the "Language" table
SELECT COUNT(LanguageID)
-- Rename the column
AS NumberOfLanguages
FROM Language;

-- Select the columns of the tables "Account" and "Language".
SELECT a.FirstName, a.LastName, l.LanguageName
-- Allows you to extract data from the tables at the same time
-- with the logical statement ON to combine the tables
FROM Account_Language al
INNER JOIN Account a ON a.AccountID = al.AccountID
INNER JOIN Language l ON l.LanguageID = al.LanguageID
-- Displays the records that meet the condition
WHERE a.AccountID = 33;

-- Selects all columns of the table "SocialNetwork"
SELECT *
FROM SocialNetwork
-- Shows the first five records
LIMIT 5;

-- Gives back the number of social networks
SELECT COUNT(SocialNetworkID)
-- Rename the column
AS NumberOfSocialNetworks
FROM SocialNetwork;

-- Select the columns of the tables "Account" and "SocialNetwork".
SELECT a.FirstName, a.LastName, sn.SocialNetwork
-- Allows you to extract data from the tables at the same time
-- with the logical statement ON to combine the tables
FROM Account_SocialNetwork asn
INNER JOIN Account a ON a.AccountID = asn.AccountID
INNER JOIN SocialNetwork sn ON sn.SocialNetworkID = asn.SocialNetworkID
-- Displays the records that meet the condition
WHERE a.LastName IN ('Santos', 'Flores', 'Nakamura');

-- Selects all columns of the table "Host"
SELECT *
FROM Host
-- Shows the first record
LIMIT 1;

-- Select the columns of the tables "Account" and "Host"
SELECT a.FirstName, a.LastName, a.DateCreated, h.SuperHost
-- Allows you to extract data from the tables at the same time
-- with the logical statement ON to combine the tables
FROM Host h
JOIN Account a ON a.AccountID = h.AccountID
-- Organize the records according to the "SuperHost" column
-- and then by the date the account was created
ORDER BY h.SuperHost, a.DateCreated;

-- Selects all columns of the table "Guest"
SELECT *
FROM Guest
-- Shows the first record
LIMIT 1;

-- Gives back the number of guest
SELECT COUNT(GuestID)
-- Rename the column
AS NumberOfGuest
FROM Guest;

-- Select the columns of the tables "Account" and "Guest"
SELECT a.FirstName, a.LastName, a.DateCreated, g.Commission, g.ExperiencedGuest
-- Allows you to extract data from the tables at the same time
-- with the logical statement ON to combine the tables
FROM Guest g
JOIN Account a ON a.AccountID = g.AccountID
-- Organize the records according to the "Commission" column
-- and then by the date the account was created
ORDER BY g.Commission, a.DateCreated;

-- Select the columns of the created tables "T_Host" and "T_Guest"
SELECT T_Host.AccountID, T_Host.FirstName, T_Host.LastName, T_Host.DateCreated,
       T_Guest.Commission, T_Host.SuperHost, T_Guest.ExperiencedGuest
-- Table created from the combination of the tables "Account" and "Host"
-- and renamed as "T_Host"
FROM (SELECT a.AccountID, a.FirstName, a.LastName, a.DateCreated, h.SuperHost
         FROM Host h
         JOIN Account a
         ON a.AccountID = h.AccountID) AS T_Host
-- Table created from the combination of the "Account" and "Guest" tables
-- and renamed as "T_Guest"
JOIN (SELECT a.AccountID, a.FirstName, a.LastName, a.DateCreated,
             g.Commission, g.ExperiencedGuest
         FROM Guest g
         JOIN Account a
         ON a.AccountID = g.AccountID) AS T_Guest
ON T_Host.AccountID = T_Guest.AccountID
-- Organize the records according to the "Commission" column
ORDER BY g.Commission;

-- Selects all columns of the table "Address"
SELECT *
FROM Address
-- Shows the five first records
LIMIT 5;

-- Gives back the number of addresses
SELECT COUNT(*)
-- Rename the column
AS NumberOfAddresses
FROM Address;

-- Counts the number of rows per country grouping
-- Displays the column with the modified name
-- together with the country column
SELECT COUNT(*) AS NumberOfAddresses, Country
FROM Address
-- Grouping of addresses by country
GROUP BY Country
-- Sort records in descending order according
-- to total number of addresses
ORDER BY COUNT(*) DESC;

-- Selects all columns of the table "Accommodation"
SELECT *
FROM Accommodation
-- Shows the five first records
LIMIT 5;

-- Gives back the number of accommodations
SELECT COUNT(*)
-- Rename the column
AS NumberOfAccommodations
FROM Accommodation;

-- Selection of certain columns
-- The MIN aggregator gives the lowest price per night
SELECT ac.AccommodationName, MIN(ac.NightPrice), ad.City,
       ad.Country, A.FirstName, A.LastName
-- Allows you to extract data from the tables at the same time
-- with the logical statement ON to combine the tables
FROM Accommodation AS ac
JOIN Address AS ad ON ac.AddressID = ad.AddressID
JOIN Host AS h ON ac.HostID = h.HostID
JOIN Account AS A ON A.AccountID = h.AccountID;

-- Selection of certain columns
-- The MAX aggregator gives the highest price per night
SELECT ac.AccommodationName, MAX(ac.NightPrice) AS NightPrice,
       ad.City, ad.Country, ac.HostID, A.FirstName, A.LastName
-- Allows you to extract data from the tables at the same time
-- with the logical statement ON to combine the tables
FROM Accommodation AS ac
JOIN Address AS ad ON ac.AddressID = ad.AddressID
JOIN Host AS h ON ac.HostID = h.HostID
JOIN Account AS A ON A.AccountID = h.AccountID;

-- Selection of certain columns
SELECT h.HostID, A.FirstName, A.LastName,
       T_A.AccommodationName, T_A.NightPrice, ad.City, ad.Country
-- The table "T_A" is created from the table "Accomodation"
-- Extracts the information of the accommodation with the highest price
FROM (SELECT ac.AccommodationName, ac.NightPrice AS NightPrice,
             ac.AccommodationID, ac.AddressID, ac.HostID
         FROM Accommodation AS ac
         ORDER BY ac.NightPrice DESC
         LIMIT 1) AS T_A
-- Allows you to extract data from the tables
-- with the logical statement ON to combine the tables
JOIN Address AS ad ON T_A.AddressID = ad.AddressID
JOIN Host AS h ON T_A.HostID = h.HostID
JOIN Account AS A ON A.AccountID = h.AccountID;

-- Selects all columns of the table "Review"
SELECT *
FROM Review
-- Shows the five first records
LIMIT 5;

-- Gives back the number of reviews
SELECT COUNT(*)
-- Rename the column
AS NumberOfreviews
FROM Review;

-- Selection of certain columns
SELECT h.HostID, A.FirstName, A.LastName, T_R.NumberOfReviews
-- Counts the number of rows per HostID grouping
-- Displays the column with the modified name
-- together with the HostID column
FROM(SELECT COUNT(*) AS NumberOfReviews, HostID
        FROM Review
        -- Displays the records that meet the condition
        WHERE ReviewFor = 'H'
        -- Grouping of eviews by guest
        GROUP BY HostID
        -- Sort records in descending order according
        -- to total number of reviews
        ORDER BY COUNT(*) DESC) AS T_R
-- Combine the tables
JOIN Host AS h ON T_R.HostID = h.HostID
JOIN Account AS A ON A.AccountID = h.AccountID;

-- Selects all columns of the table "KitchenAmenity"
SELECT *
FROM KitchenAmenity
-- Shows the three first records
LIMIT 3;

-- Gives back the number of amenities in the "KitchenAmenity" table
SELECT COUNT(*)
-- Rename the column
AS NumberOfKitchenAmenities
FROM KitchenAmenity;

-- Selection of certain columns
SELECT T_A.AccommodationID, T_A.AccommodationName, ka.KitchenEquipment
-- The table "T_A" is created from the table "Accomodation"
-- Extracts the information of the accommodation with the highest price
FROM (SELECT ac.AccommodationName, ac.NightPrice AS NightPrice,
             ac.AccommodationID, ac.AddressID, ac.HostID
         FROM Accommodation AS ac
         ORDER BY ac.NightPrice DESC
         LIMIT 1) AS T_A
-- Combine the tables
INNER JOIN Accommodation_KitchenAmenity ak
ON ak.AccommodationID = T_A.AccommodationID
INNER JOIN KitchenAmenity ka
ON ka.KitchenAmenityID = ak.KitchenAmenityID;

-- Selects all columns of the table "BathBedroomLaundry"
SELECT *
FROM BathBedroomLaundry
-- Shows the three first records
LIMIT 3;

-- Gives back the number of amenities in
-- the "BathBedroomLaundry" table
SELECT COUNT(*)
-- Rename the column
AS NumberOfBathBedroomAmenities
FROM BathBedroomLaundry;

-- Counts the number of accommodations
SELECT COUNT(*) AS NumberOfAccommodations
-- The table "T_B" is created from the table "BathBedroomLaundry"
-- it has the information that meets the condition
FROM (SELECT *
         FROM BathBedroomLaundry
         WHERE AmenityName = "Crib") AS T_B
-- Combine the tables
JOIN Accommodation_BBLaundry ab
ON ab.BathBedroomLaundryID = T_B.BathBedroomLaundryID
JOIN Accommodation a
ON a.AccommodationID = ab.AccommodationID;

-- Selects all columns of the table "SafetyandProperty"
SELECT *
FROM SafetyandProperty
-- Shows the three first records
LIMIT 3;

-- Gives back the number of amenities in
-- the "SafetyandProperty" table
SELECT COUNT(*)
-- Rename the column
AS NumberOfSafetyPropertyAmenities
FROM SafetyandProperty;

-- Selection of certain columns
SELECT a.AccommodationName, a.NightPrice, T_SP.SafetyProperty,
       Address.City, Address.Country
-- The table "T_SP" is created from the table "SafetyandProperty"
-- it has the information that meets the condition
FROM (SELECT *
         FROM SafetyandProperty
         WHERE SafetyProperty IN ("No suitable for infants under 2 years",
                              "No suitable for children and infants")) AS T_SP
-- Combine the tables
JOIN Accommodation_SafetyProperty asp
ON asp.SafetyPropertyID = T_SP.SafetyPropertyID
JOIN Accommodation a
ON a.AccommodationID = asp.AccommodationID
JOIN Address
ON Address.AddressID = a.AddressID;

-- Selects all columns of the table "OutdoorFacility"
SELECT *
FROM OutdoorFacility
-- Shows the first fifteen records
LIMIT 15;

-- Gives back the number of amenities in
-- the "OutdoorFacility" table
SELECT COUNT(*)
-- Rename the column
AS NumberOfOutdoorFacility
FROM OutdoorFacility;

-- Selection of certain columns
SELECT a.AccommodationName, a.MaxGuest, a.NoBeds, a.NightPrice, a.Description,
       T_OF.OutdoorFacility, Address.Street, Address.City, Address.Country
-- The table "T_OF" is created from the table "OutdoorFacility"
-- it has the information that meets the condition
FROM (SELECT *
         FROM OutdoorFacility
         WHERE (OutdoorFacility LIKE '%access'
           OR OutdoorFacility LIKE '%pool')) AS T_OF
-- Combine the tables
JOIN Accommodation_OutdoorFacility ao
ON ao.OutdoorFacilityID = T_OF.OutdoorFacilityID
JOIN Accommodation a
ON a.AccommodationID = ao.AccommodationID
JOIN Address
ON Address.AddressID = a.AddressID
-- Sort records according to the name of the accommodation
ORDER BY AccommodationName;

-- Selects all columns of the table "Entertainment"
SELECT *
FROM Entertainment
-- Shows the first five records
LIMIT 5;

-- Gives back the number of amenities in
-- the "Entertainment" table
SELECT COUNT(*)
-- Rename the column
AS NumberOfEntertainmentPossibilities
FROM Entertainment;

-- Selection of certain columns
SELECT T_A.AccommodationName, e.Entertainment
-- The table "T_A" is created from the table "Accommodation"
-- it has the information that meets the condition
FROM (SELECT *
         FROM Accommodation
         WHERE (AccommodationName = 'Le Colombier'
           OR AccommodationName = 'The Croft')) AS T_A
-- Combine the tables
JOIN Accommodation_Entertainment ae
ON ae.AccommodationID = T_A.AccommodationID
JOIN Entertainment e
ON ae.EntertainmentID = e.EntertainmentID;

-- Selects all columns of the table "ScenicViews"
SELECT *
FROM ScenicViews
-- Shows the first five records
LIMIT 5;

-- Gives back the number of scenic views in
-- the "ScenicViews" table
SELECT COUNT(*)
-- Rename the column
AS NumberOfScenicViews
FROM ScenicViews;

-- Selection of certain columns
SELECT ap.PictureTitle, ap.PictureLink
-- The "T_SV" table is created from the table "ScenicViews"
-- it has the information that meets the condition
FROM (SELECT *
         FROM ScenicViews
         WHERE Views = 'Pyramids view') AS T_SV
-- Combine the tables
JOIN Accommodation_ScenicViews asv
ON T_SV.ScenicViewsID = asv.ScenicViewsID
JOIN Accommodation a
ON asv.AccommodationID = a.AccommodationID
JOIN AccommodationPicture ap
ON ap.AccommodationID = a.AccommodationID;

-- Selects all columns of the table "HouseRules"
SELECT *
FROM HouseRules
-- Shows the first five records
LIMIT 5;

-- Gives back the number of rules in
-- the "HouseRules" table
SELECT COUNT(*)
-- Rename the column
AS NumberOfRules
FROM HouseRules;

-- Selection of certain columns
SELECT a.AccommodationName, a.MaxGuest, a.NoBeds, a.NightPrice, a.Description,
       T_H.HouseRule, Address.Street, Address.City, Address.Country
-- The table "T_H" is created from the table "HouseRules"
-- it has the information that meets the condition
FROM (SELECT *
         FROM HouseRules
         WHERE HouseRule = "Pets allowed") AS T_H
-- Combine the tables
JOIN Accommodation_HouseRules ah
ON ah.HouseRuleID = T_H.HouseRuleID
JOIN Accommodation a
ON a.AccommodationID = ah.AccommodationID
JOIN Address
ON Address.AddressID = a.AddressID
ORDER BY a.NightPrice;

-- Selects all columns of the table
SELECT *
FROM CancellationPolicies
-- Shows the first five records
LIMIT 5;

-- Gives back the number of policies in
-- the "CancellationPolicies" table
SELECT COUNT(*)
-- Rename the column
AS NumberOfPolicies
FROM CancellationPolicies;

-- Selection of certain columns
SELECT Acc.FirstName, Acc.LastName, h.SuperHost,
       T_C.CancellationPolicies, a.AccommodationName
-- The table "T_C" is created from the table
-- "CancellationPolicies". It has the information
-- that meets the condition
FROM (SELECT *
         FROM CancellationPolicies
         WHERE CancellationPolicies LIKE "Strict%") AS T_C
-- Combine the tables
JOIN Accommodation_CancellationPolicies ac
ON ac.CancellationPoliciesID = T_C.CancellationPoliciesID
JOIN Accommodation a
ON a.AccommodationID = ac.AccommodationID
JOIN Host h
ON h.HostID = a.HostID
JOIN Account Acc
ON Acc.AccountID = h.AccountID
ORDER BY a.AccommodationName;

-- Selects all columns of the table
SELECT *
FROM Reservation
-- Shows the three first records
LIMIT 3;

-- Gives back the number of reservations in
-- the "Reservation" table
SELECT COUNT(*)
-- Rename the column
AS NumberOfReservations
FROM Reservation;

-- Selection of certain columns
SELECT T_R.ReservationDate, T_R.ReservationStatus, a.FirstName,
       a.LastName, ac.AccommodationName
-- The table "T_R" is created from the table
-- "Reservation". It has the information
-- that meets the condition
FROM (SELECT *
         FROM Reservation
         WHERE ReservationStatus = 'canceled') AS T_R
-- Combine the tables
JOIN Guest g ON g.GuestID = T_R.GuestID
JOIN Account a
ON a.AccountID = g.AccountID
JOIN Accommodation ac
ON ac.AccommodationID = T_R.AccommodationID;

-- Selects all columns of the table
SELECT *
FROM AccomRating
-- Shows the three first records
LIMIT 3;

-- Gives back the number of ratings in
-- the "AccomRating" table
SELECT COUNT(*)
-- Rename the column
AS NumberOfRatings
FROM AccomRating;

-- Select the AccommodationID column and
-- create a new column with the average rating
SELECT AccommodationID, AVG((Cleanliness+Accurancy+Communication+
       Location+CheckIn+ServiceAccordingPrice)/6) AS AverageRating
FROM AccomRating
-- Grouping of average rating by accommodation
GROUP BY AccommodationID
-- Sort records according to the average rating
ORDER BY AverageRating;

-- Selection of certain columns
SELECT g.GuestID, g.ExperiencedGuest, a.AccommodationID,
       a.AccommodationName, r.ReviewFor, a.HostID, r.Review
       -- The table "T_AR" is created from the table
       -- "AccomRating".
FROM (SELECT GuestID, AccommodationID
         FROM AccomRating ar
         -- Displays the records that meet the condition
         WHERE AccommodationID IN (4, 6)) AS T_AR
-- Combine the tables
JOIN Guest g
ON g.GuestID = T_AR.GuestID
JOIN Accommodation a
ON a.AccommodationID = T_AR.AccommodationID
JOIN Review r
ON r.GuestID = g.GuestID
-- Displays the records that meet the condition
WHERE r.ReviewFor = "H";

-- Selects all columns of the table
SELECT *
FROM CreditCard
-- Shows the three first records
LIMIT 3;

-- Gives back the number of credit cards
-- in the "CreditCard" table
SELECT COUNT(*)
-- Rename the column
AS NumberOfCreditCards
FROM CreditCard;

-- Selection of certain columns
-- Count the number of payments
SELECT cc.CardHolderFirstName, cc.CardHolderLastName,
       COUNT(*) AS NoPayments
FROM CreditCard cc
-- Combine the tables
JOIN Payment p
ON cc.CreditCardID = p.CreditCardID
-- Group records
GROUP BY cc.CardHolderFirstName, cc.CardHolderLastName
-- Sort records according to the number of payments
ORDER BY NoPayments DESC;

-- Selects all columns of the table
SELECT *
FROM Payment
-- Shows the three first records
LIMIT 3;

-- Gives back the number of payments
-- in the "Payment" table
SELECT COUNT(*)
-- Rename the column
AS NumberOfPayments
FROM Payment;

-- Obtains the total commission generated by the 30 bookings.
SELECT SUM((g.Commission*p.TotalAmount)/100 + (3*p.TotalAmount)/100) AS
       TotalCommission
-- Combine the tables
FROM Payment p
JOIN CreditCard c
ON c.CreditCardID = p.CreditCardID
JOIN Guest g
ON g.GuestID = c.GuestID;

-- Selection of certain columns.
-- Obtain the commission paid by the guest for each reservation.
-- Obtain the commission paid by the host for each reservation.
-- Obtain the total commission paid for each reservation.
-- Obtains the Profit made by the host for each reservation.
SELECT g.GuestID, p.TotalAmount, g.Commission AS GuestPercentageFee,
       (g.Commission*p.TotalAmount)/100 AS CommissionGuest,
       (3*p.TotalAmount)/100 AS CommissionHost,
       (g.Commission*p.TotalAmount)/100 + (3*p.TotalAmount)/100 AS
       TotalCommission,
       p.TotalAmount-((g.Commission*p.TotalAmount)/100 + (3*p.TotalAmount)/100)
       AS HostProfit
-- Combine the tables
FROM Payment p
JOIN CreditCard c
ON c.CreditCardID = p.CreditCardID
JOIN Guest g
ON g.GuestID = c.GuestID;
