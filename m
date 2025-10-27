Return-Path: <linux-kernel+bounces-871728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5B2C0E28D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E445B1888D19
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA481305051;
	Mon, 27 Oct 2025 13:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="txu/0qKc"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8993D3009E5
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572901; cv=none; b=Gb2MtsGDDYwwfTKcnUpeKB5W3qk2r+p0IlcPuyAUu2NgnWjOqKtiwTogBeu9j7V93zrsP3jWhye604WwgdIT68uCaI/j+FiejxJrGdzO8fgp9RziIRMMUSywkgxAWA2nzZNuwcJeIuf4EaM6KL6PXeUkEFCdZC/vZ4scKkqeaUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572901; c=relaxed/simple;
	bh=AMTMzYIR4DDJTLX9LuQFH6GBjdRQeMAJzoxVs+wkijQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i5kvgQTUA3DNdQ97wJMmfhXM+me3LfqXyzwXZo1iD4RmbkPwTAcwqCgLHSsbJ79x+7xhLbieQ+bwh6OD6crItxYq3iGiSIN3rlNx8uVHQlJJeYmeDjCVAC+Pp1Psootm0heBhJnyL/MQhzJzvTfppUA8V0+3ZQbDfxxwAX+0EPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=txu/0qKc; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4710683a644so39146655e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761572893; x=1762177693; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZOdtbgbAJjZxUvzAQjPjHhdoeRKY+ERU8nQDCPTZxY=;
        b=txu/0qKcJFnr43X1fzmRasz5QR9v281C4JhXraJFEQ3W3xvg9eVVkiN7Bw4mlxOPKz
         74OBaEhMYA9iSLUqKWcbq89chXuepJDIUx1K6S1due6VnN8B0eZnO6cygcPfG91K0hgY
         1wDPSrK2IxC7KMAfyjy0+StfaKTxevJZl4BApXXIPiUBhZVX7epq9Tdba4yBZAJvYZIY
         G2byf1xiYTlsCYK+Q6z1+DrH7LWH3SaQCSLBq2UZvwaMivUUoc+ZGe1gPgA6mXUnJZhX
         5J1mSA8BcgBl2A0RzBE+H6mNrLYePfEpC/gTWtS1Q/KtpBLSMrxzjkAcb2orNfTChCg9
         NbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761572893; x=1762177693;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZOdtbgbAJjZxUvzAQjPjHhdoeRKY+ERU8nQDCPTZxY=;
        b=TzpljGMnIyed2DSKLsT5Y4OqQ3MRLe9HZ21MLmx+v/Zy1eF8LgnoBrfrmCoeKHYu6b
         N4WAVR0Oqx91tb3jKpiyMOYNLxhRAMFz6DR3PGbh8v1OpUK1bfbaspe2V0gbF++yrs0s
         zsNuJFo/C3SCdfxbSIToTmuTUE9XJsgnAk5CaspDQA07sbAsv/S4yONrSKS7Zb56zvUW
         jnF4csKnhcufd9+mLr30oxhKzewn9VAMcIcdAthrRg5HUIFeYAtr50zLb5561fJ4I9z4
         UO0cDTRWUpZN6y86niVWzZI9c+nF6T/Eh6DDRXHRGq1Hd3Pbd+9MgU1pv9cCCl5HBX/5
         11Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUqEFFpEtxpiS9G8uhQi3aSq6DANxY7ZvwPPW8wiPG2qGtymK0b33UNmwsnxDkH6v4yw8cuPh+juoEUNDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFM+aeKy18YaR/Z01aeS7qS/S7Ua7wgU8FpzTEtgloN2TwQI8c
	fDwStS0TplTewJxBLOkgxCIhsE8akNf1nk/TJq7/u5cuSPa26UlVktQzuM5IcPmeITA=
