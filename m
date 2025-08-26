Return-Path: <linux-kernel+bounces-786382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834A6B35916
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7070171047
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBD132143A;
	Tue, 26 Aug 2025 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Lob6an2u"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439C531986F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200920; cv=none; b=R2mggDyLqE9KcDdfpeDPkOpmjuD31WJjNEJ2Ql0TWE9sA/jlSXsC4DugJYRksR6SGlEUBXn4J9o9zVsEeYtGvU4tJKT4nG60VPZeMOkxc1sxMvWLsuzD9GGWrlntS8x7FRf9hFEvxubbw4emx2ouWj7YzkPDUCjdKtHqsqWLIXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200920; c=relaxed/simple;
	bh=eJYObQcFDw7m310+2ZfUoUQs1zqBlwtoyN+n2YWx1X8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Iz4mXgQDFG1Z9AsQyZsxzPCnTB3DkPsqlZS23zHW+244vbXxG0iU66NcHXF2wP4flROnPaOBrcxFFzbxjhLmYWDOwuavVLrUVcsdnltxNlpT/r8yI3DYW4qOB+ta6Mz/epMgj4RiVfS5bzNS8qIjNb1738hO8AFB3Pxh91gXC2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Lob6an2u; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b00f23eso31261765e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756200916; x=1756805716; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o6UVlAeR3fwHCFjy4a5d3B3zx2pe4QnNId31mWH7HxM=;
        b=Lob6an2uBcBMUUKdEPFqRiaRjeKO2kghVeB7r9edvceNOPuMPrchYMxTVLI3KLyvmF
         ai0QMnS3DGvVHOJaCevNyn2do4chlpHTZiXlvIl+bP6HqgYslKhHcZInqMbbIHiCJRMz
         9E7D48qTtQl/8/OPqvIdsY0++olmGwdNhuvrJ3kJ1pwryQD88wmNeWSV42b/KY0c+xkf
         IFO8tBetq6OCKVoYfhy4/Q48SDIx8hERhvujNAdKx/RdXuAoozLtV9nY84T0FTEb7TAK
         5b6KsQs2NYlIvR4F8AbzI4pjs4jBBzK9v6c5F1ex1PeQFlz1DtbtMvkRpYMOUd4XuzfP
         wcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756200916; x=1756805716;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6UVlAeR3fwHCFjy4a5d3B3zx2pe4QnNId31mWH7HxM=;
        b=bh3JjtDOkTh4VdM2YyBIN6NjZ/hpwaB3mjEyDhgfR6o3GVS0OUWhZgoCfJZkgKHqPY
         qupgCSRTCUJ40FQ8FeeDh7kpbLUduDkE703G+Dl/ulR44DLlsAX6Bdsgi2ZyLEy3zYWs
         9jvQbyMYcv6jqBFyqCttykY0NBfd7OrkzAOS+jdaT09qpJeG/5qz0Y0AAxKc5lBlMtuX
         UY3NTWnXqhXNoLzkrLNW7I31XTH8THwnc5vU/N4mwXhoMRcZP5j0M5Uy3WB6mlB9Zc1z
         z92UTWwF7PlUFB0/aF+hWyXmObLtNZBZwe68un7HvB+F9iHC5Z73sy1kEkxiAttihyr6
         pCkA==
X-Forwarded-Encrypted: i=1; AJvYcCVBX26xp3Rklw4sXejqVGQDvL2Png2etyG9nTZSJu0+7+12sJqwRu6Kul0NhY1fx2P+M7B3ZHtWH8+FJRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvNOgfLBKGLFUbf3MkS0UEiGU5uzufkTB3Bko7Z9cgvDQvxra1
	T1scLJj39z0WejLRGTwSF8t4H6Mug3vcPx7Xz/mHtQG1seUjgeUQU+jT35O6nX3xcgQ=
X-Gm-Gg: ASbGnct/J4AcW1wDmYI6F9LOKJI+ng4TfsNJQbV3WHoF1utCBJNBtt0GQhFoqd1pngI
	IrUNBijNUSV7TIMfARr10xcZR2CBaUSFPdgva155+vmjz4WVmfq6G/8mDI/xL+r2l9u7he5/Qjg
	dix5OlwRUa2jAhXVa7urNFqu43iQ0+v/DkiWQCn9uh9+RZ9PEFLKPaE1cFR74k28hHEHt8dQyDo
	y9IbjugX2labGCbtj76uFc/wTf4DPAvcnslhAKOi/B3nLCR340rw+krUNR86ExzuEyrmJwxfyWr
	ENPFBekbblyf+xVZov9jbtQRDN5bzeDES8z9U52NYuPtfZdJT/qiWgDxHuKuEkJKCA+rwpqnEZI
	LHeS4pTQwBmISAevx
