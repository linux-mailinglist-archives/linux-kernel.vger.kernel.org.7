Return-Path: <linux-kernel+bounces-871387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F122C0D1A9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AD753BE2C4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF5B2F7AC3;
	Mon, 27 Oct 2025 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KOLe+pT5"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8636D2FB0A0;
	Mon, 27 Oct 2025 11:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761563631; cv=none; b=I8xs2eUCaqREmCGU3FYr9xzm8EHdw7VXzb2dEieHHPmKGM/zyaepsWk9BUbKC+ww57BOpd5Im49p9KrjRzp8l7sBTfLZ7pxKz/HPsrfJPQq8cXnx25icz6kSu2mjCYs6zmvjqKED3HlMg8L3xN9bjQFtW7SEQPeQPfnJJIC+g/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761563631; c=relaxed/simple;
	bh=uMNDlVMiY8eMGT5nLR/6G4iE8k9njF/IX52KNy0kIlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFzap9SnXVK9tHgLe/84lN1pOVgEvTfcJeawJDBTxtDySp67PlSlXKspmVVb3QyyXTRd7/vcJsYk2riVt4/xgNDwRTVLUJpLhIOWF0ZSOxlflFuZK9kYjOQpV9uX7DI+xffhvFhoxnWvCJaT4lFA2akCHfldEmdvxVMFbnWc2CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KOLe+pT5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761563627;
	bh=uMNDlVMiY8eMGT5nLR/6G4iE8k9njF/IX52KNy0kIlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KOLe+pT590qSbVdRx3pvAbjB/Bhp/aE/O91IrwnBFmc2QSFvx1vQXEAHGB9R4wvBl
	 OFauX9t0RCgIzuRhqvf9MkwrqZuTYHAQvfoAxLhpNTkpiLz8ECbzkF5esT9Jw6ThMI
	 RvVCRFbC5Gb3aPj3kiCGBG9fMcXQ1Gg3j93qVO8NMWFRDgldVMTrNu0lF89pPAmOIF
	 Thjf39wUB2Qo91n+jIdlGRdkumQ5MRla1Yask/+o4qZNNvRJjAN6siTfIHj1Uvqazx
	 8GrM8KJnpURL9ZOefmHVT223vZePkjgy4sRCvjofA4qL5xRTlyInX79pPB+XbSIOEy
	 kaGvYC0hHw3xw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 17D6B17E12D5;
	Mon, 27 Oct 2025 12:13:47 +0100 (CET)
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
Subject: [PATCH v2 2/7] clk: mediatek: clk-gate: Simplify and optimize registration iter
Date: Mon, 27 Oct 2025 12:13:38 +0100
Message-ID: <20251027111343.21723-3-angelogioacchino.delregno@collabora.com>
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

Simplify and optimize mtk_clk_register_all_gates() by removing and
replacing the function-local clk_hw pointer assignment and check
and as last step the consequent assignment to the array containing
handles to the registered clocks with... just the last step.

This removes a bunch of useless assignments, and in case any error
happens, the tear down iterator will still do its job without any
change required, effectively bringing no functional change, and a
a small optimization.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-gate.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index fd8cec95cd8d..8d1cc6a98a5f 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -257,8 +257,7 @@ static int mtk_clk_register_all_gates(struct device *dev, struct device_node *no
 				      const struct mtk_gate *clks, int num,
 				      struct clk_hw_onecell_data *clk_data)
 {
-	int i;
-	struct clk_hw *hw;
+	int i, ret;
 
 	if (!clk_data)
 		return -ENOMEM;
@@ -272,21 +271,19 @@ static int mtk_clk_register_all_gates(struct device *dev, struct device_node *no
 			continue;
 		}
 
-		hw = mtk_clk_register_gate(dev, gate, regmap, regmap_hwv);
-
-		if (IS_ERR(hw)) {
+		clk_data->hws[gate->id] = mtk_clk_register_gate(dev, gate, regmap, hwv_regmap);
+		if (IS_ERR(clk_data->hws[gate->id])) {
 			pr_err("Failed to register clk %s: %pe\n", gate->name,
-			       hw);
+			       clk_data->hws[gate->id]);
+			ret = PTR_ERR(clk_data->hws[gate->id]);
 			goto err;
 		}
-
-		clk_data->hws[gate->id] = hw;
 	}
 
 	return 0;
 
 err:
-	while (--i >= 0) {
+	while (i-- >= 0) {
 		const struct mtk_gate *gate = &clks[i];
 
 		if (IS_ERR_OR_NULL(clk_data->hws[gate->id]))
@@ -296,7 +293,7 @@ static int mtk_clk_register_all_gates(struct device *dev, struct device_node *no
 		clk_data->hws[gate->id] = ERR_PTR(-ENOENT);
 	}
 
-	return PTR_ERR(hw);
+	return ret;
 }
 
 int mtk_clk_register_gates(struct device *dev, struct device_node *node,
-- 
2.51.1


