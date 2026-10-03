local v

local function fn()
	return loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
end

v = fn()
assert(type(v) == "table" and type(v.CreateWindow) == "function", "WindUI failed to load.")

local v2
v2 = v:CreateWindow({
	Title = "CAT HUB | Ride a Pet",
	Author = "CATJack.gg",
	Folder = "CATHUB_RideAPet",
	Icon = "rbxassetid://126031329785796",
	Theme = "Dark"
})

v2:Tag({ Title = "Ride A Pet", Icon = "paw-print", Color = Color3.fromHex("#10C550") })

local defaultTab
defaultTab = v2:Tab({ Name = "Farm", Title = "Farm", Icon = "wheat" })
local RunService, UserInputService, localPlayer, game_, activeEggs, tbl, v3, fn2, fn3, fn4
local fn5, tbl2, fn6, tbl3, fn_trackToggle

do
	local Players = game:GetService("Players")
	RunService = game:GetService("RunService")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local CoreGui = game:GetService("CoreGui")
	UserInputService = game:GetService("UserInputService")
	local CollectionService = game:GetService("CollectionService")
	localPlayer = Players.LocalPlayer
	game_ = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Game")
	activeEggs = ReplicatedStorage:WaitForChild("ServerData"):WaitForChild("ActiveEggs")

	local function fn7(arg)
		local ok, result = pcall(function()
			return require(arg())
		end)

		return ok and result or nil
	end

	tbl = {
		Eggs = fn7(function()
			return ReplicatedStorage.GameData.Eggs
		end),
		Pets = fn7(function()
			return ReplicatedStorage.GameData.Pets
		end),
		Foods = fn7(function()
			return ReplicatedStorage.GameData.Foods
		end),
		Shop = fn7(function()
			return ReplicatedStorage.GameData.Shop
		end),
		Rebirths = fn7(function()
			return ReplicatedStorage.GameData.Rebirths
		end),
		EggBaskets = fn7(function()
			return ReplicatedStorage.GameData.EggBaskets
		end),
		Mutations = fn7(function()
			return ReplicatedStorage.GameData.Mutations
		end),
	}

	local function fn8()
		if typeof(gethui) == "function" then
			local ok, result = pcall(gethui)
			if ok and typeof(result) == "Instance" then
				return result
			end
		end

		return CoreGui
	end

	v3 = fn8()
	local v4 = Random.new()
	local str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

	fn2 = function()
		local v5 = v4:NextInteger(12, 20)
		local v6 = table.create(v5)

		for i = 1, v5 do
			local v7 = v4:NextInteger(1, #str)
			v6[i] = string.sub("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789", v7, v7)
		end

		return table.concat(v6)
	end

	local tbl4 = {}

	fn3 = function(arg)
		table.insert(tbl4, arg)
	end

	local text = "All"

	fn4 = function(arg)
		if type(arg) ~= "table" then
			return arg
		end
		local value = rawget(arg, "Instance")
		if typeof(value) ~= "Instance" then
			return arg
		end
		local flag = false

		local function fn9(arg2)
			if flag then
				return
			end

			if arg2.Text == "None" then
				flag = true
				arg2.Text = text
				flag = false
			end
		end

		local function fn10(descendant)
			if not descendant:IsA("TextLabel") or descendant.Name ~= "Value" then
				return
			end
			fn9(descendant)

			local connection = descendant:GetPropertyChangedSignal("Text"):Connect(function()
				fn9(descendant)
			end)

			fn3(function()
				pcall(function()
					connection:Disconnect()
				end)
			end)
		end

		for _, descendant in ipairs(value:GetDescendants()) do
			fn10(descendant)
		end

		local connection = value.DescendantAdded:Connect(fn10)

		fn3(function()
			pcall(function()
				connection:Disconnect()
			end)
		end)

		return arg
	end

	local genv = typeof(getgenv) == "function" and getgenv() or _G
	local chilliHubRapCleanup = genv.ChilliHubRapCleanup

	if type(chilliHubRapCleanup) == "function" then
		pcall(chilliHubRapCleanup)
	end

	genv.ChilliHubRapCleanup = function()
		for i = #tbl4, 1, -1 do
			pcall(tbl4[i])
		end

		table.clear(tbl4)
	end

	fn5 = function(arg, arg2)
		if type(v.Notify) == "function" then
			pcall(v.Notify, v, { Title = arg, Content = arg2, Duration = 5 })
		end
	end

	local toggleStates = setmetatable({}, { __mode = "k" })

	fn_trackToggle = function(container, opts)
		local widget
		local originalCallback = opts.Callback
		opts.Callback = function(value)
			local state = value == true
			if widget then
				toggleStates[widget] = state
			end
			if originalCallback then
				originalCallback(value)
			end
		end
		widget = container:Toggle(opts)
		if toggleStates[widget] == nil then
			toggleStates[widget] = opts.Default == true
		end
		return widget
	end

	tbl2 = { Toggle = function(arg, arg2)
		if type(arg) ~= "table" then
			return arg2 == true
		end

		local state = toggleStates[arg]
		if type(state) == "boolean" then
			return state
		end

		local ok, result = pcall(function()
			local controller = arg._controller
			return type(controller) == "table" and type(controller.GetValue) == "function" and controller.GetValue()
		end)

		if ok and type(result) == "boolean" then
			return result
		end

		for _, v5 in ipairs({ "Get", "GetValue" }) do
			local ok2, result2 = pcall(function()
				return arg[v5]
			end)

			if ok2 and type(result2) == "function" then
				local ok3, result3 = pcall(result2, arg)
				if ok3 and type(result3) == "boolean" then
					return result3
				end
			end
		end

		return arg2 == true
	end }

	fn6 = function(arg)
		local tbl5 = {}

		if type(arg) == "table" then
			for k, v5 in pairs(arg) do
				if v5 == true and type(k) == "string" then
					tbl5[k] = true
				elseif type(v5) == "string" then
					tbl5[v5] = true
				end
			end
		end

		return tbl5
	end

	local tbl5 = { "Common", "Rare", "Epic", "Legendary", "Mythic", "Divine", "Ethereal" }

	-- New/event eggs (like the Volcanic Egg) can use a rarity name this list doesn't know about.
	-- Those used to rank as 0 and got skipped by Min Egg Rarity, so slot any unknown rarity in
	-- by its luck value instead.
	do
		local luckSum, luckCount = {}, {}

		if type(tbl.Eggs) == "table" then
			for _, egg in pairs(tbl.Eggs) do
				if type(egg) == "table" and egg.Rarity ~= nil then
					local name = tostring(egg.Rarity)
					luckSum[name] = (luckSum[name] or 0) + (tonumber(egg.Luck) or 0)
					luckCount[name] = (luckCount[name] or 0) + 1
				end
			end
		end

		local function avgLuck(name)
			return luckCount[name] and luckSum[name] / luckCount[name] or 0
		end

		local known = {}
		for _, name in ipairs(tbl5) do
			known[name] = true
		end

		local unknown = {}
		for name in pairs(luckCount) do
			if not known[name] then
				table.insert(unknown, name)
			end
		end
		table.sort(unknown, function(a, b)
			return avgLuck(a) < avgLuck(b)
		end)

		for _, name in ipairs(unknown) do
			local position = #tbl5 + 1
			for i, existing in ipairs(tbl5) do
				if avgLuck(existing) > avgLuck(name) then
					position = i
					break
				end
			end
			table.insert(tbl5, position, name)
		end
	end

	tbl3 = { RarityOrder = tbl5, RarityRank = {} }

	for i, v5 in ipairs(tbl5) do
		tbl3.RarityRank[v5] = i
	end

	tbl3.RarityChoices = { "Any" }

	for _, v5 in ipairs(tbl5) do
		table.insert(tbl3.RarityChoices, v5)
	end

	tbl3.KnownRarities = {}
	for _, v5 in ipairs(tbl5) do
		tbl3.KnownRarities[v5] = true
	end

	-- Called whenever an egg's rarity name isn't one we've seen before - covers eggs added to
	-- the game after this hub started, or ones tbl.Eggs hadn't loaded yet at startup. Slots the
	-- name in as top rank (new eggs are usually the good ones) rather than leaving it unranked.
	tbl3.RegisterRarity = function(arg)
		local name = tostring(arg)

		if tbl3.KnownRarities[name] then
			return tbl3.RarityRank[name]
		end

		tbl3.KnownRarities[name] = true
		table.insert(tbl3.RarityOrder, name)
		local rank = #tbl3.RarityOrder
		tbl3.RarityRank[name] = rank
		table.insert(tbl3.RarityChoices, name)

		if type(fn5) == "function" then
			pcall(fn5, "New Egg Rarity Found", name .. " wasn't in the rarity list yet, added it as top priority.")
		end

		return rank
	end

	tbl3.RarityColors = {
		Common = Color3.fromRGB(214, 218, 228),
		Rare = Color3.fromRGB(96, 170, 255),
		Epic = Color3.fromRGB(190, 110, 255),
		Legendary = Color3.fromRGB(255, 196, 66),
		Mythic = Color3.fromRGB(255, 82, 90),
		Divine = Color3.fromRGB(255, 240, 150),
		Ethereal = Color3.fromRGB(125, 225, 255),
	}

	tbl3.FlySpeed = 2000
	tbl3.Status = "Idle"
	tbl3.Movement = { Owner = nil }
	local v5 = nil

	tbl3.Character = function()
		return localPlayer.Character
	end

	tbl3.Humanoid = function()
		local character = localPlayer.Character
		character = character and character:FindFirstChildOfClass("Humanoid")
		if character and character.Health > 0 then
			return character
		end
		return nil
	end

	tbl3.Root = function()
		local character = localPlayer.Character
		character = character and character:FindFirstChild("HumanoidRootPart")
		if character and character:IsDescendantOf(workspace) then
			return character
		end
		return nil
	end

	tbl3.Plot = function()
		if v5 and v5.Parent then
			local data = v5:FindFirstChild("Data")
			data = data and data:FindFirstChild("Owner")
			if data and data.Value == localPlayer then
				return v5
			end
		end

		v5 = nil
		local plots = workspace:FindFirstChild("Plots")
		if not plots then
			return nil
		end

		for _, child in ipairs(plots:GetChildren()) do
			local data = child:FindFirstChild("Data")
			data = data and data:FindFirstChild("Owner")
			if data and data.Value == localPlayer then
				v5 = child
				return child
			end
		end

		return nil
	end

	tbl3.PlotBase = function()
		local baseplate = tbl3.Plot()
		baseplate = baseplate and baseplate:FindFirstChild("Baseplate")
		if baseplate and baseplate:IsA("BasePart") then
			return baseplate
		end
		return nil
	end

	tbl3.PlotTop = function()
		local v6 = tbl3.PlotBase()
		if not v6 then
			return nil
		end
		return v6.Position + Vector3.new(0, v6.Size.Y / 2, 0)
	end

	tbl3.RandomPlotPoint = function(arg, arg2, arg3)
		local v6 = tbl3.PlotBase()
		if not v6 then
			return nil
		end
		local n = math.max(1, v6.Size.X / 2 - arg)
		local n2 = math.max(1, v6.Size.Z / 2 - arg)
		local n3 = v6.Position.Y + v6.Size.Y / 2
		local v7 = nil

		for i = 1, 24 do
			local nextNumber = v4.NextNumber
			local vector = Vector3.new(v4:NextNumber(-n, n), 0, nextNumber(v4, -n2, n2))
			local v8 = v6.CFrame:PointToWorldSpace(vector)
			local vector2 = Vector3.new(v8.X, n3, v8.Z)
			local flag = true

			if arg2 then
				for _, v9 in ipairs(arg2) do
					if Vector3.new(v9.X - vector2.X, 0, v9.Z - vector2.Z).Magnitude < arg3 then
						flag = false
						break
					end
				end
			end

			if flag then
				return vector2
			end
			v7 = v7 or vector2
		end

		return v7
	end

	tbl3.Cash = function()
		local savedData = localPlayer:FindFirstChild("SavedData")
		savedData = savedData and savedData:FindFirstChild("Cash")
		return savedData and tonumber(savedData.Value) or 0
	end

	tbl3.Saved = function(arg)
		local savedData = localPlayer:FindFirstChild("SavedData")
		savedData = savedData and savedData:FindFirstChild(arg)
		return savedData and savedData.Value or nil
	end

	tbl3.Fire = function(arg, ...)
		local v6 = game_:FindFirstChild(arg)
		if not v6 or not v6:IsA("RemoteEvent") then
			return false
		end
		local v7 = table.pack(...)

		return pcall(function()
			v6:FireServer(table.unpack(v7, 1, v7.n))
		end)
	end

	tbl3.EggData = function(arg)
		local eggs = tbl.Eggs
		local flag = type(eggs) == "table" and eggs[tostring(arg)] or nil
		return type(flag) == "table" and flag or nil
	end

	tbl3.EggRank = function(arg)
		local v6 = tbl3.EggData(arg)
		-- An egg the game data doesn't know about is most likely a new event egg, so treat it as
		-- top rank instead of bottom so Min Egg Rarity never filters it out.
		if not v6 or v6.Rarity == nil then
			return #tbl3.RarityOrder
		end

		local name = tostring(v6.Rarity)
		return tbl3.RarityRank[name] or tbl3.RegisterRarity(name)
	end

	tbl3.EggRarity = function(arg)
		local v6 = tbl3.EggData(arg)
		return v6 and tostring(v6.Rarity) or "Common"
	end

	tbl3.EggLuck = function(arg)
		local v6 = tbl3.EggData(arg)
		return v6 and tonumber(v6.Luck) or 0
	end

	tbl3.PetData = function(arg)
		local pets = tbl.Pets
		local flag = type(pets) == "table" and pets[tostring(arg)] or nil
		return type(flag) == "table" and flag or nil
	end

	tbl3.MutationBonus = function(arg)
		local mutations = tbl.Mutations
		local flag = type(mutations) == "table" and arg and mutations[tostring(arg)] or nil
		return 1 + (type(flag) == "table" and tonumber(flag.StatMultiplier) or 0) / 100
	end

	tbl3.PetScore = function(arg, arg2, arg3)
		local v6 = tbl3.PetData(arg)
		return (v6 and tonumber(v6.Income) or 1) * math.max(tonumber(arg2) or 1, 0.1) * tbl3.MutationBonus(arg3)
	end

	tbl3.PetNameOf = function(arg)
		local attribute = arg:GetAttribute("PetName")
		if type(attribute) == "string" and attribute ~= "" then
			return attribute
		end
		return (string.gsub(arg.Name, "%s*%[.*$", ""))
	end

	tbl3.Tools = function(arg)
		local tbl6 = {}
		local backpack = localPlayer:FindFirstChildOfClass("Backpack")

		if backpack then
			for _, child in ipairs(backpack:GetChildren()) do
				if child:IsA("Tool") and CollectionService:HasTag(child, arg) then
					table.insert(tbl6, child)
				end
			end
		end

		local character = localPlayer.Character

		if character then
			for _, child in ipairs(character:GetChildren()) do
				if child:IsA("Tool") and CollectionService:HasTag(child, arg) then
					table.insert(tbl6, child)
				end
			end
		end

		return tbl6
	end
end

tbl3.Equip = function(arg)
	local v4 = tbl3.Humanoid()
	local character = localPlayer.Character
	if not v4 or not arg or not character then
		return false
	end

	if arg.Parent == character then
		return true
	end

	pcall(function()
		v4:EquipTool(arg)
	end)

	local n = os.clock() + 1

	while arg.Parent ~= character and os.clock() < n do
		RunService.Heartbeat:Wait()
	end

	return arg.Parent == character
end

tbl3.Unequip = function()
	local v4 = tbl3.Humanoid()

	if v4 then
		pcall(function()
			v4:UnequipTools()
		end)
	end
end

tbl3.BasketCount = function()
	local basket = localPlayer:FindFirstChild("Basket")
	return basket and #basket:GetChildren() or 0
end

tbl3.BasketCapacity = function()
	local EquippedEggBasket = tbl3.Saved("EquippedEggBasket")
	local eggBaskets = tbl.EggBaskets
	local flag = type(eggBaskets) == "table" and EquippedEggBasket and eggBaskets[tostring(EquippedEggBasket)] or nil
	local n = type(flag) == "table" and tonumber(flag.Capacity) or 1
	if n == math.huge or n > 50 then
		return 50
	end
	return math.max(1, n)
end

tbl3.BasketDeadline = function()
	local basket = localPlayer:FindFirstChild("Basket")
	local v4 = nil

	if basket then
		v4 = nil

		for _, child in ipairs(basket:GetChildren()) do
			local num = tonumber(child:GetAttribute("BreakAt"))

			if num and (v4 == nil or num < v4) then
				v4 = num
			end
		end
	end

	return v4
end

tbl3.Claim = function(owner)
	local movement = tbl3.Movement
	if movement.Owner == nil or movement.Owner == owner then
		movement.Owner = owner
		return true
	end
	return false
end

tbl3.Release = function(arg)
	if tbl3.Movement.Owner == arg then
		tbl3.Movement.Owner = nil
	end
end

do
	local tbl4 = {}

	local function setNoclip(arg)
		local character = localPlayer.Character
		if not character then
			return
		end

		for _, descendant in ipairs(character:GetDescendants()) do
			if descendant:IsA("BasePart") then
				if arg then
					if tbl4[descendant] == nil then
						tbl4[descendant] = descendant.CanCollide
					end

					descendant.CanCollide = false
				elseif tbl4[descendant] ~= nil then
					descendant.CanCollide = tbl4[descendant]
				end
			end
		end

		if not arg then
			table.clear(tbl4)
		end
	end

	tbl3.SetNoclip = setNoclip
	tbl3.CruiseHeight = 45

	tbl3.VoidDepth = 110
	tbl3.OverHeight = 250

	local function fn7(arg, arg2, opts)
		if Vector3.new(arg2.X - arg.X, 0, arg2.Z - arg.Z).Magnitude < 80 and math.abs(arg2.Y - arg.Y) < 30 then
			return { arg2 }
		end

		if opts and opts.Void then
			-- Dive under the map, travel sideways at a constant depth, only rise at the very end.
			local voidY = math.min(arg.Y, arg2.Y) - tbl3.VoidDepth
			voidY = math.max(voidY, workspace.FallenPartsDestroyHeight + 60)
			return {
				Vector3.new(arg.X, voidY, arg.Z),
				Vector3.new(arg2.X, voidY, arg2.Z),
				arg2,
			}
		end

		local cruiseHeight = (opts and opts.Over) and tbl3.OverHeight or tbl3.CruiseHeight
		local n = math.max(arg.Y, arg2.Y) + cruiseHeight
		local tbl5 = {}
		local vector = Vector3.new(arg.X, n, arg.Z)
		local vector2 = Vector3.new(arg2.X, n, arg2.Z)
		tbl5[1] = vector
		tbl5[2] = vector2
		tbl5[3] = arg2
		return tbl5
	end

	tbl3.TravelTime = function(arg, arg2, opts)
		local n = 0

		for _, v4 in ipairs(fn7(arg, arg2, opts)) do
			n += (v4 - arg).Magnitude
			arg = v4
		end

		return n / math.max((opts and opts.Speed) or tbl3.FlySpeed, 20)
	end

	tbl3.FlyTo = function(arg, arg2, arg3, opts)
		local v4 = tbl3.Root()
		if not v4 or typeof(arg) ~= "Vector3" then
			return false
		end
		local n = arg3 or 3
		if (v4.Position - arg).Magnitude <= n then
			return true
		end
		local startPosition = v4.Position
		local v5 = fn7(v4.Position, arg, opts)
		local n2 = os.clock() + tbl3.TravelTime(v4.Position, arg, opts) + 6
		local flySpeed = (opts and opts.Speed) or tbl3.FlySpeed
		setNoclip(true)

		local connection = RunService.Stepped:Connect(function()
			local character = localPlayer.Character
			if not character then
				return
			end

			for _, descendant in ipairs(character:GetDescendants()) do
				if descendant:IsA("BasePart") and descendant.CanCollide then
					descendant.CanCollide = false
				end
			end
		end)

		local n3 = 1
		local flag, v6

		while true do
			flag = false

			if not (os.clock() < n2) then
				break
			else
				if not (arg2 and arg2()) then
					local result = RunService.Heartbeat:Wait()
					v6 = tbl3.Root()

					if v6 then
						local flag2 = n3 == #v5
						local n4 = v5[n3] - v6.Position
						local magnitude = n4.Magnitude

						if magnitude <= (flag2 and n or 2) then
							if flag2 then
								flag = true
								break
							else
								n3 += 1
								continue
							end
						else
							local n5 = math.min(magnitude, math.max(flySpeed, 20) * result)
							local vector = Vector3.new(n4.X, 0, n4.Z)
							local cframe = vector.Magnitude > 0.1 and CFrame.lookAt(Vector3.zero, vector.Unit) or v6.CFrame.Rotation
							local nextPosition = v6.Position + n4.Unit * n5

							-- At high Tween Speed a single frame can jump well past what's
							-- already streamed in, which is what drops the character into
							-- the void. Pre-load terrain ahead of any big hop.
							if n5 > 60 then
								pcall(function()
									if typeof(workspace.RequestStreamAroundAsync) == "function" then
										workspace:RequestStreamAroundAsync(nextPosition, 16)
									end
								end)
							end

							pcall(function()
								v6.CFrame = CFrame.new(nextPosition) * cframe
								v6.AssemblyLinearVelocity = Vector3.zero
								v6.AssemblyAngularVelocity = Vector3.zero
							end)

							continue
						end
					end
				end

				break
			end
		end

		v6 = tbl3.Root()

		-- Fall-through safety: a big jump can still land the character below
		-- unloaded/missing terrain despite the streaming request above. Recover
		-- with the same anchor-and-reteleport trick InstantFlyTo uses.
		if v6 and v6.Position.Y < math.min(arg.Y, startPosition.Y) - 15 then
			local recoverTo = flag and arg or startPosition
			pcall(function()
				local wasAnchored = v6.Anchored
				v6.Anchored = true
				v6.AssemblyLinearVelocity = Vector3.zero
				v6.CFrame = CFrame.new(recoverTo)
				RunService.Heartbeat:Wait()
				v6.Anchored = wasAnchored
			end)
			v6 = tbl3.Root()
		end

		connection:Disconnect()
		setNoclip(false)
		v6 = tbl3.Root()
		local flag2

		if v6 then
			pcall(function()
				v6.AssemblyLinearVelocity = Vector3.zero
			end)

			if not ((v6.Position - arg).Magnitude <= n + 1) then
				flag2 = flag
			else
				flag2 = true
			end
		else
			flag2 = flag
		end

		return flag2
	end

	tbl3.InstantFlyTo = function(arg, arg2, arg3)
		local v4 = tbl3.Root()
		if not v4 or typeof(arg) ~= "Vector3" then
			return false
		end
		local n = arg3 or 3
		if (v4.Position - arg).Magnitude <= n then
			return true
		end
		if arg2 and arg2() then
			return false
		end

		setNoclip(true)

		local connection = RunService.Stepped:Connect(function()
			local character = localPlayer.Character
			if not character then
				return
			end

			for _, descendant in ipairs(character:GetDescendants()) do
				if descendant:IsA("BasePart") and descendant.CanCollide then
					descendant.CanCollide = false
				end
			end
		end)

		local wasAnchored = v4.Anchored

		local function teleportTo(position)
			local v5 = tbl3.Root()
			if not v5 then
				return
			end

			pcall(function()
				v5.Anchored = true
				v5.AssemblyLinearVelocity = Vector3.zero
				v5.AssemblyAngularVelocity = Vector3.zero
				v5.CFrame = CFrame.new(position)
			end)
		end

		teleportTo(arg)

		pcall(function()
			if typeof(workspace.RequestStreamAroundAsync) == "function" then
				workspace:RequestStreamAroundAsync(arg, 16)
			end
		end)

		-- Anchored while terrain around the destination streams in and physics settles,
		-- so gravity never gets a window to drag the character into unloaded/missing terrain.
		for _ = 1, 5 do
			if arg2 and arg2() then
				break
			end
			RunService.Heartbeat:Wait()
		end

		local v6 = tbl3.Root()

		-- Fall-through safety: if the root somehow ended up well below the target
		-- (unloaded terrain, a gap, whatever), re-teleport once more before releasing.
		if v6 and v6.Position.Y < arg.Y - 15 then
			teleportTo(arg)
			RunService.Heartbeat:Wait()
			v6 = tbl3.Root()
		end

		pcall(function()
			if v6 then
				v6.Anchored = wasAnchored
				v6.AssemblyLinearVelocity = Vector3.zero
				v6.AssemblyAngularVelocity = Vector3.zero
			end
		end)

		connection:Disconnect()
		setNoclip(false)

		if not v6 then
			return false
		end

		pcall(function()
			v6.AssemblyLinearVelocity = Vector3.zero
		end)

		return (v6.Position - arg).Magnitude <= n + 1
	end

	tbl3.FirePrompt = function(arg)
		if not arg or not arg:IsA("ProximityPrompt") then
			return false
		end

		if typeof(fireproximityprompt) == "function" then
			return pcall(fireproximityprompt, arg)
		end

		return pcall(function()
			arg:InputHoldBegin()
			task.wait(arg.HoldDuration + 0.1)
			arg:InputHoldEnd()
		end)
	end

	fn3(function()
		setNoclip(false)
	end)
end

local v4, v5, v6, tbl4

do
	local v7 = defaultTab:Section({ Title = "Farm Status" })
	local v8 = defaultTab:Section({ Title = "Auto Collect Eggs" })
	local v9 = defaultTab:Section({ Title = "Auto Plant & Hatch" })
	v4 = defaultTab:Section({ Title = "Auto Pets" })
	v5 = defaultTab:Section({ Title = "Auto Shop" })
	v6 = defaultTab:Section({ Title = "Auto Progress" })

	tbl4 = {
		Collect = nil,
		Plant = nil,
		Hatch = nil,
		Place = nil,
		Swap = nil,
		Feed = nil,
		Busy = false,
		Manual = {},
		Carried = {},
		Target = nil,
		TargetManual = false,
		Dropped = nil,
		LastPickupAt = 0,
		Relaying = false,
	}

	local v10 = v7:Paragraph({ Title = "Farm Status", Desc = "Idle" })
	local status = nil

	local connection = RunService.Heartbeat:Connect(function()
		if tbl3.Status ~= status then
			status = tbl3.Status

			if v10 then
				for _, setter in ipairs({ "SetDesc", "Set", "SetValue" }) do
					if type(v10[setter]) == "function" then
						local ok = pcall(v10[setter], v10, status)
						if ok then
							break
						end
					end
				end
			end
		end
	end)

	fn3(function()
		connection:Disconnect()
	end)

	local tbl5 = {}
	local tbl6 = {}

	if type(tbl.Eggs) == "table" then
		for k, egg in pairs(tbl.Eggs) do
			if type(egg) == "table" then
				local rarityName = egg.Rarity ~= nil and tostring(egg.Rarity) or nil
				table.insert(tbl6, {
					Name = k,
					Rank = rarityName and (tbl3.RarityRank[rarityName] or tbl3.RegisterRarity(rarityName)) or 0,
					Luck = tonumber(egg.Luck) or 0,
				})
			end
		end
	end

	table.sort(tbl6, function(arg, arg2)
		if arg.Rank ~= arg2.Rank then
			return arg.Rank > arg2.Rank
		end
		return arg.Luck > arg2.Luck
	end)

	for _, v11 in ipairs(tbl6) do
		table.insert(tbl5, v11.Name)
	end

	local tbl7 = { "Highest Luck", "Highest Rarity", "Nearest", "Farthest" }
	local n = 0
	local tbl8 = {}
	local str = tbl7[2]
	local tbl9 = {}
	local n2 = 3

	local function fn7(arg)
		local attribute = localPlayer:GetAttribute("CollectedEggs")
		return type(attribute) == "string" and attribute ~= "" and string.find(attribute, tostring(arg) .. ",", 1, true) ~= nil
	end

	local function fn8(arg)
		local tbl10 = {}
		local v11 = tbl3.PlotTop()
		local now = os.clock()

		for _, child in ipairs(activeEggs:GetChildren()) do
			local attribute = child:GetAttribute("Egg")
			local attribute2 = child:GetAttribute("Position")
			local attribute3 = child:GetAttribute("PrivateTo")
			local v12 = tbl9[child.Name]
			local flag = type(attribute) == "string" and typeof(attribute2) == "Vector3" and (attribute3 == nil or attribute3 == localPlayer.UserId)

			if flag then
				flag = not (v12 and v12 > now)
			end

			if flag and not fn7(attribute) then
				local v13 = tbl3.EggRank(attribute)

				if v13 >= n and (next(tbl8) == nil or tbl8[attribute]) then
					if (v11 and tbl3.TravelTime(attribute2, v11) or 0) < 20 - n2 - 2 then
						table.insert(tbl10, {
							Config = child,
							Name = attribute,
							Position = attribute2,
							Rank = v13,
							Luck = tbl3.EggLuck(attribute) * (tonumber(child:GetAttribute("Weight")) or 1),
							Distance = (attribute2 - arg).Magnitude,
						})
					end
				end
			end
		end

		table.sort(tbl10, function(arg2, arg3)
			if str == tbl7[3] then
				return arg2.Distance < arg3.Distance
			end

			if str == tbl7[4] then
				return arg2.Distance > arg3.Distance
			end

			if str == tbl7[2] then
				if arg2.Rank ~= arg3.Rank then
					return arg2.Rank > arg3.Rank
				end

				if arg2.Luck ~= arg3.Luck then
					return arg2.Luck > arg3.Luck
				end
				return arg2.Distance < arg3.Distance
			end

			if arg2.Luck ~= arg3.Luck then
				return arg2.Luck > arg3.Luck
			end
			return arg2.Distance < arg3.Distance
		end)

		return tbl10
	end

	local n3 = 250

	local function fn9(arg, arg2, arg3)
		local v11 = tbl3.Root()
		local basket = localPlayer:FindFirstChild("Basket")
		if not v11 or not basket then
			return
		end
		local v12 = arg.CFrame:PointToObjectSpace(v11.Position)
		local vector = Vector3.new(v12.X, 0, v12.Z)

		if vector.Magnitude < 1 then
			vector = Vector3.new(0, 0, 1)
		end

		local n4 = arg.Size.X / 2
		local n5 = arg.Size.Z / 2
		local unit = vector.Unit
		local n6 = unit / math.max(math.abs(unit.X) / (n4 + 20), math.abs(unit.Z) / (n5 + 20))
		local v13 = arg.CFrame:PointToWorldSpace(Vector3.new(n6.X, 0, n6.Z))
		local vector2 = Vector3.new(v13.X, arg2.Y + 4, v13.Z)

		if tbl4.StealMethod == "Instant" then
			tbl3.InstantFlyTo(vector2, arg3, 4)
		else
			tbl3.FlyTo(vector2, arg3, 4, { Speed = tbl4.ReturnSpeed })
		end

		local v14 = tbl3.Root()
		if not v14 or (v14.Position - vector2).Magnitude > 10 then
			return
		end
		tbl3.Status = "Re-picking eggs near base"
		local n7 = os.clock() + 0.3

		while os.clock() < n7 do
			local v15 = tbl3.Root()

			if v15 then
				pcall(function()
					local rotation = v15.CFrame.Rotation
					v15.CFrame = CFrame.new(vector2) * rotation
					v15.AssemblyLinearVelocity = Vector3.zero
				end)
			end

			RunService.Heartbeat:Wait()
		end

		local tbl10 = {}

		for _, child in ipairs(activeEggs:GetChildren()) do
			tbl10[child] = true
		end

		local tbl11 = {}
		local tbl12 = {}

		for _, child in ipairs(basket:GetChildren()) do
			local attribute = child:GetAttribute("Egg")

			if type(attribute) == "string" then
				table.insert(tbl12, attribute)
			end
		end

		tbl4.Relaying = true

		for _, v15 in ipairs(tbl12) do
			tbl3.Fire("BasketDrop", v15)
		end

		local n8 = os.clock() + 3

		while #tbl11 < #tbl12 and os.clock() < n8 do
			for _, child in ipairs(activeEggs:GetChildren()) do
				if not tbl10[child] and child:GetAttribute("OriginPosition") ~= nil and typeof(child:GetAttribute("Position")) == "Vector3" then
					tbl10[child] = true
					table.insert(tbl11, child)
				end
			end

			RunService.Heartbeat:Wait()
		end

		for _, v15 in ipairs(tbl11) do
			local attribute = v15:GetAttribute("Position")

			for i = 1, 3 do
				if v15.Parent ~= nil then
					if typeof(attribute) == "Vector3" then
						tbl3.FlyTo(attribute + Vector3.new(0, 3, 0), nil, 5)
					end

					local v16 = tbl3.BasketCount()
					tbl4.LastPickupAt = os.clock()
					tbl3.Fire("EggPickup", v15.Name)
					local n9 = os.clock() + 1.5

					while tbl3.BasketCount() == v16 and os.clock() < n9 do
						RunService.Heartbeat:Wait()
					end

					if not (v16 < tbl3.BasketCount()) then
						continue
					end
				end

				break
			end

			if v15.Parent ~= nil and not table.find(tbl4.Manual, v15.Name) then
				table.insert(tbl4.Manual, 1, v15.Name)
			end
		end

		tbl4.Relaying = false
	end

	tbl4.Deliver = function(arg)
		if tbl3.BasketCount() <= 0 then
			return true
		end
		local v11 = tbl3.PlotTop()
		local v12 = tbl3.PlotBase()
		if not v11 or not v12 then
			return false
		end
		tbl3.Status = "Bringing eggs home"
		local pickupPos = tbl3.Root()
		pickupPos = tbl4.PickupPos or pickupPos and pickupPos.Position

		-- Instant steal goes straight home: no drop-and-re-pick dance near the base,
		-- so the egg isn't dropped and there's no wasted time on its break timer.
		if tbl4.StealMethod ~= "Instant" and pickupPos and (pickupPos - v11).Magnitude > n3 then
			fn9(v12, v11, arg)
			tbl3.Status = "Bringing eggs home"
		end

		if tbl4.StealMethod == "Instant" then
			tbl3.InstantFlyTo(v11 + Vector3.new(0, 4, 0), arg, 4)
		else
			tbl3.FlyTo(v11 + Vector3.new(0, 4, 0), arg, 4, { Speed = tbl4.ReturnSpeed })
		end

		local n4 = os.clock() + 3

		while tbl3.BasketCount() > 0 and os.clock() < n4 do
			RunService.Heartbeat:Wait()
		end

		if tbl3.BasketCount() == 0 then
			table.clear(tbl4.Carried)
			tbl4.PickupPos = nil
		end

		return tbl3.BasketCount() == 0
	end

	local function fn10()
		while #tbl4.Manual > 0 do
			local v11 = activeEggs:FindFirstChild(tbl4.Manual[1])
			local attribute = v11 and v11:GetAttribute("Egg")
			local attribute2 = v11 and v11:GetAttribute("Position")
			local attribute3 = v11 and v11:GetAttribute("PrivateTo")
			if type(attribute) == "string" and typeof(attribute2) == "Vector3" and (attribute3 == nil or attribute3 == localPlayer.UserId) then
				return { Config = v11, Name = attribute, Position = attribute2, Manual = true }
			end
			table.remove(tbl4.Manual, 1)
		end

		return nil
	end

	local function fn11(arg)
		local v11 = table.find(tbl4.Manual, arg)

		if v11 then
			table.remove(tbl4.Manual, v11)
		end
	end

	tbl4.AutoPlan = function(arg)
		if not tbl2.Toggle(tbl4.Collect, false) then
			return {}
		end
		return fn8(arg)
	end

	tbl4.CollectStep = function(arg)
		if not tbl3.Root() then
			return false
		end
		local v11 = tbl3.BasketCapacity()
		local flag = false

		while tbl3.BasketCount() < v11 do
			if not arg() then
				local v12 = tbl3.BasketDeadline()
				local v13 = tbl3.PlotTop()
				local v14, v15, flag2, name, v16, flag3, v17, n4, flag4

				if v12 and v13 then
					local v18 = tbl3.Root()

					if not (v12 - workspace:GetServerTimeNow() - (v18 and tbl3.TravelTime(v18.Position, v13) or 0) < n2 + 4) then
						v14 = tbl3.Root()

						if v14 then
							v15 = fn10()
							flag2 = not v15 and tbl2.Toggle(tbl4.Collect, false)

							if flag2 then
								for _, v19 in ipairs(fn8(v14.Position)) do
									if not table.find(tbl4.Manual, v19.Config.Name) then
										v15 = v19
										break
									end
								end
							end

							if not v15 then
								if not flag then
									tbl3.Status = "No egg matches the filters"
								end

								break
							else
								name = v15.Config.Name
								tbl4.Target = name
								tbl4.TargetManual = v15.Manual == true
								tbl4.Dropped = nil
								tbl3.Status = string.format("Collecting %s", v15.Name)

								v16 = tbl3.FlyTo(v15.Position + Vector3.new(0, 3, 0), function()
									return arg() or v15.Config.Parent == nil or tbl4.Dropped == name
								end, 6, tbl4.RouteOpts())

								if tbl4.Dropped == name then
									tbl4.Target = nil
									tbl4.Dropped = nil
									continue
								else
									flag3 = v15.Config.Parent == nil and not v16

									if flag3 then
										fn11(name)
										tbl4.Target = nil
										continue
									elseif not v16 then
										tbl9[name] = os.clock() + 20
										fn11(name)
										tbl4.Target = nil
										break
									else
										v17 = tbl3.BasketCount()
										tbl4.LastPickupAt = os.clock()

										if v17 == 0 then
											tbl4.PickupPos = v15.Position
										end

										tbl3.Fire("EggPickup", name)
										n4 = os.clock() + 1.2

										while tbl3.BasketCount() == v17 do
											if os.clock() >= n4 then
												flag4 = v15.Config.Parent ~= nil or os.clock() >= n4 + 1.5
												if not flag4 then
													RunService.Heartbeat:Wait()
													continue
												end
											else
												RunService.Heartbeat:Wait()
												continue
											end

											break
										end

										fn11(name)
										tbl4.Target = nil

										if v17 < tbl3.BasketCount() then
											tbl4.Carried[name] = v15.Config
											flag = true
										else
											tbl9[name] = os.clock() + 20
										end

										continue
									end
								end
							end
						end
					end
				else
					v14 = tbl3.Root()

					if v14 then
						v15 = fn10()
						flag2 = not v15 and tbl2.Toggle(tbl4.Collect, false)

						if flag2 then
							for _, v18 in ipairs(fn8(v14.Position)) do
								if not table.find(tbl4.Manual, v18.Config.Name) then
									v15 = v18
									break
								end
							end
						end

						if not v15 then
							if not flag then
								tbl3.Status = "No egg matches the filters"
							end

							break
						else
							name = v15.Config.Name
							tbl4.Target = name
							tbl4.TargetManual = v15.Manual == true
							tbl4.Dropped = nil
							tbl3.Status = string.format("Collecting %s", v15.Name)

							v16 = tbl3.FlyTo(v15.Position + Vector3.new(0, 3, 0), function()
								return arg() or v15.Config.Parent == nil or tbl4.Dropped == name
							end, 6, tbl4.RouteOpts())

							if tbl4.Dropped == name then
								tbl4.Target = nil
								tbl4.Dropped = nil
								continue
							else
								flag3 = v15.Config.Parent == nil and not v16

								if flag3 then
									fn11(name)
									tbl4.Target = nil
									continue
								elseif not v16 then
									tbl9[name] = os.clock() + 20
									fn11(name)
									tbl4.Target = nil
									break
								else
									v17 = tbl3.BasketCount()
									tbl4.LastPickupAt = os.clock()

									if v17 == 0 then
										tbl4.PickupPos = v15.Position
									end

									tbl3.Fire("EggPickup", name)
									n4 = os.clock() + 1.2

									while tbl3.BasketCount() == v17 do
										if os.clock() >= n4 then
											flag4 = v15.Config.Parent ~= nil or os.clock() >= n4 + 1.5
											if not flag4 then
												RunService.Heartbeat:Wait()
												continue
											end
										else
											RunService.Heartbeat:Wait()
											continue
										end

										break
									end

									fn11(name)
									tbl4.Target = nil

									if v17 < tbl3.BasketCount() then
										tbl4.Carried[name] = v15.Config
										flag = true
									else
										tbl9[name] = os.clock() + 20
									end

									continue
								end
							end
						end
					end
				end
			end

			break
		end

		tbl4.Target = nil

		if tbl3.BasketCount() > 0 then
			tbl4.Deliver(nil)
		end

		return flag
	end

	tbl4.Collect = fn_trackToggle(v8, {
		Title = "Auto Collect Eggs",
		Default = false,
		Callback = function()
			tbl4.Wake()
		end,
	})

	tbl4.StealMethod = "Tween"
	tbl4.ReturnSpeed = 1976

	v8:Dropdown({
		Title = "Steal Method",
		Desc = "Tween flies home after stealing. Instant teleports straight back to your plot.",
		Values = { "Tween", "Instant" },
		Value = "Tween",
		Callback = function(arg)
			tbl4.StealMethod = tostring(arg) == "Instant" and "Instant" or "Tween"
		end,
	})

	tbl4.StealApproach = "Under Map"

	tbl4.RouteOpts = function()
		if tbl4.StealApproach == "Under Map" then
			return { Void = true }
		elseif tbl4.StealApproach == "Over Map" then
			return { Over = true }
		end

		return nil
	end

	v8:Dropdown({
		Title = "Steal Approach",
		Desc = "Under Map dives below the map and rises at the egg. Over Map flies high above. Normal flies the short arc.",
		Values = { "Normal", "Under Map", "Over Map" },
		Value = "Under Map",
		Callback = function(arg)
			local choice = tostring(arg)
			if choice == "Normal" or choice == "Over Map" then
				tbl4.StealApproach = choice
			else
				tbl4.StealApproach = "Under Map"
			end
		end,
	})

	v8:Dropdown({
		Title = "Min Egg Rarity",
		Values = tbl3.RarityChoices,
		Value = tbl3.RarityChoices[1],
		Callback = function(arg)
			n = tbl3.RarityRank[tostring(arg)] or 0
		end,
	})

	fn4(v8:Dropdown({
		Title = "Target Eggs",
		Values = tbl5,
		Multi = true,
		Callback = function(arg)
			tbl8 = fn6(arg)
		end,
	}))

	v8:Dropdown({
		Title = "Collect Priority",
		Values = tbl7,
		Value = tbl7[2],
		Callback = function(arg)
			str = tostring(arg)
		end,
	})

	v8:Slider({
		Title = "Travel Speed",
		Desc = "How fast you fly to each egg.",
		Step = 50,
		Value = {
			Min = 100,
			Max = 10000,
			Default = 2000,
		},
		Callback = function(arg)
			tbl3.FlySpeed = math.clamp(tonumber(arg) or 2000, 100, 10000)
		end,
	})

	v8:Slider({
		Title = "Fast Return Speed",
		Desc = "How fast you fly home when Steal Method is Tween. Instant teleports home instead.",
		Step = 50,
		Value = {
			Min = 100,
			Max = 10000,
			Default = 1976,
		},
		Callback = function(arg)
			tbl4.ReturnSpeed = math.clamp(tonumber(arg) or 1976, 100, 10000)
		end,
	})

	local n4 = 0
	local n5 = 0
	local n6 = 0

	local function fn12()
		local eggs = tbl3.Plot()
		eggs = eggs and eggs:FindFirstChild("Eggs")
		return eggs and eggs:GetChildren() or {}
	end

	local function fn13()
		local tbl10 = {}

		for _, v11 in ipairs(fn12()) do
			local ok, result = pcall(function()
				return v11:GetPivot().Position
			end)

			if ok then
				table.insert(tbl10, result)
			end
		end

		local pets = tbl3.Plot()
		pets = pets and pets:FindFirstChild("Pets")

		if pets then
			for _, child in ipairs(pets:GetChildren()) do
				local ok, result = pcall(function()
					return child:GetPivot().Position
				end)

				if ok then
					table.insert(tbl10, result)
				end
			end
		end

		return tbl10
	end

	tbl4.PlantStep = function(arg)
		if os.clock() < n5 and #fn12() >= n6 then
			return false
		end
		local tbl10 = {}

		for _, v11 in ipairs(tbl3.Tools("Egg")) do
			if n4 <= tbl3.EggRank(v11.Name) then
				table.insert(tbl10, v11)
			end
		end

		if #tbl10 == 0 then
			return false
		end

		table.sort(tbl10, function(arg2, arg3)
			return tbl3.EggLuck(arg2.Name) > tbl3.EggLuck(arg3.Name)
		end)

		local n7 = 0

		for _, v11 in ipairs(tbl10) do
			if not arg() then
				if not v11.Parent then
					continue
				else
					local v12 = tbl3.RandomPlotPoint(8, fn13(), 5)

					if v12 then
						tbl3.Status = string.format("Planting %s", v11.Name)

						if tbl3.Equip(v11) then
							local n8 = #fn12()
							tbl3.Fire("EggPlaced", { PlantPosition = v12 })
							local n9 = os.clock() + 1.2

							while os.clock() < n9 and #fn12() == n8 do
								RunService.Heartbeat:Wait()
							end

							if n8 < #fn12() then
								n7 += 1
								continue
							else
								n5 = os.clock() + 15
								n6 = #fn12()
								break
							end
						end
					end
				end
			end

			break
		end

		tbl3.Unequip()
		return n7 > 0
	end

	local function fn14()
		local tbl10 = {}

		for _, v11 in ipairs(fn12()) do
			local timer = v11:FindFirstChild("Timer", true)
			local hatch = v11:FindFirstChild("Hatch", true)

			if hatch and hatch:IsA("ProximityPrompt") and hatch.Enabled and timer and timer:IsA("TextLabel") and timer.Text == "Ready" then
				table.insert(tbl10, { Egg = v11, Prompt = hatch })
			end
		end

		return tbl10
	end

	tbl4.HatchWanted = function()
		return tbl2.Toggle(tbl4.Hatch, false) and #fn14() > 0
	end

	tbl4.HatchStep = function(arg)
		local n7 = 0

		for _, v11 in ipairs(fn14()) do
			if not arg() then
				if v11.Egg.Parent then
					local ok, result = pcall(function()
						return v11.Egg:GetPivot().Position
					end)

					if ok then
						tbl3.Status = "Hatching eggs"
						tbl3.FlyTo(result + Vector3.new(0, 3, 3), arg, 5)
						tbl3.FirePrompt(v11.Prompt)
						local n8 = os.clock() + 2

						while os.clock() < n8 and v11.Egg.Parent do
							RunService.Heartbeat:Wait()
						end

						if not v11.Egg.Parent then
							n7 += 1
						end
					end
				end

				continue
			end

			break
		end

		if n7 > 0 then
			task.wait(0.5)
			tbl3.Unequip()
		end

		return n7 > 0
	end

	tbl4.Plant = fn_trackToggle(v9, {
		Title = "Auto Plant Eggs",
		Default = false,
		Callback = function()
			n5 = 0
			tbl4.Wake()
		end,
	})

	v9:Dropdown({
		Title = "Plant Min Rarity",
		Values = tbl3.RarityChoices,
		Value = tbl3.RarityChoices[1],
		Callback = function(arg)
			n4 = tbl3.RarityRank[tostring(arg)] or 0
		end,
	})

	tbl4.Hatch = fn_trackToggle(v9, {
		Title = "Auto Hatch Eggs",
		Default = false,
		Callback = function()
			tbl4.Wake()
		end,
	})
end

do
	local tbl5 = {}
	local tbl6 = {}
	local foodChoices = {}

	if type(tbl.Foods) == "table" then
		local tbl7 = {}

		for k, food in pairs(tbl.Foods) do
			if type(food) == "table" then
				table.insert(tbl7, { Name = k, Cost = tonumber(food.Cost) or 0 })
			end
		end

		table.sort(tbl7, function(arg, arg2)
			return arg.Cost < arg2.Cost
		end)

		for _, v7 in ipairs(tbl7) do
			table.insert(foodChoices, v7.Name)
		end
	end

	tbl4.FoodChoices = foodChoices

	local function fn7()
		local pets = tbl3.Plot()
		pets = pets and pets:FindFirstChild("Pets")
		return pets and pets:GetChildren() or {}
	end

	local function fn8()
		return math.max(1, tonumber(localPlayer:GetAttribute("MaxPets")) or tonumber(tbl3.Saved("MaxPets")) or 5)
	end

	local function fn9(arg)
		local petScore = tbl3.PetScore
		local attribute = arg:GetAttribute("PetName") or arg.Name
		local getAttribute = arg.GetAttribute
		return petScore(attribute, arg:GetAttribute("Weight"), getAttribute(arg, "Mutation"))
	end

	local function fn10(arg)
		local getAttribute = arg.GetAttribute
		return tbl3.PetScore(tbl3.PetNameOf(arg), arg:GetAttribute("Weight"), getAttribute(arg, "Mutation"))
	end

	local function fn11()
		local n = -1
		local v7 = nil

		for _, v8 in ipairs(tbl3.Tools("Pet")) do
			local v9 = fn10(v8)

			if v9 > n then
				n = v9
				v7 = v8
			end
		end

		return v7, n
	end

	local function fn12()
		local huge = math.huge
		local v7 = nil

		for _, v8 in ipairs(fn7()) do
			local v9 = fn9(v8)

			if v9 < huge then
				huge = v9
				v7 = v8
			end
		end

		return v7, huge
	end

	tbl4.PlaceWanted = function()
		if not tbl2.Toggle(tbl4.Place, false) then
			return false
		end
		local v7, v8 = fn11()
		if not v7 then
			return false
		end

		if #fn7() < fn8() then
			return true
		end

		if tbl2.Toggle(tbl4.Swap, false) then
			local v9
			v9, v9 = fn12()
			return v8 > v9 * 1.05
		end

		return false
	end

	local function fn13(arg, arg2)
		local attribute = arg:GetAttribute("PetKey")
		if not attribute then
			return false
		end
		local v7 = tbl3.PlotTop()

		if v7 then
			tbl3.FlyTo(v7 + Vector3.new(0, 4, 0), arg2, 20)
		end

		if not tbl3.Equip(arg) then
			return false
		end
		local v8 = tbl3.RandomPlotPoint(10, nil, 0)
		local n = #fn7()
		tbl3.Fire("PlacePet", attribute, v8 + Vector3.new(0, 2, 0))
		task.wait(0.35)
		tbl3.Unequip()
		local n2 = os.clock() + 1.5

		while os.clock() < n2 and #fn7() == n do
			RunService.Heartbeat:Wait()
		end

		return #fn7() > n
	end

	tbl4.PlaceStep = function(arg)
		local n = 0

		for i = 1, fn8() do
			if not (arg() or not tbl4.PlaceWanted()) then
				local v7 = fn11()

				if v7 then
					local n2 = #fn7()

					if not (fn8() <= n2) then
						tbl3.Status = string.format("Placing %s", tbl3.PetNameOf(v7))
						if fn13(v7, arg) then
							n += 1
							continue
						end
					else
						local v8 = fn12()
						local attribute = v8 and v8:GetAttribute("PetKey")

						if attribute then
							tbl3.Status = "Swapping in a stronger pet"
							local v9 = tbl3.PlotTop()

							if v9 then
								tbl3.FlyTo(v9 + Vector3.new(0, 4, 0), arg, 20)
							end

							tbl3.Fire("PickupPet", attribute)
							local n3 = os.clock() + 1.5

							while os.clock() < n3 and v8.Parent do
								RunService.Heartbeat:Wait()
							end

							if not v8.Parent then
								tbl3.Status = string.format("Placing %s", tbl3.PetNameOf(v7))
								if fn13(v7, arg) then
									n += 1
									continue
								end
							end
						end
					end
				end
			end

			break
		end

		return n > 0
	end

	local function fn14()
		local huge = math.huge
		local v7 = nil

		for _, v8 in ipairs(tbl3.Tools("Food")) do
			local amount = v8:FindFirstChild("Amount", true)

			if (amount and tonumber(amount.Value) or 1) > 0 and (next(tbl5) == nil or tbl5[v8.Name]) then
				local flag = type(tbl.Foods) == "table" and tbl.Foods[v8.Name] or nil
				local n = type(flag) == "table" and tonumber(flag.Cost) or 0

				if n < huge then
					huge = n
					v7 = v8
				end
			end
		end

		return v7
	end

	tbl4.FeedWanted = function()
		if not tbl2.Toggle(tbl4.Feed, false) or not fn14() then
			return false
		end
		local now = os.clock()

		for _, v7 in ipairs(fn7()) do
			local attribute = v7:GetAttribute("PetKey")

			if attribute then
				attribute = (tbl6[attribute] or 0) <= now
			end

			if attribute then
				return true
			end
		end

		return false
	end

	tbl4.FeedStep = function(arg)
		local v7 = fn7()

		table.sort(v7, function(arg2, arg3)
			return fn9(arg2) > fn9(arg3)
		end)

		local n = 0

		for _, v8 in ipairs(v7) do
			if not arg() then
				local attribute = v8:GetAttribute("PetKey")
				local v9 = fn14()

				if v9 then
					local flag

					if attribute then
						flag = (tbl6[attribute] or 0) <= os.clock()
					else
						flag = attribute
					end

					if flag then
						local ok, result = pcall(function()
							return v8:GetPivot().Position
						end)

						if ok then
							tbl3.Status = string.format("Feeding %s", tostring(v8:GetAttribute("PetName") or v8.Name))
							tbl3.FlyTo(result + Vector3.new(0, 4, 4), arg, 8)

							if tbl3.Equip(v9) then
								local attribute2 = v8:GetAttribute("Age")
								tbl3.Fire("FeedPet", attribute, v9.Name)
								local n2 = os.clock() + 1.2

								while os.clock() < n2 and v8:GetAttribute("Age") == attribute2 do
									RunService.Heartbeat:Wait()
								end

								tbl6[attribute] = os.clock() + 2
								n += 1
							end
						end
					end

					continue
				end
			end

			break
		end

		tbl3.Unequip()
		return n > 0
	end

	tbl4.Place = fn_trackToggle(v4, {
		Title = "Auto Place Best Pets",
		Default = false,
		Callback = function()
			tbl4.Wake()
		end,
	})

	tbl4.Swap = fn_trackToggle(v4, {
		Title = "Swap Weaker Pets",
		Default = false,
		Callback = function()
			tbl4.Wake()
		end,
	})

	tbl4.Feed = fn_trackToggle(v4, {
		Title = "Auto Feed Pets",
		Default = false,
		Callback = function()
			table.clear(tbl6)
			tbl4.Wake()
		end,
	})

	fn4(v4:Dropdown({
		Title = "Foods To Use",
		Values = foodChoices,
		Multi = true,
		Callback = function(arg)
			tbl5 = fn6(arg)
		end,
	}))
end

do
	local flag = false
	local flag2 = true

	tbl4.Wake = function()
		flag = true
	end

	tbl4.CollectActive = function()
		return tbl2.Toggle(tbl4.Collect, false) or #tbl4.Manual > 0
	end

	local function fn7()
		local flag3 = tbl3.BasketCount() > 0

		if flag3 then
			flag3 = next(tbl4.Carried) ~= nil

			if not flag3 then
				local lastPickupAt = tbl4.LastPickupAt
				flag3 = os.clock() - lastPickupAt < 30
			end
		end

		return flag3
	end

	local function fn8()
		return tbl4.CollectActive() or fn7() or tbl2.Toggle(tbl4.Plant, false) or tbl2.Toggle(tbl4.Hatch, false) or tbl2.Toggle(tbl4.Place, false) or tbl2.Toggle(tbl4.Feed, false)
	end

	local function fn9()
		return not flag2 or not fn8()
	end

	local function fn10(arg)
		return function()
			return fn9() or not tbl2.Toggle(arg, false)
		end
	end

	task.spawn(function()
		while flag2 do
			local flag3 = false

			if fn8() and tbl3.Root() and tbl3.Plot() then
				tbl4.Busy = true

				if not pcall(function()
					if tbl3.BasketCount() > 0 then
						tbl4.Deliver(fn9)
						flag3 = true
					end

					if tbl2.Toggle(tbl4.Plant, false) and not fn9() then
						if tbl4.PlantStep(fn10(tbl4.Plant)) then
							flag3 = true
						end
					end

					if tbl4.HatchWanted() and not fn9() then
						if tbl4.HatchStep(fn10(tbl4.Hatch)) then
							flag3 = true
						end
					end

					if tbl4.PlaceWanted() and not fn9() then
						if tbl4.PlaceStep(fn10(tbl4.Place)) then
							flag3 = true
						end
					end

					if tbl4.FeedWanted() and not fn9() then
						if tbl4.FeedStep(fn10(tbl4.Feed)) then
							flag3 = true
						end
					end

					if tbl4.CollectActive() and not fn9() then
						if tbl4.CollectStep(function()
							return fn9() or not tbl4.CollectActive()
						end) then
							flag3 = true
						end
					end
				end) then
					tbl3.Unequip()
				end

				tbl4.Busy = false

				if not flag3 and not tbl2.Toggle(tbl4.Collect, false) then
					tbl3.Status = "Waiting for work"
				end
			elseif not fn8() then
				tbl3.Status = "Idle"
			end

			local n = flag3 and 0.15 or 1
			local n2 = os.clock() + n

			while flag2 and os.clock() < n2 and not flag do
				RunService.Heartbeat:Wait()
			end

			flag = false
		end
	end)

	fn3(function()
		flag2 = false
	end)
end

do
	local TweenService = game:GetService("TweenService")
	local tweenInfo = TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local tbl5 = { "Luck", "Rarity", "Distance" }
	local n = 60
	local n2 = 9

	local tbl6 = {
		Collect = Color3.fromRGB(255, 255, 255),
		Cancel = Color3.fromRGB(255, 120, 120),
		AutoOn = Color3.fromRGB(120, 255, 120),
		AutoOff = Color3.fromRGB(255, 255, 255),
		Busy = Color3.fromRGB(120, 255, 90),
		Queued = Color3.fromRGB(255, 214, 90),
		Auto = Color3.fromRGB(150, 210, 255),
		Carry = Color3.fromRGB(255, 170, 70),
	}

	local n3 = 1
	local screenGui = nil
	local clone = nil
	local holder = nil
	local clone2 = nil
	local textLabel = nil
	local textLabel2 = nil
	local label = nil
	local clone3 = nil
	local notification = nil
	local udim2 = nil
	local v7 = nil
	local n4 = nil
	local fn7 = nil
	local flag = false
	local tbl7 = {}
	local tbl8 = {}
	local flag2 = true
	local flag3 = true

	local function fn8(arg, text)
		if arg and arg.Text ~= text then
			arg.Text = text
		end
	end

	local function fn9()
		local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
		return playerGui and playerGui:FindFirstChild("Main")
	end

	local function fn10(arg)
		for _, descendant in ipairs(arg:GetDescendants()) do
			if descendant:IsA("LuaSourceContainer") or descendant:IsA("BindableEvent") then
				descendant:Destroy()
			end
		end
	end

	local function fn11(arg)
		local str = tbl3.EggData(arg)

		if str then
			str = tostring(str.Image or "")
		end

		return str or ""
	end

	local function fn12(arg)
		local attribute = arg:GetAttribute("Egg")
		local attribute2 = arg:GetAttribute("Position")
		local attribute3 = arg:GetAttribute("PrivateTo")
		return type(attribute) == "string" and typeof(attribute2) == "Vector3" and (attribute3 == nil or attribute3 == localPlayer.UserId)
	end

	local function fn13(arg)
		local position = arg.Position
		return UDim2.new(1 + arg.AnchorPoint.X * arg.Size.X.Scale + 0.1, position.X.Offset, position.Y.Scale, position.Y.Offset)
	end

	local function fn14(arg, arg2)
		TweenService:Create(arg, tweenInfo, { Position = arg2 }):Play()
	end

	local function fn15()
		if not flag then
			return
		end
		flag = false

		if clone then
			fn14(clone, v7)
		end
	end

	local function fn16()
		local v8 = flag
		local flag4

		if flag then
			flag4 = v8
		else
			flag4 = not clone
		end

		if flag4 then
			return
		end
		flag = true
		flag2 = true
		pcall(fn7)
		fn14(clone, udim2)
	end

	local function fn17()
		local collect = tbl4.Collect

		if type(collect) == "table" and type(collect.Set) == "function" then
			pcall(collect.Set, collect, not tbl2.Toggle(collect, false))
		end

		tbl4.Wake()
	end

	local function fn18(arg)
		if not table.find(tbl4.Manual, arg) then
			table.insert(tbl4.Manual, arg)
		end

		tbl4.Wake()
	end

	local function fn19(dropped)
		local v8 = table.find(tbl4.Manual, dropped)

		if v8 then
			table.remove(tbl4.Manual, v8)
		end

		if tbl4.Target == dropped then
			tbl4.Dropped = dropped
		end
	end

	local function fn20(arg, name, position, size, textXAlignment)
		local clone4 = arg:Clone()
		clone4.Name = name
		clone4.AnchorPoint = Vector2.new(0, 0)
		clone4.Position = position
		clone4.Size = size
		clone4.TextXAlignment = textXAlignment or Enum.TextXAlignment.Left
		clone4.TextScaled = true
		clone4.Visible = true
		clone4.Text = ""
		return clone4
	end

	local fn21 = nil

	local function fn22(arg, arg2)
		local clone4 = clone2:Clone()
		clone4.Name = fn2()
		clone4.Visible = true
		clone4.Size = UDim2.new(0.888163447, 0, 0, fn21())
		local holder2 = clone4:FindFirstChild("Holder")
		holder2 = holder2 and holder2:FindFirstChild("EggImage")
		local eggWeight = holder2 and holder2:FindFirstChild("EggWeight")
		local progress = clone4:FindFirstChild("Progress")
		local timeLeft = progress and progress:FindFirstChild("TimeLeft")
		local open = clone4:FindFirstChild("Open")
		local textLabel3 = open and open:FindFirstChild("TextLabel")

		if progress then
			progress.Visible = false
		end

		local eggName = timeLeft and fn20(timeLeft, "EggName", UDim2.fromScale(0.33, 0.1), UDim2.fromScale(0.64, 0.3))
		local eggInfo = timeLeft and fn20(timeLeft, "EggInfo", UDim2.fromScale(0.33, 0.4), UDim2.fromScale(0.64, 0.2))
		local eggStatus = timeLeft and fn20(timeLeft, "EggStatus", UDim2.fromScale(0.33, 0.66), UDim2.fromScale(0.3, 0.22))

		for _, v8 in ipairs({ eggName, eggInfo, eggStatus }) do
			v8.Parent = clone4
		end

		if open then
			open.Visible = true
			open.AnchorPoint = Vector2.new(0.5, 0.5)
			open.Position = UDim2.fromScale(0.8, 0.74)
			open.Size = UDim2.fromScale(0.33, 0.38)

			open.Activated:Connect(function()
				if table.find(tbl4.Manual, arg) or tbl4.Target == arg and tbl4.TargetManual then
					fn19(arg)
				else
					fn18(arg)
				end

				flag2 = true
			end)
		end

		local attribute = arg2:GetAttribute("Egg")
		local v8 = tbl3.EggRarity(attribute)

		if holder2 then
			holder2.Image = fn11(attribute)
		end

		if eggWeight then
			eggWeight.Text = string.format("%.2f KG", tonumber(arg2:GetAttribute("Weight")) or 0)
		end

		eggName.Text = tostring(attribute)
		eggName.TextColor3 = tbl3.RarityColors[v8] or Color3.fromRGB(255, 255, 255)
		clone4.Parent = holder

		return {
			Frame = clone4,
			Config = arg2,
			Name = attribute,
			Rarity = v8,
			Rank = tbl3.EggRank(attribute),
			Luck = tbl3.EggLuck(attribute) * (tonumber(arg2:GetAttribute("Weight")) or 1),
			Position = arg2:GetAttribute("Position"),
			Info = eggInfo,
			Status = eggStatus,
			Button = open,
			ButtonText = textLabel3,
		}
	end

	fn21 = function()
		return math.max(40, math.floor((holder and holder.AbsoluteSize.X or 0) * 0.888163447 / 2.55))
	end

	local function fn23(arg)
		local v8 = tbl7[arg]

		if v8 then
			tbl7[arg] = nil

			pcall(function()
				v8.Frame:Destroy()
			end)
		end
	end

	local function fn24(arg, arg2)
		if tbl4.Carried[arg] then
			return "Bringing home", tbl6.Carry, nil
		end

		if tbl4.Target == arg then
			return "Collecting...", tbl6.Busy, tbl4.TargetManual and "Cancel" or nil
		end
		local v8 = table.find(tbl4.Manual, arg)
		if v8 then
			return "Queued #" .. v8, tbl6.Queued, "Cancel"
		end

		if arg2 then
			return "Auto #" .. arg2, tbl6.Auto, "Collect"
		end
		return "", tbl6.Collect, "Collect"
	end

	fn7 = function()
		if not holder then
			return
		end
		local position = tbl3.Root()
		position = position and position.Position or Vector3.zero
		local tbl9 = {}
		local tbl10 = {}

		for _, child in ipairs(activeEggs:GetChildren()) do
			local flag4 = fn12(child)

			if flag4 then
				flag4 = not (tbl4.Relaying and child:GetAttribute("OriginPosition") ~= nil)
			end

			if flag4 then
				tbl9[child.Name] = child
				table.insert(tbl10, child)
			end
		end

		for k, v8 in pairs(tbl4.Carried) do
			if typeof(v8) == "Instance" and not tbl9[k] then
				tbl9[k] = v8
			end
		end

		if tbl4.Target and not tbl9[tbl4.Target] and tbl7[tbl4.Target] then
			tbl9[tbl4.Target] = tbl7[tbl4.Target].Config
		end

		for k in pairs(tbl7) do
			if not tbl9[k] then
				fn23(k)
			end
		end

		local tbl11 = {}

		for _, v8 in ipairs(tbl10) do
			local attribute = v8:GetAttribute("Egg")
			local attribute2 = v8:GetAttribute("Position")

			table.insert(tbl11, {
				Uid = v8.Name,
				Config = v8,
				Rank = tbl3.EggRank(attribute),
				Luck = tbl3.EggLuck(attribute) * (tonumber(v8:GetAttribute("Weight")) or 1),
				Distance = (attribute2 - position).Magnitude,
			})
		end

		local sort = tbl5[n3]

		table.sort(tbl11, function(arg, arg2)
			if sort == "Distance" then
				return arg.Distance < arg2.Distance
			end

			if sort == "Rarity" then
				if arg.Rank ~= arg2.Rank then
					return arg.Rank > arg2.Rank
				end

				if arg.Luck ~= arg2.Luck then
					return arg.Luck > arg2.Luck
				end
				return arg.Distance < arg2.Distance
			end

			if arg.Luck ~= arg2.Luck then
				return arg.Luck > arg2.Luck
			end
			return arg.Distance < arg2.Distance
		end)

		local tbl12 = {}
		local v8 = tbl4.AutoPlan(position)
		local n5 = 0

		for _, v9 in ipairs(v8) do
			local name = v9.Config.Name

			if not table.find(tbl4.Manual, name) and tbl4.Target ~= name then
				n5 += 1
				tbl12[name] = n5
				if not (n2 <= n5) then
					continue
				end
			else
				continue
			end

			break
		end

		local tbl13 = {}

		for k, v9 in pairs(tbl4.Carried) do
			if tbl9[k] == v9 then
				table.insert(tbl13, k)
			end
		end

		if tbl4.Target and tbl9[tbl4.Target] and not tbl4.Carried[tbl4.Target] then
			table.insert(tbl13, tbl4.Target)
		end

		for _, v9 in ipairs(tbl4.Manual) do
			if tbl9[v9] and v9 ~= tbl4.Target then
				table.insert(tbl13, v9)
			end
		end

		local tbl14 = {}
		local tbl15 = {}

		for _, v9 in ipairs(tbl13) do
			tbl15[v9] = true
			table.insert(tbl14, v9)
		end

		for _, v9 in ipairs(tbl11) do
			if not tbl15[v9.Uid] then
				tbl15[v9.Uid] = true
				table.insert(tbl14, v9.Uid)
			end
		end

		local tbl16 = {}

		for _, v9 in ipairs(tbl11) do
			tbl16[v9.Uid] = v9.Distance
		end

		local tbl17 = {}

		for i, v9 in ipairs(tbl14) do
			if not (i > n) then
				tbl17[v9] = true
				local v10 = tbl7[v9]

				if not v10 then
					v10 = fn22(v9, tbl9[v9])
					tbl7[v9] = v10
				end

				v10.Frame.LayoutOrder = i
				local v11 = fn21()

				if v10.Frame.Size.Y.Offset ~= v11 then
					v10.Frame.Size = UDim2.new(0.888163447, 0, 0, v11)
				end

				if tbl4.Carried[v9] then
					fn8(v10.Info, v10.Rarity .. "  |  In basket")
				else
					fn8(v10.Info, string.format("%s  |  %dm", v10.Rarity, math.floor(tbl16[v9] or 0)))
				end

				local v12, v13, v14 = fn24(v9, tbl12[v9])
				fn8(v10.Status, v12)
				v10.Status.TextColor3 = v13

				if v10.Button then
					v10.Button.Visible = v14 ~= nil

					if v14 then
						fn8(v10.ButtonText, v14)
						v10.Button.ImageColor3 = v14 == "Cancel" and tbl6.Cancel or tbl6.Collect
					end
				end

				continue
			end

			break
		end

		for k in pairs(tbl7) do
			if not tbl17[k] then
				fn23(k)
			end
		end

		fn8(label, string.format("Map Eggs (%d)", #tbl10))
		local v9 = tbl2.Toggle(tbl4.Collect, false)
		fn8(textLabel2, v9 and "Auto: ON" or "Auto: OFF")

		if textLabel2 and textLabel2.Parent and textLabel2.Parent:IsA("ImageButton") then
			textLabel2.Parent.ImageColor3 = v9 and tbl6.AutoOn or tbl6.AutoOff
		end

		fn8(textLabel, "Sort: " .. sort)

		if notification then
			local n6 = #tbl4.Manual + (tbl4.Target and 1 or 0)
			notification.Visible = n6 > 0
			local v10 = tostring
			fn8(notification:FindFirstChild("Count"), v10(n6))
		end
	end

	local function fn25()
		local v8 = fn9()
		local plotEggsTracker = v8 and v8:FindFirstChild("PlotEggsTracker")
		local sideBar = v8 and v8:FindFirstChild("SideBar")
		sideBar = sideBar and sideBar:FindFirstChild("Egg")
		local handler = nil

		if plotEggsTracker then
			handler = plotEggsTracker:FindFirstChild("Handler")
			handler = handler and handler:FindFirstChild("EggFrame")

			if not handler then
				local holder2 = plotEggsTracker:FindFirstChild("Holder")
				local v9 = ipairs
				local children = holder2 and holder2:GetChildren() or {}

				for _, child in v9(children) do
					if child:IsA("Frame") and child:FindFirstChild("Holder") then
						handler = child
						break
					end
				end
			end
		end

		if not plotEggsTracker or not sideBar or not handler then
			return false
		end
		screenGui = Instance.new("ScreenGui")
		screenGui.Name = fn2()
		screenGui.ResetOnSpawn = false
		screenGui.IgnoreGuiInset = v8.IgnoreGuiInset
		screenGui.ScreenInsets = v8.ScreenInsets
		screenGui.ZIndexBehavior = v8.ZIndexBehavior
		screenGui.DisplayOrder = v8.DisplayOrder + 1
		clone2 = handler:Clone()
		fn10(clone2)
		clone = plotEggsTracker:Clone()
		clone.Name = fn2()
		fn10(clone)
		holder = clone:FindFirstChild("Holder")

		for _, child in ipairs(holder:GetChildren()) do
			if not child:IsA("UIListLayout") then
				child:Destroy()
			end
		end

		holder.AutomaticCanvasSize = Enum.AutomaticSize.Y
		holder.CanvasSize = UDim2.new()
		local uiListLayout = holder:FindFirstChildOfClass("UIListLayout")

		if uiListLayout then
			uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		end

		udim2 = UDim2.new(0.99, 0, 0.5, 0)
		clone.Position = udim2
		v7 = fn13(clone)
		clone.Position = v7
		local header = clone:FindFirstChild("Header")
		label = header and header:FindFirstChild("Label")

		if label then
			label.Text = "Map Eggs"
		end

		local growAll = clone:FindFirstChild("GrowAll")

		if growAll then
			local clone4 = growAll:Clone()
			growAll.Name = fn2()
			clone4.Name = fn2()
			growAll.Size = UDim2.new(0.27, 0, growAll.Size.Y.Scale, 0)
			clone4.Size = growAll.Size
			growAll.Position = UDim2.new(0.58, 0, growAll.Position.Y.Scale, 0)
			clone4.Position = UDim2.new(0.86, 0, growAll.Position.Y.Scale, 0)
			clone4.Parent = clone

			for _, v9 in ipairs({ growAll, clone4 }) do
				local textLabel3 = v9:FindFirstChild("TextLabel")

				if textLabel3 then
					textLabel3.AnchorPoint = Vector2.new(0.5, 0.5)
					textLabel3.Position = UDim2.fromScale(0.5, 0.5)
					textLabel3.Size = UDim2.fromScale(0.86, 0.56)
					textLabel3.TextXAlignment = Enum.TextXAlignment.Center
				end
			end

			textLabel = growAll:FindFirstChild("TextLabel")
			textLabel2 = clone4:FindFirstChild("TextLabel")

			growAll.Activated:Connect(function()
				n3 = n3 % #tbl5 + 1
				flag2 = true
			end)

			clone4.Activated:Connect(function()
				fn17()
				flag2 = true
			end)
		end

		local toggle = clone:FindFirstChild("Toggle")

		if toggle and toggle:IsA("GuiButton") then
			toggle.Activated:Connect(fn15)
		end

		clone.Parent = screenGui
		clone3 = sideBar:Clone()
		clone3.Name = fn2()
		fn10(clone3)
		local arrow = clone3:FindFirstChild("Arrow")
		local v9, v10, v11 = pairs(type(tbl.Eggs) == "table" and tbl.Eggs or {})
		local n5 = -1
		local v12 = nil

		for k, v13 in v9, v10, v11 do
			local image = type(v13) == "table" and v13.Image
			local flag4

			if image then
				flag4 = (tonumber(v13.Luck) or 0) > n5
			else
				flag4 = image
			end

			if flag4 then
				n5 = tonumber(v13.Luck)

				if n5 then
					v12 = k
				else
					n5 = 0
					v12 = k
				end
			end
		end

		if arrow and v12 then
			arrow.Image = fn11(v12)
			arrow.AnchorPoint = Vector2.new(0.5, 0.5)
			arrow.Position = UDim2.fromScale(0.5, 0.42)
			arrow.Size = UDim2.fromScale(0.74, 0.74)
		end

		clone3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		local uiGradient = Instance.new("UIGradient")
		uiGradient.Rotation = 90
		local color = Color3.fromRGB
		uiGradient.Color = ColorSequence.new(Color3.fromRGB(196, 110, 255), color(112, 40, 214))
		uiGradient.Parent = clone3
		local uiStroke = clone3:FindFirstChildOfClass("UIStroke")

		if uiStroke then
			uiStroke.Color = Color3.fromRGB(44, 8, 86)
		end

		notification = clone3:FindFirstChild("Notification")
		local count = notification and notification:FindFirstChild("Count")

		if count then
			local clone4 = count:Clone()
			clone4.Name = fn2()
			clone4.AnchorPoint = Vector2.new(0.5, 0.5)
			clone4.Position = UDim2.fromScale(0.5, 0.86)
			clone4.Size = UDim2.fromScale(0.9, 0.3)
			clone4.TextScaled = true
			clone4.Text = "MAP"
			clone4.TextColor3 = Color3.fromRGB(255, 255, 255)
			clone4.ZIndex = 3
			local uiStroke2 = clone4:FindFirstChildOfClass("UIStroke")

			if uiStroke2 then
				uiStroke2.Color = Color3.fromRGB(44, 8, 86)
			end

			clone4.Parent = clone3
		end

		if notification then
			notification.Visible = false
		end

		clone3.AnchorPoint = Vector2.new(0.5, 0.5)
		clone3.Parent = screenGui

		clone3.Activated:Connect(function()
			if flag then
				fn15()
			else
				fn16()
			end
		end)

-- https://discord.gg/bRdE4sfddp
		screenGui.Parent = v3
		return true
	end

	local function fn26(arg)
		if not clone3 or not screenGui then
			return
		end
		local v8 = fn9()
		local sideBar = v8 and v8:FindFirstChild("SideBar")
		local egg = sideBar and sideBar:FindFirstChild("Egg")
		local pets = sideBar and sideBar:FindFirstChild("Pets")
		if not egg or not pets or not v8.Enabled then
			clone3.Visible = false
			return
		end
		local absoluteSize = screenGui.AbsoluteSize
		local absolutePosition = screenGui.AbsolutePosition
		local n5 = egg.AbsolutePosition + egg.AbsoluteSize / 2 - absolutePosition
		local n6 = pets.AbsolutePosition + pets.AbsoluteSize / 2 - absolutePosition

		if sideBar:GetAttribute("Open") == true and n6.X < absoluteSize.X - pets.AbsoluteSize.X * 0.4 then
			n4 = absoluteSize.X - n6.X
		end

		local n7 = n4 or pets.AbsoluteSize.X * 0.9
		local absoluteSize2 = pets.AbsoluteSize
		local vector2 = Vector2.new(absoluteSize.X - n7, n5.Y - n6.Y - n5.Y)
		local exitTo = nil
		local v9

		for _, v10 in ipairs({ "BasketTracker", "PlotEggsTracker", "PetsTracker" }) do
			v9 = v8:FindFirstChild(v10)
			if v9 and v9:GetAttribute("Open") == true and v9.AbsolutePosition.X - absolutePosition.X < absoluteSize.X then
				exitTo = 1
				break
			end
		end

		local vector22, clamp

		if exitTo == 1 then
			local y = v9.AbsolutePosition.Y
			local n8 = v9.AbsolutePosition.X + v9.AbsoluteSize.X

			for _, child in ipairs(v9:GetChildren()) do
				if child:IsA("GuiObject") and child.Visible then
					y = math.min(y, child.AbsolutePosition.Y)
				end
			end

			local n9 = absoluteSize2.X / 2
			vector2 = Vector2.new(math.min(n8 - absolutePosition.X, absoluteSize.X - 4) - n9, y - absolutePosition.Y - absoluteSize2.Y / 2 - absoluteSize2.Y * 0.12)
			vector22 = Vector2.new(clone3.Position.X.Offset, clone3.Position.Y.Offset)
			clamp = math.clamp
			arg = arg or 0
		else
			vector22 = Vector2.new(clone3.Position.X.Offset, clone3.Position.Y.Offset)
			clamp = math.clamp
			arg = arg or 0
		end

		local n8 = clamp(arg * 14, 0, 1)

		if not clone3.Visible or (vector22 - vector2).Magnitude > absoluteSize.Y then
			n8 = 1
		end

		local v10 = vector22:Lerp(vector2, n8)
		clone3.Size = UDim2.fromOffset(absoluteSize2.X, absoluteSize2.Y)
		clone3.Position = UDim2.fromOffset(v10.X, v10.Y)
		clone3.Visible = not flag
	end

	local function fn27()
		if screenGui then
			return
		end

		if not fn25() then
			return
		end

		table.insert(tbl8, activeEggs.ChildAdded:Connect(function()
			flag2 = true
		end))

		table.insert(tbl8, activeEggs.ChildRemoved:Connect(function()
			flag2 = true
		end))

		local n5 = 0

		table.insert(tbl8, RunService.RenderStepped:Connect(function(deltaTime)
			pcall(fn26, deltaTime)
			n5 += deltaTime

			if flag and (flag2 or n5 >= 0.3) then
				n5 = 0
				flag2 = false
				pcall(fn7)
			elseif not flag and n5 >= 0.5 then
				n5 = 0

				if notification then
					local n6 = #tbl4.Manual + (tbl4.Target and 1 or 0)
					notification.Visible = n6 > 0
					local v8 = tostring
					fn8(notification:FindFirstChild("Count"), v8(n6))
				end
			end
		end))
	end

	local function fn28()
		for _, v8 in ipairs(tbl8) do
			v8:Disconnect()
		end

		table.clear(tbl8)
		flag = false
		table.clear(tbl7)

		if screenGui then
			pcall(function()
				screenGui:Destroy()
			end)
		end

		screenGui = nil
		clone = nil
		holder = nil
		clone2 = nil
		clone3 = nil
		notification = nil
	end

	task.spawn(function()
		local n5 = os.clock() + 30

		while flag3 and not screenGui and os.clock() < n5 do
			pcall(fn27)

			if not screenGui then
				task.wait(1)
			end
		end
	end)

	fn3(function()
		flag3 = false
		fn28()
	end)
end

do
	local tbl5 = { Food = nil, Gears = nil }
	local tbl6 = { Food = {}, Gears = {} }
	local tbl7 = {}
	local n = 0
	local tbl8 = {}

	local function fn7(arg)
		local tbl9 = {}
		local shop = tbl.Shop
		local flag = type(shop) == "table" and shop[arg] or nil

		if type(flag) == "table" then
			for k, v7 in pairs(flag) do
				if type(v7) == "table" then
					table.insert(tbl9, { Name = k, Price = tonumber(v7.Price) or 0 })
				end
			end
		end

		table.sort(tbl9, function(arg2, arg3)
			return arg2.Price < arg3.Price
		end)

		local tbl10 = {}

		for _, v7 in ipairs(tbl9) do
			table.insert(tbl10, v7.Name)
		end

		return tbl10
	end

	local function fn8(arg, arg2)
		local shop = tbl.Shop
		local flag = type(shop) == "table" and shop[arg] or nil
		local flag2 = type(flag) == "table" and flag[arg2] or nil
		return type(flag2) == "table" and tonumber(flag2.Price) or math.huge
	end

	local function fn9(arg)
		if type(arg) ~= "table" then
			return
		end

		for k, v7 in pairs(arg) do
			if (k == "Food" or k == "Gears") and type(v7) == "table" then
				local tbl9 = {}

				for k2, v8 in pairs(v7) do
					if type(v8) == "table" then
						tbl9[k2] = tonumber(v8.Amount) or v8.InStock and 1 or 0
					end
				end

				tbl5[k] = tbl9
			end
		end
	end

	local tbl9 = {}

	for _, v7 in ipairs({ "Restock", "ShopStock" }) do
		local v8 = game_:FindFirstChild(v7)

		if v8 and v8:IsA("RemoteEvent") then
			table.insert(tbl9, v8.OnClientEvent:Connect(function(arg)
				fn9(arg)
			end))
		end
	end

	tbl3.Fire("ShopStock")

	local function fn10(arg)
		local character = localPlayer.Character
		local n2 = 0

		for _, v7 in ipairs({ localPlayer:FindFirstChildOfClass("Backpack"), character }) do
			if v7 then
				for _, child in ipairs(v7:GetChildren()) do
					if child:IsA("Tool") and string.gsub(child.Name, "%s*%[.*$", "") == arg then
						local amount = child:FindFirstChild("Amount", true)
						n2 += amount and tonumber(amount.Value) or 1
					end
				end
			end
		end

		return n2
	end

	local function fn11(arg)
		if not tbl2.Toggle(tbl8[arg], false) then
			return
		end
		local flag = false

		for _, v7 in ipairs(fn7(arg)) do
			if tbl6[arg][v7] then
				local v8 = fn8(arg, v7)
				local v9 = tbl5[arg]
				local v10 = v9 and v9[v7]
				local flag2 = v10 == nil

				if flag2 then
					flag2 = (tbl7[arg .. v7] or 0) <= os.clock()
				end

				flag2 = flag2 or v10 ~= nil and v10 > 0
				local n2 = 0

				while flag2 and n2 < 20 and tbl3.Cash() - v8 >= n do
					if not flag then
						tbl3.Fire("SetOpenShop", arg)
						task.wait(0.15)
						flag = true
					end

					local v11 = fn10(v7)
					tbl3.Fire("BuyWithCash", arg, v7)
					n2 += 1
					local n3 = os.clock() + 0.8

					while os.clock() < n3 and fn10(v7) <= v11 do
						RunService.Heartbeat:Wait()
					end

					if fn10(v7) > v11 then
						if v9 and v9[v7] then
							v9[v7] = math.max(0, v9[v7] - 1)
							flag2 = v9[v7] > 0
						end
					else
						if v9 then
							v9[v7] = 0
						end

						tbl7[arg .. v7] = os.clock() + 30
						flag2 = false
					end
				end
			end
		end
	end

	local flag = true

	task.spawn(function()
		while flag do
			pcall(fn11, "Food")
			pcall(fn11, "Gears")
			task.wait(3)
		end
	end)

	fn3(function()
		flag = false

		for _, v7 in ipairs(tbl9) do
			v7:Disconnect()
		end
	end)

	tbl8.Food = fn_trackToggle(v5, {
		Title = "Auto Buy Food",
		Default = false,
		Callback = function()
		end,
	})

	v5:Dropdown({
		Title = "Food To Buy",
		Values = fn7("Food"),
		Multi = true,
		Callback = function(arg)
			tbl6.Food = fn6(arg)
		end,
	})

	tbl8.Gears = fn_trackToggle(v5, {
		Title = "Auto Buy Radars",
		Default = false,
		Callback = function()
		end,
	})

	v5:Dropdown({
		Title = "Radars To Buy",
		Values = fn7("Gears"),
		Multi = true,
		Callback = function(arg)
			tbl6.Gears = fn6(arg)
		end,
	})

	v5:Slider({
		Title = "Keep Cash",
		Step = 1000,
		Value = {
			Min = 0,
			Max = 100000000,
			Default = 0,
		},
		Callback = function(arg)
			n = math.max(0, tonumber(arg) or 0)
		end,
	})
end

do
	local function fn7()
		local rebirths = tbl.Rebirths
		local n = tonumber(tbl3.Saved("Rebirths")) or 0
		if type(rebirths) ~= "table" then
			return nil
		end
		local num = tonumber(rebirths.Cap)
		if num and n >= num then
			return nil
		end

		if type(rebirths.GetCost) == "function" then
			local ok, result = pcall(rebirths.GetCost, n)
			if ok and tonumber(result) then
				return tonumber(result)
			end
		end

		return nil
	end

	local v7 = fn_trackToggle(v6, {
		Title = "Auto Rebirth",
		Default = false,
		Callback = function()
		end,
	})

	local v8 = fn_trackToggle(v6, {
		Title = "Auto Claim Index Reward",
		Default = false,
		Callback = function()
		end,
	})

	local flag = true
	local n = 0
	local n2 = 0

	task.spawn(function()
		while flag do
			local now = os.clock()

			if tbl2.Toggle(v7, false) and now >= n then
				local v9 = fn7()

				if v9 and tbl3.Cash() >= v9 then
					tbl3.Fire("Rebirth")
					n = now + 15
				else
					n = now + 3
				end
			end

			if tbl2.Toggle(v8, false) and now >= n2 then
				tbl3.Fire("ClaimIndexReward")
				n2 = now + 60
			end

			task.wait(1)
		end
	end)

	fn3(function()
		flag = false
	end)
end

do
	local v7 = v2:Tab({ Title = "Player", Icon = "user" })
	local v8 = v7:Section({ Title = "Movement" })
	local v9 = v7:Section({ Title = "ESP" })
	local v10 = nil
	local n = 60

	local connection = RunService.Heartbeat:Connect(function()
		if not tbl2.Toggle(v10, false) or tbl4.Busy then
			return
		end
		local v11 = tbl3.Humanoid()
		local v12 = tbl3.Root()
		if not v11 or not v12 or v11.Sit then
			return
		end
		local moveDirection = v11.MoveDirection
		local vector = Vector3.new(moveDirection.X, 0, moveDirection.Z)
		if vector.Magnitude < 0.05 then
			return
		end
		local n2 = vector.Unit * n
		v12.AssemblyLinearVelocity = Vector3.new(0, v12.AssemblyLinearVelocity.Y, 0) + n2
	end)

	fn3(function()
		connection:Disconnect()
	end)

	v10 = fn_trackToggle(v8, {
		Title = "Speed Boost",
		Default = false,
		Callback = function()
		end,
	})

	v8:Slider({
		Title = "Boost Speed",
		Step = 1,
		Value = {
			Min = 16,
			Max = 1300,
			Default = 60,
		},
		Callback = function(arg)
			n = math.clamp(tonumber(arg) or 60, 16, 1300)
		end,
	})

	local v11 = nil

	local connection2 = UserInputService.JumpRequest:Connect(function()
		if not tbl2.Toggle(v11, false) then
			return
		end
		local v12 = tbl3.Humanoid()

		if v12 then
			pcall(function()
				v12:ChangeState(Enum.HumanoidStateType.Jumping)
			end)
		end
	end)

	fn3(function()
		connection2:Disconnect()
	end)

	v11 = fn_trackToggle(v8, {
		Title = "Infinite Jump",
		Default = false,
		Callback = function()
		end,
	})

	local v12 = nil
	local flag = false

	local connection3 = RunService.Stepped:Connect(function()
		if tbl2.Toggle(v12, false) then
			flag = true
			tbl3.SetNoclip(true)
		elseif flag then
			flag = false

			if not tbl4.Busy then
				tbl3.SetNoclip(false)
			end
		end
	end)

	fn3(function()
		connection3:Disconnect()
	end)

	v12 = fn_trackToggle(v8, {
		Title = "Noclip",
		Default = false,
		Callback = function()
		end,
	})

	local ProximityPromptService = game:GetService("ProximityPromptService")
	local tbl5 = {}
	local tbl6 = {}

	local function fn7(arg)
		if not arg:IsA("ProximityPrompt") then
			return
		end

		if tbl5[arg] == nil then
			tbl5[arg] = arg.HoldDuration
		end

		if arg.HoldDuration ~= 0 then
			arg.HoldDuration = 0
		end
	end

	local function fn8()
		for _, v13 in ipairs(tbl6) do
			v13:Disconnect()
		end

		table.clear(tbl6)

		for k, v13 in pairs(tbl5) do
			if k.Parent then
				pcall(function()
					k.HoldDuration = v13
				end)
			end
		end

		table.clear(tbl5)
	end

	local function fn9()
		fn8()

		for _, descendant in ipairs(workspace:GetDescendants()) do
			if descendant:IsA("ProximityPrompt") then
				fn7(descendant)
			end
		end

		table.insert(tbl6, workspace.DescendantAdded:Connect(function(descendant)
			if descendant:IsA("ProximityPrompt") then
				task.defer(fn7, descendant)
			end
		end))

		table.insert(tbl6, ProximityPromptService.PromptShown:Connect(fn7))
	end

	fn3(fn8)

	fn_trackToggle(v8, {
		Title = "Instant Pickup",
		Default = false,
		Callback = function(arg)
			if arg then
				fn9()
			else
				fn8()
			end
		end,
	})

	local font = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal)
	local n2 = 0
	local visible = true
	local folder = nil
	local tbl7 = {}
	local tbl8 = {}

	local function fn10(parent, arg)
		parent.BackgroundTransparency = 1
		parent.FontFace = font
		parent.TextScaled = true
		parent.TextStrokeTransparency = 1
		parent.TextColor3 = Color3.fromRGB(255, 255, 255)
		parent.Size = UDim2.new(1, 0, 0, arg)
		local uiStroke = Instance.new("UIStroke")
		uiStroke.Name = fn2()
		uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
		uiStroke.LineJoinMode = Enum.LineJoinMode.Round
		uiStroke.Color = Color3.fromRGB(0, 0, 0)
		uiStroke.Thickness = 1.8
		uiStroke.Transparency = 0.05
		uiStroke.Parent = parent
	end

	local function fn11(child)
		local v13 = tbl7[child]

		if v13 then
			tbl7[child] = nil

			pcall(function()
				v13.Gui:Destroy()
			end)
		end
	end

	local function fn12(arg)
		if tbl7[arg] or not folder then
			return
		end
		local attribute = arg:GetAttribute("Egg")
		local attribute2 = arg:GetAttribute("Position")
		if type(attribute) ~= "string" or typeof(attribute2) ~= "Vector3" then
			return
		end
		local attribute3 = arg:GetAttribute("PrivateTo")
		if attribute3 ~= nil and attribute3 ~= localPlayer.UserId then
			return
		end

		if tbl3.EggRank(attribute) < n2 then
			return
		end
		local v13 = tbl3.EggRarity(attribute)
		local rarityColor = tbl3.RarityColors[v13] or Color3.fromRGB(255, 255, 255)
		local billboardGui = Instance.new("BillboardGui")
		billboardGui.Name = fn2()
		billboardGui.AlwaysOnTop = true
		billboardGui.LightInfluence = 0
		billboardGui.Size = UDim2.fromOffset(196, 54)
		billboardGui.Adornee = workspace.Terrain
		billboardGui.StudsOffsetWorldSpace = attribute2 + Vector3.new(0, 4, 0)
		billboardGui.MaxDistance = 100000

		local card = Instance.new("Frame")
		card.Name = fn2()
		card.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
		card.BackgroundTransparency = 0.12
		card.BorderSizePixel = 0
		card.Size = UDim2.fromScale(1, 1)
		card.Parent = billboardGui
		local cardCorner = Instance.new("UICorner")
		cardCorner.Name = fn2()
		cardCorner.CornerRadius = UDim.new(0, 8)
		cardCorner.Parent = card
		local cardStroke = Instance.new("UIStroke")
		cardStroke.Name = fn2()
		cardStroke.Color = Color3.fromRGB(255, 255, 255)
		cardStroke.Transparency = 0.82
		cardStroke.Thickness = 1
		cardStroke.Parent = card

		local accent = Instance.new("Frame")
		accent.Name = fn2()
		accent.BackgroundColor3 = rarityColor
		accent.BorderSizePixel = 0
		accent.AnchorPoint = Vector2.new(0, 0)
		accent.Position = UDim2.fromScale(0, 0)
		accent.Size = UDim2.new(0, 4, 1, 0)
		accent.Parent = card
		local accentCorner = Instance.new("UICorner")
		accentCorner.Name = fn2()
		accentCorner.CornerRadius = UDim.new(0, 8)
		accentCorner.Parent = accent

		local frame = Instance.new("Frame")
		frame.Name = fn2()
		frame.BackgroundTransparency = 1
		frame.Position = UDim2.fromOffset(12, 0)
		frame.Size = UDim2.new(1, -16, 1, 0)
		frame.Parent = card
		local uiListLayout = Instance.new("UIListLayout")
		uiListLayout.Name = fn2()
		uiListLayout.FillDirection = Enum.FillDirection.Vertical
		uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
		uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		uiListLayout.Parent = frame
		local textLabel = Instance.new("TextLabel")
		textLabel.Name = fn2()
		textLabel.LayoutOrder = 1
		textLabel.TextXAlignment = Enum.TextXAlignment.Left
		fn10(textLabel, 22)
		textLabel.Text = attribute
		textLabel.TextColor3 = rarityColor
		textLabel.Parent = frame
		local textLabel2 = Instance.new("TextLabel")
		textLabel2.Name = fn2()
		textLabel2.LayoutOrder = 2
		textLabel2.TextXAlignment = Enum.TextXAlignment.Left
		fn10(textLabel2, 16)
		textLabel2.TextColor3 = Color3.fromRGB(200, 200, 208)
		textLabel2.Visible = visible
		textLabel2.Parent = frame
		billboardGui.Parent = folder

		tbl7[arg] = {
			Gui = billboardGui,
			Info = textLabel2,
			Rarity = v13,
			Position = attribute2,
			Weight = tonumber(arg:GetAttribute("Weight")) or 1,
		}
	end

	local function fn13()
		for _, v13 in ipairs(tbl8) do
			v13:Disconnect()
		end

		table.clear(tbl8)

		for k in pairs(tbl7) do
			fn11(k)
		end

		if folder then
			pcall(function()
				folder:Destroy()
			end)

			folder = nil
		end
	end

	local function fn14()
		fn13()
		folder = Instance.new("Folder")
		folder.Name = fn2()
		folder.Parent = v3
		local children = activeEggs:GetChildren()

		task.spawn(function()
			local n3 = 1

			while folder and n3 <= #children do
				local n4 = os.clock() + 0.004

				while n3 <= #children and os.clock() < n4 do
					fn12(children[n3])
					n3 += 1
				end

				RunService.Heartbeat:Wait()
			end
		end)

		table.insert(tbl8, activeEggs.ChildAdded:Connect(function(child)
			task.defer(fn12, child)
		end))

		table.insert(tbl8, activeEggs.ChildRemoved:Connect(fn11))
		local n3 = 0

		table.insert(tbl8, RunService.Heartbeat:Connect(function(deltaTime)
			n3 += deltaTime
			if n3 < 0.5 then
				return
			end
			n3 = 0
			local v13 = tbl3.Root()
			if not v13 or not visible then
				return
			end

			for _, v14 in pairs(tbl7) do
				v14.Info.Text = string.format("%s  %.2fkg  %dm", v14.Rarity, v14.Weight, math.floor((v14.Position - v13.Position).Magnitude))
			end
		end))
	end

	fn3(fn13)

	local v13 = fn_trackToggle(v9, {
		Title = "ESP Eggs",
		Default = false,
		Callback = function(arg)
			if arg then
				fn14()
			else
				fn13()
			end
		end,
	})

	v9:Dropdown({
		Title = "ESP Min Rarity",
		Values = tbl3.RarityChoices,
		Value = tbl3.RarityChoices[1],
		Callback = function(arg)
			n2 = tbl3.RarityRank[tostring(arg)] or 0

			if tbl2.Toggle(v13, false) then
				fn14()
			end
		end,
	})
end

local v7
v7 = v2:Tab({ Title = "Server", Icon = "server" }):Section({ Title = "Server" })

do
	local TeleportService = game:GetService("TeleportService")
	local HttpService = game:GetService("HttpService")

	local function fn7()
		if type(queue_on_teleport) == "function" then
			return queue_on_teleport
		end

		if type(queueonteleport) == "function" then
			return queueonteleport
		end

		if type(syn) == "table" and type(syn.queue_on_teleport) == "function" then
			return syn.queue_on_teleport
		end

		if type(fluxus) == "table" and type(fluxus.queue_on_teleport) == "function" then
			return fluxus.queue_on_teleport
		end
		return nil
	end

	local function fn8(arg)
		pcall(function()
			TeleportService:SetTeleportSetting("__ChilliAutoLoadScriptEnabled", arg)
		end)

		if not arg then
			return true
		end
		local v8 = fn7()
		if not v8 then
			return false
		end

		if rawget(_G, "__ChilliAutoLoadQueued") ~= true then
			if not pcall(v8, [[local TeleportService = game:GetService("TeleportService")
local enabled = true
pcall(function()
    enabled = TeleportService:GetTeleportSetting("__ChilliAutoLoadScriptEnabled") == true
end)
if enabled then
    local ok, source = pcall(function()
        return game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua")
    end)
    if ok and type(source) == "string" then
        local chunk = loadstring(source)
        if chunk then
            chunk()
        end
    end
end
]]) then
				return false
			end

			_G.__ChilliAutoLoadQueued = true
		end

		return true
	end

	local v8 = nil

	local function fn9()
		if v8 and tbl2.Toggle(v8, false) then
			fn8(true)
		end
	end

	v8 = fn_trackToggle(v7, {
		Title = "Auto Load Script",
		Default = true,
		Callback = function(arg)
			local flag = arg == true

			if not fn8(flag) and flag then
				task.defer(function()
					fn8(false)

					if v8 and type(v8.Set) == "function" then
						pcall(v8.Set, v8, false, false)
					end

					fn5("Auto Load Unavailable", "This executor does not support queue on teleport.")
				end)
			end
		end,
	})

	local str = "Least Players"
	local n = 10
	local n2 = 0
	local v9 = nil
	local tbl5 = {}
	local flag = false
	local n3 = 0
	local flag2 = false
	local v10 = nil
	local str2 = ""
	local n4 = 0
	local n5 = 60

	local function fn10(arg)
		n2 = 0
		v9 = nil

		if arg then
			tbl5[arg] = true
		end
	end

	pcall(function()
		TeleportService.TeleportInitFailed:Connect(function(arg, arg2, arg3)
			if not v9 then
				return
			end
			fn10(v9)
			flag2 = true

			if not flag then
				fn5("Server Hop Failed", tostring(arg3 ~= "" and arg3 or arg2))
			end
		end)
	end)

	local function fn11(arg)
		local str3 = tostring(game.JobId or "")
		local tbl6 = {}
		local flag3 = arg == "Random"
		local str4 = arg == "Least Players" and "Asc" or "Desc"
		local n6 = flag3 and 3 or 6
		local nextPageCursor = nil

		for i = 1, n6 do
			local str5 = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=%s&excludeFullGames=true&limit=100", game.PlaceId, str4)

			if nextPageCursor and nextPageCursor ~= "" then
				str5 ..= "&cursor=" .. HttpService:UrlEncode(nextPageCursor)
			end

			local ok, result = pcall(function()
				return HttpService:JSONDecode(game:HttpGet(str5))
			end)

			if not ok or type(result) ~= "table" then
				return tbl6, false
			end
			local v11 = ipairs
			local data = result.data or {}

			for _, v12 in v11(data) do
				local str6 = tostring(v12.id or "")
				local huge = tonumber(v12.playing) or math.huge
				local n7 = tonumber(v12.maxPlayers) or 0

				if str6 ~= "" and str6 ~= str3 and huge < n7 then
					tbl6[#tbl6 + 1] = { Id = str6, Playing = huge, Room = n7 - huge }
				end
			end

			if #tbl6 > 0 and not flag3 then
				break
			end
			nextPageCursor = result.nextPageCursor
			if not nextPageCursor or nextPageCursor == "" then
				break
			end
		end

		return tbl6, true
	end

	local function serverHop(arg)
		local v11

		if v10 and str2 == arg and os.clock() - n4 < n5 then
			v11 = v10
		else
			local v12
			v11, v12 = fn11(arg)
			if not v12 then
				return "fetch"
			end
			v10 = v11
			str2 = arg
			n4 = os.clock()
		end

		local function fn12(arg2)
			local tbl6 = {}

			for _, v12 in ipairs(v11) do
				if not tbl5[v12.Id] and v12.Room >= arg2 then
					tbl6[#tbl6 + 1] = v12
				end
			end

			return tbl6
		end

		local v12 = fn12(2)

		if #v12 == 0 then
			v12 = fn12(1)
		end

		if #v12 == 0 and next(tbl5) ~= nil then
			table.clear(tbl5)
			v12 = fn12(1)
		end

		if #v12 == 0 then
			fn10(nil)
			v10 = nil
			return "empty"
		end

		local id

		if arg == "Random" then
			id = v12[math.random(1, #v12)].Id
		else
			table.sort(v12, function(arg2, arg3)
				if arg == "Least Players" then
					return arg2.Playing < arg3.Playing
				end
				return arg2.Playing > arg3.Playing
			end)

			id = v12[1].Id
		end

		flag2 = false
		v9 = id
		n2 = os.clock() + n
		pcall(fn9)

		if not pcall(function()
			TeleportService:TeleportToPlaceInstance(game.PlaceId, id, localPlayer)
		end) then
			fn10(id)
			return "failed"
		end

		local n6 = os.clock() + n

		while os.clock() < n6 do
			if flag2 then
				return "denied"
			end
			task.wait(0.25)
		end

		return "waiting"
	end

	tbl2.ServerHop = serverHop

	v7:Dropdown({
		Title = "Server Hop Mode",
		Values = { "Most Players", "Random", "Least Players" },
		Value = "Least Players",
		Callback = function(arg)
			str = tostring(arg or "Least Players")
		end,
	})

	v7:Button({
		Title = "Server Hop",
		Callback = function()
			n3 += 1
			local v11 = n3

			task.spawn(function()
				flag = true
				local n6 = 0

				while v11 == n3 do
					n6 += 1
					local v12 = serverHop(str)

					if not (v12 == "waiting" or v11 ~= n3) then
						if v12 == "empty" then
							v10 = nil
							table.clear(tbl5)
						end

						if n6 % 10 == 0 then
							fn5("Server Hop", string.format("Every server was full so far, %d tries.", n6))
						end

						task.wait(v12 == "fetch" and 1 or 0.1)
						continue
					end

					break
				end

				if v11 == n3 then
					flag = false
				end
			end)
		end,
	})

	local n6 = 8
	local n7 = 0
	local str3 = ""
	local v11 = nil

	local function fn12()
		return os.clock() < n7
	end

	local function fn13(arg)
		n7 = arg and os.clock() + n6 or 0
	end

	local function fn14(arg)
		local match = tostring(arg or ""):match("^%s*(.-)%s*$")
		return match:match("%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x") or match
	end

	local function fn15()
		local v12 = str3
		local result = str3

		if v11 then
			local ok

			ok, result = pcall(function()
				local controller = v11._controller
				return controller and controller.GetValue and controller.GetValue()
			end)

			if not (ok and type(result) == "string" and result ~= "") then
				local exitTo = nil

				for _, v13 in ipairs({ "Get", "GetValue", "GetText" }) do
					local ok2, result2 = pcall(function()
						return v11[v13]
					end)

					if ok2 and type(result2) == "function" then
						local ok3
						ok3, result = pcall(result2, v11)
						if ok3 and type(result) == "string" and result ~= "" then
							exitTo = 1
							break
						end
					end
				end

				if exitTo ~= 1 then
					result = v12
				end
			end
		end

		local v13 = fn14(result)

		if v13 == "" then
			local ok, result2 = pcall(function()
				local v14 = getclipboard or readclipboard or getrbxclipboard
				return type(v14) == "function" and v14() or nil
			end)

			if ok and type(result2) == "string" then
				v13 = fn14(result2)
			end
		end

		return v13
	end

	local function fn16(arg)
		if not v11 then
			return
		end

		pcall(function()
			local controller = v11._controller

			if controller and controller.SetValue then
				controller.SetValue(arg, false)
			end
		end)

		str3 = fn14(arg)
	end

	local function fn17(arg)
		fn13(true)
		pcall(AutoLoadBeforeTeleport)

		if not pcall(function()
			if game.JobId ~= "" then
				TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, localPlayer)
			else
				TeleportService:Teleport(game.PlaceId, localPlayer)
			end
		end) then
			fn13(false)
			fn5(arg, "Roblox could not rejoin the server.")
		end
	end

	pcall(function()
		TeleportService.TeleportInitFailed:Connect(function(arg, arg2, arg3)
			if not fn12() then
				return
			end
			fn13(false)
			fn5("Teleport Failed", tostring(arg3 ~= "" and arg3 or arg2))
		end)
	end)

	v11 = v7:Input({
		Title = "Job ID",
		Placeholder = "Paste a server Job ID...",
		Value = "",
		Callback = function(arg)
			str3 = fn14(arg)
		end,
	})

	if v11 then
		v11._configIgnored = true

		if v11.State and not v11.State._registered then
			v11.State._configIgnored = true
		end
	end

	v7:Button({
		Title = "Join Job ID",
		Callback = function()
			if fn12() then
				fn5("Join Job ID Failed", "A teleport is already running, try again shortly.")
				return
			end
			local v12 = fn15()
			if v12 == "" then
				fn5("Join Job ID Failed", "Paste a valid Job ID first.")
				return
			end
			fn13(true)
			pcall(AutoLoadBeforeTeleport)

			if not pcall(function()
				TeleportService:TeleportToPlaceInstance(game.PlaceId, v12, localPlayer)
			end) then
				fn13(false)
				fn5("Join Job ID Failed", "Roblox could not join that server.")
			end
		end,
	})

	v7:Button({
		Title = "Copy Current Job ID",
		Callback = function()
			local str4 = tostring(game.JobId or "")
			fn16(str4)
			local v12 = setclipboard or toclipboard
			fn5((type(v12) == "function" and pcall(v12, str4) or false) and "Job ID Copied" or "Job ID Shown", str4)
		end,
	})

	v7:Button({
		Title = "Rejoin Server",
		Callback = function()
			if fn12() then
				fn5("Rejoin Failed", "A teleport is already running, try again shortly.")
				return
			end
			fn17("Rejoin Failed")
		end,
	})
end

local v8
v8 = v2:Tab({ Title = "Misc", Icon = "settings" })
local v9
v9 = v8:Section({ Title = "Performance" })
local flag = false

v9:Slider({
	Title = "FPS Cap",
	Step = 1,
	Value = {
		Min = 30,
		Max = 1000,
		Default = 240,
	},
	Callback = function(arg)
		local n = math.clamp(math.floor(tonumber(arg) or 240), 30, 1000)
		if type(setfpscap) == "function" and pcall(setfpscap, n) then
			flag = false
			return
		end

		if not flag then
			flag = true
			fn5("FPS Cap Unavailable", "This environment does not support setfpscap.")
		end
	end,
})

do
	local Lighting = game:GetService("Lighting")
	local n = 0.003
	local flag2 = false
	local n2 = 0
	local thread = nil
	local tbl5 = {}
	local tbl6 = {}
	local obj = setmetatable({}, { __mode = "k" })
	local tbl7 = {}
	local connection = nil

	local function fn7(arg, arg2, arg3)
		local ok, result = pcall(arg)
		if not ok then
			return
		end
		tbl6[#tbl6 + 1] = { Setter = arg2, Value = result }
		pcall(arg2, arg3)
	end

	local function fn8(arg, arg2, arg3)
		local tbl8 = obj[arg]

		if not tbl8 then
			tbl8 = {}
			obj[arg] = tbl8
		end

		if tbl8[arg2] == nil then
			local ok, result = pcall(function()
				return arg[arg2]
			end)

			if not ok then
				return
			end
			tbl8[arg2] = { Value = result }
		end

		pcall(function()
			arg[arg2] = arg3
		end)
	end

	local function fn9(arg)
		if not flag2 or not arg.Parent then
			return
		end

		if arg:IsA("ParticleEmitter") then
			fn8(arg, "Enabled", false)
			fn8(arg, "Rate", 0)
		elseif arg:IsA("Trail") or arg:IsA("Beam") then
			fn8(arg, "Enabled", false)
		elseif arg:IsA("PointLight") or arg:IsA("SpotLight") or arg:IsA("SurfaceLight") then
			fn8(arg, "Enabled", false)
			fn8(arg, "Brightness", 0)
		elseif arg:IsA("Fire") or arg:IsA("Smoke") or arg:IsA("Sparkles") then
			fn8(arg, "Enabled", false)
		elseif arg:IsA("Explosion") then
			fn8(arg, "Visible", false)
		elseif arg:IsA("SpecialMesh") then
			fn8(arg, "TextureId", "")
		elseif arg:IsA("Decal") or arg:IsA("Texture") then
			if not (arg.Name == "face" and arg.Parent and arg.Parent.Name == "Head") then
				fn8(arg, "Transparency", 1)
			end
		elseif arg:IsA("MeshPart") then
			fn8(arg, "RenderFidelity", Enum.RenderFidelity.Performance)
			fn8(arg, "TextureID", "")
			fn8(arg, "CastShadow", false)
			fn8(arg, "Reflectance", 0)
			fn8(arg, "Material", Enum.Material.SmoothPlastic)
		elseif arg:IsA("BasePart") then
			fn8(arg, "CastShadow", false)
			fn8(arg, "Reflectance", 0)
			fn8(arg, "Material", Enum.Material.SmoothPlastic)
		elseif arg:IsA("PostEffect") then
			fn8(arg, "Enabled", false)
		elseif arg:IsA("Clouds") then
			fn8(arg, "Cover", 0)
			fn8(arg, "Density", 0)
		elseif arg:IsA("Atmosphere") then
			fn8(arg, "Density", 0)
			fn8(arg, "Haze", 0)
			fn8(arg, "Glare", 0)
		end
	end

	local function fn10()
		for _, v10 in ipairs(tbl5) do
			if v10.Connected then
				v10:Disconnect()
			end
		end

		table.clear(tbl5)

		if connection then
			pcall(function()
				connection:Disconnect()
			end)

			connection = nil
		end
	end

	local function fn11()
		local rendering = settings().Rendering
		local terrain = workspace.Terrain

		local function fn12(arg, arg2, arg3)
			fn7(function()
				return arg[arg2]
			end, function(arg4)
				arg[arg2] = arg4
			end, arg3)
		end

		fn12(rendering, "QualityLevel", Enum.QualityLevel.Level01)
		fn12(rendering, "MeshPartDetailLevel", Enum.MeshPartDetailLevel.Level01)
		fn12(rendering, "EditQualityLevel", Enum.QualityLevel.Level01)

		local ok, result = pcall(function()
			return UserSettings():GetService("UserGameSettings")
		end)

		if ok and result then
			fn12(result, "SavedQualityLevel", Enum.SavedQualitySetting.QualityLevel1)
		end

		fn12(Lighting, "GlobalShadows", false)
		fn12(Lighting, "ShadowSoftness", 0)
		fn12(Lighting, "FogEnd", 9e9)
		fn12(Lighting, "Technology", Enum.Technology.Legacy)
		fn12(Lighting, "EnvironmentDiffuseScale", 0)
		fn12(Lighting, "EnvironmentSpecularScale", 0)
		fn12(terrain, "Decoration", false)
		fn12(terrain, "WaterWaveSize", 0)
		fn12(terrain, "WaterWaveSpeed", 0)
		fn12(terrain, "WaterReflectance", 0)
		fn12(terrain, "WaterTransparency", 1)
	end

	local function fn12(arg, arg2)
		local now = os.clock()

		for _, descendant in ipairs(arg:GetDescendants()) do
			if not flag2 or n2 ~= arg2 then
				return false
			end
			fn9(descendant)

			if n < os.clock() - now then
				RunService.Heartbeat:Wait()
				now = os.clock()
			end
		end

		return true
	end

	local function fn13()
		if not flag2 or #tbl7 == 0 then
			return
		end
		local now = os.clock()

		while #tbl7 > 0 do
			local v10 = table.remove(tbl7)
			fn9(v10)
			if not (n < os.clock() - now) then
				continue
			end
			break
		end
	end

	local function fn14()
		local now = os.clock()

		for k, v10 in pairs(obj) do
			if k.Parent then
				for k2, v11 in pairs(v10) do
					pcall(function()
						k[k2] = v11.Value
					end)
				end
			end

			obj[k] = nil

			if os.clock() - now > n then
				RunService.Heartbeat:Wait()
				now = os.clock()
			end
		end
	end

	local function fn15()
		if not flag2 then
			return
		end
		flag2 = false
		n2 += 1
		fn10()
		table.clear(tbl7)

		if thread then
			pcall(task.cancel, thread)
			thread = nil
		end

		fn14()

		for i = #tbl6, 1, -1 do
			local v10 = tbl6[i]
			pcall(v10.Setter, v10.Value)
		end

		table.clear(tbl6)
	end

	local function fn16()
		if flag2 then
			return
		end
		flag2 = true
		n2 += 1
		local v10 = n2
		fn11()

		local function fn17(arg)
			tbl5[#tbl5 + 1] = arg.DescendantAdded:Connect(function(descendant)
				if flag2 and n2 == v10 then
					tbl7[#tbl7 + 1] = descendant
				end
			end)
		end

		fn17(workspace)
		fn17(Lighting)

		connection = RunService.Heartbeat:Connect(function()
			if flag2 and n2 == v10 then
				fn13()
			end
		end)

		thread = task.spawn(function()
			if fn12(workspace, v10) then
				fn12(Lighting, v10)
			end
		end)
	end

	fn3(fn15)

	fn_trackToggle(v9, {
		Title = "Optimizer",
		Desc = "Strip shadows, textures and effects for the highest FPS",
		Default = false,
		Callback = function(arg)
			if arg then
				fn16()
			else
				task.spawn(fn15)
			end
		end,
	})
end

do
	local Stats = game:GetService("Stats")
	local n = 132
	local n2 = 0.085
	local n3 = 0.2
	local n4 = 8
	local v10 = { _value = {} }
	function v10:Get()
		return self._value
	end
	function v10:Set(value)
		self._value = value
	end

	local function fn7()
		local v11 = v10:Get()
		if type(v11) == "table" and type(v11.XOffset) == "number" and type(v11.YOffset) == "number" then
			return UDim2.new(tonumber(v11.XScale) or 0, v11.XOffset, tonumber(v11.YScale) or 0, v11.YOffset)
		end
		return UDim2.new(0, 16, 0, 16)
	end

	local function fn8(arg)
		v10:Set({ XScale = arg.X.Scale, XOffset = arg.X.Offset, YScale = arg.Y.Scale, YOffset = arg.Y.Offset })
	end

	local color = Color3.fromRGB(58, 255, 55)
	local color2 = Color3.fromRGB(255, 214, 84)
	local color3 = Color3.fromRGB(255, 96, 96)
	local color4 = Color3.fromRGB(150, 150, 158)
	local flag2 = false
	local tbl5 = {}
	local screenGui = nil
	local frame = nil
	local uiScale = nil
	local v11 = nil
	local v12 = nil
	local n5 = 1
	local n6 = 0
	local n7 = 0
	local v13 = nil
	local v14 = nil
	local font = nil

	pcall(function()
		font = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal)
	end)

	local function fn9(arg)
		if arg >= 100 then
			return color
		end

		if arg >= 50 then
			return color2
		end
		return color3
	end

	local function fn10(arg)
		if arg <= 90 then
			return color
		end

		if arg <= 180 then
			return color2
		end
		return color3
	end

	local function fn11()
		if not uiScale then
			return
		end
		local currentCamera = workspace.CurrentCamera
		currentCamera = currentCamera and currentCamera.ViewportSize or Vector2.new(1280, 720)

		if currentCamera.X < 1 then
			currentCamera = Vector2.new(1280, 720)
		end

		uiScale.Scale = math.clamp(currentCamera.X * n2 / n, 0.7, 1.4) * n5
	end

	local function fn12()
		for _, v15 in ipairs(tbl5) do
			pcall(function()
				v15:Disconnect()
			end)
		end

		table.clear(tbl5)

		if screenGui then
			pcall(function()
				screenGui:Destroy()
			end)
		end

		screenGui = nil
		frame = nil
		uiScale = nil
		v11 = nil
		v12 = nil
		v13 = nil
		v14 = nil
		n6 = 0
	end

	local function createTextLabel(parent, arg, arg2, textColor3)
		local textLabel = Instance.new("TextLabel")
		textLabel.Name = fn2()
		textLabel.BackgroundTransparency = 1
		textLabel.Position = UDim2.fromOffset(arg, 9)
		textLabel.Size = UDim2.fromOffset(arg2, 16)
		textLabel.Text = ""
		textLabel.TextColor3 = textColor3
		textLabel.TextScaled = true
		textLabel.TextXAlignment = Enum.TextXAlignment.Left

		if font then
			textLabel.FontFace = font
		else
			textLabel.Font = Enum.Font.GothamBold
		end

		textLabel.Parent = parent
		return textLabel
	end

	local function fn13()
		fn12()
		screenGui = Instance.new("ScreenGui")
		screenGui.Name = fn2()
		screenGui.Archivable = false
		screenGui.DisplayOrder = 58
		screenGui.IgnoreGuiInset = true
		screenGui.ResetOnSpawn = false
		screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		frame = Instance.new("Frame")
		frame.Name = fn2()
		frame.Active = true
		frame.BackgroundColor3 = Color3.fromRGB(8, 8, 10)
		frame.BackgroundTransparency = 0.08
		frame.BorderSizePixel = 0
		frame.Position = fn7()
		frame.Size = UDim2.fromOffset(148, 46)
		frame.Parent = screenGui
		local uiCorner = Instance.new("UICorner")
		uiCorner.Name = fn2()
		uiCorner.CornerRadius = UDim.new(0, 10)
		uiCorner.Parent = frame
		local uiStroke = Instance.new("UIStroke")
		uiStroke.Name = fn2()
		uiStroke.Color = Color3.fromRGB(255, 255, 255)
		uiStroke.Thickness = 1
		uiStroke.Transparency = 0.85
		uiStroke.Parent = frame
		uiScale = Instance.new("UIScale")
		uiScale.Name = fn2()
		uiScale.Parent = frame
		fn11()

		local divider = Instance.new("Frame")
		divider.Name = fn2()
		divider.AnchorPoint = Vector2.new(0.5, 0.5)
		divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		divider.BackgroundTransparency = 0.85
		divider.BorderSizePixel = 0
		divider.Position = UDim2.new(0.5, 0, 0.5, 0)
		divider.Size = UDim2.new(0, 1, 0, 30)
		divider.Parent = frame

		local function createColumn(x, labelText)
			local column = Instance.new("Frame")
			column.Name = fn2()
			column.BackgroundTransparency = 1
			column.Position = UDim2.new(0, x, 0, 0)
			column.Size = UDim2.new(0, 68, 1, 0)
			column.Parent = frame

			local labelCaption = Instance.new("TextLabel")
			labelCaption.Name = fn2()
			labelCaption.BackgroundTransparency = 1
			labelCaption.Position = UDim2.fromOffset(0, 5)
			labelCaption.Size = UDim2.new(1, 0, 0, 12)
			labelCaption.Text = labelText
			labelCaption.TextColor3 = color4
			labelCaption.TextScaled = true
			labelCaption.TextXAlignment = Enum.TextXAlignment.Center
			if font then
				labelCaption.FontFace = font
			else
				labelCaption.Font = Enum.Font.GothamBold
			end
			labelCaption.Parent = column

			local valueLabel = Instance.new("TextLabel")
			valueLabel.Name = fn2()
			valueLabel.BackgroundTransparency = 1
			valueLabel.Position = UDim2.fromOffset(0, 18)
			valueLabel.Size = UDim2.new(1, 0, 0, 22)
			valueLabel.Text = ""
			valueLabel.TextColor3 = color
			valueLabel.TextScaled = true
			valueLabel.TextXAlignment = Enum.TextXAlignment.Center
			if font then
				valueLabel.FontFace = font
			else
				valueLabel.Font = Enum.Font.GothamBold
			end
			valueLabel.Parent = column

			return valueLabel
		end

		v11 = createColumn(4, "FPS")
		v12 = createColumn(76, "PING")
		screenGui.Parent = v3
		local currentCamera = workspace.CurrentCamera

		if currentCamera then
			tbl5[#tbl5 + 1] = currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fn11)
		end

		local flag3 = false
		local v15 = nil
		local vector2 = Vector2.zero
		local position = nil

		tbl5[#tbl5 + 1] = frame.InputBegan:Connect(function(input)
			if flag3 or input.UserInputState ~= Enum.UserInputState.Begin then
				return
			end
			local flag4 = input.UserInputType == Enum.UserInputType.Touch
			if not (input.UserInputType == Enum.UserInputType.MouseButton1) and not flag4 then
				return
			end
			flag3 = true
			v15 = flag4 and input or nil
			vector2 = Vector2.new(input.Position.X, input.Position.Y)
			position = frame.Position
		end)

		tbl5[#tbl5 + 1] = UserInputService.InputChanged:Connect(function(input)
			if not flag3 or not frame or not position then
				return
			end

			if not (v15 and input == v15 or not v15 and input.UserInputType == Enum.UserInputType.MouseMovement) then
				return
			end
			local n8 = Vector2.new(input.Position.X, input.Position.Y) - vector2
			frame.Position = UDim2.new(position.X.Scale, position.X.Offset + n8.X, position.Y.Scale, position.Y.Offset + n8.Y)
		end)

		tbl5[#tbl5 + 1] = UserInputService.InputEnded:Connect(function(input)
			if not flag3 then
				return
			end

			if v15 and input == v15 or not v15 and input.UserInputType == Enum.UserInputType.MouseButton1 then
				flag3 = false
				v15 = nil
				position = nil

				if frame then
					fn8(frame.Position)
				end
			end
		end)

		tbl5[#tbl5 + 1] = RunService.RenderStepped:Connect(function(deltaTime)
			if not flag2 or not v11 then
				return
			end
			local n8 = math.clamp(deltaTime, 0.001, 1)
			local n9 = 1 / n8

			if n6 <= 0 then
				n6 = n9
			else
				n6 += (n9 - n6) * (1 - math.exp(-n8 * n4))
			end

			local now = os.clock()
			if now < n7 then
				return
			end
			n7 = now + n3
			local n10 = math.floor(n6 + 0.5)
			local text = tostring(n10)

			if text ~= v13 then
				v13 = text
				v11.Text = text
				v11.TextColor3 = fn9(n10)
			end

			local n11 = 0

			pcall(function()
				n11 = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
			end)

			local n12 = math.floor(n11 + 0.5)
			local text2 = tostring(n12) .. "ms"

			if text2 ~= v14 then
				v14 = text2
				v12.Text = text2
				v12.TextColor3 = fn10(n12)
			end
		end)
	end

	fn_trackToggle(v9, {
		Title = "FPS and Ping",
		Default = true,
		Callback = function(arg)
			flag2 = arg == true

			if flag2 then
				fn13()
			else
				fn12()
			end
		end,
	})

	v9:Slider({
		Title = "FPS and Ping Size",
		Step = 1,
		Value = {
			Min = 60,
			Max = 160,
			Default = 100,
		},
		Callback = function(arg)
			n5 = math.clamp((tonumber(arg) or 100) / 100, 0.6, 1.6)
			fn11()
		end,
	})

	fn3(fn12)
end

do
	local v10 = v8:Section({ Title = "Utility" })
	local tbl5 = { Enabled = true, Alive = true }

	local function fn7()
		if type(getconnections) ~= "function" then
			return {}
		end
		local ok, result = pcall(getconnections, localPlayer.Idled)
		return ok and type(result) == "table" and result or {}
	end

	local function fn8()
		for _, v11 in ipairs(fn7()) do
			pcall(function()
				v11:Disable()
			end)
		end
	end

	local function fn9()
		for _, v11 in ipairs(fn7()) do
			pcall(function()
				v11:Enable()
			end)
		end
	end

	fn3(function()
		tbl5.Alive = false
		fn9()
	end)

	task.spawn(function()
		while tbl5.Alive do
			if tbl5.Enabled then
				fn8()
			end

			task.wait(30)
		end
	end)

	fn_trackToggle(v10, {
		Title = "Anti AFK",
		Default = true,
		Callback = function(arg)
			tbl5.Enabled = arg ~= false

			if tbl5.Enabled then
				fn8()
			else
				fn9()
			end
		end,
	})
end

do
	local v10 = v2:Tab({ Title = "Discord", Icon = "message-circle" }):Section({ Title = "Community" })
	local inviteUrl = "https://discord.gg/bRdE4sfddp"

	local perks = {
		{ Title = "New Scripts & Updates", Desc = "Patch notes and new game scripts are posted there first." },
		{ Title = "Giveaways", Desc = "Member giveaways and events are announced in the server." },
		{ Title = "Support", Desc = "Ask for help, report bugs and get answers from the team." },
		{ Title = "Suggestions", Desc = "Request features and vote on what gets added next." },
	}

	local function fn7()
		local setClip = setclipboard or toclipboard
		local ok = type(setClip) == "function" and pcall(setClip, inviteUrl) or false
		fn5(ok and "Discord Link Copied" or "Discord Link", inviteUrl)
	end

	v10:Paragraph({
		Title = "CAT HUB [Ride a Pet]",
		Desc = "Join the community server for updates, support and giveaways.",
		Thumbnail = "rbxassetid://128961717706452",
		ImageSize = 48,
		Buttons = {
			{ Title = "Copy Link", Icon = "link", Callback = fn7 },
		},
	})

	for _, perk in ipairs(perks) do
		v10:Paragraph({ Title = perk.Title, Desc = perk.Desc })
	end

	v10:Button({ Title = "Copy Discord Link", Callback = fn7 })
end