
import UIKit

class HotelVC: UIViewController {
    
    //MARK: - Private properties
    private lazy var hotelView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var aboutHotelView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = UIColor(red: 232/255.0, green: 233/255.0, blue: 236/255.0, alpha: 1.0)
        scroll.contentSize = CGSize(width: view.bounds.width, height: 990)
        return scroll
    }()
    
    private lazy var roomButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("К выбору номера", for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()
    
    private lazy var imageHotel: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "hotel")
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 12
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var nameHotelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "Steigenberger Makadi"
        
        return label
    }()
    
    private lazy var ratingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 255/255.0, green: 199/255.0, blue: 0/255.0, alpha: 0.2)
        view.layer.cornerRadius = 5
        return view
    }()
    
    private lazy var costLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "от 134 673 ₽"
        return label
    }()
    
    private lazy var adressButton: UIButton = {
        let button = UIButton()
        button.setTitle("Madinat Makadi, Safaga Road, Makadi Bay, Египет", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var priceForIt: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red: 130/255.0, green: 135/255.0, blue: 150/255.0, alpha: 1.0)
        label.text = "за тур с перелётом"
        return label
    }()
    
    private lazy var starImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(systemName: "star.fill")
        image.tintColor = UIColor.orange
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var ratingName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.orange
        label.text = "5 Превосходно"
        return label
    }()
    
    private lazy var aboutHotelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = UIColor.black
        label.text = "Об отеле"
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.text = "Отель VIP-класса с собственными гольф полями. Высокий уровнь сервиса. Рекомендуем для респектабельного отдыха. Отель принимает гостей от 18 лет!"
        return label
    }()
    
    //MARK: - Peculiarities
    private lazy var peculiaritiesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private var tagNames: [String] = ["Бесплатный Wifi на всей территории отеля", "1 км до пляжа", "Бесплатный фитнес-клуб", "20 км до аэропорта"]
    
    private var tagLabels = [UILabel]()
    
    private let tagHeight:CGFloat = 29
    private let tagPadding: CGFloat = 16
    private let tagSpacingX: CGFloat = 8
    private let tagSpacingY: CGFloat = 8
    
    private var containerHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
    
    
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "Отель"
        
        setupRoomButtonConstraints()
        setupScrollViewConstraints()
        setupHotelView()
        setupAboutHotelView()
        setupImageHotel()
        setupNameHotelLabel()
        setupRatingViewConstraints()
        setupCostLabelConstraints()
        setupAdressButtonConstraints()
        setupPriceForItConstraints()
        setupStarImageConstraints()
        setupRatingNameConstraints()
        setupAboutHotelLabelConstraints()
        setupPeculiaritiesViewConstraints()
        setupDescriptionLabelConstraints()
       
        
    }
    
    //MARK: - viewDidLayoutSubviews()
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        displayTagLabels()
        print("PeculiaritiesView height: \(peculiaritiesView.frame.height)")
    }
    
    //MARK: - Setup Constraints
    
    private func setupRoomButtonConstraints() {
        view.addSubview(roomButton)
        
        NSLayoutConstraint.activate([
            roomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            roomButton.widthAnchor.constraint(equalToConstant: 343),
            roomButton.heightAnchor.constraint(equalToConstant: 48),
            roomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    private func setupScrollViewConstraints() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: roomButton.topAnchor, constant: -12)
        ])
        
    }
    
    
    private func setupHotelView() {
        scrollView.addSubview(hotelView)
        
        NSLayoutConstraint.activate([
            hotelView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            hotelView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hotelView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            hotelView.heightAnchor.constraint(equalToConstant: 436)
        ])
        
    }
    
    private func setupAboutHotelView() {
        scrollView.addSubview(aboutHotelView)
        
        NSLayoutConstraint.activate([
            aboutHotelView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            aboutHotelView.topAnchor.constraint(equalTo: hotelView.bottomAnchor, constant: 8),
            aboutHotelView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            aboutHotelView.heightAnchor.constraint(equalToConstant: 539)
        ])
        
    }
    
    private func setupImageHotel() {
        hotelView.addSubview(imageHotel)
        
        NSLayoutConstraint.activate([
            imageHotel.topAnchor.constraint(equalTo: hotelView.topAnchor),
            imageHotel.heightAnchor.constraint(equalToConstant: 257),
            imageHotel.leftAnchor.constraint(equalTo: hotelView.leftAnchor, constant: 16),
            imageHotel.rightAnchor.constraint(equalTo: hotelView.rightAnchor, constant: -16)
        ])
    }
    
    
    private func setupNameHotelLabel() {
        hotelView.addSubview(nameHotelLabel)
        
        NSLayoutConstraint.activate([
            nameHotelLabel.topAnchor.constraint(equalTo: hotelView.topAnchor, constant: 317),
            nameHotelLabel.heightAnchor.constraint(equalToConstant: 26),
            nameHotelLabel.leftAnchor.constraint(equalTo: hotelView.leftAnchor, constant: 16),
            nameHotelLabel.rightAnchor.constraint(equalTo: hotelView.rightAnchor, constant: -16)
        ])
    }
    
    private func setupRatingViewConstraints() {
        hotelView.addSubview(ratingView)
        
        NSLayoutConstraint.activate([
            ratingView.topAnchor.constraint(equalTo: hotelView.topAnchor, constant: 280),
            ratingView.leftAnchor.constraint(equalTo: hotelView.leftAnchor, constant: 16),
            ratingView.heightAnchor.constraint(equalToConstant: 29),
            ratingView.widthAnchor.constraint(equalToConstant: 149)
            
        ])
    }
    
    private func setupCostLabelConstraints() {
        hotelView.addSubview(costLabel)
        
        costLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        NSLayoutConstraint.activate([
            costLabel.topAnchor.constraint(equalTo: hotelView.topAnchor, constant: 384),
            costLabel.leftAnchor.constraint(equalTo: hotelView.leftAnchor, constant: 16),
            costLabel.widthAnchor.constraint(equalToConstant: 174),
            costLabel.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        costLabel.minimumScaleFactor = 0.5
        costLabel.numberOfLines = 1
        costLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func setupAdressButtonConstraints() {
        hotelView.addSubview(adressButton)
        adressButton.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
            adressButton.topAnchor.constraint(equalTo: hotelView.topAnchor, constant: 351),
            adressButton.leftAnchor.constraint(equalTo: hotelView.leftAnchor, constant: 16),
            adressButton.rightAnchor.constraint(equalTo: hotelView.rightAnchor, constant: -16),
            adressButton.heightAnchor.constraint(equalToConstant: 17)
        ])
        adressButton.titleLabel?.minimumScaleFactor = 0.5
        adressButton.titleLabel?.numberOfLines = 1
        adressButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    private func setupPriceForItConstraints() {
        hotelView.addSubview(priceForIt)
        
        priceForIt.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
            priceForIt.topAnchor.constraint(equalTo: hotelView.topAnchor, constant: 398),
            priceForIt.leftAnchor.constraint(equalTo: hotelView.leftAnchor, constant: 198),
            priceForIt.heightAnchor.constraint(equalToConstant: 19),
            priceForIt.rightAnchor.constraint(equalTo: hotelView.rightAnchor, constant: -16)
        ])
        priceForIt.minimumScaleFactor = 0.5
        priceForIt.numberOfLines = 1
        priceForIt.adjustsFontSizeToFitWidth = true
    }
    
    private func setupStarImageConstraints() {
        ratingView.addSubview(starImage)
        
        NSLayoutConstraint.activate([
            starImage.leftAnchor.constraint(equalTo: ratingView.leftAnchor, constant: 10),
            starImage.widthAnchor.constraint(equalToConstant: 15),
            starImage.heightAnchor.constraint(equalToConstant: 15),
            starImage.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor)
        ])
    }
    
    private func setupRatingNameConstraints() {
        ratingView.addSubview(ratingName)
        ratingName.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        NSLayoutConstraint.activate([
            ratingName.widthAnchor.constraint(equalToConstant: 112),
            ratingName.heightAnchor.constraint(equalToConstant: 19),
            ratingName.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor),
            ratingName.rightAnchor.constraint(equalTo: ratingView.rightAnchor, constant: -10)
            
        ])
        ratingName.minimumScaleFactor = 0.5
        ratingName.numberOfLines = 1
        ratingName.adjustsFontSizeToFitWidth = true
    }
    
    private func setupAboutHotelLabelConstraints() {
        aboutHotelView.addSubview(aboutHotelLabel)
        
        NSLayoutConstraint.activate([
            aboutHotelLabel.topAnchor.constraint(equalTo: aboutHotelView.topAnchor, constant: 16),
            aboutHotelLabel.leftAnchor.constraint(equalTo: aboutHotelView.leftAnchor, constant: 16),
            aboutHotelLabel.heightAnchor.constraint(equalToConstant: 26),
            aboutHotelLabel.rightAnchor.constraint(equalTo: aboutHotelView.rightAnchor, constant: -16)
        ])
    }
    
    private func setupDescriptionLabelConstraints() {
        aboutHotelView.addSubview(descriptionLabel)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byTruncatingTail
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.minimumScaleFactor = 0.5
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: peculiaritiesView.bottomAnchor, constant: 12),
            descriptionLabel.leftAnchor.constraint(equalTo: aboutHotelView.leftAnchor, constant: 16),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 76),
            descriptionLabel.rightAnchor.constraint(equalTo: aboutHotelView.rightAnchor, constant: -16)
        ])
    }
    
    private func setupPeculiaritiesViewConstraints() {
        aboutHotelView.addSubview(peculiaritiesView)
        
        containerHeightConstraint = peculiaritiesView.heightAnchor.constraint(equalToConstant: 10)
        
        NSLayoutConstraint.activate([
            peculiaritiesView.topAnchor.constraint(equalTo: aboutHotelView.topAnchor, constant: 58),
            peculiaritiesView.leftAnchor.constraint(equalTo: aboutHotelView.leftAnchor, constant: 16),
            peculiaritiesView.rightAnchor.constraint(equalTo: aboutHotelView.rightAnchor, constant: -16),
            containerHeightConstraint,
        ])
        
        addTagLabels()
    }
    
    private func  addTagLabels() {
        for j in 0..<self.tagNames.count {
            
            let newLabel = UILabel()
            
            newLabel.text = tagNames[j]
            newLabel.textAlignment = .center
            newLabel.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 252/255, alpha: 1)
            newLabel.textColor = UIColor(red: 130/255, green: 135/255, blue: 150/255, alpha: 1)
            newLabel.layer.masksToBounds = true
            newLabel.layer.cornerRadius = 5
            
            newLabel.frame.size.width = newLabel.intrinsicContentSize.width + tagPadding
            newLabel.frame.size.height = tagHeight
            
            peculiaritiesView.addSubview(newLabel)
            tagLabels.append(newLabel)
        }
    }
    
    private func displayTagLabels() {
        let containerWidth = peculiaritiesView.frame.width
        
        var currentOriginX: CGFloat = 0
        var currentOriginY: CGFloat = 0
        
        tagLabels.forEach { label in
            if currentOriginX + label.frame.width > containerWidth {
                currentOriginX = 0
                currentOriginY += tagHeight + tagSpacingY
            }
            label.frame.origin.x = currentOriginX
            label.frame.origin.y = currentOriginY
            
            currentOriginX += label.frame.width + tagSpacingX
        }
        containerHeightConstraint.constant = currentOriginY + tagHeight
        
    }
    
}