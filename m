Return-Path: <linux-kernel+bounces-830349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF200B99730
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8906E1B21A50
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6ECE2E0922;
	Wed, 24 Sep 2025 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DjpjYwUb"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590D02DF6FF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758710246; cv=none; b=efvgPW3u7rAV32b+rZtAGsUe+Kir0sBlSKXVmdL0hp3bfhLzpw+5Q2A+FxcFuODOPCVlwBfEiAS6Fp2t7QhHZtEqgpzb55g9s6SN04Pv3l7fpX3RhVHECrAI5ykqHF9fwJCEpHlshiVa6MSy4rnCQcqiGE5jeAUstoQD7AR7KOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758710246; c=relaxed/simple;
	bh=zBsUv12CnB+eYEv/phnc2P7PAeGpmJaBNqHcFB5Huqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=htAvueEQoMQOi1tNbHu/rn4zEimndXgfvvY/UvNPkC5UmdLDp6EhE/5HGT4cHaNmg0wbbfIzD4s+Xbx34eX1HVT7rLRjqzhZRdazMXuKrwskoz8pLeSxELM3EwLu8dqUA+GlTLL4LZiMmbJRH7J/57pFQlHYIxJSxY1PymgQ3ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DjpjYwUb; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758710239;
	bh=zBsUv12CnB+eYEv/phnc2P7PAeGpmJaBNqHcFB5Huqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DjpjYwUb5pOMFOpgc5Ffg1V9RI+Q2NHA9uv7N9HEy4JDU+sGEWERm9NJNmIYxIK0Y
	 bWSN2BXojWpqoxWqNoxaCWPULPMLnCLHBfjs9VsUWYkgN++pNztlxZYlZ/1u69egO/
	 E/MMa6w3OocHpTGsi/oIDnSRAWnonwOCaylCjeIWYIOBC4mjbWMKZnQr0IG458Zc07
	 2CMrHMLC/GvQ/qITeGf8b+ezFJSzcyAp/JGe6ZLcQKLMahG00tTjmYQMmYk55NzA3P
	 4YxVxtyjlqjYPussaH4fm/qKnM2UMLi/IwR9TJ8I4lg8hPxfzyeOevyW2n9UtTKlQS
	 CqjUbPidS6+oQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DC33017E1389;
	Wed, 24 Sep 2025 12:37:18 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	dmitry.osipenko@collabora.com,
	granquet@baylibre.com,
	rex-bc.chen@mediatek.com,
	ck.hu@mediatek.com,
	amergnat@baylibre.com,
	djkurtz@chromium.org,
	littlecvr@chromium.org,
	bibby.hsieh@mediatek.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 3/3] drm/mediatek: mtk_disp_rdma: Enable/disable interrupt on bind/unbind
Date: Wed, 24 Sep 2025 12:37:08 +0200
Message-ID: <20250924103708.19071-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924103708.19071-1-angelogioacchino.delregno@collabora.com>
References: <20250924103708.19071-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RDMA driver is installing an ISR in the probe function but, if
the component is not bound yet, the interrupt handler may call the
vblank_cb ahead of time (while probing other drivers) or too late
(while removing other drivers), possibly accessing memory that it
should not try to access by reusing stale pointers.

In order to fix this, like done in the OVL driver, add a new `irq`
member to struct mtk_disp_ovl and then set the NOAUTOEN flag to
the irq before installing the ISR to manually disable and clear
the hwirqs with register writes, and enable_irq() and disable_irq()
in the bind and unbind callbacks respectively.

Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
Link: https://lore.kernel.org/r/20250402083628.20111-6-angelogioacchino.delregno@collabora.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 34 ++++++++++++++----------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index c9d41d75e7f2..9fd9bb1ee544 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -81,6 +81,7 @@ struct mtk_disp_rdma_data {
 struct mtk_disp_rdma {
 	struct clk			*clk;
 	void __iomem			*regs;
+	int				irq;
 	struct cmdq_client_reg		cmdq_reg;
 	const struct mtk_disp_rdma_data	*data;
 	void				(*vblank_cb)(void *data);
@@ -295,13 +296,23 @@ void mtk_rdma_layer_config(struct device *dev, unsigned int idx,
 static int mtk_disp_rdma_bind(struct device *dev, struct device *master,
 			      void *data)
 {
-	return 0;
+	struct mtk_disp_rdma *priv = dev_get_drvdata(dev);
+
+	/* Disable and clear pending interrupts */
+	writel(0x0, priv->regs + DISP_REG_RDMA_INT_ENABLE);
+	writel(0x0, priv->regs + DISP_REG_RDMA_INT_STATUS);
+
+	enable_irq(priv->irq);
 
+	return 0;
 }
 
 static void mtk_disp_rdma_unbind(struct device *dev, struct device *master,
 				 void *data)
 {
+	struct mtk_disp_rdma *priv = dev_get_drvdata(dev);
+
+	disable_irq(priv->irq);
 }
 
 static const struct component_ops mtk_disp_rdma_component_ops = {
@@ -313,16 +324,15 @@ static int mtk_disp_rdma_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mtk_disp_rdma *priv;
-	int irq;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	priv->irq = platform_get_irq(pdev, 0);
+	if (priv->irq < 0)
+		return priv->irq;
 
 	priv->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(priv->clk))
@@ -345,21 +355,17 @@ static int mtk_disp_rdma_probe(struct platform_device *pdev)
 	if (ret && (ret != -EINVAL))
 		return dev_err_probe(dev, ret, "Failed to get rdma fifo size\n");
 
-	/* Disable and clear pending interrupts */
-	writel(0x0, priv->regs + DISP_REG_RDMA_INT_ENABLE);
-	writel(0x0, priv->regs + DISP_REG_RDMA_INT_STATUS);
-
-	ret = devm_request_irq(dev, irq, mtk_disp_rdma_irq_handler,
-			       IRQF_TRIGGER_NONE, dev_name(dev), priv);
-	if (ret < 0)
-		return dev_err_probe(dev, ret, "Failed to request irq %d\n", irq);
-
 	priv->data = of_device_get_match_data(dev);
 
 	platform_set_drvdata(pdev, priv);
 
 	pm_runtime_enable(dev);
 
+	ret = devm_request_irq(dev, priv->irq, mtk_disp_rdma_irq_handler,
+			       IRQF_NO_AUTOEN, dev_name(dev), priv);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to request irq %d\n", priv->irq);
+
 	ret = component_add(dev, &mtk_disp_rdma_component_ops);
 	if (ret) {
 		pm_runtime_disable(dev);
-- 
2.51.0


