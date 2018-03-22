//
//  AnswerQuestionsViewController.swift
//  Alumni
//
//  Created by alumnos on 12/3/18.
//  Copyright © 2018 adrian. All rights reserved.
//

import UIKit

class AnswerQuestionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ExpandableHeaderViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var sections = [
        Section(genre: "1. ¿Puedo cambiar mi contraseña?",
                movies: ["Sí, sí puedes. En la pantalla de inicio de sesión tienes la opción '¿Olvidaste tu contraseña'.Tras verificar tu e-mail, podrás introducir una nueva contraseña."],
                expanded: false),
        Section(genre: "2. ¿Cómo puedo crear una nueva noticia?",
                movies: ["Pulsando en el icono '+' podrás añadir el tipo de noticia que elijas, rellenando todos los campos obligatorios."],
                expanded: false),
        Section(genre: "3. ¿Cómo puedo cambiar el idioma?",
                movies: ["Entrando en ajustes podrás editar el idioma de la aplicación."],
                expanded: false),
        Section(genre: "4. ¿Puedo cambiar mi contraseña?",
                movies: ["Sí, sí puedes. En la pantalla de inicio de sesión tienes la opción '¿Olvidaste tu contraseña'.Tras verificar tu e-mail, podrás introducir una nueva contraseña."],
                expanded: false),
        Section(genre: "5. ¿Cómo puedo crear una nueva noticia?",
                movies: ["Pulsando en el icono '+' podrás añadir el tipo de noticia que elijas, rellenando todos los campos obligatorios."],
                expanded: false),
        Section(genre: "6. ¿Cómo puedo cambiar el idioma?",
                movies: ["Entrando en ajustes podrás editar el idioma de la aplicación."],
                expanded: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (sections[indexPath.section].expanded) {
            return 90
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.customInit(title: sections[section].genre, section: section, delegate: self)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as! DescriptionTableViewCell
        cell.descriptionTV.text = sections[indexPath.section].movies[indexPath.row]
        return cell
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        
        
        tableView.beginUpdates()
        for i in 0 ..< sections[section].movies.count {
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }
    
    @IBAction func dismissVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let simpleVC = SimpleVC()
//        simpleVC.customInit(imageName: sections[indexPath.section].movies[indexPath.row])
//        tableView.deselectRow(at: indexPath, animated: true)
//        self.navigationController?.pushViewController(simpleVC, animated: true)
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
