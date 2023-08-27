class Admin < Member
	validates :role, inclusion: { in: ["admin"] }
end
