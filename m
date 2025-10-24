Return-Path: <linux-kernel+bounces-868389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4A8C0516A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25E7A541A65
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9643630BBAB;
	Fri, 24 Oct 2025 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="o17l6bt8"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282753064AE;
	Fri, 24 Oct 2025 08:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761294795; cv=none; b=OlsftVe+Q60QnJQruSGPKN9RKe5n30wHxRVH+tS1YdV26/sh7zbmSBFG4FLImA1uFyYXuSkSh+xD81teX833pxhwQF0fEfkhuQ2h4MagSoEAdSOLChiaMIKYWZBdQ3y1C49wAGInGlK8j0oVpopNpCtWU3zP285CpwybLXXvtpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761294795; c=relaxed/simple;
	bh=uMNDlVMiY8eMGT5nLR/6G4iE8k9njF/IX52KNy0kIlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDhrZaicItmevKWKN14ndKcwgn8qtniO3kZbFDDd2zyj0Ij8lctCadAOE50CBO+ezKATkEL7bqTxqAPqwQI4TX2iKEMTXpA8ARxn3ISqMEBbBaiGkXjShw6WcxLuNxasu6Et17GPCbxCcnX5abbM5fywkUqKtNfy4PSKWaBFLDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=o17l6bt8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761294791;
	bh=uMNDlVMiY8eMGT5nLR/6G4iE8k9njF/IX52KNy0kIlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o17l6bt8HzrdePhSth7Sivre7iSSR6dEnqk/IVSTX6qcmrK+V8eeEsXwu6WZLndh6
	 4eytEGp4w8rAPWAbAoOdo4OLX3D5MEBULH6mPNB/f2WC2wh2dBSWXdFVs7fKthl3es
	 EMdDqus1x4FGNim6W39Iy9uyRzHn5HGAcxxKCIApOWt1GNwgNZg+0qTANOjPR/+Fvb
	 WsqCgnpX8vkkHaOU70yV7cNj0aVXnkqCM+Ucwj1IY8xvpRDtrKQgfoctVpMfWNfu9/
	 QJOkUO+Xhu8Fteuq/OC7OFrkLt6uN7WOLVe/BXt+QiEbtvKpNtMWftp09Q5uVVD16w
	 KJC65X8m3k6mw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0E4AC17E0CA1;
	Fri, 24 Oct 2025 10:33:11 +0200 (CEST)
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
Subject: [PATCH v1 2/7] clk: mediatek: clk-gate: Simplify and optimize registration iter
Date: Fri, 24 Oct 2025 10:32:56 +0200
Message-ID: <20251024083301.25845-3-angelogioacchino.delregno@collabora.com>
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


