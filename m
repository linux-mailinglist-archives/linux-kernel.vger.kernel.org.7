Return-Path: <linux-kernel+bounces-855782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEC0BE24D2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E73CC4F3BCF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C6F314D0B;
	Thu, 16 Oct 2025 09:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xwclXvCp"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2035311581
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605780; cv=none; b=gHs6X0S6XOYEl1gog9WQ/hs8A5Y6uspJBGoRmvTBmNPQVaZrE2OtSSQHLsbhskE0OeMManXBxEZb8zoHdcUWlFxkc46zqYD6n7ibbU/BfgbY+9+Pi9QckLK8v98hFLH969iX8YxhXxPu5/9cGEi7CWsDHmJNzGEXdTqGv3wZw3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605780; c=relaxed/simple;
	bh=WhgdTNSdd3mtfnl348fwcfKg9kivpFFHVh03Lv0Z9G4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QoVL/y+0wcXOkkOEP5N1ZsYfEsftwIr+EegQJn4jCdy6R73Spgp0kVAckB4+W3RRtoZ/ojU6ctcuKbdq0Lpx4shNORjJ53oy6OFHMhjr+AAPBqrHG7GXTjLuv6O1BlTtDEu4os+dMJyLEK++YI19DNj6km10o9MZffK5v6JSwYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xwclXvCp; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3f0308469a4so328764f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 02:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760605777; x=1761210577; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OFJZE0pKNCv07L2HqBXLecNS6deU/WhVUmv/yCRIV1Q=;
        b=xwclXvCp/nzM9UJVCEYXxpd2og98hbAVgdEiOPjfdU1QlOryw+VM6PCrz8kNumrJtE
         gji5uV6M1k7I+6uc1/4C1ug3S5T+nRaMvHnGhA6nFxdYH66a3yKCyF8yMVdnHX8ax/md
         T38D5Ms8nTb59mEIbAEESg/VdfpYTuzaUzKpcbVj/h/URjlCifZY0UZiFgfyh5uacFUp
         sCt8pSI7+MvtnQBdjiD1ARhR4EISMTzdOA2sgXCcnrPR7TSWkVsJiNl7xdBOOTF+G94S
         AUB1nGSEpFMcfLl/jEYPxZ1HFtDs0E1ZLlMT37sV1dxy4NQKfVuYHVKvWr3H2OBBDnSn
         pQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760605777; x=1761210577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFJZE0pKNCv07L2HqBXLecNS6deU/WhVUmv/yCRIV1Q=;
        b=sOGKxJ0z2lK1EACC5tvGcnh/mL6xq3hqvuH5G6zuSUjCghb0mxeCPODq8Vks7ciSra
         rbX7Hx9zgtbbAeqMa5yxSrxPKhu3Jp0zdOukeqM63MlfTpE+SBSFrIz7bn5odBJH570E
         wIbBjKt+L8268fqHjIaQ709KNmhcnEEDqKcLR7ohoCPvF9Kb4H6jzWMqnwOaYaTX87WB
         hkeSPZ/KCk4FtX1lglCNLMgR99AK1ErAFE6IwSzrq6PuKOpPkHm0QbYNUogl9+90yCfm
         SufcHhfBCoE4EEg1ONy0b4VbrR2RvbsNn7zuNLNL11hzxVYPK3eX3nVs+ossXM+Sg22g
         dg1g==
X-Forwarded-Encrypted: i=1; AJvYcCUmFqeCPpL3RVW6CCsZPewPORXfdahUJyKYj/ghm9tfEx8ZVDhhF0ckhUUv2jYIDrzkmvzw3l0a5brtE7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxo5RK+HfKY8EDqYRQLxg2ttDRDRLpgX84FKVmhqRktXLPjmJ4
	4k33kf87fVJF/y01VBU1oPOPIbyKPcforRPBd5iTEt99Kqg7PtU5Xx4JSB6UO2UjvEM=
X-Gm-Gg: ASbGncuJHHNp2oMMc8I9zZRhRt094KoMSsMDwNAeKrG/bdCI92/ajIxebMyX9/tzyFQ
	uYqST4kRVQbaWGNM8rbYsGhUDscFjMnSf2pp9eV1UVtXwT80dK//5G69ws63tL814nX1wr9kTJg
	LkOt/8h99rbIYxgiNpvKPLVbJJ7ZKfTN9+6Ups253Xsfn0iVfZ8Hj4I+ETtsBC288rd8SKaQkMs
	3XG1MaCwmRnLzMbfLtvER/1qi+mUApLeKhwoLsTRrIklNm9VrfJBk3X7bB4S1nbVrKrQpxbsqRz
	cAniLWHG0Wmkoggg7d7oNNvolbJxtCVHxad65d76cW/ddRL/C8euKYO/2JxqRPFw0p9byTYDbNM
	NR8p8o/zJN7Bc5OlmER0s5r/fQLySZ9R+4f6+shEzRZ4XsFihaO/mfSzQawlN7qdL2reC5Lv/da
	Mma+H+fccVun1EokaY
