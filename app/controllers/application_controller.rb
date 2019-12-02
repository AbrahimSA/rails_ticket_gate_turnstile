class ApplicationController < ActionController::Base


    def self.getTimes(time, direction)
        # exit = 1 or enter = 0. 
        #n = 4
        puts "time: #{time.to_s}"
        puts "direction: #{direction.to_s}"
        priority = 1
        array_times =[]
        wait_list = []
        # next_time = 0
        last_time = nil
        # If in the previous second the turnstile was not used (maybe it was used before, but not at the previous second), then the person who wants to leave goes first.
        # If in the previous second the turnstile was used as an exit, then the person who wants to leave goes first.
        # If in the previous second the turnstile was used as an entrance, then the person who wants to enter goes first.
    
        direction.each_with_index do |row, idx|
             #IF 
             if last_time < (time[idx]-1) && (direction.count == (idx + 1) || time[idx] < time[idx + 1])
                 last_time = time[idx] > last_time ? time[idx] : last_time + 1
                array_times.append(time[idx])
                priority = row
            elsif priority == row
                # last_time = time[idx]
                 last_time = time[idx] > last_time ? time[idx] : last_time + 1
                array_times.append(time[idx])
            else
                array_times.append(nil)
                wait_list.append(idx)
             end
            if wait_list.count > 0 && (direction.count == (idx + 1) || (last_time + 1) < time[idx + 1]) && last_time != -2
                wait_list.each_with_index do |r, i|
                    puts "wait_list STEP: #{i} - #{last_time} - #{r}"
                    last_time = last_time + 1
                    array_times[r] = last_time
                end
                priority = direction[wait_list[0]]
                wait_list =[]
             end
    
        end
       
        puts "array_times: #{array_times.to_s}"
        return array_times
    end


end
