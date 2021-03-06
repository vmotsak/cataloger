class ProductPolicy <ApplicationPolicy
  #Admin
  #Могут помечать некоторые продукты как PRO.
  def mark_as_pro?
    user && user.admin?
  end

  #Owner
  #Могут добавлять товары.
  def create?
    user && user.owner?
  end

  #Visitor
  #После регистрации могут видеть товары помеченные как PRO.
  #Не могут видеть название магазина в описании товара
  def show_shop_name?
    user.nil? || !user.visitor?
  end

  def buy?
    user && user.visitor? && @record.sellable?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.nil?
        scope.where(is_pro: [false, nil])
      else
        scope.all
      end
    end
  end
end
