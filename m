Return-Path: <linux-kernel+bounces-764491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F67B223B9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38BE504D68
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DBE2EA49C;
	Tue, 12 Aug 2025 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="dHTDu2fE"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDEE2EA178
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992345; cv=none; b=Bs435BnZVw30i1RZ0Rv19F+LBP5EaFsozDqVyq7OLoLMid0qu6jznYmUyYc/y/x4DxjJJi+bOvpFuN2yTXkRXOw8YgrUHFBwmwIudTEHKDHYcDPYd6iwtysdDGDn4SxR8q39O2ELnjBUG8dFn91NgnmkhEjiFN+xLYOGeMnShCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992345; c=relaxed/simple;
	bh=vkpZBLTpaIui+7bJpSkDPzFmEy+B6nYwKDayQOON0kA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m2SBEL3iUmQUubfx+TQVcp/oa7fJRK4AZQNT6XKhhKRhGKNFQ0mbB/jgt+ceB47+cNkIvhj4qg/eGfrNao/DPnP3vtrz9MELp2N8t7rLGVbIg6nCTlMdQdR833JbrEChbMcu23zSmX+Eyhiuibb6sq192PLbPKDq1/sKCWICk40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=dHTDu2fE; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b913a76ba9so318494f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754992342; x=1755597142; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=knHQSjIWdfCUEPeYoPW7hFKkqoSdgZ12PWpZI20C2uk=;
        b=dHTDu2fEQq3bG/V46+oRl1C7v2K7z9KhdsRbVvykcfqW/ybdWWbBUEUmBPHGgTxQK6
         sXFHZ0MltdN5D8idkX7tiQkqKpjpEnuKJaOOgk8jk5DqY8ty/RBCtcsmI3zZV9km2Dv6
         e8zoI6xzHvL7Ohw6nneFzHzJ5jG2bWvxEBEGpCOmh0NCpAIwDPCI3Zfxy1mQmU24mgfR
         RhrLmO9Co9T68/863berMniLYDTrETcNWF63ZCRCHbnWRhQYvKPE5tL6NxUnws3EQmtw
         6JWidsWpa/w/xjvtoSfjHeJkyjKWcfrAh7q2cw7ih6QWHsiZqcGM6fhkujfhF6lUnjXe
         sEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754992342; x=1755597142;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knHQSjIWdfCUEPeYoPW7hFKkqoSdgZ12PWpZI20C2uk=;
        b=q0OdNBdMvsE0dKoKg/kvJBuuZHj8fqgmbqbWC+eLr30YB47eZehpMnZup6CwRoNva0
         u/nV9RUhIgA9muuHBO5CfXlelOSP4ehdyKjrh7C9CACdnTKsLUSDaGJ0t54rWNNTgxAf
         PN8Iv2jFAtNGW8SdoDulFU9fr+CmG4+2XTDLqWPrgvR8yNEtvYqYRZcVk30Qg+2iEBfX
         atYfXAzeQY/HwcDq2QK1RG5rrj2zcnnvqzTQNaaaP2F5mB/OqeITRZqU75mD6Jp9y9uJ
         6imPOAkrmryphudXSZusO4kVV4SvkWsYqXMRxwWaCdgzuzFwUgM5u0nub79l/BpDHKUx
         xsIg==
X-Forwarded-Encrypted: i=1; AJvYcCXlrzc43CmyhNum4ic6JMteB8uGGt0D2+wvNXH66vqcWYLJJeoKBFEis5kPhJEBWf9jWF9U5tNLtnx5SC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTT0itdr4nQxtZ/fZA/88MYDifMEVi4pWJ97nUoplUWv4GzpNA
	ZIg8x8xNmoBKNA3y+UPlp/T0RPiJ6UZrcl9lOzpGrxiu0dI4vz8A1UZT3xICuDAHOew=
X-Gm-Gg: ASbGnctRjjgBMk4pN5cOY59iWL62Qr0j7zY6W4M9OQq0LxYxqF84pQhzj8tbPOHtzyw
	RTEo4yjYZpp719cWOy1XpGPFfw18pPZcC7muu4pk1UFn47FSKNxszf0Q2ylCFY9OED0r1kWASV5
	gqQPKd6R/HeHTSwGN7gax+pqZTXVZbziwZgL+bKo1wY0ZwdQ1H2N1NfAJY2tZxQ+LXoWQJLaLeV
	SwuGxUJ/lY/m6BEevg/2s3iDg5PEOlDtRoIN89Adp7J+Z11H/s9A2qeJTmoZPRcb6auob5k1Yxh
	PK8ZDOlj0HQrz3i4ffpSDqLTGVQmp1F8Bsf5qFRtZV61xWx+JUmPD/ERpjQ7qwPvPPKzBqa3MJ5
	onq4k6F+nv91afMY=
