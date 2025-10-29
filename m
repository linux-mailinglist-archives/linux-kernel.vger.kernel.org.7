Return-Path: <linux-kernel+bounces-876319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F81C1B361
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D95A05A681D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD23C274FEF;
	Wed, 29 Oct 2025 14:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="nHhIgmnL"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8249259CA1
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747111; cv=none; b=EgNeCUVniVamAt4tBT8m7WtqgaRo+VrJBOdkSAB3+mcgHfxsNCnCr1sj2PlFLdPPQWKzZ8DqlXrmCuZapWBg5lFox/yZ6pVDJPvSDQG35+isIVSgTMFv8ThxOYE3JnIg22m0nRX4TC88eOOCAZtJmiGa31t81fAyJlS78PaL0as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747111; c=relaxed/simple;
	bh=Hntdd3yDQRf/U3IuP9ibxYe8opl5fVZAd3eOtMBOPbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfuJ4QL4ipCFWG9J72fDwDpGMe2O1jawMWXomAfN9arHdYzLzBsYfhCRPz0Xd5SJKqdZoqsH3EK/3NT1qUVr3d02Ntp5lgpGdtPn7SMwDgtJHQXZy37M27SpTBs19und4hp1TNIDVN6cU0H5QI5rhkM3Sa79fi7fqMslwtsudSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=nHhIgmnL; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4770c2cd96fso32265695e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1761747108; x=1762351908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiX2FBg0xSMT0ys2toEEaugoNSrzq/45Y+gh1pKXUeU=;
        b=nHhIgmnLu+6w0F3P9KwBxKsC+p3z0KlMRkZcnsek7XeyH2GU+gDXNbiE7klYTZ6b4X
         7U/a9zlOuEtfCiI8e+kaMirWd9J0A+7zZX/yvnaGYEaZIeyruR29gvrMEfpaX/7iUrU8
         OACKJ3wjgD9164Hte5z/lAMkk3xAg7oNthu9zBJ/vtV2u9KQP6x1mbd4NDt0/AP38Xd0
         QqLhUS7giMMsoqHZosCp95Knccu9cJO/gnB59oWpBHClNEfV/83e2XITVEPtGX0QTD4Z
         buhFe0Mf4NZeuPjOIC255/4U294BLEIWxk7SLhQM46e1XK+r/K0CACxj6bdxHn7/opit
         hoow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761747108; x=1762351908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CiX2FBg0xSMT0ys2toEEaugoNSrzq/45Y+gh1pKXUeU=;
        b=DxBdkZx2MdCEwqheUz9tn/Mk77gJ7Hih+vYzRWEid5yLyTcS8tykR1Lc7CGUwniQnI
         mVizVB6e3dp55fGLGb4o7miXylOYlBn3FW/Q6Z7NIIgz2Kz+MIQ5OXtFJ2yLdUE6Wgna
         XWNU+kNHNAXYWrZEoyNqIRB6tOzA2vxhmkOnlLE4rjju/rXm+cXJkJtFtNz364Qw0I4/
         jRyumSoPoNMz3aeE7N3AvyptVvDJd+1/1aBytJLprUx9xhtuHIrhjLwd+PSmgWSOwN4U
         4Afd6YNWDtc5x+sC1ukhlccyl+qDYaBxuJt0pbwU9mWLlELd9uQ8onsTUlyGlpo0dWLC
         PYjg==
X-Forwarded-Encrypted: i=1; AJvYcCUrlKs/6jp8GeTqUuH7q0CZeaqSssGCTS0Ds8fPRvYjSfONVzkSoxxoWobqagpCQApvvxhzvq+aAVRkmqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Je0IxYcG9StQw0JwwkMNF4uIpdU3E11BkE/hJvB1f802q2TD
	MvVS6kocUpFCoDNOPe9+xeSzb9TsqMh6PoeV2u8biah6GYeLA7tWla3ffnhSprwzqaY=
