class CommandLineInterface

    def greet
        puts "Welcome!"
    end

    def display_teams
        Team.all.each do |team|
            puts "Press #{team.id} for #{team.name}."
        end
    end

    def tty_select_team
        prompt = TTY::Prompt.new 
        prompt.select("Select a team", Team.all.map{|team| team.name})
    end

    def tty_display_info_options(name)
        prompt = TTY::Prompt.new 
        options = [
            "Overall win-loss record",
            "All matches",
            "All wins",
            "All losses",
            "All draws",
            "Home matches",
            "Away matches",
            "Record against a specific team",            
            "Wins against a specific team",
            "Losses against a specific team",
            "Draws against a specific team",
            "Stadium info",
            "Change team",
            "Exit"
        ]
        user_input = prompt.select("\nYou have selected #{name}.\nChoose an option", options)
        case user_input
            when options[0] #Overall win-loss record
                display_record(name)
            when options[1] #All matches
                display_matches(name)
            when options[2] #Wins
                display_match_wins(name)
            when options[3] #Losses against a specific team
                display_match_losses(name)
            when options[4] #Draws against a specific team
                display_match_draws(name)
            when options[5] #Home matches
                display_home_matches(name)
            when options[6] #Away matches
                display_away_matches(name)
            when options[7] #All matches 
                display_record_against(name)
            when options[8] #Wins against a specific team 
                display_wins_against(name)
                # tty_display_info_options(tty_select_team)
            when options[9] #Losses against a specific team
                display_losses_against(name)
            when options[10] #Draws against a specific team
                display_draws_against(name)
            when options[11]
                display_stadium_info(name)
            when options[12] #Change team
                tty_display_info_options(tty_select_team)
            when options[13] #Exit
                puts "Goodbye"
        end
    end


    def get_user_input
        user_input = gets.chomp.to_i
    end

    def yes_no_prompt
        prompt = TTY::Prompt.new
        response = prompt.yes?("\nDo you want to continue?")
        if response
            tty_display_info_options(tty_select_team)
        else
            return
        end
    end

    def display_stadium_info(user_input)
        team = Team.find_by(name: user_input)
        puts "Team: #{user_input}"
        puts "Name: #{team.stadium.name}"
        puts "Location: #{team.stadium.location}"
        puts "Capacity: #{team.stadium.capacity}"
        yes_no_prompt
    end

    def get_users_team
        user_input = get_user_input

        if valid_team?(user_input)
            puts "You have selected #{Team.find(user_input).name}"
            user_input
            # display_team_stats(user_input)
        else
            puts "Invalid input, please try again."
            get_users_team
        end
    end

    def valid_team?(user_input)
        Team.all.map{|team| team.id}.include?(user_input)
    end

    def valid_info_option?(user_input)
        (1..13).to_a.include?(user_input)
    end

    def print_match_info(matches)
        matches.each do |m|
          puts "\nHome Team: #{Team.find(m.home_team_id).name}"
          puts "Away Team: #{Team.find(m.away_team_id).name}"
          puts "Final Score: #{Team.find(m.home_team_id).name} - #{m.home_team_score}, #{Team.find(m.away_team_id).name} - #{m.away_team_score}"
      end
    end

    def display_record(user_input)
        # puts "You have selected #{team.name}"
        team = Team.find_by(name: user_input)
        puts "#{team.name} has #{team.total_wins.length} wins, #{team.total_losses.length} losses, and #{team.total_draws.length} draws"
        yes_no_prompt
    end

    def display_matches(user_input)
        team = Team.find_by(name: user_input)
        print_match_info(team.all_matches)
        yes_no_prompt
    end

    def display_match_wins(user_input)
        team = Team.find_by(name: user_input)
        print_match_info(team.total_wins)        
        yes_no_prompt
    end

    def display_match_losses(user_input)
        team = Team.find_by(name: user_input)
        print_match_info(team.total_losses)        
        yes_no_prompt
    end


    def display_match_draws(user_input)
        team = Team.find_by(name: user_input)
        print_match_info(team.total_draws)        
        yes_no_prompt
    end

    def display_home_matches(user_input)
        team = Team.find_by(name: user_input)
        print_match_info(team.home_team_matches)        
        yes_no_prompt
    end

    def display_away_matches(user_input)
        team = Team.find_by(name: user_input)
        print_match_info(team.away_team_matches)        
        yes_no_prompt
    end

    def display_record_against(user_input)
        puts "Please select the team you would like to compare with #{user_input}."
        against_name = tty_select_team
        # binding.pry
        team = Team.find_by(name: user_input)
        against_team = Team.find_by(name: against_name)
        puts "#{team.name} has #{team.total_wins_against(against_name).length} wins, #{team.total_losses_against(against_name).length} losses, and #{team.total_draws_against(against_name).length} draws against #{against_name}."
        yes_no_prompt
    end

    def display_wins_against(user_input)
        puts "Please select the team you would like to compare with #{user_input}."
        # display_teams
        against_name = tty_select_team
        # binding.pry
        team = Team.find_by(name: user_input)
        against_team = Team.find_by(name: against_name)
        if team.total_wins_against(against_name).empty?
            puts "#{team.name} has no wins against #{against_team.name}"
            yes_no_prompt
        else
            print_match_info(team.total_wins_against(against_name))
            yes_no_prompt    
        end
    end

    def display_losses_against(user_input)
        puts "Please select the team you would like to compare with #{user_input}."
        # display_teams
        against_name = tty_select_team
        # binding.pry
        team = Team.find_by(name: user_input)
        against_team = Team.find_by(name: against_name)
        if team.total_losses_against(against_name).empty?
            puts "#{team.name} has no losses against #{against_team.name}"
            yes_no_prompt
        else
            print_match_info(team.total_losses_against(against_name))            
            yes_no_prompt
        end
    end

    def display_draws_against(user_input)
        puts "Please select the team you would like to compare with #{user_input}."
        # display_teams
        against_name = tty_select_team
        # binding.pry
        team = Team.find_by(name: user_input)
        against_team = Team.find_by(name: against_name)
        if team.total_draws_against(against_name).empty?
            puts "#{team.name} has no draws against #{against_team.name}"
            yes_no_prompt
        else
            print_match_info(team.total_draws_against(against_name))    
            yes_no_prompt    
        end
    end
end

