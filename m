Return-Path: <linux-kernel+bounces-679449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04896AD367D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 14:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805AE189A193
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 12:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20879298240;
	Tue, 10 Jun 2025 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zDhzkMez"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1067E295DAD
	for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558813; cv=none; b=VYFkXdz+L6+vgkKosgEyxJPj6HZn8nRptdNhBQSiWtO9INMeKuhXk322dCmaK26hljt6Ayit/qEAj5GPe/CRmj23StJQ8by+Z7aMuUVa12X3RBUYsBWsM5vYjc9Jw9vPaERRaem7uvW3faSTBcpPXcrXcxyexHdlqwMWXDg6uGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558813; c=relaxed/simple;
	bh=fwfQg190abE0E91/VWzBk3aED/FxotuW4ck3Px0zeW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PV8POM9qiJ5FzjESCvbk7c4njYHndWs6QBa4D3scejrW6gSONwQb0NU+TtqXzZdKEAGigncQX0RlIFiKGse393V0tQJWpzsq1l60qPils3AqQz+JQCRogJdTX5oi+2WiEXyNIS+cAgsWeTBEcpC5tOBYreSPojGtBqXZZEDlLjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zDhzkMez; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so2076990f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 05:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1749558809; x=1750163609; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3F+4kh8HnzcTAXwMgO05FwI7b8fR5vWj+INTIOT0oXg=;
        b=zDhzkMezvDmCjkfyPixWhtPPn0fRvUBw2KFnbtnh0SicjGA02/MNx3znhD/XUZE+w6
         l2KStlmsm5WijgwDnNZL0ZR+asaKp3jEweuQ1DPAHoLK10uYinNLv9D+C+/JULR+Evmm
         d2pYVNjIu48DyvBTVH3yGHVDgri9ljgwruSxJxyjexMPVIj5W8cIDMByB6cXPKDPjoJg
         p8ohdw+f6uAK9aIKtotxPN+CFMOk4DdFBW802rm6+HDSXRz9/dtFx23pSIa496eOhmVT
         JkMGLJglWOmm3IYftdSNIh8GfOhVAQjAh6/4v0Rq2bY3ZbOAerNFsVP+lAi93xSVUwV1
         XKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749558809; x=1750163609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3F+4kh8HnzcTAXwMgO05FwI7b8fR5vWj+INTIOT0oXg=;
        b=uXIRU73mfb8RzXmzdfYtC7HvcQg1MFKam8NCdK+iQUFl2KU5xnztNUCt4RPAzFLuTH
         xDcMQMuwjCkGwuykRrAj4u69Yp+hwzIPAnIwyqRlmfpFXO/Nx8uCP+5sn5JbJ3fioJQh
         wXViIAnLw+qEBEA/ANRR+ZudxygziH7E58NLTs6o4PhTQpSCL4xDZLyYCMpCH43btRKD
         x09vwllLiBzoMFHRRdeVUqlS6uHcGDJDkEpxWh+9j+0xhbEBZFHC0UO7gdATIteD+cip
         W3wsM8J36loL3ssA6e9FTZ8IfF0yweQWuG1w58j0FubaDvMbtAkBF3dZ36vuBw7Yvesj
         XNpw==
X-Forwarded-Encrypted: i=1; AJvYcCXo/xhnk/NCF2HkNunzgSOxsTRlbh3FFR1aUXCE7sx4RX5G+VU7L9wXB7+XM42KdK0XJ+tT+Q+mlgjovKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfMTKj46wCD6W6mM8RSfo/CMBIHVXpEPXESIhhT65jQtTEKbor
	QWFSP7+PwdUuEF9uZGRrhps7qx6Nk3B9CXYRI1Y0mLjY+cIiyrL8hiOQ6X3X26eH54c=
X-Gm-Gg: ASbGncvZgRx4Qed6nStnve0dSF+Upu3Kw5HFm8VLfnsOWwNnbzS/H+QroshWWnEks2F
	0lB1rN/1iyeAzGlsnlSlNj1gOJV0USBrY6wXCDsLjpFYiAn6+qq6gMDXboO0pOyZ607qBG+r86Y
	NWB7kSGPElHXa6IV2PVmur4bAOGr1GJbMHUuLVe3ImZj8DIBIsfgaYD/y5C/nx2rLc4SXdr1OkS
	Y73NvNgWYgFz72zMkBHvYeknLs9mM95VirECNcB67w9PuVsXZJMKbRSCCdSCZUm0IvutMReHRxT
	jNOZmcoXgd9bu+B+u6pWAhPWHM7BaQtcF1UKoMWtLMs2Emx5eHQsUrU6yelp6rVZ
X-Google-Smtp-Source: AGHT+IFTYvxx+yPM6Fsk1C7fqSFoF6VLwEGT1tv11cW8KGpzuidERKwWdXVAfe2jAdVBle4RMS66FA==
X-Received: by 2002:adf:a342:0:b0:3a5:5299:3ae2 with SMTP id ffacd0b85a97d-3a552993bbamr1564362f8f.3.1749558809156;
        Tue, 10 Jun 2025 05:33:29 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:4d:e52b:812d:eb7c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53243661csm12290668f8f.53.2025.06.10.05.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 05:33:28 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 10 Jun 2025 14:33:16 +0200
Subject: [PATCH 06/12] gpio: mpsse: use new GPIO line value setter
 callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-gpiochip-set-rv-gpio-v1-6-3a9a3c1472ff@linaro.org>
