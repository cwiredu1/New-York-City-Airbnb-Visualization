#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)





dashboardPage(skin='black',
              dashboardHeader(title='NYC Airbnb Data Project'),
              dashboardSidebar(
                sidebarMenu(
                  menuItem('Introduction',tabName= 'introduction',icon=icon('info')),
                  menuItem('Map',tabName = 'map',icon=icon('map')),
                  menuItem('Where to Stay',tabName = 'analytics',icon=icon('question')),
                  menuItem('Summaries',tabName = 'summaries',icon=icon('adjust')),
                  menuItem('Data',tabName = 'data',icon=icon('database')),
                  menuItem('About Charles',tabName= 'about',icon=icon('book')))),
              dashboardBody(
                tabItems(
                  tabItem(tabName='introduction',
                          HTML('
            <p><center><b><font size="7">Visualizing New York City Airbnb Data</font></b></center></p>
            <p><center><font size="5">Finding the Best Neighborhoods to Stay in New York City</font></center></p>
            <p><center>by Charles Wiredu</center></p>
            <p><center>
            <img src="https://img.freepik.com/free-photo/central-park-manhattan-new-york-huge-beautiful-park-surrounded-by-skyscraper-with-pond_181624-50335.jpg?w=1060&t=st=1691166415~exp=1691167015~hmac=35aa60102a0d407a29dc8565dedbede9b72f958ff9d6d9899ba4fa7c81e33bdd", height="600px" 
            style="float:center"/>
            </p>
            </p><center>
            </center></p>
            <p><center>
            The purpose of this project is to help users determine and make decision on the best neighborhood to stay in New York City, by 
            observing several factors such as: price, borough, property type, number of listings. Below is a summary of the tabs in this Shiny app, please 
            refer to each respective tab for more detailed insight and information.
            </center></p>
            
            <center><p>
          <table style="width: 417px; height: 258px;">
          <tbody>
          <tr>
          <td style="width: 120.671875px;"><u><b>Tab Name</b></u></td>
          <td style="width: 295.34375px;"><u><b>Description</b></u></td>
          </tr>
          <tr>
          <td style="width: 120.671875px;"><b>Map</b></td>
          <td style="width: 295.34375px;">Interactive map that displays average price of listings in each neighborhood.</td>
          </tr>
          <tr>
          <td style="width: 120.671875px;"><b>Where to Stay</b></td>
          <td style="width: 295.34375px;">Presents a maximum of 10 recommended neighborhoods that fit the user input criteria.</td>
          </tr>
          <tr>
          <td style="width: 120.671875px;"><b>Summaries</b></td>
          <td style="width: 295.34375px;">Other data visualizations and insights.</td>
          </tr>
          <tr>
          <td style="width: 120.671875px;"><b>Data</b></td>
          <td style="width: 295.34375px;">Data used for project, and source.</td>
          </tr>
          <tr>
          <td style="width: 120.671875px;"><b>About Charles</b></td>
          <td style="width: 295.34375px;">About me, includes links to my Github, project code, and contact information.</td>
          </tr>
          </tbody>
          </table>
          </center></p>
                 ')),
                  #INTERACTIVE MAP TAB
                  tabItem(tabName='map',
                          #leaflet map
                          leafletOutput("map1"),
                          #slider
                          fluidRow(
                            column(6,
                                   HTML('<br></br>'),
                                   sliderInput("map_pricerange",
                                               "Price Range:",
                                               min = 32,
                                               max = 500,
                                               value = c(75,300)),
                                   selectizeInput(inputId ="roomtype",
                                                  label = "Room Type",
                                                  choices = unique (airbnb$room_type)),
                                   selectizeInput(inputId ="borough",
                                                  label = "Borough",
                                                  choices = unique (airbnb$neighbourhood_group)),
                                   #<br> adds space below the drop down menus
                                   HTML('
                         <br></br>
                         <br></br> 
                         <br></br>
                       ')),
                            column(6,HTML(
                              '<br></br>
                         <b>Instructions: </b>
                         <br></br>
                         Please specify your preferences using the slide and drop down menus. 
                         If you receive an error, please try another set of inputs.
                         <br></br>                         
                         Light blue markers on the map indicate cheaper neighborhoods (on average), and dark purple ones 
                         indicate the most expensive. Hover over a circle to view the borough name and average price per night (per listing).
                         <br></br>
                         <br></br>
                         '))
                            
                          )),
                  
                  #Other Analytics
                  tabItem(tabName='analytics',
                          
                          #plots
                          fluidRow(
                            column(4,
                                   "Please specify your preferences using the options below. If you receive an error, please try 
                           another set of inputs.",
                                   HTML('<br></br>'),
                                   sliderInput("numoptions",
                                               "Number of Options:",
                                               min = 1,
                                               max = 10,
                                               value = 5),
                                   sliderInput("pricerange2",
                                               "Price Range:",
                                               min = 32,
                                               max = 500,
                                               value = c(75,300)),
                                   selectizeInput(inputId ="roomtype2",
                                                  label = "Room Type",
                                                  choices = unique (airbnb$room_type)),
                                   selectizeInput(inputId ="borough2",
                                                  label = "Borough",
                                                  choices = unique (airbnb$neighbourhood_group))
                                   
                            ),
                            column(8,plotlyOutput("leBubblePlot"))),
                          HTML('<br></br>'),
                          leafletOutput("map2"),
                          HTML('<br></br>'),
                          "Note: Top 5 (or as specified) number of recommended neighborhoods
                  displays those with the highest number of listings that
                  satisfy the user input criteria. The larger bubbles on the plot reflect higher numbers of 
                  reviews on average - indicating more bookings and higher popularity. ",
                          HTML('
                         <br></br>
                         <br></br> 
                       ')),
                  tabItem(tabName = 'summaries',
                          fluidRow(
                            column(6,
                                   selectizeInput(inputId ="neighborhood1",
                                                  label = "Neighborhood",
                                                  choices = unique (airbnb$neighbourhood)),
                                   plotOutput("summaryplot1"),
                                   plotOutput("summaryplot2"),
                                   plotOutput("summaryplot3")),
                            column(6,
                                   selectizeInput(inputId ="neighborhood2",
                                                  label = "Neighborhood",
                                                  choices = unique (airbnb$neighbourhood)),
                                   plotOutput("summaryplot4"),
                                   plotOutput("summaryplot5"),
                                   plotOutput("summaryplot6")                  
                            ))),
                  #DATA TAB
                  tabItem(tabName='data',
                          HTML('
                     <a href="http://insideairbnb.com/get-the-data.html">Data Source</a>
                     <br></br> 
                       '),
                          
                          fluidRow(box(DT::dataTableOutput("table"), width = 20)),
                          HTML('
                     <br></br> 
                     <br></br> 
                       ')),
                  
                  #JESSIES BIO
                  tabItem(tabName='about', 
                          
                          fluidRow(
                            column(6,HTML('
                              <p>I hope you enjoyed browsing my R Shiny project. </p>
                              <p>A little about myself, I am currently a senior year graduate student in Ball State University,Muncie-Indiana where l study Data Science. 
                              l graduate in Spring,2024 and look forward to explore the data world to uncover more insights to drive businesses. 
                              </p>
                              <p>I very interested in data  as there are many diverse ways to use data creatively as a form of storytelling. Aside from data science,
                              my interests include hiking,listening to music and traveling - I love to explore new places!</p>
                              <p><a href="https://www.linkedin.com/in/charles-wiredu-064655246/">LinkedIn</a></p>
                              <p><a href="https://github.com/cwiredu1/">Github</a></p>
                              <p>E-mail: charlwiredu@gmail.com</p>
                              <p><br></p>')),
                            column(6,
                                   )))
                )
              )
)