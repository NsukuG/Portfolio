#!/usr/bin/env python
# coding: utf-8

# In[94]:


import os, shutil


# In[99]:


print ("Welcome, this tools moves files into folders per type. It only works with videos, audio and documents")
path = r"Downloads/"


# In[96]:


file_names = os.listdir(path)


# In[97]:


folder_names = ['video', 'audio','Pdf','word','powerpoint','csv files','other']

for loop in range(0,6): 
    if not os.path.exists(path + folder_names[loop]):
        print(path + folder_names[loop])
        os.makedirs((path + folder_names[loop]))

for file in file_names:
    if ".csv" in file and not os.path.exists(path + "csv files/" + file):
        shutil.move(path + file, path +"csv files/" + file )
        
    elif ".mp3" in file and not os.path.exists(path + "audio/" + file):
         shutil.move(path + file, path +"audio/" + file )
        
    elif ".pdf" in file and not os.path.exists(path + "Pdf/" + file):
         shutil.move(path + file, path +"Pdf/" + file )
        
    elif ".pptx" in file and not os.path.exists(path + "powerpoint/" + file):
         shutil.move(path + file, path +"powerpoint/" + file )
        
    elif ".docx" in file and not os.path.exists(path + "word/" + file):
          shutil.move(path + file, path +"word/" + file )
         
    
    elif ".mkv" in file and not os.path.exists(path + "movies/" + file):
          shutil.move(path + file, path +"movies/" + file )
    
    elif ".mp4" in file and not os.path.exists(path + "video/" + file):
          shutil.move(path + file, path +"video/" + file )
    else:  shutil.move(path + file, path +"other/" + file )        


# In[92]:


for file in file_names:
    if ".csv" in file and not os.path.exists(path + "csv files/" + file):
        shutil.move(path + file, path +"csv files/" + file )
        
    elif ".mp3" in file and not os.path.exists(path + "audio/" + file):
         shutil.move(path + file, path +"audio/" + file )
        
    elif ".pdf" in file and not os.path.exists(path + "Pdf/" + file):
         shutil.move(path + file, path +"Pdf/" + file )
        
    elif ".pptx" in file and not os.path.exists(path + "powerpoint/" + file):
         shutil.move(path + file, path +"powerpoint/" + file )
        
    elif ".docx" in file and not os.path.exists(path + "word/" + file):
          shutil.move(path + file, path +"word/" + file )
         
    
    elif ".mkv" in file and not os.path.exists(path + "movies/" + file):
          shutil.move(path + file, path +"movies/" + file )
    
    elif ".mp4" in file and not os.path.exists(path + "video/" + file):
          shutil.move(path + file, path +"video/" + file )
    else:  shutil.move(path + file, path +"other/" + file )      
        
       

