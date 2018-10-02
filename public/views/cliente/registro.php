<div class="row">
    <div class="col-lg-12">
        <section class="panel">
            <header class="panel-heading">
                REGISTRO CLIENTE
            </header>
            <div class="panel-body">
                <div class=" form">
                    <form class="cmxform form-horizontal adminex-form" id="frmUsuario" name="frmUsuario" method="post">
                        <div class="form-group ">
                            <label for="cname" class="control-label col-lg-2">Nombre completo (obligatorio)</label>
                            <div class="col-lg-8">
                                <input class=" form-control" id="name" name="name" minlength="2" type="text" required />
                            </div>
                        </div>
                        <div class="form-group ">
                            <label for="user" class="control-label col-lg-2">nombre de usuario (Obligatorio)</label>
                            <div class="col-lg-8">
                                <input class="form-control " id="user" type="text" name="user" required />
                            </div>
                        </div>
                        <div class="form-group ">
                            <label for="password" class="control-label col-lg-2">Contraseña (obligatorio)</label>
                            <div class="col-lg-8">
                                <input class="form-control " id="password" type="password" name="password" required />
                            </div>
                        </div>
                        <div class="form-group ">
                            <label for="password_repeat" class="control-label col-lg-2">Repetir contraseña</label>
                            <div class="col-lg-8">
                                <input class="form-control" type="password" id="password_repeat" name="password_repeat" required/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-offset-2 col-lg-10">
                                <button class="btn btn-primary" type="submit">Registrar</button>
                                <button class="btn btn-default" type="button">Cancelar</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </section>
    </div>
</div>