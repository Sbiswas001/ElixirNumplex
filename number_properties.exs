defmodule NumberProperties do
  def main do
    IO.write("Enter a positive number: ")
    num = String.to_integer(IO.gets(""))

    result = """
    Number is #{if is_even(num), do: "Even", else: "Odd"}
    Number of digits is #{digit_count(num)}
    Sum of digits is #{digit_sum(num)}
    Reverse of number is #{reverse(num)}
    Prime factorization is #{prime_factorization(num)}
    Prime factors are #{Enum.join(Enum.uniq(prime_factors(num)), ", ")}
    Number of prime factors is #{Enum.count(Enum.uniq(prime_factors(num)))}
    Sum of prime factors is #{Enum.sum(Enum.uniq(prime_factors(num)))}
    Factors of #{num} are #{Enum.join(Enum.uniq(factors(num)), ", ")}
    Number of factors is #{Enum.count(Enum.uniq(factors(num)))}
    Sum of factors is #{Enum.sum(Enum.uniq(factors(num)))}
    #{num} is #{if !is_prime(num), do: "a Composite", else: "not a Composite"} number
    Binary representation is #{Integer.to_string(num, 2)}
    Octal representation is #{Integer.to_string(num, 8)}
    Hexadecimal representation is #{Integer.to_string(num, 16) |> String.upcase()}
    #{num} is #{if is_palindrome(num), do: "a Palindrome", else: "not a Palindrome"} number
    #{num} is #{if is_niven(num), do: "a Niven", else: "not a Niven"} number
    #{num} is #{if is_emirp(num), do: "an Emirp", else: "not an Emirp"} number
    #{num} is #{if is_abundant(num) <= 0, do: "not an Abundant number", else: "an Abundant number with Abundance #{is_abundant(num)}"}
    #{num} is #{if is_tech(num), do: "a Tech", else: "not a Tech"} number
    #{num} is #{if is_disarium(num), do: "a Disarium", else: "not a Disarium"} number
    #{num} is #{if is_pronic(num), do: "a Pronic", else: "not a Pronic"} number
    #{num} is #{if is_automorphic(num), do: "an Automorphic", else: "not an Automorphic"} number
    #{num} is #{if is_kaprekar(num), do: "a Kaprekar", else: "not a Kaprekar"} number
    #{num} is #{if is_special(num), do: "a Special", else: "not a Special"} number
    #{num} is #{if is_lucas(num), do: "a Lucas", else: "not a Lucas"} number
    #{num} is #{if is_smith(num), do: "a Smith", else: "not a Smith"} number
    #{num} is #{if is_armstrong(num), do: "an Armstrong", else: "not an Armstrong"} number
    #{num} is #{if is_fibonacci(num), do: "a Fibonacci", else: "not a Fibonacci"} number
    #{num} is #{if is_circular_prime(num), do: "a Circular Prime", else: "not a Circular Prime"} number
    #{num} is #{if is_palindrome(num) and is_prime(num), do: "a Prime Palindrome", else: "not a Prime Palindrome"} number
    #{num} is #{if is_fermat(num), do: "a Fermat", else: "not a Fermat"} number
    #{num} is #{if is_ugly(num), do: "an Ugly", else: "not an Ugly"} number
    #{num} is #{if is_neon(num), do: "a Neon", else: "not a Neon"} number
    #{num} is #{if is_spy(num), do: "a Spy", else: "not a Spy"} number
    #{num} is #{if is_happy(num), do: "a Happy", else: "not a Happy"} number
    #{num} is #{if is_duck(num), do: "a Duck", else: "not a Duck"} number
    """

    IO.puts(result)
  end

  def is_even(number), do: rem(number, 2) == 0

  def digit_count(number), do: Integer.digits(number) |> length()

  def digit_sum(number), do: Integer.digits(number) |> Enum.sum()

  def digit_product(number), do: Enum.reduce(Integer.digits(number), 1, &*/2)

  def reverse(number), do: Integer.digits(number) |> Enum.reverse() |> Integer.undigits()

  def is_palindrome(number), do: number == reverse(number)

  def is_prime(n) when n <= 1, do: false
  def is_prime(2), do: true
  def is_prime(n) when rem(n, 2) == 0, do: false
  def is_prime(n) do
    Enum.all?(3..:math.sqrt(n) |> trunc(), fn i -> rem(n, i) != 0 end)
  end

  def prime_factors(n) do
    2..n
    |> Enum.filter(&is_prime/1)
    |> Enum.reduce([], fn i, acc ->
      if rem(n, i) == 0, do: [i | acc], else: acc
    end)
    |> Enum.reverse()
  end

  def prime_factorization(n) do
    factors = prime_factors(n)
    factor_count = Enum.frequencies(factors)
    Enum.map(factor_count, fn {factor, count} -> "#{factor}^#{count}" end)
    |> Enum.join(" × ")
  end

  def factors(n) do
    1..n
    |> Enum.filter(fn i -> rem(n, i) == 0 end)
  end

  def is_niven(number), do: rem(number, digit_sum(number)) == 0

  def is_emirp(number), do: is_prime(number) and is_prime(reverse(number))

  def is_abundant(number), do: Enum.sum(factors(number)) - number - number

  def is_tech(number) do
    digits = Integer.digits(number)
    if rem(length(digits), 2) != 0 do
      false
    else
      {first_half, second_half} = Enum.split(digits, div(length(digits), 2))
      sum = Integer.undigits(first_half) + Integer.undigits(second_half)
      sum * sum == number
    end
  end

  def is_disarium(number) do
    digits = Integer.digits(number)
    Enum.with_index(digits, 1)
    |> Enum.reduce(0, fn {digit, index}, acc -> acc + :math.pow(digit, index) |> round() end)
    |> Kernel.==(number)
  end

  def is_pronic(number), do: Enum.any?(0..number, fn x -> x * (x + 1) == number end)

  def is_automorphic(number) do
    square = number * number
    Integer.to_string(square) |> String.ends_with?(Integer.to_string(number))
  end

  def is_kaprekar(number) do
    square = number * number
    square_str = Integer.to_string(square)
    (1..String.length(square_str) - 1)
    |> Enum.any?(fn i ->
      {first_part, second_part} = String.split_at(square_str, i)
      if String.length(first_part) > 0 and String.length(second_part) > 0 do
        first = String.to_integer(first_part)
        second = String.to_integer(second_part)
        first + second == number
      else
        false
      end
    end)
  end

  def is_special(number) do
    Integer.digits(number)
    |> Enum.map(&factorial/1)
    |> Enum.sum() == number
  end

  def factorial(0), do: 1
  def factorial(n), do: Enum.reduce(1..n, 1, &*/2)

  def is_lucas(number), do: is_lucas(number, 2, 1)
  defp is_lucas(number, a, b) when number in [a, b], do: true
  defp is_lucas(number, a, b) when b > number, do: false
  defp is_lucas(number, a, b), do: is_lucas(number, b, a + b)

  def is_smith(number) do
    if is_prime(number), do: false, else: digit_sum(number) == digit_sum(Enum.sum(prime_factors(number)))
  end

  def is_armstrong(number) do
    digits = Integer.digits(number)
    len = length(digits)
    Enum.map(digits, &(:math.pow(&1, len) |> round())) |> Enum.sum() == number
  end

  def is_fibonacci(number), do: is_perfect_square(5 * number * number + 4) or is_perfect_square(5 * number * number - 4)

  defp is_perfect_square(n), do: :math.sqrt(n) |> round() |> (&(&1 * &1 == n)).()

  def is_circular_prime(number) do
    digits = Integer.digits(number)
    Enum.all?(0..length(digits) - 1, fn _ ->
      number = rotate_number(number)
      is_prime(number)
    end)
  end

  defp rotate_number(number) do
    digits = Integer.digits(number)
    [head | tail] = digits
    Integer.undigits(tail ++ [head])
  end

  def is_fermat(number) do
    if number in [3, 5], do: true, else: false
  end

  def is_ugly(number) do
    prime_factors = prime_factors(number)
    Enum.all?(prime_factors, fn factor -> factor in [2, 3, 5] end)
  end

  def is_neon(number) do
    digit_sum(number * number) == number
  end

  def is_spy(number) do
    digit_sum(number) == digit_product(number)
  end

  def is_happy(number) do
    happy(number, [])
  end

  defp happy(1, _), do: true
  defp happy(n, seen) when n in seen, do: false
  defp happy(n, seen) do
    happy(digit_sum_square(n), [n | seen])
  end

  defp digit_sum_square(number) do
    Integer.digits(number)
    |> Enum.map(&(&1 * &1))
    |> Enum.sum()
  end

  def is_duck(number) do
    digits = Integer.digits(number)
    Enum.any?(digits, fn digit -> digit == 0 end)
  end
end

NumberProperties.main()
