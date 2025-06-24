Return-Path: <linux-kernel+bounces-700285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA15AE668E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 15:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C2517315A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 13:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969C82D0292;
	Tue, 24 Jun 2025 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="g9pibnnV"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0EA2C158F
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750771673; cv=none; b=Es/bd4EbHEh0EEhBWBG0kIf7gK3kG6vNV/f9BcSceXB8+CE51+i2mZEAayj3mKHiJEVCtlVLuGj3m8JFlLAIyvD0Uvah8MRSH1dsRY9qS+1oCn1bmYiicWl+0XGLJLoLF/j4TFXyaiWBKemjViegTNkdh1EC5gz4j7xUpdHmRts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750771673; c=relaxed/simple;
	bh=4sAXU9caGg9f/DjHncEPIA7KaN/pWf+xDxVR7QJuIB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y0ODmsBnjh4rFzAs1tmIlaySKBKgBFThEv9LpUPezcEROUfeb/Xt1reBK7T4F6qotoSrYGGobqjj/gQFIsJ1WCL1dSVszX4qPa6sk86247nvT6fu0y4M1axOsQ0QPR/TBzsMHIoBopMuW/Jle/c4KvAaaMd5ZGOZhbQvrq9ON1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=g9pibnnV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so3436335e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 06:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750771669; x=1751376469; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BZNYZ4uzmMTmFUY45XO1zgtp9A/k49xGz2UfsvZ/gw=;
        b=g9pibnnVbnZ5kDs6TnGJ4p8A3Z8L0dpa5Ps1Px/0m4eIoCFRDDFWjN/Qz9fMVd2GdW
         rUIem9tKy38iQqSNXxswBGSEnUxmnEXX6v/WuVOe+UzVnO2wgRptb0KtednuEQM/h2Cw
         yCgpax2NXm7uEYQ4EvrjT4UaCwg8OuJ/f16LJ3EpPqRKrLO8VwqLI7T7ui3MF0wKJ1Pt
         9XDGY4bzoMkkPmDtNh8z8scwG2eqqKkuFsM7wcErUGWibpvE1BNUgQTc1Xy/g+R9iRAV
         6oYFte3bi+rHoSKY3qYeytfYpI52Kw4GrtkE06p1piUpFLqeJzBoSMD61nZblSgx0999
         MbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750771669; x=1751376469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BZNYZ4uzmMTmFUY45XO1zgtp9A/k49xGz2UfsvZ/gw=;
        b=WYPQ+OH+cAg3Avs5kVsoF2fncjdBfnnbxh3/1lBJDC21FgmuzGWcCBNBgG/iOWGG9X
         4cukbiZXSIvsPo1EnekGSn2dslVTWjgxDO09KwfR1zunX609d4RtBsmk8CSXLNmBfsg2
         cOGLkSpp5sYkcLmZRbs5tEFOGCKlmrTeZ5OUsWVWtqxp5IreJloNq4mpoNQsXppfcjLg
         vbYnaqk+r2R7Re6XnN9wtGe2yDMAM2wWetZmlqcfOwBDpHZg6O6jlSj+A5FgQd5tbQGd
         kgGDaHqUTowZWS1vlJNNqkjFZ5PyW72oQgjnJ6GEYJYkm8jM8PQz32ysluukAgSeMjTy
         aFnQ==
X-Gm-Message-State: AOJu0YzcM8Zv/JtCp+1IcGxAAggUrByxNaSx9qnOpEOuTA6lSfGbPO5x
	jLJncBphHP1290YgkcvpIuc2M+9cDRrmlEAeD54qJTgXLrx5jNEsxl8fl2V0TseKdPs=
X-Gm-Gg: ASbGncv7YUd/zvn3X049doj2wSNaUnRmD+DMoy/qpdJEu7ZKfQzLFlLTzsSYACX5d0/
	qYjkBumASxdA1cTw4WPl+nIJtMtgLy5OdwL3rbA5wpbS5eowKS2++Ov5cjRNTmThGAc2TfSd8pQ
	oK0pvnyg+htXY50lno36pWEU0a6S5ZHgpfgs6eYfv9jn7DjFiBtNCLpiEgqB5E6l6AB0REqBDsl
	59HaQsnFjVytbO354A3NjeyZ0aXuzWXRxApN9/t6EFFcnnVC8Fsatx66WOh33vRSfIRYOLgoy/a
	HJcasiJlgQAd+Nr0bjH4TcS3iRxClhKT83MWEFbSOinhOAZUsgEU0gY=
X-Google-Smtp-Source: AGHT+IEUbPKcWbn9NN2y6f1Hc3c97b8DvrWEquHy3uhBBn6lW/jObv1Sw1EXdMfJS/xPuPKek3QNuQ==
X-Received: by 2002:a05:600c:840f:b0:453:c39:d0d0 with SMTP id 5b1f17b1804b1-4536539c48cmr145546035e9.13.1750771668863;
        Tue, 24 Jun 2025 06:27:48 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:34d2:109c:3293:19e9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453632312a3sm152588485e9.1.2025.06.24.06.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 06:27:48 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 24 Jun 2025 15:27:37 +0200
