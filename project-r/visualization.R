library(tidyverse)

## data visualization

## base R visualization
plot(mtcars$mpg, mtcars$hp, pch = 16, col = "salmon")

boxplot(mtcars$mpg)

t1 <- table(mtcars$am) ## ต้องสร้าง table ใหม่ขึ้นมาก่อน เป็นคำสั่งสร้างตารางความถี่
barplot(t1)

hist(mtcars$mpg)


## ggplot => grammar of graphic
library(ggplot2)

ggplot(data = mtcars, mapping = aes(x = mpg)) +
  geom_histogram(bins = 5)


ggplot(data = mtcars, mapping = aes(x = mpg)) +
  geom_density()

ggplot(data = mtcars, mapping = aes(x = mpg)) +
  geom_freqpoly()
ggplot(mtcars, aes(hp)) +
  geom_freqpoly(
    col = "salmon")

p1 <- ggplot(mtcars, aes(mpg)) +
  geom_histogram(bins = 5)

p2 <- ggplot(mtcars, aes(hp)) + 
  geom_histogram(bins = 10)

mtcars %>%
  filter(hp <= 100) %>%
  count()

## summary table before make bar chart
mtcars <- mtcars %>%
  mutate(am = ifelse(am == 0, "Auto", "Manual")) 
# Bar Chart แบบที่ 1  สร้าง summary table -> geom_col()
t2 <- mtcars %>%
  mutate(am = ifelse(am == 0, "Auto", "Manual")) %>%
  count(am) 
ggplot(t2, aes(am, n)) +
  geom_col() # ใช้กับ summary table

# Bar Chart แบบที่ 2 ใช้ geom_bar() เลย

ggplot(mtcars, aes(am)) +
  geom_bar()

## two variable, numeric
## นิยมใช้ Chart ที่ดู Correlation การกระจายตัว
## ที่ใช้เยอะ คือ scatter plot
ggplot(mtcars, aes(hp, mpg)) +
  geom_point(col = "red", size = 5)

## dataframe => diamonds ใน ggplot2

# ตารางความถี่
diamonds %>%
  count(cut)

table(mtcars$am)
mtcars %>%
  count(am)


## ordinal factor : มาจาก order สามารถเรียง สูง กลาง ต่ำ ได้
temp <- c("high", "med", "low", "high")
temp <- factor(temp, levels = c("low", "med", "high"), ordered = TRUE) # levels ใช้ใส่ค่าเรียงกัน น้อย -> สูง
class(temp)

## categorical factor
gender <- c("m", "f", "m")
gender <- factor(gender)


glimpse(diamonds)
## frequency table
diamonds %>%
  count(cut, color, clarity)

## Sample - ใช้กับการที่ต้องการ test เช่น หา model ถ้าใช้ได้ ค่อยไปปรับใช้กับก้อนใหญ่
set.seed(27) # lock sample result
diamonds %>%
  sample_n(5)

diamonds %>%
  sample_frac(0.5) # สุ่มแบบกำหนด การซอยย่อย แล้วสุ่มเป็น %

diamonds %>%
  slice(1:5) # เหมือน head(5)

# เราใช้ Chart เพื่อหาอะไรบางอย่างที่อยู่ใน Data
## relationship (pattern)
ggplot(diamonds, aes(carat, price)) +
  geom_point()

# simple ก่อน
p3 <- ggplot(diamonds %>% sample_frac(0.1), aes(carat, price)) +
  geom_point() +
  geom_smooth(method = "lm") + ## default = loess เส้นโค้ง จะ fit กับ data ได้ดีกว่า
  # ข้อเสียของ default loess เทียบกับ linear คือ ถ้ามี จุด outlier จะดึงเส้นโค้งไปหา outliner
  # ควรใช้ lm ดูก่อน ว่า fit กับ data มั้ย
  # การเลือก model ที่ fit กับ data มากเกินไป จะทำให้เราตีความ chart ผิด
  # การตีความ Chart สำคัญมาก! ต้องเข้าใจ Business Context
  geom_rug() # ตรงไหนทึบมาก แสดงว่า มีข้อมูลกระจุกตัวค่อนข้างเยอะ


## setting vs. mapping

## color name in R
colors()

ggplot(diamonds, aes(price)) +
  geom_histogram(bins = 100, fill = "tomato2") # setting คือการ เปลี่ยนด้วยตัวเอง ให้ Chart

ggplot(diamonds %>% sample_n(500), aes(carat, price)) +
  geom_point(size = 5, alpha = 0.2, col = "tomato2")

# การปรับแบบ Mapping: column ใน DF ไป Map เป็น element setting เช่น สี, shape ของ Chart
# ดึง column ไป Mapping เข้าที่ Element ของ Chart
ggplot(diamonds %>% sample_n(500), 
       mapping = aes(carat, price, col = cut, shape = cut)) +
  geom_point(size = 5, alpha = 0.5) +
  theme_minimal()

set.seed(42)
small_diamonds <- sample_n(diamonds, 5000)
ggplot(small_diamonds, 
       aes(carat, price, col=color, shape = cut)) +  
  geom_point()

##SETTING vs MAPPING ???
# setting คือ การปรับ สี, การ render อื่นๆ แบบ manual | mapping คือ การ map column เข้ากับ element ของ chart ซึ่ง element นอกจากมี x,y แล้ว ยังมี สี, shape ได้ด้วย จะเกิดใน aes()

