//
//  ViewController.swift
//  AutoLayout
//
//  Created by SeongMinK on 2021/09/10.
//

import UIKit

let MY_TABLE_VIEW_CELL_ID = "myTableViewCell"

// 섹션 이넘
enum Section {
    case feed, post, board
}

// 클래스
class Feed: Hashable {
    // 고유 아이디
    let uuid: UUID = UUID()
    var content: String
    var isFavorite: Bool = false // 하트
    var isThumbsUp: Bool = false // 좋아요
    
    init(content: String) {
        self.content = content
    }
    
    static func == (lhs: Feed, rhs: Feed) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}

// 구조체
struct Post: Hashable {
    var content: String
}

class MyTableVC: UIViewController {

    // 1. 테이블 뷰
    @IBOutlet weak var myTableView: UITableView!
    
    // 2. 데이터 소스 - UITableViewDataSource deletate를 대체
    var dataSource: UITableViewDiffableDataSource<Section, Feed>!
    
    // 3. 스냅샷 - 현재의 데이터 상태
    var snapshot: NSDiffableDataSourceSnapshot<Section, Feed>!
    
    let feedArray = [
        Feed(content: "simply dummy text of the printing and"),
        Feed(content: "um has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type "),
        Feed(content: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribestablished fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, co"),
        Feed(content: "ho loves pain itself, who seeks after it and wants to have it, simply because it is pai"),
        Feed(content: "established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, co"),
        Feed(content: "ho loves pain itself, who seeks after it and wants to have it, simply because it is pai"),
        Feed(content: "a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is thaai"),
        Feed(content: "ho loves pain ita reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is to have it, simply because it is pai"),
        Feed(content: "ho loves pain itself, who seeks after it and wants to have it, simplho loves pain ita reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is to have it, simply because it y because it is pai")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("MyTableVC - viewDidLoad() called")
        
        // 셀 리소스 파일 가져오기
        let myTableViewCellNib = UINib(nibName: String(describing: MyTableViewCell.self), bundle: nil)
        
        // 셀에 리소스 등록
        self.myTableView.register(myTableViewCellNib, forCellReuseIdentifier: MY_TABLE_VIEW_CELL_ID)
        
        self.myTableView.rowHeight = UITableView.automaticDimension
        self.myTableView.estimatedRowHeight = 120
        
        // 아주 중요
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
        print("feedArray.count : \(feedArray.count)")
        
        // 데이터 소스의 현재 스냅샷을 만든다
        snapshot = NSDiffableDataSourceSnapshot<Section, Feed>()
        
        // 섹션 추가
        snapshot.appendSections([.feed])
        
        // 추가한 섹션에 아이템 넣기
        snapshot.appendItems(feedArray, toSection: .feed)
    }
    
    // 테이블 뷰 클릭해도 하이라이트 안생기게 하기
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension MyTableVC: UITableViewDelegate {
    
}

extension MyTableVC: UITableViewDataSource {

    // 테이블 뷰 셀의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedArray.count
    }

    // 각 셀에 대한 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: MY_TABLE_VIEW_CELL_ID, for: indexPath) as! MyTableViewCell

        if self.feedArray.count > 0 {
            let cellData = feedArray[indexPath.row]
            cell.updateUI(with: cellData)
        }
        
        cell.heartBtnAction = { [weak self] currentBtnState in
            guard let self = self else { return }
            self.feedArray[indexPath.row].isFavorite = !currentBtnState
//            self.myTableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        cell.thumbsUpBtnAction = { [weak self] currentBtnState in
            guard let self = self else { return }
            self.feedArray[indexPath.row].isThumbsUp = !currentBtnState
        }

        return cell
    }
}