X-Google-Smtp-Source: AGHT+IFdyzKUrKRAlW14tVUX4b2aHHspc9PvsRC+rGSFJEZ9Pd8418vrWH6Ug7r4l2yDUGoozqULLQ==
X-Received: by 2002:a05:6000:4014:b0:3ec:e152:e2ce with SMTP id ffacd0b85a97d-4266e7e0149mr20224020f8f.32.1760605776501;
        Thu, 16 Oct 2025 02:09:36 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ef97:57cb:86cb:f7c4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e1284sm33191287f8f.45.2025.10.16.02.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 02:09:35 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 16 Oct 2025 11:09:26 +0200
Subject: [PATCH 2/3] gpio: export gpiod_hwgpio()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-aspeed-gpiolib-include-v1-2-31201c06d124@linaro.org>
References: <20251016-aspeed-gpiolib-include-v1-0-31201c06d124@linaro.org>
In-Reply-To: <20251016-aspeed-gpiolib-include-v1-0-31201c06d124@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2579;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=XUEzgJKIWaOU7M01Lj57Hof44CTqsVlDHoOHP1+/564=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo8LZLfz4E1D7KIi+IF13RRnzlttgMRQMtMTXyT
 T8pl1U+bZWJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaPC2SwAKCRARpy6gFHHX
 csGsD/9IG3JL4wNs996oayX3obUxxPuPx7WtnTFG9Zz/7STe6Bs3vE7iYGDEdB+7w7c0usFGx6H
 f6bF4sfw5xMl7/nWM/BZhreiMkZ/5arno7zwm6zSsUJdhSSDf+LXFe3TUcoEF1SJCGK05XMOkDP
 FfMMW/lggT11D2LyLxFwwz6Dndun07u/ARkuQN2lVIsVuBZirAkxMhglPJctetYBczNNGK3Y05N
 EztIen5eCJ64VX0UFV7ZRSHosveM3eVSOMooQo6KFWqJ7tHHKxFjsulCtbWRSR5Msho6qHxc8cp
 G38EOz0ojt7EXrSNICnK4wGqSMEx8OiWLC9IveXoWkI2D5Pcj40w0uQAVqWH9t9oeXjDBlCoKXs
 CVCkqk/6t2wI3adax4H14MRqGsAEspJU1x3ak3L6WrnL5Zxo3FtgotN/dUIhdC/5j2q85v+oIho
 qXLZE1Pn7O/yNa1jAEk0JTCwbKRLLFa0UXGKJ+Dgffeae/KEmGXTZw9yGO9T85be16egWax+jVS
 cwrg0juZgZKe1A6zwlrctxg356u0V14r2yO+zGmjbVkcB7E3V4wWAHq0hEM82sbwXaa9mYK0A2K
 tmQroP4qMsKE1onX2wQ9SYB0bJHw+z7/IHutRY/XvVAjwZyjFKOLT2MvnVcgB8J4g3xpnU1h10c
 lzMNmtNCPdwKdNA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reading the GPIO hardware number from a descriptor is a valid use-case
outside of the GPIO core. Export the symbol to consumers of GPIO
descriptors.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c        | 13 +++++++++++++
 drivers/gpio/gpiolib.h        |  8 --------
 include/linux/gpio/consumer.h |  2 ++
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 5a450dac8f3acea3e381b09767b9fe9c9dadc2f7..a81981336b36db49d899634feafcd9bc25edf96f 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -235,6 +235,19 @@ int desc_to_gpio(const struct gpio_desc *desc)
 }
 EXPORT_SYMBOL_GPL(desc_to_gpio);
 
+/**
+ * gpiod_hwgpio - Return the GPIO number of the passed descriptor relative to
+ *                its chip.
+ * @desc: GPIO descriptor
+ *
+ * Returns:
+ * Hardware offset of the GPIO represented by the descriptor.
+ */
+int gpiod_hwgpio(const struct gpio_desc *desc)
+{
+	return desc - &desc->gdev->descs[0];
+}
+EXPORT_SYMBOL_GPL(gpiod_hwgpio);
 
 /**
  * gpiod_to_chip - Return the GPIO chip to which a GPIO descriptor belongs
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 62d4c15b74f580273412e6d432ab306a2d2fe682..14e6a9807a89da6d7c6594a0a2de5f5032c49e0d 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -273,14 +273,6 @@ int gpiochip_get_ngpios(struct gpio_chip *gc, struct device *dev);
 struct gpio_desc *gpiochip_get_desc(struct gpio_chip *gc, unsigned int hwnum);
 const char *gpiod_get_label(struct gpio_desc *desc);
 
-/*
- * Return the GPIO number of the passed descriptor relative to its chip
- */
-static inline int gpiod_hwgpio(const struct gpio_desc *desc)
-{
-	return desc - &desc->gdev->descs[0];
-}
-
 /* With descriptor prefix */
 
 #define __gpiod_pr(level, desc, fmt, ...) \
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 00df68c514051434e6fa67dc2307c6a8ce4ce3df..994d46874d560416175c9099e18180237839bd4c 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -171,6 +171,8 @@ int gpiod_set_consumer_name(struct gpio_desc *desc, const char *name);
 struct gpio_desc *gpio_to_desc(unsigned gpio);
 int desc_to_gpio(const struct gpio_desc *desc);
 
+int gpiod_hwgpio(const struct gpio_desc *desc);
+
 struct gpio_desc *fwnode_gpiod_get_index(struct fwnode_handle *fwnode,
 					 const char *con_id, int index,
 					 enum gpiod_flags flags,

-- 
2.48.1


