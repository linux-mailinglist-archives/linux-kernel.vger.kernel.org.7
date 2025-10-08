Return-Path: <linux-kernel+bounces-845728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB840BC5F21
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 70E0D34ED06
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A4029E109;
	Wed,  8 Oct 2025 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="XOn37LMy"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EAE2BD5BC;
	Wed,  8 Oct 2025 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759939592; cv=pass; b=gk2LRgBYlWRL6oS9ZoCorCjFXzTxRNtwj6REKamxMA+nmtPQDx22tAy/saG3tiWzCdY2OIZPqftHksaWxY1dvV0pRtma2UuXpbWqCqmqkXSGrjqDHpOQxFPuhS3Pm6Qf+V4sd+Xw+08ORcI9JpQAKSImsxIp1pyPnha1McliOrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759939592; c=relaxed/simple;
	bh=1eWMasfW+YMGFyIu6a2zSKcJWEXKDJPclNaQ2b6AxAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t9uxQ8cNtDxbLBAzrWtrbX36CB82+Q6/06zIghuJaQLqq5R1BjwDqVf8DMNN6o3jZYRvuNnnTcFkS/Di1Lb59KlADGsHisLcaXLmGzxILz4eA+enVS+zH9XDlToHhyCZHb7dMWBPqJ0uYFUzGJ96Cvx7KcyjFi2lB2BLqg5s4WI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=XOn37LMy; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759939557; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NkSdHI8ANULyCBA4znvMfiLFKyiiN4bN1ATDgWcWjglxkZm1KMNCo6Bfs/lWPcgsCAvewHgJ0jmkLiccv4mZjSvfFruqlTzou6HdXeUP3xbr7f3ton5axk7pc0aWkQbpaudLVfOE+/FW5kabqgHYJKpZPglftskyZ1zVny/4OMA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759939557; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UjHQYkUSghO0qzYp6RVgVcWd0WgU6nq+wKvC+3iLfOA=; 
	b=k5KlLFEJjcPbPq+krlQm/IWzSNh1V60orw8Al11MBe24FLimI+aZSMxCtyjTQ758ZUNEqnu2YLOCryM2RHTSFnIc1kN2C9i2lRM/V+yfj9CcYZvV2mq5Iy5cbWJAKOzgLRnkxr7rTZUPrs7M2clgDms7CeNLIHjAvMLJebXBXfk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759939557;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=UjHQYkUSghO0qzYp6RVgVcWd0WgU6nq+wKvC+3iLfOA=;
	b=XOn37LMymSUh6RwNDDQ3fdXs+DLht8yRT2YprWCw6tBCPgl4NliZojUsZaLKz0dW
	SIcTwglXi/ciq+gFlQS7mvizppEEduAZjnRPOb5Mi6VivZcliiGpSQjfzdhpW4Wp1b4
	9SD4bYX+fcOcX9gly9NvteNAnk51xg2PeaBPCCFU=
Received: by mx.zohomail.com with SMTPS id 1759939556382226.16509659324583;
	Wed, 8 Oct 2025 09:05:56 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 08 Oct 2025 18:05:37 +0200
Subject: [PATCH v2 3/5] clk: mediatek: Pass device to clk_hw_register for
 PLLs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-mtk-pll-rpm-v2-3-170ed0698560@collabora.com>
References: <20251008-mtk-pll-rpm-v2-0-170ed0698560@collabora.com>
In-Reply-To: <20251008-mtk-pll-rpm-v2-0-170ed0698560@collabora.com>
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
 linux-mediatek@lists.infradead.org, Stephen Boyd <sboyd@codeaurora.org>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

Passing the struct device pointer to clk_hw_register allows for runtime
power management to work for the registered clock controllers. However,
the mediatek PLL clocks do not do this.

Change this by adding a struct device pointer argument to
mtk_clk_register_pll, and fix up the only other user of it. Also add a
new member to the struct mtk_clk_pll for the struct device pointer,
which is set by mtk_clk_register_pll and is used by
mtk_clk_register_pll_ops.