Subject: [PATCH 5/8] gpio: cadence: use lock guards
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-gpio-mmio-rework-v1-5-aea12209d258@linaro.org>
References: <20250624-gpio-mmio-rework-v1-0-aea12209d258@linaro.org>
In-Reply-To: <20250624-gpio-mmio-rework-v1-0-aea12209d258@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2927;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=untPBAM91123AoBXnC7kV8/BRVDDOFFauDcUW0X87cQ=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoWqfM13Dq0oK+m+cELMPgv/E6/IQGi1X/lJOCc
 a2U5/8yD9CJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaFqnzAAKCRARpy6gFHHX
 ct7uD/sGNCGk7mdxy9ZfPSIWzM1QufC2JrgdiT1Y4C0v/JOJlMDMByILNEMjNuLqPvYwu4UsuXi
 YaTQmzyJRfcrSaMpBo3MLw6yTsNjpbfEj3f0tc6JXKuN63anO0yf/GAHqr8QwbT0pwtHlqQ2+8+
 dao1qn7AP5NrxRlsb4M0FZBu3aTN32jv/7T/s7PL/ccIhaXy9QCmZ2rPYvIw5s9tl3ufYMQewpi
 wfwRzY+d5/hTin8rVg6a2EHUhzg6lSdwlgmXHUk800A9HoObSpf0bu7te+fsVPL8H4LQJkhgf+w
 8dJhcLVkwQGUbJ4lQf3l22eqiC6H6ypmYV3/kdetNm5+hUzZjw/eeqHr2ZxboZW3S2DJPPQJUVX
 nZw4HQTJ+ifS7tPp8XKWk2bn5l8zQWL6E3S/XmPvhLc1SYXKoz9I4V3U8XB4NVhZYme2ZQQ91HC
 LkgmBLKRb8LTDwmM7TVxVpqxrFl93lY0E9JPkuKOirXbPyWFM4zp+ru9JOa4Ldd7YwFcYaL2CXy
 3CIQUTblBcFwqb94o+y4qAAWyBzUzjD4QEhX81FS2YtbI2QHT0Iy2hRWsqsVgirNrDi0zoQined
 bpUiuzHCs3kz55dzOzWQLeCyWnEQqPosBKqSmfTwwzXF+BB0ITuGzOHKFwOOCj1n3valTMFGx8x
 i/798StF+aw8Erg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Simplify the code by using lock guards for the bgpio_lock. While at it:
move the gpio/driver.h include into its correct place alphabetically.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-cadence.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-cadence.c b/drivers/gpio/gpio-cadence.c
index e9dd2564c54f879cf1d49442dfa3db0004473d35..e6ec341d55e9047b2fa8718799ba72d54624388e 100644
--- a/drivers/gpio/gpio-cadence.c
+++ b/drivers/gpio/gpio-cadence.c
@@ -8,8 +8,9 @@
  *  Boris Brezillon <boris.brezillon@free-electrons.com>
  */
 
-#include <linux/gpio/driver.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
+#include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -38,29 +39,24 @@ struct cdns_gpio_chip {
 static int cdns_gpio_request(struct gpio_chip *chip, unsigned int offset)
 {
 	struct cdns_gpio_chip *cgpio = gpiochip_get_data(chip);
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&chip->bgpio_lock, flags);
+	guard(raw_spinlock)(&chip->bgpio_lock);
 
 	iowrite32(ioread32(cgpio->regs + CDNS_GPIO_BYPASS_MODE) & ~BIT(offset),
 		  cgpio->regs + CDNS_GPIO_BYPASS_MODE);
 
-	raw_spin_unlock_irqrestore(&chip->bgpio_lock, flags);
 	return 0;
 }
 
 static void cdns_gpio_free(struct gpio_chip *chip, unsigned int offset)
 {
 	struct cdns_gpio_chip *cgpio = gpiochip_get_data(chip);
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&chip->bgpio_lock, flags);
+	guard(raw_spinlock)(&chip->bgpio_lock);
 
 	iowrite32(ioread32(cgpio->regs + CDNS_GPIO_BYPASS_MODE) |
 		  (BIT(offset) & cgpio->bypass_orig),
 		  cgpio->regs + CDNS_GPIO_BYPASS_MODE);
-
-	raw_spin_unlock_irqrestore(&chip->bgpio_lock, flags);
 }
 
 static void cdns_gpio_irq_mask(struct irq_data *d)
@@ -85,13 +81,12 @@ static int cdns_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
 	struct cdns_gpio_chip *cgpio = gpiochip_get_data(chip);
-	unsigned long flags;
 	u32 int_value;
 	u32 int_type;
 	u32 mask = BIT(d->hwirq);
 	int ret = 0;
 
-	raw_spin_lock_irqsave(&chip->bgpio_lock, flags);
+	guard(raw_spinlock)(&chip->bgpio_lock);
 
 	int_value = ioread32(cgpio->regs + CDNS_GPIO_IRQ_VALUE) & ~mask;
 	int_type = ioread32(cgpio->regs + CDNS_GPIO_IRQ_TYPE) & ~mask;
@@ -108,15 +103,12 @@ static int cdns_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	} else if (type == IRQ_TYPE_LEVEL_LOW) {
 		int_type |= mask;
 	} else {
-		ret = -EINVAL;
-		goto err_irq_type;
+		return -EINVAL;
 	}
 
 	iowrite32(int_value, cgpio->regs + CDNS_GPIO_IRQ_VALUE);
 	iowrite32(int_type, cgpio->regs + CDNS_GPIO_IRQ_TYPE);
 
-err_irq_type:
-	raw_spin_unlock_irqrestore(&chip->bgpio_lock, flags);
 	return ret;
 }
 

-- 
2.48.1


