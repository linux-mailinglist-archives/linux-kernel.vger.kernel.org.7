Return-Path: <linux-kernel+bounces-875622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5232C197AE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D146548966
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF1D3328F7;
	Wed, 29 Oct 2025 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="McJClldz"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48BE3328FF
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730783; cv=none; b=tscAh1aTd857XzPySTxJk1HT4iIYWpOJAVv4wqD8VtqevUDi+1vDGdpL/pD4uXrpQPCAsRSTPm2nb0MvwsqvxKuH15HPRJ7R/qZXRrI57iyfeg3Ct+qwegpEf6iqu8QQ4jHW8OYRc3X5JOTZG1hAXaBRT+W7p51Iru86xa4yOws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730783; c=relaxed/simple;
	bh=9Jrp+ehv1bHsY53MY3h58OEcHjCmI5PtpCsDcMmBsMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yj3YFidBt/dhj64ks2iwt0nxvdSeEAVRxmO7I+bZcqRDhd1ldgEM9wqBR7eWfcOm6rmpIgzKfYQide/X1HRSyYb9nk+6rQUQ6HGo2yPuDgGM1s/wXQAvyv163//1ZTdef/SBHAgA0W1NvBhF7fX9Bd9NNdk2FaTFTU3OPHkQUfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=McJClldz; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8BFCA4E413C6;
	Wed, 29 Oct 2025 09:39:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 60D4B606E8;
	Wed, 29 Oct 2025 09:39:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BE099117F19E1;
	Wed, 29 Oct 2025 10:39:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761730779; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=cag2UQaMgFonyUk6auPnw8wxwz30sT+vgy2pDfTh9FE=;
	b=McJClldzrIeRFKB4lV5B+LrsznjEJVBrhnFiYKfRM/oF0P+2JHq4H5AU1C3vQRIZKH/+m0
	zdpgbyD5+rxfmQLC7ag4iUh/+wi+MH8hUgvlx2evyb546mf6kP28pTmknpX0C3OX9y10eA
	OfykYcrXqc97WrBipy16emLqhOS3jmqh/Ds6N63k02x7KzcS8euA44ZTfZ64OPXf+XU7E3
	iVFebs5g2Ap6JWxY8KkVFHX9B3v0E4Zwa4pr+Kj+Qj9OCcvrDAUM1YzkPkYlrN1Bp3A6vL
	NgdmGyXHACqDjhn+czoywIA5c8R6NR5TRoktWagR9ifEtxddB8hfW+1FW79C+Q==
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
Subject: [PATCH v2 4/4] ASoC: cs4271: Add support for the external mclk
Date: Wed, 29 Oct 2025 10:39:20 +0100
Message-ID: <20251029093921.624088-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029093921.624088-1-herve.codina@bootlin.com>
References: <20251029093921.624088-1-herve.codina@bootlin.com>
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
 sound/soc/codecs/cs4271.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index a9d333e6c723..b8a50b9001e1 100644
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
@@ -505,6 +507,7 @@ static int cs4271_soc_suspend(struct snd_soc_component *component)
 		return ret;
 
 	regcache_mark_dirty(cs4271->regmap);
+	clk_disable_unprepare(cs4271->clk);
 	regulator_bulk_disable(ARRAY_SIZE(cs4271->supplies), cs4271->supplies);
 
 	return 0;
@@ -522,6 +525,12 @@ static int cs4271_soc_resume(struct snd_soc_component *component)
 		return ret;
 	}
 
+	ret = clk_prepare_enable(cs4271->clk);
+	if (ret) {
+		dev_err(component->dev, "Failed to enable clk: %d\n", ret);
+		return ret;
+	}
+
 	/* Do a proper reset after power up */
 	cs4271_reset(component);
 
@@ -567,22 +576,29 @@ static int cs4271_component_probe(struct snd_soc_component *component)
 		cs4271->enable_soft_reset = cs4271plat->enable_soft_reset;
 	}
 
+	ret = clk_prepare_enable(cs4271->clk);
+	if (ret) {
+		dev_err(component->dev, "Failed to enable clk: %d\n", ret);
+		goto err_disable_regulators;
+	}
+
 	/* Reset codec */
 	cs4271_reset(component);
 
 	ret = regcache_sync(cs4271->regmap);
 	if (ret < 0)
-		goto err_disable_regulators;
+		goto err_disable_clk;
 
 	ret = regmap_update_bits(cs4271->regmap, CS4271_MODE2,
 				 CS4271_MODE2_PDN | CS4271_MODE2_CPEN,
 				 CS4271_MODE2_PDN | CS4271_MODE2_CPEN);
 	if (ret < 0)
-		goto err_disable_regulators;
+		goto err_disable_clk;
 	ret = regmap_update_bits(cs4271->regmap, CS4271_MODE2,
 				 CS4271_MODE2_PDN, 0);
 	if (ret < 0)
-		goto err_disable_regulators;
+		goto err_disable_clk;
+
 	/* Power-up sequence requires 85 uS */
 	udelay(85);
 
@@ -593,6 +609,8 @@ static int cs4271_component_probe(struct snd_soc_component *component)
 
 	return 0;
 
+err_disable_clk:
+	clk_disable_unprepare(cs4271->clk);
 err_disable_regulators:
 	regulator_bulk_disable(ARRAY_SIZE(cs4271->supplies), cs4271->supplies);
 	return ret;
@@ -607,6 +625,7 @@ static void cs4271_component_remove(struct snd_soc_component *component)
 
 	regcache_mark_dirty(cs4271->regmap);
 	regulator_bulk_disable(ARRAY_SIZE(cs4271->supplies), cs4271->supplies);
+	clk_disable_unprepare(cs4271->clk);
 };
 
 static const struct snd_soc_component_driver soc_component_dev_cs4271 = {
@@ -641,6 +660,10 @@ static int cs4271_common_probe(struct device *dev,
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


