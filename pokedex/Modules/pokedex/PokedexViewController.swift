//
//  PokedexViewController.swift
//  pokedex
//
//  Created by francisco rafael aguilar lugo on 11/09/23.
//

import UIKit

class PokedexViewController: UIViewController {
    
    var presenter: PokedexPresenterProtocol?

    let contentView = UIView()
    let backgroundView = UIView()
    let nameLabel = UILabel()
    let typeLabel = UILabel()
    let weightLabel = UILabel()
    let heightLabel = UILabel()
    let pokemonImageView = UIImageView()
    
    let alert = UIAlertController(title: nil, message: "Cargando...", preferredStyle: .alert)
    let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))

    
    var pokemonSearch = 1
    var spriteSearch = 0
    
    var spriteData: [String]?
    
    var pokemonData: PokemonDetailModel?

    let previousButton = UIButton()
    let downSearchButton = UIButton()
    let upSearchButton = UIButton()
    let nextButton = UIButton()
    let randomButton = UIButton()
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)


        
        self.title = "POKEDEX"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        presenter?.getPokemonsPresenter(id: "1")

        backgroundView.backgroundColor = .systemRed
        view.addSubview(backgroundView)

        contentView.backgroundColor = .systemGray5
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        view.addSubview(contentView)

        pokemonImageView.contentMode = .scaleAspectFit
        contentView.addSubview(pokemonImageView)
        pokemonImageView.layer.cornerRadius = 8.0
        pokemonImageView.backgroundColor = .red

        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        nameLabel.text = "Label"
        nameLabel.textColor = .black
        contentView.addSubview(nameLabel)
        
        
        typeLabel.textAlignment = .center
        typeLabel.text = "Label"
        typeLabel.font = UIFont.systemFont(ofSize: 18)
        contentView.addSubview(typeLabel)

        weightLabel.textAlignment = .center
        weightLabel.text = "Label"
        weightLabel.font = UIFont.systemFont(ofSize: 18)
        contentView.addSubview(weightLabel)
        
        heightLabel.textAlignment = .center
        heightLabel.text = "Label"
        heightLabel.font = UIFont.systemFont(ofSize: 18)
        contentView.addSubview(heightLabel)
        

        previousButton.setTitle("←", for: .normal)
        previousButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        previousButton.setTitleColor(.black, for: .normal)
        previousButton.backgroundColor = .yellow
        previousButton.layer.cornerRadius = 8.0
        previousButton.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside)
        contentView.addSubview(previousButton)

        downSearchButton.setTitle("↓", for: .normal)
        downSearchButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        downSearchButton.setTitleColor(.black, for: .normal)
        downSearchButton.backgroundColor = .yellow
        downSearchButton.layer.cornerRadius = 8.0
        downSearchButton.addTarget(self, action: #selector(downButtonTapped), for: .touchUpInside)
        contentView.addSubview(downSearchButton)

        upSearchButton.setTitle("↑", for: .normal)
        upSearchButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        upSearchButton.setTitleColor(.black, for: .normal)
        upSearchButton.backgroundColor = .yellow
        upSearchButton.layer.cornerRadius = 8.0
        upSearchButton.addTarget(self, action: #selector(upButtonTapped), for: .touchUpInside)
        contentView.addSubview(upSearchButton)

        nextButton.setTitle("→", for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.backgroundColor = .yellow
        nextButton.layer.cornerRadius = 8.0
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        contentView.addSubview(nextButton)
        
        randomButton.setTitle("R", for: .normal)
        randomButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        randomButton.setTitleColor(.black, for: .normal)
        randomButton.backgroundColor = .yellow
        randomButton.layer.cornerRadius = 8.0
        randomButton.addTarget(self, action: #selector(randomButtonTapped), for: .touchUpInside)
        contentView.addSubview(randomButton)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        contentView.addSubview(tableView)

        setupConstraints()
    }

    func setupConstraints() {
        randomButton.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        downSearchButton.translatesAutoresizingMaskIntoConstraints = false
        upSearchButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentView.widthAnchor.constraint(equalToConstant: 300),
            contentView.heightAnchor.constraint(equalToConstant: 650)
        ])

        NSLayoutConstraint.activate([
            pokemonImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            pokemonImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 120),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 120)
        ])

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            typeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            weightLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 25),
            weightLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
        ])
        
        NSLayoutConstraint.activate([
            heightLabel.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 25),
            heightLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
        ])
        
        

        NSLayoutConstraint.activate([
            previousButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            previousButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            previousButton.widthAnchor.constraint(equalToConstant: 50),
            previousButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        NSLayoutConstraint.activate([
            downSearchButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            downSearchButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            downSearchButton.widthAnchor.constraint(equalToConstant: 50),
            downSearchButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        NSLayoutConstraint.activate([
            upSearchButton.bottomAnchor.constraint(equalTo: downSearchButton.topAnchor, constant: -10),
            upSearchButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            upSearchButton.widthAnchor.constraint(equalToConstant: 50),
            upSearchButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            nextButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            nextButton.widthAnchor.constraint(equalToConstant: 50),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            randomButton.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 60),
            randomButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            randomButton.widthAnchor.constraint(equalToConstant: 50),
            randomButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: upSearchButton.topAnchor, constant: -12)
        ])
    }
    
    @objc func previousButtonTapped() {
        
        if pokemonSearch <= 1 {
            print(pokemonSearch)
        } else {
            pokemonSearch -= 1
            print(pokemonSearch)
            showPokemon()
            spriteSearch = 0
        }
    }
    
    @objc func randomButtonTapped() {
        pokemonSearch = Int(randomNumber())
        showPokemon()
    }

    @objc func upButtonTapped() {
        if spriteSearch == (spriteData?.count ?? 0) - 1 {
            print("out of range")
        }else{
            print(spriteData?.count)
            spriteSearch += 1
            print(spriteSearch)
            pokemonImageView.loadImage(from: spriteData?[spriteSearch] ?? "")
        }
    }

    @objc func downButtonTapped() {
        if spriteSearch == 0 {
            print(0)
        } else {
            spriteSearch -= 1
            pokemonImageView.loadImage(from: spriteData![spriteSearch])
        }
    }

    @objc func nextButtonTapped() {
        pokemonSearch += 1
        spriteSearch = 0
        showPokemon()
    }
    
    func showPokemon() {
        
        present(alert, animated: true, completion: nil)
        presenter?.getPokemonsPresenter(id: "\(pokemonSearch)")

    }
    
    func decimetersToMeters(decimeters: Int) -> Double {
        let meters = Double(decimeters) / 10.0
        return meters
    }
    
    func hectogramsToKg(hectograms: Int) -> Double {
        let kg = Double(hectograms) / 10.0
        return kg
    }
    
    func randomNumber() -> UInt32 {
        let randomNumber = arc4random_uniform(1014) + 1
        return randomNumber
    }
    
}

extension PokedexViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(pokemonData?.abilities.count)
        return pokemonData?.abilities.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let emptyCell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = pokemonData?.abilities[indexPath.row].ability.name
        
        return cell ?? emptyCell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Habilidades"
    }
    
    
}

extension PokedexViewController: PokedexViewProtocol {
    func getPokemonsRequestSuccess(dataPokemon: PokemonDetailModel, sprites: [String]) {
        dismiss(animated: false, completion: nil)
        pokemonData = dataPokemon
        
        spriteData = sprites
        
        DispatchQueue.main.async {
            self.pokemonImageView.loadImage(from: dataPokemon.sprites?.frontDefault ?? "" )
            self.nameLabel.text = dataPokemon.name
            self.typeLabel.text = dataPokemon.types.first?.type.name
            self.weightLabel.text = "Peso: \(self.hectogramsToKg(hectograms: dataPokemon.weight)) kg"
            self.heightLabel.text = "Altura: \(self.decimetersToMeters(decimeters: dataPokemon.height ?? 0)) m"
            self.tableView.reloadData()
        }
    }
    
    
    func getPokemonsRequestFailure() {
        DispatchQueue.main.async {
            self.dismiss(animated: false, completion: nil)
        }
        print("error backend")
    }
    
}
