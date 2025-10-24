Return-Path: <linux-kernel+bounces-868393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BACA0C051A6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E37D5648C9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C620F30DD1C;
	Fri, 24 Oct 2025 08:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="k2Vhydir"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B2930BF5D;
	Fri, 24 Oct 2025 08:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761294799; cv=none; b=nXkbRnHni7hdI7WddXlre5XiMLgGTR6c59TpSJLbRgFezHfm6NGVBJOXOXoWbySsonn2DvkDunBXerzp50ibslwL0PeJJchcnUY1lJdH+kUbIZUdHHZBEtFvWLHadwBof7de0SrGbTQPP8BZ0Ea9XtuOEmnFc4USQ63kCmyP4BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761294799; c=relaxed/simple;
	bh=YqO1T0x5GSKjDARuiu0Has2FHu7zVh+8KSe8/MxVcXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFXDTW98xpZkKG8G4yIRUrwoeO2RTz5C4u4bZQ/obf4tevAa7UI0EY31ui0Lvtek37JU9IHK3zLvFqKugws3yw7UowdzahX47OwSwnMfLyAOCuXrSnGhp5LMmtT2xhGJNTGkE9raOL6/oEMfJX1KSIxZcjkx7QV45kQYB638odg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=k2Vhydir; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761294793;
	bh=YqO1T0x5GSKjDARuiu0Has2FHu7zVh+8KSe8/MxVcXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k2VhydirnJMdQJ0O3J74s12j7oqCdtL393Bci/64JXKvDJAmnTMU54y4fORPuJ5Dh
	 sj7XezEVF4pAJHg8gNDDd8ojVniRmxGUY4fXOtfSCGi7pfM7P5SuA4GOkJwzQzyU/Z
	 pjabaKKiD0vd1ZCs8HMzEvaDkJCmG9tM55Hy7UNZdj/9aobgw68MG41tzWmErzQnKV
	 EegvNEDsrm4WXuzyGKAX9JNocb+iBvd0nRG+5o5a1SXjYe9GL1VCSHsSgnEC29gDT9
	 nP6t9DvnfJyQ2DFmN7z2SAp4OR0ONA075N1lQvzdN2EKz6rWDjH3Dl75YRop25csQt
	 nZmpkYt87OMGQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 87C1B17E1404;
	Fri, 24 Oct 2025 10:33:12 +0200 (CEST)
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
Subject: [PATCH v1 4/7] clk: mediatek: Add and wire up mtk_spmi_clk_register_gates()
Date: Fri, 24 Oct 2025 10:32:58 +0200
Message-ID: <20251024083301.25845-5-angelogioacchino.delregno@collabora.com>
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

In preparation for adding means to register SPMI clock controllers
add a new mtk_spmi_clk_register_gates() function and wire it up to
mtk_clk_simple_probe_internal().

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-gate.c | 10 ++++++++++
 drivers/clk/mediatek/clk-gate.h |  6 ++++++
 drivers/clk/mediatek/clk-mtk.c  |  8 ++++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index 8d1cc6a98a5f..1bc09c5ca897 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -319,6 +319,16 @@ int mtk_clk_register_gates(struct device *dev, struct device_node *node,
 }
 EXPORT_SYMBOL_GPL(mtk_clk_register_gates);
 
+int mtk_spmi_clk_register_gates(struct device *dev, struct device_node *node,
+				const struct mtk_gate *clks, int num,
+				struct clk_hw_onecell_data *clk_data,
+				struct regmap *regmap)
+{
+	return mtk_clk_register_all_gates(dev, node, regmap, NULL,
+					  clks, num, clk_data);
+}
+EXPORT_SYMBOL_GPL(mtk_spmi_clk_register_gates);
+
 void mtk_clk_unregister_gates(const struct mtk_gate *clks, int num,
 			      struct clk_hw_onecell_data *clk_data)
 {
diff --git a/drivers/clk/mediatek/clk-gate.h b/drivers/clk/mediatek/clk-gate.h
index 4f05b9855dae..924219344021 100644
--- a/drivers/clk/mediatek/clk-gate.h
+++ b/drivers/clk/mediatek/clk-gate.h
@@ -14,6 +14,7 @@ struct clk_hw_onecell_data;
 struct clk_ops;
 struct device;
 struct device_node;
+struct regmap;
 
 extern const struct clk_ops mtk_clk_gate_ops_setclr;
 extern const struct clk_ops mtk_clk_gate_ops_setclr_inv;
@@ -57,6 +58,11 @@ int mtk_clk_register_gates(struct device *dev, struct device_node *node,
 			   const struct mtk_gate *clks, int num,
 			   struct clk_hw_onecell_data *clk_data);
 
+int mtk_spmi_clk_register_gates(struct device *dev, struct device_node *node,
+				const struct mtk_gate *clks, int num,
+				struct clk_hw_onecell_data *clk_data,
+				struct regmap *regmap);
+
 void mtk_clk_unregister_gates(const struct mtk_gate *clks, int num,
 			      struct clk_hw_onecell_data *clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 93c7e28ffb5f..b5b329f6fde7 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -552,8 +552,12 @@ int mtk_clk_simple_probe_internal(struct platform_device *pdev,
 	}
 
 	if (mcd->clks) {
-		r = mtk_clk_register_gates(&pdev->dev, node, mcd->clks,
-					   mcd->num_clks, clk_data);
+		if (regmap)
+			r = mtk_spmi_clk_register_gates(&pdev->dev, node, mcd->clks,
+							mcd->num_clks, clk_data, regmap);
+		else
+			r = mtk_clk_register_gates(&pdev->dev, node, mcd->clks,
+						   mcd->num_clks, clk_data);
 		if (r)
 			goto unregister_dividers;
 	}
-- 
2.51.1


