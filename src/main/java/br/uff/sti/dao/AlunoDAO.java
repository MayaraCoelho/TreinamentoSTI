/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.uff.sti.dao;

import br.uff.sti.model.Aluno;
import org.springframework.data.repository.CrudRepository;

/**
 *
 * @author uff

 */

public interface AlunoDAO extends CrudRepository<Aluno, String> {
    
}
