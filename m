Return-Path: <linux-kernel+bounces-764731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E05B2268F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C4E2620D53
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C4E2F5484;
	Tue, 12 Aug 2025 12:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DS3dxiUO"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08C42F5462
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755000792; cv=none; b=t0xNDLlwP+Va3W6J6Az2pnX/FATyaPjfujD358oYuLLTQQeAzuRdZwPvUayRVU3fVzZ8jN50Czp4cFFPthBZ80PvTuowvryusB3VDKsICRfAMhRerZnIbUSYRYNKKPc0sU0AjQeumAX+iev0AONBuAz77CTSCE4nYVmjrPL+qmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755000792; c=relaxed/simple;
	bh=f3XDHr8xYS2BjL20qDCCzhyytv+tnz4ZBdR/dqLusIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=szgdIyEW8uMVwCGQuylZnE/QZP23Z5/kniYnl6cPdtg/aPmRBKN+eNDRBnKuX+jll9NmZ+EYmufooBljg+P8QxEbuI2X12yrOO+AD3zMRkGtuwfNqHBnJKIZk7SyaF0EBXKc5lDCRC+doo++udWlakexmHszRRRaKGeGQQlwZSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DS3dxiUO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b7920354f9so4410095f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1755000789; x=1755605589; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cm9l30Z/3e08iuv7sMN2PFeVixoBoGdwhV2fpocwB1E=;
        b=DS3dxiUOQdF8F2QU1Z3VUDGOguEzWbbY+B7xTlKQzY/ZeicdG6jnx2kF+dG28SjO03
         IpPlyCGrkz00F8b87aFulhL8zAeh4ptFAs3MqpQ+g4sXMng+3rQnK9AyfONWQj+ho1y1
         mWyPKnEA6Hj7ou6+kWXC1ft1YSvwlYL1XWIrnmxYa1crgTbU71wYeT0WEnNzTfr/XgDm
         fMFxrnK06lKpsbuBgUv+Y+LhPeqyAB5DiSRGxWug9Te5/vdmv/FlEQObHvKTER5toknl
         1PFfwS3WxkApnuGhFlDNz/UL4vVfcJfX6GFVaHglfWVu/8NnFVzxCWSP4iMzMi4ymPF8
         eoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755000789; x=1755605589;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cm9l30Z/3e08iuv7sMN2PFeVixoBoGdwhV2fpocwB1E=;
        b=ZjinUoo4EyFs5E8JHVx/G8qxKSAYMt1iRVLRYniOGPhEmpwsNZfP8nFFIuftZzcawo
         0frW+TaiZTZux+tNmWOk6Vxts61xVHonxP40TCB1i2SAYSaYW8I+kZ0nOeYfJMH554VU
         nBJdblzv4UvsMU/5fW7dcRcSINDBE0/HX84tJKEX1musAeBrqFjkaM0YRycHFbnSkmY8
         5wU2ITwvvalTozrQHiixGUrI4KdMFyROx0L1ycyMvLB90GOWnPOuNBLlP5C+Oxw8/isj
         9+nOII8gKRj/2Hpt1qBX1kEkw71z6cbcya3Ol5qMlCyrgEaNbruwLcYUElGy3Qm9+aAX
         2cJg==
X-Forwarded-Encrypted: i=1; AJvYcCXT16jQLTVIwek2i4wHTZyC6TgEWKKpLGjZMgH2e/awowoBN0T7bZGdLRC7ibIwWJi5PbHvp/7Lx+oJOXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhsLXtLj6zbykjZzkOY7IBqZZwqS+GZBEDgJdaTP2l8zJ4fLX7
	1lBw3BlmRif+NYgoq2BXTNRlcs31KN0HcLpUn26djN/LkCBMYBrB4tkvOGqC64netK8=
X-Gm-Gg: ASbGncvr1hS7BYSJuIa0PpFxYhl4XHkvU26JqTC626xWtsCztArpLYN4uMtMN33NS34
	Uz6K0JUVvxDsFjKmK5CndwtLM1usQKmmrtbi4Bq/RxBHXtjVqX3TZwacjoKt3s2vFyunvUy1KXn
	o61FOPhkPp7dR+5fqTRkec6MhgPyLNvhH8G2KbknObYJDlimnNYEwSj2TttuhW0nvgqBSOa62Rs
	L2NI+l4TXAuSvDm5gKOdV6unI1+vaUMAEgukNhhUohMuGBBZJuYyxc7kunMuWhFfUAHec4QJTHS
	W42X8gGaxVxO0xPlBdv12FLNhunlGsT1nf0j9sSDNNmWrKpHX0NJTrGaDJZtxAMKj9rKkqsIKdq
	o/CL3JMprgf4YGEo=
