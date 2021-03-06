context("Test Plot Addresses")

test_that("Plotting Addresses works", {
  

  
  df<-data.frame("authorID"=c(1,2,3),
                 "AU"= c('Smith, Jon J.','Thompson, Bob B.','Smith,J'),          
                 "AF"= c('Smith, Jon J.','Thompson, Bob B.','Smith,J'),          
                 "groupID"= c(3,2,3),      
                 "match_name"=c('Smith,J',NA,'Smith, Jon J'),
                 "similarity"= c(0.8833333,NA,0.8833333),   
                 "author_order"= c(1,2,1),
                 "address"=c("Univ Florida, Gainesville, FL USA","University of Texas, Austin, TX, USA",NA),      
                 "RP_address"=c("Univ Florida, Gainesville, FL USA","University of Oxford, Oxfordshire, UK","University of California Berkley, Berkley, CA, USA"),   
                 "RI"=NA,          
                 "OI"=NA,      
                 "EM"=c("j.smith@ufl.edu",NA,'jsmith@usgs.gov'),          
                 "refID"=c(1,1,3),
                 "TA"=NA,
                 "SO"=NA,          
                 "UT"=c('test1','test1','test2'),
                 "PT"=NA,
                 "PU"=NA,
                 "PY"=NA,
                 "university"=c('Univ Florida','University of Oxford',"University of California"),  
                 "country"=c('USA','United Kingdom',"USA"),
                 "state"=c('FL','Oxfordshire',"CA"),
                 "postal_code"=NA,
                 "city"=c('Gainesville','Oxford',"Berkley"),
                 "department"=NA ,
                 "lat"=c(35,51.7520,39),
                 "lon"=c(-100,1.2577,-80),
                 stringsAsFactors=F )
  
  a<-plot_addresses_points(data=df)
  expect_doppelganger("test_plot_addresses",a)
  b<-plot_addresses_country(data=df)
  expect_doppelganger("test_plot_country",b)
  c<-plot_net_address(data=df)
  expect_doppelganger("test_plot_net_address",c)
  d<-plot_net_coauthor(data=df)
  expect_doppelganger("test_plot_net_coauthor",d)
  e<-plot_net_country(data=df)  
  expect_doppelganger("test_plot_net_country",e)
})
  
  