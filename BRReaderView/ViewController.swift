//
//  ViewController.swift
//  BRReaderView
//
//  Created by Archy on 2018/9/14.
//  Copyright © 2018 Archy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: BRReaderView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let test = "<p sort=\"1\"><br></p><p sort=\"2\">　　“您想好了？”</p><p sort=\"3\"><br></p><p sort=\"4\">　　“欸，想好了！”夏盛虎说着吐出一口气，将自己腰间的刀猛地抽出来拍在桌面上道：</p><p sort=\"5\"><br></p><p sort=\"6\">　　“封刀！”</p><p sort=\"7\"><br></p><p sort=\"8\">　　那是一把宽刃障刀，刀刃已经有些翻卷，刀身上还缀着斑斑锈迹，想来已是很久没有保养。然而刀躺在桌上仍散出隐隐的杀气，像落叶下隐匿的毒蛇，窥伺着杀机。</p><p sort=\"9\"><br></p><p sort=\"10\">　　柳妨斋笑了笑，将目光收回，又望向面前低着头的夏盛虎：“前辈‘虎牙’之名在江湖上如雷贯耳，若是封刀，何不去荣安寺、洛云楼或者上峰武馆？我这，怕是委屈您了。”</p><p sort=\"11\"><br></p><p sort=\"12\">　　怎料夏盛虎听了这话却是正色道：“你说的哪里的话，这刀是从你这得来的，在你这封刀才是善始善终。我夏盛虎可是那种势利之人？”</p><p sort=\"13\"><br></p><p sort=\"14\">　　“是在下妄言了。”柳妨斋笑笑，道：“既然如此，那还请将第二把刀一并交出，我好去准备封刀的相关事宜。”</p><p sort=\"15\"><br></p><p sort=\"16\">　　　听到这句话，夏盛虎宛遭电击一般不住地颤抖起来，哑声道：“这......第二把刀我，我赠与一个今生恐难再相见的知己了。”说话间，他的牙齿咬得咯吱作响，似乎下一刻就要崩碎。</p><p sort=\"17\"><br></p><p sort=\"18\">　　柳妨斋见状，将刀推回夏盛虎面前，轻声道：“前辈在我刀斋籍籍无名之时光顾，培植之恩无以为报，还容在下聒噪几句。这江湖上，有多少人心愿未了而封刀最后落得一个抱憾终生，这前辈比我清楚。别的事我不问，可倘若封刀后又复出却是有损前辈的名声，还请前辈还三思。”说罢，柳妨斋将茶壶拿起来，给两个杯子续上茶水。</p><p sort=\"19\"><br></p><p sort=\"20\">　　夏盛虎紧绷的身体逐渐放松下来，他的目光变得愤恨而悠远，柳妨斋没再看他，低着眉眼吹拂着茶水，看那碧绿的波纹一圈圈地荡漾开。</p><p sort=\"21\"><br></p><p sort=\"22\">　　柳妨斋和夏盛虎出了后院的房间，朝刀斋的前门走去，穿过前厅的时候，夏盛虎如来时一般驻足环顾四周。</p><p sort=\"23\"><br></p><p sort=\"24\">　　刀斋的前厅十分宽敞，地上整整齐齐铺着竹席，散发出徐徐清香。前厅与后厅相隔处是一块扇面屏风，白色的面上用极简的笔画勾勒出一把刀，神韵十足。二楼四面都是房间，在往高处看，便是房梁和房顶。那房顶虽不算高，却昏暗如夜空，其间有星星点点的光芒闪烁。</p><p sort=\"25\"><br></p><p sort=\"26\">　　那是刀光。</p><p sort=\"27\"><br></p><p sort=\"28\">　　十几把刀死寂地望着地上的人们，不言不语，只是随着房顶缝隙漏出来的风微微摆动着，相互擦碰发出叮叮当当的轻响。</p><p sort=\"29\"><br></p><p sort=\"30\">　　“如今这‘长安刀铃斋’的名号，怕是快比我们这些老家伙更叫得响咯。”夏盛虎感慨。</p><p sort=\"31\"><br></p><p sort=\"32\">　　柳妨斋闻言后笑道：“可我这刀斋都已经几个月没开过张了。”</p><p sort=\"33\"><br></p><p sort=\"34\">　　正说着，前门忽然被推开了一条缝，一个小脑袋从缝里探出来问到：“请问柳妨斋柳大师在吗？”</p><p sort=\"35\"><br></p><p sort=\"36\">　　“我便是柳妨斋。”</p><p sort=\"37\"><br></p><p sort=\"38\">　　“大师！”门缝后的人忽然跳了进来，行礼道：“我叫阿金！初入江湖特来向柳大师求刀！”</p><p sort=\"39\"><br></p><p sort=\"40\">　　阿金不过十五六岁的模样，头发用一根灰布条扎着，一身灰褐粗布短打。柳妨斋没说话，他便一直保持着行礼的姿势，眼睛却抬起来不住地观察着柳妨斋的神色。</p><p sort=\"41\"><br></p><p sort=\"42\">　　柳妨斋问他：“你可知一把镔铁横刀需要多少贯钱？”阿金闻言忙答到：“知道，我之前来的路上打听过，需要两贯多钱。我可以给您做工，工钱抵刀钱！我身上带的钱够管自己吃饭！”</p><p sort=\"43\"><br></p><p sort=\"44\">　　“也罢。”柳妨斋笑了笑，转身走到一边的武器架上拎出一把最基本的短刀过来，递给了阿金：“来，朝我挥刀。”</p><p sort=\"45\"><br></p><p sort=\"46\">　　阿金一脸惊讶地接过刀，定在那不知道该怎么办。</p><p sort=\"47\"><br></p><p sort=\"48\">　　“毋须慌张，求刀的一点规矩而已。”这是柳妨斋一直以来的规矩，他从不会问来求刀的客人有什么要求，而是通过让客人挥刀来感受其与刀剑的共鸣之处，从而打制出适合客人的刀剑。</p><p sort=\"49\"><br></p><p sort=\"50\">　　夏盛虎偏头对柳妨斋悄悄说了一句“你这的规矩还是和十年前一样，没变？”柳妨斋点头，夏盛虎瞪大了眼睛道：“难道你一把刀还是收三贯钱？”柳妨斋笑说：“我倒是想涨价，可眼下我这刀斋却是门可罗雀呀。”</p><p sort=\"51\"><br></p><p sort=\"52\">　　然后他示意阿金开始。阿金得令后，双手又将刀握紧了几分，深吸几口气后，大喝一声“哈”，挥刀朝柳妨斋劈过去。柳妨斋盯着那向自己劈来的刀不闪也不躲，看着刀就这么落在自己眼前，然后他转头问道：“夏前辈，您看如何？”</p><p sort=\"53\"><br></p><p sort=\"54\">　　“不如何。”夏盛虎斩钉截铁道，然后又对阿金说：“小子，我说你学过武功或者刀法吗？你这一刀劈得怎么和砍柴似的？”</p><p sort=\"55\"><br></p><p sort=\"56\">　　阿金听到夏盛虎问他，脸一下便红了，转耳挠腮地承认自己家里确实是靠打柴为生。“嗨，那你来这浪费什么功夫？走吧走吧，先去拜师修炼个几年再来！或者干脆回家砍柴去！”夏盛虎被气笑了。</p><p sort=\"57\"><br></p><p sort=\"58\">　　 “啊.....柳大师，他说的是真的吗？”</p><p sort=\"59\"><br></p><p sort=\"60\">　　“就算现在我替你打刀，也只是与寻常铁匠铺的刀剑无异。况且闯荡江湖，不是有一把好武器就能一帆风顺的。”　</p><p sort=\"61\"><br></p><p sort=\"62\">　　阿金一听这话垂头丧气起来：“这.....我这上哪去找师傅啊.....再说我就是找到了，人家凭什么收我呀？”柳妨斋听了这话，瞟了夏盛虎一眼，然后对着阿金笑道：“这是夏盛虎前辈，江湖上赫赫有名的‘虎牙’。”</p><p sort=\"63\"><br></p><p sort=\"64\">　　“啊！原来是位大侠！前辈久仰久仰！”阿金赶紧恭恭敬敬地行礼。</p><p sort=\"65\"><br></p><p sort=\"66\">　　“哼，不用客气。”</p><p sort=\"67\"><br></p><p sort=\"68\">　　“夏前辈会在我这小住一个月，我看就你留下来替我照顾他罢。这样一来你有什么不懂的尽可问他，二来我就算是你在我这出了工，将来便抵你的刀钱，你看如何？”</p><p sort=\"69\"><br></p><p sort=\"70\">　　 “啊.....这.....谢谢柳大师！真的太感谢了！”阿金边说边行礼，身体恨不能弯成一个圈。</p><p sort=\"71\"><br></p><p sort=\"72\">　　随后，柳妨斋向阿金交代了刀斋厨房和柴房的位置，又让他去取来两套被褥先到二楼去准备。待阿金走后，夏盛虎黑着脸问他：“方才我跟你说住下一月，是为着体验退隐后的生活。你怎么还吩咐他照顾我，我还不至于在小辈面前这般倚老卖老吧？”柳妨斋也不看他，只是兀自将刀拎回刀架，边走边道：</p><p sort=\"73\"><br></p><p sort=\"74\">    “那若是您身上有会致命的内伤呢？”</p><p sort=\"75\"><br></p>"
        print(ReaderHelper.shared.flatFormattedString(text: test))
        textView.frame.size.width = UIScreen.main.bounds.width - 30
        textView.parser = ReaderParser.shared
        textView.readerViewDelegate = self
        textView.formattedString = test
    }

}

extension ViewController: ReaderViewDelegate {
    
    func readerView(_ readerView: ReaderView, viewForItem item: ReaderItem, at range: NSRange) -> UIView {
        if item.type == .image, let imageItem = item.data as? ReaderImage {
            let componentNib = UINib(nibName: String(describing: ReaderImageComponentView.self), bundle: nil)
            let componentView = componentNib.instantiate(withOwner: nil, options: nil).first as! ReaderImageComponentView
            componentView.data = imageItem
            return componentView
        } else if item.type == .mark, let markItem = item.data as? ReaderMark {
            let componentNib = UINib(nibName: String(describing: ReaderMarkComponentView.self), bundle: nil)
            let componentView = componentNib.instantiate(withOwner: nil, options: nil).first as! ReaderMarkComponentView
            componentView.data = markItem
            return componentView
        }
        return UIView()
    }
    
}
