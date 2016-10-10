import requests
import numpy as np
import pandas as pd
from bs4 import BeautifulSoup
import time


##################################################################################################
# web scraping part 
##################################################################################################
states = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DC", "DE", "FL", "GA", 
          "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", 
          "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", 
          "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", 
          "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]

my_df=[]

for s in states:
        
        for i in range(25):
            url = 'http://www.loopnet.com/for-sale/'+str(s)+'/' + str(i) + '/?sk=9920ce1d0d828efae8be6faf437794d7&view=list'
            soup=BeautifulSoup(requests.get(url).text)
            gen_data=soup.find_all("div",{"class":"placard-details module"})

            for item in gen_data:
                my_row=[]
                my_row.append(item.find_all("h5",{"class":"listing-address"})[0].find('span',{'class':'street-address'},).text)	# street address 
                my_row.append(item.find_all('span',{'itemprop':'addressLocality'})[0].text)										#city 
                my_row.append(item.find_all('span',{'itemprop':'addressState'})[0].text)										#state
                my_row.append(item.find_all('span',{'itemprop':'postalCode'})[0]['title'])										#zip code 
                try:
                    my_row.append(item.find_all('span',{'class':'listing-price'})[0].text)											#listing price 
                except: 
                    my_row.append(np.nan)
                try:
                    my_row.append(item.find_all('p',{'class':'property-name'})[0].text)												#property name
                except: 
                    my_row.append(np.nan)
                try:
                    my_row.append(item.find_all('li')[0].text.strip('\n'))															#property type
                except: 
                    my_row.append(np.nan)
                try:
                    my_row.append(item.find_all('i')[0].text)																		#size
                except: 
                    my_row.append(np.nan)
                try:
                    my_row.append(item.find_all('i')[1].text.strip('\r\n'))															#property class					
                except: 
                    my_row.append(np.nan)
                try:
                    my_row.append(item.find_all('i')[2].text.strip('\r\n'))			                                                #cap rate
                except:
                    my_row.append(np.nan)

                my_df.append(my_row)
        time.sleep(10)
    
my_df2=pd.DataFrame(my_df, columns=['street_address','city','state','zip_code','listing_price', 'property_name', 'property_type','size_sf','property_class','cap_rate'])
my_df2.to_csv('all_states.csv')


# loading data 
all_states=pd.read_csv('allstates.csv')
all_states.head

# check for missing data 
all_states.isnull()

grp_state=all_states.groupby(['state'])

grp_state.size()

# NA summary 
np.sum(all_states.isnull())


all_states[all_states.isnull().any(axis=1)]


# replace 'On Request' with nan
all_states_NArep=all_states.replace('    On Request', np.nan)
all_states_NArep.head()

all_states_NArep=all_states_NAdrp.replace('Price Not Disclosed',np.nan)
all_states_NArep.head()

np.sum(all_states_NArep.isnull())

