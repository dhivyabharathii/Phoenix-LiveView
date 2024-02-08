defmodule Ecommerce.Repo.Migrations.ProductAddColumRating do
  use Ecto.Migration

  def change do
    alter table("products") do
      add :rating, :integer
    end
  end
end
