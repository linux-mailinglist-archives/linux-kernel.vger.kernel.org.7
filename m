Return-Path: <linux-kernel+bounces-836277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657AEBA92D6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74FB816484C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58068305964;
	Mon, 29 Sep 2025 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="WQImkyqN"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BB81AAE13;
	Mon, 29 Sep 2025 12:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759148064; cv=pass; b=sjcLeI/zY6BuGJB2FwMFBLPAMUdh1E2Fv2FChL86HfmVO2oPwOVctkNu5gpFvBm2As6pu8uJ2cvnAK6EGN/p3+bW9HsnpZAYUpEr96J346t5X8faeqyEOEfOpdnOVeHSfPQ4o+n7dtZe6RtXdv5Vdsq2HhyZPSGme0r6KGbn+Wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759148064; c=relaxed/simple;
	bh=8HFBQHEo5arJpQOAJwKIM2MvQvjbRMkvOJXoJQQ/QWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ntb3wFKRetyEMjP2Dwx+qfiElpVMVhSwU2VqRqlJBVAb7jDFneaNmlMixalb+E5j5nsvWo6u5LnlRbHngztGXVxzTC/bf3G8Wb4BtNoc0WjNyJdVUt23K+9dGXBoh/YaCRCUxlZJS81+o7QNS1ScjhBX+dI8EvLixmXcbfq9lZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=WQImkyqN; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759148037; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BwzAzwN22EUGxhmqj3i1ZgC5Hr1/JPnmFfY3mwxeW7MVh1mui6K9xu6nVfRvbSklvba+n0qisg7bbEZHYCHD1cVvmqYTQJp+xOf9dhtDu2NQHlKgQqEg2ULxM3ofOPsFkFhPn2b7xpjHqBLe/rr4tpZSqSvCEzlg/f+t4LcWjcA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759148037; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QxCZTFF4iG3STPzoFw46Bohn0VkTc+z5x9foKK+SKnc=; 
	b=chWjxtVClcCKhjU5Ir20yaVdE1kZPyyLUqCYmLFCIBfDYq2m7pAt/rRdHMXHZP0Zkl1VJmlEgYz1Vaw7taHF2+aAcZqZTU8sAWTesPMXOyODt/aAnuUNXLtkEkKfkdpJwHHn0RPAsAmdtfhn+Ea4uczvy+O7YJW/HYguOmFjbFk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759148036;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=QxCZTFF4iG3STPzoFw46Bohn0VkTc+z5x9foKK+SKnc=;
	b=WQImkyqN0ts2FbkiuraOV8Q94f0LGL7NrIOMl3763L9oTAMp9z589bIxQ6vKTKhD
	6C1BcSiyVxQlgw1kuU8jntB3wMprV2wmdwbPvvRXLA4M95f4YjfUJXZWHohXmPXFdX5
	uJLBIS2geKleoqKyIJCfzOVfW2KPbCIDt2/t4T4A=
Received: by mx.zohomail.com with SMTPS id 1759148035478164.29442178412774;
	Mon, 29 Sep 2025 05:13:55 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 29 Sep 2025 14:13:22 +0200
Subject: [PATCH 3/4] clk: mediatek: Pass device to clk_hw_register for PLLs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-mtk-pll-rpm-v1-3-49541777878d@collabora.com>
References: <20250929-mtk-pll-rpm-v1-0-49541777878d@collabora.com>
In-Reply-To: <20250929-mtk-pll-rpm-v1-0-49541777878d@collabora.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Guangjie Song <guangjie.song@mediatek.com>, 
 Laura Nao <laura.nao@collabora.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Yassine Oudjana <y.oudjana@protonmail.com>
Cc: kernel@collabora.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

Passing the struct device pointer to clk_hw_register allows for runtime
power management to work for the registered clocks. However, the
mediatek PLL clocks do not do this.

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


