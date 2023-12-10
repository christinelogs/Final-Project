CREATE DATABASE petAdoption;
-- Table for common user information
CREATE TABLE users (
    userid INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    username VARCHAR(255),
    password VARCHAR(255)
);

-- Table for pet adopters
CREATE TABLE pet_adopters (
    adopterid INT PRIMARY KEY,
    userid INT,
    FOREIGN KEY (userid) REFERENCES users(userid)
);

-- Table for pet information
CREATE TABLE pet_information (
    petid INT PRIMARY KEY,
    adopterid INT,
    name VARCHAR(255),
    age INT,
    gender VARCHAR(10),
    type_of_animal VARCHAR(50),
    breed VARCHAR(50),
    location VARCHAR(255),
    category VARCHAR(50),
    status VARCHAR(50),
    FOREIGN KEY (adopterid) REFERENCES pet_adopters(adopterid)
);

-- Table for messages
CREATE TABLE messages (
    messageid INT PRIMARY KEY,
    adopterid INT,
    providerid INT,
    message TEXT,
    date TIMESTAMP,
    FOREIGN KEY (adopterid) REFERENCES pet_adopters(adopterid),
    FOREIGN KEY (providerid) REFERENCES pet_providers(providerid)
);

-- Table for pet adoption form
CREATE TABLE pet_adoption_form (
    formid INT PRIMARY KEY,
    adopterid INT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    contact_no VARCHAR(20),
    email VARCHAR(255),
    home_type VARCHAR(50),
    why_adopt_pet TEXT,
    previously_owned_pets VARCHAR(3),
    currently_owned_pets VARCHAR(255),
    status VARCHAR(50),
    FOREIGN KEY (adopterid) REFERENCES pet_adopters(adopterid)
);

-- Table for pet providers
CREATE TABLE pet_providers (
    providerid INT PRIMARY KEY,
    userid INT,
    FOREIGN KEY (userid) REFERENCES users(userid)
);

-- Table for pet provider messages
CREATE TABLE pet_provider_messages (
    messageid INT PRIMARY KEY,
    petadopterid INT,
    petproviderid INT,
    messagedate TIMESTAMP,
    FOREIGN KEY (petadopterid) REFERENCES pet_adopters(adopterid),
    FOREIGN KEY (petproviderid) REFERENCES pet_providers(providerid)
);

-- Login as Pet Adopter
SELECT adopterid, name, email 
FROM pet_adopters 
WHERE (email = email.TextBox.Text OR username = username.TextBox.Text) AND password = password.TextBox.Text;

-- Swiping for Dogs
SELECT * FROM pet_information
WHERE category = 'Dog';

-- Pet Adopter Messages
SELECT pa.name AS Adopter, pp.name AS Provider, m.message, m.date AS Date
FROM pet_adopters pa
JOIN messages m ON pa.adopterid = m.adopterid
JOIN pet_providers pp ON pp.providerid = m.providerid
ORDER BY m.date DESC;

-- Pet Adopter Messages (Alternative)
SELECT * FROM PetProviderMessages 
JOIN PetAdopters ON PetProviderMessages.petadopterid = PetAdopters.petadopterid 
JOIN PetProviders ON PetProviderMessages.petproviderid = PetProviders.petproviderid 
WHERE petadopterid = 'varpetadopterid' AND petproviderid = 'varpetproviderid' 
ORDER BY messagedate DESC;

-- Adoption Form Submission
INSERT INTO pet_adoption_form (first_name, last_name, contact_no, email, home_type, why_adopt_pet, previously_owned_pets, currently_owned_pets)
VALUES ('Christine', 'Mendoza', 09847549352, 'cm123@gmail.com', 'house', 'companion for child', yes, 'dog, cat');

-- Retrieve Adoption Form
SELECT *
FROM pet_adoption_form
WHERE first_name = 'Christine'
  AND last_name = 'Mendoza';

-- Update Adoption Form
UPDATE pet_adoption_form
SET first_name = 'Alliah', last_name = 'Laylo', contact_no = 09123408612, email = 'liah123@gmail.com', home_type = 'apartment', why_adopt_pet = 'companion for self', previously_owned_pets = 'no', currently_owned_pets = 'rabbit'
WHERE id = 1;

-- Delete Adoption Form
DELETE FROM pet_adoption_form WHERE id = 1;

-- Provider Login
SELECT providerid, name, email 
FROM pet_provider
WHERE (email = email.TextBox.Text OR username = username.TextBox.Text) AND password = password.TextBox.Text;

-- Add Pet Information
INSERT INTO pet_information (name, age, gender, type_of_animal, breed, location)
VALUES ('Mingming', 6, 'Male', 'Cat', 'Tabby Cat', 'Rosario, Batangas');

-- Count Cats
SELECT COUNT(*) AS total_cats
FROM pet_information
WHERE type_of_animal = 'Cat';

-- Retrieve Pet Information
SELECT * FROM pet_information WHERE name = 'Mingming';

-- Update Pet Information
UPDATE pet_information SET breed = 'Maine Coon' WHERE name = 'Mingming';

-- Delete Pet Information
DELETE FROM pet_information WHERE name = 'Mingming';

-- Retrieve Adoption Form Responses
SELECT *
FROM pet_adoption_form;

-- Retrieve Adoption Form Responses (Ordered by Breed)
SELECT * FROM pet_adoption_form
ORDER BY breed DESC;

-- Retrieve Approved Adoption Form Responses
SELECT *
FROM  pet_adoption_form
WHERE status = 'Approved';

-- Retrieve Messages
SELECT pa.name AS Adopter, pp.name AS Provider, m.message, m.date AS Date
FROM pet_adopters pa
JOIN messages m ON pa.adopterid = m.adopterid
JOIN pet_providers pp ON pp.providerid = m.providerid
ORDER BY m.date DESC;

-- Retrieve Messages (Alternative)
SELECT * FROM PetAdopterMessages 
JOIN PetAdopters ON PetAdopterMessages.petadopterid = PetAdopters.petadopterid 
JOIN PetProviders ON PetAdopterMessages.petproviderid = PetProviders.petproviderid 
WHERE petadopterid = 'varpetadopterid' AND petproviderid = 'varpetproviderid' 
ORDER BY messagedate DESC;