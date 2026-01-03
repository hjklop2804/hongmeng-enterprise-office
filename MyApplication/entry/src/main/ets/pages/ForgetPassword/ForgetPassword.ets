import router from '@ohos.router'
import  http  from '@ohos.net.http';
import { promptAction } from '@kit.ArkUI';

interface phoneState{
  code:number,
  checkNum:number
}
@Entry
@Component
struct ForgetPassword {
  @State phone:number = 0;
  @State checkNum:number = 0;
  @State code:number = 0;
  @State inputCheckNum:number = 0;
  @State password:string = '';
  @State relPassword:string = '';
  @State phoneState:phoneState = {
    code: 0,
    checkNum: 0
  }
  private  checkPhone(url:string) {
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
        this.phoneState = JSON.parse(data.result.toString())
        console.info(`获取的状态码为${this.phoneState.code}`)
        this.code = this.phoneState.code
        if(this.code===2001){
            this.checkNum = this.phoneState.checkNum
        }else{
          promptAction.openToast({message:"手机号输入有误"})
        }
      }
    );
  }
  build() {
    Column() {
      Row() {
        Image($rawfile("login/back.png"))
          .width(26)
          .height(26)
          .margin(10)
          .onClick(() => {
            router.back()
          })
        Text("忘记密码")
          .fontColor('#333333')
          .fontSize(26)
          .textAlign(TextAlign.Start)
          .fontWeight(FontWeight.Bold)
          .padding({
            left: 110
          })
          .width('100%')
      }
      .width('100%')
      .height(70)
      .justifyContent(FlexAlign.SpaceBetween)
      Row() {
        Text("手机账号")
          .width(65)
          .height('100%')
        TextInput({ placeholder: '请输入手机号' })
          .margin({ left: 10 })
          .height(70)
          .backgroundColor('#f3f3f3')
          .borderRadius(0)
          .layoutWeight(1)
          .onChange((value:string)=>{
            this.phone = parseInt(value)
          })
        Button('获取验证码')
          .fontColor(Color.White)
          .backgroundColor('#4749a1')
          .height(40)
          .width(100)
          .borderRadius(10)
          .onClick(()=>{
            console.info(`获取电话号码为${this.phone}`)
            this.checkPhone("http://10.0.2.2:4523/m1/7330595-7060370-default/user/forgetpsd?phone="+this.phone)
          })
      }
      .padding(20)
      .width('100%')
      .height(70)
      .borderColor({
        top: '#eaeaea'
      })
      .borderWidth({
        top: 1
      }) .backgroundColor('#f5f5f5')
      .margin({
        top: 8
      })
      Row() {
        Text("验证码")
          .width(65)
          .height('100%')
        TextInput({ placeholder: '请输入验证码',text:''+this.checkNum })
          .margin({ left: 10 })
          .height(70)
          .backgroundColor('#f3f3f3')
          .borderRadius(0)
          .layoutWeight(1)
          .onChange((value:string)=>{
            this.inputCheckNum = parseInt(value)
          })
      }
      .padding(20)
      .width('100%')
      .height(70)
      .borderColor({
        top: '#eaeaea'
      })
      .borderWidth({
        top: 1
      })
      .backgroundColor('#f5f5f5')
      Row() {
        Text("设置密码")
          .width(65)
          .height('100%')
        TextInput({ placeholder: '请输入密码' })
          .margin({ left: 10 })
          .height(70)
          .borderRadius(0)
          .backgroundColor('#f3f3f3')
          .layoutWeight(1)
          .onChange((value:string)=>{
            this.password = value;
          })
      }
      .padding(20)
      .width('100%')
      .height(70)
      .borderColor({
        top: '#eaeaea'
      })
      .borderWidth({
        top: 1
      })
      .backgroundColor('#f3f3f3')
      Row() {
        Text("确认密码")
          .width(65)
          .height('100%')
        TextInput({ placeholder: '确认密码' })
          .margin({ left: 10 })
          .height(70)
          .borderRadius(0)
          .backgroundColor('#f3f3f3')
          .layoutWeight(1)
          .onChange((value:string)=>{
            this.relPassword = value;
          })
      }
      .padding(20)
      .width('100%')
      .height(70)
      .borderColor({
        top: '#eaeaea',
        bottom: '#eaeaea'
      })
      .borderWidth({
        top: 1,
        bottom: 1
      })
      .backgroundColor('#f3f3f3')
      Button('确定')
        .width('90%')
        .height(60)
        .borderRadius(5)
        .type(ButtonType.Normal)
        .backgroundColor('#4749a1')
        .margin({ top: 20 })
        .onClick(()=>{
          if(this.inputCheckNum === this.checkNum){
            if(this.password===this.relPassword){
              promptAction.openToast({message:"密码重置成功"})
            }else {
              promptAction.openToast({message:"两次输入的密码不一致"})
            }
          }else{
            promptAction.openToast({message:"验证码有误"})
          }
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }
}