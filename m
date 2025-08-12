Return-Path: <linux-kernel+bounces-764723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D3CB22681
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396701B63EB8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1022F3C0A;
	Tue, 12 Aug 2025 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YlgRiJlY"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B2B2F1FC7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755000781; cv=none; b=Kf94dwik4LmoBlKgW0kXjGuIxoC3SDOBl0u6C3ip1nA9m/5IxZNXckLx40eZXLjvHqIQ+stdQ27oX1SYIkk4EGZ9SfwDgjRvJ4oY7tHStjyl8XE3aelxhIus3Gp10gXNhEdN0MEsq9wNPVYfgm1l0jUPyKU3hxspQI2mNtaZpPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755000781; c=relaxed/simple;
	bh=S+8urmUItItM/xWiVUTCqmdfALzfBJBt4ua9Tu1wW+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mt17W4Xxv4o5MeWdpZX7I3WH9LtSbOzhkk4qs9B8l7OUSQ0iYZIURYXLDAEGKgNZwvza0J3jlKGe7FOeFYH2yuC41pxFEH+y0iSx2wwuct8eutKmDXVHfOb4YMUSvcgYIjSIo9ehAmMYk17SF9kEb/X2M56QvIF1AqRe00Pmgso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YlgRiJlY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a12b3f4b3so3880225e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1755000778; x=1755605578; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9kI37g+TGqamMTbBje/mg9IaGEYmRq4naVS4/zTf0zA=;
        b=YlgRiJlYfyZp2ci9Jhi+xcy9K2NG5QWehivcUJrnkQrFjj+QpeFK4PaD2O26J68dg1
         Xr2NJj0MRTzEtRVlh5GntjhGS2ZemPEurb1Kj0gUnQbnSXEUS4QTc0EEleSqfRYatTQ/
         OfCuN77T1XgsUloZXJdbJTG58A+A7ChfJLGnvhEtLzBbv2v4KVyRH9LEpfcQsTGrWDUF
         Uy9zi0np6sEPZGDiO5783RsJ4PLhiarN8JR1m9ytIDVH+ULK5deczLDXbuzlH2+95cKe
         n7N44RhS4UCwri1J8t02yQpc511COtzQeMkjoBI3v26nblOEGOwgsVj+UHbYPSnfrWpY
         OkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755000778; x=1755605578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kI37g+TGqamMTbBje/mg9IaGEYmRq4naVS4/zTf0zA=;
        b=vQRhxgf6KxHYtfn3VcGpYyLFFbLTRa97/aJAmtONWz4BDG4hja4oKTo+ZHCxjNEsAU
         Wy85ZGiLg1S/kIqtVzH5IGQwRCnb2fdd44SLBE8d6sswsPcqwOPL4LrF0nUE4qGEQ1fx
         GxCsHbebY0ygGqpji9WcFwRE9pyN0bhohxGirNJ6mrmBZ2yAa6RWmIpCUJ0E62JE66d1
         sOdDOLqWVGjY2IUzngy1q/gIYhdRVHOz6SMAiyZuokpXZCYAo3gCddpUbeW6Bd1N2idx
         L1ZBTotitQYWs1+mcdw5SFZTP7HSLlM59BEzb/IV55uv4Z22Ze+AH88fs7RR0KICBPrG
         vXhw==
X-Forwarded-Encrypted: i=1; AJvYcCX9/Qv3UBpZUKiHec9H07CfmSUIERUiEkNlKDoTm2g5vVqK9L4/IA6mYFhyrmlZriH3TIAZvMdgzkoWyJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfzHbohYO6ad/FTNDVix5JVcgvsN9Ag2lmAa444quoXW3mgEtS
	QQmIzSZUF9WPaLTIaGW8/vEAKdpC5rDfT3/Pm/7JeFNoy2dg6ehDTCyNvK2nDVOnW60=
X-Gm-Gg: ASbGnctikYAmq7JJdaiAu7e0BD70NRqilPeuOMpZKIU1jDd/OivQIIDGYFzerrnsYw4
	RB0n97lTq8LSgjWBymL/tl2uZLgVxPr99igg8P5XE1MTEYfuvQIrFXXFoRZqU2RKWanGXSuwpNh
	uaP2j1BKP4w+5bNMhAGuxoQLdCBnQKZ09KFDss1ScTFXFMRemvooDmTHREx7GuC1c7kLibkxU2r
	N6LuGIHDU3V7WwKtSY6gIx0WmiDMq1GVyrxgLKtOKcyLmOILnYQ7BwU5cx8qo1wUHeYt6lDNBq+
	iImjhqTWlKMDC5QwGoaybLF2doUpddYwafX9zraJjHXNM7WOVcLTLDoPwp2QmK+aP/4WFV/O5v+
	TQvh5bv0Pmiq80IFGfjXLTpO/yw==
