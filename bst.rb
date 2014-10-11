class Node
	attr_accessor :value, :left_child, :right_child
	def initialize(value,left_child=nil,right_child=nil)
		@value = value
		@left_child = left_child
		@right_child = right_child
	end
end

class BinarySearchTree
	attr_accessor :root
	def initialize(root = nil)
		@root = Node.new(root)
	end

	def build_tree(arr,left = 0, right = arr.length - 1)
		arr = merge_sort(arr)

		index_mid = left + (right-left)/2
		node = Node.new(arr[index_mid])
		
		Node.left_child = build_tree(arr,left,index_mid - 1)
		Node.right_child = build_tree(arr,index_mid + 1,right)

	end

	def merge_sort(arr)
		left,right,result = []
		if arr.length <= 1
			return arr
		else
			mid = arr.length / 2
			left = arr[0..mid-1]
			right = arr[mid..-1]
			
			left = merge_sort(left)
			right = merge_sort(right)

			result = merge(left,right)
		end
		return result
	end

	def merge(left,right)
		result = []
		while left.length > 0 and right.length > 0
			if left[0] <= right[0]
				result << left[0]
				left = left[1..-1]
			elsif left[0] > right[0]
				result << right[0]
				right = right[1..-1]
			end 
		end
		if left.length > 0
			result.concat left
		elsif right.length > 0
			result.concat right
		end
		result
	end

	def build_tree_ver2(arr) 
		if @root.value.nil?
			@root = Node.new(arr.shift)
		end
		arr.each {|n| insert_node(n,@root)}
	end

	def insert_node(value,node)
		if value < node.value
			if node.left_child.nil?
				node.left_child = Node.new(value)
			else 
				insert_node(value,node.left_child)
			end
		elsif value > node.value
			if node.right_child.nil?
				node.right_child = Node.new(value)
			else 
				insert_node(value,node.right_child)
			end
		end
	end

	def breadth_first_search(target)
		queue = [@root]
		while !queue.empty?
			current_node = queue.shift
			if current_node.value == target
				return current_node
			end
			if !current_node.left_child.nil?
				queue.unshift(current_node.left_child)
			end
			if !current_node.right_child.nil?
				queue.unshift(current_node.right_child)
			end
		end
		puts "Target not found"
		return nil
	end

	def depth_first_search(target)
		stack = [@root]
		while !stack.empty?
			current_node = stack.pop
			if current_node.value == target
				return current_node
			end
			if !current_node.left_child.nil?
				stack.push(current_node.left_child)
			end
			if !current_node.right_child.nil?
				stack.push(current_node.right_child)
			end
		end
		puts "Target not found"
		return nil
	end

	def dfs_rec(target,node = @root)
		current_node.value = node.value
		if current_node.value == target
			return current_node
		end
		if !current_node.left_child.nil?
			dfs_rec(target,current_node.left_child)
		end
		if !current_node.right_child.nil?
			dfs_rec(target,current_node.right_child)
		end
	end
end
arr = [5,3,4,6,1,99,100,45,63]
tree = BinarySearchTree.new
puts tree.build_tree_ver2(arr)
puts tree.breadth_first_search(99)
