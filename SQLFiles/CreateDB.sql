/*
Deletes all tables in the database and
clears the database
*/
DROP DATABASE IF EXISTS `sql_airbnb`;
-- Creates a database called "sql_airbnb"
CREATE DATABASE `sql_airbnb`;
/*
Indicates that the database called "sql_airbnb"
should be used for following statements
*/
USE `sql_airbnb`;

/*
Includes characters that cannot be represented
in pure ASCII
*/
SET NAMES utf8;
SET character_set_client = utf8mb4;

/*
Creates the table named "OfficialIdentificationType",
which indicated the type of identification used to
verify the user´s identity
*/
CREATE TABLE `OfficialIdentificationType` (
  `OfficialIdentificationID` int(11) NOT NULL,
  `OfficialIdentification` varchar(20) NOT NULL,
  PRIMARY KEY (`OfficialIdentificationID`)
);

/*
Creates the table named "Account",
which records the user's information.
*/
CREATE TABLE `Account` (
  `AccountID` int(11) NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `AccountEmail` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `Telephone` varchar(50) NOT NULL,
  `Birthdate` Date DEFAULT NULL,
  `DateCreated` Date NOT NULL,
  `OfficialIdentificationID` int(11) NOT NULL,
  PRIMARY KEY (`AccountID`),
  FOREIGN KEY (OfficialIdentificationID) REFERENCES OfficialIdentificationType(OfficialIdentificationID)
);

/*
Creates the table named "AccountPhoto",
which stores the name and link where the
user's profile pictures are located.
*/
CREATE TABLE `AccountPhoto` (
  `AccountPhotoID` int(11) NOT NULL,
  `PhotoTitle` varchar(50) NOT NULL,
  `PhotoLink` MEDIUMTEXT NOT NULL,
  `AccountID` int(11) NOT NULL,
  PRIMARY KEY (`AccountPhotoID`),
  FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);

/*
Creates the table named "Language".
Different languages are listed in this table
*/
CREATE TABLE `Language` (
  `LanguageID` int(11) NOT NULL,
  `LanguageName` varchar(50) NOT NULL,
  PRIMARY KEY (`LanguageID`)
);

/*
Creates the association table between
the "Account" and "Language" tables
*/
CREATE TABLE `Account_Language` (
  `AccountID` int(11) NOT NULL,
  `LanguageID` int(11) NOT NULL,
  PRIMARY KEY (`AccountID`, `LanguageID`),
  FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
  FOREIGN KEY (LanguageID) REFERENCES Language(LanguageID)
);

/*
Creates the table named "SocialNetwork",
Different social networks are listed in this table
*/
CREATE TABLE `SocialNetwork` (
  `SocialNetworkID` int(11) NOT NULL,
  `SocialNetwork` varchar(50) NOT NULL,
  PRIMARY KEY (`SocialNetworkID`)
);

/*
Creates the association table between
the "Account" and "SocialNetwork" tables
*/
CREATE TABLE `Account_SocialNetwork` (
  `AccountID` int(11) NOT NULL,
  `SocialNetworkID` int(11) NOT NULL,
  PRIMARY KEY (`AccountID`, `SocialNetworkID`),
  FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
  FOREIGN KEY (SocialNetworkID) REFERENCES SocialNetwork(SocialNetworkID)
);

/*
Creates the table named "Host",
who are the users who offer an accommodation.
*/
CREATE TABLE `Host` (
  `HostID` int(11) NOT NULL,
  `SuperHost` char(1) NOT NULL,
  `Commission` int(1) DEFAULT 3,
  `AccountID` int(11) NOT NULL,
  PRIMARY KEY (`HostID`),
  FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);

/*
Creates the table named "Guest", who are
the users who pay to use the Accommodation
for a certain period of time.
*/
CREATE TABLE `Guest` (
  `GuestID` int(11) NOT NULL,
  `ExperiencedGuest` char(1) NOT NULL,
  `Commission` int(2) DEFAULT 6, ## six to twelve
  `AccountID` int(11) NOT NULL,
  PRIMARY KEY (`GuestID`),
  FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);

/*
Creates the table named "Address".
Records the address of the property
*/
CREATE TABLE `Address` (
  `AddressID` int(11) NOT NULL,
  `Street` varchar(50) NOT NULL,
  `Number` varchar(20) NOT NULL,
  `City` varchar(50) NOT NULL,
  `Country` varchar(50) NOT NULL,
  PRIMARY KEY (`AddressID`)
);

