--[[ 
    Advanced Guidebook Script for QBCore Framework
    version: 1.0.0
    author: AnyaProject
    Discord: https://discord.gg/8jHxpRxyFr
]]--

Config = {}

-- Set to 'true' to enable the command, 'false' to disable it.
Config.EnableCommands = { 
    guidebook     = true,
    policebook    = true,
    ambulancebook = true,
    mechbook      = true,
    govbook       = true,
}

-- Set to 'true' to enable item usage, 'false' to disable it.
Config.EnableItems = {
    guidebook              = true,
    police_manual_book     = true,
    ambulance_manual_book  = true,
    mechanic_manual_book   = true,
    government_manual_book = true,
}

-- Set the title that will appear in the UI for each guidebook.
Config.BookTitles = {
    warga      = "City Citizen Guidebook",
    police     = "Police S.O.P.",
    ambulance  = "Medical Protocols", 
    mechanic   = "Mechanic Procedures",
    government = "Government Rulebook",
}

-- Define the minimum job grade allowed to edit each guidebook.
Config.EditPermissions = {
    ['police']     = 4, -- Example: Only grade 4 and above (e.g., Chief of Police) can edit
    ['ambulance']  = 3, -- Example: Only grade 3 and above (e.g., Director)
    ['mechanic']   = 2, -- Example: Only grade 2 and above (e.g., Head Mechanic)
    ['government'] = 2,
}

-- Define which admin groups have access to all features.
Config.AdminGroups = {
    ['admin']      = true,
    ['superadmin'] = true,
    ['god']        = true,
}