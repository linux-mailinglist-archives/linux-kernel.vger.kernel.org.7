Return-Path: <linux-kernel+bounces-871389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDE3C0D1BE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534A840447A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15182FD660;
	Mon, 27 Oct 2025 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Xyxvd/U1"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172282FB63B;
	Mon, 27 Oct 2025 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761563632; cv=none; b=L8n6J49ocvJLnzF8t6D4UBhPMkM4pNJ7i5yASmkATeT8ICXPsq/UqjMLC9c0MBoucpUXX2VkJ0D3PNmSubcq/1+3xHFaCtCz2kWlFIII+4JWlAtgopI+vkXaLAf7n6FRPKy8n6g+uEK7wQgP8Syc13TxjwTqIuRIhYXAIF+0T0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761563632; c=relaxed/simple;
	bh=f5P3+e3xtzKeCpgjf0REjVgwacDa/HF6QyCwbdP8mxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQjtr8ggIZQZ7JaZ8ZtbraT1A2LEfsVguomJ5aYN9YRf/vVxJgaMADYaDTsFHlFUTYSsS80Bffn9aTMWhjMIJZ5i2GOygDThtcTUW3Glr/FMMNnilHuFKMrrsmlXm1ML+vI8dV142b3yZJ/WJCfTJ8rpNJB09uVq23/jYyJ90/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Xyxvd/U1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761563629;
	bh=f5P3+e3xtzKeCpgjf0REjVgwacDa/HF6QyCwbdP8mxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xyxvd/U1O2a3lCyj/QysGL0noPhkvEb7ZearpAdcQoN6BXRe8Dt7PpdbzbncKghY8
	 jgrCcHOhdOxIkemvrtoxwVUERBEfcSICh++GmgL7Jso0rOgCl2Woehj0iDdQ+qGIA4
	 cK/yK2FfFbFJtuW1AHq7t7IDgMg3PSDjf6LLGYI7hyqpiR7ZjGELWKVKpxJq1IZNie
	 xOzwvxEtrRC30UTtyFx1KOo+rsMYUo2+hNTtaN8QakQlIlyGmgk+h4e0psdbZ7/jct
	 tXuVgNUFQ7cI5XkmiIbGLhF/rDJLywAyM0QLJPTt/B0u+grXtAld7yOkQ3zvsZkiDP
	 lJLhahC/Mxh4w==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id ADD0817E1413;
	Mon, 27 Oct 2025 12:13:48 +0100 (CET)
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
Subject: [PATCH v2 4/7] clk: mediatek: Add and wire up mtk_spmi_clk_register_gates()
Date: Mon, 27 Oct 2025 12:13:40 +0100
Message-ID: <20251027111343.21723-5-angelogioacchino.delregno@collabora.com>
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
index bf57c65b01ff..a33011358f08 100644
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


