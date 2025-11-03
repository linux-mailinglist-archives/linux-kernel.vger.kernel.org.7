Return-Path: <linux-kernel+bounces-883603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AB4C2DDE1
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 78B0B34BFC9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBFC329C70;
	Mon,  3 Nov 2025 19:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HW+GLHzD"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF2A32142F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197295; cv=none; b=pP+YoRWNOBwznTdpJUgRx4n6E1TLwXBs4VERQ/MuOXgsSuJCsOp7yBGoiVyoS1aeXON5PQzZuv9QGFZy/cfZpPKXu3pAJUSWbAODlp4hI2JSpEdp5Hotd1Q0UrjTXnaK9waBVwrvmt0GsHv/r/ysDWZm4Q/bNIG6c3FJh95nB/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197295; c=relaxed/simple;
	bh=bNbZLBlOh8aHiChZU7kk7ga82xzwPKmO1X6PcccdfUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PspwI4iNQmPDXndHECH9+VB+EsC283p1DoU0XFAieSWJzTY3hYVhLS10AexfTFzSnf0x+GajFxEQfmW662WhGqUSpBZmXUrBtv3oawflZDOprJv/YQX9RA+l8ME4u1Y56buLBr25jtSmpIrrBRFkED0feTsCKdf3pLUXl7ogOms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HW+GLHzD; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640c48b3b90so1863800a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762197289; x=1762802089; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0KbWJf/+NZy5gbyur7GEAAJPtKRAWXvUdUh0UXe1eU=;
        b=HW+GLHzDs1heZTvQGhjDPks6XgQdIGeVQL7GZRlB6ED+ap/ILpz2tcZwxRCDk33HEI
         LGA5r7v+1AGw+5D//H16HaXfaJuS5WWCWJ9wfG6o8dxIFRxEf1II6ZBn5hNGDwqZ0qfc
         dBbNU/iaCDUzabf2QfrXRCWh199RlhSCxNZmgE0UWJuKIaRbm6iSpc5l5Oen2KPSGEqC
         g1pTUGAC+YdKV+SZj6bsnd4DD371oom42Nu9sRUKikWivW0oI5lLopskjzeCb6ucFwBL
         5i5mlWmavNhonjHyU9yGl8T2wV9HwebH2I55mt/L/goWxsDy3ahjJFuF23NeExyRvJKh
         0D9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762197289; x=1762802089;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0KbWJf/+NZy5gbyur7GEAAJPtKRAWXvUdUh0UXe1eU=;
        b=P+z3W+1+A1EzJ2upQjhZTM7LFI/Oq+JAZr1NQkXBgpo82wnVYJEZ8LGMeUuSULCBk2
         MGdvckoZdKvdOxtMPfRxImfTxbJ2Zs4i1UiLkeVs/ivnwqOset4UtNyOUvaMsNv26qP1
         VFrMVyvvF7grqUFWuHhH/K3cHM8tzEKyt2OSHcdzb5p/QACIO0Bs+Y+BXURSxOb+rUeV
         DNVDh1q6wqeTVos6/HglFxqGr22akalsyusfZ0gznRBknGee2PmmPgnM9YvBiPTGZMgl
         qrtXh7HWVrCYW/7+G/T6XKjyXnlYJj/PtDu9K7EC/H1naWk7Um0zBWFXwA5lCjJ7u4BQ
         jRyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8PGvyyZfdsofgD52z3Cs3GaY7gtrvx5TKMHv7yv3zx21PYZveFaXv7WY9HjfTP1gRyx/Pj1RMsidD5aU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk8NLI8Z4uQi8khExcPzIQKHo6A1+o9wtJrUNXPGec6QJv6tHE
	fwUWCJVm3I5fSjSGu4tAJg5gc8CwKyVizddryAqWJAsjHuH34+usjHyRKWaKOHgeHZg=
