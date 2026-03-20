# Finite Algebra Witness Problem

## Objetivo

Archivo objetivo: `LeanLab/Exercises/OpenGaussFiniteAlgebra.lean`

Teorema objetivo:

`exists_finite_ring_with_unit_witnesses`

Interpretacion: anillo asociativo con unidad (no conmutativo en general).

Buscar `R` finito y unidades `a b : R` tales que:

* `b * a + b ^ 2 * a * b = 1`
* `a + b ^ 2 * a ^ 2 + b ^ 3 = 0`
* `a ^ 3 + a ^ 2 * b + a * b + b ≠ 1`

## Workflow robusto (anti-falsos positivos)

1. Ejecutar estado de proyecto
* `/project status`

2. Ejecutar prueba guiada con restricciones fuertes
* `/prove LeanLab/Exercises/OpenGaussFiniteAlgebra.lean`
* Prompt interno recomendado:
	* `Keep theorem statement unchanged.`
	* `Do not negate or weaken theorem.`
	* `No sorry/admit.`
	* `Do not claim done unless file has zero Lean errors.`

3. Regla tecnica clave
* Evitar `native_decide` directo sobre `IsUnit` dentro del existencial.
* Usar busqueda decidible con testigos explicitos de inversa:
	* `∃ a b ai bi, a*ai=1 ∧ ai*a=1 ∧ b*bi=1 ∧ bi*b=1 ∧ ...`
* Luego convertir a `IsUnit a` y `IsUnit b` constructivamente.

4. Gate de validacion (obligatorio)
* Verificar que el archivo no tenga errores Lean.
* Si hay errores, NO aceptar el resultado y volver al paso 2.

5. Definition of Done
* Teorema original intacto.
* Cero errores en `LeanLab/Exercises/OpenGaussFiniteAlgebra.lean`.
* Sin `sorry`, sin `admit`.
* Si hay testigo explicito, anotar `R`, `a`, `b`, `ai`, `bi`.

## Prompt listo para usar en Gauss

`Edit only LeanLab/Exercises/OpenGaussFiniteAlgebra.lean. Keep theorem statement unchanged. Prove theorem with no sorry/admit. Do not negate or weaken theorem. Use decidable search with explicit inverse witnesses (a,b,ai,bi) instead of native_decide directly on IsUnit existential. Convert witness equalities into IsUnit proofs constructively. Continue iterating until Lean errors are zero.`

## Si se atasca

* Reducir el espacio de busqueda por familias de anillos finitos.
* Guardar progreso por etapas en lemas auxiliares decidibles.
* No mezclar algebra simbolica agresiva con `noncomm_ring` si empieza a divergir; preferir pruebas por testigos finitos verificables.