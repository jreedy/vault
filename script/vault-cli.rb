#!/usr/bin/env rails runner

def user_header
    puts "||  User ID | " + "Username".center(25) + " | " +  "Password".center(8) + " | " +  "Role One | Role Two | Role Three ||"
end

def user_row(user)
  puts "|| #{user.id.to_s.center(8)} | #{user.username.center(25)} | ******** | #{(user.role_one ? "*" : " ").center(8) } | #{(user.role_two ? "*" : " ").center(8)} | #{(user.role_three ? "*" : " ").center(10)} ||"  
end

def show_user_list
  user_header
  puts "||            " + "--------".center(25) + "   " +  "--------".center(8) + " | " +  "--------   --------   ---------- ||"
  User.all.each do |user|
    user_row(user)
  end
end

def list_prompt
  puts 
  puts "Enter a User ID to edit a user"
  print "> "
  user_id = gets.to_s.chomp
  #puts "user selected " + user_id
  if [1,2,3].include?(user_id.to_i)
    edit_user(user_id.to_i)
  else 
    clear_screen
    show_user_list
    puts
    puts user_id + " is not a valid selection.  Select a User ID."
    list_prompt
  end
end

def edit_user(user_id)
  user = User.find(user_id)
  user_header
  user_row(user)
end

def clear_screen
    print "\e[2J\e[f"
end

show_user_list
list_prompt
