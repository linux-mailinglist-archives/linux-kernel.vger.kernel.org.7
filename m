Return-Path: <linux-kernel+bounces-871388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B03C0D19D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92E954ED00F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E94D2FCBF0;
	Mon, 27 Oct 2025 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LB6x0IZH"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E712F9D86;
	Mon, 27 Oct 2025 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761563632; cv=none; b=L9t4JnZXbH6Kd0nHCKkdya65KiIGc02my8gykQ0r54roW1Y9KKyGPeET+7CJSu3tXriBzZYuCert663psPxghqUG+cb5rFmDh+A28l44h9j7E7SAfacFYw2bWH1Z0QDOP2FsLXPyORHKEMOv2U5diczsH6euR+PGk6JRiDNtASk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761563632; c=relaxed/simple;
	bh=lzGnPtkld4klxH26DmZNGJG2N0pnPsOl2zEvnIGz8vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jud3ZiZE/mjGj102gNATMQC+7hc4tTJhwUF1J0rDqTKXPz2+CsjaemHhf59WdDcqS7ks+hon+DJ6eh68XmCVT92HCG6H4+bH4gcL36JBHV+IxYR25cNhyLFTLlX464fN+8k/sU0pu/VYqs/DVXnixsN/VqHXT1OZ/zDHVEg8MqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LB6x0IZH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761563628;
	bh=lzGnPtkld4klxH26DmZNGJG2N0pnPsOl2zEvnIGz8vY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LB6x0IZH48gZVHfk8esGZZBVkuoMxtX2N3GZP9MJ8L+0Nt0JR1D2pJOBlE4gwILCd
	 ffJGmdpJ9mwOmIieoQIOcyvp8r0/gsGTy7yQ+y84UFaVw901uU9tJ9YSXcl2X7Dyqy
	 FgioIp4wjj0NqlNGs/Tng66PhUf6+BMN9R22+cO6HfwjEd5i8yMghBtpj9zXwQWqoZ
	 aegtmI0XEnGN7gkZ5jvt2fAPvYN/8ArCzF6lOLhbdUJ5m43qyVCpIrLeE1/KK9l6cK
	 r5XHKbewTrI6ZvhQ7cVEvWabVNvQmU+GlE9c6KHakcJuwR/doUVd/DnHh38npZDZ3K
	 q/8xRCIw1WoPQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DD01817E1401;
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
Subject: [PATCH v2 3/7] clk: mediatek: clk-mtk: Split and rename __mtk_clk_simple_probe()
Date: Mon, 27 Oct 2025 12:13:39 +0100
Message-ID: <20251027111343.21723-4-angelogioacchino.delregno@collabora.com>
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

In preparation for adding support to register clock controllers
that are not reachable over MMIO but rather over a different bus,
especially SPMI (for PMIC clocks!), split out the current private
__mtk_clk_simple_probe() function in two, make it accept a handle
to regmap in and call it mtk_clk_simple_probe_internal().

The new function is not static, but its symbol is *not* exported:
this is done on purpose, because this is supposed to be usable
only by clock registration helpers inside of clk/mediatek, and
only ones built inside of the same module as clk-mtk, as will be
done in a later change.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mtk.c | 58 ++++++++++++++++++++++++----------
 drivers/clk/mediatek/clk-mtk.h |  5 +++
 2 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 19cd27941747..bf57c65b01ff 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -2,6 +2,8 @@
 /*
  * Copyright (c) 2014 MediaTek Inc.
  * Author: James Liao <jamesjj.liao@mediatek.com>
+ * Copyright (c) 2025 Collabora Ltd
+ *		      AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
  */
 
 #include <linux/bitops.h>
@@ -14,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 
 #include "clk-mtk.h"
@@ -464,26 +467,15 @@ void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
 }
 EXPORT_SYMBOL_GPL(mtk_clk_unregister_dividers);
 
-static int __mtk_clk_simple_probe(struct platform_device *pdev,
-				  struct device_node *node)
+int mtk_clk_simple_probe_internal(struct platform_device *pdev,
+				  struct device_node *node,
+				  const struct mtk_clk_desc *mcd,
+				  struct regmap *regmap)
 {
-	const struct platform_device_id *id;
-	const struct mtk_clk_desc *mcd;
 	struct clk_hw_onecell_data *clk_data;
 	void __iomem *base = NULL;
 	int num_clks, r;
 
-	mcd = device_get_match_data(&pdev->dev);
-	if (!mcd) {
-		/* Clock driver wasn't registered from devicetree */
-		id = platform_get_device_id(pdev);
-		if (id)
-			mcd = (const struct mtk_clk_desc *)id->driver_data;
-
-		if (!mcd)
-			return -EINVAL;
-	}
-
 	/* Composite and divider clocks needs us to pass iomem pointer */
 	if (mcd->composite_clks || mcd->divider_clks) {
 		if (!mcd->shared_io)
@@ -653,20 +645,52 @@ static void __mtk_clk_simple_remove(struct platform_device *pdev,
 	mtk_free_clk_data(clk_data);
 }
 
+static int mtk_clk_get_desc(struct platform_device *pdev, const struct mtk_clk_desc **d)
+{
+	const struct platform_device_id *id;
+	const struct mtk_clk_desc *mcd;
+
+	mcd = device_get_match_data(&pdev->dev);
+	if (!mcd) {
+		/* Clock driver wasn't registered from devicetree */
+		id = platform_get_device_id(pdev);
+		if (id)
+			mcd = (const struct mtk_clk_desc *)id->driver_data;
+
+		if (!mcd)
+			return -EINVAL;
+	}
+	*d = mcd;
+
+	return 0;
+}
+
 int mtk_clk_pdev_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
+	const struct mtk_clk_desc *mcd;
+	int ret;
 
-	return __mtk_clk_simple_probe(pdev, node);
+	ret = mtk_clk_get_desc(pdev, &mcd);
+	if (ret)
+		return ret;
+
+	return mtk_clk_simple_probe_internal(pdev, node, mcd, NULL);
 }
 EXPORT_SYMBOL_GPL(mtk_clk_pdev_probe);
 
 int mtk_clk_simple_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
+	const struct mtk_clk_desc *mcd;
+	int ret;
+
+	ret = mtk_clk_get_desc(pdev, &mcd);
+	if (ret)
+		return ret;
 
-	return __mtk_clk_simple_probe(pdev, node);
+	return mtk_clk_simple_probe_internal(pdev, node, mcd, NULL);
 }
 EXPORT_SYMBOL_GPL(mtk_clk_simple_probe);
 
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 5417b9264e6d..945fd3ee79ca 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -262,6 +262,11 @@ struct mtk_clk_desc {
 	bool need_runtime_pm;
 };
 
+int mtk_clk_simple_probe_internal(struct platform_device *pdev,
+				  struct device_node *node,
+				  const struct mtk_clk_desc *mcd,
+				  struct regmap *regmap);
+
 int mtk_clk_pdev_probe(struct platform_device *pdev);
 void mtk_clk_pdev_remove(struct platform_device *pdev);
 int mtk_clk_simple_probe(struct platform_device *pdev);
-- 
2.51.1


