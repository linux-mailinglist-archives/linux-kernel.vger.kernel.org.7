Return-Path: <linux-kernel+bounces-894004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 269EBC49168
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FEDF3AD49E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10FE336EFF;
	Mon, 10 Nov 2025 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ouyeRHYf"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAE933858F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802953; cv=none; b=GIMbz4kWtwRXiYI457UWFi6bUXDFcKst6WxCeo1sXQKB7v2hKR8MzoWfea0Regra0j+qP5xxgSD+wQbROWexfYBdM+tnQ7VCijcROzsNeKAhYG1/ItziNLF/wLgBWoz15YzDPcQTgfv00R6f6Da3QNQF5yixYKOzfT90TRL25CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802953; c=relaxed/simple;
	bh=QlgIZM6a8G7ebRRBr/Ymjzyq0EM2ZhxwbkcfrP/9WaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OsFu1QMzUarclGAWOUSNaQYprMPNeQCPNR7E44UOr/hQ5AAAiPvVit3fW3jLaZMldnfLLjrQQVqLPrMfMzBimsGAJYduGdcA1ZBcWOdrcftDUFWpUH3VhXRhFaGYMY0UL/fMeeVc+yKBrpPutxC5Ds/q/cVZmEcSM5p5toQcsAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ouyeRHYf; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b72b495aa81so379154366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762802945; x=1763407745; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zKonCPupUC+bG3BYmfoKbIV6pthcjc9BkK1iVxTRfG4=;
        b=ouyeRHYfaY0R0Ei9FUaOlbjh4ZAnqlZf7fSDPyt5fA0DXQZSrWa/OZORxLlcRtr0x5
         H+8s2r1YoWlQLFSoLtEzyjYdeKPbw2nPNJ0UyQwhOL/whm+5PhYG1IagxVLSXJC9god6
         1mqEXKKVAyyyARKA6F3ySTGGX1JguzyI/PAuQv7p5R+5zvLKABveJhfP1Y4iR+4ZnLZ+
         2zxGoCdGocXRChsGpxcWWWDVcq/oIX5HnifpbXMWeIPcMwb59yLIqTVAn0x8tqPbCFNT
         FnEHn+tC+PCWgoJ1la/zd3lVCEMFRnBS1lLNrCKfpZNzjkQLOhUjrs+RMrC5YfIRBJqN
         qTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762802945; x=1763407745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zKonCPupUC+bG3BYmfoKbIV6pthcjc9BkK1iVxTRfG4=;
        b=FjXf/RzDmSV+5oApE6Q7nd9xnljZiAWgzD/iUdUFXY4ju+QIK2OFDRDW4IDfiwagsZ
         TBZkXe1ZCMyhsgC+PRgVuy9Ry3VKQQxymQgJGtDVRncHMWtWfPvPWOYVWrufY181CU2B
         5lKggnzTGPTYtwYWCHboNnjqTh0fVkRLbQuiEzEjR55yENn/mJmV9SGxbOZba5dwNHfC
         tB85St/LBFU++fr6EdhGEyCa4Cd9TrX22k6q79ec39ig5fchrwRnL90+78I/7Ua/KrrY
         NmxUoQ3bpu+GpzRj91r+O4nhSJ+1VwZZAH6wy2UDTywZipG4eaFkYoa4yTtk6WtO0coY
         eQPA==
X-Forwarded-Encrypted: i=1; AJvYcCVZKzJhOlaLDARf+66tIDJwyQi7BsirdP5wEsBNkzaTH4DQ2GyHvTJY5NUHnaQA98ch2pqBWWvwdanHYes=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9qott5jYhiHYIiMbrm06VA3AtIZLqgcu2wSb2IcGGYSW+HP/9
	ygEz9o8piCpdHONgFUNHmoyMf5eep+mtDrz5t5MEu1cYr15snuGPW5P/UoQ68n2Dml0=
X-Gm-Gg: ASbGncuJh+eRu0XEx/lnzp+NDeiBltIO1vb02bdatiilpVeD8ucOOGb1vgy35sglrZe
	TQARU0RmyK6ES1JORQ6314wS0V9WX2TqJtwmagTOj9JYzQR4lcvHJLhSdu8W+/wSw/E0o388ezV
	k0mJFX4iiRroPsnCNDEvF+sne00arBN+oIsWlq8Jb5O7uqq4/dcNtTXQbqgikUYusifdBF32U9n
	CEGAPEcoOapCMxifKld2dvbFARKmIU2wxZWJwrcRdTPRs4/BKfi+ecItlxALYRV8+su4e/RnYdf
	eHeONQMhpPP7eisGdpOIh5fK8xTWgk6Egffi62SjQ+e/jV2g9201xGmIywuDYKKBRD0pc5e2SL4
	+33y9TQyF8TdcD6JASSE3ZVeCcUEL5aLYh51pwY9XA4FpZq6shf4SUQsD8Ed5c4BoCKkA80Fzdi
	9FwYvaV89twCF4baYTRapQgHgxGd17i0YYRNlXgxJtpRbwSmXlRP+8qUpM11RZjzUcMNAjlvM=
X-Google-Smtp-Source: AGHT+IGociUEXCMH9EZnqdHW6O6NvooD0NFgtcVgxLnNvsoTMYo5GwswgzK23CjfOBC+ZZdaBDycIg==
X-Received: by 2002:a17:907:9412:b0:b3e:e16a:8cdb with SMTP id a640c23a62f3a-b72e02944e3mr990967966b.12.1762802945515;
        Mon, 10 Nov 2025 11:29:05 -0800 (PST)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d16esm1168178166b.35.2025.11.10.11.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 11:29:05 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 10 Nov 2025 19:28:55 +0000
Subject: [PATCH v4 12/20] regulator: s2mps11: use dev_err_probe() where
 appropriate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251110-s2mpg1x-regulators-v4-12-94c9e726d4ba@linaro.org>
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
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.2

dev_err_probe() exists to simplify code and harmonise error messages,
there's no reason not to use it here.

While at it, harmonise some error messages to add regulator name and ID
like in other messages in this driver, and update messages to be more
similar to other child-drivers of this PMIC (e.g. RTC).

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
2.51.2.1041.gc1ab5b90ca-goog


