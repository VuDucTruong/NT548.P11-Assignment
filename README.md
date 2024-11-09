## Hướng dẫn sử dụng 
1. Clone project về :
   Mở VSCode và tạo một terminal. Sau đó thực hiện câu lệnh sau :
   
```` terminal
git clone https://github.com/VuDucTruong/NT548.P11-Assignment.git
````
2. Tạo key pair cho EC2 và gắn vào
   <p>Vào mục EC2 , và chọn Key Pairs ở Network & Security </p>
   <img src="https://github.com/user-attachments/assets/145f7cf9-2f0d-4e8c-97a7-dfce31889fd3"></img>
3. Truy cập vào file main.yaml

   Thiết lập parameters default cho cái trường dữ liệu sau hoặc  : 
  ![image](https://github.com/user-attachments/assets/af9a7260-d522-4bb3-8398-8951b9e09bf8)

4. Upload các files trong project lên S3 Bucket :
<ul>
  <li>
    <div>
      Tạo 1 S3 bucket <br/>
      <img src="https://github.com/user-attachments/assets/0c81c6e9-c81e-4049-a26d-9b48fdc60a34"></img>
    </div>
  </li>
  <li>
    Upload tất cả các file trong folder CloudFormation lên <br/>
    <img src="https://github.com/user-attachments/assets/33632561-6d15-49fc-b376-0e766c35faf6"></img>
  </li>
  <h3>Lưu ý</h3>
  <em>Ở phần HostURL trong các parameters, thay đổi url dựa trên s3 bucket url của bạn</em> <br/>
  <em>Ví dụ ở đây, ta sẽ lấy là : https://nhom22.s3.amazonaws.com</em>
  <img src="https://github.com/user-attachments/assets/083f5f5f-a1d2-4b08-a3e8-ee272bc66dc2"></img>

</ul>

5. Tạo stack
   <ul>
     <li>
       Vào CloudFormation và chọn create Stack , dùng with new resources (standard)
       <img src="https://github.com/user-attachments/assets/d0727496-82aa-481d-b826-ca6878be1b46"></img>
     </li>
     <li>
       Nhập S3 Url của main.yaml mà ta đã upload ở bước4
       <img src="https://github.com/user-attachments/assets/3e5d3bd1-0915-4c5d-972b-8216528604c1"></img>
     </li>
     <li>
       Nhập stack name và các parameters cần thiết ( nếu như không thiết lập default value ở bước 3 )
       <img src="https://github.com/user-attachments/assets/8fe73a4d-4251-40ab-a778-4d2db40766d3"></img>
     </li>
     <li>Tiếp tục bấm next cho các steps còn lại</li>
   </ul>

5. Kiểm tra kết quả
   <p>Nếu kết quả trả về như thế này thì bạn đã triển khai thành công các instance :</p>
   <img src="https://github.com/user-attachments/assets/b36263bc-3e3a-4eae-97e1-fe6472a16fde"></img>

