# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

locations= Location.create([
                               {name: "中西區"},
                               {name: "灣仔區"},
                               {name: "東區"},
                               {name: "南區"},
                               {name: "九龍-油尖旺區"},
                               {name: "九龍-深水埗區"},
                               {name: "九龍-九龍城區"},
                               {name: "九龍-黃大仙區"},
                               {name: "九龍-觀塘區"},
                               {name: "新界-北區"},
                               {name: "新界-大埔區"},
                               {name: "新界-沙田區"},
                               {name: "新界-西貢區"},
                               {name: "新界-荃灣區"},
                               {name: "新界-屯門區"},
                               {name: "新界-元朗區"},
                               {name: "新界-葵青區"},
                               {name: "新界-離島區"}
                           ])

tags = Tag.create([
                      {name: "手機"},
                      {name: "電腦"},
                      {name: "其他"}
                  ])

users = User.create([
                        {name: "陳大文", facebook_name: "chanbigman1", password: "123456",
                         password_confirmation: "123456", facebook_id: "chanbigman1", email: "chanbigman1@gmail.com"},
                        {name: "黃小明", facebook_name: "wongsiuming", password: "123456",
                         password_confirmation: "123456", facebook_id: "wongsiuming", email: "wongsiuming@gmail.com"},
                    ])


location_a = Location.first
tags_a =Tag.first
tags_b =Tag.last
user_a = User.first
user_b = User.last
items = Item.create([
                        {
                            name: "HTC 手機",
                            description: "九成新，功能齊全",
                            price: 500,
                            location: location_a,
                            tags: [tags_a, tags_b],
                            user: user_a,
                        },
                        {
                            name: "另一部手機",
                            description: "都幾好用",
                            price: 1000,
                            location: location_a,
                            tags: [tags_a, tags_b],
                            user: user_a,
                        }
                    ])

item_a = Item.first
item_b = Item.last
# pictures = Picture.create([
#                               {
#                                   item: item_a,
#                                   file: "http://www.wired.com/images_blogs/gadgetlab/2009/09/cliq-front-open-tmo.jpg"
#                               },
#                               {
#                                   item: item_a,
#                                   file: "http://cdn-static.zdnet.com/i/story/70/00/000436/wowcomputer.png"
#                               },
#                               {
#                                   item: item_b,
#                                   file: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMLm4eGiWXcbDDcyipCHsWnq2jygzc81yZUBql0m8YMzMmm6MyMQ"
#                               }
#                           ])

comments =Comment.create([
                             {
                                 message: "幾好呀",
                                 user: user_a,
                                 item: item_a

                             },
                             {
                                 message: "唔錯",
                                 user: user_b,
                                 item: item_a
                             },
                             {
                                 message: "差",
                                 user: user_a,
                                 item: item_b

                             }
])


