Return-Path: <linux-kernel+bounces-894010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2917BC4910E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1149B4EF0EB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A36C341AAE;
	Mon, 10 Nov 2025 19:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oDz8IoDU"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E883B339708
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802957; cv=none; b=jsiXllKBBvuJ5aLzyPufmchrF0EzrZ/Qh1iFlX0I0M5ZuKZxsJTZ/CrLgZYIT9TV6M1O3M3oMDNV92xhDz00jjQzHUpC6cfJ3YKoZvt51i5CetGytpdT7TpdoWObl0E0X3axPWu9SBvjzY8dXTvc509+Muh6wJpjLB4bKVpouys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802957; c=relaxed/simple;
	bh=Rkw9WFZoXp+5InFPPXxrxAJqP9DWE+hJyBAEvtT6sRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WRwFN5Oeb0i1zt/IZwtBKE3A/LtaaF9/x5ZF6pi5H6ydEsG91mXb2Gn9RDx/SWJtjC6TBfagLaVR7Kc41pYjtMOmn/PHvLxxH6IsO8+U7F0h0ewJU31hc7O4ynXCNVprx3EB8fCypwsg6QcNDLe+4g8rGl+Lge2Ovk4yPrrwbeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oDz8IoDU; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso497596166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762802948; x=1763407748; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9GRGFlvExyifoBhuyafidhUoY1iG6eXyVZefzJBFYOs=;
        b=oDz8IoDUazH9p5kgYCIvBiK1g0HMsJ6aUJpQ3ZpW4XziCtpineqk2MaQAkJzO59x5b
         IyazJNUSQ04oMKvPXIsg/0yIHjGCOZkMF5NJ/avKdMLuf6tW/2A/LrK77BPkvEG+MSC2
         83YyPf3Dsso/suNWZfKgahuwhmQuacIrYKuZqHQ2kiGaWMXhiBcrEfi8pDYWxM0KURrx
         aZz4hk8eK15/JkNWOD1y0goJtYCb1rF2Hn3g9/eZlSYO+W+oegHmu6FyPw9S1GdRtWYA
         p9eRJF8H2BQmSO0igetho3Du5aW2xQ8cNymjioAxW6hGxJYmlYWpUjrvIZTCqmwLo2N9
         VCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762802948; x=1763407748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9GRGFlvExyifoBhuyafidhUoY1iG6eXyVZefzJBFYOs=;
        b=KDuaj8bjdQ+V7EsQQXCbLzIoUgddYIEDgC2z8sDqJ4oirCYDBbow0utZPvKZlkkxTY
         4jhGnbEzE3egik9M+zwcUH9vkySmlsOyhHHo65UFCX3odNCNd0oNVu4CgWdfhGOOG9IO
         JXU41kv0o2rITpJKlIRgMYz4x/BqxSB7CLleR5ZmlyjwCzMBJQAJxBEFMrPez/1iO/x9
         ifeK6H2zV8so8t8pvIeUQrKPjjCu0//jGRfhntcFy8S/5SWTkX1KdITF24iCdbhjJK+b
         vdFvq8R1EdmZEAWq+litzsvRUCvA1jKbnANtH1bb3QaxD1OQCnp+v/gdEnMEBcGvxpiP
         CDdA==
X-Forwarded-Encrypted: i=1; AJvYcCUlbThsNFBCNB5VIxu1s26I+kjT3/inya+QFRZdOqXLuWHzkHodiC+Eiwk+qAomB0xMOIq8r/0G+UIRUjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0zoqM5nIXh9JFgqCrqIP/HIx942wr3+5/PK7eePaNIZdFVzm/
	b3i6dkhzM/i+y2irTqEZNLtXLr6B0Aw016dd6xEKxhZqHJpp+4ynuZ4upuQB2wT69gE=
X-Gm-Gg: ASbGnct0q3xCcV2BtPWT3/WnYgsdXuBVgYz2WhvZVF+bR9y2upvoZ59zHdxgTdD/eIF
	SAWNlLRbSXHTpRF3PlAv+Inl8o5WhBrD7nP4Ds5AdA4Q9yLucUUU6G6tDCaNpTbO2/YUU7K42wn
	aeTFD/TABWIKNBOMIW+LF2bzLSAL1IhTwpoihFMx9/2yDIrABUsvSfB9jScJTlBNCuxQHjbEfGO
	oZHIjoSjBUSRSJhA5cIctntO6VvUiIn/hDlfL0ot6bwrCsET4az1jq/MMJDrRkh90K+E/4yx+n2
	trMvpSI2xD4SthRl+wPuLMvCg4QQp4HJmzDWANL2YxAvBdiR1u7mr0u1C8KPzuwwysw+IXqQKDI
	IStWrJf9c11ysHAXPZB63TWBBYc6kQPXqz2DuqiAvRe2w3MhrTFUAl1uXPIVc+8FCfMpqnz3410
	Ho4UZfzDQAdY1QOyH8Vx4RkWvigC7pJwvKUr7SQQ6HEhy3nWb5uNQ4LcT+kPy1a8KXI1+K82w=