X-Google-Smtp-Source: AGHT+IHw5CvbsO/+//TLW6vU07wlWKt9OhY4KdTCKw7kDY2ouaD3KJYhB2udEhSB6VhDjWhTy/BT9Q==
X-Received: by 2002:a05:600c:1990:b0:456:1006:5418 with SMTP id 5b1f17b1804b1-45a10ba2e85mr33107135e9.13.1755000778093;
        Tue, 12 Aug 2025 05:12:58 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:16c8:50:27fe:4d94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e6867193sm298878535e9.6.2025.08.12.05.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:12:57 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 12 Aug 2025 14:12:48 +0200
Subject: [PATCH RESEND 06/14] gpio: ts4800: use dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-gpio-mmio-gpio-conv-v1-6-aac41d656979@linaro.org>
References: <20250812-gpio-mmio-gpio-conv-v1-0-aac41d656979@linaro.org>
In-Reply-To: <20250812-gpio-mmio-gpio-conv-v1-0-aac41d656979@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
 Hoan Tran <hoan@os.amperecomputing.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Yang Shen <shenyang39@huawei.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=906;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=JVVbThM9xH2PXWbYe03tJE2jElHw1ibdCVrW+ltAkLs=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBomy/Ad2G9sZS7ICkDDEmkSScMmuRpmIarjRSCw
 eKwaldFODaJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaJsvwAAKCRARpy6gFHHX
 clpND/9QxoBvO0B43u50QTACc0vPVPlKp7dDSnRaclDKK3ELzWruFYW8rtT4Cvlp1QD55NMx719
 E9hj4fAwjGxzRv7Wz0wwUxNEJT+7WJ1QV5s2DyrhCHV1+IRlaMZlKjiMD61TPnsjLfcsoCFgtf+
 6LjOV1z01yD+PWAcWOovSa5YWyGLZQctaw8lk9Ydjzx9jBNk2Vg3A5/vSRKBku7wmAN0MqGiuwr
 N/V30Kot2L8bzhXMNK4nDSleMacFwg0cId2n5uP6J7Cf0SWpXLiUb1bi9VsCsZlg9M0PUw3rcFl
 Q7avGt9kvozTD6gW+YZlfHahh4i2onXR+XqeRdZiBj3ii+VsbitUAiuvxQl1X1FSYid+lOEfcnE
 LUGXDUYikA21nTJ51OaEOV/R4K3qWc6sQTKZ1xa9t9iPsTbmjjo9e+CSZrZm8Vxi+uk5O9rkJVx
 ECkv6/yD5quCYmO5wJQbrkM08Cp0dCy5mTs8KeUQpThjjjV4BLNbQ0FGx+shWVkxm8k8dN76Z/b
 hTvsLHH3djOh93GTG++z3iGu64PSLsfu42+yHsjRZ0ri3VhUXFTMZ9SyoB2JsEUg5UzVb5TS6X1
 YHjNtd9MX4WPXB3FoLh7QF/QCG7xvRD0UObXXTBlHi1RAEn8lCNpjJdbMDtP54hRGBJAovrPYXm
 6X5bGIpXpA5cxAQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use dev_err_probe() where applicable.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-ts4800.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-ts4800.c b/drivers/gpio/gpio-ts4800.c
index f4ae87325393c909c66eda3bb7b2f849e645b7a4..cb3eeeb1e9df9aa687e880b16f8d0a31b04a3b07 100644
--- a/drivers/gpio/gpio-ts4800.c
+++ b/drivers/gpio/gpio-ts4800.c
@@ -40,10 +40,8 @@ static int ts4800_gpio_probe(struct platform_device *pdev)
 	retval = bgpio_init(chip, &pdev->dev, 2, base_addr + INPUT_REG_OFFSET,
 			    base_addr + OUTPUT_REG_OFFSET, NULL,
 			    base_addr + DIRECTION_REG_OFFSET, NULL, 0);
-	if (retval) {
-		dev_err(&pdev->dev, "bgpio_init failed\n");
-		return retval;
-	}
+	if (retval)
+		return dev_err_probe(dev, retval, "bgpio_init failed\n");
 
 	chip->ngpio = ngpios;
 

-- 
2.48.1


