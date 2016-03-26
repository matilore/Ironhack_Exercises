require 'pry'
require 'colorize'

class Blog
	attr_reader :posts

	def initialize
		@posts = []
		@@page_number = 0
		@posts[@@page_number] = []
	end

	def publish_posts(post)
		if @posts[@@page_number].length < 3
			@posts[@@page_number]<<post
		else
			@@page_number += 1
			@posts[@@page_number] = []
			@posts[@@page_number]<<post
		end
	end

	def count_pages
		n_of_pages = []
		counter = 1
		@posts.each do |page|
			n_of_pages<<counter
			counter +=1
		end
		n_of_pages
	end

	def move_page(shift)
			puts 
			puts 'You can also move from page to page writing next or back'
			answer = gets.chomp
			if answer == 'next'
				shift += 1
				publish_front_page(shift)
			elsif answer == 'back'
				if shift == 0
					puts 'You are already in the last page'
				else
					shift -= 1
					publish_front_page(shift)				
				end					
			end
		end

		def colorize_page_n(shift)
				count_pages.each do |n|
				if n == shift + 1
					print n.to_s.colorize(:green) + ' '
				else
					print n.to_s + ' '
				end
			end			
		end

	def publish_front_page(shift = 0)
		@posts[shift].each do |post|
			puts post.title
			puts '*' * 10
			puts post.text
			puts '-' * 10
		end

		colorize_page_n(shift)

		move_page(shift)

	end
end

class Post
	attr_reader :title, :date, :text
	def initialize(title, text)
		@title = title
		@date = Time.now
		@text = text

	end
end

class SponsoredPost < Post
	def initialize(title, text)
		super
		@title = '*' * 5 + title + '*' * 5
		
	end
end


post1 = Post.new('Post1', 'This is the first post')
post2 = SponsoredPost.new('Post2', 'This is the second post')
post3 = Post.new('Post3', 'This is the third post')
post4 = Post.new('Post4', 'This is the fourth post')

ironblog = Blog.new

ironblog.publish_posts(post1)
ironblog.publish_posts(post2)
ironblog.publish_posts(post3)
ironblog.publish_posts(post4)
ironblog.publish_front_page
