Return-Path: <linux-kernel+bounces-868388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D99C0512B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8661AA0B1F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9C730BB88;
	Fri, 24 Oct 2025 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pYMeoMlu"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE0E3064B1;
	Fri, 24 Oct 2025 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761294794; cv=none; b=TNYvgLgpzdg982A/Q/f8/CVd/Aete/v5N1uFranR3eqCgxg27qUf06YldM6aubI1u95U+Pyp/5LA1a85FGEkD2B9aOSxZSq5V2mMlFoF0JJjIMK+lBov/YbwRX3GqsCJIfJqMCs3Ur4AFGZZ85GZ689UYiUmchunfH7Mx1Nl7vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761294794; c=relaxed/simple;
	bh=GnXom17LPeRNQIG22zsGuukZcFHtFvIHWJ7Waw4tsSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VIG6XlLHqdGn2UdzxvgwsMpr05MYyPPKK6snyzrSMrdIyRfsvzT6utx3FTlQ1dJV9nJgxge0lxzv6GhDyyYQZ+8Olgap1Yn8Z34FMtC+5KuwCWZ6lne5jsvY3wjPVzypflycyplf0PQ3wWOiBte6dVj+Zu3SyniJa/1OFFEPXJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pYMeoMlu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761294790;
	bh=GnXom17LPeRNQIG22zsGuukZcFHtFvIHWJ7Waw4tsSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pYMeoMlufLsWIxH3fO9lyb2yv5FCpKI3l9gBfEd5dCyjhWvUu3d/rwiGyTeWLpga1
	 CCWKdrO3DdGobDBcGlcyrrtfE2MWJw3jd5n1ByqvduSmlP+MKB+5J55Oa/5NEkP/pE
	 qVwQ8Z+5B2XMYbHQJOIPw1ggu52W91dT83WGunEE7V+XwHiXgtF4/iqSMV4lUVazBe
	 Xx1EXf9dZt6rlodhtQGjRVh29y55AJs86oNy1zKs28bowOdLmEFtqVoxzHRs6mADV9
	 gyLthaUdv0lRzhANwwSnTNkJAa4w6TuQoTwLpsSOSU1F0BzoHF5MiO1zoXUFT8g6Np
	 ESj9XGS3KkziA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 45F1D17E00AC;
	Fri, 24 Oct 2025 10:33:10 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: sboyd@kernel.org
Cc: mturquette@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	laura.nao@collabora.com,
	nfraprado@collabora.com,
	wenst@chromium.org,
	y.oudjana@protonmail.com,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 1/7] clk: mediatek: Split out registration from mtk_clk_register_gates()
Date: Fri, 24 Oct 2025 10:32:55 +0200
Message-ID: <20251024083301.25845-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251024083301.25845-1-angelogioacchino.delregno@collabora.com>
References: <20251024083301.25845-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding support for clock controllers over SPMI
bus, split out the actual registration iterator out of the function
mtk_clk_register_gates() to a new mtk_clk_register_all_gates()
private function, taking a handle to regmap and hwv_regmap as
parameters.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-gate.c | 43 ++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index f6b1429ff757..fd8cec95cd8d 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -252,30 +252,17 @@ static void mtk_clk_unregister_gate(struct clk_hw *hw)
 	kfree(cg);
 }
 
-int mtk_clk_register_gates(struct device *dev, struct device_node *node,
-			   const struct mtk_gate *clks, int num,
-			   struct clk_hw_onecell_data *clk_data)
+static int mtk_clk_register_all_gates(struct device *dev, struct device_node *node,
+				      struct regmap *regmap, struct regmap *hwv_regmap,
+				      const struct mtk_gate *clks, int num,
+				      struct clk_hw_onecell_data *clk_data)
 {
 	int i;
 	struct clk_hw *hw;
-	struct regmap *regmap;
-	struct regmap *regmap_hwv;
 
 	if (!clk_data)
 		return -ENOMEM;
 
-	regmap = device_node_to_regmap(node);
-	if (IS_ERR(regmap)) {
-		pr_err("Cannot find regmap for %pOF: %pe\n", node, regmap);
-		return PTR_ERR(regmap);
-	}
-
-	regmap_hwv = mtk_clk_get_hwv_regmap(node);
-	if (IS_ERR(regmap_hwv))
-		return dev_err_probe(
-			dev, PTR_ERR(regmap_hwv),
-			"Cannot find hardware voter regmap for %pOF\n", node);
-
 	for (i = 0; i < num; i++) {
 		const struct mtk_gate *gate = &clks[i];
 
@@ -311,6 +298,28 @@ int mtk_clk_register_gates(struct device *dev, struct device_node *node,
 
 	return PTR_ERR(hw);
 }
+
+int mtk_clk_register_gates(struct device *dev, struct device_node *node,
+			   const struct mtk_gate *clks, int num,
+			   struct clk_hw_onecell_data *clk_data)
+{
+	struct regmap *regmap, *regmap_hwv;
+
+	regmap = device_node_to_regmap(node);
+	if (IS_ERR(regmap)) {
+		pr_err("Cannot find regmap for %pOF: %pe\n", node, regmap);
+		return PTR_ERR(regmap);
+	}
+
+	regmap_hwv = mtk_clk_get_hwv_regmap(node);
+	if (IS_ERR(regmap_hwv))
+		return dev_err_probe(
+			dev, PTR_ERR(regmap_hwv),
+			"Cannot find hardware voter regmap for %pOF\n", node);
+
+	return mtk_clk_register_all_gates(dev, node, regmap, regmap_hwv,
+					  clks, num, clk_data);
+}
 EXPORT_SYMBOL_GPL(mtk_clk_register_gates);
 
 void mtk_clk_unregister_gates(const struct mtk_gate *clks, int num,
-- 
2.51.1