If mtk_clk_register_pll is called with a NULL struct device pointer,
then everything still works as expected; the clock core will simply
treat them as previously, i.e. without runtime power management.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/clk/mediatek/clk-pll.c   | 9 ++++++---
 drivers/clk/mediatek/clk-pll.h   | 4 +++-
 drivers/clk/mediatek/clk-pllfh.c | 2 +-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 5caf91ae9ddbe4f4d7052864adf0a5a70bda66bc..c4f9c06e5133dbc5902f261353c197fbde95e54d 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -366,7 +366,7 @@ struct clk_hw *mtk_clk_register_pll_ops(struct mtk_clk_pll *pll,
 		init.parent_names = &parent_name;
 	init.num_parents = 1;
 
-	ret = clk_hw_register(NULL, &pll->hw);
+	ret = clk_hw_register(pll->dev, &pll->hw);
 
 	if (ret)
 		return ERR_PTR(ret);
@@ -374,7 +374,8 @@ struct clk_hw *mtk_clk_register_pll_ops(struct mtk_clk_pll *pll,
 	return &pll->hw;
 }
 
-struct clk_hw *mtk_clk_register_pll(const struct mtk_pll_data *data,
+struct clk_hw *mtk_clk_register_pll(struct device *dev,
+				    const struct mtk_pll_data *data,
 				    void __iomem *base)
 {
 	struct mtk_clk_pll *pll;
@@ -385,6 +386,8 @@ struct clk_hw *mtk_clk_register_pll(const struct mtk_pll_data *data,
 	if (!pll)
 		return ERR_PTR(-ENOMEM);
 
+	pll->dev = dev;
+
 	hw = mtk_clk_register_pll_ops(pll, data, base, pll_ops);
 	if (IS_ERR(hw))
 		kfree(pll);
@@ -428,7 +431,7 @@ int mtk_clk_register_plls(struct device *dev,
 			continue;
 		}
 
-		hw = mtk_clk_register_pll(pll, base);
+		hw = mtk_clk_register_pll(dev, pll, base);
 
 		if (IS_ERR(hw)) {
 			pr_err("Failed to register clk %s: %pe\n", pll->name,
diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
index 0e2b94b9cd4b56adceee3b04e9ab24c2526471da..0f2a1d19eea78b7390b221af47016eb9897f3596 100644
--- a/drivers/clk/mediatek/clk-pll.h
+++ b/drivers/clk/mediatek/clk-pll.h
@@ -63,6 +63,7 @@ struct mtk_pll_data {
  */
 
 struct mtk_clk_pll {
+	struct device *dev;
 	struct clk_hw	hw;
 	void __iomem	*base_addr;
 	void __iomem	*pd_addr;
@@ -110,7 +111,8 @@ struct clk_hw *mtk_clk_register_pll_ops(struct mtk_clk_pll *pll,
 					const struct mtk_pll_data *data,
 					void __iomem *base,
 					const struct clk_ops *pll_ops);
-struct clk_hw *mtk_clk_register_pll(const struct mtk_pll_data *data,
+struct clk_hw *mtk_clk_register_pll(struct device *dev,
+				    const struct mtk_pll_data *data,
 				    void __iomem *base);
 void mtk_clk_unregister_pll(struct clk_hw *hw);
 
diff --git a/drivers/clk/mediatek/clk-pllfh.c b/drivers/clk/mediatek/clk-pllfh.c
index 83630ee07ee976bf980c8cf2dd35ea24c1b40821..62bfe4a480f14a0a742fb094aff0e6d1a79fe0c3 100644
--- a/drivers/clk/mediatek/clk-pllfh.c
+++ b/drivers/clk/mediatek/clk-pllfh.c
@@ -220,7 +220,7 @@ int mtk_clk_register_pllfhs(struct device_node *node,
 		if (use_fhctl)
 			hw = mtk_clk_register_pllfh(pll, pllfh, base);
 		else
-			hw = mtk_clk_register_pll(pll, base);
+			hw = mtk_clk_register_pll(NULL, pll, base);
 
 		if (IS_ERR(hw)) {
 			pr_err("Failed to register %s clk %s: %ld\n",

-- 
2.51.0


