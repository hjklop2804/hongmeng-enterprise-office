import router from '@ohos.router'
import http from '@ohos.net.http';
import promptAction from '@ohos.promptAction';

interface rs{
  leaveInfo:string,
  agree:number
}

@Entry
@Component
struct leave{
  @State selectInfo:string = "请选择..."
  @State leaveInfo:string = ''
  @State selectIndex:number = 0;
  @State agreeColor:Color = Color.Gray
  @State IsAgree:string = "未提交"
  @State rs:rs = {
    leaveInfo: '',
    agree: 0
  }
  build() {
    Column(){
      Row(){
        Image($rawfile("login/back.png"))
          .width(40)
          .height(40)
          .margin({
            left:5
          })
          .position({
            left:10,top:5
          })
          .onClick(()=>{
            router.back()
          })
        Text("请假申请")
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(50)
      .backgroundColor(Color.White)
      .margin({
        bottom:40
      })
      .justifyContent(FlexAlign.Center)
      Row(){
        Text("请假类型")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({
            left:20
          })
        Select([{ value: '事假' }, { value: '病假',}, { value: '外勤',}, { value: '其他'}])
          .margin({
            right:20
          })
          .value(this.selectInfo)
          .backgroundColor(Color.White)
          .onSelect((index:number,value:string)=>{
            console.info(`选择了${value},下标为${index}`)
            this.selectInfo = value;
            this.selectIndex = index
          })
      }
      .width('100%')
      .height(50)
      .backgroundColor(Color.White)
      .margin({
        bottom:30
      })
      .justifyContent(FlexAlign.SpaceBetween)
      Column(){
        Text("请假事由")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .padding({
            top:10,
            left:20,
            bottom:10
          })
          .width('100%')
          .borderWidth({
            bottom:1
          })
          .borderColor("#ffcbc8c8")
        TextArea({placeholder:"请输入请假事由..."})
          .width('100%')
          .height(260)
          .margin({
            top:10
          })
          .backgroundColor(Color.White)
          .onChange((value:string)=>{
            this.leaveInfo = value
            console.info(`请假事由：${this.leaveInfo}`)
          })
      }
      .width('100%')
      .height(320)
      .backgroundColor(Color.White)
      .margin({
        bottom:20
      })
      Column(){
        Text("审批结果")
          .width('100%')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .padding({
            top:10,
            left:20,
            bottom:10
          })
          .borderWidth({
            bottom:1
          })
          .borderColor("#ffcbc8c8")
        Row(){
          Text(this.IsAgree)
            .fontColor(Color.White)
        }
        .width('90%')
        .height(44)
        .margin({
          top:30
        })
        .backgroundColor(this.agreeColor)
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(150)
      .backgroundColor(Color.White)
      Column(){
        Button('提交审核')
          .width('90%')
          .onClick(()=>{
            if(this.selectIndex>=0&&this.selectIndex<=3){
              const baseUrl = "http://127.0.0.1:4523/m1/7622172-7361408-default";
              this.leave(baseUrl + "/user/leave?selectIndex="+this.selectIndex);
            }else{
              promptAction.openToast({message:"请选择请假类型后提交"})
            }
          })
      }
      .margin({
        top:22
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ffe7e5e5')
  }

  private leave(url:string) {
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
        console.log("响应结果",data.result.toString())
        this.rs = JSON.parse(data.result.toString())
        if(this.rs.agree===0){
          this.agreeColor = Color.Red
          this.IsAgree = "审核未通过"
        }else if(this.rs.agree===1){
          this.agreeColor = Color.Green
          this.IsAgree = "审核通过"
        }
      }
    );
  }
}