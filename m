Return-Path: <linux-kernel+bounces-673449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE381ACE16A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 17:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A610B7AC3B6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 15:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBF81F3FE8;
	Wed,  4 Jun 2025 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JWyNo4QV"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042F51CB518
	for <linux-kernel@vger.kernel.org>; Wed,  4 Jun 2025 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749050759; cv=none; b=ROXc0YQRpLAPbqp5VaJzYb88UOg5blsZNTZ7jFt+6TUfanerx5Y1IuY8tgg6zSkCOqH6fGhydydPb63LO+zyM9WUfrQK7Sux0X1SzA6+aHpuby+z7GbOmIIulKiMONTgWzIfHLfd5uvp4y/MPbRI7rfuctMTYoDfTUFL39MMpA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749050759; c=relaxed/simple;
	bh=gpRe8Mt5ndzq0RKdCAcP7CMV+rBpHJ84dXjPHbGOCWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KouNmJZ6dtbCv1xtV1WA2clWSNtgheqDI0q+g88yIfr0CKAokPR/0bRoZodUI3Mms401AgMNAXBclLJHEjCVtLwtLjn+0jzoqgbD/fffTRDW1kzxgJ/ooqFzozxsV4ttNc4I3XYOEWShKNcaWiQ7rth9l0a6+qUBPq0T5HzXdrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JWyNo4QV; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-606bbe60c01so3622913a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jun 2025 08:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749050752; x=1749655552; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pP407Ox1v91FomL1iN4XwON2iK1j8Ht0T+AJfPsmGsI=;
        b=JWyNo4QVZIiV/llCGZCM/mgWS16dQa+u5O0J+eiD3dCtp+m7GzBDEQvyLhqG+2YydU
         /QyvammoVG7aUvB4VKOSk5vEKxU6GMTYB8umvneqZvV7RdnEYNWNHWnBlO3xmIeTGZbO
         RQbVOnvW6MK0Vi756tSP0vBj3UsGVLmCrOn1DtIkgCH7V/Oz1aUmOCEuqZWNizxDHAYy
         qUYINT5xs1BEQDBLrsWe9txed0Kz6oZJNOYEU/eMOP5Rs5vLlAeaYYObfkRN5OHURJz7
         jASrHNvktcVd/LSzifi/hm9jt1Dm+eVaGg1z4o4kWF/qxhUx8MCWhfm+WaYMhNTA+hbz
         6L1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749050752; x=1749655552;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pP407Ox1v91FomL1iN4XwON2iK1j8Ht0T+AJfPsmGsI=;
        b=CYOmyznhLXUrcwbhXXyolnlbtqduFU55XetS3MQMI6rHT0baUrnJtCb/UvCMY13CGl
         wCS+zFxusu13MDHzU5RnRZdTvjTqLB4qFFsR9B3Pls6ytA04FC0xassBVD1d3nr6wx3V
         GruXDc5uHupZNplda0VpxcGtrektZplJ/BfxOm4iCMETcks9AJSA6JPAspHGuVW7ITPr
         YWF19NBNtIhNEwxTOhio/qV4uF5bJQpivFjoKKFejma3x+osMMc0LB6O4k3264P5/D31
         EO/WUxkMFKIl/ySxDfOQMR2vv9H/wJ9P53xGlqurlUNl/fdcpTaJye4W8ItQFFfiIQQR
         JXRw==
X-Forwarded-Encrypted: i=1; AJvYcCXPOMajALurZNFRrOwq8anUGwGPb8MlHKD0jPer/hxfhFSIMWVgjg4D6lxXMOflBFKsyYnmVLibLRm2oK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKffaTdBTnkGqZXryLQ9c2Ssrizv2GP8VpelpVbCz7sCgsOKPd
	Lwd4Eo2cGzF5iFOqsDjNDYC9g2r6RVPGklGnMhGY0pHnNfT/af1cWyv8/kMRXZKAee8=
X-Gm-Gg: ASbGncuU3sPjkr00mtbPUMkXWAPIAyro7EzIX3tecT7KmgBIQOjHrQ+Y7esD8XRLcl6
	yoOR3EKTAfF2hxBEcIt1HBqjP+ZZZFv637LtGAKQ99/7p1AForRyiok2gohvBWLn91hmzVfFCTi
	pSZa8iqS/6mF6t7BKaluybMgH+KtUNS44fjWkM+ocjxAlSxpa0f4KT2qXZAQ3LTlm4uTdPtGe1F
	QFxBlex45Wk9iwrgGYhIsASsE5nSHhl90chAg3Bp5Lj0DNHx4QtNPPM0YJqp4ADvgFOecbd1iMp
	DrQe7csjSF/swc31K/fgOnuijslDJYSOaT+NwAgTzrEh1fFOrJZn/1J1wQHdZMUzA1Uvu0/ml0e
	V9nMe7Y97pfM51EfYSA2ugmWOQIeSGY4bkA8=
X-Google-Smtp-Source: AGHT+IFc62NxQDrp6Fd0aN6PA4dvCy44jt7oi4p68WSn0L0ytJoyIqbFgJ8vuOoNN2SWezfzZwIZWQ==
X-Received: by 2002:a05:6402:2789:b0:602:1b8b:2902 with SMTP id 4fb4d7f45d1cf-606e941b388mr3458933a12.15.1749050752175;
        Wed, 04 Jun 2025 08:25:52 -0700 (PDT)
