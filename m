Return-Path: <linux-kernel+bounces-848780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB3CBCE8E6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8BA19E240C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F9A303A18;
	Fri, 10 Oct 2025 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="GN+O+O2e"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B804303A11;
	Fri, 10 Oct 2025 20:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129294; cv=pass; b=QrZHJr9gQhFao/H+MeqH1sHU8kS7EB3j+W4U4K5lDggeyzKd6TbUsaaUboICFug6kOD0vm127PwQ0cTzECG6KBq5uE8G4nHO/zLhnK8Srwl98iWJlOuovuyttctbkJPqaS3tXz+2WpeFYXxuNXif03OS7gpYQWfeDpU7GOqgrok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129294; c=relaxed/simple;
	bh=8GUCaiNzqWDhN+ADy4rhGcVaSZLYP8oBvVrAvi+U7xc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WiHC7s3t7RIvzHyyxWB4PHbERc0MvCZXEA7uBaCFZl6xEZJ4rbEtNgcSp/DTLzl1v9F4vEITEL0TstRlUZOkb8147X1zhPVdk46oogKd5wBTEmEZfXJ67VyXwW34a8daXtcnJoNYCt6xCGM6au7Ps50OYn7Xkeu06R0t9sdsOQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=GN+O+O2e; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760129267; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eSCvhPR2NdeiDaGHNZX7X3W1uYCVXVHSnJGrjvj/xt4s3fukUm0aRNLb83FGUOA98Fpf+qgLVQeBJfe7QMG4GnDnMBlzCTVo8hMahtPZs06269uDtVC6J4qI8drj/+c33Qh4JcAHpBSeLDMkVYp3xTRP87pe/u4n9MEhWFfDYhA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760129267; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3++fXgIXc4/LRZtpwaII6fQKy3c0bv1cnXzTItgn82c=; 
	b=h6C/VP+n1I5wUkWlJO9Ei2u8V1urt1RG8AR/XvZOKElze3yKg54GA1FnwkcjLcUzcWywcE5CEdVn8HIfJQ3qBWmJdhGQmF90SFulTkRkFk9KYHEz4zBzrZam22JNMaVNVBZeGMZmvXbe3KurhTin2ym7lYfEBb62YzuU2J9JglM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760129267;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=3++fXgIXc4/LRZtpwaII6fQKy3c0bv1cnXzTItgn82c=;
	b=GN+O+O2eAWG38R0CHn3qKG+FWArOf7vCFCvWdmmPxhgjcfjvuXl7Q6gRD31p5+sz
	KGuFwiGCkZ4283vbndyx6gIo9PUDaq031Wtv8X3tokc6vq3hrjZbEZhSXadlk+ZFq8G
	9JFB5WnL4VStc+07gCluTAJTwWaZm/5EZUNk1mIU=
Received: by mx.zohomail.com with SMTPS id 1760129265113477.12854001630546;
	Fri, 10 Oct 2025 13:47:45 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 10 Oct 2025 22:47:10 +0200
Subject: [PATCH v3 2/5] clk: mediatek: Refactor pll registration to pass
 device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-mtk-pll-rpm-v3-2-fb1bd15d734a@collabora.com>
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

As it stands, mtk_clk_register_plls takes a struct device_node pointer
as its first argument. This is a tragic happenstance, as it's trivial to
get the device_node from a struct device, but the opposite not so much.
The struct device is a much more useful thing to have passed down.

Refactor mtk_clk_register_plls to take a struct device pointer instead
of a struct device_node pointer, and fix up all users of this function.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/clk/mediatek/clk-mt2701.c            |  2 +-
 drivers/clk/mediatek/clk-mt2712-apmixedsys.c |  2 +-
 drivers/clk/mediatek/clk-mt6735-apmixedsys.c |  4 ++--
 drivers/clk/mediatek/clk-mt6765.c            |  2 +-
 drivers/clk/mediatek/clk-mt6779.c            |  2 +-
 drivers/clk/mediatek/clk-mt6797.c            |  2 +-
 drivers/clk/mediatek/clk-mt7622-apmixedsys.c |  2 +-
 drivers/clk/mediatek/clk-mt7629.c            |  2 +-
 drivers/clk/mediatek/clk-mt7981-apmixed.c    |  2 +-
 drivers/clk/mediatek/clk-mt7986-apmixed.c    |  2 +-
 drivers/clk/mediatek/clk-mt7988-apmixed.c    |  2 +-
 drivers/clk/mediatek/clk-mt8135-apmixedsys.c |  3 ++-
 drivers/clk/mediatek/clk-mt8167-apmixedsys.c |  2 +-
 drivers/clk/mediatek/clk-mt8183-apmixedsys.c |  2 +-
 drivers/clk/mediatek/clk-mt8188-apmixedsys.c |  2 +-
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c |  3 ++-
 drivers/clk/mediatek/clk-mt8196-apmixedsys.c |  3 ++-
 drivers/clk/mediatek/clk-mt8196-mcu.c        |  2 +-
 drivers/clk/mediatek/clk-mt8196-mfg.c        |  2 +-
 drivers/clk/mediatek/clk-mt8196-vlpckgen.c   |  2 +-
 drivers/clk/mediatek/clk-mt8365-apmixedsys.c |  2 +-
 drivers/clk/mediatek/clk-mt8516-apmixedsys.c |  2 +-
 drivers/clk/mediatek/clk-pll.c               |  7 ++++---
 drivers/clk/mediatek/clk-pll.h               | 10 ++++------
 24 files changed, 34 insertions(+), 32 deletions(-)

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
index d71c150ce83e4bb2fe78290c2d5570a90084246d..38fde1a273bff0a7a010a37356ebc715fe0720d3 100644
--- a/drivers/clk/mediatek/clk-pll.h
+++ b/drivers/clk/mediatek/clk-pll.h
@@ -10,9 +10,7 @@
 #include <linux/clk-provider.h>
 #include <linux/types.h>
 
-struct clk_ops;
-struct clk_hw_onecell_data;
-struct device_node;
+struct device;
 
 struct mtk_pll_div_table {
 	u32 div;
@@ -78,9 +76,9 @@ struct mtk_clk_pll {
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


