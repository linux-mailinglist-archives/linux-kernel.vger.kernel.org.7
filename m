Return-Path: <linux-kernel+bounces-883602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240E9C2DDEB
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B1A3BE96E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6AB329C74;
	Mon,  3 Nov 2025 19:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sjj7sVM6"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AF532255D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197295; cv=none; b=ovGswhNRwyigDC9/q8hjLp0GStAed9eL7xkc7PcDPN//H9k3nlO5p7FoWbvDlkfStGQnJBJBo9+0xQCXyO2oJPdDEzqT6LJrfVFz4UCq+UvcMIyY6tLTafxuFEQtwhlexN9bN6R9YG2Do3gPHLTZIY4G3me4kB0+mTAktVxofzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197295; c=relaxed/simple;
	bh=Ep9VqpEEy3DliB6wfxhwC677Qa8a8OVz72OQ5z6O6l0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ceDw7AjDsvo2eCh53nvd1JNFHVHKaRsAZweQUXUDZct+KjTETHkcLJX3YNEVGD246JrHodDVD30C3DdZyf2UEzBvwU6HfdLgSGhgMaLxTPVq7AugpRx53byjbr9APLOD+QPDKQ9xubEWVVI473h6LDaEscR9u6qptufOKX1YIgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sjj7sVM6; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b70fb7b531cso199721966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762197290; x=1762802090; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SymEZu7KuHsaR6tBK8LZYO8ms6zJrn1970mxvhHuMAU=;
        b=sjj7sVM6/8Fza/KZuuC2AN8YVBBK9X4gEhsfcpu1MefXjRwQQoUe/QKwSRsHVKqQcz
         O8842sftNZB31RSBnKdMuCRsAJCXxWa1UgTU/sttOZSBEYrXuRaDZNg2+R9fkGborXHo
         HSzQRzufhZj1gQ6Ha+5xg9LTxw+qMWw0R2DOsmg/M+lZj3q+Paw3Lm2LSviRzVnCW1+a
         3rOvvpXkI9XGLVJerRZhMXToEGKYLmq1T2/CmRJbB5CjmEbGuxKbn9+KJeSuAI8KJLl5
         F1hFlolZvKH+QzQ18Ifu05nVE3gCRgHsRbIkBl+d0nIMU4cfHItlYLD1/GoaG8Y6fTor
         YhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762197290; x=1762802090;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SymEZu7KuHsaR6tBK8LZYO8ms6zJrn1970mxvhHuMAU=;
        b=MvtM9hyV3WYPWqp2cGPZsQt3auMU1wlNVJ6QkWk3TjWr57S3t4RAM1tviXMN1rW25Y
         eSMa8ddwqxYNSshngK+hsZv0SDQ0MBmU8mkioeu3gU5YdiXEA7kDfRDfFdTq3a0mqCLW
         BUbCltry5/Vn9ssIb8k6lgGZkr1/bgwTMnFKb6a/t3flXQecQE8r04iO+Nkisokv0Uzg
         +NZXFN9RB0Rd5cIyYkxRc3xVfqEAn+RZuF8XLw3OI3hTLo3K1xoEUzIbxqcSwG90hhKh
         UOPc1oJYJ2gvIZZm6KEuYHTMP3r/7L21KnRGlakuiLrZRSiuAraV3V43EfvPlWYYWJgR
         PSkg==
X-Forwarded-Encrypted: i=1; AJvYcCWbfKakMr7i6XSzJsn0/SQu32s7kduvg7QzUvDDu1GVzSZdQ2/sMk+IRqVy3sjWkkRUn/4jL0O4+y8HXEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOV/Qb7O72zUXyEMXNMDoGKVJC+my6RM6NY3fvk0XHl6HHW+4K
	loBEmLzCMWg8y8ONLBzhL9dZ99wPNKMgHCl9rbXslmbZEyMv753vj8GYMd9jdZxj/uM=
X-Gm-Gg: ASbGncvDJA372HrWmqezw6JPgM+48JmBXCnWou32euhQZexNVqKCJcuSG7n7ZZICfKU
	wp1q54GDbKqFWWqPkq8BkOq8w/JLk/9UleIpQ0x+GpdxTIj3L+pqIgglIimkOHVfrP0psoOCNBS
	W38SIxD4JQBW4hOarRY15E7AicUjIx9YHBwFvP+eIdG0Bz3QYXS+b7s0y2KH5yOTwyNb9sW250k
	JaJA7MP9WxJDjp5U0oIurHt9m5PNglDy8orN7bfvYaQe9T2VyqGH0R91rx0HOfSq3nVpR7/kzoH
	N6B2T8Xc7tm+o7AXcSKr4EzrDPvqXuC5/5Qg9U8Tn4vXN83T2p9ifZBknXQppbsdLLhX597ZKJZ
	0Q0cPYaGB+0r3lSZkoYnDdrpeoDRQOOEI1KgiqTzjFnnt7A4OCZlK1+sLfH+2tD7RC+E7ODDVla
	ipoaIaMupLdMXFHJgZvaeddBO+AzJU0DsvDu1p0sJWPxEeM7vwm5gOrLMxQFN2
