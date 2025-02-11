
Species Table
SpeciesID: A unique identifier for each species (Primary Key).
CommonName: The common name of the species, which may vary in length.
ScientificName: The scientific classification name for the species, also varying in length.
Habitat: The typical habitat where the species can be found, limited by character count.
Venomous: A boolean indicator that specifies whether the species is venomous or not.

Snakes Table
SnakeID: A unique identifier for each snake (Primary Key).
SpeciesID: A foreign key that links each snake to its corresponding species in the Species table.
Length: The length of the snake, measured in meters, which may require a decimal point.
Age: The age of the snake in years, represented as a whole number.
Color: A description of the snake’s color, limited by character count.

Sightings Table
SightingID: A unique identifier for each sighting (Primary Key).
SnakeID: A foreign key linking each sighting to a specific snake in the Snakes table.
Location: The location where the snake was sighted, which may vary in length.
SightingDate: The date when the sighting occurred.
Observer: The name of the person who observed the sighting, with a character limit.

ConservationStatus Table
StatusID: A unique identifier for each conservation status record (Primary Key).
SpeciesID: A foreign key linking the conservation status to the corresponding species in the Species table.
Status: A description of the conservation status of the species, which may vary in length.
LastUpdated: The date when the conservation status was last updated.

