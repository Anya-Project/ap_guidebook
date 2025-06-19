# QB-Guidebook: A Dynamic In-Game Manual Platform

![Made for QB-Core](https://img.shields.io/badge/Made%20for-QB--Core-blueviolet)
![Version](https://img.shields.io/badge/Version-1.0-blue)

An highly flexible guidebook and manual platform for FiveM servers running on the QB-Core framework. Designed to provide easily accessible and manageable information for both regular citizens and specific jobs like Police, EMS, and more.
![Preview 1](https://i.imgur.com/uJzmGR7.png) 
---

## Core Features

This is not just another guidebook script. It's a complete information system packed with advanced features:

*   **Dynamic Content:** All pages and categories are stored in the database, allowing for real-time updates without a script restart.
*   **In-Game Editor:** Authorized admins or department heads can add, edit, and delete categories and page content directly in-game using a Rich Text Editor (similar to Word/Google Docs).
*   **Multi-Manual System:** Create separate, access-controlled guidebooks for each job (`nonjob`, `police`, `ambulance`, etc.).
*   **Advanced Content Search:** A powerful search function that looks for keywords not just in category titles, but also within the **full content** of every page.
*   **Internal Wiki-Linking:** Create links between pages within the same guidebook using a simple `[[Category Name]]` format for a deeply connected knowledge base.
*   **Item Integration:** Each manual can be accessed by using a corresponding item from the inventory, enhancing immersion.
*   **Immersive Animations:** The player's character will physically hold and look at a tablet prop while the guidebook is open.
*   **Highly Configurable:** Nearly every aspect (titles, commands, items, edit permissions) can be easily configured in `config.lua`.
*   **Secure & Lightweight:** Built with server-side validation for all critical actions and optimized for high performance (`0.00ms` at idle).
*   **Export Ready:** Other server-side scripts can open the guidebook for a specific player via an export function.

---

## Dependencies

*   [qb-core](https://github.com/qbcore-framework/qb-core)
*   [oxmysql](https://github.com/overextended/oxmysql) (or a configured mysql-async)

---

## Installation

1.  **Download & Place:** Download or clone this repository and place the `qb_guidebook` folder into your server's `resources` directory.
2.  **Import SQL:** Execute the `guidebook.sql` file (or the query below) in your server's database. This will create the necessary `guidebook_pages` table.
    ```sql
    CREATE TABLE `guidebook_pages` (
      `id` INT(11) NOT NULL AUTO_INCREMENT,
      `book_type` VARCHAR(50) NOT NULL DEFAULT 'warga',
      `category` VARCHAR(100) NOT NULL,
      `content` LONGTEXT NOT NULL,
      `priority` INT(11) NOT NULL DEFAULT 10,
      `deletable` TINYINT(1) NOT NULL DEFAULT 1,
      PRIMARY KEY (`id`),
      UNIQUE KEY `book_type_category` (`book_type`,`category`)
    );
    ```
3.  **Add Items:** Open your main items file (usually `qb-core/shared.lua`) and add the required items. An example is provided in the `_items.lua` file in this repository.
4.  **Ensure Script:** Add `ensure qb_guidebook` to your `server.cfg` file. Make sure it is placed **after** `qb-core` and `oxmysql`.
5.  **Configure:** Set up the `config.lua` file to match your server's needs (job names, grade levels, etc.).
6.  **Restart Server:** Restart your server completely to ensure all changes are loaded correctly.

---

## Usage

### Default Commands
*   `/guidebook`: Opens the citizen's guide.
*   `/policemanual`: Opens the manual for the police job.
*   `/ambulancemanual`: Opens the manual for the ambulance job.
*   ...and so on, as configured.

## For Developers (Exports)

You can open the guidebook from other server-side scripts using an export.

```lua
-- Example: Opening the mechanic manual directly to the "Price List" page for player with source '1'
exports['qb_guidebook']:openBookForPlayer(1, 'mechanic', 'Daftar Harga')
```
*   **Param 1:** `targetSource` (number) - The player's source ID.
*   **Param 2:** `bookType` (string) - The type of book to open (e.g., 'warga', 'police').
*   **Param 3:** `categoryName` (string, optional) - The name of the category to open directly.

---
