class Account
  attr_reader :account_number, :name
  attr_accessor :balance

  def initialize(name, initial_balance)
    @name = name
    @balance = initial_balance
    @account_number = rand(10000..99999)
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    if amount > @balance
      puts "Insufficient funds!"
    else
      @balance -= amount
    end
  end
end

class Bank
  def initialize
    @accounts = {}
  end

  def create_account(name, initial_deposit)
    account = Account.new(name, initial_deposit)
    @accounts[account.account_number] = account
    puts "Account created successfully. Account Number: #{account.account_number}"
  end

  def deposit(account_number, amount)
    account = @accounts[account_number]
    if account
      account.deposit(amount)
      puts "Deposited #{amount}. New Balance: #{account.balance}"
    else
      puts "Account not found!"
    end
  end

  def withdraw(account_number, amount)
    account = @accounts[account_number]
    if account
      account.withdraw(amount)
      puts "Withdrawn #{amount}. New Balance: #{account.balance}"
    else
      puts "Account not found!"
    end
  end

  def transfer(from_acc_number, to_acc_number, amount)
    from_account = @accounts[from_acc_number]
    to_account = @accounts[to_acc_number]

    if from_account && to_account && from_account.balance >= amount
      from_account.withdraw(amount)
      to_account.deposit(amount)
      puts "Transferred #{amount} from Account #{from_acc_number} to Account #{to_acc_number}"
    else
      puts "Transfer failed. Check account numbers and balance."
    end
  end
end

# Example Usage
bank = Bank.new
bank.create_account("Alice", 1000)
bank.create_account("Bob", 500)
bank.deposit(10001, 200) # Assuming 10001 is Alice's account number
bank.withdraw(10002, 100) # Assuming 10002 is Bob's account number
bank.transfer(10001, 10002, 300)