X-Google-Smtp-Source: AGHT+IHHMs8HHGoX5pQrBguiSZlF9A3BQe4UKuEJbCj0cIrDBD5J1SUnyxSXmIGXuAVtd2TxeU4iVA==
X-Received: by 2002:a5d:5d0a:0:b0:3b8:f358:e80d with SMTP id ffacd0b85a97d-3c5db8ab097mr12681160f8f.5.1756200916017;
        Tue, 26 Aug 2025 02:35:16 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:fed4:79fc:9440:6629])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7117d5b10sm15308255f8f.47.2025.08.26.02.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 02:35:15 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 26 Aug 2025 11:35:05 +0200
Subject: [PATCH 04/12] gpio: mlxbf2: use dev_err_probe() where applicable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-gpio-mmio-gpio-conv-part2-v1-4-f67603e4b27e@linaro.org>
References: <20250826-gpio-mmio-gpio-conv-part2-v1-0-f67603e4b27e@linaro.org>
In-Reply-To: <20250826-gpio-mmio-gpio-conv-part2-v1-0-f67603e4b27e@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Yang Shen <shenyang39@huawei.com>, 
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1971;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=4Y9QgbF00FoI4B/3f7jAJj3cl2aWhCMkDNYuPbS1EZY=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBorX/Mp2Ad+I7SUoOZM6v519gOx/CLUv6RIzX8O
 Ar5I9b0l/mJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaK1/zAAKCRARpy6gFHHX
 csC1D/4se4kSHgMsVlmXVig251ULGbAuknuYAURfTPA+Gx/KWNnNaq2HC17vXfvReZjWV+38lSW
 RKsntS3xYeQEEwKabO82u1QzKaWhqgxHiWa2HPldhJNj4h24871wvnXhv4sMXdHFHa+FhVexotj
 tJIw9MPiRgqECLk4Sq4ww6+9xZ3KlEPSjEYfz6mHT0rQeO8vpzHge3towl0LkAar3hPV37QjEAg
 6kmt58UNYU6ZoAaRB6YZHmkKDCOPNY4YdrtKxv+wGTsqGizXc0KDHgU1mdyj4Xln+g6ZYFyKtLy
 F/WXoZPBa8oTZpYXi4yC+at09xkqkNquwPrMkSvUweF5lZSxWqyKRlS3mklC2K729dq3ykdFsoQ
 vESYOohtsAMjdEusqxNc4hAlbIfWcb3DHsOKpWPKm2VBMJ7WMX4xHWE5vOdrpga0dac6pKDMhFH
 uWmPPI7P8kqcHGdfVe+UaGyTxGasjE5z2B2r6Zs+V/rTJ/zMpVMjZ/sSXGEDejFQhyazm+MV+04
 eh5BDWYp9VbxaAIjL0IfIK6CMkIrCMgpoeDIV/Tz3lj4ZYNQCuHi3fe5u3nCDwEUjUb+j3PdUE0
 3hOTlZKXsSLqw1CyligsQHbM6AlryxzOPZTeW5jD3psp16PB1l3ih/gQWZGfMYL1zGuj3ROcDdR
 6ZxueVzBhI6xB+A==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Simplify error handling and shrink the code by using dev_err_probe()
consistently across the driver.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-mlxbf2.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-mlxbf2.c b/drivers/gpio/gpio-mlxbf2.c
index 390f2e74a9d8193f924ee50f4a8f2d7bc6ae2168..bc4bba8b567c2605a77d4f9d4d7d916e8b096569 100644
--- a/drivers/gpio/gpio-mlxbf2.c
+++ b/drivers/gpio/gpio-mlxbf2.c
@@ -369,10 +369,8 @@ mlxbf2_gpio_probe(struct platform_device *pdev)
 		return PTR_ERR(gs->gpio_io);
 
 	ret = mlxbf2_gpio_get_lock_res(pdev);
-	if (ret) {
-		dev_err(dev, "Failed to get yu_arm_gpio_lock resource\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get yu_arm_gpio_lock resource\n");
 
 	if (device_property_read_u32(dev, "npins", &npins))
 		npins = MLXBF2_GPIO_MAX_PINS_PER_BLOCK;
@@ -387,10 +385,8 @@ mlxbf2_gpio_probe(struct platform_device *pdev)
 			NULL,
 			0);
 
-	if (ret) {
-		dev_err(dev, "bgpio_init failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "bgpio_init failed\n");
 
 	gc->direction_input = mlxbf2_gpio_direction_input;
 	gc->direction_output = mlxbf2_gpio_direction_output;
@@ -414,19 +410,15 @@ mlxbf2_gpio_probe(struct platform_device *pdev)
 		 */
 		ret = devm_request_irq(dev, irq, mlxbf2_gpio_irq_handler,
 				       IRQF_SHARED, name, gs);
-		if (ret) {
-			dev_err(dev, "failed to request IRQ");
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to request IRQ");
 	}
 
 	platform_set_drvdata(pdev, gs);
 
 	ret = devm_gpiochip_add_data(dev, &gs->gc, gs);
-	if (ret) {
-		dev_err(dev, "Failed adding memory mapped gpiochip\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed adding memory mapped gpiochip\n");
 
 	return 0;
 }

-- 
2.48.1


