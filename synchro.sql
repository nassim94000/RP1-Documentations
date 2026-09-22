DROP DATABASE IF EXISTS synchro;
DROP USER IF EXISTS 'johndoe'@'localhost';

CREATE DATABASE synchro;
CREATE USER 'johndoe'@'localhost' IDENTIFIED BY 'azerty';
GRANT ALL PRIVILEGES ON synchro.* TO 'johndoe'@'localhost';
FLUSH PRIVILEGES;

USE synchro;

CREATE TABLE utilisateur (
    id_utilisateur INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL, -- verification email
    fonction VARCHAR(30) CHECK (fonction IN ('operationnel', 'chef de projet', 'ressources humaines')) NOT NULL,
    mdp VARCHAR(255) NOT NULL
);

CREATE TABLE tache (
    id_tache INT AUTO_INCREMENT PRIMARY KEY,
    id_utilisateur INT NOT NULL,
    libelle VARCHAR(100) NOT NULL,
    description TEXT,
    date_debut DATETIME NOT NULL,
    date_fin DATETIME NOT NULL,
    importance VARCHAR(10) CHECK (importance IN ('faible', 'moyen', 'fort')) NOT NULL,
    statut VARCHAR(20) CHECK (statut IN ('en cours', 'fait', 'en retard')) NOT NULL,
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur) ON DELETE CASCADE -- suppression simplifiée
);

CREATE TABLE groupe (
    id_groupe INT AUTO_INCREMENT PRIMARY KEY,
    nom_groupe VARCHAR(100) NOT NULL,
    description_groupe VARCHAR(500)
);

CREATE TABLE groupe_membre (
    id_groupe INT NOT NULL,
    id_utilisateur INT NOT NULL,
    date_inscription DATE NOT NULL DEFAULT (CURRENT_DATE),
    est_admin BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (id_groupe, id_utilisateur), --  création de la primaires avec les deux clés étrangéres
    FOREIGN KEY (id_groupe) REFERENCES groupe(id_groupe) ON DELETE CASCADE, -- suppression simplifiée
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur) ON DELETE CASCADE -- suppression simplifiée
);
