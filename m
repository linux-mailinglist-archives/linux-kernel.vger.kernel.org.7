Return-Path: <linux-kernel+bounces-884697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B96C30D21
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 12:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1AA24275A7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 11:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624EC2DCC1B;
	Tue,  4 Nov 2025 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="HDx1A+Lq"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29302D6E6E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762256970; cv=none; b=WskIt5Ffho16h0nmFY2B+LVndYX+68/ZhZzc+DtIHniAm7ECcqII9ccR6LCNzjDQqm7C6bjdRSP6N9VQ3S70WF3GA/3QRk8vXLqMte3pcF7vQxO9dg6EUhwqVDVwu2g4EXHsF/dtrPAyQg5I8ziQxOR7IczE55/GaRS4lur1/6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762256970; c=relaxed/simple;
	bh=CKT1nhbWtK1ppjtO41KsCtKgqW+QgLN18kyQi1cgNdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kKWJXcvWTbRgoVKwbLEzYnkd4LTFMhJ83iG6vJhWtUQYy7pWp8H2oPzK2kdId2+75WRU0ga5JKjLX/PwVAMksBdErZVC9d9nLIa4FFUy7Qws/ZuPybi1RIo/zjh4htzhish6w7TS+BSsPZLN6RkiHtzqSaNWV3iO7f2U91goH/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=HDx1A+Lq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4711810948aso38614275e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 03:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762256967; x=1762861767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W3Q3lfgSzo70PNdFL4DM707Bst20OFBSjv1WovPhPE0=;
        b=HDx1A+LqrrpUNazAYyH+ZnrXLVrSEn8jrsvola2SDmQ9W89NRpw48UUxVc2EoXldBp
         YRE/7RDnxmOoQ/OSPKqAyUjkmowuEUFA9gA/8CDPrZAe+kRR1Z6VI3w0xoTPtD+1tRIA
         GRp6YXnIWk8qk6/4MrFkF7/Wg6Delxstid96uGuHILaSM8rmq0We4R+I2KHC/tDOs+58
         7m803oJgs3OFae2YS8B7JKsIaHN8JsGBHCQGAi2ImiU8aMoqSfvTI7nIYmVMmc1l6P5/
         j6ieN69X5rxBZ/z8OeDbjFYTIoR5qPFLDZx+Zb2wyVHI97TJQGlKTLr52ej8zucwYKAm
         nc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762256967; x=1762861767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W3Q3lfgSzo70PNdFL4DM707Bst20OFBSjv1WovPhPE0=;
        b=DRg+JWOKy0uaqbiipJXrmuTX3rnBO6HuUmLzWhS3mJvy4KB5RqE0NKrvObjIOw0FOv
         Xj/R0d+iSM1Blza6FLAHKmvvTRLUxUDyIwjYFTUuwj/m94l7eJ/YcK9h/M+MI6xFMI5Y
         uAGhIkiU7AAYBqodrw473AlsRzTv9saoNI0HOhxsT/jK69K8VsOSsrC3Xf5k116rYRDs
         WhnHfpgmCtWLrXnVm7LAUAwIzXbsHkEJ+YT3oy+UTPAgL+P+5FGZXT6QC7KeFvzvLqNH
         SOm9zIHft1qnXAuUjbOPrgSPAQtEsoTeyoXfUUtL6LJ/No/qgJ6+cHj1SeL4MVsHsVXL
         YuQg==
X-Forwarded-Encrypted: i=1; AJvYcCVqpu2z4P2WpkxtvMety6coAVmpY97/Wf/veHzGKqwlRzYhDc1EYuS7SrNphDWDKUhWes41heRP7OZaANY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdmiQ7YVGe3cN5xwA/ax8EnfqU316y9prbHen6XNVTNZ+VEBFu
	jcjF+z6SHjMQIfwVR7D8sEh4kQK126qrovwK7gEeU2C7D1ilviwA4cLwZQstTxk8TM0=
X-Gm-Gg: ASbGncs4pmzyJZ9anUkEVArL7pb46dFaYREFlBHtsbTbqiuDeMLIUv9jEAQYV8Nvw2R
	f+Ink0cXcd8eBh8jauY296QUjfPtpKd60RZpPLZuEjVpk3iUGEN1dwcLRQTPS9WIT3TE4nL5z0O
	h8ToxQTBwrvmwW4blnpiSI7sZo7x8lA9hZiT0JoTWoR8U76sEeP5RbJn0OwaVntbE/VjkZVU+h2
	TKcPyGkbkcZY8XpjPpFlrcZLDMbTM2js+q07g8dLtGNDQhSoTBgGV3YdNQEq0fcP7BkZ1tuSadj
	8dYlk+doCMKlHaL1MAm75R42+e8ddD2jRNSLJUyVWCzFwTJKEARa9omFqaTIe3y0Jbn3Nuaivwk
	ysurub86Bnjj/GNfzpz8yGZclvK6YeAV/glfU4z3XPPcYooCfamrIRq5kUvN4EUOven3DIBeqcV
	spYfLFAxH0eSkEFKSmqIK0UFecKmZQGgJUtVrzPJCO
X-Google-Smtp-Source: AGHT+IFbxxKS7M3rAb63teL3DhfpL/hNeaf7jG1V589UZvNdPARtVhJN/7tTY0bkkAg8PsGFjx+3Jg==
X-Received: by 2002:a05:600d:835a:b0:46e:3709:d88a with SMTP id 5b1f17b1804b1-47730890ea5mr95596395e9.33.1762256966869;
        Tue, 04 Nov 2025 03:49:26 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47755942772sm16627315e9.5.2025.11.04.03.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 03:49:26 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: support.opensource@diasemi.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: claudiu.beznea@tuxon.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] ASoC: da7213: Use component driver suspend/resume