References: <20250610-gpiochip-set-rv-gpio-v1-0-3a9a3c1472ff@linaro.org>
In-Reply-To: <20250610-gpiochip-set-rv-gpio-v1-0-3a9a3c1472ff@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Daniel Palmer <daniel@thingy.jp>, Romain Perier <romain.perier@gmail.com>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
 Grygorii Strashko <grygorii.strashko@ti.com>, 
 Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 openbmc@lists.ozlabs.org, linux-omap@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2989;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=TMx8xoTgcbqz3Qqy5NSYm5JAQDdrcON6VQI7QNVNO/w=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoSCYPCFfXkFBozviHjnoa/3QfnofqJwkCL0YGi
 UwKuobyQmyJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaEgmDwAKCRARpy6gFHHX
 cibjD/93BIE6A13TiKE9ysPDcrvPFrMv37iv7QXsvm0Lmv6wlgcG1+dairOOfUdjPMav8dlioDH
 8HTVlXxB0bqzKYrcS3mMMtkC0Q4qk+AhHImuFtNEKTIBl0+pBdYkrtisnh04673bsig5p6E+mlx
 JZijDEApCXAyE6O0CTrkgHRAb7i4AYOnDpnA1QohI0S/3WAQVPHJz09AmYsiqHLOcKbfT33n6lM
 tvD7LNztj6gvgddKar6MiiGD0Q/Ak+9crMBkju3I/FX2F7M2nOC8TKyVwk32eeIsvIczMIwnAnF
 v8O60v3shWlZ3IeiheyA7oiShU0F2/gUokAkpw9C5j/jY7mAB6zr8Fo21I6CMBjJgPG74UuyDlu
 GtGi5/jpDloLA8HOKSmNveS9WXC6IBcN6E5O1v8mXcjGTPr/1dbngoICJLlXXR5CPwEV2Cdb7aS
 +DYdfjcEIoA1olpZVfmqJtn+VC4VupcMQQnurxBHJa5cfDLRnKNvoJmSH+YnUXSxlnOo+8idA5e
 CMA8uth49bFCKuH+LjcK0+Atd2lYC8UDt+Zr9gOavzjr3DVEqp119wb0A+BOCHgtmO8KpHgr0nO
 0x/TjKxvqy6vM0e5hyVCvN7WbJSAsiw9m2LS+jMsU9hRHbm/PeAn7d8RD73HDqVCfA7JlvGSO8S
 vgw27DKUKWSkanw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-mpsse.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-mpsse.c b/drivers/gpio/gpio-mpsse.c
index 3ea32c5e33d1a445dec02996744429f17ec61af7..b17de08e9e03c5ce05ca5c1bbbb8a0f83fc2ba03 100644
--- a/drivers/gpio/gpio-mpsse.c
+++ b/drivers/gpio/gpio-mpsse.c
@@ -160,8 +160,8 @@ static int gpio_mpsse_get_bank(struct mpsse_priv *priv, u8 bank)
 	return buf;
 }
 
-static void gpio_mpsse_set_multiple(struct gpio_chip *chip, unsigned long *mask,
-				    unsigned long *bits)
+static int gpio_mpsse_set_multiple(struct gpio_chip *chip, unsigned long *mask,
+				   unsigned long *bits)
 {
 	unsigned long i, bank, bank_mask, bank_bits;
 	int ret;
@@ -180,11 +180,11 @@ static void gpio_mpsse_set_multiple(struct gpio_chip *chip, unsigned long *mask,
 
 			ret = gpio_mpsse_set_bank(priv, bank);
 			if (ret)
-				dev_err(&priv->intf->dev,
-					"Couldn't set values for bank %ld!",
-					bank);
+				return ret;
 		}
 	}
+
+	return 0;
 }
 
 static int gpio_mpsse_get_multiple(struct gpio_chip *chip, unsigned long *mask,
@@ -227,7 +227,7 @@ static int gpio_mpsse_gpio_get(struct gpio_chip *chip, unsigned int offset)
 		return 0;
 }
 
-static void gpio_mpsse_gpio_set(struct gpio_chip *chip, unsigned int offset,
+static int gpio_mpsse_gpio_set(struct gpio_chip *chip, unsigned int offset,
 			       int value)
 {
 	unsigned long mask = 0, bits = 0;
@@ -236,7 +236,7 @@ static void gpio_mpsse_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	if (value)
 		__set_bit(offset, &bits);
 
-	gpio_mpsse_set_multiple(chip, &mask, &bits);
+	return gpio_mpsse_set_multiple(chip, &mask, &bits);
 }
 
 static int gpio_mpsse_direction_output(struct gpio_chip *chip,
@@ -249,9 +249,7 @@ static int gpio_mpsse_direction_output(struct gpio_chip *chip,
 	scoped_guard(mutex, &priv->io_mutex)
 		priv->gpio_dir[bank] |= BIT(bank_offset);
 
-	gpio_mpsse_gpio_set(chip, offset, value);
-
-	return 0;
+	return gpio_mpsse_gpio_set(chip, offset, value);
 }
 
 static int gpio_mpsse_direction_input(struct gpio_chip *chip,
@@ -450,9 +448,9 @@ static int gpio_mpsse_probe(struct usb_interface *interface,
 	priv->gpio.direction_input = gpio_mpsse_direction_input;
 	priv->gpio.direction_output = gpio_mpsse_direction_output;
 	priv->gpio.get = gpio_mpsse_gpio_get;
-	priv->gpio.set = gpio_mpsse_gpio_set;
+	priv->gpio.set_rv = gpio_mpsse_gpio_set;
 	priv->gpio.get_multiple = gpio_mpsse_get_multiple;
-	priv->gpio.set_multiple = gpio_mpsse_set_multiple;
+	priv->gpio.set_multiple_rv = gpio_mpsse_set_multiple;
 	priv->gpio.base = -1;
 	priv->gpio.ngpio = 16;
 	priv->gpio.offset = priv->intf_id * priv->gpio.ngpio;

-- 
2.48.1


