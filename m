Return-Path: <linux-kernel+bounces-856242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE094BE399A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DBDA3AF608
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81C6335BC7;
	Thu, 16 Oct 2025 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iQidPaz1"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B91532D7F9;
	Thu, 16 Oct 2025 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619859; cv=none; b=o0MO0hU4xixXzNaz9Z16eZoG17s3FnXcsPF/wHtyHNQ1FnFxbc3LCvFPsNwTI71dVBjZA0kpZPhDb4ay00EzlytS+O54pI1keMJ4HABduHB2Jjd4RWcUZLyevmRK/31Pr1GGzwGzXgot5RYPFUBwOnI9qRIrBT1eZDRF3iD8a10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619859; c=relaxed/simple;
	bh=Co5KuU+qAIZuiHL/bWuYupCgu6V+k3j8ZJmVSLCA1ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gONR/P8D3QMILWUNcfbzX8fG4kyOKovG8ThCz2hX2EbLsbrAI+ZhEFarIkRQ6da/OEB7jXM25ZsHn4BbSrTCjQDdOHQ+swZlcQh57yQqCbQiZgn4iNDZnbcUzKWGyNzZdH0z/W/5+2GA4Fy2JaYP45qTo+kX7ED5gaf7yw/FnUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iQidPaz1; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7B06AC041CE;
	Thu, 16 Oct 2025 13:03:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AE15C6062C;
	Thu, 16 Oct 2025 13:04:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 70291102F230E;
	Thu, 16 Oct 2025 15:04:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760619854; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=3lP2zPTU9xBiuqJX81V4KyxoE+dPnxkHHBQsJkwfLuU=;
	b=iQidPaz1wmtCgZW4zp6DrvqXRLr6T6rLr+Q4rcnRXs6zNNSg885oGAUQBKh9uUnZ3YYI5j
	+6I7H5nqzr4eFRsV/dbOOnkPRWC9nU9XJi7TsGPsaINY5RSfZfCcVAEoWE+vYyF4/Y3ZV9
	fUiXLys9iO3Q2DWLSt8ZfzhnXFWGpa40aJDi69chdq4VCmYAjYOtqfBAHYNX4gwmaqVMHE
	N9MkkqCAueJ4SpElOoyIw5gcvi8NPbw5mNn+/aGOVstiTL5XGlLbdh1KnfQRaWrkX79QVV
	aBcKKq4PVgXzizXbK2I53bXgGxKt3Mb0tvDfwCgcIBF7y6L/HC8YUuHNv0eSmw==
From: Herve Codina <herve.codina@bootlin.com>
To: David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Axel Lin <axel.lin@ingics.com>,
	Brian Austin <brian.austin@cirrus.com>
Cc: linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 3/3] ASoC: cs4271: Add support for the external mclk
Date: Thu, 16 Oct 2025 15:03:39 +0200
Message-ID: <20251016130340.1442090-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016130340.1442090-1-herve.codina@bootlin.com>
References: <20251016130340.1442090-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The mclk (master clock) of the cs4271 codec can be an input clock.

In this case the connected clock needs to be enabled outside of any
audio stream. Indeed, this clock is needed for i2c communication.

Add support of this clock and enable it before the first i2c transfer.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 sound/soc/codecs/cs4271.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index ff9c6628224c..481a2c20b7cf 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -10,6 +10,7 @@
  * DAPM support not implemented.
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
@@ -163,6 +164,7 @@ struct cs4271_private {
 	/* enable soft reset workaround */
 	bool				enable_soft_reset;
 	struct regulator_bulk_data      supplies[ARRAY_SIZE(supply_names)];
+	struct clk *clk;
 };
 
 static const struct snd_soc_dapm_widget cs4271_dapm_widgets[] = {
@@ -567,22 +569,36 @@ static int cs4271_component_probe(struct snd_soc_component *component)
 		cs4271->enable_soft_reset = cs4271plat->enable_soft_reset;
 	}
 
+	ret = clk_prepare_enable(cs4271->clk);
+	if (ret) {
+		dev_err(component->dev, "Failed to enable clk: %d\n", ret);
+		goto err_disable_regulators;
+	}
+
+	/*
+	 * Be sure to have the clock and power-supplies stable before releasing
+	 * the reset.
+	 */
+	fsleep(1000);
+
 	/* Reset codec */
 	cs4271_reset(component);
 
 	ret = regcache_sync(cs4271->regmap);
 	if (ret < 0)
-		return ret;
+		goto err_force_reset;
 
 	ret = regmap_update_bits(cs4271->regmap, CS4271_MODE2,
 				 CS4271_MODE2_PDN | CS4271_MODE2_CPEN,
 				 CS4271_MODE2_PDN | CS4271_MODE2_CPEN);
 	if (ret < 0)
-		return ret;
+		goto err_force_reset;
+
 	ret = regmap_update_bits(cs4271->regmap, CS4271_MODE2,
 				 CS4271_MODE2_PDN, 0);
 	if (ret < 0)
-		return ret;
+		goto err_force_reset;
+
 	/* Power-up sequence requires 85 uS */
 	udelay(85);
 
@@ -592,6 +608,13 @@ static int cs4271_component_probe(struct snd_soc_component *component)
 				   CS4271_MODE2_MUTECAEQUB);
 
 	return 0;
+
+err_force_reset:
+	gpiod_set_value(cs4271->reset, 1);
+	clk_disable_unprepare(cs4271->clk);
+err_disable_regulators:
+	regulator_bulk_disable(ARRAY_SIZE(cs4271->supplies), cs4271->supplies);
+	return ret;
 }
 
 static void cs4271_component_remove(struct snd_soc_component *component)
@@ -603,6 +626,7 @@ static void cs4271_component_remove(struct snd_soc_component *component)
 
 	regcache_mark_dirty(cs4271->regmap);
 	regulator_bulk_disable(ARRAY_SIZE(cs4271->supplies), cs4271->supplies);
+	clk_disable_unprepare(cs4271->clk);
 };
 
 static const struct snd_soc_component_driver soc_component_dev_cs4271 = {
@@ -637,6 +661,10 @@ static int cs4271_common_probe(struct device *dev,
 				     "error retrieving RESET GPIO\n");
 	gpiod_set_consumer_name(cs4271->reset, "CS4271 Reset");
 
+	cs4271->clk = devm_clk_get_optional(dev, "mclk");
+	if (IS_ERR(cs4271->clk))
+		return dev_err_probe(dev, PTR_ERR(cs4271->clk), "Failed to get mclk\n");
+
 	for (i = 0; i < ARRAY_SIZE(supply_names); i++)
 		cs4271->supplies[i].supply = supply_names[i];
 
-- 
2.51.0


