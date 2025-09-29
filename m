Return-Path: <linux-kernel+bounces-836276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFF4BA92C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7AD189EAC6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0CA305943;
	Mon, 29 Sep 2025 12:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="RCE5iGfB"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D60B30596F;
	Mon, 29 Sep 2025 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759148056; cv=pass; b=k+/XsbMHuw61l1VUc089OxKWwWSQCras1kdtq/+pwgMqLuqEWGtfkEwJYEC6SasZY4QoDUI3WZuZrsA5P2Bt5X3ZnzL0W9nrY5PgbqILSj0ajpwigZjUa7YCcZ/JrsqLL0PU6oZtmQWkrzq3Fw1sTILf077cs61oOxZHklXumXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759148056; c=relaxed/simple;
	bh=pr3/606nX9pqimy/+CjvDhplfefWml6gZiLFcWqsvr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ohx5lbvOatB5QD+ZwgjM7J15Pmc7Z7aIHoSXXVW4teEtLz4KxWk11KYViqwo0WNgSgPm8/XQpq+YoDrOBkilA4vTTBBRl0pF/l7fb4QOja+l/BeHsjtqCqun63n2WY/HIHV6SxY987BAkG2E5gZm9xzkDsUZ19ihsYJsTaU6wHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=RCE5iGfB; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759148032; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=g3nvdVXyQ6FQBn9uEd7zCk5KeMvJ9M6NV2ZrdCK5hDfJNsD7PmOj58E4aONBQkBRiV0x2JKrG/qU5Z2VMv8ILZJxhSi8N2HFpHV903k1tg8JcGXzd8h/zJnjaEJ53ZPpqtMBBldgedh60sXU9Iky+wIE7Av3RTrGFTrV5AXSnyE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759148032; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nj+maPM7kXas+OqM/T0w/dYAI+0ixkQ2MCVze+Y7ZzA=; 
	b=AoTAUVpOVs7syDgcyXa7obyzLHMAx/DKm8S0dalCFn6A8cbE0NuV4TNgiAnlk3TgFEKEUAOl06hKITKCmqj+lSGoBnkwGT6hvIYEHNXaaY7SKhtOINh5REtvZiIjL6dNOWfmH11v2+xxe+GzQcUjFmxxV+ijmor0FHs2koDt+Gc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759148032;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=nj+maPM7kXas+OqM/T0w/dYAI+0ixkQ2MCVze+Y7ZzA=;
	b=RCE5iGfBR82yrvR5TUn3Wqel6QJxsHUZ17XRU4CGBM7liyHiDlAFeiKOaqTRzkVC
	vlSuJfIPnDUXwAY4h1wjSp964L7b3PwL/0ONvp1vh72dA15zL1ZEI86a/HH4nwNjYrL
	UxVn/giYSGlxWE23kbtZa1SRHgOe6hDnsPmrAJrc=
Received: by mx.zohomail.com with SMTPS id 1759148031644827.9697327445571;
	Mon, 29 Sep 2025 05:13:51 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 29 Sep 2025 14:13:21 +0200
Subject: [PATCH 2/4] clk: mediatek: Refactor pll registration to pass
 device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-mtk-pll-rpm-v1-2-49541777878d@collabora.com>
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

As it stands, mtk_clk_register_plls takes a struct device_node pointer
as its first argument. This is a tragic happenstance, as it's trivial to
get the device_node from a struct device, but the opposite not so much.
The struct device is a much more useful thing to have passed down.

