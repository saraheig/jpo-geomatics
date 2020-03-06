# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

case Rails.env
when 'development'
  User.delete_all
  User.create!(
    pseudo: 'tototutu',
    password: 'tototutu'
  )
end

Player.delete_all
Player.create!([{
                 pseudo: 'Lulu',
                 email: 'Lulu@gmail.com',
                 score_geo: 45,
                 score_gci: 55,
                 score_gen: 65
               }, {
                 pseudo: 'Mama',
                 email: 'Mama@outlook.com',
                 score_geo: 43,
                 score_gen: 63
               }, {
                 pseudo: 'Sasa',
                 email: 'Sasa@gmail.com',
                 score_geo: 47,
                 score_gen: 67
               }, {
                 pseudo: 'Soso',
                 email: 'Soso@gmail.com',
                 score_geo: 47,
                 score_gci: 57
               }, {
                 pseudo: 'Tibtib',
                 email: 'Tibtib@outlook.com',
                 score_geo: 47,
                 score_gci: 57,
                 score_gen: 67
               }])
