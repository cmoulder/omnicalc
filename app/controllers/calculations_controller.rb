class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    text_in_array=@text.downcase.split
    @word_count = text_in_array.length

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = text_in_array.join("").length

    no_punctuation = @text.downcase.gsub(/[^a-z0-9\s]/i, '').split
    @occurrences = no_punctuation.count { |x| x == @special_word }

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================
    monthly_i = @apr/12/100
    n_month=@years*12
    @monthly_payment = @principal*(monthly_i*(1 + monthly_i)**n_month)/((1 + monthly_i)**n_month - 1)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================
    time_diff = @starting - @ending
    @seconds = time_diff
    @minutes = time_diff/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/52

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================
    sorted_array = @numbers.sort
    @sorted_numbers = sorted_array

    @count = @numbers.length

    min1 = @numbers.min
    @minimum = min1

    max1 = @numbers.max
    @maximum = max1

    @range = max1-min1

    def median(array)
      len = array.length
      (array[(len - 1) / 2] + array[len / 2]) / 2.0
    end
    @median = median(sorted_array)

    @sum = @numbers.sum.to_f

    @mean = @sum/@count

    delta = @numbers.map { |i| i - @mean }
    delta_sq= delta.map{ |i| i**2}
    @variance = delta_sq.sum/(@count)

    @standard_deviation = @variance**0.5

    @mode = @numbers.max_by { |i| @numbers.count(i) }

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