Refactor mtk_clk_register_plls to take a struct device pointer instead
of a struct device_node pointer, and fix up all users of this function.
This will allow us to extend clk-pll with runtime PM things later.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/clk/mediatek/clk-mt2701.c            | 2 +-
 drivers/clk/mediatek/clk-mt2712-apmixedsys.c | 2 +-
 drivers/clk/mediatek/clk-mt6735-apmixedsys.c | 4 ++--
 drivers/clk/mediatek/clk-mt6765.c            | 2 +-
 drivers/clk/mediatek/clk-mt6779.c            | 2 +-
 drivers/clk/mediatek/clk-mt6797.c            | 2 +-
 drivers/clk/mediatek/clk-mt7622-apmixedsys.c | 2 +-
 drivers/clk/mediatek/clk-mt7629.c            | 2 +-
 drivers/clk/mediatek/clk-mt7981-apmixed.c    | 2 +-
 drivers/clk/mediatek/clk-mt7986-apmixed.c    | 2 +-
 drivers/clk/mediatek/clk-mt7988-apmixed.c    | 2 +-
 drivers/clk/mediatek/clk-mt8135-apmixedsys.c | 3 ++-
 drivers/clk/mediatek/clk-mt8167-apmixedsys.c | 2 +-
 drivers/clk/mediatek/clk-mt8183-apmixedsys.c | 2 +-
 drivers/clk/mediatek/clk-mt8188-apmixedsys.c | 2 +-
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c | 3 ++-
 drivers/clk/mediatek/clk-mt8196-apmixedsys.c | 3 ++-
 drivers/clk/mediatek/clk-mt8196-mcu.c        | 2 +-
 drivers/clk/mediatek/clk-mt8196-mfg.c        | 2 +-
 drivers/clk/mediatek/clk-mt8196-vlpckgen.c   | 2 +-
 drivers/clk/mediatek/clk-mt8365-apmixedsys.c | 2 +-
 drivers/clk/mediatek/clk-mt8516-apmixedsys.c | 2 +-
 drivers/clk/mediatek/clk-pll.c               | 7 ++++---
 drivers/clk/mediatek/clk-pll.h               | 6 +++---
 24 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 1e88ad8b93f4485ad40f842e19c68117e00a2fbe..d9f40fda73d1abc56ebc97ab755bb48bd5f0991f 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -978,7 +978,7 @@ static int mtk_apmixedsys_init(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	mtk_clk_register_plls(node, apmixed_plls, ARRAY_SIZE(apmixed_plls),
+	mtk_clk_register_plls(&pdev->dev, apmixed_plls, ARRAY_SIZE(apmixed_plls),
 								clk_data);
 	mtk_clk_register_factors(apmixed_fixed_divs, ARRAY_SIZE(apmixed_fixed_divs),
 								clk_data);
diff --git a/drivers/clk/mediatek/clk-mt2712-apmixedsys.c b/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
index a60622d251ff30fe8db2e596d87986a88f854e61..54b18e9f83f8f403460c77d8f5d4ea0737316774 100644
--- a/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
@@ -119,7 +119,7 @@ static int clk_mt2712_apmixed_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	r = mtk_clk_register_plls(&pdev->dev, plls, ARRAY_SIZE(plls), clk_data);
 	if (r)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt6735-apmixedsys.c b/drivers/clk/mediatek/clk-mt6735-apmixedsys.c
index e0949911e8f7da7894b204012caefd0404cf8308..9e30c089a2092472bab889ede419c41890c307a0 100644
--- a/drivers/clk/mediatek/clk-mt6735-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt6735-apmixedsys.c
@@ -93,8 +93,8 @@ static int clk_mt6735_apmixed_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, clk_data);
 
-	ret = mtk_clk_register_plls(pdev->dev.of_node, apmixedsys_plls,
-				   ARRAY_SIZE(apmixedsys_plls), clk_data);
+	ret = mtk_clk_register_plls(&pdev->dev, apmixedsys_plls,
+				    ARRAY_SIZE(apmixedsys_plls), clk_data);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register PLLs: %d\n", ret);
 		return ret;
diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
index d53731e7933f46d88ff180e43eb7163e52fb5b1c..60f6f9fa7dcf279631d0fa2eb30a3bcbadef3225 100644
--- a/drivers/clk/mediatek/clk-mt6765.c
+++ b/drivers/clk/mediatek/clk-mt6765.c
@@ -740,7 +740,7 @@ static int clk_mt6765_apmixed_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	mtk_clk_register_plls(&pdev->dev, plls, ARRAY_SIZE(plls), clk_data);
 
 	mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
 			       ARRAY_SIZE(apmixed_clks), clk_data);
diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
index 86732f5acf93407a5aa99bc2f386f0728a06bb9b..4b9dcb910b03f1078212dc7089d7171d05de7e7f 100644
--- a/drivers/clk/mediatek/clk-mt6779.c
+++ b/drivers/clk/mediatek/clk-mt6779.c
@@ -1220,7 +1220,7 @@ static int clk_mt6779_apmixed_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	mtk_clk_register_plls(&pdev->dev, plls, ARRAY_SIZE(plls), clk_data);
 
 	mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
 			       ARRAY_SIZE(apmixed_clks), clk_data);