/*
Creates the table named "Accommodation".
Contains the information related to the
accommodation
*/
CREATE TABLE `Accommodation` (
  `AccommodationID` int(11) NOT NULL,
  `AccommodationName` varchar(50) NOT NULL,
  `MaxGuest` int(5) NOT NULL,
  `NoBedrooms` int(5) NOT NULL,
  `NoBeds` int(5) NOT NULL,
  `NoBathrooms` int(5) DEFAULT NULL,
  `NightPrice` DECIMAL(10, 2) NOT NULL,
  `Description` MEDIUMTEXT NOT NULL,
  `HostID` int(11) NOT NULL,
  `AddressID` int(11) NOT NULL,
  PRIMARY KEY (`AccommodationID`),
  FOREIGN KEY (HostID) REFERENCES Host(HostID),
  FOREIGN KEY (AddressID) REFERENCES Address(AddressID)
);

/*
Creates the table named "Review",
Records reviews written by the host
to the guest and vice versa.
*/
CREATE TABLE `Review` (
  `ReviewID` int(11) NOT NULL,
  `ReviewDate` Date NOT NULL,
  `ReviewFor` varchar(1) NOT NULL,
  `Review` MEDIUMTEXT NOT NULL,
  `HostID` int(11) NOT NULL,
  `GuestID` int(11) NOT NULL,
  PRIMARY KEY (`ReviewID`),
  FOREIGN KEY (HostID) REFERENCES Host(HostID),
  FOREIGN KEY (GuestID) REFERENCES Guest(GuestID)
);

/*
Creates the table named "KitchenAmenity",
This table lists the various amenities
that can be found in the kitchen
*/
CREATE TABLE `KitchenAmenity` (
  `KitchenAmenityID` int(11) NOT NULL,
  `KitchenEquipment` varchar(60) NOT NULL,
  PRIMARY KEY (`KitchenAmenityID`)
);

/*
Creates the association table between
the "Accommodation" and "KitchenAmenity" tables.
*/
CREATE TABLE `Accommodation_KitchenAmenity` (
  `AccommodationID` int(11) NOT NULL,
  `KitchenAmenityID` int(11) NOT NULL,
  PRIMARY KEY (`AccommodationID`, `KitchenAmenityID`),
  FOREIGN KEY (AccommodationID) REFERENCES Accommodation(AccommodationID),
  FOREIGN KEY (KitchenAmenityID) REFERENCES KitchenAmenity(KitchenAmenityID)
);

/*
Creates the table named "BathBedroomLaundry",
Lists the various amenities that can be found
in the bathroom and bedroom, and whether there
is laundry and drying facilities
*/
CREATE TABLE `BathBedroomLaundry` (
  `BathBedroomLaundryID` int(11) NOT NULL,
  `AmenityName` varchar(60) NOT NULL,
  PRIMARY KEY (`BathBedroomLaundryID`)
);

/*
Creates the association table between the
"Accommodation" and "BathBedroomLaundry" tables
*/
CREATE TABLE `Accommodation_BBLaundry` (
  `AccommodationID` int(11) NOT NULL,
  `BathBedroomLaundryID` int(11) NOT NULL,
  PRIMARY KEY (`AccommodationID`, `BathBedroomLaundryID`),
  FOREIGN KEY (AccommodationID) REFERENCES Accommodation(AccommodationID),
  FOREIGN KEY (BathBedroomLaundryID) REFERENCES BathBedroomLaundry(BathBedroomLaundryID)
);

/*
Creates the table named "SafetyandProperty",
Lists the safety measures and possible hazards on the property.
It also mentions facilities offered by the property with
respect to temperature regulation and parking.
*/
CREATE TABLE `SafetyandProperty` (
  `SafetyPropertyID` int(11) NOT NULL,
  `SafetyProperty` varchar(60) NOT NULL,
  PRIMARY KEY (`SafetyPropertyID`)
);

