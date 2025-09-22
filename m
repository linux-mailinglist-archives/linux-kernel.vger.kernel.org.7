Return-Path: <linux-kernel+bounces-827013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E69B8FE2F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41430422023
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9322FDC22;
	Mon, 22 Sep 2025 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YMd5Vvqa"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B3F2F618F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535129; cv=none; b=PjZHR7D7+SXUPzW68wEdeiVk5QlBfayVbyJKjOumWRNN1t63dNhmTm6WS2QMmYVV8Tb1bLqQVuXdKfVcSA3oeYpdHZoda6aI+qoRfEQHV6RJXCOB8967Hjz9ZKjwixI0esG1MHpxiLDj0YPXt4gyHwNoBqb6kYC7If3HQ08walQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535129; c=relaxed/simple;
	bh=zWPNj0RNAceSF22TSQ0IDW3EbGOYMdo93t/FZbvvlww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a2yiVZQ6mR74WKGFmNXcAlrJpn2DC+BaKxAGzmnWQEfNoWgyQdzEq1y1EyNEkjqyg3g2I9jOW9s0tZpDnJDISmomSXdR5AJUIrfbLHaRPO7Xj586alCG5Q4YzHamXNVuu2JlB4V3MYiNYmISjIxPneHl7vXQszczkscdEQ5FJgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YMd5Vvqa; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3e8ef75b146so3933008f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758535126; x=1759139926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nSZRXEJpJYIJ7RPipWafSLvYkrPeHLjEAHBfYF7qoM4=;
        b=YMd5VvqalawgeYNlhsEo6p79eBEMK8M00xo6Xhu11BmsyfV0Nmv+UQF3HIk7pbthHN
         jMu8P4z1E72a4e90fObExfnZtEi+/wrCjMRMFQ2QXcksZ3SD7klSygoBFp6JwjrYQtki
         HHDQL/znCROyKt+a4NGVENVJS0pMkZ/bu0CXMoYtrqK4m+8qcL9o7VC5RWzfD4pDd4YM
         8S/fYA5MQdzHwnGQvOcJamsM/d1mUbsT816GcpvlBnx7Gs4JegHhvc2DyyTYm36pkzMJ
         xgi6DTpU9LU+1X+XTFAdRE2q7nWe0zExuwFVU4zTratFz1oK5MZNmMXapLhSZfH69JnR
         yBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758535126; x=1759139926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nSZRXEJpJYIJ7RPipWafSLvYkrPeHLjEAHBfYF7qoM4=;
        b=W2DOvnC4jrgNg8i42Zn2jf6qmStX1YBUzR0du3EC0CvQdoGmMRT4b0IewdEBjeiMcn
         Fozv4W9IslMyQwuBo3+hzeQp4HQu51sY/ZXWqiQ1SX4QJC/P2VtjTOsyKiLeSS6mq0zD
         a0AQfMOJNV+w6Yz7u/qgtrRKgQ3h9Y2j6+CqlqWd1qdxOtoQpAte0NIhNtz6jntbB6JX
         vRt9Tlfc7/f0o5igTclm9Vbc1oo4DmdQjZU4fCjDEqe6/CkCmnSKPXnkrCDuA36zzwEP
         VyzGdaicurRN6FIpqJQa0l0fj5WUVPcaImI4rVbOLgelHn/bWbl84T2wG5jc8AllLjGe
         4hOw==
X-Forwarded-Encrypted: i=1; AJvYcCX+yO6krPaR7Ghxf6xmxr7+e6vbd8hO7EnSZ5bnPadg+dnvWH5W0TN+Ty+hOMsmx7UxAaXyR+R0lg9JZvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YziPA+7PYZt+80AoyFAFmJBiJpkJkO7YNgElX901KQifoxiHwc2
	PhEVlyio2d2hzY7LGhr98v2t5g6fGIG73D0sCTONIVz5DLONPPn/p77PFUM/hQB1rz3nGF/oRMF
	SKD+VHys=
X-Gm-Gg: ASbGncswi7+bdcye/nYNM0br3z8B7uBL5I0pK6M0TidWH0FoIQCLv4vHCQIYLrqrsVl
	wgFUfRPsDNBxxnnKT9fbW8onhEbxHkVkOMQ4Er9ezJ1Ckeiyuill2tcvWBTFyYNy5H1SCc/R93G
	Fd3+4LCFDsJYUepDnot7dWRGPUWCJ5tzyr5HJLeDLn2U7VCVbuj+PKU+tzXeUX8W7z6ziFDTB5a
	C+2EsIx6Y4GZmBfYs0r4vk8/EU/qxAp6hjv0gj4rYfa1y+J7TEplZji4rrInDl+fU+Q4AnVLg5r
	hGY/xJf9Y9/52xIrZCSlVOIZh5G96kSWhFBa7kyCnx51dxNf6ZtNVqJcFa+/SE+bV+ZJqLkTCuF
	9OpvHwMCYTuRuD5bo3Fx39Ps=
X-Google-Smtp-Source: AGHT+IFC7YOxNiZosfAq2ySehVzFtcxAUO/OP5OGtBiL3ZvhNpMo+4gv1HpkEL9ZjVRzo3egBOBdhA==
X-Received: by 2002:a05:6000:22c7:b0:3ee:1357:e18f with SMTP id ffacd0b85a97d-3ee7bad15e4mr10289789f8f.12.1758535125927;
        Mon, 22 Sep 2025 02:58:45 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:824c:ead0:65a5:c51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7460sm19423401f8f.31.2025.09.22.02.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:58:45 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: virtuser: check the return value of gpiod_set_value()
Date: Mon, 22 Sep 2025 11:58:41 +0200
Message-ID: <20250922095841.52330-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We converted gpiod_set_value() and its variants to return an integer to
indicate failures. Check the return value where it's ignored currently
so that user-space agents controlling the virtual user module can get
notified about errors.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-virtuser.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-virtuser.c b/drivers/gpio/gpio-virtuser.c
index a10eab7d2617..37f2ce20f1ae 100644
--- a/drivers/gpio/gpio-virtuser.c
+++ b/drivers/gpio/gpio-virtuser.c
@@ -500,9 +500,7 @@ static int gpio_virtuser_value_set(void *data, u64 val)
 	if (val > 1)
 		return -EINVAL;
 
-	gpiod_set_value_cansleep(ld->ad.desc, (int)val);
-
-	return 0;
+	return gpiod_set_value_cansleep(ld->ad.desc, (int)val);
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(gpio_virtuser_value_fops,
@@ -543,7 +541,7 @@ static void gpio_virtuser_set_value_atomic(struct irq_work *work)
 	struct gpio_virtuser_irq_work_context *ctx =
 			to_gpio_virtuser_irq_work_context(work);
 
-	gpiod_set_value(ctx->desc, ctx->val);
+	ctx->ret = gpiod_set_value(ctx->desc, ctx->val);
 	complete(&ctx->work_completion);
 }
 
@@ -562,7 +560,7 @@ static int gpio_virtuser_value_atomic_set(void *data, u64 val)
 
 	gpio_virtuser_irq_work_queue_sync(&ctx);
 
-	return 0;
+	return ctx.ret;
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(gpio_virtuser_value_atomic_fops,
-- 
2.48.1


