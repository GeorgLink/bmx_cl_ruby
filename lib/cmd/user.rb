require 'thor'

class User < Thor
  option :usermail , desc: "USERMAIL"   , required: true
  option :password , desc: "PASSWORD", required: true
  desc "create", "create a user"
  def create
    under_construction
  end

  desc "show USERMAIL", "show user information"
  def show(usermail)
    user = BmxApiRuby::UsersApi.new(client)
    ap user.get_users_usermail(usermail).to_hash
  end

  desc "deposit USERMAIL AMOUNT", "deposit user tokens"
  def deposit(usermail, _amount)
    under_construction
  end

  desc "withdraw USERMAIL AMOUNT", "withdraw user tokens"
  def withdraw(usermail,  _amount)
    under_construction
  end
end
