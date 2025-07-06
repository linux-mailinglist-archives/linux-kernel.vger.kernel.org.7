Return-Path: <linux-kernel+bounces-712829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03745AF0F93
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 11:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D083A5D50
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 09:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36B62512FF;
	Wed,  2 Jul 2025 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vy/dlG9x"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE9E24BD04
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 09:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751447660; cv=none; b=dzON6cvcCa7s3qj3GYGqtqyCYugxwgzlKIlhm5wJM0nHKZqY5s9l1+Z/gHdsUK7vaNKDHmRh8cHBok/55VGndhBdWkyRXQ+dyoZyB2zsHX81N7f1jDpU039+GUuNrM4k8cl7XcFVBKVmdh949JGgUS/d6fOFqXXdZBYLAtN/c+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751447660; c=relaxed/simple;
	bh=PnY3cDY0PN7ZXV/E8YltXHdHfPXrlFGAY0vU2G2n/fI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RMC1iNs/5d1X8z8AGBJY3KYt+s80v8P4oVCuufnTKiJnAXU6xt3IEUIHuE8k/++DF4pWwFroB3PvQstCNKEz07+CiBAhA2gMNLZDzOhgGTBfyUocB+koMQjD7u6MEwxztgP/WU322N6ty+sQza8C2nvh0C6Wouy+YjYwB9+gDzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vy/dlG9x; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so44434005e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jul 2025 02:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1751447656; x=1752052456; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gUEUklA3BurrfmixuDf8vbdIh4R5xkMKm43bDMdhoHw=;
        b=vy/dlG9xf0c8B46mY4RGKzdRBQTm9deO6X/lUi10TZP+GMqX55GURFv6H0QfGvTsMs
         tUJFMKAJnsP+kh3PyZeYgXHtSLJJr5b7RYL8nds8In7Ax6APJW/KkG5/VPmywdqfc5PW
         kmqi2pzx+3dFXlu5mZcIOHBD0v+bYQlXAPFA+FVu04f8n7kz+Rc1uwjkrWqc4SBjuN5S
         N3H/2gTmEr9naXhm8R4gosAAZXLtN2adq3keIaqFx/ZOoDu2VsxHxHAEoV4Yq9XJ1Iia
         y02PEYkAEB1EJykSyo/hnQDR4V2YImNR6yV95lwNhBapFhINlvMEuakf2Lfkl90LgFIT
         Sn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751447656; x=1752052456;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUEUklA3BurrfmixuDf8vbdIh4R5xkMKm43bDMdhoHw=;
        b=hkoTEo1ABwgg4CYdxCXC5Ru/jSZ1Gz2M94ykPneHsD/kfEVkVoutcIlez6PjiK1uvl
         7qqsIknwTffqEgP7R0a2wfw/tSQzTbDHFIzz1iZterN3ppb1hg4bjQTGfTrkeRE+m3rx
         BdgY25jw2kZMCCVv5Udvf0NgF28D9VX6pChY+zQ5EUJtA/+TG8JdfGf1+8juT91D4Tm6
         JXZ+rO2jYIHUi9dEo6T6fD0mnrAb/fhucZAOSajiokQ2PLK/sq9H/MqdguEETh5DvdQr
         4dZlytEBMbW0OLgecQ7MUOFNsFr85MxAaQydrVEkrp1pstL1dgK+Ulm6OstR1taARFNV
         +h7w==
X-Forwarded-Encrypted: i=1; AJvYcCXhYe+o04stCuKT/U+eDn5cwiXFM28434Ak4Emf9LspT8ucU1RqDr5lKq3DaH77s003sv8IZDVEHZ4T/+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2F8E8SQJ+nRjWsK0GGKPu6KqTOAQ47hLwPdBzu5NWy8XkRe1v
	IjWfJrQdYRBKkbXST0cKGgWsRaF47d7uPNth1SsDclqpKIG5fcK2ALp6k0VfNivJYS0=
X-Gm-Gg: ASbGncsRbSeS0xldAXHkr/sMLlSGKDkVp7q3eJKE+Wff4zi8uVS+x9j0MgFOHKG9/D2
	5esu2HorEb2RBi0WGaSNhWN/6tgmUX/XpSHVmlIk2h/uk49WkpAPQlPxaeoEPxQvkgNTtD84bCk
	J1gztd1LW1H4eFWfSpHpy7Lvum2qlclEvoMmfkDseS6oNr8JTEl3eOvOrF1Bygn9zI7eFJcbTNY
	AwUCSAv33t8TtFQI8r2C/qVODZHaxmGfvvZM8fi8afnVYoOd4sfMitbb3YtMafX89nLBLXIgbb/
	0iNIIDMEJD3l31zF9JKR51jEK/9l4WXqa17NFlilGJ2421oUROLgPmx/RU51Hyhi
X-Google-Smtp-Source: AGHT+IF3yQMlh0CO5QqkB989AOdLnKhbtuXBds/WRv6FgUi0LgiNCmdiY8uDqmLHTmv20hYB6TXs1w==
X-Received: by 2002:a05:600c:1d04:b0:43c:fdbe:4398 with SMTP id 5b1f17b1804b1-454a5629234mr9687425e9.6.1751447655450;
        Wed, 02 Jul 2025 02:14:15 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:8827:d0e:25e:834a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e6f8bsm16027213f8f.17.2025.07.02.02.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 02:14:15 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 02 Jul 2025 11:14:05 +0200