## add label
ggplot(diamonds %>% sample_n(500), 
       mapping = aes(carat, price, col = cut, shape = cut)) +
  geom_point(size = 5, alpha = 0.5) +
  theme_minimal() +
  labs(
    title = "Relationship between carat and price",
    x = "Carat",
    y = "Price USD",
    subtitle = "We found a positive relationship",
    caption = "Datasource: diamonds ggplot2"
  )

ggplot(small_diamonds, aes(carat, price)) +  
  labs(
    title = "Relationship between carat and price by color",       
    x = "Carat",       
    y = "Price USD",      
    subtitle = "We found a positive relationship", 
    caption = "Source : Diamonds from ggplot2 package")

## Pallet Color in R : R Color Brewer
ggplot(diamonds %>% sample_n(500), 
       mapping = aes(carat, price, col = cut, shape = cut)) +
  geom_point(size = 5, alpha = 0.5) +
  theme_minimal() +
  labs(
    title = "Relationship between carat and price",
    x = "Carat",
    y = "Price USD",
    subtitle = "We found a positive relationship",
    caption = "Datasource: diamonds ggplot2"
  ) + 
  scale_color_manual(values = c("salmon", 
                                "peachpuff", 
                                "tan4", 
                                "pink2", 
                                "palegreen")) # change color pallet for Mapping

ggplot(diamonds %>% sample_n(500),        
       mapping = aes(carat, price, 
                     col = cut, shape = cut)) +  
  geom_point(size = 5, alpha = 0.5) +
  scale_color_manual(
    values = c(
      "salmon",
      "peachpuff",
      "tan4",
      "pink2",
      "palegreen"))      


ggplot(diamonds %>% sample_n(500), 
       mapping = aes(carat, price, col = cut, shape = cut)) +
  geom_point(size = 5, alpha = 0.5) +
  theme_minimal() +
  labs(
    title = "Relationship between carat and price",
    x = "Carat",
    y = "Price USD",
    subtitle = "We found a positive relationship",
    caption = "Datasource: diamonds ggplot2"
  ) + 
  scale_color_viridis_d(direction = -1) # direction -1 = reverse color
# d = discrete variable

ggplot(diamonds %>% sample_n(500),        
       mapping = aes(carat, price, 
                     col = cut, shape = cut)) +  
  geom_point(size = 5, alpha = 0.5) +
  scale_color_viridis_d(direction = -1)
# d = discrete variable

ggplot(diamonds %>% sample_n(500), 
       mapping = aes(carat, price, col = cut, shape = cut)) +
  geom_point(size = 5, alpha = 0.5) +
  theme_minimal() +
  labs(
    title = "Relationship between carat and price",
    x = "Carat",
    y = "Price USD",
    subtitle = "We found a positive relationship",
    caption = "Datasource: diamonds ggplot2"
  ) + 
  scale_color_brewer(type = "div", palette = 4) # เล่นเพิ่มเติมใน web ได้ color brewer .org
# https://colorbrewer2.org/#type=qualitative&scheme=Dark2&n=3
# สีผ่านการ Research มาแล้วว่า เหมาะกับข้อมูลประเภทไหน

ggplot(diamonds %>% sample_n(500),        
       mapping = aes(carat, price, 
                     col = cut, shape = cut)) +  
  geom_point(size = 5, alpha = 0.5) +
  scale_color_brewer(
    type = "div", 
    palette = 4)


# ใช้สีที่คนอื่นคิด Palette ให้ เช่น https://coolors.co/

## map color scale สำหรับการ Map color ด้วย ตัวแปร Continuous จะใช้สีแบบ Gradient
ggplot(mtcars, aes(hp, mpg, col = wt)) + 
  geom_point(size = 5, alpha = 0.7) +
  theme_minimal() +
  scale_color_gradient(low = "gold", high = "purple")

ggplot(mtcars, aes(hp, mpg, col = wt)) +   
  geom_point(size = 5, alpha = 0.7) +   
  scale_color_gradient(
    low = "gold", 
    high = "purple")

## facet
ggplot(diamonds %>% sample_n(5000), aes(carat, price)) +
  geom_point(alpha = 0.5) +
  geom_smooth(col = "tomato2", fill = "gold") +
  theme_minimal() +
  facet_wrap(~ cut, ncol = 3) 

ggplot(diamonds %>% sample_n(5000), aes(carat, price)) +
  geom_point(alpha = 0.5) +
  geom_smooth(col = "tomato2", fill = "gold") +
  theme_minimal() +
  facet_grid(cut ~ color) # cut = x, color = y

ggplot(small_diamonds, aes(carat, price)) +  
  geom_point() +  
  geom_smooth(method = "lm", col = "red") +  
  facet_grid(cut ~ color)

## combine chart
#library patchwork
#install.packages("patchwork")
library(patchwork)
library(ggplot2)

## ggplot แบบย่อ
p1 <- qplot(mpg, data = mtcars, geom = "histogram", bins = 10)
p2 <- qplot(hp, mpg, data = mtcars, geom = "point")
p3 <- qplot(hp, data = mtcars, geom = "density")
p4 <- ggplot(mtcars, aes(hp, mpg, col = wt)) + 
  geom_point(size = 5, alpha = 0.7) +
  theme_minimal() +
  scale_color_gradient(low = "gold", high = "purple")

## patchwork quick plot 
## 3 Chart เรียงต่อกัน
## + คือ เรียงต่อกัน ซ้าย -> ขวา
## / (หาร) คือ เรียงลงไปด้านล่าง
p1 + p2 + p3
(p1 + p2) / p3
p1 / p2 / p3
(p1 + p2 + p3) / p4