X-Gm-Gg: ASbGnctXrZhs5ROhkCo7EepgK6372dVXiTnOK2GfIoe++AiBG3ZOlFwsm+GkSBm+TM8
	Mw09Px6b1zNJciglmIwAR5oqR5Kx9XxV+dSYbmzetyN9WNmbi8anJEmnAwuBD76K/O4AYlpPv4z
	ABreBwI4mBLqRjtV7q8l9QcihORBhbFwG7MQj8WrJDKtE1MqVznuqG02F0Sayt4Y/M1D203g4Ec
	HlroQUvKHJSW0gb9r8VuVBTiur1evqWhQLTPvfKWcIhesI+86B1yGPqswSUGZXWVEA107ZDbH5h
	TLi6L/m2xTTzpWs0CVDJ2QnLo4dppu72XWCmLYXm9q53HTLNgODBg3Ng4qfpjc0C0BVQX0eMVln
	a3PKIRuefjFnV6kE4b7DGgU9qt3okHPaUlvLDsHCqCSF3bl27Qg/LA144mHx3/0h0seJguwo=
X-Google-Smtp-Source: AGHT+IEGGWvDjLmaN9EsIELyDZ5VldXpDwTQugsaTK5ibfAT4aDyN22LcgDQRCumfex0XJrAMxMr2g==
X-Received: by 2002:a05:600c:6049:b0:477:11a0:b746 with SMTP id 5b1f17b1804b1-47711a0b96fmr19545635e9.6.1761572893331;
        Mon, 27 Oct 2025 06:48:13 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:c1c6:7dde:fe94:6881])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952db964sm14483390f8f.33.2025.10.27.06.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:48:11 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 27 Oct 2025 14:48:02 +0100
Subject: [PATCH 1/2] gpio: mmio: use lock guards
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-gpio-mmio-refactor-v1-1-b0de7cd5a4b9@linaro.org>
References: <20251027-gpio-mmio-refactor-v1-0-b0de7cd5a4b9@linaro.org>
In-Reply-To: <20251027-gpio-mmio-refactor-v1-0-b0de7cd5a4b9@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4407;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=8HvOkKg486JjYqNH7zy1hHaXeCKfJW0HwXQyvvQTz04=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo/3gZPtUI9fLGwuqo1eVVXayxmtz+2KmxmCj5+
 VtVxqRQvQGJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaP94GQAKCRARpy6gFHHX
 cv5ID/9r+2dXkU8/bFMPiabT1dgl49MYpjPNjaPPqxBN+7YcWvg0HfAU38cT04AVMQvHhFMlFMh
 x3jbIKpPF/2c+L9+VKtgovu5IOttwvfLqVzZkZxLuualjYuwD5TX3zlMduQeVfCvBsnxMt4t5bY
 hl2YNkZbmf5aIheBqzdLsjqlnLfyDxiPangblZxfHh7G3fFIpw9deDiXaD3lJSIwKWGR/8b4wIX
 5MJ0Tz5da5iQfXpuS8yj6c66kAh73Vo6ZWeozEGrzFOYb4y404FWN/KncJM+XJ4KAypW+B4epI2
 aitVluCYJv3aR7833aTg58LPnxK+VmzcS8fk3BPHsSi1RbcYxxUG5PV8TBtKt6Zl6UrtxhrGgDR
 GMZbTHX7B3VtuWCtgIRrFqXq6CGE7HZm227rS9tmeS0CbKjvP/5hr3rzCQwowqUjVH/OC0CBFjN
 mVKnlJ7vn4nIn/CsILBbZUFJnLbpIhXrPi/OfpcoZ/KCn37s43xvK7ot3WdPkBJjUmQ53NCLGuV
 vjPnSULyZo2HFWruKYYgDNLdn+ewf0Z9eZpTm0pOoxD9X1wU+ivVsd4XYPcmMqlBexQim3RC17M
 1nIJysvY9HG0G1CobOpv/DWjoKX+cmkOF30QvCyE8IesCdqiwUokSK3vTnZwPHSl2TXg0VJrqIL
 /5RTx9HMV+xw/dg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Shrink the code by a couple lines and improve lock management by using
