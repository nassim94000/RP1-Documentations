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
    email VARCHAR(255) UNIQUE NOT NULL,
    fonction ENUM('operationnel', 'chef de projet', 'ressources humaines') NOT NULL,
    mdp VARCHAR(255) NOT NULL
);

CREATE TABLE tache (
    id_tache INT AUTO_INCREMENT PRIMARY KEY,
    id_planning INT NOT NULL,
    libelle VARCHAR(100) NOT NULL,
    description TEXT,
    date_debut DATETIME NOT NULL,
    date_fin DATETIME NOT NULL,
    importance ENUM('faible', 'moyenne', 'forte') NOT NULL,
    statut ENUM('en cours', 'fait', 'en retard') NOT NULL,
);

CREATE TABLE planning (
    id_utilisateur INT NOT NULL,
    id_tache INT NOT NULL,
    PRIMARY KEY (id_tache, id_utilisateur),
    --CRER LES CLEES ETRANGERE--
    --ON DELETE CASCADE POUR SIMPLIFIER LA SUPRESSION--
    FOREIGN KEY (id_tache) REFERENCES tache(id_tache) ON DELETE CASCADE,
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur) ON DELETE CASCADE
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
    PRIMARY KEY (id_groupe, id_utilisateur),
    --CRER LES CLEES ETRANGERE--
    --ON DELETE CASCADE POUR SUPPRIMER UN UTILISATEUR DE CES GROUPE SI CETTE UTILISATEUR N'EXISTE PLUS--
    FOREIGN KEY (id_groupe) REFERENCES groupe(id_groupe) ON DELETE CASCADE,
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur) ON DELETE CASCADE
);

-- UTILISATEURS --
INSERT INTO utilisateur (nom, prenom, email, fonction, mdp) VALUES ('BEN BOUBAKER', 'Nassim', 'nassim.benboubaker@monlycee.net', 'ressources humaines', 'azerty');
INSERT INTO utilisateur (nom, prenom, email, fonction, mdp) VALUES ('PICHEGRU', 'Raphaël', 'raphael.pichegru@monlycee.net', 'chef de projet', 'azerty');
INSERT INTO utilisateur (nom, prenom, email, fonction, mdp) VALUES ('DOGO', 'Mélina', 'melina.dogo@monlycee.net', 'operationnel', 'azerty');