Subject: [PATCH 04/12] gpio: thunderx: use new GPIO line value setter
 callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-gpiochip-set-rv-gpio-round3-v1-4-0d23be74f71d@linaro.org>
References: <20250702-gpiochip-set-rv-gpio-round3-v1-0-0d23be74f71d@linaro.org>
In-Reply-To: <20250702-gpiochip-set-rv-gpio-round3-v1-0-0d23be74f71d@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Robert Richter <rric@kernel.org>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2578;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=G0fFtgDkg5d/ZDEdFwzcLRDF+AwziOGhhqiJcYzEKbY=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoZPhg2rri/An++ouHF7TQgAz2SF90haXoniwux
 ALfVfrEVYaJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaGT4YAAKCRARpy6gFHHX
 crIGEAC0qKug87b46x+VLSigXbJbceWR3kG43qHFO0d16GdoIqcjtz8VjbidjhFaHaqCeMdW3Pe
 EKYDrLn4aqfAry1xsN+Scj/GZzNejdpeRoj6/NPzvDW4MCvMy4cQ/NFbzvjjWcPitQKHm7EROzf
 bhorte02dyQJ5J1/jet2QiJm7Wuo0Znx0qARXegBGnbxHbsFqbWfSXIxHLCIlosP62HjW/1KLIl
 ee1WLkDN/y+xM8s13bXXDkFqDSkvknLUHZH2ALj87/DRKJlnKeIFdphgdsnjqntm44QWhJCfrdf
 +yKPdA5su/Npk8zEe6G7zl2p7j/omH2QNBOUM8+C0+H/fpr9LrqwKL+lG72cEazWvUoNrD4cDU/
 tH0cAKmfyaZI6ZgWJypTVByI+nWlK96gB0rnj7uufHfFmveMpwoWuQ68/s6T/2EeoxxERdxacDy
 GSSy/trn/HRpBshIiNhyLfWoKQVFjGRzUA76G7KynuCdgUAadN/PJ7ygz9RkBlXtm2JR09jAmEE
 Ptdm7h4j7C8BJhsIwrv46BBJH+rEpK+vjcvIII79jc5+xWK4Wmez7nMfFSvN7dIvgiDoQ7feHjr
 tryHQWIg4JfRjiZdm9q5K7hWdzSYdmjtaNThSb+Y+1Eds3UoXVsRRGUFlBh0C9so9KBOGjuQYsE
 El9TKafigFHQ2fA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-thunderx.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-thunderx.c b/drivers/gpio/gpio-thunderx.c
index 5b851e904c11f5381cd4890828ecd956b78e2f00..eb6a1f0279c09a832ac71d76de8f696d9c28dd17 100644
--- a/drivers/gpio/gpio-thunderx.c
+++ b/drivers/gpio/gpio-thunderx.c
@@ -116,8 +116,8 @@ static int thunderx_gpio_dir_in(struct gpio_chip *chip, unsigned int line)
 	return 0;
 }
 
-static void thunderx_gpio_set(struct gpio_chip *chip, unsigned int line,
-			      int value)
+static int thunderx_gpio_set(struct gpio_chip *chip, unsigned int line,
+			     int value)
 {
 	struct thunderx_gpio *txgpio = gpiochip_get_data(chip);
 	int bank = line / 64;
@@ -127,6 +127,8 @@ static void thunderx_gpio_set(struct gpio_chip *chip, unsigned int line,
 		(bank * GPIO_2ND_BANK) + (value ? GPIO_TX_SET : GPIO_TX_CLR);
 
 	writeq(BIT_ULL(bank_bit), reg);
+
+	return 0;
 }
 
 static int thunderx_gpio_dir_out(struct gpio_chip *chip, unsigned int line,
@@ -269,9 +271,9 @@ static int thunderx_gpio_get(struct gpio_chip *chip, unsigned int line)
 		return masked_bits != 0;
 }
 
-static void thunderx_gpio_set_multiple(struct gpio_chip *chip,
-				       unsigned long *mask,
-				       unsigned long *bits)
+static int thunderx_gpio_set_multiple(struct gpio_chip *chip,
+				      unsigned long *mask,
+				      unsigned long *bits)
 {
 	int bank;
 	u64 set_bits, clear_bits;
@@ -283,6 +285,8 @@ static void thunderx_gpio_set_multiple(struct gpio_chip *chip,
 		writeq(set_bits, txgpio->register_base + (bank * GPIO_2ND_BANK) + GPIO_TX_SET);
 		writeq(clear_bits, txgpio->register_base + (bank * GPIO_2ND_BANK) + GPIO_TX_CLR);
 	}
+
+	return 0;
 }
 
 static void thunderx_gpio_irq_ack(struct irq_data *d)
@@ -529,8 +533,8 @@ static int thunderx_gpio_probe(struct pci_dev *pdev,
 	chip->direction_input = thunderx_gpio_dir_in;
 	chip->get = thunderx_gpio_get;
 	chip->direction_output = thunderx_gpio_dir_out;
-	chip->set = thunderx_gpio_set;
-	chip->set_multiple = thunderx_gpio_set_multiple;
+	chip->set_rv = thunderx_gpio_set;
+	chip->set_multiple_rv = thunderx_gpio_set_multiple;
 	chip->set_config = thunderx_gpio_set_config;
 	girq = &chip->irq;
 	gpio_irq_chip_set_chip(girq, &thunderx_gpio_irq_chip);

-- 
2.48.1


