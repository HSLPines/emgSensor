
import { parse } from "path";
import app = require("teem");

class IndexRoute {

	@app.http.post()
	public async inserirLeitura(req: app.Request, res: app.Response) {

		let erro: string = null;

		let leitura = req.body;

		leitura.emg = parseInt(leitura.emg);

		if (!leitura) {
			erro = "Dados inválidos";
		} else if (isNaN(leitura.emg)) {
			erro = "Leitura EMG inválida";
		}

		if (erro) {
			res.status(400).json(erro);
		} else {

			await app.sql.connect(async (sql: app.Sql) => {
				await sql.query("insert into modelo_emg(id_leitura, id_sessao, tempo, tensao, amplitude), values (?, ?, ?, ?, ?)", leitura);
			});
			res.status(204).end();

		}

	}
	

	public async index(req: app.Request, res: app.Response) {
		

		let hoje = new Date();

		let mes = hoje.getMonth() + 1;
		let dia = hoje.getDate();

		let opcoes = {

			ano: hoje.getFullYear(),
			mes: (mes < 10 ? "0" + mes : mes),
			dia: (dia < 10 ? "0" + dia : dia)

		};

		res.render("index/index", opcoes);

	}

	public async home(req: app.Request, res: app.Response) {

		let opcoes = {
			titulo: "Home"
		};

		res.render("index/home", opcoes);

	}

	public async dev(req: app.Request, res: app.Response) {

		let opcoes = {
			titulo: "Dev"
		};

		res.render("index/dev", opcoes);

	}

	public async sobre(req: app.Request, res: app.Response) {

		let opcoes = {
			titulo: "Sobre"
		};

		res.render("index/sobre", opcoes);

	}

	public async relatorio(req: app.Request, res: app.Response) {

		let opcoes = {
			titulo: "Relatório"
		};

		res.render("index/relatorio", opcoes);

	}

	public async obterDadosDev(req: app.Request, res: app.Response) {
		let dados: any[] = [];
	
		await app.sql.connect(async (sql: app.Sql) => {
			let lista: any[] = await sql.query("select amplitude from leitura order by id_leitura desc limit 100");
			let reverseLista = lista.reverse();
			
			dados = reverseLista.map((l, index) => {
				return {
					dia: `Dia ${index + 1}`,
					valor: l.amplitude
				};
			});
		});
	
		res.json(dados);
	}
	


}

export = IndexRoute;
