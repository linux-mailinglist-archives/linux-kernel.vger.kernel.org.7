Return-Path: <linux-kernel+bounces-848782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C295BCE8EF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B33F19E1D1D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6A2303C8A;
	Fri, 10 Oct 2025 20:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="KQbO5wPZ"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573B0303A26;
	Fri, 10 Oct 2025 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129297; cv=pass; b=cNuYF9WoYE6Mc0bTKZNP7kd+Ozg6UhAS/+8RgieRj8v6mvscUAAfACckVVblSd15FhKuNSzySDtHCZTVJUKAbtVqUn0W2A5h1yqmgt5YdewcWqW7NHII74VyhtUnAOvPtZlgr8OpOx1YXtnGWXeoP0qaWaFI18+RdMe5eZETXc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129297; c=relaxed/simple;
	bh=92D6FZZC301x+KfnnCs1GRBKU+67f3TXVmiREp0Oet8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dr3eCBGVxf26bvzbh5D0RlRtkdDWAxs4F3JTjDhHPwfULEHcFk6+DKjYMab/E0WQb5e0x56cgB+IwC+hTwJWuFYpabR91zG2i1IjzXBDZN7An3LwLmJdZ1xM8zksQMRoPeIS7RqVjE/fhkDBEvLAl5DMqBKlHG5wBPWGr63X6LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=KQbO5wPZ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760129273; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=brEp0Mv54PwELGVXmK3qAZdMbKPPmHXS0F6u3wRbU/IUv78MHDySmS0RzLQGDPruByi/B42EzpIYrpy5J5sCuaCdheznGIiq3AIPPos0dnIKWjzEjoXyOGiSmJzrkz245UIDDEOaEQvNrQ7PEr5CmdlPnkfg0sDzPtnlQS6Df/M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760129273; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dvR0nVJz3qP3rSUx5baNKuQSFe2J2wvzDrszjuc2XJQ=; 
	b=GijkgAeINz41ZvWtLhmS1qt7xKiwxJdd8wfmknHN7Pwdn6mYfLwVXrgCb3A5CmKCQllVvUR+e8mtVEataeYSvA368usheonDgavRxUX4bFNUTw2pbMBksorUhFEjNK/7+RessGic+cUpjI8Lo2RcsnGXHUThJfHtbgTGg3RUrYA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760129273;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=dvR0nVJz3qP3rSUx5baNKuQSFe2J2wvzDrszjuc2XJQ=;
	b=KQbO5wPZoZQjCai/RUmLCV3w9+rIfIRunMdCm+2MGYj88qKuKuQArk+WkfM3Wt87
	Dp+XCQapXuIMvNIBEPk7lM2EsdhT7y62ZQneZMT52D1QYmdbyRfclfCl0am8sQ2KzhM
	PJ1lKakhLKLB+ganhXtKXwuhl4vgQaPSSmQnlcWU=
Received: by mx.zohomail.com with SMTPS id 1760129271811594.0370826679009;
	Fri, 10 Oct 2025 13:47:51 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 10 Oct 2025 22:47:12 +0200
Subject: [PATCH v3 4/5] clk: mediatek: Refactor pllfh registration to pass
 device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-mtk-pll-rpm-v3-4-fb1bd15d734a@collabora.com>
References: <20251010-mtk-pll-rpm-v3-0-fb1bd15d734a@collabora.com>
In-Reply-To: <20251010-mtk-pll-rpm-v3-0-fb1bd15d734a@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Yassine Oudjana <y.oudjana@protonmail.com>, 
 Laura Nao <laura.nao@collabora.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

After refactoring all of PLL to pass the device, it's now fairly easy to
refactor pllfh and its users, as pllfh registration wraps PLL
registration.

Do this refactor and move all of the pllfh users to pass the device as
well.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/clk/mediatek/clk-mt6795-apmixedsys.c |  2 +-
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c | 14 +++++++-------
 drivers/clk/mediatek/clk-mt8186-apmixedsys.c |  2 +-
 drivers/clk/mediatek/clk-mt8192-apmixedsys.c |  2 +-
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c |  2 +-
 drivers/clk/mediatek/clk-pllfh.c             | 13 ++++++++-----
 drivers/clk/mediatek/clk-pllfh.h             |  2 +-
 7 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt6795-apmixedsys.c b/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