lock guards from cleanup.h.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-mmio.c | 40 ++++++++++++++--------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
index 7d6dd36cf1aeffeab96704821e0b280727346f6f..95ebbdf04343b81b1b8d836542c324bffb9c40e8 100644
--- a/drivers/gpio/gpio-mmio.c
+++ b/drivers/gpio/gpio-mmio.c
@@ -41,6 +41,7 @@ o        `                     ~~~~\___/~~~~    ` controller in FPGA is ,.`
  */
 
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/compiler.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -229,9 +230,8 @@ static int bgpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
 {
 	struct gpio_generic_chip *chip = to_gpio_generic_chip(gc);
 	unsigned long mask = bgpio_line2mask(gc, gpio);
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&chip->lock, flags);
+	guard(raw_spinlock)(&chip->lock);
 
 	if (val)
 		chip->sdata |= mask;
@@ -240,8 +240,6 @@ static int bgpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
 
 	chip->write_reg(chip->reg_dat, chip->sdata);
 
-	raw_spin_unlock_irqrestore(&chip->lock, flags);
-
 	return 0;
 }
 
@@ -262,9 +260,9 @@ static int bgpio_set_with_clear(struct gpio_chip *gc, unsigned int gpio,
 static int bgpio_set_set(struct gpio_chip *gc, unsigned int gpio, int val)
 {
 	struct gpio_generic_chip *chip = to_gpio_generic_chip(gc);
-	unsigned long mask = bgpio_line2mask(gc, gpio), flags;
+	unsigned long mask = bgpio_line2mask(gc, gpio);
 
-	raw_spin_lock_irqsave(&chip->lock, flags);
+	guard(raw_spinlock)(&chip->lock);
 
 	if (val)
 		chip->sdata |= mask;
@@ -273,8 +271,6 @@ static int bgpio_set_set(struct gpio_chip *gc, unsigned int gpio, int val)
 
 	chip->write_reg(chip->reg_set, chip->sdata);
 
-	raw_spin_unlock_irqrestore(&chip->lock, flags);
-
 	return 0;
 }
 
@@ -303,9 +299,9 @@ static void bgpio_set_multiple_single_reg(struct gpio_chip *gc,
 					  void __iomem *reg)
 {
 	struct gpio_generic_chip *chip = to_gpio_generic_chip(gc);
-	unsigned long flags, set_mask, clear_mask;
+	unsigned long set_mask, clear_mask;
 
-	raw_spin_lock_irqsave(&chip->lock, flags);
+	guard(raw_spinlock)(&chip->lock);
 
 	bgpio_multiple_get_masks(gc, mask, bits, &set_mask, &clear_mask);
 
@@ -313,8 +309,6 @@ static void bgpio_set_multiple_single_reg(struct gpio_chip *gc,
 	chip->sdata &= ~clear_mask;
 
 	chip->write_reg(reg, chip->sdata);
-
-	raw_spin_unlock_irqrestore(&chip->lock, flags);
 }
 
 static int bgpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
@@ -394,18 +388,15 @@ static int bgpio_simple_dir_out(struct gpio_chip *gc, unsigned int gpio,
 static int bgpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
 {
 	struct gpio_generic_chip *chip = to_gpio_generic_chip(gc);
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&chip->lock, flags);
+	scoped_guard(raw_spinlock, &chip->lock) {
+		chip->sdir &= ~bgpio_line2mask(gc, gpio);
 
-	chip->sdir &= ~bgpio_line2mask(gc, gpio);
-
-	if (chip->reg_dir_in)
-		chip->write_reg(chip->reg_dir_in, ~chip->sdir);
-	if (chip->reg_dir_out)
-		chip->write_reg(chip->reg_dir_out, chip->sdir);
-
-	raw_spin_unlock_irqrestore(&chip->lock, flags);
+		if (chip->reg_dir_in)
+			chip->write_reg(chip->reg_dir_in, ~chip->sdir);
+		if (chip->reg_dir_out)
+			chip->write_reg(chip->reg_dir_out, chip->sdir);
+	}
 
 	return bgpio_dir_return(gc, gpio, false);
 }
@@ -437,9 +428,8 @@ static int bgpio_get_dir(struct gpio_chip *gc, unsigned int gpio)
 static void bgpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 {
 	struct gpio_generic_chip *chip = to_gpio_generic_chip(gc);
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&chip->lock, flags);
+	guard(raw_spinlock)(&chip->lock);
 
 	chip->sdir |= bgpio_line2mask(gc, gpio);
 
@@ -447,8 +437,6 @@ static void bgpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 		chip->write_reg(chip->reg_dir_in, ~chip->sdir);
 	if (chip->reg_dir_out)
 		chip->write_reg(chip->reg_dir_out, chip->sdir);
-
-	raw_spin_unlock_irqrestore(&chip->lock, flags);
 }
 
 static int bgpio_dir_out_dir_first(struct gpio_chip *gc, unsigned int gpio,

-- 
2.48.1


