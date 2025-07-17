Return-Path: <linux-kernel+bounces-735327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B801B08DD8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C073A18927A2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACED2D8797;
	Thu, 17 Jul 2025 13:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Dbp3K2FZ"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1782D8776
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752757445; cv=none; b=OPiPZQn1vt7Ye44B4t4PgvnJk2p4mff3ZW6dgWgxKrSDOYxtOLxdhaslt1ZhdlnnnDbVD6ATKRpx7OO2hsc+yEUzuSxaGWDo/hKvcLrxwjkyTEkS4weGqQdIKBPU/dSmulMmGbnUB/hbMmX149Kqu/imG9YImnzxXuOUNgbjMtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752757445; c=relaxed/simple;
	bh=NftqzsRL5J/T4J3rX4hNKcGRqdV8OQxf1wBUn1DJjGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gps4A63ZOplxMAUS6+8/rr3gb7GfgY2qAW9pIMwJG7niutM8c0cStTB6e2MD2vUzvCdsZ/QAaqXTCoVnrxIvI6P2LrIVpye0i2NisfDOKCiKgpT5kNdbzDSjDfvIh47ADNgFdC16FdwkjX3oKg1A+0Upae0FrCqQCahqMx19ymE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Dbp3K2FZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45619d70c72so17142635e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752757441; x=1753362241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XkwWhdv6v2tQVpOgaNo0HBrvh5YlIDiiOsHIyXdFuE8=;
        b=Dbp3K2FZfjqFEwrH2RGgy+qe7QTFlhjij9MWY+p4xl6PS9VUdz11GGeXiufFTv5VBM
         XzDKfq3ecK4uA21MV/EyiHPSTSb25kuK19UBrhq6axXMHrPxfg2XhTS9cAssva2l7JBQ
         uDfqp4rTSw9F1R4tW+ovNGBnJAM5pbEJgRUr2iD0DISKorrQh9i2Ou+1Lobv0NRd/Dos
         QrV7XMfpdwKWKrlKzD1F2/iXp0vMPpx7gl4vCoNBrwuFuDIdVeOAd0K9EjcUtCwf+SpY
         Xzx1pdWJID0eadOPEoqbjgEz+sZYSMf2uLTyHfhLofJIFD7gB2j0pIccOhENGB1i7b97
         YiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752757441; x=1753362241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XkwWhdv6v2tQVpOgaNo0HBrvh5YlIDiiOsHIyXdFuE8=;
        b=RN+pp0oD8hq2V2xyN98YXJx1qxm6+GiEnJk1tBUSED/Na6AOsLp4sjOnYuWBbtFMDg
         n5w6lmO7ZGbVHLx25ATJIhJrCQqOleofIHx3aoZIj4Q9eSLUM9axpqRDuDQeS4dWMj67
         oYXJscdZeIzS0CCKMFrAX1vqgNbqnYdEqRkfFPOJ59Rzr1XxYM6n1n0FabTrnnSoChvU
         2NNfX+Nlviznrl82/hnG59jLqHQZdqE71CrAqSM+0r8gmAE3Swj/8A0iNXuDb0xt/bAU
         hY4NHB0iojnvX83TWxmtrT3VtUHFNdsbhmqj2cdGE9SGPS4/tPIVKiDxo68C/00eBKvN
         en5Q==
X-Gm-Message-State: AOJu0Yw0eH+SbJ7RyFqUMQakwY4fDBszad/dCwkMlCAzyK5Hh/0Usp6f
	LcFQS1q6hhFV23wKLmLVKGhvcGmtEN0HuNfGhzQeUSzcWELxLA3PvP/s4rZ4BsUp8yU=
X-Gm-Gg: ASbGnctqGed53PVG5JGS+I9iE3F72ifOkVd7mtWQ7f691PdV0zIahX6eyv807DG0j33
	xz30moUYl8nIsoVj7HguSW6kibvbz3XgD+tlbXl2kkePM9UfVUNERRcYASZBUriYDULBkvGe6vU
	ISMk/K7NWW6x5PMtNco7j1zJ6P8lMTNEcfQCgUjW6yPFj14lIRyqpMpJlGIt5vf/ZbDoo8VcLi5
	SUCck8J9jJ6jA++3629KaF3AYUzPWhUBOJqxpxEEtR6T51RDcmxbkapiFUcM3HzAIzAyWlVX8lB
	nl3DShWG3zux43QFz4meupeaC9qevbJQ+e/a2YUvVk5TQhno93euT+6Lgr4bW94wG9Afcn8wzNm
	HO6hRrm5pme8Q4HAuoDkZims=
X-Google-Smtp-Source: AGHT+IHCEa5ASkRQNWGuxFa+q/5TTFTyaTn4FE3gd2ldB4CT+hspmh0TDEoQG3esevQchrYLxJN0Kw==
X-Received: by 2002:a05:600c:6610:b0:456:942:b162 with SMTP id 5b1f17b1804b1-45637bc1e8fmr18452415e9.11.1752757440948;
        Thu, 17 Jul 2025 06:04:00 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:9e61:4694:c621:5693])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm21113548f8f.34.2025.07.17.06.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 06:04:00 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Romain Gantois <romain.gantois@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/2] misc: ti-fpc202: remove unneeded direction check
Date: Thu, 17 Jul 2025 15:03:55 +0200
Message-ID: <20250717130357.53491-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

As of commit 92ac7de3175e3 ("gpiolib: don't allow setting values on input
lines"), the GPIO core makes sure values cannot be set on input lines.
Remove the unnecessary check.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/misc/ti_fpc202.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/misc/ti_fpc202.c b/drivers/misc/ti_fpc202.c
index f7cde245ac95..ca415ef45cbe 100644
--- a/drivers/misc/ti_fpc202.c
+++ b/drivers/misc/ti_fpc202.c
@@ -125,9 +125,6 @@ static void fpc202_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	int ret;
 	u8 val;
 
-	if (fpc202_gpio_get_dir(offset) == GPIO_LINE_DIRECTION_IN)
-		return;
-
 	ret = fpc202_read(priv, FPC202_REG_OUT_A_OUT_B_VAL);
 	if (ret < 0) {
 		dev_err(&priv->client->dev, "Failed to set GPIO %d value! err %d\n", offset, ret);
-- 
2.48.1


