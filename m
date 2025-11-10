Return-Path: <linux-kernel+bounces-894007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5A5C49171
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333B83B10C5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C4433EAF5;
	Mon, 10 Nov 2025 19:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g2jxX/eM"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67332338904
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802954; cv=none; b=bYMMS4O6a/5AEHSOGdpYo9zS9Xep/4bf3dZLq9CyeieSAFlmWREnPvp5Y42QGZsOpSEsj4BQ7NNmYkDdDbcQ/D5pKPO+KpkDxEq4AmQF7huOWhBvYlcZFL4z+MWLhtdbpkM77CE8ayouymUwP4nb04yxRllEIMPhIcSl520ENHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802954; c=relaxed/simple;
	bh=eYixXJGVDTdDGMYyrWgNtepN6ShNQjaLw58PX+iYDjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VpqLFN5K9Lvn7UqL1m1ylFPQPiTzia2g7oWEfO9QWQdU4zM/Po2WPKoNWbOp1Jwp5hSw7NP5Us12NW23sWbf/hHv1wgOEaojYpBcmsqWdiJB1Pi+9aPTy9lg0Wxu19qGbj9EWOCTLkmO2z6tIXPM2p0UM0RgYw7iyIT+a5wU+Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g2jxX/eM; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7272012d30so629512366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762802946; x=1763407746; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fw7S55wozV8jZ+b5ptCozjuTZxOLQ9IoCnelwcEEJ6g=;
        b=g2jxX/eMjDunpBw0s6R7XkWXXwbUXstJrw7lON8/bNFHFDrPmq9F9IlSySFf62gbxv
         PMmVgIR0V8KvagjzqCIzU2sBqlI+d6cVB3Og3zrd37pdSCJYAr6y8GvfuC26hmMLJ94+
         5W9TTzsvzwjq9SpSfaeu3aXB6h5JOoNIJBYKRYStrwIHWz+QK7H6igzgFXF9Tqv9lNBv
         2a6QpdNh1EcoS0H5rJVGiWeSV8JzCW4D+SIwAl8T94UlRlo/BB+Y88jktboXMSjxCJEG
         ztXi3nmQqd90twEzUEIXZrmqm3m+g0uAt9jmqMqG/2tj1xR7BTrYD0p8xaw9qymfddZ+
         MtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762802946; x=1763407746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fw7S55wozV8jZ+b5ptCozjuTZxOLQ9IoCnelwcEEJ6g=;
        b=tYO1PDGcvsdNJ7sj5b+1PGIVJcrOpGNno2OkGKedYKGdB91AkFxFArJMAfUX94Lm8r
         0APSmzq/gWxdPTT0UlrYI8nK0Xw1ww8Y2R0npljgBawKWBioleJ+ScCeVpvGOqamsDGA
         VRHFqZIn1wLkbvuCSXdaWcljmItu1F/ExNkoyhxJBPJ1oT5i3Dy0MaRBQIxQR5gJ9xVA
         gU7hUs6V03U660jURvO2uXuKNNNmViZVBDJI2kSouvBAH32Px7Nhih26DMD9+J5FYugv
         d6gCDl2LL6HBIHaNrhBxAcr5EO97QAD9ISn8E5t4G91RdV+x8Oa1XhUVZqrcFUm8ks85
         ycsw==
X-Forwarded-Encrypted: i=1; AJvYcCXvg6+SlD1rpyu1MQGdlbAb13TrySEf93CsSJPI1nlI0CLSUO0NelKpG2XioSJ1YNVDg9cUrE4vkHGde1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeWc4dD7DS8/KV9zP9URR+QPMyKjc0Jtt20QPvfrZN8/jShVRm
	mFmFfXME9RHM3Je5+FeYLsPZIJRnkT7zt4+wv9f6qWzc/HJtYebjBqztitFQKX2AQ0Q=
X-Gm-Gg: ASbGncuolNBrjoJgopTdUy9JOEJArF8QBPPrr18xyS4Ql9Hag+wDDlB75qn0Md9v0V8
	4w2VT38wOqTyI4SWtiv9PW2nig4247LQ2icXxqexY+8agg+lvjdX5tEtXrCKrNd1XTWd4reWHRs
	BuH2Wz7R0a4HSXQINarMjBblmz90TKPgPmGgKRZpgK59lzh/DcFmnsGg8EICfwUIWYHdtndgb5G
	IbTIDTLoavMFhSbQKfVszFNNYWiqtBGsLMD61ZF0cxIm+n2dJ+jgaqEAbZLTtQJ7r0klF2JhcXk
	bRmI/8Tn4SXiF/W5/7qhh/7c1xlCYfmAITcZz5CA4PUO9HbtRRu0HQ1qv1j1bpDaj3eyyx52sWn
	KfmQ6TTTlDlfEaxYzHUIVY0E+LmMlaRloiztcKfVSHYHyIosU1ez9ULvl+sD/7fsjqrdjfc7yxn
	jHhKZlWmhh9qNrKvVnexN8O45zwP9KpPS+rVRBhn0KDpEe/EJO3XklsC+if33n9s4+f0n/AUc=
X-Google-Smtp-Source: AGHT+IEZS7ecosIDuABVvoBOB9FJ0YBGdAO5O/xjrZmOLhiVmbjmci3066c+xARZ4iRtS1uRrcnaRw==
X-Received: by 2002:a17:907:7fa5:b0:b72:d56f:3468 with SMTP id a640c23a62f3a-b72e0490addmr962983866b.50.1762802945969;
        Mon, 10 Nov 2025 11:29:05 -0800 (PST)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d16esm1168178166b.35.2025.11.10.11.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 11:29:05 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 10 Nov 2025 19:28:56 +0000
Subject: [PATCH v4 13/20] regulator: s2mps11: place constants on right side
 of comparison tests
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251110-s2mpg1x-regulators-v4-13-94c9e726d4ba@linaro.org>
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

For the lines being changed, checkpatch reports:

    WARNING: Comparisons should place the constant on the right side of the test

Update the code accordingly.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
2.51.2.1041.gc1ab5b90ca-goog


