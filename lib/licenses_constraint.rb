class LicensesConstraint
	def matches?(request)
		SiteSetting.dl_custom_homepage_licensed
	end
end