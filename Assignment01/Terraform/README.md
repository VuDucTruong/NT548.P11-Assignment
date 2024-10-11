## Hướng dẫn sử dụng 
1. Clone project về :
   Mở VSCode và tạo một terminal. Sau đó thực hiện câu lệnh sau :
   
```` terminal
git clone https://github.com/VuDucTruong/NT548.P11-Assignment.git
````

2. Tạo ra file terraform.tfvars để lưu biến

   ![image](https://github.com/user-attachments/assets/ac1ca520-c513-44f9-aa1f-4f5ae23da5bc)
   
3. Sử dụng lệnh terraform init để khởi tạo provider và các file cần thiết

```` terminal
terraform init
````
4. Sử dụng lệnh terraform plan để kiểm tra

````terminal
terraform plan
````

5. Sử dụng lệnh terraform apply để thực hiện triển khai trên hạ tầng AWS

```` terminal
terraform apply
````

<h3>Lưu ý</h3>
<em>
  Sử dụng lệnh terraform test để kiểm tra các instance đã được triển khai thành công sau khi thực hiện xong bước 3 ở trên.
</em>

````terminal
terraform test
````