Date: Tue,  4 Nov 2025 13:49:14 +0200
Message-ID: <20251104114914.2060603-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Since snd_soc_suspend() is invoked through snd_soc_pm_ops->suspend(),
and snd_soc_pm_ops is associated with the soc_driver (defined in
sound/soc/soc-core.c), and there is no parent-child relationship between
the soc_driver and the DA7213 codec driver, the power management subsystem
does not enforce a specific suspend/resume order between the DA7213 driver
and the soc_driver.

Because of this, the different codec component functionalities, called from
snd_soc_resume() to reconfigure various functions, can race with the
DA7213 struct dev_pm_ops::resume function, leading to misapplied
configuration. This occasionally results in clipped sound.

Fix this by dropping the struct dev_pm_ops::{suspend, resume} and use
instead struct snd_soc_component_driver::{suspend, resume}. This ensures
the proper configuration sequence is handled by the ASoC subsystem.

Cc: stable@vger.kernel.org
Fixes: 431e040065c8 ("ASoC: da7213: Add suspend to RAM support")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- kept runtime PM ops unchanged and re-use them on
  struct snd_soc_component_driver::{suspend, resume}
- updated the patch description to reflect the new approach
- fixed the patch title
- dropped patch 2/2 from v1 along with the cover letter

 sound/soc/codecs/da7213.c | 69 +++++++++++++++++++++++++--------------
 sound/soc/codecs/da7213.h |  1 +
 2 files changed, 45 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index c1657f348ad9..81bd5b03e2b6 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -2124,11 +2124,50 @@ static int da7213_probe(struct snd_soc_component *component)
 	return 0;
 }
 
+static int da7213_runtime_suspend(struct device *dev)
+{
+	struct da7213_priv *da7213 = dev_get_drvdata(dev);
+
+	regcache_cache_only(da7213->regmap, true);
+	regcache_mark_dirty(da7213->regmap);
+	regulator_bulk_disable(DA7213_NUM_SUPPLIES, da7213->supplies);
+
+	return 0;
+}
+
+static int da7213_runtime_resume(struct device *dev)
+{
+	struct da7213_priv *da7213 = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regulator_bulk_enable(DA7213_NUM_SUPPLIES, da7213->supplies);
+	if (ret < 0)
+		return ret;
+	regcache_cache_only(da7213->regmap, false);
+	return regcache_sync(da7213->regmap);
+}
+
+static int da7213_suspend(struct snd_soc_component *component)
+{
+	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
+
+	return da7213_runtime_suspend(da7213->dev);
+}
+
+static int da7213_resume(struct snd_soc_component *component)
+{
+	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
+
+	return da7213_runtime_resume(da7213->dev);
+}
+
 static const struct snd_soc_component_driver soc_component_dev_da7213 = {
 	.probe			= da7213_probe,
 	.set_bias_level		= da7213_set_bias_level,
 	.controls		= da7213_snd_controls,
 	.num_controls		= ARRAY_SIZE(da7213_snd_controls),
+	.suspend		= da7213_suspend,
+	.resume			= da7213_resume,
 	.dapm_widgets		= da7213_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(da7213_dapm_widgets),
 	.dapm_routes		= da7213_audio_map,
@@ -2175,6 +2214,8 @@ static int da7213_i2c_probe(struct i2c_client *i2c)
 	if (!da7213->fin_min_rate)
 		return -EINVAL;
 
+	da7213->dev = &i2c->dev;
+
 	i2c_set_clientdata(i2c, da7213);
 
 	/* Get required supplies */
@@ -2224,31 +2265,9 @@ static void da7213_i2c_remove(struct i2c_client *i2c)
 	pm_runtime_disable(&i2c->dev);
 }
 
-static int da7213_runtime_suspend(struct device *dev)
-{
-	struct da7213_priv *da7213 = dev_get_drvdata(dev);
-
-	regcache_cache_only(da7213->regmap, true);
-	regcache_mark_dirty(da7213->regmap);
-	regulator_bulk_disable(DA7213_NUM_SUPPLIES, da7213->supplies);
-
-	return 0;
-}
-
-static int da7213_runtime_resume(struct device *dev)
-{
-	struct da7213_priv *da7213 = dev_get_drvdata(dev);
-	int ret;
-
-	ret = regulator_bulk_enable(DA7213_NUM_SUPPLIES, da7213->supplies);
-	if (ret < 0)
-		return ret;
-	regcache_cache_only(da7213->regmap, false);
-	return regcache_sync(da7213->regmap);
-}
-
-static DEFINE_RUNTIME_DEV_PM_OPS(da7213_pm, da7213_runtime_suspend,
-				 da7213_runtime_resume, NULL);
+static const struct dev_pm_ops da7213_pm = {
+	RUNTIME_PM_OPS(da7213_runtime_suspend, da7213_runtime_resume, NULL)
+};
 
 static const struct i2c_device_id da7213_i2c_id[] = {
 	{ "da7213" },
diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
index b9ab791d6b88..29cbf0eb6124 100644
--- a/sound/soc/codecs/da7213.h
+++ b/sound/soc/codecs/da7213.h
@@ -595,6 +595,7 @@ enum da7213_supplies {
 /* Codec private data */
 struct da7213_priv {
 	struct regmap *regmap;
+	struct device *dev;
 	struct mutex ctrl_lock;
 	struct regulator_bulk_data supplies[DA7213_NUM_SUPPLIES];
 	struct clk *mclk;
-- 
2.43.0