X-Gm-Gg: ASbGncvPiyqjC92rshYyKSkV/y4RI5SDriX74tT5eBup5LJwZTaEpzRNI5SisqDJQkt
	GPQgz7BHwBja5CFF80+nJWn4EnSiQZL1urUM7FDosY2rtAqzDbKs+iyMYG23weNHmWHFFbYgHC/
	uuyiP9KwqJYqQwkls7BQvNXXmVGjswBrCMnTvpoRP/Jczhh0bX+nrgOAmzz451rlQv9675+SY5k
	gdHiLQayZlKF3TL150XVnpihq8St7kIUdYStNRkcf//DQ6zvjlsCpTUF4FQmXxx3JlRN6+RDjHu
	01jJnWkPdl9+0uU5piasoVxqvk968v3uuBQ8eP6g9o8cAgzIe6QpRnfYakVfZRtntxpCQ75PHJP
	keffvOQA5g3R/LTd4GlZVs3Ysjag2eCmLIs33Cq3CBpQrXt2/JxHpD49Bj8hc0RCs2y2qmuB0P3
	jS7rRHXLBLq/nfKF+adgTdD1JdJBqv2MAa9anHyP34iXoMdKn02F3xTR+X9WxKyVU8diQRCgA=
X-Google-Smtp-Source: AGHT+IFfcf8kPIcx3o/lKhX8Dl2PmPr0jcmin5FgIW/unByF7E6CX8l3uCTtwQdjdzu0yG9z2ioa2w==
X-Received: by 2002:a17:907:7252:b0:b46:8bad:6981 with SMTP id a640c23a62f3a-b70701917e6mr1534994266b.20.1762197289291;
        Mon, 03 Nov 2025 11:14:49 -0800 (PST)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70b9f29c8asm466765066b.8.2025.11.03.11.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:14:48 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 03 Nov 2025 19:14:51 +0000
Subject: [PATCH v3 12/20] regulator: s2mps11: use dev_err_probe() where
 appropriate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251103-s2mpg1x-regulators-v3-12-b8b96b79e058@linaro.org>
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

dev_err_probe() exists to simplify code and harmonise error messages,
there's no reason not to use it here.

While at it, harmonise some error messages to add regulator name and ID
like in other messages in this driver, and update messages to be more
similar to other child-drivers of this PMIC (e.g. RTC).

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/regulator/s2mps11.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index 1f51fbc6c7b6e158f9707c04d9f030b9eee5e842..30586e9884bfb998ff07e3148813344b307506c0 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -1249,9 +1249,9 @@ static int s2mps11_pmic_probe(struct platform_device *pdev)
 		BUILD_BUG_ON(S2MPS_REGULATOR_MAX < ARRAY_SIZE(s2mpu05_regulators));
 		break;
 	default:
-		dev_err(&pdev->dev, "Invalid device type: %u\n",
-				    s2mps11->dev_type);
-		return -EINVAL;
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "Unsupported device type %d\n",
+				     s2mps11->dev_type);
 	}
 
 	s2mps11->ext_control_gpiod = devm_kcalloc(&pdev->dev, rdev_num,
@@ -1290,21 +1290,20 @@ static int s2mps11_pmic_probe(struct platform_device *pdev)
 			devm_gpiod_unhinge(&pdev->dev, config.ena_gpiod);
 		regulator = devm_regulator_register(&pdev->dev,
 						&regulators[i], &config);
-		if (IS_ERR(regulator)) {
-			dev_err(&pdev->dev, "regulator init failed for %d\n",
-				i);
-			return PTR_ERR(regulator);
-		}
+		if (IS_ERR(regulator))
+			return dev_err_probe(&pdev->dev, PTR_ERR(regulator),
+					     "regulator init failed for %d/%s\n",
+					     regulators[i].id,
+					     regulators[i].name);
 
 		if (config.ena_gpiod) {
 			ret = s2mps14_pmic_enable_ext_control(s2mps11,
-					regulator);
-			if (ret < 0) {
-				dev_err(&pdev->dev,
-						"failed to enable GPIO control over %s: %d\n",
-						regulator->desc->name, ret);
-				return ret;
-			}
+							      regulator);
+			if (ret < 0)
+				return dev_err_probe(&pdev->dev, ret,
+						     "failed to enable GPIO control over %d/%s\n",
+						     regulator->desc->id,
+						     regulator->desc->name);
 		}
 	}
 

-- 
2.51.2.997.g839fc31de9-goog


