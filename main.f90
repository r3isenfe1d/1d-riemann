    program package_interface
    !> Libs
    use kind_parameters
    use global_data
    use computational_domain_class
    use chemical_properties_class
    use solver_options_class
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

    print *, 'Hello from main :)'
    end program package_interface