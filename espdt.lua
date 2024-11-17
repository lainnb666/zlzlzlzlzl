local function initializeESP(enable)
    if enable then
        _G.Eeeeeeeee= {}
        local function createESP(instance, name, color)
            local billboard = Instance.new("BillboardGui")
            billboard.Parent = game:GetService("CoreGui")
            billboard.AlwaysOnTop = true
            billboard.Size = UDim2.new(0, 100, 0, 50)
            billboard.Adornee = instance
            billboard.MaxDistance = 2000
            
            local frame = Instance.new("Frame", billboard)
            frame.AnchorPoint = Vector2.new(0.5, 0.5)
            frame.BackgroundColor3 = color
            frame.Size = UDim2.new(0, 8, 0, 8)
            frame.Position = UDim2.new(0.5, 0, 0.5, 0)
            Instance.new("UICorner", frame).CornerRadius = UDim.new(1, 0)
            Instance.new("UIStroke", frame)

            local textLabel = Instance.new("TextLabel", billboard)
            textLabel.AnchorPoint = Vector2.new(0.5, 0.5)
            textLabel.BackgroundTransparency = 1
            textLabel.TextColor3 = color
            textLabel.Size = UDim2.new(1, 0, 0, 20)
            textLabel.Position = UDim2.new(0.5, 0, 0.7, 0)
            textLabel.Text = name
            Instance.new("UIStroke", textLabel)

            task.spawn(function()
                while billboard do
                    if not billboard.Adornee or not billboard.Adornee:IsDescendantOf(workspace) then
                        billboard:Destroy()
                        break
                    end
                    task.wait(1)
                end
            end)
        end

        local function monitorItems()
            for _, item in pairs(workspace:GetDescendants()) do
                if item:IsA("Model") and item.Name == "workspace.Folder.Coin" then
                    createESP(item, "金币", Color3.fromRGB(50, 10, 255))
                end
            end

            workspace.DescendantAdded:Connect(function(item)
                if item:IsA("Model") and item.Name == "workspace.Folder.KillNPC" then
                    createESP(item, "怪物", Color3.fromRGB(50, 10, 255))
                end
            end)
        end

        monitorItems()
        table.insert(_G.Eeeeeeeee, { items = {} })

    else
        if _G.Eeeeeeeee then
            for _, instance in pairs(_G.Eeeeeeeee) do
                for _, v in pairs(instance.items) do
                    if v and v.delete then
                        v.delete()
                    end
                end
            end
            _G.Eeeeeeeee = nil
        end
    end
end