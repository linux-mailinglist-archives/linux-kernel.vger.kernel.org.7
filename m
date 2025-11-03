Return-Path: <linux-kernel+bounces-883605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21704C2DDF2
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23B124F48BC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14C8329C77;
	Mon,  3 Nov 2025 19:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vntm4ms3"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0973164AF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197297; cv=none; b=GC+dagxC1AKL7O+gKlUu/9jdf/AMsQv+YRf6sT1LXbnfqCjo74VZvRtOuEdNnjEWlbQ1KYi+/0Zz8NWxN0SgodImyij8qlYqVHwUKBEEK6Yi8H36EelcxAmIeaFpTQWm8rAatTE5Svj0NgZ4ViQRX+cX3TT+fmSCbPWiFAlqOE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197297; c=relaxed/simple;
	bh=stmeLWCyvE+ndp9fyCdhqthj4/jP+eCyMDS73hUiVTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dIfIuISuSIMqpaIvYBqL2sHp49O6YZcgHINPpmoQaLBLTxti2x93bYcxeu2xqp/0Dkj7ys0Dd2DFe2P4g+2JHo19CEF4QcHl/W/6adb3ng3R0kutQ7DwtNq0d3jIEQ9YDYjHEyAN1x6Mb6Or4XYs9oUxXQkKqauUI0V/khZsovk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vntm4ms3; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so5892038a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762197291; x=1762802091; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E8tWS8cFy4ocvC9wnSQAr/3WpkgY8Vx4Z962opSddEs=;
        b=Vntm4ms3bC0suKaKAKu/wzNZTPx4onWeo06TaKyX4bI238OobL8/2yU+03V2kP3C5X
         YnHWTw1fsEcitIx2d5jH/8f047sAoh61Di3f/mT5KmUbD6LfDd8L9k7fb5Td7/bfrMWI
         g9O2PZfRxq+iThyFc7+jP6tfhxvnJ5gXMN/aDOwSbPLekDk8IZD2tND0ImC0gjxiw4sp
         bUOR5W0cff1GtXkHbFmDJZ7fJ5FTrzKS/vocon9NZDDYcaQrqQIokY73OFQmMO/oVZXs
         bintxIdBR6Xkg/yhpl26NFN0yMgx0awVU5OIHn4eFoWDvJl7iwF6oNezcu85fvvo3a3/
         T8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762197291; x=1762802091;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8tWS8cFy4ocvC9wnSQAr/3WpkgY8Vx4Z962opSddEs=;
        b=w4YldISFA6/9DOE3EHM9GTEUIRS8a+nly/0Cp3OrSYKcOqI15DKx+7tzXIguEyNlhz
         OI8Y+5eIaqKULheH6LxodRFnx+xMRbMhyf02bTFQxJR/uaElhHz2Za+SK2MhmDFbNzVT
         WhMqgBeQiO+iPnMm8btsUHkjDOjWv/Os0uQoKmiS6K4vwOgUwAnWk1yqBOAnAOoKIss4
         ZYpTsjxFqrOa6WXMRWKuR4DWOOP8B4kl93y0FUq9kGw+guYeP/y9TLE/5k5JOPs89+Wd
         hCX4bOLCnRry7NciSY+gHP0Yxjo2rys/ZdS9eOZvwSyfzB6NikM8pXwyXvUHPyYRCs8V
         /i0A==
X-Forwarded-Encrypted: i=1; AJvYcCVi7ErAtRIeDNjzIFlm+S2WwPSiOV4suQX1RjloJpMH0auEbh5ctevYtYtvklGqFFh0WRPDNdyMr78ZG3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwJYmGF1wlA1ase6G1wqpIufJEpZ95pMfsSGKcfTI1ARRPiFCn
	HbCu3+nq9aCU/84mIpVY9C2jhdK6dRwNjkK7ayogqfXWjUS1PcS0iVqgbq+4R7/cQ2A=
X-Gm-Gg: ASbGncsQU3vNSll5+d1BMXjrp8W3VG8y6on9bsl8d41ZNsITGg0xlLY7p1oQxukHgSj
	yFweDhnhm5RKBn/uoyAnrn9Hy/Qz/cvxSFT7IJIDBfxKMz2kRAlqnB/boWTMqIbR/j0TZLISilh
	/rfOvlYKMNTLvaT/xs5bpA+WJpYvmQuqh2c0xSGlhCpPFqWk2/6gsXI/xIw3dTqq0qaMEt1j0IG
	aR+J27QLVFXvBBfEOyQOU4Njh3PVQOLKI1TYy9mXuZlAv7Wy8ZTqNYpMPDH5uFxBysvTXMMVm29
	Y0Eb0SXD6F+woV6/w16+E5I9rqWP7LMF63JGArmnPkgX+m9jpEYuCrdc+h+tHBXSnKaVw/m+eUo
	posenW0zgOrYQSjAS3Z8K5+AFG5es+/vheBFdY8JDMWz2/EndloCiu6JLFrBnAeqYjecya2gAGG
	6UkwBEi2BH0gpo8EJDkv5BPIu8iSZX4wqyXBkuhaYH/FLTuF5dmh1Bpg9JHhRf
X-Google-Smtp-Source: AGHT+IHj4Yfe90Bxd+t/ZeDrhCAfV9o3nFQAjRa3TrLPc9HMD49nPALHVBv3VRToSfNQer8bJnWldA==
X-Received: by 2002:a17:907:7e8d:b0:b6d:8ce4:ff18 with SMTP id a640c23a62f3a-b70700bcd6amr1422759766b.9.1762197290671;
        Mon, 03 Nov 2025 11:14:50 -0800 (PST)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70b9f29c8asm466765066b.8.2025.11.03.11.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:14:50 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 03 Nov 2025 19:14:54 +0000
Subject: [PATCH v3 15/20] regulator: s2mps11: refactor handling of external
 rail control
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251103-s2mpg1x-regulators-v3-15-b8b96b79e058@linaro.org>
References: <20251103-s2mpg1x-regulators-v3-0-b8b96b79e058@linaro.org>
In-Reply-To: <20251103-s2mpg1x-regulators-v3-0-b8b96b79e058@linaro.org>
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

Refactor s2mps14_pmic_enable_ext_control() and s2mps11_of_parse_cb()
slightly as a preparation for adding S2MPG10 and S2MPG11 support, as
both of those PMICs also support control of rails via GPIOs.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/regulator/s2mps11.c | 86 ++++++++++++++++++++++++++++++---------------
 1 file changed, 57 insertions(+), 29 deletions(-)

diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index 88e21c90832a45547e5791b15cd1de274f81fed6..bb0a4f35ef47551f7171321fdde2c0202ce86ede 100644
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
2.51.2.997.g839fc31de9-goog


