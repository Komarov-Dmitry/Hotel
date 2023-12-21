
import UIKit

class HotelVC: UIViewController {
    
    var hotelData: ModelHotel?
    
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
        scroll.contentSize = CGSize(width: view.bounds.width, height: 922)
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
    
    private lazy var nameHotelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 22)
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
        
        return label
    }()
    
    private lazy var adressButton: UIButton = {
        let button = UIButton()
        //button.setTitle("Madinat Makadi, Safaga Road, Makadi Bay, Египет", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var priceForIt: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red: 130/255.0, green: 135/255.0, blue: 150/255.0, alpha: 1.0)
        //label.text = "за тур с перелётом"
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
        //label.text = "5 Превосходно"
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
        return label
    }()
    
    //MARK: - Peculiarities
    private lazy var peculiaritiesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private var tagNames: [String] = []
    private var tagLabels = [UILabel]()
    
    private let tagHeight:CGFloat = 29
    private let tagPadding: CGFloat = 12
    private let tagSpacingX: CGFloat = 8
    private let tagSpacingY: CGFloat = 8
    
    private var containerHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
    private lazy var detailedDataTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.isScrollEnabled = false
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Identifier")
        return table
    }()
    
    private let detailDataArray = ["Удобства", "Что включено", "Что не включено"]
    private let detailDataImage: [UIImage?] = [UIImage(named: "emoji"), UIImage(named: "tick"), UIImage(named: "close")]
        

    //MARK: - viewDidLoad()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "Отель"
        
        loadFromAPI()
        setupRoomButtonConstraints()
        setupScrollViewConstraints()
        setupHotelView()
       
        setupAboutHotelView()
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
        setupDetailedDataTableView()
        
    }
    
    fileprivate func loadFromAPI() {
        // Загрузка данных из сети
        if let url = URL(string: "https://run.mocky.io/v3/d144777c-a67f-4e35-867a-cacc3b827473") {
            NetworkManager.shared.fetchData(from: url) { result in
                switch result {
                case .success(let data):
                    self.hotelData = data
                    // Обновление UI в главном потоке
                    DispatchQueue.main.async {
                        self.updateUI()
                    }
                case .failure(let error):
                    print("Ошибка при загрузке данных: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func updateUI() {
        guard let hotelData = hotelData else { return }
        
        // Переписываем код с учетом новой структуры данных
        nameHotelLabel.text = hotelData.name
        adressButton.setTitle(hotelData.adress, for: .normal)
        
        costLabel.text = formatMinimalPrice(hotelData.minimalPrice)
        priceForIt.text = hotelData.priceForIt
        
        ratingName.text = "\(hotelData.rating) \(hotelData.ratingName)"
        descriptionLabel.text = hotelData.aboutTheHotel.aboutTheHotelDescription
        
        // Передаем URL-адреса изображений для отображения в вашем интерфейсе
        // (поменяйте это в соответствии с вашим интерфейсом)
        let imageURLs = hotelData.imageUrls
        
        // Здесь вы можете использовать imageURLs для загрузки изображений в ваш интерфейс
        
        tagNames = hotelData.aboutTheHotel.peculiarities
        addTagLabels()
        displayTagLabels()
    }
    
    //MARK: - viewDidLayoutSubviews()
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        displayTagLabels()
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
            aboutHotelView.heightAnchor.constraint(equalToConstant: 470)
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
        
        // Set up label properties for auto-shrinking
        nameHotelLabel.minimumScaleFactor = 0.5
        nameHotelLabel.numberOfLines = 1
        nameHotelLabel.adjustsFontSizeToFitWidth = true
        nameHotelLabel.textAlignment = .center // You can adjust this based on your preference
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
            descriptionLabel.topAnchor.constraint(equalTo: peculiaritiesView.bottomAnchor, constant: 16),
            descriptionLabel.leftAnchor.constraint(equalTo: aboutHotelView.leftAnchor, constant: 16),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 76),
            descriptionLabel.rightAnchor.constraint(equalTo: aboutHotelView.rightAnchor, constant: -16)
        ])
    }
    
    private func setupPeculiaritiesViewConstraints() {
        aboutHotelView.addSubview(peculiaritiesView)
        
        containerHeightConstraint = peculiaritiesView.heightAnchor.constraint(equalToConstant: 10)
        
        NSLayoutConstraint.activate([
            peculiaritiesView.topAnchor.constraint(equalTo: aboutHotelLabel.bottomAnchor, constant: 16),
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
            newLabel.font = UIFont.systemFont(ofSize: 16)
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
    
    private func setupDetailedDataTableView() {
        aboutHotelView.addSubview(detailedDataTableView)
        
        detailedDataTableView.layer.cornerRadius = 15
        detailedDataTableView.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            detailedDataTableView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            detailedDataTableView.leftAnchor.constraint(equalTo: aboutHotelView.leftAnchor, constant: 16),
            detailedDataTableView.rightAnchor.constraint(equalTo: aboutHotelView.rightAnchor, constant: -16),
            detailedDataTableView.heightAnchor.constraint(equalToConstant: 183)
        ])
    }
    
    private func formatMinimalPrice(_ price: Int) -> String {
        return "от \(price.formattedWithSeparator()) ₽"
    }
   
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension HotelVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Identifier", for: indexPath)
        
        let model = detailDataArray[indexPath.row]
        let image = detailDataImage[indexPath.row]
        
        var listConfiguration = cell.defaultContentConfiguration()
        listConfiguration.text = model
        listConfiguration.textProperties.font = UIFont.systemFont(ofSize: 16)
        listConfiguration.secondaryText = "Самое необходимое"
        listConfiguration.secondaryTextProperties.font = UIFont.systemFont(ofSize: 14)
        listConfiguration.secondaryTextProperties.color = UIColor.gray
        
        // Создаем специальное содержимое для хранения изображения и меток
        let customContentView = UIView()
        customContentView.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(customContentView)
        
        // Изображение для фотографии
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        customContentView.addSubview(imageView)
        
        // Метка для текста
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = listConfiguration.text
        textLabel.font = listConfiguration.textProperties.font
        customContentView.addSubview(textLabel)
        
        // Метка для вторичного текста
        let secondaryLabel = UILabel()
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        secondaryLabel.text = listConfiguration.secondaryText
        secondaryLabel.font = listConfiguration.secondaryTextProperties.font
        secondaryLabel.textColor = listConfiguration.secondaryTextProperties.color
        customContentView.addSubview(secondaryLabel)
        
        let accessoryImageView = UIImageView()
        accessoryImageView.contentMode = .scaleAspectFit
        accessoryImageView.translatesAutoresizingMaskIntoConstraints = false
        accessoryImageView.image = UIImage(named: "check")
        customContentView.addSubview(accessoryImageView)
        
        
        // Настраиваем ограничения для специального содержимого, изображения и меток
        NSLayoutConstraint.activate([
            customContentView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
            customContentView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
            customContentView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8),
            customContentView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -8),
            
            imageView.leadingAnchor.constraint(equalTo: customContentView.leadingAnchor),
            imageView.centerYAnchor.constraint(equalTo: customContentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            
            textLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            textLabel.topAnchor.constraint(equalTo: customContentView.topAnchor),
            
            secondaryLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            secondaryLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 4),
            secondaryLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            
            accessoryImageView.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor),
            accessoryImageView.centerYAnchor.constraint(equalTo: customContentView.centerYAnchor),
            accessoryImageView.widthAnchor.constraint(equalToConstant: 24),
            accessoryImageView.heightAnchor.constraint(equalToConstant: 24),
        ])
        
        if indexPath.row == 1 {
            // Добавляем разделительную линию между 1 и 2 ячейкой
            let separatorView = UIView()
            separatorView.translatesAutoresizingMaskIntoConstraints = false
            separatorView.backgroundColor = UIColor.lightGray
            cell.contentView.addSubview(separatorView)
            
            NSLayoutConstraint.activate([
                separatorView.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor),
                separatorView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
                separatorView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                separatorView.heightAnchor.constraint(equalToConstant: 1)
            ])
        } else if indexPath.row == 2 {
            // Добавляем разделительную линию между 2 и 3 ячейкой
            let separatorView = UIView()
            separatorView.translatesAutoresizingMaskIntoConstraints = false
            separatorView.backgroundColor = UIColor.lightGray
            cell.contentView.addSubview(separatorView)
            
            NSLayoutConstraint.activate([
                separatorView.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor),
                separatorView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
                separatorView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                separatorView.heightAnchor.constraint(equalToConstant: 1)
            ])
        }
        
        cell.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 252/255, alpha: 1.0)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 61
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Не выполняйте никаких действий при нажатии на ячейку
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension Int {
    func formattedWithSeparator() -> String {
        let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                numberFormatter.groupingSeparator = " " // Используем пробел вместо запятой
                return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
