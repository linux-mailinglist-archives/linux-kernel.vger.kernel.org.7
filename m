Return-Path: <linux-kernel+bounces-863515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EE0BF807C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EF0F4E2C62
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19FD3502A2;
	Tue, 21 Oct 2025 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZsJhADB"
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB165224B09
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761070620; cv=none; b=OKdrTq+JTUGs9QiDZVW7gaeQUMNoV2U2UGM5MKVU0ku5VRTI4uhFmAfzVUTOx90rkhuSZ0IWQ0VkoBeVjPhpjvFECKNAb2DULZ4cida6Gw2dR4rdUTcZ+7Sfg41yi15+SfYMcR8n4mLcAhBD0m2ilsgCDRs0ffgudXlzu2NRk98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761070620; c=relaxed/simple;
	bh=kZOWY6JMDDz6tZv9AtSD0B2cuHs83Ph+Lw30vWeNKWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BSRqXqV6JuyY50u5sH65QYd5DvK6sUcsWAEMyTEcv5LRAmDvBvTmkzA8vudPPccGLFAU25Tg2QJsCDiSjutiDahtw7IHdzfTZwIVLDspJdsKJYD9ciEWlv8dnipYwQtO1C4Gfv7wi0xmf7tmAgjhOeQcBAQTDqM5DNHwp75Q0OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZsJhADB; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso5792534f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761070617; x=1761675417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2WcC5Yj4O8iFwcWtj14bHD/J4MzaQs1gHT8i+XN9QYA=;
        b=bZsJhADBXjsrNeC/WywuowtHzBLHS0Ve7oeJ5fi3lYk4cvN5U8mpKB8Bvk7g0jHqV6
         +snqgx5118n0Xa04tS9HhyVP7go9LxVtNI8vvc6Of5YJpNNQhfNoB8k3NCmaGcBBLh3F
         3oK8G+gHtwbUVyaLOn7yXqOjLek+GwGgGXg2RFSdAuDAVeMHI6oLrlE/3maG9M0QknGw
         I6Sg5byQLiayN7xin2JEVZKgjR1hjGxRFoQzIM8/Hk1fEpw7ndMap9y3yol8w2U+s0qy
         /M9PRga3Ia69ycGTEhCV8jZiWtj8iyLds69SH34LjzpohBbNT8AMAAhyNar1toagHLRD
         vzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761070617; x=1761675417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2WcC5Yj4O8iFwcWtj14bHD/J4MzaQs1gHT8i+XN9QYA=;
        b=QMKqz54UTGxk+cs9uAzDzqDlS20hXt57EghGMSnpz5i1FsRSzM+86NeDaZAMO9YWfR
         E5+mHNI0qbUyg5NNJ9E/2em26b43uBdNhRxECldMFf4rHLkFrtmZLDD1yxCebHbSOXaS
         IX4olSSXvIe6Tv/gKPFxk7vQnCtR1IHV6yyyuAT6E6zRor+TZjAKJQ+5uB871rpn5AzF
         IphENj0+b9+Bf08rs5ljrsKptvcWMYJbkzwwNPAiuql/lTrz1I78iMO3JwovSGsiF+KA
         LKc3ICZNmTJ41y3cojh0dhuKE41WNuz+x6w6Cp7kK1m/MfVydGUuP+vJtRuLeea2ODcR
         udfA==
X-Forwarded-Encrypted: i=1; AJvYcCVqJaFa3PVgK/6GDcjXxq/KeUCAyICinrylVP7XzigxJufRmYt0kw2TM+7up9BEv2SqKX/wpGI2CodQZk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+aQ6itfBWoDONM0IUPjXyvH4lcXiHHNbHj/qkgd6gZEyENUhC
	VpY7bLHJs9Tu8qfsJgbVBGjMc5SGn0GwSOKqrdr+JqRX9pO/pSbfFUoW
X-Gm-Gg: ASbGncsTpPsSa128gjIB/BCWs8KuHNtqaXUHHtPCcC/0PkC49H6eU4xuUpz/vVlFD4I
	s0CLXGxUSbyZMSvBkGqtZK1Df+Mtr2+SfeMet1bMAteLRSpcxp5rlL+DQ+ykXIg1QiruJ5idS5q
	MhzILxY4AR3whW06gLkSb8ZySs+IDSDSots6Esa8Xeq28iW6BHFrlITW+dWXpO4+vgjmG3GiwiH
	BUuvf6B0TX69AL6THh2FHZMVWf1SxpXF30pu1WpL0mCgFOVMQBZMm5YBIq7/uNGiCZsIwlOYAA7
	n+o3fiRJTFh1agsfVyLMa8glFCoyKSteRmkPdGLNkvbFOPIjrZqMqCFvTzoXP1uwzEk5Txq7/Yo
	YBCUI8lHax1SY2yWbUL0NLQ06KNTeCZv1yu+bx8nuFiLBEGo7cKeBh3zokWvWf/v+sUx8IkVnKm
	FpmR1om0mY21gMFoIfm+3NarTwE9sx8sU=
X-Google-Smtp-Source: AGHT+IH8ohr126cVW7kli1cWkoQTKhgJPU//PvVUWOvvxFkw5/xR/ldVcYvGM8kcSFx7OtVljK6Z/g==
X-Received: by 2002:a05:6000:2089:b0:427:608:c660 with SMTP id ffacd0b85a97d-4270608c8b7mr11681948f8f.59.1761070617066;
        Tue, 21 Oct 2025 11:16:57 -0700 (PDT)
Received: from localhost.localdomain ([39.46.217.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4369b3esm3936125e9.13.2025.10.21.11.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 11:16:56 -0700 (PDT)
From: Ali Tariq <alitariq45892@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org
Cc: Emil Renner Berthing <kernel@esmil.dk>,
	Hal Feng <hal.feng@starfivetech.com>,
	linux-kernel@vger.kernel.org,
	Ali Tariq <alitariq45892@gmail.com>
Subject: [PATCH] pinctrl: starfive: use dynamic GPIO base allocation
Date: Tue, 21 Oct 2025 18:16:30 +0000
Message-ID: <20251021181631.25442-1-alitariq45892@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The JH7110 pinctrl driver currently sets a static GPIO base number from
platform data:

  sfp->gc.base = info->gc_base;

Static base assignment is deprecated and results in the following warning:

  gpio gpiochip0: Static allocation of GPIO base is deprecated,
  use dynamic allocation.

Set `sfp->gc.base = -1` to let the GPIO core dynamically allocate
the base number. This removes the warning and aligns the driver
with current GPIO guidelines.

Tested on VisionFive 2 (JH7110 SoC).

Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
---
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
index 05e3af75b09f..eb5cf8c067d1 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
@@ -938,7 +938,7 @@ int jh7110_pinctrl_probe(struct platform_device *pdev)
 	sfp->gc.set = jh7110_gpio_set;
 	sfp->gc.set_config = jh7110_gpio_set_config;
 	sfp->gc.add_pin_ranges = jh7110_gpio_add_pin_ranges;
-	sfp->gc.base = info->gc_base;
+	sfp->gc.base = -1;
 	sfp->gc.ngpio = info->ngpios;
 
 	jh7110_irq_chip.name = sfp->gc.label;
-- 
2.43.0


