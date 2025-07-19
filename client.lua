local markers = {
    {
        positions = {
            vector3(-1034.39, -2727.55, 13.76), -- Position | Posizione del marker
            vector3(-266.6036, -968.7652, 31.2247) -- Position 2 | Posizione del marker 2
        },
        textureDict = "marker", -- File .ytd Name | Nome del file .ytd
        textureName = "docs", -- Image Name in the .ytd | Nome dell'immagine nel file .ytd
        config = {
            scale = vector3(0.5, 0.5, 1.0), -- Scale of the marker | Scala del marker
            rotation = vector3(90.0, 180.0, 0.0), -- Rotation of the marker | Rotazione del marker
            color = {r = 255, g = 255, b = 255, a = 255}, -- Color of the marker | Colore del marker
            bobUpAndDown = false, -- Whether the marker bobs up and down | Se il marker si muove su e giù
            faceCamera = true, -- Whether the marker faces the player | Se il marker guarda verso il giocatore
            rotate = 2, -- Rotation speed of the marker | Velocità di rotazione del marker
            drawOnEnts = false -- Whether the marker is drawn on entities | Se il marker è disegnato sugli oggetti
        }
    },
    {
        positions = {
            vector3(465.1465, -998.5970, 30.7228)
        },
        textureDict = "marker",
        textureName = "vestito",
        config = {
            scale = vector3(1.2, 1.2, 1.0),
            rotation = vector3(90.0, 180.0, 0.0),
            color = {r = 255, g = 255, b = 255, a = 255},
            bobUpAndDown = false,
            faceCamera = true,
            rotate = 2,
            drawOnEnts = false
        }
    }
    -- Add more markers here following the same pattern. | Aggiungi altri marker qui seguendo lo stesso schema.
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for _, marker in ipairs(markers) do
            if not HasStreamedTextureDictLoaded(marker.textureDict) then
                RequestStreamedTextureDict(marker.textureDict, true)
                while not HasStreamedTextureDictLoaded(marker.textureDict) do
                    Wait(1)
                end
            end
            
            -- Itera su tutte le posizioni del marker
            for _, pos in ipairs(marker.positions) do
                -- Usa le configurazioni personalizzate per ogni marker
                local config = marker.config
                DrawMarker(
                    9, pos.x, pos.y, pos.z, 
                    0.0, 0.0, 0.0, 
                    config.rotation.x, config.rotation.y, config.rotation.z, 
                    config.scale.x, config.scale.y, config.scale.z, 
                    config.color.r, config.color.g, config.color.b, config.color.a, 
                    config.bobUpAndDown, config.faceCamera, config.rotate, 
                    config.drawOnEnts, marker.textureDict, marker.textureName, false
                )
            end
        end
    end
end)
