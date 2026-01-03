import router from '@ohos.router'
import  http  from '@ohos.net.http';
import promptAction from '@ohos.promptAction';
interface user {
  username: string;
  password: string;
}
interface loginInfo {
  status:string,
  message: string,
  userInfo:userInfo

}
interface userInfo{
  username:string
}
@Entry
@Component
struct Login {
  @State inputValue:string = '';
  @State inputPassword:string = '';
  @State loginInfo:loginInfo = {
    status: '',
    message: '',
    userInfo: {
      username:''
    }
  }
  private  postData(url:string, payload:user) {
    const httpRequest = http.createHttp();
    httpRequest.request(
      url,
      {
        method:http.RequestMethod.POST ,
        header: { 'Content-Type': 'application/json'}
      },
      (err, data) => {
        if (err) {
          console.error('请求失败：', err.message);
          return;
        }
        // console.log('服务器响应：', JSON.parse(data.result.toString()));
        console.info(data.result.toString())
        //把json字符串转换成script对象
        console.info(JSON.parse(data.result.toString()))
        this.loginInfo = JSON.parse(data.result.toString())
        console.info(this.loginInfo.status)
        if(this.loginInfo.status==="success"){
          router.pushUrl({
            url:"pages/Work/Work"
          })
        }else{
          promptAction.openToast({message:"用户名或密码错误"})
          router.pushUrl({
            url:"pages/Login/Login"
          })
        }
      }
    );
  }
  build() {
    Column() {
      Image($rawfile("login/login1.png"))
        .objectFit(ImageFit.Fill)
        .width('100%')
        .height(300)
      Column() {
        Row() {
          Image($rawfile("login/phone.png"))
            .width(20)
            .height(30)
            .margin({ left: 10 })
          TextInput({
            placeholder: "请输入账号"
          })
            .height('100%')
            .layoutWeight(1)
            .borderRadius(0)
            .backgroundColor(Color.White)
            .onChange((value:string)=>{
              this.inputValue = value
            })
        }
        .borderWidth(1)
        .borderColor('#d5d5d5')
        .height(50)
        .width('90%')
        .borderRadius(0)
        .margin({
          top: 30
        })
        // Text(`输入了${this.inputValue}`)
        Row() {
          Image($rawfile("login/password.png"))
            .width(20)
            .height(30)
            .margin({ left: 10 })
          TextInput({
            placeholder: "请输入密码",
          })
            .type(InputType.Password)
            .height('100%')
            .backgroundColor(Color.White)
            .layoutWeight(1)
            .borderRadius(0)
            .onChange((value:string)=>{
              this.inputPassword = value
            })
        }
        .borderWidth(1)
        .borderColor('#d5d5d5')
        .height(50)
        .width('90%')
        .borderRadius(0)
        .margin({
          top: 30
        })
        Button('登录')
          .backgroundColor('#4749a1')
          .height(60)
          .width('85%')
          .margin({
            top: 30
          })
          .onClick(()=>{
            const payload: user = {username:this.inputValue,password:this.inputPassword};
            console.info(payload.username)
            console.info(payload.password)
            const baseUrl = "http://127.0.0.1:4523/m1/7622172-7361408-default";
            this.postData(baseUrl + "/user/login?username="+payload.username+"&password="+payload.password, payload);
          })
        Row() {
          Text("登录及代表同意")
            .fontColor('#919191')
          Text("《同意协议》")
            .fontColor('#333333')
            .fontWeight(FontWeight.Bold)
            .onClick(() => {
              console.log('---点击了用户协议---')
            })
          Text("和")
            .fontColor('#919191')
          Text("《隐私条款》")
            .fontColor('#333333')
            .fontWeight(FontWeight.Bold)
            .onClick(() => {
              console.log('---点击了隐私条款---')
            })
        }
        .margin({
          top: 40
        })
      }
      .backgroundColor(Color.White)
      .borderRadius(5)
      .width('94%')
      .height(350)
      .margin({
        top: -50
      })
      Text('忘记密码')
        .fontColor('#4749a1')
        .margin({
          top: 120
        })
        .onClick(() => {
          router.pushUrl({
            url: "pages/ForgetPassword/ForgetPassword"
          })
        })
    }
    .backgroundColor('#f5f5f5')
    .width('100%')
    .height('100%')
  }
}

