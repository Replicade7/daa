local Leaf = {}
local selectedPart = "1"
local fileNameInput = ""
local configs = {}
local configFolder = "LeafConfigs"

if not isfolder(configFolder) then
    makefolder(configFolder)
end

function Leaf:CreateWindow(config)
    local window = {}
    Leaf.MenuColorValue = Instance.new("Color3Value")
    Leaf.MenuColorValue.Value = Color3.fromRGB(config.Color[1], config.Color[2], config.Color[3])
    Leaf.colorElements = {}
    Leaf.toggles = {}
    Leaf.settings = {}

    Leaf.MenuColorValue.Changed:Connect(function()
        for _, item in ipairs(Leaf.colorElements) do
            item.element[item.property] = Leaf.MenuColorValue.Value
        end
        for _, toggleData in ipairs(Leaf.toggles) do
            if toggleData.state then
                toggleData.indicator.BackgroundColor3 = Leaf.MenuColorValue.Value
            end
        end
        if activeTab then
            activeTab.TabButton.ImageColor3 = Leaf.MenuColorValue.Value
        end
    end)
    
    local MiniMenu = Instance.new("ScreenGui")
    local MiniMenuFrame = Instance.new("Frame")
    local UICornerMini = Instance.new("UICorner")
    local ImageMiniMenu = Instance.new("ImageLabel")
    local Bmenu = Instance.new("TextButton")
    
    MiniMenu.Name = "MiniMenu"
    MiniMenu.Parent = game:GetService("CoreGui")
    MiniMenu.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    MiniMenuFrame.Name = "MiniMenu"
    MiniMenuFrame.Parent = MiniMenu
    MiniMenuFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MiniMenuFrame.BorderSizePixel = 0
    MiniMenuFrame.Position = UDim2.new(0.442, 0, 0.065, 0)
    MiniMenuFrame.Size = UDim2.new(0, 50, 0, 50)
    
    UICornerMini.CornerRadius = UDim.new(0, 4)
    UICornerMini.Parent = MiniMenuFrame
    
    ImageMiniMenu.Name = "ImageMiniMenu"
    ImageMiniMenu.Parent = MiniMenuFrame
    ImageMiniMenu.BackgroundTransparency = 1
    ImageMiniMenu.Position = UDim2.new(0.14, 0, 0.14, 0)
    ImageMiniMenu.Size = UDim2.new(0, 35, 0, 35)
    ImageMiniMenu.Image = "rbxassetid://"..config.LogoID
    ImageMiniMenu.ImageColor3 = Leaf.MenuColorValue.Value
    table.insert(Leaf.colorElements, {element = ImageMiniMenu, property = "ImageColor3"})
    
    Bmenu.Name = "Bmenu"
    Bmenu.Parent = MiniMenuFrame
    Bmenu.BackgroundTransparency = 1
    Bmenu.Size = UDim2.new(0, 50, 0, 50)
    Bmenu.Font = Enum.Font.SourceSans
    Bmenu.Text = ""
    Bmenu.TextTransparency = 1

    local ScreenGui = Instance.new("ScreenGui")
    local MenuFrame = Instance.new("Frame")
    local Mainframe = Instance.new("Frame")
    local UICornerMain = Instance.new("UICorner")
    local MainframeUIStroke = Instance.new("UIStroke")
    local TopBar = Instance.new("Frame")
    local UICornerTop = Instance.new("UICorner")
    local TopBarUIStroke = Instance.new("UIStroke")
    local TextLabel = Instance.new("TextLabel")
    
    ScreenGui.Name = "MainMenu"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Enabled = false
    
    MenuFrame.Name = "Menu"
    MenuFrame.Parent = ScreenGui
    MenuFrame.BackgroundTransparency = 1
    MenuFrame.Position = UDim2.new(0.361, 0, 0.178, 0)
    MenuFrame.Size = UDim2.new(0, 200, 0, 239)
    
    Mainframe.Name = "MainFrame"
    Mainframe.Parent = MenuFrame
    Mainframe.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Mainframe.Position = UDim2.new(-0.001, 0, 0.160, 0)
    Mainframe.Size = UDim2.new(0, 200, 0, 200)
    
    UICornerMain.CornerRadius = UDim.new(0, 4)
    UICornerMain.Parent = Mainframe
    
    MainframeUIStroke.Name = "MainframeUIStroke"
    MainframeUIStroke.Parent = Mainframe
    MainframeUIStroke.Color = Leaf.MenuColorValue.Value
    MainframeUIStroke.Thickness = 2
    table.insert(Leaf.colorElements, {element = MainframeUIStroke, property = "Color"})
    
    TopBar.Name = "TopBar"
    TopBar.Parent = Mainframe
    TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TopBar.Position = UDim2.new(0, 0, -0.2, 0)
    TopBar.Size = UDim2.new(0, 200, 0, 30)
    
    UICornerTop.CornerRadius = UDim.new(0, 4)
    UICornerTop.Parent = TopBar
    
    TopBarUIStroke.Name = "TopBarUIStroke"
    TopBarUIStroke.Parent = TopBar
    TopBarUIStroke.Color = Leaf.MenuColorValue.Value
    TopBarUIStroke.Thickness = 2
    table.insert(Leaf.colorElements, {element = TopBarUIStroke, property = "Color"})
    
    TextLabel.Parent = TopBar
    TextLabel.BackgroundTransparency = 1
    TextLabel.Position = UDim2.new(0.05, 0, 0, 0)
    TextLabel.Size = UDim2.new(0, 120, 0, 30)
    TextLabel.Font = Enum.Font.GothamBold
    TextLabel.Text = config.Name
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextSize = 15
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left

    local allTabs = {}
    local activeTab
    local allDropdowns = {}
    local allColorPickers = {}
    
    local function setActiveTab(tab)
        if activeTab then
            activeTab.ScrollingFrame.Visible = false
            activeTab.TabButton.ImageColor3 = Color3.fromRGB(130, 130, 130)
        end
        activeTab = tab
        activeTab.ScrollingFrame.Visible = true
        activeTab.TabButton.ImageColor3 = Leaf.MenuColorValue.Value
        
        for _, dropdown in ipairs(allDropdowns) do
            dropdown.Visible = false
        end
        for _, picker in ipairs(allColorPickers) do
            picker.Visible = false
        end
    end

    local function updateConfigDropdown()
        local configFiles = listfiles(configFolder)
        local configNames = {}
        for _, file in ipairs(configFiles) do
            local name = file:match(".-([^\\]+)%.json$")
            if name then
                table.insert(configNames, name)
            end
        end
        return configNames
    end

    function window:CreateTab(props)
        local tab = {}
        local TabButton = Instance.new("ImageButton")
        local UICornerTab = Instance.new("UICorner")
        
        TabButton.Name = "Tab"..#allTabs+1
        TabButton.Parent = TopBar
        TabButton.BackgroundTransparency = 1
        TabButton.Position = UDim2.new(0.64 + (#allTabs * 0.11), 0, 0.04, 0)
        TabButton.Size = UDim2.new(0, 25, 0, 25)
        TabButton.Image = props.Image
        TabButton.ImageColor3 = props.Opened and Leaf.MenuColorValue.Value or Color3.fromRGB(130, 130, 130)
        
        UICornerTab.CornerRadius = UDim.new(0, 4)
        UICornerTab.Parent = TabButton
        
        local ScrollingFrame = Instance.new("ScrollingFrame")
        ScrollingFrame.Parent = Mainframe
        ScrollingFrame.Active = true
        ScrollingFrame.BackgroundTransparency = 1
        ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
        ScrollingFrame.Visible = props.Opened
        ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        ScrollingFrame.ScrollBarThickness = 3
        
        tab.TabButton = TabButton
        tab.ScrollingFrame = ScrollingFrame
        tab.nextPosition = 10
        
        function tab:Button(props)
            local ButtonFrame = Instance.new("Frame")
            local UICornerBtn = Instance.new("UICorner")
            local Indicator = Instance.new("Frame")
            local UICornerInd = Instance.new("UICorner")
            local NameButton = Instance.new("TextLabel")
            local TextButton = Instance.new("TextButton")
            
            ButtonFrame.Parent = self.ScrollingFrame
            ButtonFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            ButtonFrame.Size = UDim2.new(0.85, 0, 0, 40)
            ButtonFrame.Position = UDim2.new(0.5, -85, 0, self.nextPosition)
            
            UICornerBtn.CornerRadius = UDim.new(0, 4)
            UICornerBtn.Parent = ButtonFrame
            
            Indicator.Parent = ButtonFrame
            Indicator.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Indicator.Position = UDim2.new(1, -9, 0.2, 0)
            Indicator.Size = UDim2.new(0, 5, 0, 23)
            
            UICornerInd.CornerRadius = UDim.new(0, 4)
            UICornerInd.Parent = Indicator
            
            NameButton.Parent = ButtonFrame
            NameButton.BackgroundTransparency = 1
            NameButton.Position = UDim2.new(0.04, 0, 0, 0)
            NameButton.Size = UDim2.new(0.8, 0, 1, 0)
            NameButton.Font = Enum.Font.GothamBold
            NameButton.Text = props.Title
            NameButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            NameButton.TextSize = 16
            NameButton.TextXAlignment = Enum.TextXAlignment.Left
            
            TextButton.Parent = ButtonFrame
            TextButton.BackgroundTransparency = 1
            TextButton.Size = UDim2.new(1, 0, 1, 0)
            TextButton.Text = ""
            
            local clickCount = 0
            local runService = game:GetService("RunService")
            
            TextButton.MouseButton1Click:Connect(function()
                clickCount = clickCount + 1
                local currentClick = clickCount
                
                Indicator.BackgroundColor3 = Leaf.MenuColorValue.Value
                
                if props.Callback then pcall(props.Callback) end
                
                local startTime = os.clock()
                while os.clock() - startTime < (props.Active or 0.5) do
                    runService.Heartbeat:Wait()
                end
                
                if clickCount == currentClick then
                    Indicator.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                end
            end)
            
            self.nextPosition = self.nextPosition + 45
            self.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, self.nextPosition + 10)
        end

        function tab:DeButton(props)
            local DeButtonFrame = Instance.new("Frame")
            local UICornerDeBtn = Instance.new("UICorner")
            local NameButton = Instance.new("TextLabel")
            local TextButton = Instance.new("TextButton")
            
            DeButtonFrame.Parent = self.ScrollingFrame
            DeButtonFrame.BackgroundColor3 = Leaf.MenuColorValue.Value
            table.insert(Leaf.colorElements, {element = DeButtonFrame, property = "BackgroundColor3"})
            DeButtonFrame.Size = UDim2.new(0.85, 0, 0, 40)
            DeButtonFrame.Position = UDim2.new(0.5, -85, 0, self.nextPosition)
            
            UICornerDeBtn.CornerRadius = UDim.new(0, 4)
            UICornerDeBtn.Parent = DeButtonFrame
            
            NameButton.Parent = DeButtonFrame
            NameButton.BackgroundTransparency = 1
            NameButton.Size = UDim2.new(1, 0, 1, 0)
            NameButton.Font = Enum.Font.GothamBold
            NameButton.Text = props.Title
            NameButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            NameButton.TextSize = 25
            
            TextButton.Parent = DeButtonFrame
            TextButton.BackgroundTransparency = 1
            TextButton.Size = UDim2.new(1, 0, 1, 0)
            TextButton.Text = ""
            
            TextButton.MouseButton1Click:Connect(function()
                if props.Callback then pcall(props.Callback) end
            end)
            
            self.nextPosition = self.nextPosition + 45
            self.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, self.nextPosition + 10)
        end

        function tab:Toggle(props)
            local ToggleFrame = Instance.new("Frame")
            local UICornerTog = Instance.new("UICorner")
            local Indicator = Instance.new("Frame")
            local UICornerInd = Instance.new("UICorner")
            local Circle = Instance.new("Frame")
            local UICornerCir = Instance.new("UICorner")
            local NameButton = Instance.new("TextLabel")
            local TextButton = Instance.new("TextButton")
            
            ToggleFrame.Parent = self.ScrollingFrame
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            ToggleFrame.Size = UDim2.new(0.85, 0, 0, 40)
            ToggleFrame.Position = UDim2.new(0.5, -85, 0, self.nextPosition)
            
            UICornerTog.CornerRadius = UDim.new(0, 4)
            UICornerTog.Parent = ToggleFrame
            
            Indicator.Parent = ToggleFrame
            Indicator.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Indicator.Position = UDim2.new(0.684, 0, 0.25, 0)
            Indicator.Size = UDim2.new(0, 45, 0, 20)
            
            UICornerInd.CornerRadius = UDim.new(0, 4)
            UICornerInd.Parent = Indicator
            
            Circle.Parent = Indicator
            Circle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            Circle.Size = UDim2.new(0, 15, 0, 15)
            Circle.Position = UDim2.new(0.05, 0, 0.1, 0)
            
            UICornerCir.CornerRadius = UDim.new(1, 0)
            UICornerCir.Parent = Circle
            
            NameButton.Parent = ToggleFrame
            NameButton.BackgroundTransparency = 1
            NameButton.Position = UDim2.new(0.04, 0, 0, 0)
            NameButton.Size = UDim2.new(0.6, 0, 1, 0)
            NameButton.Font = Enum.Font.GothamBold
            NameButton.Text = props.Title
            NameButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            NameButton.TextSize = 16
            NameButton.TextXAlignment = Enum.TextXAlignment.Left
            
            TextButton.Parent = ToggleFrame
            TextButton.BackgroundTransparency = 1
            TextButton.Size = UDim2.new(1, 0, 1, 0)
            TextButton.Text = ""
            
            local state = props.Default or false
            local toggleData = {
                state = state,
                indicator = Indicator,
                name = props.Title
            }
            table.insert(Leaf.toggles, toggleData)
            Leaf.settings[props.Title] = state
            
            local tweenService = game:GetService("TweenService")
            
            local function updateToggle()
                if state then
                    tweenService:Create(Circle, TweenInfo.new(0.2), {Position = UDim2.new(0.6, 0, 0.1, 0)}):Play()
                    tweenService:Create(Indicator, TweenInfo.new(0.2), {BackgroundColor3 = Leaf.MenuColorValue.Value}):Play()
                    tweenService:Create(Circle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                else
                    tweenService:Create(Circle, TweenInfo.new(0.2), {Position = UDim2.new(0.05, 0, 0.1, 0)}):Play()
                    tweenService:Create(Indicator, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
                    tweenService:Create(Circle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
                end
            end
            
            updateToggle()
            
            TextButton.MouseButton1Click:Connect(function()
                state = not state
                toggleData.state = state
                Leaf.settings[props.Title] = state
                updateToggle()
                if props.Callback then pcall(props.Callback, state) end
            end)
            
            self.nextPosition = self.nextPosition + 45
            self.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, self.nextPosition + 10)
        end

        function tab:Slider(props)
            local min = props.Value.Min
            local max = props.Value.Max
            local increment = props.Value.Increment
            local default = props.Value.Default
            
            local SliderFrame = Instance.new("Frame")
            local UICornerSld = Instance.new("UICorner")
            local SliderName = Instance.new("TextLabel")
            local Fill = Instance.new("Frame")
            local UICornerFill = Instance.new("UICorner")
            local Progress = Instance.new("Frame")
            local UICornerProg = Instance.new("UICorner")
            local Snumber = Instance.new("TextLabel")
            
            SliderFrame.Parent = self.ScrollingFrame
            SliderFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            SliderFrame.Size = UDim2.new(0.85, 0, 0, 50)
            SliderFrame.Position = UDim2.new(0.5, -85, 0, self.nextPosition)
            
            UICornerSld.CornerRadius = UDim.new(0, 4)
            UICornerSld.Parent = SliderFrame
            
            SliderName.Parent = SliderFrame
            SliderName.BackgroundTransparency = 1
            SliderName.Position = UDim2.new(0.04, 0, 0, 0)
            SliderName.Size = UDim2.new(0.5, 0, 0.5,  Catholic: CreateWindow({ Name = "Leaf", Color = { 255, 255, 255 }, LogoID = "1234567890" })

return window
end

return Leaf
