Return-Path: <linux-kernel+bounces-871386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0706AC0D185
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD2B44F1731
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C191C2F9DAF;
	Mon, 27 Oct 2025 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YhLo3hnY"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EC12FB09C;
	Mon, 27 Oct 2025 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761563630; cv=none; b=ldKgbTq+EW5PQSXKMRjANJZoXYl9PPYt2D3mUPyG24ijLx7dPk71Akh44cgNAceWuay2ud502zlFk4+E/b45PHk1BDg8/oUxyg4O7WArCK+uT7f6LY5brlIDGHVOyDGLNbjvlcZKrULbJU+F/n5umEyEdagn5lkdmSzTO1mgUEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761563630; c=relaxed/simple;
	bh=GnXom17LPeRNQIG22zsGuukZcFHtFvIHWJ7Waw4tsSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfaR7a5CqKPPGOWnJSF62RmT9sycl715VttrodLyTswRHDk1062FBHzjyndYsHX30M0rluNavuWPQh89dAjuhSZ25iPpEF2fxt7Q5WffFNxhR34h/wHGe2Kp+cxi9XUBZSzuLa1O74yZSYZjWuskZFKdjPZkZJXJs/9pEdg2dMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YhLo3hnY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761563626;
	bh=GnXom17LPeRNQIG22zsGuukZcFHtFvIHWJ7Waw4tsSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YhLo3hnYFIORfQSJhhO3fVp1Np3qphJn4ftm9mVOpuYmYzk786LG2IK0zdPOKQ51f
	 vzhzWsct1XLj2KNusefo00Drw00bXa3ETa4gSXFNPBAU1xiQAurVMuh0uGtU/sIGX+
	 OoerBTMQnJ12YQK4iOtbUFIvS1AJMaQDe1uddGD0L4PUTeH7D6/+F66o4xxqFkcAF5
	 n0ne2fIIiq8eG/ye1vA06BlH9GSf8AZbI4H+F7pCDTiADtwFtKDi7cDjv6pgLANVyz
	 ruNQNyP7wReHF2fBSBacq1aAl3+H/xZ+G5sLEBtk97Q0h5RX/Pd98KrFjtDcmZx+L4
	 /MJnoHrIInQ7g==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 46B4A17E12AE;
	Mon, 27 Oct 2025 12:13:46 +0100 (CET)
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
Subject: [PATCH v2 1/7] clk: mediatek: Split out registration from mtk_clk_register_gates()
Date: Mon, 27 Oct 2025 12:13:37 +0100
Message-ID: <20251027111343.21723-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027111343.21723-1-angelogioacchino.delregno@collabora.com>
References: <20251027111343.21723-1-angelogioacchino.delregno@collabora.com>
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


