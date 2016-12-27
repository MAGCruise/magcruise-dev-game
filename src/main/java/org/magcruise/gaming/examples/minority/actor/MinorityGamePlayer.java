package org.magcruise.gaming.examples.minority.actor;

import org.magcruise.gaming.lang.Parameters;
import org.magcruise.gaming.model.game.HistoricalField;
import org.magcruise.gaming.model.game.Player;
import org.magcruise.gaming.model.game.PlayerParameter;
import org.magcruise.gaming.ui.model.FormBuilder;
import org.magcruise.gaming.ui.model.input.RadioInput;

public class MinorityGamePlayer extends Player {

	@HistoricalField(name = "選択したアイテム")
	public volatile String item;

	public MinorityGamePlayer(PlayerParameter playerParameter) {
		super(playerParameter);
	}

	public void vote(MinorityGameContext ctx) {
		FormBuilder b = new FormBuilder();

		b.setLabel("1000円のアイテムXと100円のアイテムYがあります．"
				+ "あなたの他に2人プレーヤがいて，あなただけが他のプレーヤと異なるアイテムを選べば，そのアイテムを貰うことができます．"
				+ " もし，一緒のアイテムを選んだ場合は，何も貰うことは出来ません．どちらのアイテムを選びますか？");
		b.addInput(new RadioInput("アイテムの選択", "choice", "X",
				new String[] { "アイテムX", "アイテムY" }, new String[] { "X", "Y" }));
		syncRequestToInput(b.build(), (Parameters params) -> {
			this.item = params.getString("choice");
			log.debug(item);
		});
	}

}