/*
Creates the association table between
the "Accommodation" and "SafetyandProperty" tables
*/
CREATE TABLE `Accommodation_SafetyProperty` (
  `AccommodationID` int(11) NOT NULL,
  `SafetyPropertyID` int(11) NOT NULL,
  PRIMARY KEY (`AccommodationID`, `SafetyPropertyID`),
  FOREIGN KEY (AccommodationID) REFERENCES Accommodation(AccommodationID),
  FOREIGN KEY (SafetyPropertyID) REFERENCES SafetyandProperty(SafetyPropertyID)
);

/*
Creates the table named "OutdoorFacility".
Lists the facilities accessible to the guest and
the items or equipment for external use provided
by the accommodation.
*/
CREATE TABLE `OutdoorFacility` (
  `OutdoorFacilityID` int(11) NOT NULL,
  `OutdoorFacility` varchar(100) NOT NULL,
  PRIMARY KEY (`OutdoorFacilityID`)
);

/*
Creates the association table between the
"Accommodation" and "OutdoorFacility" tables
*/
CREATE TABLE `Accommodation_OutdoorFacility` (
  `AccommodationID` int(11) NOT NULL,
  `OutdoorFacilityID` int(11) NOT NULL,
  PRIMARY KEY (`AccommodationID`, `OutdoorFacilityID`),
  FOREIGN KEY (AccommodationID) REFERENCES Accommodation(AccommodationID),
  FOREIGN KEY (OutdoorFacilityID) REFERENCES OutdoorFacility(OutdoorFacilityID)
);

/*
Creates the table named "Entertainment".
Lists the different entertainment possibilities
that can be found in the accommodation
*/
CREATE TABLE `Entertainment` (
  `EntertainmentID` int(11) NOT NULL,
  `Entertainment` varchar(60) NOT NULL,
  PRIMARY KEY (`EntertainmentID`)
);

/*
Creates the association table between the
"Accommodation" and "Entertainment" tables
*/
CREATE TABLE `Accommodation_Entertainment` (
  `AccommodationID` int(11) NOT NULL,
  `EntertainmentID` int(11) NOT NULL,
  PRIMARY KEY (`AccommodationID`, `EntertainmentID`),
  FOREIGN KEY (AccommodationID) REFERENCES Accommodation(AccommodationID),
  FOREIGN KEY (EntertainmentID) REFERENCES Entertainment(EntertainmentID)
);

/*
Creates the table named "ScenicViews".
Lists the scenic views that the guest can
admire from the accommodation
*/
CREATE TABLE `ScenicViews` (
  `ScenicViewsID` int(11) NOT NULL,
  `Views` varchar(20) NOT NULL,
  PRIMARY KEY (`ScenicViewsID`)
);

/*
Creates the association table between the
"Accommodation" and "ScenicViews" tables
*/
CREATE TABLE `Accommodation_ScenicViews` (
  `AccommodationID` int(11) NOT NULL,
  `ScenicViewsID` int(11) NOT NULL,
  PRIMARY KEY (`AccommodationID`, `ScenicViewsID`),
  FOREIGN KEY (AccommodationID) REFERENCES Accommodation(AccommodationID),
  FOREIGN KEY (ScenicViewsID) REFERENCES ScenicViews(ScenicViewsID)
);

/*
Creates the table named "HouseRules".
Lists the different rules of the house,
which must be respected by the guest
during his/her stay.
*/
CREATE TABLE `HouseRules` (
  `HouseRuleID` int(11) NOT NULL,
  `HouseRule` varchar(80) NOT NULL,
  PRIMARY KEY (`HouseRuleID`)
);

/*
Creates the association table between the
"Accommodation" and "HouseRules" tables
*/
CREATE TABLE `Accommodation_HouseRules` (
  `AccommodationID` int(11) NOT NULL,
  `HouseRuleID` int(11) NOT NULL,
  PRIMARY KEY (`AccommodationID`, `HouseRuleID`),
  FOREIGN KEY (AccommodationID) REFERENCES Accommodation(AccommodationID),
  FOREIGN KEY (HouseRuleID) REFERENCES HouseRules(HouseRuleID)
);

/*
Creates the table named "CancellationPolicies".
Lists different types of cancellation policies
*/
CREATE TABLE `CancellationPolicies` (
  `CancellationPoliciesID` int(11) NOT NULL,
  `CancellationPolicies` MEDIUMTEXT NOT NULL,
  PRIMARY KEY (`CancellationPoliciesID`)
);