Received: from puffmais.c.googlers.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-606ed984f63sm1051640a12.58.2025.06.04.08.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 08:25:51 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 04 Jun 2025 16:25:51 +0100
Subject: [PATCH 12/17] regulator: s2mps11: refactor handling of external
 rail control
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250604-s2mpg1x-regulators-v1-12-6038740f49ae@linaro.org>
References: <20250604-s2mpg1x-regulators-v1-0-6038740f49ae@linaro.org>
In-Reply-To: <20250604-s2mpg1x-regulators-v1-0-6038740f49ae@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Refactor s2mps14_pmic_enable_ext_control() and s2mps11_of_parse_cb()
slightly as a preparation for adding S2MPG10 and S2MPG11 support, as
both of those PMICs also support control of rails via GPIOs.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/regulator/s2mps11.c | 86 ++++++++++++++++++++++++++++++---------------
 1 file changed, 57 insertions(+), 29 deletions(-)

diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index d3739526add3c966eb2979b9be2e543b5ad9d89a..ff9124c998c685d9c598570148dca074e671a99b 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -328,27 +328,13 @@ static int s2mps11_regulator_set_suspend_disable(struct regulator_dev *rdev)
 				  rdev->desc->enable_mask, state);
 }
 
-static int s2mps11_of_parse_cb(struct device_node *np,
-			       const struct regulator_desc *desc,
-			       struct regulator_config *config)
+static int s2mps11_of_parse_gpiod(struct device_node *np,
+				  const struct regulator_desc *desc,
+				  struct regulator_config *config)
 {
-	const struct s2mps11_info *s2mps11 = config->driver_data;
 	struct gpio_desc *ena_gpiod;
 	int ret;
 
-	if (s2mps11->dev_type == S2MPS14X)
-		switch (desc->id) {
-		case S2MPS14_LDO10:
-		case S2MPS14_LDO11:
-		case S2MPS14_LDO12:
-			break;
-
-		default:
-			return 0;
-		}
-	else
-		return 0;
-
 	ena_gpiod = fwnode_gpiod_get_index(of_fwnode_handle(np),
 					   "samsung,ext-control", 0,
 					   GPIOD_OUT_HIGH |
@@ -380,6 +366,28 @@ static int s2mps11_of_parse_cb(struct device_node *np,
 	return 0;
 }
 
+static int s2mps11_of_parse_cb(struct device_node *np,
+			       const struct regulator_desc *desc,
+			       struct regulator_config *config)
+{
+	const struct s2mps11_info *s2mps11 = config->driver_data;
+
+	if (s2mps11->dev_type == S2MPS14X)
+		switch (desc->id) {
+		case S2MPS14_LDO10:
+		case S2MPS14_LDO11:
+		case S2MPS14_LDO12:
+			break;
+
+		default:
+			return 0;
+		}
+	else
+		return 0;
+
+	return s2mps11_of_parse_gpiod(np, desc, config);
+}
+
 static const struct regulator_ops s2mps11_ldo_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
@@ -903,10 +911,16 @@ static const struct regulator_desc s2mps15_regulators[] = {
 };
 
 static int s2mps14_pmic_enable_ext_control(struct s2mps11_info *s2mps11,
-		struct regulator_dev *rdev)
+					   struct regulator_dev *rdev)
 {
-	return regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
-			rdev->desc->enable_mask, S2MPS14_ENABLE_EXT_CONTROL);
+	int ret = regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
+				     rdev->desc->enable_mask,
+				     S2MPS14_ENABLE_EXT_CONTROL);
+	if (ret < 0)
+		return dev_err_probe(rdev_get_dev(rdev), ret,
+				     "failed to enable GPIO control over %d/%s\n",
+				     rdev->desc->id, rdev->desc->name);
+	return 0;
 }
 
 static int s2mpu02_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
@@ -1244,6 +1258,26 @@ static const struct regulator_desc s2mpu05_regulators[] = {
 	regulator_desc_s2mpu05_buck45(5),
 };
 
+static int s2mps11_handle_ext_control(struct s2mps11_info *s2mps11,
+				      struct regulator_dev *rdev)
+{
+	int ret;
+
+	switch (s2mps11->dev_type) {
+	case S2MPS14X:
+		if (!rdev->ena_pin)
+			return 0;
+
+		ret = s2mps14_pmic_enable_ext_control(s2mps11, rdev);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return ret;
+}
+
 static int s2mps11_pmic_probe(struct platform_device *pdev)
 {
 	struct sec_pmic_dev *iodev = dev_get_drvdata(pdev->dev.parent);
@@ -1314,15 +1348,9 @@ static int s2mps11_pmic_probe(struct platform_device *pdev)
 					     regulators[i].id,
 					     regulators[i].name);
 
-		if (regulator->ena_pin) {
-			ret = s2mps14_pmic_enable_ext_control(s2mps11,
-							      regulator);
-			if (ret < 0)
-				return dev_err_probe(&pdev->dev, ret,
-						     "failed to enable GPIO control over %d/%s\n",
-						     regulator->desc->id,
-						     regulator->desc->name);
-		}
+		ret = s2mps11_handle_ext_control(s2mps11, regulator);
+		if (ret < 0)
+			return ret;
 	}
 
 	return 0;

-- 
2.49.0.1204.g71687c7c1d-goog