X-Gm-Gg: ASbGncsjpf0RHEgdEmpBkaRO9wySxjE7LWWz/ddxp2wfanyRZA3hPc1BanM2868Npnn
	gJvQVLQuBOnnDwFhAnxaGRsPWa6pssgT4m4OQzk1i2c7P2lM7EnZC5FMw7MBpx+lCm6OhRjnloc
	FDqrH1h1c61HDVLOtWJgbbaSs8bBUI90MUq+PuY5xojg3wLoSUirrdHKgF5Bx96Zb22OmT2TylY
	tTxa6IzkeFpswSYxuvlK1LVNPeXiiyeYZhdmOzQaSKgKT2jDnMw/Xnk5CCtyPI8sAFjvB7RG6U2
	zcEJDUzC/swr0Dm8/lgYJGs/xbeGR6VyN1D27D4Vhx/bqnLYWZ2GesL5GSuwBHKVpL+D2n/1mcb
	QKOyHzQ5fy6afJr/Ic3ZFdcPfx8EOqaKv7JSl+NXe8I/pQmj1lj2Zn7AvmlfEDp/M5kJUFql5vl
	WNiol1NqOZNh/dYQnQiBxBeXpO+uaK7m3JHd+2zTwY1+2RTiowwZ63a/hYGinqHo/6VD15G9A=
X-Google-Smtp-Source: AGHT+IG7D9wiTnWhsTvZgrczWu50oyyOBZvdsojX8GRj+W1b85megZbJiPS5Nql3Nv4Hb2EvAbObRA==
X-Received: by 2002:a05:600c:1c81:b0:477:e66:4077 with SMTP id 5b1f17b1804b1-4771e3fb258mr33456885e9.29.1761747108142;
        Wed, 29 Oct 2025 07:11:48 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6302:7900:aafe:5712:6974:4a42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952db9c6sm27076286f8f.36.2025.10.29.07.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:11:47 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: support.opensource@diasemi.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ASoC: codecs: Use component driver suspend/resume
Date: Wed, 29 Oct 2025 16:11:33 +0200
Message-ID: <20251029141134.2556926-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029141134.2556926-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251029141134.2556926-1-claudiu.beznea.uj@bp.renesas.com>
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
DA7213 resume function, leading to misapplied configuration.
This occasionally results in clipped sound.

Fix this by moving the regmap cache operations into
struct snd_soc_component_driver::{suspend, resume}. This ensures the
proper configuration sequence is handled by the ASoC subsystem.

Cc: stable@vger.kernel.org
Fixes: 431e040065c8 ("ASoC: da7213: Add suspend to RAM support")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/codecs/da7213.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index c1657f348ad9..051806982bbe 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -2124,11 +2124,31 @@ static int da7213_probe(struct snd_soc_component *component)
 	return 0;
 }
 
+static int da7213_suspend(struct snd_soc_component *component)
+{
+	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
+
+	regcache_cache_only(da7213->regmap, true);
+	regcache_mark_dirty(da7213->regmap);
+
+	return 0;
+}
+
+static int da7213_resume(struct snd_soc_component *component)
+{
+	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
+
+	regcache_cache_only(da7213->regmap, false);
+	return regcache_sync(da7213->regmap);
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
@@ -2228,27 +2248,19 @@ static int da7213_runtime_suspend(struct device *dev)
 {
 	struct da7213_priv *da7213 = dev_get_drvdata(dev);
 
-	regcache_cache_only(da7213->regmap, true);
-	regcache_mark_dirty(da7213->regmap);
-	regulator_bulk_disable(DA7213_NUM_SUPPLIES, da7213->supplies);
-
-	return 0;
+	return regulator_bulk_disable(DA7213_NUM_SUPPLIES, da7213->supplies);
 }
 
 static int da7213_runtime_resume(struct device *dev)
 {
 	struct da7213_priv *da7213 = dev_get_drvdata(dev);
-	int ret;
 
-	ret = regulator_bulk_enable(DA7213_NUM_SUPPLIES, da7213->supplies);
-	if (ret < 0)
-		return ret;
-	regcache_cache_only(da7213->regmap, false);
-	return regcache_sync(da7213->regmap);
+	return regulator_bulk_enable(DA7213_NUM_SUPPLIES, da7213->supplies);
 }
 
-static DEFINE_RUNTIME_DEV_PM_OPS(da7213_pm, da7213_runtime_suspend,
-				 da7213_runtime_resume, NULL);
+static const struct dev_pm_ops da7213_pm = {
+	RUNTIME_PM_OPS(da7213_runtime_suspend, da7213_runtime_resume, NULL)
+};
 
 static const struct i2c_device_id da7213_i2c_id[] = {
 	{ "da7213" },
-- 
2.43.0