diff --git a/drivers/clk/mediatek/clk-mt6797.c b/drivers/clk/mediatek/clk-mt6797.c
index fb59e71af58e32d9419e036e3dbd28cdaa61cac3..ebf850ac57f540f2317e63dfabe94a953db3ae29 100644
--- a/drivers/clk/mediatek/clk-mt6797.c
+++ b/drivers/clk/mediatek/clk-mt6797.c
@@ -655,7 +655,7 @@ static int mtk_apmixedsys_init(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	mtk_clk_register_plls(&pdev->dev, plls, ARRAY_SIZE(plls), clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
diff --git a/drivers/clk/mediatek/clk-mt7622-apmixedsys.c b/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
index 2350592d9a934f3ec8efb0cd8197e4c4fee49697..8a29eaab0cfcb7a389e09f8869b572d5886e2eaf 100644
--- a/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
@@ -96,7 +96,7 @@ static int clk_mt7622_apmixed_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	ret = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	ret = mtk_clk_register_plls(dev, plls, ARRAY_SIZE(plls), clk_data);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index baf94e7bea373c59cb6333fdb483d00240b744c7..e154771b1b8bba7378af8a797c81d0784b626e3b 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -634,7 +634,7 @@ static int mtk_apmixedsys_init(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls),
+	mtk_clk_register_plls(&pdev->dev, plls, ARRAY_SIZE(plls),
 			      clk_data);
 
 	mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
diff --git a/drivers/clk/mediatek/clk-mt7981-apmixed.c b/drivers/clk/mediatek/clk-mt7981-apmixed.c
index e8211eb4e09e1a645f7e50a1e5814d29030c1757..6606b54fb376983ec7d49b00c2c0d1690c734058 100644
--- a/drivers/clk/mediatek/clk-mt7981-apmixed.c
+++ b/drivers/clk/mediatek/clk-mt7981-apmixed.c
@@ -76,7 +76,7 @@ static int clk_mt7981_apmixed_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	mtk_clk_register_plls(&pdev->dev, plls, ARRAY_SIZE(plls), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
diff --git a/drivers/clk/mediatek/clk-mt7986-apmixed.c b/drivers/clk/mediatek/clk-mt7986-apmixed.c
index 93751abe6be89784a102a0e5ac629d363ab3baaf..1c79418d08a77acf25cee914fb6573ac1707163e 100644
--- a/drivers/clk/mediatek/clk-mt7986-apmixed.c
+++ b/drivers/clk/mediatek/clk-mt7986-apmixed.c
@@ -74,7 +74,7 @@ static int clk_mt7986_apmixed_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	mtk_clk_register_plls(&pdev->dev, plls, ARRAY_SIZE(plls), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
diff --git a/drivers/clk/mediatek/clk-mt7988-apmixed.c b/drivers/clk/mediatek/clk-mt7988-apmixed.c
index 63d33a78cb48805f71aa6a74f8ed6b83f3b4fe22..416a4b88d100bb47bdb07e4f72bc13208c8707a7 100644
--- a/drivers/clk/mediatek/clk-mt7988-apmixed.c
+++ b/drivers/clk/mediatek/clk-mt7988-apmixed.c
@@ -86,7 +86,7 @@ static int clk_mt7988_apmixed_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	r = mtk_clk_register_plls(&pdev->dev, plls, ARRAY_SIZE(plls), clk_data);
 	if (r)
 		goto free_apmixed_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8135-apmixedsys.c b/drivers/clk/mediatek/clk-mt8135-apmixedsys.c
index bdadc35c64cbd8987061c4442b8ff2f5fe50cc32..19e4ee489ec3905e92674ed0813a9f60f9c28209 100644
--- a/drivers/clk/mediatek/clk-mt8135-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8135-apmixedsys.c
@@ -57,7 +57,8 @@ static int clk_mt8135_apmixed_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	ret = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	ret = mtk_clk_register_plls(&pdev->dev, plls, ARRAY_SIZE(plls),
+				    clk_data);
 	if (ret)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8167-apmixedsys.c b/drivers/clk/mediatek/clk-mt8167-apmixedsys.c
index adf576786696e0962dfd5147dfc8897bfaa48054..fb6c21bbeef81a383b56c8fada1799e0680676e5 100644
--- a/drivers/clk/mediatek/clk-mt8167-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8167-apmixedsys.c
@@ -105,7 +105,7 @@ static int clk_mt8167_apmixed_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	ret = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	ret = mtk_clk_register_plls(dev, plls, ARRAY_SIZE(plls), clk_data);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/mediatek/clk-mt8183-apmixedsys.c b/drivers/clk/mediatek/clk-mt8183-apmixedsys.c
index 551adbfd7ac9309bbc4f9beefe4f26230514f062..6242d4f5376e79346b2219b0a35cf0c5ad755e49 100644
--- a/drivers/clk/mediatek/clk-mt8183-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8183-apmixedsys.c
@@ -155,7 +155,7 @@ static int clk_mt8183_apmixed_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	ret = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	ret = mtk_clk_register_plls(dev, plls, ARRAY_SIZE(plls), clk_data);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/mediatek/clk-mt8188-apmixedsys.c b/drivers/clk/mediatek/clk-mt8188-apmixedsys.c
index 21d7a9a2ab1af64cca6962960418d44c81dc664a..a1de596bff9945ca938504391e3e33a4987d3a63 100644
--- a/drivers/clk/mediatek/clk-mt8188-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8188-apmixedsys.c
@@ -106,7 +106,7 @@ static int clk_mt8188_apmixed_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	r = mtk_clk_register_plls(&pdev->dev, plls, ARRAY_SIZE(plls), clk_data);
 	if (r)
 		goto free_apmixed_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
index 8b45a3fad02f18df30e4c2ce2ba5b6338eae321f..a2d98ed58e34866b3d68bd0f85bde339c258d822 100644
--- a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
+++ b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
@@ -66,7 +66,8 @@ static int clk_mt8195_apusys_pll_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_plls(node, apusys_plls, ARRAY_SIZE(apusys_plls), clk_data);
+	r = mtk_clk_register_plls(&pdev->dev, apusys_plls,
+				  ARRAY_SIZE(apusys_plls), clk_data);
 	if (r)
 		goto free_apusys_pll_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8196-apmixedsys.c b/drivers/clk/mediatek/clk-mt8196-apmixedsys.c
index 617f5449b88b8bcaf282e8ed8593b52413a233a8..c4ebb0170b82b979fbe7f03925f205325247d55d 100644
--- a/drivers/clk/mediatek/clk-mt8196-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8196-apmixedsys.c
@@ -152,7 +152,8 @@ static int clk_mt8196_apmixed_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_plls(node, mcd->clks, mcd->num_clks, clk_data);
+	r = mtk_clk_register_plls(&pdev->dev, mcd->clks, mcd->num_clks,
+				  clk_data);
 	if (r)
 		goto free_apmixed_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8196-mcu.c b/drivers/clk/mediatek/clk-mt8196-mcu.c
index 5cbcc411ae734c82b97bf099a645cb6aaa31d9c3..13642fc673c267a66027d1fa7073c9cfed68c682 100644
--- a/drivers/clk/mediatek/clk-mt8196-mcu.c
+++ b/drivers/clk/mediatek/clk-mt8196-mcu.c
@@ -122,7 +122,7 @@ static int clk_mt8196_mcu_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_plls(node, plls, num_plls, clk_data);
+	r = mtk_clk_register_plls(&pdev->dev, plls, num_plls, clk_data);
 	if (r)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8196-mfg.c b/drivers/clk/mediatek/clk-mt8196-mfg.c
index ae1eb9de79ae2992b10a400c75e2e0324b100f66..8e09c0f7b7548f8e286671cea2dac64530b8ce47 100644
--- a/drivers/clk/mediatek/clk-mt8196-mfg.c
+++ b/drivers/clk/mediatek/clk-mt8196-mfg.c
@@ -105,7 +105,7 @@ static int clk_mt8196_mfg_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_plls(node, plls, num_plls, clk_data);
+	r = mtk_clk_register_plls(&pdev->dev, plls, num_plls, clk_data);
 	if (r)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8196-vlpckgen.c b/drivers/clk/mediatek/clk-mt8196-vlpckgen.c
index d59a8a9d98550e897d18031d9bb814aa96d3cf57..7dcc164627c578ca93377425c3b21b46da4b4c28 100644
--- a/drivers/clk/mediatek/clk-mt8196-vlpckgen.c
+++ b/drivers/clk/mediatek/clk-mt8196-vlpckgen.c
@@ -664,7 +664,7 @@ static int clk_mt8196_vlp_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_factors;
 
-	r = mtk_clk_register_plls(node, vlp_plls, ARRAY_SIZE(vlp_plls),
+	r = mtk_clk_register_plls(dev, vlp_plls, ARRAY_SIZE(vlp_plls),
 				  clk_data);
 	if (r)
 		goto unregister_muxes;
diff --git a/drivers/clk/mediatek/clk-mt8365-apmixedsys.c b/drivers/clk/mediatek/clk-mt8365-apmixedsys.c
index f41b991a0178af3067b19a693512ec922af48e07..e331aa28a4bd58baf48a4aae1601cc80fc5661ac 100644
--- a/drivers/clk/mediatek/clk-mt8365-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8365-apmixedsys.c
@@ -133,7 +133,7 @@ static int clk_mt8365_apmixed_probe(struct platform_device *pdev)
 		return PTR_ERR(hw);
 	clk_data->hws[CLK_APMIXED_USB20_EN] = hw;
 
-	ret = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	ret = mtk_clk_register_plls(dev, plls, ARRAY_SIZE(plls), clk_data);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/mediatek/clk-mt8516-apmixedsys.c b/drivers/clk/mediatek/clk-mt8516-apmixedsys.c
index edd9174d2f2ff97a0c1198caa2a0b9c1ca40ffd2..2a6206cae2f087ff06fe60a6cf96a0fa3143e567 100644
--- a/drivers/clk/mediatek/clk-mt8516-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8516-apmixedsys.c
@@ -87,7 +87,7 @@ static int clk_mt8516_apmixed_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	ret = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	ret = mtk_clk_register_plls(dev, plls, ARRAY_SIZE(plls), clk_data);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index cd2b6ce551c6b0333cbe0a4f0d155ba2411f757a..5caf91ae9ddbe4f4d7052864adf0a5a70bda66bc 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -11,6 +11,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 
 #include "clk-pll.h"
@@ -404,7 +405,7 @@ void mtk_clk_unregister_pll(struct clk_hw *hw)
 	kfree(pll);
 }
 
-int mtk_clk_register_plls(struct device_node *node,
+int mtk_clk_register_plls(struct device *dev,
 			  const struct mtk_pll_data *plls, int num_plls,
 			  struct clk_hw_onecell_data *clk_data)
 {
@@ -412,7 +413,7 @@ int mtk_clk_register_plls(struct device_node *node,
 	int i;
 	struct clk_hw *hw;
 
-	base = of_iomap(node, 0);
+	base = of_iomap(dev->of_node, 0);
 	if (!base) {
 		pr_err("%s(): ioremap failed\n", __func__);
 		return -EINVAL;
@@ -423,7 +424,7 @@ int mtk_clk_register_plls(struct device_node *node,
 
 		if (!IS_ERR_OR_NULL(clk_data->hws[pll->id])) {
 			pr_warn("%pOF: Trying to register duplicate clock ID: %d\n",
-				node, pll->id);
+				dev->of_node, pll->id);
 			continue;
 		}
 
diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
index d71c150ce83e4bb2fe78290c2d5570a90084246d..0e2b94b9cd4b56adceee3b04e9ab24c2526471da 100644
--- a/drivers/clk/mediatek/clk-pll.h
+++ b/drivers/clk/mediatek/clk-pll.h
@@ -78,9 +78,9 @@ struct mtk_clk_pll {
 	const struct mtk_pll_data *data;
 };
 
-int mtk_clk_register_plls(struct device_node *node,
-			  const struct mtk_pll_data *plls, int num_plls,
-			  struct clk_hw_onecell_data *clk_data);
+int mtk_clk_register_plls(struct device *dev, const struct mtk_pll_data *plls,
+			  int num_plls, struct clk_hw_onecell_data *clk_data);
+
 void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num_plls,
 			     struct clk_hw_onecell_data *clk_data);
 

-- 
2.51.0