index 91665d7f125efde4941cc4de881c5b503a935529..123d5d7fea8554676364dc56f5c023e43325d516 100644
--- a/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
@@ -152,7 +152,7 @@ static int clk_mt6795_apmixed_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
-	ret = mtk_clk_register_pllfhs(node, plls, ARRAY_SIZE(plls),
+	ret = mtk_clk_register_pllfhs(dev, plls, ARRAY_SIZE(plls),
 				      pllfhs, ARRAY_SIZE(pllfhs), clk_data);
 	if (ret)
 		goto free_clk_data;
diff --git a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
index 95385bb67d5511eda3a851f81986e67eaf81e5fb..d7d416172ab35bc027ae67c163c1dc20dee857b6 100644
--- a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
@@ -140,13 +140,13 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8173_apmixed);
 static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
 {
 	const u8 *fhctl_node = "mediatek,mt8173-fhctl";
-	struct device_node *node = pdev->dev.of_node;
 	struct clk_hw_onecell_data *clk_data;
+	struct device *dev = &pdev->dev;
 	void __iomem *base;
 	struct clk_hw *hw;
 	int r;
 
-	base = of_iomap(node, 0);
+	base = of_iomap(dev->of_node, 0);
 	if (!base)
 		return -ENOMEM;
 
@@ -157,25 +157,25 @@ static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
 	}
 
 	fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
-	r = mtk_clk_register_pllfhs(node, plls, ARRAY_SIZE(plls),
-				    pllfhs, ARRAY_SIZE(pllfhs), clk_data);
+	r = mtk_clk_register_pllfhs(dev, plls, ARRAY_SIZE(plls), pllfhs,
+				    ARRAY_SIZE(pllfhs), clk_data);
 	if (r)
 		goto free_clk_data;
 
 	hw = mtk_clk_register_ref2usb_tx("ref2usb_tx", "clk26m", base + REGOFF_REF2USB);
 	if (IS_ERR(hw)) {
 		r = PTR_ERR(hw);
-		dev_err(&pdev->dev, "Failed to register ref2usb_tx: %d\n", r);
+		dev_err(dev, "Failed to register ref2usb_tx: %d\n", r);
 		goto unregister_plls;
 	}
 	clk_data->hws[CLK_APMIXED_REF2USB_TX] = hw;
 
