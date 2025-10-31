Return-Path: <linux-kernel+bounces-880449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ADBC25C81
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751FF188193A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9631EE019;
	Fri, 31 Oct 2025 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="K0qESczX"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8031DD543
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923198; cv=none; b=rPqTyZ8S/78l/MWdGAqziDtDts+l+JkGRHNO6YwCo/bXQPie3koRVCgo+/PW6KKV6AePJRPow42i5Px39NlVR7c5uMWuHqogxHvniVXBnNtIqGO8QoWZPfbaKSHF+HYu8TXQRSuBNTaX8v5uhikuiRfIpbnmmbs5FrBhnT47NmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923198; c=relaxed/simple;
	bh=xyzfl4C3ygHBnCoU4AGi8cbblst62cDCaAHkvc/NX4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rPHnjBaxg2/BOtbO/lWh1C3uUiitw0GH5muEHqjEYb+oW//+yqne1uuNyrXwlHqewggypP7LHy7s1Y/04M+lPfkCvneKscCZ54NOgNhMooKRx0kG+x2d42rZt93/xMHMnmut7rl1UBw4nPBGjaXDajAg2Bbi8PiMj8fo5qScPTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=K0qESczX; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4711b95226dso29954635e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761923194; x=1762527994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vjEbL0bNohIYE2ZQO0FpwBW3VCE74PSDjugxRYid1kM=;
        b=K0qESczXzoJvJlJAAibo/PvYz6rqsfkeNmjbl4qlRPaJP7UJOzYCcbUDWpRAzaswa6
         VkQ68mZqvowdGPouzyXe39r0qYAIYBvu7ONEBsuEmCjidGqUzGFzwpiMs4QyuAKtVvZA
         oV3RwIIkx/jzBAcyqZ9RPIzydiJjAy9MnsFiLT19vuvcd7aIARTVU6n6uJdI/2LrlgoE
         StnMyCo5tyNx9w9aMHJhDy23PyMtH+yPCZKhwMDCd4rcmd4WafgUIug3KkIsVPuPniEX
         qrscacvHXhmZ/GoUNAbMPGmMQwei6wWUrW/vIzPo3hi+6b6ryhjoyHtbeKKQu2Hf16bp
         6b6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761923194; x=1762527994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vjEbL0bNohIYE2ZQO0FpwBW3VCE74PSDjugxRYid1kM=;
        b=iy3SGrYQksK1IrPC2oaE1RTHjRkvwI+38rlluyKXslMJsdyy1HvRqdPfCm09ZUb75y
         EyaWrwWKnQyQ2HwHy6XDqp6Xm0H5hSpPSveOrdJ22Z0WkEkqR7lOjQe7F1bNMouYpyO8
         6A6D2nVCNfGJh9ZbQbNiLTD9UKorWtGBlG6Dt7haYmPveOq1O0DpzqUEVq/tNdK73Lb/
         /3gwJGyL29xBnKg94CNCBITyI+kbn8vqvv0g5KBpaU/jXzGM/yJt6Ov8hwV6mPA6JWeZ
         LzDs0H/e7mcG6YUSIwPj/lGyxM979y/nTFzYNBdMPsC5ZjRihcvOmIlfpOGUin9n64M7
         GNQA==
X-Forwarded-Encrypted: i=1; AJvYcCW4p0QwE2D6QOvkVrpdOHT8XbxpOaB+WJn1B1WJidVeRB6BWpcgtQbZ1ws0TzoPa7weQ/hX63j7HNtVbqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7COGmWiQugXu9tM6Kshya7oryt8kMFpXfFIjcPwzS1WYna6jA
	mLIe51emMWx7WQAdN1s+u3LlyLofLNeaBim8yDr8seKy9auM1/YOTKWJS7qh/Eq9IM9TyC9hxm2
	xGhlZ0FkgtA==
X-Gm-Gg: ASbGncsJ9mAmEx2c+o160C41fUMsTUYNl+slAM7kPd7k0oeslKmprB8t+C/TlTss6BW
	KRtyCMJIawSqx2BfdIk+rfMUjfLJpDg235lsa9KOIoaaOMl/gPcapj5WPrfmbpmiqCu7Y/LXwa/
	SWIcnniEW9/Dkag9nqI6pxGBLtabm6HkbUVpaTc0z/8lUGy5FbOQHsQyTake3UK1Z+IDvni9mkU
	gKOEjnKdD5jRGmIc6khrcsbvzq4Ik0VKuqGxAPwdIxU6PE82V9Xpg1jEnqzykhWczIgRr+hiAVD
	52QMRLWH4tgVl/p1hKrntU3EDcyBgCJl2r7VGkJIDIyyjtf9iwJOzFvTZ4v3jpjr3TM9I4wdYZl
	uhhM2Mz8KsOqIoxbdMKjSivknkYejxH8ld3IJLwKToCDSKtZbX31wZHSPrwEr8uJ2rSyu1xNilG
	EXYQ8m
X-Google-Smtp-Source: AGHT+IEvPszlrCmD+0AHLDtDLtdRKT+3Y/m1QcskyCCaRvaRtbit5XIg+aCi6RUsOUdQ+xiibEYYhQ==
X-Received: by 2002:a05:600c:3b1f:b0:45b:47e1:ef6d with SMTP id 5b1f17b1804b1-477308aec7bmr41241675e9.36.1761923193361;
        Fri, 31 Oct 2025 08:06:33 -0700 (PDT)
Received: from brgl-uxlite ([2a01:cb1d:dc:7e00:68f9:7cde:26e2:9b52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c10ff1besm4051411f8f.9.2025.10.31.08.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 08:06:32 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpiolib: fix invalid pointer access in debugfs
Date: Fri, 31 Oct 2025 16:06:31 +0100
Message-ID: <20251031150631.33592-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

If the memory allocation in gpiolib_seq_start() fails, the s->private
field remains uninitialized and is later dereferenced without checking
in gpiolib_seq_stop(). Initialize s->private to NULL before calling
kzalloc() and check it before dereferencing it.

Fixes: e348544f7994 ("gpio: protect the list of GPIO devices with SRCU")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
This was brought to my attention by a person under sanctions. This is a
simplified version of their initial patch.

 drivers/gpio/gpiolib.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a81981336b36..fdb6a002dbda 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -5303,6 +5303,8 @@ static void *gpiolib_seq_start(struct seq_file *s, loff_t *pos)
 	struct gpio_device *gdev;
 	loff_t index = *pos;
 
+	s->private = NULL;
+
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return NULL;
@@ -5338,6 +5340,9 @@ static void gpiolib_seq_stop(struct seq_file *s, void *v)
 {
 	struct gpiolib_seq_priv *priv = s->private;
 
+	if (!priv)
+		return;
+
 	srcu_read_unlock(&gpio_devices_srcu, priv->idx);
 	kfree(priv);
 }
-- 
2.48.1


