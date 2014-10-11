class BoardSquare
	attr_accessor :position, :path  
	def initialize(position,path)
		@position = position
		@path = path
	end
end

def knight_moves(start,finish)
	queue = [BoardSquare.new(start,[start])]
	visited = [start]

	while !queue.empty?
		current_move = queue.shift
		possible = possible_moves(current_move.position).select {|move| !visited.include?(move)}

		if possible.include?(finish)
			current_move.path << finish
			if current_move.path.size - 1 == 1
				puts "You made it in #{current_move.path.size - 1} moves!  Here's your path:"
			else 
				puts "You made it in #{current_move.path.size - 1} moves!  Here's your path:"
			end
			current_move.path.each {|pos| p pos}
		end

		possible.each do |move|
			queue.push(BoardSquare.new(move,current_move.path + [move]))
			visited << move
		end
	end
end

def possible_moves(pos)
	position_change = [[-1,-2],[-2,-1],[-2,1],[-1,2],[1,2],[2,1],[2,-1],[1,-2]]
	moves = []
	position_change.each do |change|
		moves << [pos[0] + change[0],pos[1] + change[1]]
	end
	moves.select {|move| is_valid_move?(move)}
end

def is_valid_move?(move)
	(0 <= move[0] and move[0] < 8) and (0 <= move[1] and move[1] < 8 ) ? true : false
end

knight_moves([3,3],[0,0])