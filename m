Return-Path: <linux-kernel+bounces-798572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7C1B41FFB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A023A9935
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D9530BF6D;
	Wed,  3 Sep 2025 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1AqA+bm6"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A8D30AAC0;
	Wed,  3 Sep 2025 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903693; cv=none; b=SfIO3TWFsTahIMeaZ4WZhzyipted9Vta5+Y4qM3SwXKFglcnW1C9omiFkERLd/FnnbqWsJZmgbLr/pov4NttcH9XPNuoJm2neavXhJpMOkUXEnijRRoRR5kOeZPKKgSN5P3mwAd9tE/Afx9Mb+3R3dQg5B5TeapPzBsoqjgXKk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903693; c=relaxed/simple;
	bh=4bNNkHVC2aJNVXLs/K85UFMmabtxOabApbEO1pdUgyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rkLAFwAjHnjN8Y1fFl0yvF6VVR5vVosPiASQrswloSZZZitUxZn0LBnpRfBY+FS3GaG/6vsqhbcs66xq1rHE/gEZcx3faCBk7pJdCrFpnhxjTR50FZosgIR/q596uWP3kQ4PW8lXT9drLbV2WCJPJ7GqZa6G1KihsgWV35jZq10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1AqA+bm6; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 052E31A08CE;
	Wed,  3 Sep 2025 12:48:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D2335606C3;
	Wed,  3 Sep 2025 12:48:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 318081C22A4EA;
	Wed,  3 Sep 2025 14:48:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756903688; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=OAZYQK1WvsUmQL4WZLsOwmlchJWna6XIMMIb+V5JjQ8=;
	b=1AqA+bm6fjtkmWg6FVcdHY6BVRtDDm2azATuHi2QE4Ad76X4ABZ4JIi4eiNtIfvLEuX4bZ
	i5imFE2FAJMyeUR6nAm8VK3ckz3Opg7HtjHv+CLTTMcykWNvLCi6Xso/1Z42BLDG2E3bFJ
	mNK0OcS9Wc9OXZZyz5LVorDC3I9MkSUgbCLmFng2SwZFEZ+OQSz9/zz82r4sXWPq2L8sOJ
	wd8UscwQ1Rm+yiop55x+GdzhSjHnjDhdsLHYGeCq/U3k3xA8/Lsze56rUf+9iVoJ9D3y09
	M6V11Vm3zj2FEETL2zVjrTbdfRgmmb5bgk7wA9ugJfxwua0s1aZLFbHG1dmpbg==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Wed, 03 Sep 2025 14:47:24 +0200
Subject: [PATCH 17/19] clk: eyeq: add a parent field to the pll
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250903-clk-eyeq7-v1-17-3f5024b5d6e2@bootlin.com>
References: <20250903-clk-eyeq7-v1-0-3f5024b5d6e2@bootlin.com>
In-Reply-To: <20250903-clk-eyeq7-v1-0-3f5024b5d6e2@bootlin.com>
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-mips@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Sari Khoury <sari.khoury@mobileye.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Allow setting the parent of a pll. If NULL, use the same "ref" clock as
before. If non-NULL, the name is looked up in the "clock-names" passed
in the device tree and if found it is used as the fw_name, similar to
how "ref" was used previously.

If not found, the name is used as the parent_name when registering the
clock with clk_hw_register_fixed_factor_with_accuracy. This last case
is used to refer to a clock registered in early init and used by the
same OLB during probe while avoiding a dependency cycle.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/clk/clk-eyeq.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-eyeq.c b/drivers/clk/clk-eyeq.c
index cf745671d86a5fc770ec3599561eb3468e13bd58..a6260c38393776afab60e994c99008cfeecf6bc3 100644
--- a/drivers/clk/clk-eyeq.c
+++ b/drivers/clk/clk-eyeq.c
@@ -115,6 +115,7 @@ struct eqc_pll {
 	const char		*name;
 	unsigned int		reg;
 	enum eqc_pll_type	type;
+	const char		*parent_name;
 };
 
 /*
@@ -366,8 +367,10 @@ static int eqc_parse_one_pll(void __iomem *base, enum eqc_pll_type type, unsigne
 static void eqc_probe_init_plls(struct device *dev, const struct eqc_match_data *data,
 				void __iomem *base, struct clk_hw_onecell_data *cells)
 {
+	struct device_node *np = dev->of_node;
 	unsigned long mult, div, acc;
 	const struct eqc_pll *pll;
+	const char *fw_name;
 	struct clk_hw *hw;
 	unsigned int i;
 	int ret;
@@ -382,8 +385,20 @@ static void eqc_probe_init_plls(struct device *dev, const struct eqc_match_data
 			continue;
 		}
 
-		hw = clk_hw_register_fixed_factor_with_accuracy_fwname(dev,
-				dev->of_node, pll->name, "ref", 0, mult, div, acc);
+		if (!pll->parent_name)
+			fw_name = "ref";
+		else if (of_property_match_string(np, "clock-names", pll->parent_name) >= 0)
+			fw_name = pll->parent_name;
+		else
+			fw_name = NULL;
+
+		if (fw_name)
+			hw = clk_hw_register_fixed_factor_with_accuracy_fwname(dev,
+					np, pll->name, fw_name, 0, mult, div, acc);
+		else
+			hw = clk_hw_register_fixed_factor_with_accuracy(dev,
+					pll->name, pll->parent_name, 0, mult, div, acc);
+
 		cells->hws[pll->index] = hw;
 		if (IS_ERR(hw))
 			dev_warn(dev, "failed registering %s: %pe\n", pll->name, hw);

-- 
2.51.0


