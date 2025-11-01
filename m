Return-Path: <linux-kernel+bounces-881173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC83C27A2D
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 09:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440581899BB0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 08:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3724C286415;
	Sat,  1 Nov 2025 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qNAd3Gx1"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E1D2BDC1D;
	Sat,  1 Nov 2025 08:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761987242; cv=none; b=C0uaTVJVsFNT5EKzUlBy9FDM0TbLQntjrDR6sefUqkvAoAMTZUw/ftziSr084jbVinr2WAJXPGovLsvAjxvHRWO+X6Mb49kqxqPz7xPHpHsdrWlEoPuwO+6pxSlXvjfh4lbXiygBZQR8EutiQOeozAgIR3yWoBVJAWfdu/m93s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761987242; c=relaxed/simple;
	bh=NYG+ETPj2x0u/ibgpjtgBYkOFUnLc2KAk3q8zgMWzxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iCSUi/PRIQJGOXkjZnbVBCM32KY0164N1/mLGHvpNBO1Fvq9hOgKcEQ+4mPdUi6jbAELriEn+OQKSyvIVt/Shk1M4XVOCACv8JsRhk1sPzyVnXeo9kSVWbfgMAlVgdBSdkssjWnRT0BCyHun2tdmQeFI+LaQ7TgsgMMv4noz6cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qNAd3Gx1; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DAEDDC0E96E;
	Sat,  1 Nov 2025 08:53:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7960D6070B;
	Sat,  1 Nov 2025 08:53:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 144FF11819FA5;
	Sat,  1 Nov 2025 09:53:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761987237; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xGfi/wxxIWJSZ/P38qx/iDvGfCPuBRfGoA+hd2Uxo10=;
	b=qNAd3Gx1W2aWuBjGQrqgJRJBHhcwNPafbm7rBGugSQkYJXTrbincOX4X+g4J84X0gC3g17
	2vu00AIZTYB1cIxFryvUcmTqTokf9BOh8EPkAlV/wwkoAVTiVRnUSqPdsN2SjWFoTTWn8l
	qJ6+QRtLiQShf+vcZjbClsdIICzbXClnsWvCSz0vmQS1VfMURLBHCPpgyqeywfdelx4Jho
	OZwBr60z6DJ1J/G+lJz9tRuIVqNx5uNR7Sp6BNSEY31eEY2F5Er5nTF1/00mH5eZcI84+E
	y0jt3trtC0bUQgs9i4/vDH5OLoYlpxa2Ti9crY9BqiW1uT92vYT6RO901GJcxw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Sat, 01 Nov 2025 09:53:32 +0100
Subject: [PATCH v2 4/7] clk: eyeq: add EyeQ5 children auxiliary device for
 generic PHYs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251101-macb-phy-v2-4-c1519eef16d3@bootlin.com>
References: <20251101-macb-phy-v2-0-c1519eef16d3@bootlin.com>
In-Reply-To: <20251101-macb-phy-v2-0-c1519eef16d3@bootlin.com>
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-clk@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Grow our clk-eyeq family; it knows how to spawn reset provider and pin
controller children. Expand with a generic PHY driver on EyeQ5.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/clk/clk-eyeq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/clk-eyeq.c b/drivers/clk/clk-eyeq.c
index 664ce7d7868d..a9de57315e48 100644
--- a/drivers/clk/clk-eyeq.c
+++ b/drivers/clk/clk-eyeq.c
@@ -109,6 +109,7 @@ struct eqc_match_data {
 
 	const char		*reset_auxdev_name;
 	const char		*pinctrl_auxdev_name;
+	const char		*eth_phy_auxdev_name;
 
 	unsigned int		early_clk_count;
 };
@@ -361,6 +362,7 @@ static int eqc_probe(struct platform_device *pdev)
 	/* Init optional auxiliary devices. */
 	eqc_auxdev_create_optional(dev, base, data->reset_auxdev_name);
 	eqc_auxdev_create_optional(dev, base, data->pinctrl_auxdev_name);
+	eqc_auxdev_create_optional(dev, base, data->eth_phy_auxdev_name);
 
 	if (data->pll_count + data->div_count + data->fixed_factor_count == 0)
 		return 0; /* Zero clocks, we are done. */
@@ -521,6 +523,7 @@ static const struct eqc_match_data eqc_eyeq5_match_data = {
 
 	.reset_auxdev_name = "reset",
 	.pinctrl_auxdev_name = "pinctrl",
+	.eth_phy_auxdev_name = "phy",
 
 	.early_clk_count = ARRAY_SIZE(eqc_eyeq5_early_plls) +
 			   ARRAY_SIZE(eqc_eyeq5_early_fixed_factors),

-- 
2.51.1


