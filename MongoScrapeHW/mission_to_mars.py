
# coding: utf-8

# In[1]:


import os
from bs4 import BeautifulSoup as bs
import requests
from splinter import Browser
import pandas as pd


# In[2]:


url = 'https://mars.nasa.gov/news/'


# In[3]:


response = requests.get(url)


# In[4]:


soup = bs(response.text,'html.parser')


# In[5]:


#print(soup.prettify())


# In[6]:


#ul_class_IL = soup.find_all('div', class_='content_title')
div_class_slide = soup.find_all('div', class_ = 'slide')


# In[7]:


par = div_class_slide[0].find('div',class_='rollover_description_inner').text
title = div_class_slide[0].find('div',class_='content_title').find('a').text


# In[8]:


#for e in div_class_slide:
#    rdi = e.find('div', class_='rollover_description_inner')
#    ct = e.find('div', class_='content_title')
#    a = ct.find('a').text


# In[9]:


url2 = 'https://www.jpl.nasa.gov/spaceimages/?search=&category=Mars'
executable_path = {'executable_path': 'chromedriver.exe'}
browser = Browser('chrome', **executable_path, headless = False)


# In[10]:


browser.visit(url2)


# In[11]:


response2 = requests.get(url2)


# In[12]:


soup2 = bs(response2.text,'html.parser')


# In[13]:


featured_image_url = 'https://www.jpl.nasa.gov' + soup2.find('footer').find('a').attrs['data-fancybox-href']


# In[14]:


url3 = 'https://twitter.com/marswxreport?lang=en'


# In[15]:


response3 = requests.get(url3)


# In[16]:


soup3 = bs(response3.text,'html.parser')


# In[17]:


mars_weather = soup3.find_all('div', class_ = 'js-tweet-text-container')[0].find('p').text


# In[18]:


url4 = 'http://space-facts.com/mars/'


# In[19]:


url4tbl = pd.read_html(url4)
url4toHTML = url4tbl[0].to_html()


# In[20]:


url5 = 'https://astrogeology.usgs.gov/search/results?q=hemisphere+enhanced&k1=target&v1=Mars'


# In[21]:


hem_dict_dict ={}


# In[22]:


browser.visit(url5)


# In[23]:


response5 =  requests.get(url5)


# In[24]:


soup5 = bs(response5.text,'html.parser')


# In[25]:


s5 = soup5.find_all('div', class_='item')
for each in s5:
    urls5 = 'https://astrogeology.usgs.gov'+ each.find('a').attrs['href']
    browser.visit(urls5)
    rs5 = requests.get(urls5)
    ps5 = bs(rs5.text,'html.parser')
    allAnchors = ps5.find_all('div', class_='downloads')
    hem_dict_dict.append({'title' : ps5.find('title').text , 'img_url' : allAnchors[0].find('a').attrs['href']})    

