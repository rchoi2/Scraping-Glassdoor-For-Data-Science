from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time
import re 
import csv 

driver = webdriver.Chrome() 

# driver.get("https://www.glassdoor.com/index.htm")
driver.get("https://www.glassdoor.com/Interview/Facebook-Interview-Questions-E40772.htm")

sign_in = driver.find_element_by_xpath('//li[@class="sign-in"]')
sign_in.click()

username = driver.find_element_by_xpath('//div//input[@id = "userEmail" and @class= "css-80r8uf"]')
password = driver.find_element_by_xpath('//div//input[@id = "userPassword" and @class= "css-80r8uf"]')
username.clear()
username.send_keys("username")
password.clear()
password.send_keys("pw")
driver.find_element_by_xpath('//div/button[@class="gd-ui-button minWidthBtn css-1sdotxz"]').click()

csv_file = open('fb.csv', 'w', encoding='utf-8')
writer = csv.writer(csv_file)
writer.writerow(['company','title','date','offer','experience','difficulty','application','interview'])

index = 1 
while True:
    try: 
        print("Scraping Page number " + str(index))
        time.sleep(1)
        index = index + 1
        wait_review = WebDriverWait(driver, 10)

        reviews = wait_review.until(EC.presence_of_all_elements_located((By.XPATH,'//li[@class=" empReview cf "]')))
        for review in reviews: 
            review_dict = {}


            driver.execute_script("arguments[0].scrollIntoView();", review)
            
            # Check for continue reading
            continue_reading_exists = False
            try:
                continue_reading = review.find_element_by_xpath('.//div[@class="continueReading link"]/strong')
                continue_reading.click()
                continue_reading_exists = True
                time.sleep(.5)
            except:
                pass

            # company
            try:
                company = driver.find_element_by_id('DivisionsDropdownComponent').text
            except Exception as e:
                print(e)
            # title
            try:
                title = review.find_element_by_xpath('.//span[@class="reviewer"]').text
            except Exception as e:
                print(e) 
            # date
            try:
                date = review.find_element_by_xpath('.//time[@class="date subtle small"]').text
            except Exception as e:
                print(e) 
            # offer
            try:
                offer = review.find_elements_by_xpath('.//span[@class="middle"]')[0].text
            except Exception as e:
                print(e) 
            # experience
            try:
                experience = review.find_elements_by_xpath('.//span[@class="middle"]')[1].text
            except Exception as e:
                print(e) 
            # difficulty
            try:
                difficulty = review.find_elements_by_xpath('.//span[@class="middle"]')[2].text
            except Exception as e:
                print(e)
            # application process
            try: 
                application = review.find_element_by_xpath('.//p[@class = "applicationDetails continueReading"]').text
            except Exception as e: 
                print(e)
            # interview review
            try: 
                interview = review.find_element_by_xpath('.//p[@class = "interviewDetails continueReading interviewContent mb-xsm "]').text
            except Exception as e: 
                print(e)
            # print("{},{},{}".format(offer,experience,difficulty))
            # print("{}, {}".format(title,date))

            review_dict['company'] = company
            review_dict['title'] = title
            review_dict['date'] = date
            review_dict['offer'] = offer
            review_dict['experience'] = experience
            review_dict['difficulty'] = difficulty 
            review_dict['application'] = application
            review_dict['interview'] = interview

            writer.writerow(review_dict.values())

 
        # driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        # /html/body/div[4]/div/div/div/div[1]/div[1]/div/div[1]/article[2]/div[1]/div[4]/div[4]/div[3]/div[2]/ul/li[7]/a
        wait_button = WebDriverWait(driver, 10)
        next_button = wait_button.until(EC.element_to_be_clickable((By.XPATH,
                                    '//div[@class="pagingControls cell middle"]//li[@class="next"]/a')))    
        # button = driver.find_element_by_xpath('//div[@class="pagingControls cell middle"]//li[@class="next"]')
        # button.click()
        next_button.click()


    except Exception as e:
        print(type(e), e)
        csv_file.close()
        break


driver.close()
