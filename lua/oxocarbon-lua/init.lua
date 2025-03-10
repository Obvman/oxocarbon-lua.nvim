local get_colors = function()
	local colors_path = 'oxocarbon-lua.colors'
	local background = vim.api.nvim_get_option('background')

	if background == 'dark' then
		return require(colors_path).dark
	elseif background == 'light' then
		return require(colors_path).light
	else
		vim.notify('Error: Background not set.', vim.log.levels.ERROR)
		return nil
	end
end

local set_terminal_colors = function(colors)
	if vim.g.oxocarbon_lua_keep_terminal then
		return
	end

	vim.api.nvim_set_var('terminal_color_background', colors[1])
	vim.api.nvim_set_var('terminal_color_foreground', colors[5])

	for x = 0,15 do
		vim.api.nvim_set_var('terminal_color_' .. x, colors[x + 1])
	end
end

local conditional_italic = function()
	if vim.g.oxocarbon_lua_disable_italic then
		return nil
	else
		return {'italic'}
	end
end

local conditional_bg = function(arg)
	if vim.g.oxocarbon_lua_transparent then
		return 'none'
	else
		return arg
	end
end

local extend_with_attributes = function(orig, attrs)
	if not attrs then
		return orig
	end

	for _, attr in ipairs(attrs) do
		orig[attr] = 1
	end
	return orig
end