X-Google-Smtp-Source: AGHT+IFuubeogvRryabHYkXen2w1TOoix4qArdOV/ufZ8vU9XKqBaFFhwfEA0gbZhZn3sytwpzWIDA==
X-Received: by 2002:a17:907:3e91:b0:b4b:4f7:7a51 with SMTP id a640c23a62f3a-b707089cceemr1365761166b.62.1762197289732;
        Mon, 03 Nov 2025 11:14:49 -0800 (PST)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70b9f29c8asm466765066b.8.2025.11.03.11.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:14:49 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 03 Nov 2025 19:14:52 +0000
Subject: [PATCH v3 13/20] regulator: s2mps11: place constants on right side
 of comparison tests
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251103-s2mpg1x-regulators-v3-13-b8b96b79e058@linaro.org>
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

For the lines being changed, checkpatch reports:

    WARNING: Comparisons should place the constant on the right side of the test

Update the code accordingly.

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v3:
- new patch
---
 drivers/regulator/s2mps11.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index 30586e9884bfb998ff07e3148813344b307506c0..8a36ab67b73e4151c7f67af0555a6465ee1e7a04 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -1221,32 +1221,32 @@ static int s2mps11_pmic_probe(struct platform_device *pdev)
 	case S2MPS11X:
 		rdev_num = ARRAY_SIZE(s2mps11_regulators);
 		regulators = s2mps11_regulators;
-		BUILD_BUG_ON(S2MPS_REGULATOR_MAX < ARRAY_SIZE(s2mps11_regulators));
+		BUILD_BUG_ON(ARRAY_SIZE(s2mps11_regulators) > S2MPS_REGULATOR_MAX);
 		break;
 	case S2MPS13X:
 		rdev_num = ARRAY_SIZE(s2mps13_regulators);
 		regulators = s2mps13_regulators;
-		BUILD_BUG_ON(S2MPS_REGULATOR_MAX < ARRAY_SIZE(s2mps13_regulators));
+		BUILD_BUG_ON(ARRAY_SIZE(s2mps13_regulators) > S2MPS_REGULATOR_MAX);
 		break;
 	case S2MPS14X:
 		rdev_num = ARRAY_SIZE(s2mps14_regulators);
 		regulators = s2mps14_regulators;
-		BUILD_BUG_ON(S2MPS_REGULATOR_MAX < ARRAY_SIZE(s2mps14_regulators));
+		BUILD_BUG_ON(ARRAY_SIZE(s2mps14_regulators) > S2MPS_REGULATOR_MAX);
 		break;
 	case S2MPS15X:
 		rdev_num = ARRAY_SIZE(s2mps15_regulators);
 		regulators = s2mps15_regulators;
-		BUILD_BUG_ON(S2MPS_REGULATOR_MAX < ARRAY_SIZE(s2mps15_regulators));
+		BUILD_BUG_ON(ARRAY_SIZE(s2mps15_regulators) > S2MPS_REGULATOR_MAX);
 		break;
 	case S2MPU02:
 		rdev_num = ARRAY_SIZE(s2mpu02_regulators);
 		regulators = s2mpu02_regulators;
-		BUILD_BUG_ON(S2MPS_REGULATOR_MAX < ARRAY_SIZE(s2mpu02_regulators));
+		BUILD_BUG_ON(ARRAY_SIZE(s2mpu02_regulators) > S2MPS_REGULATOR_MAX);
 		break;
 	case S2MPU05:
 		rdev_num = ARRAY_SIZE(s2mpu05_regulators);
 		regulators = s2mpu05_regulators;
-		BUILD_BUG_ON(S2MPS_REGULATOR_MAX < ARRAY_SIZE(s2mpu05_regulators));
+		BUILD_BUG_ON(ARRAY_SIZE(s2mpu05_regulators) > S2MPS_REGULATOR_MAX);
 		break;
 	default:
 		return dev_err_probe(&pdev->dev, -ENODEV,

-- 
2.51.2.997.g839fc31de9-goog