-	hw = devm_clk_hw_register_divider(&pdev->dev, "hdmi_ref", "tvdpll_594m", 0,
+	hw = devm_clk_hw_register_divider(dev, "hdmi_ref", "tvdpll_594m", 0,
 					  base + REGOFF_HDMI_REF, 16, 3,
 					  CLK_DIVIDER_POWER_OF_TWO, NULL);
 	clk_data->hws[CLK_APMIXED_HDMI_REF] = hw;
 
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		goto unregister_ref2usb;
 
diff --git a/drivers/clk/mediatek/clk-mt8186-apmixedsys.c b/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
index 4b2b16578232d986f78deed4778c5fab7f460184..d35dd2632e43ab535b32b8b99f8d75de02d56fe2 100644
--- a/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
@@ -151,7 +151,7 @@ static int clk_mt8186_apmixed_probe(struct platform_device *pdev)
 
 	fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
 
-	r = mtk_clk_register_pllfhs(node, plls, ARRAY_SIZE(plls),
+	r = mtk_clk_register_pllfhs(&pdev->dev, plls, ARRAY_SIZE(plls),
 				    pllfhs, ARRAY_SIZE(pllfhs), clk_data);
 	if (r)
 		goto free_apmixed_data;
diff --git a/drivers/clk/mediatek/clk-mt8192-apmixedsys.c b/drivers/clk/mediatek/clk-mt8192-apmixedsys.c
index 0b66a27e4d5ac68f09dc6a4197fd84ef82342df9..b0563a285bd666d492a7fa940733aad1ab1a0bae 100644
--- a/drivers/clk/mediatek/clk-mt8192-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8192-apmixedsys.c
@@ -162,7 +162,7 @@ static int clk_mt8192_apmixed_probe(struct platform_device *pdev)
 
 	fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
 
-	r = mtk_clk_register_pllfhs(node, plls, ARRAY_SIZE(plls),
+	r = mtk_clk_register_pllfhs(&pdev->dev, plls, ARRAY_SIZE(plls),
 				    pllfhs, ARRAY_SIZE(pllfhs), clk_data);
 	if (r)
 		goto free_clk_data;
diff --git a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
index 282a3137dc89419a6d0b574fd549cee941687900..44917ab034c56f01ef02d1957f17eb0655438d75 100644
--- a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
@@ -181,7 +181,7 @@ static int clk_mt8195_apmixed_probe(struct platform_device *pdev)
 
 	fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
 
-	r = mtk_clk_register_pllfhs(node, plls, ARRAY_SIZE(plls),
+	r = mtk_clk_register_pllfhs(&pdev->dev, plls, ARRAY_SIZE(plls),
 				    pllfhs, ARRAY_SIZE(pllfhs), clk_data);
 	if (r)
 		goto free_apmixed_data;
diff --git a/drivers/clk/mediatek/clk-pllfh.c b/drivers/clk/mediatek/clk-pllfh.c
index 62bfe4a480f14a0a742fb094aff0e6d1a79fe0c3..8ad11023d91127e88900bc6bcabbaeafb1e00664 100644
--- a/drivers/clk/mediatek/clk-pllfh.c
+++ b/drivers/clk/mediatek/clk-pllfh.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/clkdev.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 
 #include "clk-mtk.h"
 #include "clk-pllfh.h"
@@ -149,7 +150,7 @@ static bool fhctl_is_supported_and_enabled(const struct mtk_pllfh_data *pllfh)
 }
 
 static struct clk_hw *
-mtk_clk_register_pllfh(const struct mtk_pll_data *pll_data,
+mtk_clk_register_pllfh(struct device *dev, const struct mtk_pll_data *pll_data,
 		       struct mtk_pllfh_data *pllfh_data, void __iomem *base)
 {
 	struct clk_hw *hw;
@@ -166,6 +167,8 @@ mtk_clk_register_pllfh(const struct mtk_pll_data *pll_data,
 		goto out;
 	}
 
+	fh->clk_pll.dev = dev;
+
 	hw = mtk_clk_register_pll_ops(&fh->clk_pll, pll_data, base,
 				      &mtk_pllfh_ops);
 
@@ -194,7 +197,7 @@ static void mtk_clk_unregister_pllfh(struct clk_hw *hw)
 	kfree(fh);
 }
 
-int mtk_clk_register_pllfhs(struct device_node *node,
+int mtk_clk_register_pllfhs(struct device *dev,
 			    const struct mtk_pll_data *plls, int num_plls,
 			    struct mtk_pllfh_data *pllfhs, int num_fhs,
 			    struct clk_hw_onecell_data *clk_data)
@@ -203,7 +206,7 @@ int mtk_clk_register_pllfhs(struct device_node *node,
 	int i;
 	struct clk_hw *hw;
 
-	base = of_iomap(node, 0);
+	base = of_iomap(dev->of_node, 0);
 	if (!base) {
 		pr_err("%s(): ioremap failed\n", __func__);
 		return -EINVAL;
@@ -218,9 +221,9 @@ int mtk_clk_register_pllfhs(struct device_node *node,
 		use_fhctl = fhctl_is_supported_and_enabled(pllfh);
 
 		if (use_fhctl)
-			hw = mtk_clk_register_pllfh(pll, pllfh, base);
+			hw = mtk_clk_register_pllfh(dev, pll, pllfh, base);
 		else
-			hw = mtk_clk_register_pll(NULL, pll, base);
+			hw = mtk_clk_register_pll(dev, pll, base);
 
 		if (IS_ERR(hw)) {
 			pr_err("Failed to register %s clk %s: %ld\n",
diff --git a/drivers/clk/mediatek/clk-pllfh.h b/drivers/clk/mediatek/clk-pllfh.h
index 5f419c2ec01f988ede4e40289c6e5d5f8070ad14..a4f337acad71389f771187908882b09d0f801868 100644
--- a/drivers/clk/mediatek/clk-pllfh.h
+++ b/drivers/clk/mediatek/clk-pllfh.h
@@ -68,7 +68,7 @@ struct fh_operation {
 	int (*ssc_enable)(struct mtk_fh *fh, u32 rate);
 };
 
-int mtk_clk_register_pllfhs(struct device_node *node,
+int mtk_clk_register_pllfhs(struct device *dev,
 			    const struct mtk_pll_data *plls, int num_plls,
 			    struct mtk_pllfh_data *pllfhs, int num_pllfhs,
 			    struct clk_hw_onecell_data *clk_data);

-- 
2.51.0


