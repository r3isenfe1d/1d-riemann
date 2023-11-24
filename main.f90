    !> Libs
    use kind_parameters
    use global_data
    use computational_domain_class
    use chemical_properties_class
    use solver_options_class
    use computational_mesh_class
    use mpi_communications_class
    use data_manager_class
    use boundary_conditions_class
    use field_scalar_class
    use field_vector_class
    use data_save_class
    use data_io_class
    use post_processor_manager_class

    implicit none

    !> Objects of main classes
    type(computational_domain)              :: problem_domain
    type(data_manager)                      :: problem_data_manager
    type(mpi_communications)                :: problem_mpi_support

    type(chemical_properties),      target  :: problem_chemistry

    type(solver_options)                    :: problem_solver_options

    type(boundary_conditions),      target  :: problem_boundaries
    type(field_scalar_cons),        target  :: p, T, rho
    type(field_vector_cons),        target  :: v, Y
    type(post_processor_manager),   target  :: problem_post_proc_manager

    type(data_io)                           :: problem_data_io
    type(data_save)                         :: problem_data_save

    !> Additional variables
    real(dkind),    dimension(3)	:: cell_size
    integer,        dimension(3,2)	:: utter_loop, observation_slice, summation_region
    integer 						:: log_unit

    character(len=500)			:: initial_work_dir
    character(len=100)			:: work_dir
    character(len=15)			:: solver_name

    real(dkind)	:: domain_length, ignition_region
    real(dkind)	:: CFL_coeff
    real(dkind)	:: delta_x, offset
    real(dkind)	:: nu

    logical	:: stop_flag

    integer	:: task1, task2, task3, task4
    integer	:: ierr

    ierr = getcwd(initial_work_dir)

    call system('mkdir '// task_setup_folder)
    open(newunit = log_unit, file = problem_setup_log_file, status = 'replace', form = 'formatted')

    problem_domain = computational_domain_c(dimensions = 1, cells_number coordinate_system = (/5000, 1, 1/), coordinate_system = 'cartesian', lengths = reshape((/0.0_dkind, 0.0_dkind, 0.0_dkind, 0.05_dkind,0.005_dkind,0.005_dkind/),(/3,2/)), axis_name = (/'x', 'y', 'z'/))
    