return {
	load = function()
		local colors = get_colors()
		if not colors then
			return
		end

    vim.g.colors_name = 'oxocarbon-lua'

		vim.api.nvim_set_option('termguicolors', true)
		set_terminal_colors(colors)

		local highlight = function(name, fg, bg, attrs)
			local fg_color = colors[fg]
			local bg_color = colors[bg]

			vim.api.nvim_set_hl(
				0,
				name,
				extend_with_attributes(
					{
						fg = fg_color,
						bg = bg_color,
					},
					attrs
				)
			)
		end

		local none = 18

		-- editor
		highlight('ColorColumn', none, 2)
    highlight('Cursor', 1, 5)
    highlight('CursorLine', none, 2)
    highlight('CursorColumn', none, 2)
    highlight('CursorLineNr', 5, conditional_bg(none))
    highlight('QuickFixLine', none, 2)
    highlight('Error', 5, 12)
    highlight('LineNr', 4, conditional_bg(1))
    highlight('NonText', 3, conditional_bg(none))
    highlight('Normal', 5, conditional_bg(1))
    highlight('Pmenu', 5, 2)
    highlight('PmenuSbar', 5, 2)
    highlight('PmenuSel', 9, 3)
    highlight('PmenuThumb', 9, 3)
    highlight('SpecialKey', 4, none)
    highlight('Visual', none, 3)
    highlight('VisualNOS', none, 3)
    highlight('TooLong', none, 3)
    highlight('Debug', 14, none)
    highlight('Macro', 8, none)
    highlight('MatchParen', none, 3, {'underline'})
    highlight('Bold', none, none, {'bold'})
    highlight('Italic', none, none, {'italic'})
    highlight('Underlined', none, none, {'underline'})

		-- diagnostics
    highlight('DiagnosticWarn', 9, none)
    highlight('DiagnosticError', 11, none)
    highlight('DiagnosticInfo', 5, none)
    highlight('DiagnosticHint', 5, none)
    highlight('DiagnosticUnderlineWarn', 9, none, {'undercurl'})
    highlight('DiagnosticUnderlineError', 11, none, {'undercurl'})
    highlight('DiagnosticUnderlineInfo', 5, none, {'undercurl'})
    highlight('DiagnosticUnderlineHint', 5, none, {'undercurl'})

    -- lsp
    highlight('LspReferenceText', none, 4)
    highlight('LspReferenceread', none, 4)
    highlight('LspReferenceWrite', none, 4)
    highlight('LspSignatureActiveParameter', 9, none)

    -- gutter
    highlight('Folded', 4, conditional_bg(2))
    highlight('FoldColumn', 4, conditional_bg(1))
    highlight('SignColumn', 2, conditional_bg(1))

    -- navigation
    highlight('Directory', 9, none)

    -- prompts
    highlight('EndOfBuffer', 2, none)
    highlight('ErrorMsg', 5, 12)
    highlight('ModeMsg', 5, none)
    highlight('MoreMsg', 9, none)
    highlight('Question', 5, none)
    highlight('Substitute', 5, none)
    highlight('WarningMsg', 1, 14)
    highlight('WildMenu', 9, 2)

    -- search
    highlight('IncSearch', 7, 11)
    highlight('Search', 2, 9)

    -- tabs
    highlight('TabLine', 5, 2)
    highlight('TabLineFill', 5, 2)
    highlight('TabLineSel', 9, 4)

    -- window
    highlight('Title', 5, none)
    highlight('VertSplit', 2, 1)

    -- regular syntax
    highlight('Boolean', 10, none)
    highlight('Character', 15, none)
    highlight('Comment', 4, none)
    highlight('Conceal', none, none)
    highlight('Conditional', 10, none)
    highlight('Constant', 5, none)
    highlight('Decorator', 13, none)
    highlight('Define', 10, none)
    highlight('Delimeter', 7, none)
    highlight('Exception', 10, none)
    highlight('Float', 16, none)
    highlight('Function', 9, none)
    highlight('Identifier', 5, none)
    highlight('Include', 10, none)
    highlight('Keyword', 10, none)
    highlight('Label', 10, none)
    highlight('Number', 16, none)
    highlight('Operator', 10, none)
    highlight('PreProc', 10, none)
    highlight('Repeat', 10, none)
    highlight('Special', 5, none)
    highlight('SpecialChar', 5, none)
    highlight('SpecialComment', 9, none)
    highlight('Statement', 10, none)
    highlight('StorageClass', 10, none)
    highlight('String', 15, none)
    highlight('Structure', 10, none)
    highlight('Tag', 5, none)
    highlight('Todo', 14, none)
    highlight('Type', 10, none)
    highlight('Typedef', 10, none)

    -- treesitter
    highlight('TSAnnotation', 13, none)
    highlight('TSAttribute', 16, none)
    highlight('TSBoolean', 10, none)
    highlight('TSCharacter', 15, none)
    highlight('TSConstructor', 10, none)
    highlight('TSConditional', 10, none)
    highlight('TSConstant', 15, none)
    highlight('TSConstBuiltin', 8, none)
    highlight('TSConstMacro', 8, none)
    highlight('TSError', 12, none)
    highlight('TSException', 16, none)
    highlight('TSField', 5, none)
    highlight('TSFloat', 16, none)
    highlight('TSFuncBuiltin', 13, none)
    highlight('TSFuncMacro', 8, none)
    highlight('TSInclude', 10, none)
    highlight('TSKeyword', 10, none)
    highlight('TSKeywordFunction', 9, none)
    highlight('TSKeywordOperator', 9, none)
    highlight('TSLabel', 16, none)
    highlight('TSMethod', 8, none)
    highlight('TSNamespace', 5, none)
    highlight('TSNumber', 16, none)
    highlight('TSOperator', 10, none)
    highlight('TSParameter', 5, none)
    highlight('TSParameterReference', 5, none)
    highlight('TSProperty', 11, none)
    highlight('TSPunctDelimiter', 9, none)
    highlight('TSPunctBracket', 9, none)
    highlight('TSPunctSpecial', 9, none)
    highlight('TSRepeat', 10, none)
    highlight('TSString', 15, none)
    highlight('TSStringRegex', 8, none)
    highlight('TSStringEscape', 16, none)
    highlight('TSTag', 5, none)
    highlight('TSTagDelimiter', 16, none)
    highlight('TSText', 5, none)
    highlight('TSTitle', 11, none)
    highlight('TSLiteral', 5, none)
    highlight('TSType', 10, none)
    highlight('TSTypeBuiltin', 5, none)
    highlight('TSVariable', 5, none)
    highlight('TSVariableBuiltin', 5, none)
    highlight('TreesitterContext', none, 2)
    highlight('TSStrong', none, none, {'bold'})
    highlight('TSComment', 4, none, conditional_italic())
    highlight('TSFunction', 13, none, {'bold'})
    highlight('TSSymbol', 16, none, {'bold'})
    highlight('TSEmphasis', 11, none, {'bold'})
    highlight('TSUnderline', 11, none, {'underline'})
    highlight('TSStrike', 11, none, {'strikethrough'})
    highlight('TSURI', 15, none, {'underline'})
    highlight('TSCurrentScope', none, none, {'bold'})

    -- neovim
    highlight('NvimInternalError', 1, 9)
    highlight('NormalFloat', 6, 17)
    highlight('FloatBorder', 17, 17)
    highlight('NormalNC', 6, 1)
    highlight('TermCursor', 1, 5)
    highlight('TermCursorNC', 1, 5)

    -- statusline/winbar
    highlight('StatusLine', 4, 1)
    highlight('StatusLineNC', 3, 1)
    highlight('StatusReplace', 1, 9)
    highlight('StatusInsert', 1, 13)
    highlight('StatusVisual', 1, 15)
    highlight('StatusTerminal', 1, 12)
    highlight('StatusLineDiagnosticWarn', 15, 1, {'bold'})
    highlight('StatusLineDiagnosticError', 9, 1, {'bold'})
    highlight('WinBar', 20, 1, {'bold'})
    highlight('StatusPosition', 20, 1, {'bold'})
    highlight('StatusNormal', 20, 1, {'underline'})
    highlight('StatusCommand', 20, 1, {'underline'})

    -- telescope
		if vim.g.oxocarbon_lua_alternative_telescope then
			highlight('TelescopeBorder', 4, none)
			highlight('TelescopePromptNormal', 6, none)
			highlight('TelescopePromptPrefix', 8, none)
			
			highlight('TelescopeNormal', 5, none)
			
			highlight('TelescopePreviewTitle', 19, none)
			highlight('TelescopePromptTitle', 19, none)
			highlight('TelescopeResultsTitle', 19, none)
			
			highlight('TelescopeSelection', none, 3)
		else
			highlight('TelescopeBorder', 17, 17)
			highlight('TelescopePromptBorder', 3, 3)
			highlight('TelescopePromptNormal', 6, 3)
			highlight('TelescopePromptPrefix', 9, 3)
			highlight('TelescopeNormal', none, 17)
			highlight('TelescopePreviewTitle', 3, 12)
			highlight('TelescopePromptTitle', 3, 9)
			highlight('TelescopeResultsTitle', 17, 17)
			highlight('TelescopeSelection', none, 3)
			highlight('TelescopePreviewLine', none, 2)
		end

    -- notify
    highlight('NotifyERRORBorder', 9, none)
    highlight('NotifyWARNBorder', 16, none)
    highlight('NotifyINFOBorder', 6, none)
    highlight('NotifyDEBUGBorder', 14, none)
    highlight('NotifyTRACEBorder', 14, none)
    highlight('NotifyERRORIcon', 9, none)
    highlight('NotifyWARNIcon', 16, none)
    highlight('NotifyINFOIcon', 6, none)
    highlight('NotifyDEBUGIcon', 14, none)
    highlight('NotifyTRACEIcon', 14, none)
    highlight('NotifyERRORTitle', 9, none)
    highlight('NotifyWARNTitle', 16, none)
    highlight('NotifyINFOTitle', 6, none)
    highlight('NotifyDEBUGTitle', 14, none)
    highlight('NotifyTRACETitle', 14, none)

    -- cmp
    highlight('CmpItemAbbrMatchFuzzy', 5, none)
    highlight('CmpItemKindInterface', 12, none)
    highlight('CmpItemKindText', 9, none)
    highlight('CmpItemKindVariable', 14, none)
    highlight('CmpItemKindProperty', 11, none)
    highlight('CmpItemKindKeyword', 10, none)
    highlight('CmpItemKindUnit', 15, none)
    highlight('CmpItemKindFunction', 13, none)
    highlight('CmpItemKindMethod', 8, none)
    highlight('CmpItemAbbrMatch', 6, none, {'bold'})
    highlight('CmpItemAbbr', 20, none, {'bold'})

    -- nvimtree
    highlight('NvimTreeImageFile', 13, none)
    highlight('NvimTreeFolderIcon', 13, none)
    highlight('NvimTreeWinSeperator', 1, 1)
    highlight('NvimTreeFolderName', 10, none)
    highlight('NvimTreeIndentMarker', 3, none)
    highlight('NvimTreeEmptyFolderName', 16, none)
    highlight('NvimTreeOpenedFolderName', 16, none)
    highlight('NvimTreeNormal', 5, 17)

    -- neogit
    highlight('NeogitBranch', 11, none)
    highlight('NeogitRemote', 10, none)
    highlight('NeogitDiffAddHighlight', 14, 3)
    highlight('NeogitDiffDeleteHighlight', 10, 3)
    highlight('NeogitDiffContextHighlight', 5, 2)
    highlight('NeogitHunkHeader', 5, 3)
    highlight('NeogitHunkHeaderHighlight', 5, 4)

    -- gitsigns
    highlight('GitSignsAdd', 9, none)
    highlight('GitSignsChange', 10, none)
    highlight('GitSignsDelete', 15, none)

    -- parinfer
    highlight('Trailhighlight', 4, none)

    -- hydra
    highlight('HydraRed', 13, none)
    highlight('HydraBlue', 10, none)
    highlight('HydraAmaranth', 11, none)
    highlight('HydraTeal', 9, none)
    highlight('HydraPink', 15, none)
    highlight('HydraHint', none, 17)

    -- dashboard
    highlight('DashboardShortCut', 11, none)
    highlight('DashboardHeader', 16, none)
    highlight('DashboardCenter', 15, none)
    highlight('DashboardFooter', 9, none)
	end
}