X-Google-Smtp-Source: AGHT+IFQXAQ7qpkEpup7xPIu9okpJyvDOT/34sxosy38G+6R+J5XrkGBCBLacg7FEsa2RDxo9ZNkIw==
X-Received: by 2002:a05:6000:2889:b0:3b7:9a01:e4fb with SMTP id ffacd0b85a97d-3b91100ed74mr2497320f8f.46.1755000788945;
        Tue, 12 Aug 2025 05:13:08 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:16c8:50:27fe:4d94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e6867193sm298878535e9.6.2025.08.12.05.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:13:08 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 12 Aug 2025 14:12:56 +0200
Subject: [PATCH RESEND 14/14] gpio: ge: use new generic GPIO chip API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-gpio-mmio-gpio-conv-v1-14-aac41d656979@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1981;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=TSWl5L0uf8C7UyiKKr/acYMJZJe4qvP633C/saVULBE=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBomy/ChFeDpYsmN3Q3yVdyhWh6cz0WZObuwtri/
 Fq9Q1WkJumJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaJsvwgAKCRARpy6gFHHX
 cnmXD/wNlHHqx1JVE8MeQVNYMbGe1bcc3MsBaObydgCz7XjtgXUOIBh7CuLB+VXzI3fpEz6tgNI
 sLSkPXcU94zrIIJDZJzO33yBBq/j/o7NsKisJ+DzoYXYj0kU02WlNxZmXyRlJGHooPdJ2Yb0koO
 NGFems1l4Mj9BcSlVfbkqeJeNxBtpQSyLzmZHL3Kh96UIBA6SCSqFiM8VgevI2Lr8+7nPM5LYOf
 9mHJwrNVSBQ1x7NpvNJpQxzQNJPMoCC4tgWXW7E0ec8x7of97EPIO2x9Y+OJD352jp9UckI6d1x
 x6RCfaXQkJZC2EjWuc+VlNRNvzfUSmpnEN67mZj1eYk+7tAISorptDAwi7EVJ5we6UuQoQQmp6C
 NltWMVrm4etSC85EMsz8nZ+Aqh4e2cpjqyroWJy7+GoCI7uJYnn+R1hSyMDRcAVTBqUpnO/ZiM9
 QvmtN51uTfPxhOaWaPXf8rO+/BYYAMcBuyC2DCK6tn0I1EdTzIQWxs0VbhCJG/vVJEitD+Nv/e0
 wakgadtojeifeSOaDteqdRvmSysC4uvI9uwclkNeYtS0tobrSkvBkL4cfPIChpafeDqbo2G55AN
 /a6NCyokCVJCNGhlNG3PLIeI+DHsklg/ZWJJKNrM360P5rXGffHy5JnhJ0NhJ4/A/snwu2G2YSr
 lUL0MVJzfi12CTQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Convert the driver to using the new generic GPIO chip interfaces from
linux/gpio/generic.h.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-ge.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-ge.c b/drivers/gpio/gpio-ge.c
index 5dc49648d8e378e9741213f9c2de05b4c75b347f..a02dd322e0d4cecd4564a71a550204983df33568 100644
--- a/drivers/gpio/gpio-ge.c
+++ b/drivers/gpio/gpio-ge.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/gpio/driver.h>
+#include <linux/gpio/generic.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
@@ -51,24 +52,36 @@ MODULE_DEVICE_TABLE(of, gef_gpio_ids);
 
 static int __init gef_gpio_probe(struct platform_device *pdev)
 {
+	struct gpio_generic_chip_config config;
 	struct device *dev = &pdev->dev;
+	struct gpio_generic_chip *chip;
 	struct gpio_chip *gc;
 	void __iomem *regs;
 	int ret;
 
-	gc = devm_kzalloc(dev, sizeof(*gc), GFP_KERNEL);
-	if (!gc)
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
 		return -ENOMEM;
 
 	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-	ret = bgpio_init(gc, dev, 4, regs + GEF_GPIO_IN, regs + GEF_GPIO_OUT,
-			 NULL, NULL, regs + GEF_GPIO_DIRECT,
-			 BGPIOF_BIG_ENDIAN_BYTE_ORDER);
+	config = (typeof(config)){
+		.dev = dev,
+		.sz = 4,
+		.dat = regs + GEF_GPIO_IN,
+		.set = regs + GEF_GPIO_OUT,
+		.dirin = regs + GEF_GPIO_DIRECT,
+		.flags = BGPIOF_BIG_ENDIAN_BYTE_ORDER,
+	};
+
+	ret = gpio_generic_chip_init(chip, &config);
 	if (ret)
-		return dev_err_probe(dev, ret, "bgpio_init failed\n");
+		return dev_err_probe(dev, ret,
+				     "failed to initialize the generic GPIO chip\n");
+
+	gc = &chip->gc;
 
 	/* Setup pointers to chip functions */
 	gc->label = devm_kasprintf(dev, GFP_KERNEL, "%pfw", dev_fwnode(dev));

-- 
2.48.1


