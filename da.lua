local Leaf = {}

function Leaf:CreateWindow(config)
    local window = {}
    Leaf.MenuColorValue = Instance.new("Color3Value")
    Leaf.MenuColorValue.Value = Color3.fromRGB(config.Color[1], config.Color[2], config.Color[3])
    Leaf.colorElements = {}
    Leaf.activeTab = nil
    Leaf.activeToggles = {}
    
    Leaf.MenuColorValue.Changed:Connect(function()
        for _, item in ipairs(Leaf.colorElements) do
            item.element[item.property] = Leaf.MenuColorValue.Value
        end
        if Leaf.activeTab then
            Leaf.activeTab.TabButton.ImageColor3 = Leaf.MenuColorValue.Value
        end
        for _, toggle in pairs(Leaf.activeToggles) do
            toggle.Indicator.BackgroundColor3 = Leaf.MenuColorValue.Value
            toggle.Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
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
    local allDropdowns = {}
    local allColorPickers = {}
    
    local function setActiveTab(tab)
        if Leaf.activeTab then
            Leaf.activeTab.ScrollingFrame.Visible = false
            Leaf.activeTab.TabButton.ImageColor3 = Color3.fromRGB(130, 130, 130)
        end
        Leaf.activeTab = tab
        Leaf.activeTab.ScrollingFrame.Visible = true
        Leaf.activeTab.TabButton.ImageColor3 = Leaf.MenuColorValue.Value
        
        for _, dropdown in ipairs(allDropdowns) do
            dropdown.Visible = false
        end
        for _, picker in ipairs(allColorPickers) do
            picker.Visible = false
        end
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
consume            self.nextPosition = self.nextPosition + 45
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
            local toggleData = {Indicator = Indicator, Circle = Circle}
            local tweenService = game:GetService("TweenService")
            
            local function updateToggle()
                if state then
                    tweenService:Create(Circle, TweenInfo.new(0.2), {Position = UDim2.new(0.6, 0, 0.1, 0)}):Play()
                    tweenService:Create(Indicator, TweenInfo.new(0.2), {BackgroundColor3 = Leaf.MenuColorValue.Value}):Play()
                    tweenService:Create(Circle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                    Leaf.activeToggles[toggleData] = toggleData
                else
                    tweenService:Create(Circle, TweenInfo.new(0.2), {Position = UDim2.new(0.05, 0, 0.1, 0)}):Play()
                    tweenService:Create(Indicator, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
                    tweenService:Create(Circle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
                    Leaf.activeToggles[toggleData] = nil
                end
            end
            
            updateToggle()
            
            TextButton.MouseButton1Click:Connect(function()
                state = not state
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
            SliderName.Size = UDim2.new(0.5, 0, 0.5, 0)
            SliderName.Font = Enum.Font.GothamBold
            SliderName.Text = props.Title
            SliderName.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderName.TextSize = 16
            SliderName.TextXAlignment = Enum.TextXAlignment.Left
            
            Fill.Parent = SliderFrame
            Fill.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
            Fill.Position = UDim2.new(0.04, 0, 0.6, 0)
            Fill.Size = UDim2.new(0.92, 0, 0, 10)
            
            UICornerFill.CornerRadius = UDim.new(0, 4)
            UICornerFill.Parent = Fill
            
            Progress.Parent = Fill
            Progress.BackgroundColor3 = Leaf.MenuColorValue.Value
            table.insert(Leaf.colorElements, {element = Progress, property = "BackgroundColor3"})
            Progress.Size = UDim2.new(0, 0, 1, 0)
            
            UICornerProg.CornerRadius = UDim.new(0, 4)
            UICornerProg.Parent = Progress
            
            Snumber.Parent = SliderFrame
            Snumber.BackgroundTransparency = 1
            Snumber.Position = UDim2.new(0.54, 0, 0, 0)
            Snumber.Size = UDim2.new(0.4, 0, 0.5, 0)
            Snumber.Font = Enum.Font.GothamBold
            Snumber.Text = tostring(default)
            Snumber.TextColor3 = Color3.fromRGB(255, 255, 255)
            Snumber.TextSize = 16
            Snumber.TextXAlignment = Enum.TextXAlignment.Right
            
            local currentValue = default
            local dragging = false
            
            local function updateSlider(value)
                value = math.clamp(value, min, max)
                value = math.floor(value / increment + 0.5) * increment
                currentValue = value
                
                local percent = (currentValue - min) / (max - min)
                Progress.Size = UDim2.new(percent, 0, 1, 0)
                Snumber.Text = tostring(currentValue)
                
                if props.Callback then pcall(props.Callback, currentValue) end
            end
            
            local function updateValueFromPosition(position)
                local fillAbsolute = Fill.AbsolutePosition
                local fillSize = Fill.AbsoluteSize
                local relativeX = math.clamp(position.X - fillAbsolute.X, 0, fillSize.X)
                local percent = relativeX / fillSize.X
                local value = min + (max - min) * percent
                updateSlider(value)
            end
            
            local function handleInput(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    updateValueFromPosition(input.Position)
                end
            end
            
            local function endInput(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end
            
            Fill.InputBegan:Connect(handleInput)
            Fill.InputEnded:Connect(endInput)
            
            game:GetService("UserInputService").InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    updateValueFromPosition(input.Position)
                end
            end)
            
            updateSlider(default)
            self.nextPosition = self.nextPosition + 55
            self.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, self.nextPosition + 10)
        end
        
        function tab:Section(props)
            local SectionFrame = Instance.new("Frame")
            local UICornerSec = Instance.new("UICorner")
            local SectionTitle = Instance.new("TextLabel")
            local Underline = Instance.new("Frame")
            
            SectionFrame.Parent = self.ScrollingFrame
            SectionFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            SectionFrame.Size = UDim2.new(0.85, 0, 0, 25)
            SectionFrame.Position = UDim2.new(0.5, -85, 0, self.nextPosition)
            
            UICornerSec.CornerRadius = UDim.new(0, 4)
            UICornerSec.Parent = SectionFrame
            
            SectionTitle.Parent = SectionFrame
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Size = UDim2.new(1, 0, 1, 0)
            SectionTitle.Font = Enum.Font.GothamBold
            SectionTitle.Text = props.Title
            SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SectionTitle.TextSize = 16
            
            Underline.Parent = SectionFrame
            Underline.BackgroundColor3 = Leaf.MenuColorValue.Value
            table.insert(Leaf.colorElements, {element = Underline, property = "BackgroundColor3"})
            Underline.Position = UDim2.new(0, 0, 1, -2)
            Underline.Size = UDim2.new(1, 0, 0, 2)
            
            self.nextPosition = self.nextPosition + 30
            self.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, self.nextPosition + 10)
        end
        
        function tab:CreateDropdown(props)
            local DropdownFrame = Instance.new("Frame")
            local UICornerDrop = Instance.new("UICorner")
            local Dropdownname = Instance.new("TextLabel")
            local TextButton = Instance.new("TextButton")
            local Info = Instance.new("TextButton")
            local UICornerInfo = Instance.new("UICorner")
            local DropdownList = Instance.new("Frame")
            local UICornerList = Instance.new("UICorner")
            local ScrollingFrameList = Instance.new("ScrollingFrame")
            local UIListLayout = Instance.new("UIListLayout")
            
            DropdownFrame.Parent = self.ScrollingFrame
            DropdownFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            DropdownFrame.Size = UDim2.new(0.85, 0, 0, 40)
            DropdownFrame.Position = UDim2.new(0.5, -85, 0, self.nextPosition)
            
            UICornerDrop.CornerRadius = UDim.new(0, 4)
            UICornerDrop.Parent = DropdownFrame
            
            Dropdownname.Parent = DropdownFrame
            Dropdownname.BackgroundTransparency = 1
            Dropdownname.Position = UDim2.new(0.04, 0, 0, 0)
            Dropdownname.Size = UDim2.new(0.5, 0, 1, 0)
            Dropdownname.Font = Enum.Font.GothamBold
            Dropdownname.Text = props.Name
            Dropdownname.TextColor3 = Color3.fromRGB(255, 255, 255)
            Dropdownname.TextSize = 16
            Dropdownname.TextXAlignment = Enum.TextXAlignment.Left
            
            TextButton.Parent = DropdownFrame
            TextButton.BackgroundTransparency = 1
            TextButton.Size = UDim2.new(1, 0, 1, 0)
            TextButton.Text = ""
            
            Info.Parent = DropdownFrame
            Info.BackgroundColor3 = Leaf.MenuColorValue.Value
            table.insert(Leaf.colorElements, {element = Info, property = "BackgroundColor3"})
            Info.Position = UDim2.new(0.7, 0, 0.2, 0)
            Info.Size = UDim2.new(0.25, 0, 0.6, 0)
            Info.Font = Enum.Font.GothamBold
            Info.Text = props.CurrentOption
            Info.TextColor3 = Color3.fromRGB(255, 255, 255)
            Info.TextSize = 14
            
            UICornerInfo.CornerRadius = UDim.new(0, 4)
            UICornerInfo.Parent = Info
            
            DropdownList.Parent = MenuFrame
            DropdownList.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            DropdownList.Size = UDim2.new(0.85, 0, 0, 150)
            DropdownList.Visible = false
            DropdownList.ZIndex = 2
            
            UICornerList.CornerRadius = UDim.new(0, 4)
            UICornerList.Parent = DropdownList
            
            ScrollingFrameList.Parent = DropdownList
            ScrollingFrameList.Active = true
            ScrollingFrameList.BackgroundTransparency = 1
            ScrollingFrameList.Size = UDim2.new(1, 0, 1, 0)
            ScrollingFrameList.CanvasSize = UDim2.new(0, 0, 0, 0)
            ScrollingFrameList.ScrollBarThickness = 3
            ScrollingFrameList.ZIndex = 2
            
            UIListLayout.Parent = ScrollingFrameList
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Padding = UDim.new(0, 5)
            
            local function createOption(option)
                local OptionFrame = Instance.new("Frame")
                local UICornerOpt = Instance.new("UICorner")
                local OptionText = Instance.new("TextLabel")
                local OptionButton = Instance.new("TextButton")
                
                OptionFrame.Parent = ScrollingFrameList
                OptionFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                OptionFrame.Size = UDim2.new(1, 0, 0, 25)
                OptionFrame.ZIndex = 2
                
                UICornerOpt.CornerRadius = UDim.new(0, 4)
                UICornerOpt.Parent = OptionFrame
                
                OptionText.Parent = OptionFrame
                OptionText.BackgroundTransparency = 1
                OptionText.Size = UDim2.new(1, 0, 1, 0)
                OptionText.Font = Enum.Font.GothamBold
                OptionText.Text = option
                OptionText.TextColor3 = Leaf.MenuColorValue.Value
                table.insert(Leaf.colorElements, {element = OptionText, property = "TextColor3"})
                OptionText.TextSize = 14
                OptionText.ZIndex = 2
                
                OptionButton.Parent = OptionFrame
                OptionButton.BackgroundTransparency = 1
                OptionButton.Size = UDim2.new(1, 0, 1, 0)
                OptionButton.Text = ""
                OptionButton.ZIndex = 2
                
                OptionButton.MouseButton1Click:Connect(function()
                    Info.Text = option
                    props.Callback(option)
                    DropdownList.Visible = false
                end)
            end
            
            for _, option in ipairs(props.Options) do
                createOption(option)
            end
            
            ScrollingFrameList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
            
            local isOpen = false
            
            TextButton.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                if isOpen then
                    for _, dropdown in ipairs(allDropdowns) do
                        dropdown.Visible = false
                    end
                    local buttonAbsolutePos = DropdownFrame.AbsolutePosition
                    local menuAbsolutePos = MenuFrame.AbsolutePosition
                    local relativeX = buttonAbsolutePos.X - menuAbsolutePos.X
                    local relativeY = buttonAbsolutePos.Y - menuAbsolutePos.Y + DropdownFrame.AbsoluteSize.Y
                    DropdownList.Position = UDim2.new(0, relativeX, 0, relativeY)
                end
                DropdownList.Visible = isOpen
            end)
            
            table.insert(allDropdowns, DropdownList)
            self.nextPosition = self.nextPosition + 45
            self.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, self.nextPosition + 10)
        end
        
        function tab:CreateColorPicker(props)
            local Name = props.Name
            local Color = props.Color
            local Callback = props.Callback
            
            local ColorPickerFrame = Instance.new("Frame")
            local UICornerCP = Instance.new("UICorner")
            local NameLabel = Instance.new("TextLabel")
            local ColorIndicator = Instance.new("Frame")
            local UICornerCI = Instance.new("UICorner")
            local PickButton = Instance.new("TextButton")
            
            ColorPickerFrame.Parent = self.ScrollingFrame
            ColorPickerFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            ColorPickerFrame.Size = UDim2.new(0.85, 0, 0, 40)
            ColorPickerFrame.Position = UDim2.new(0.5, -85, 0, self.nextPosition)
            
            UICornerCP.CornerRadius = UDim.new(0, 4)
            UICornerCP.Parent = ColorPickerFrame
            
            NameLabel.Parent = ColorPickerFrame
            NameLabel.BackgroundTransparency = 1
            NameLabel.Position = UDim2.new(0.04, 0, 0, 0)
            NameLabel.Size = UDim2.new(0.6, 0, 1, 0)
            NameLabel.Font = Enum.Font.GothamBold
            NameLabel.Text = Name
            NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            NameLabel.TextSize = 16
            NameLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            ColorIndicator.Parent = ColorPickerFrame
            ColorIndicator.BackgroundColor3 = Color
            ColorIndicator.Position = UDim2.new(0.8, 0, 0.18, 0)
            ColorIndicator.Size = UDim2.new(0, 25, 0, 25)
            
            UICornerCI.CornerRadius = UDim.new(0, 4)
            UICornerCI.Parent = ColorIndicator
            
            PickButton.Parent = ColorPickerFrame
            PickButton.BackgroundTransparency = 1
            PickButton.Size = UDim2.new(1, 0, 1, 0)
            PickButton.Text = ""
            
            local ChangeColor = Instance.new("Frame")
            ChangeColor.Parent = ScreenGui
            ChangeColor.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            ChangeColor.Size = UDim2.new(0, 159, 0, 180)
            ChangeColor.Visible = false
            ChangeColor.ZIndex = 5
            
            local TopBarCP = Instance.new("Frame")
            TopBarCP.Name = "TopBarColorPicker"
            TopBarCP.Parent = ChangeColor
            TopBarCP.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            TopBarCP.Size = UDim2.new(1, 0, 0, 30)
            TopBarCP.Position = UDim2.new(0,0,0,0)
            
            local UICornerTopBarCP = Instance.new("UICorner")
            UICornerTopBarCP.CornerRadius = UDim.new(0,4)
            UICornerTopBarCP.Parent = TopBarCP
            
            local TopBarTitle = Instance.new("TextLabel")
            TopBarTitle.Parent = TopBarCP
            TopBarTitle.BackgroundTransparency = 1
            TopBarTitle.Size = UDim2.new(1,0,1,0)
            TopBarTitle.Font = Enum.Font.GothamBold
            TopBarTitle.Text = "Color Picker"
            TopBarTitle.TextColor3 = Color3.new(1,1,1)
            TopBarTitle.TextSize = 14
            
            local UIStroke = Instance.new("UIStroke")
            UIStroke.Parent = ChangeColor
            UIStroke.Thickness = 2
            UIStroke.Color = Leaf.MenuColorValue.Value
            table.insert(Leaf.colorElements, {element = UIStroke, property = "Color"})
            
            local ColorCanvas = Instance.new("Frame")
            ColorCanvas.Parent = ChangeColor
            ColorCanvas.BackgroundTransparency = 1
            ColorCanvas.BorderSizePixel = 0
            ColorCanvas.Position = UDim2.new(0.041, 0, 0.222, 0)
            ColorCanvas.Size = UDim2.new(0, 125, 0, 100)
            
            local HueSlider = Instance.new("Frame")
            HueSlider.Parent = ChangeColor
            HueSlider.BorderSizePixel = 0
            HueSlider.Position = UDim2.new(0.9, 0, 0.222, 0)
            HueSlider.Size = UDim2.new(0, 6, 0, 135)
            
            local HueSelector = Instance.new("Frame")
            HueSelector.Parent = HueSlider
            HueSelector.AnchorPoint = Vector2.new(0.5, 0.5)
            HueSelector.BorderSizePixel = 0
            HueSelector.Size = UDim2.new(0, 15, 0, 15)
            HueSelector.BackgroundColor3 = Color3.new(1, 1, 1)
            HueSelector.ZIndex = 10
            
            local UICornerHue = Instance.new("UICorner")
            UICornerHue.CornerRadius = UDim.new(1, 0)
            UICornerHue.Parent = HueSelector
            
            local UIStrokeHue = Instance.new("UIStroke")
            UIStrokeHue.Parent = HueSelector
            UIStrokeHue.Thickness = 1
            UIStrokeHue.Color = Color3.new(1, 1, 1)
            
            local ColorSelector = Instance.new("Frame")
            ColorSelector.Parent = ColorCanvas
            ColorSelector.AnchorPoint = Vector2.new(0.5, 0.5)
            ColorSelector.BorderSizePixel = 0
            ColorSelector.Size = UDim2.new(0, 15, 0, 15)
            ColorSelector.BackgroundTransparency = 1
            ColorSelector.ZIndex = 10
            
            local UICornerSel = Instance.new("UICorner")
            UICornerSel.CornerRadius = UDim.new(1, 0)
            UICornerSel.Parent = ColorSelector
            
            local UIStrokeSel = Instance.new("UIStroke")
            UIStrokeSel.Parent = ColorSelector
            UIStrokeSel.Thickness = 2
            UIStrokeSel.Color = Color3.new(1, 1, 1)
            
            local ApplyButton = Instance.new("TextButton")
            ApplyButton.Parent = ChangeColor
            ApplyButton.BackgroundColor3 = Leaf.MenuColorValue.Value
            table.insert(Leaf.colorElements, {element = ApplyButton, property = "BackgroundColor3"})
            ApplyButton.Position = UDim2.new(0.449, 0, 0.805, 0)
            ApplyButton.Size = UDim2.new(0, 60, 0, 27)
            ApplyButton.Font = Enum.Font.GothamBold
            ApplyButton.Text = "Apply"
            ApplyButton.TextColor3 = Color3.new(1, 1, 1)
            ApplyButton.TextSize = 14
            ApplyButton.ZIndex = 5
            
            local UICornerApply = Instance.new("UICorner")
            UICornerApply.CornerRadius = UDim.new(0, 4)
            UICornerApply.Parent = ApplyButton
            
            local CancelButton = Instance.new("TextButton")
            CancelButton.Parent = ChangeColor
            CancelButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            CancelButton.Position = UDim2.new(0.041, 0, 0.805, 0)
            CancelButton.Size = UDim2.new(0, 60, 0, 27)
            CancelButton.Font = Enum.Font.GothamBold
            CancelButton.Text = "Cancel"
            CancelButton.TextColor3 = Color3.new(1, 1, 1)
            CancelButton.TextSize = 14
            CancelButton.ZIndex = 5
            
            local UICornerCancel = Instance.new("UICorner")
            UICornerCancel.CornerRadius = UDim.new(0, 4)
            UICornerCancel.Parent = CancelButton
            
            local MainGradient = Instance.new("UIGradient")
            MainGradient.Rotation = 0
            MainGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.fromHSV(0, 1, 1))
            }
            
            local ValueGradient = Instance.new("UIGradient")
            ValueGradient.Transparency = NumberSequence.new{
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(1, 0)
            }
            ValueGradient.Rotation = 90
            
            local HueGradient = Instance.new("UIGradient")
            HueGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromHSV(1, 1, 1)),
                ColorSequenceKeypoint.new(0.17, Color3.fromHSV(0.83, 1, 1)),
                ColorSequenceKeypoint.new(0.33, Color3.fromHSV(0.67, 1, 1)),
                ColorSequenceKeypoint.new(0.5, Color3.fromHSV(0.5, 1, 1)),
                ColorSequenceKeypoint.new(0.67, Color3.fromHSV(0.33, 1, 1)),
                ColorSequenceKeypoint.new(0.83, Color3.fromHSV(0.17, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.fromHSV(0, 1, 1))
            }
            HueGradient.Rotation = 90
            
            local MainGradientFrame = Instance.new("Frame")
            MainGradientFrame.Size = UDim2.new(1, 0, 1, 0)
            MainGradientFrame.BackgroundTransparency = 0
            MainGradientFrame.Parent = ColorCanvas
            MainGradient.Parent = MainGradientFrame
            
            local ValueGradientFrame = Instance.new("Frame")
            ValueGradientFrame.Size = UDim2.new(1, 0, 1, 0)
            ValueGradientFrame.BackgroundTransparency = 0
            ValueGradientFrame.BackgroundColor3 = Color3.new(0, 0, 0)
            ValueGradientFrame.Parent = ColorCanvas
            ValueGradient.Parent = ValueGradientFrame
            
            HueGradient.Parent = HueSlider
            
            local currentHue, currentSat, currentVal = 0, 1, 1
            local originalColor = Color
            local draggingHue = false
            local draggingColor = false
            local draggingCP = false
            local dragStartCP, startPosCP
            
            local function updateColor()
                local newColor = Color3.fromHSV(currentHue, currentSat, currentVal)
                ColorIndicator.BackgroundColor3 = newColor
                Leaf.MenuColorValue.Value = newColor
            end
            
            local function updateHueSelector(input)
                local y = (input.Position.Y - HueSlider.AbsolutePosition.Y) / HueSlider.AbsoluteSize.Y
                y = math.clamp(y, 0, 1)
                currentHue = 1 - y
                HueSelector.Position = UDim2.new(0.5, 0, y, 0)
                HueSelector.BackgroundColor3 = Color3.fromHSV(currentHue, 1, 1)
                MainGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                    ColorSequenceKeypoint.new(1, Color3.fromHSV(currentHue, 1, 1))
                }
                updateColor()
            end
            
            local function updateColorSelector(input)
                local x = (input.Position.X - ColorCanvas.AbsolutePosition.X) / ColorCanvas.AbsoluteSize.X
                local y = (input.Position.Y - ColorCanvas.AbsolutePosition.Y) / ColorCanvas.AbsoluteSize.Y
                x = math.clamp(x, 0, 1)
                y = math.clamp(y, 0, 1)
                currentSat = x
                currentVal = 1 - y
                ColorSelector.Position = UDim2.new(x, 0, y, 0)
                updateColor()
            end
            
            HueSlider.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    draggingHue = true
                    updateHueSelector(input)
                end
            end)
            
            ColorCanvas.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    draggingColor = true
                    updateColorSelector(input)
                end
            end)
            
            TopBarCP.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    draggingCP = true
                    dragStartCP = input.Position
                    startPosCP = ChangeColor.Position
                end
            end)
            
            game:GetService("UserInputService").InputChanged:Connect(function(input)
                if draggingHue and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    updateHueSelector(input)
                elseif draggingColor and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    updateColorSelector(input)
                elseif draggingCP and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    local delta = input.Position - dragStartCP
                    ChangeColor.Position = UDim2.new(
                        startPosCP.X.Scale,
                        startPosCP.X.Offset + delta.X,
                        startPosCP.Y.Scale,
                        startPosCP.Y.Offset + delta.Y
                    )
                end
            end)
            
            game:GetService("UserInputService").InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    draggingHue = false
                    draggingColor = false
                    draggingCP = false
                end
            end)
            
            ApplyButton.MouseButton1Click:Connect(function()
                ChangeColor.Visible = false
                Color = ColorIndicator.BackgroundColor3
                if Callback then
                    Callback(Color)
                end
            end)
            
            CancelButton.MouseButton1Click:Connect(function()
                ChangeColor.Visible = false
                ColorIndicator.BackgroundColor3 = originalColor
                Leaf.MenuColorValue.Value = originalColor
            end)
            
            PickButton.MouseButton1Click:Connect(function()
                for _, picker in ipairs(allColorPickers) do
                    picker.Visible = false
                end
                ChangeColor.Visible = not ChangeColor.Visible
                if ChangeColor.Visible then
                    originalColor = ColorIndicator.BackgroundColor3
                    local absPos = ColorPickerFrame.AbsolutePosition
                    ChangeColor.Position = UDim2.new(0, absPos.X, 0, absPos.Y + 45)
                    
                    currentHue, currentSat, currentVal = Color3.toHSV(originalColor)
                    
                    HueSelector.Position = UDim2.new(0.5, 0, 1 - currentHue, 0)
                    HueSelector.BackgroundColor3 = Color3.fromHSV(currentHue, 1, 1)
                    ColorSelector.Position = UDim2.new(currentSat, 0, 1 - currentVal, 0)
                    
                    MainGradient.Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                        ColorSequenceKeypoint.new(1, Color3.fromHSV(currentHue, 1, 1))
                    }
                end
            end)
            
            table.insert(allColorPickers, ChangeColor)
            self.nextPosition = self.nextPosition + 45
            self.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, self.nextPosition + 10)
        end
        
        function tab:Input(props)
            local InputFrame = Instance.new("Frame")
            local UICornerInp = Instance.new("UICorner")
            local NameLabel = Instance.new("TextLabel")
            local InputBox = Instance.new("TextBox")
            local UICornerInputBox = Instance.new("UICorner")
            
            InputFrame.Parent = self.ScrollingFrame
            InputFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            InputFrame.Size = UDim2.new(0.85, 0, 0, 40)
            InputFrame.Position = UDim2.new(0.5, -85, 0, self.nextPosition)
            
            UICornerInp.CornerRadius = UDim.new(0, 4)
            UICornerInp.Parent = InputFrame
            
            NameLabel.Parent = InputFrame
            NameLabel.BackgroundTransparency = 1
            NameLabel.Position = UDim2.new(0.04, 0, 0, 0)
            NameLabel.Size = UDim2.new(0.5, 0, 1, 0)
            NameLabel.Font = Enum.Font.GothamBold
            NameLabel.Text = props.Title
            NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            NameLabel.TextSize = 16
            NameLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            InputBox.Parent = InputFrame
            InputBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            InputBox.BorderSizePixel = 0
            InputBox.Position = UDim2.new(0.55, 0, 0.175, 0)
            InputBox.Size = UDim2.new(0.4, 0, 0.65, 0)
            InputBox.Font = Enum.Font.GothamBold
            InputBox.Text = props.Default or ""
            InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            InputBox.TextSize = 14
            InputBox.PlaceholderText = props.Placeholder or ""
            
            UICornerInputBox.CornerRadius = UDim.new(0, 4)
            UICornerInputBox.Parent = InputBox
            
            InputBox.FocusLost:Connect(function(enterPressed)
                if props.Callback then
                    pcall(props.Callback, InputBox.Text)
                end
            end)
            
            self.nextPosition = self.nextPosition + 45
            self.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, self.nextPosition + 10)
        end
        
        if props.Opened then
            Leaf.activeTab = tab
        else
            ScrollingFrame.Visible = false
        end
        
        TabButton.MouseButton1Click:Connect(function() setActiveTab(tab) end)
        table.insert(allTabs, tab)
        return tab
    end

    local UserInputService = game:GetService("UserInputService")
    
    local draggingMain, dragStartMain, startPosMain
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingMain = true
            dragStartMain = input.Position
            startPosMain = MenuFrame.Position
        end
    end)
    
    TopBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingMain = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if draggingMain and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStartMain
            MenuFrame.Position = UDim2.new(
                startPosMain.X.Scale, 
                startPosMain.X.Offset + delta.X,
                startPosMain.Y.Scale,
                startPosMain.Y.Offset + delta.Y
            )
        end
    end)
    
    local miniMenuDragging, miniMenuDragStart, miniMenuStartPos
    Bmenu.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            miniMenuDragging = true
            miniMenuDragStart = input.Position
            miniMenuStartPos = MiniMenuFrame.Position
        end
    end)
    
    Bmenu.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            miniMenuDragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if miniMenuDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - miniMenuDragStart
            MiniMenuFrame.Position = UDim2.new(
                miniMenuStartPos.X.Scale,
                miniMenuStartPos.X.Offset + delta.X,
                miniMenuStartPos.Y.Scale,
                miniMenuStartPos.Y.Offset + delta.Y
            )
        end
    end)
    
    Bmenu.MouseButton1Click:Connect(function()
        ScreenGui.Enabled = not ScreenGui.Enabled
    end)
    
    return window
end

return Leaf