X-Google-Smtp-Source: AGHT+IECpKLFUmLjNWELv2Vm5UCSytpZeRz/kU6StwzL1uQ1NedMDX8f/lYYWPod5BD9l7i7CF9NzQ==
X-Received: by 2002:a17:907:7fa6:b0:b72:b6ae:266 with SMTP id a640c23a62f3a-b72e036bc01mr885816066b.10.1762802948072;
        Mon, 10 Nov 2025 11:29:08 -0800 (PST)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d16esm1168178166b.35.2025.11.10.11.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 11:29:07 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 10 Nov 2025 19:29:00 +0000
Subject: [PATCH v4 17/20] regulator: s2mps11: refactor S2MPG10
 ::set_voltage_time() for S2MPG11 reuse
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251110-s2mpg1x-regulators-v4-17-94c9e726d4ba@linaro.org>
References: <20251110-s2mpg1x-regulators-v4-0-94c9e726d4ba@linaro.org>
In-Reply-To: <20251110-s2mpg1x-regulators-v4-0-94c9e726d4ba@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The upcoming S2MPG11 support needs a similar, but different version of
::set_voltage_time(). For S2MPG10, the downwards and upwards ramps for
a rail are at different offsets at the same bit positions, while for
S2MPG11 the ramps are at the same offset at different bit positions.

Refactor the existing version slightly to allow reuse.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/regulator/s2mps11.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index aff85138fa5da4cff83bdec5cdb3086a58afc7ce..d840aec236dcbdc8b460f89b4cd04e42e3b3da7d 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -561,26 +561,23 @@ static int s2mpg10_regulator_buck_enable_time(struct regulator_dev *rdev)
 		+ DIV_ROUND_UP(curr_uV, s2mpg10_desc->enable_ramp_rate));
 }
 
-static int s2mpg10_regulator_buck_set_voltage_time(struct regulator_dev *rdev,
-						   int old_uV, int new_uV)
+static int s2mpg1x_regulator_buck_set_voltage_time(struct regulator_dev *rdev,
+						   int old_uV, int new_uV,
+						   unsigned int ramp_reg,
+						   unsigned int ramp_mask)
 {
-	unsigned int ramp_reg, ramp_sel, ramp_rate;
+	unsigned int ramp_sel, ramp_rate;
 	int ret;
 
 	if (old_uV == new_uV)
 		return 0;
 
-	ramp_reg = rdev->desc->ramp_reg;
-	if (old_uV > new_uV)
-		/* The downwards ramp is at a different offset. */
-		ramp_reg += S2MPG10_PMIC_DVS_RAMP4 - S2MPG10_PMIC_DVS_RAMP1;
-
 	ret = regmap_read(rdev->regmap, ramp_reg, &ramp_sel);
 	if (ret)
 		return ret;
 
-	ramp_sel &= rdev->desc->ramp_mask;
-	ramp_sel >>= ffs(rdev->desc->ramp_mask) - 1;
+	ramp_sel &= ramp_mask;
+	ramp_sel >>= ffs(ramp_mask) - 1;
 	if (ramp_sel >= rdev->desc->n_ramp_values ||
 	    !rdev->desc->ramp_delay_table)
 		return -EINVAL;
@@ -590,6 +587,21 @@ static int s2mpg10_regulator_buck_set_voltage_time(struct regulator_dev *rdev,
 	return DIV_ROUND_UP(abs(new_uV - old_uV), ramp_rate);
 }
 
+static int s2mpg10_regulator_buck_set_voltage_time(struct regulator_dev *rdev,
+						   int old_uV, int new_uV)
+{
+	unsigned int ramp_reg;
+
+	ramp_reg = rdev->desc->ramp_reg;
+	if (old_uV > new_uV)
+		/* The downwards ramp is at a different offset. */
+		ramp_reg += S2MPG10_PMIC_DVS_RAMP4 - S2MPG10_PMIC_DVS_RAMP1;
+
+	return s2mpg1x_regulator_buck_set_voltage_time(rdev, old_uV, new_uV,
+						       ramp_reg,
+						       rdev->desc->ramp_mask);
+}
+
 /*
  * We assign both, ::set_voltage_time() and ::set_voltage_time_sel(), because
  * only if the latter is != NULL, the regulator core will call neither during

-- 
2.51.2.1041.gc1ab5b90ca-goog