X-Google-Smtp-Source: AGHT+IFhu3eBE61b3o1CeUsd+4IJk3B6C/uJlFbaeXOz24wBBmqFmhKOMJ+2LpT68myAimu+s/kRqw==
X-Received: by 2002:a05:6000:4022:b0:3b8:fe01:cc29 with SMTP id ffacd0b85a97d-3b91100ec4amr2185308f8f.45.1754992341938;
        Tue, 12 Aug 2025 02:52:21 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:16c8:50:27fe:4d94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e587e154sm312580295e9.27.2025.08.12.02.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:52:18 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 12 Aug 2025 11:51:59 +0200
Subject: [PATCH 02/14] gpio: generic: provide helpers for reading and
 writing registers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-gpio-mmio-gpio-conv-v1-2-9f43e95dea98@linaro.org>
References: <20250812-gpio-mmio-gpio-conv-v1-0-9f43e95dea98@linaro.org>
In-Reply-To: <20250812-gpio-mmio-gpio-conv-v1-0-9f43e95dea98@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
 Hoan Tran <hoan@os.amperecomputing.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Yang Shen <shenyang39@huawei.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1736;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=OZyZWSGy8uPs2UaDZUWXQTJ09CV/XrDYoRGt1dr0Y80=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBomw7FVQgiJpzBOU44PukLx9jZdqD1qP/d2YDnL
 DDJZ5rlEh2JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaJsOxQAKCRARpy6gFHHX
 ckwvEACCYpw3TBBm+4QxD3fMyvnMsXLF0rCJpsRs/micPsQez8B8fCSq2jLZsLdFCEbO8gXvIz9
 7yxSocjBylUJUNHZpUg1enKYX56dw3/PMzo7H/3ezKIZOV+5Zzc5bBew/8TuFSLWnS19XgTBrWc
 hGR/uzwBp07HBNOo3a0QHSTqQY2dfBcp9dcVJeyD6l4n8aK9rKmlCDxcsLRa4oZ/zB09v+5mIWC
 RkqmfGhJ3E8gt5j/qkcXEXTv6tm7ee3m6BynnAs3fljqrK7Qp/xUT0Mz8CvWKwvXGeGvRJIxBTY
 jwo63D4gCtB4ArcwLFTDWRohUrpZsjOv2eFMtjEJsZAnBdKR8yoGFPj8cw+rw4dQqzuSiNm16Z3
 KvPWZuztO8kOKvmXlGBCYoIT0JpLw4daGjiUm/eb3+/P+utlN2FzBdNlbVyfipWCer7wyz+ARe+
 P3v7whbF9yVKkLvZiJHgBa3CJMuaviCJtBnvvDY5PppfSYysmUpxk3eUwnta9U8fJSuxsHYBMer
 l2e2Hk/AOGyItuelYOgKC35POSsp3IpnoCqJ9TslZYp2xiMGUhwamw42vWF77tI9i1V8K5j0FuJ
 OgPtLvVuRude8ZWgFPrBa1dHsqEcCki+RXoJ8tA5fOQy/cHpFtmIFQNpYCG2CUNOzIQ0k5NMcJA
 XyedK5ZeVqhRP1g==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Provide helpers wrapping the read_reg() and write_reg() callbacks of the
generic GPIO API that are called directly by many users. This is done to
hide their implementation ahead of moving them into the separate generic
GPIO struct.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/gpio/generic.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/gpio/generic.h b/include/linux/gpio/generic.h
index 5a85ecbef8d234d9cf0c2f1db7a97f5f3781b2e4..4c0626b53ec90388a034bc7797eefa53e7ea064e 100644
--- a/include/linux/gpio/generic.h
+++ b/include/linux/gpio/generic.h
@@ -100,6 +100,37 @@ gpio_generic_chip_set(struct gpio_generic_chip *chip, unsigned int offset,
 	return chip->gc.set(&chip->gc, offset, value);
 }
 
+/**
+ * gpio_generic_read_reg() - Read a register using the underlying callback.
+ * @chip: Generic GPIO chip to use.
+ * @reg: Register to read.
+ *
+ * Returns: value read from register.
+ */
+static inline unsigned long
+gpio_generic_read_reg(struct gpio_generic_chip *chip, void __iomem *reg)
+{
+	if (WARN_ON(!chip->gc.read_reg))
+		return 0;
+
+	return chip->gc.read_reg(reg);
+}
+
+/**
+ * gpio_generic_write_reg() - Write a register using the underlying callback.
+ * @chip: Generic GPIO chip to use.
+ * @reg: Register to write to.
+ * @val: New value to write.
+ */
+static inline void gpio_generic_write_reg(struct gpio_generic_chip *chip,
+					  void __iomem *reg, unsigned long val)
+{
+	if (WARN_ON(!chip->gc.write_reg))
+		return;
+
+	chip->gc.write_reg(reg, val);
+}
+
 #define gpio_generic_chip_lock(gen_gc) \
 	raw_spin_lock(&(gen_gc)->gc.bgpio_lock)
 

-- 
2.48.1