/*
Creates the association table between the
"Accommodation" and "CancellationPolicies" tables
*/
CREATE TABLE `Accommodation_CancellationPolicies` (
  `AccommodationID` int(11) NOT NULL,
  `CancellationPoliciesID` int(11) NOT NULL,
  PRIMARY KEY (`AccommodationID`, `CancellationPoliciesID`),
  FOREIGN KEY (AccommodationID) REFERENCES Accommodation(AccommodationID),
  FOREIGN KEY (CancellationPoliciesID) REFERENCES CancellationPolicies(CancellationPoliciesID)
);

/*
Creates the table named "AccommodationPicture".
Contains the names and links to the images of
the different accommodations.
*/
CREATE TABLE `AccommodationPicture` (
  `AccomPictureID` int(11) NOT NULL,
  `PictureTitle` varchar(50) NOT NULL,
  `PictureLink` MEDIUMTEXT NOT NULL,
  `AccommodationID` int(11) NOT NULL,
  PRIMARY KEY (`AccomPictureID`),
  FOREIGN KEY (AccommodationID) REFERENCES Accommodation(AccommodationID)
);

/*
Creates the table named "Reservation", which records
the details of the reservation made by the guest.
*/
CREATE TABLE `Reservation` (
  `ReservationID` int(11) NOT NULL,
  `ReservationDate` Date NOT NULL,
  `ArrivalDate` Date NOT NULL,
  `DepartureDate` Date NOT NULL,
  `NoGuest` int(5) NOT NULL,
  `ReservationStatus` varchar(20) NOT NULL,
  `GuestID` int(11) NOT NULL,
  `AccommodationID` int(11) NOT NULL,
  PRIMARY KEY (`ReservationID`),
  FOREIGN KEY (GuestID) REFERENCES Guest(GuestID),
  FOREIGN KEY (AccommodationID) REFERENCES Accommodation(AccommodationID)
);

/*
Creates the table named "AccomRating", guests rate
the accommodations from one to five in six categories,
with one being the worst or lowest rating and
five being the best or highest.
*/
CREATE TABLE `AccomRating` (
  `AccomRatingID` int(11) NOT NULL,
  `RaitingDate` Date NOT NULL,
  `Cleanliness` int(1) NOT NULL,
  `Accurancy` int(1) NOT NULL,
  `Communication` int(1) NOT NULL,
  `Location` int(1) NOT NULL,
  `CheckIn` int(1) NOT NULL,
  `ServiceAccordingPrice` int(1) NOT NULL,
  `GuestID` int(11) NOT NULL,
  `AccommodationID` int(11) NOT NULL,
  PRIMARY KEY (`AccomRatingID`),
  FOREIGN KEY (GuestID) REFERENCES Guest(GuestID),
  FOREIGN KEY (AccommodationID) REFERENCES Accommodation(AccommodationID)
);

/*
Creates the table named "CreditCard", which
contains information about the credit card
used by the guest to pay for their stay.
*/
CREATE TABLE `CreditCard` (
  `CreditCardID` int(11) NOT NULL,
  `CreditCardNumber` bigint(50) NOT NULL,
  `ExpiredDate` Date NOT NULL,
  `BankName` varchar(25) NOT NULL,
  `CardHolderFirstName` varchar(50) NOT NULL,
  `CardHolderLastName` varchar(50) NOT NULL,
  `GuestID` int(11) NOT NULL,
  PRIMARY KEY (`CreditCardID`),
  FOREIGN KEY (GuestID) REFERENCES Guest(GuestID)
);

/*
Creates the table named "Payment".Records the
details of the guest´s payment for the stay.
*/
CREATE TABLE `Payment` (
  `PaymentID` int(11) NOT NULL,
  `PaymentDate` Date NOT NULL,
  `CurrentNightPrice` DECIMAL(10, 2) NOT NULL,
  `NoNights` int(11) NOT NULL,
  `TotalAmount` DECIMAL(10, 2) NOT NULL,
  `CreditCardID` int(11) NOT NULL,
  `ReservationID` int(11) NOT NULL,
  PRIMARY KEY (`PaymentID`),
  FOREIGN KEY (CreditCardID) REFERENCES CreditCard(CreditCardID),
  FOREIGN KEY (ReservationID) REFERENCES Reservation(ReservationID)
);
