Return-Path: <linux-kernel+bounces-679450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8667FAD367F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 14:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31E7117818D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 12:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D3329826B;
	Tue, 10 Jun 2025 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ETQA6UWi"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06D32980AC
	for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558814; cv=none; b=gHIh1ndPLYtmXtWeVHVFAQpZRiNFHEEkJsHITh3tt8/sEF3HVcX0F961D5Dpbr4Q2WXgKyu1shv98luIlvJdERO4uE2+Czg/18ruUwNYuzKbu0w4aSNDF8o5O8IjTaoBbCmGSp83kgT294GZR2UvUbkUm7EgsW2B5ynGOuEx6AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558814; c=relaxed/simple;
	bh=0Q/v23KkvgGRE/jqhFxsdYJoykX4nfP6MLHY3t3sq1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VpirofW+nMxJH7bM9wxah943m+GR0+yjQ54eKY5eMFbwLCmg8y+3UCuxVEG9k61MbMzsoxEWfzXlb1TkBs7H18zmyrKm74cU4f3XjkXhr7T5Zr1lg0VyRRt1isGaSqAtnMY9IWabXRZUMuj2jOAOrwDe1wY0xsX8Av9/If3L39c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ETQA6UWi; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a5123c1533so3053024f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 05:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1749558810; x=1750163610; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qxLzYZOTSdUIwG/dDdz19oBo7jupe4wC7PnSCC6qO4k=;
        b=ETQA6UWiKQEXG9Z+/FiRbYonJbwJ6P39Qm1fk+FCdfyRFmmIzNMLdSLFDRpVWEL2uM
         exQgN8W2UnqdUgBaN4Cuhou16qdcMuXfPuN1widJxYbeIHgSaYglMo9sHPW5FgazhUbv
         Gl7hJevfTuzpMjPVWuli8/zxmsNYQ1opGSG2W9SrtyGmUyVP/fWkQr1tA7MpVLHqA2TA
         BJhYGipMKvl0DZebSIV2GH/7S0ea0+pZFPFyrU+cIid/CxV8fEjd4Fd+sI/Zqu1YkRAd
         ygAFPvYmTdhZlLOMpvXKz9nmZmT+L2bSNVr87UBwlz5K38N17VZVGvAbXdrKyr85c8cm
         jkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749558810; x=1750163610;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxLzYZOTSdUIwG/dDdz19oBo7jupe4wC7PnSCC6qO4k=;
        b=qe13SKp6zItKNDx9x0tHS9Ah9tYPb8gJrini7Rd4x74TwBuD1C1lZ06sUseGMOsiJC
         rMd0VFxPj622n96lG6L8OxQLq9kbSIyyTrxnqR1z285n+yRj6cUSNMJw43Aig0JPxqPr
         52KDmT6mxzPf8MC0JOucw1qICqcl92qcbnbARXw+SPubqJdKsot9MGcISugXYKK6FE00
         7eVXULNvp4kN5GLQXEuokDa/7lx1HpUMEmCgvUGH9gqIWoOGtN4jXddNb/00fkCtDuxL
         mZ95O45K3VP18XnYjFOlx0Ncq5+mYbo5R66e7Kwjp9zQ39Q1aWkW5yJ6ynaSZDzX1QUO
         3YLg==
X-Forwarded-Encrypted: i=1; AJvYcCUwmGE7SL3aGfs/Ohlt8iUvCXxwIxEOV0lPsrMxxs36Cbi3XQ32NeH6ULnZliMKn0AWz/s/9gPSIRPB6FY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDVSoQXbFEdJxzoCxi19qVlHKntD4dVuqzy3wk5aqmc/h1Ukh1
	fUS2k0moHYdjMWJMJJv3SJ2/flt9twvQGKpdOiTNUjT15U9nU/X5oMq56yFfCKw6+Ec=
X-Gm-Gg: ASbGnctkH9aXBoIFSGnonjY4wLYLtGTY3SZK+t9S7enViahbP+AQrseFRg360s4+gUJ
	5VliEFAze9DbCaxq53Q1c0x6yOzPPGDDej6BJvgFn6ve/Y+J103GJL5b5OGNKgOH1Zr7ieI1oF2
	so7Ti57wmSY58v3c5UwS1qdbW7m3vEr6gATa3f51ft2pBeoanKFC4no3fZHtZgcg3hFGyC6C7Wv
	51RFQ9jnZ1vDystWRqSEzQQHB9BS6VzJoiwUpqpD4y+C0HS3qwHAfesZaLbiWpgJ525sWbWEKge
	t33QQfUGhQ7uzqgjV64V2D5coNRKtcdpfxGH4pvCJqEbxIamwwrXYA==
X-Google-Smtp-Source: AGHT+IGf24xBNhS/K1ZbKglpgFrm46LA9T2wVtmfcyS7odITVr/pCroc70/4xTfamtgoFjylllZKEA==
X-Received: by 2002:a05:6000:4205:b0:3a3:7987:945f with SMTP id ffacd0b85a97d-3a531ced4e1mr13192942f8f.57.1749558810273;
        Tue, 10 Jun 2025 05:33:30 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:4d:e52b:812d:eb7c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53243661csm12290668f8f.53.2025.06.10.05.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 05:33:29 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 10 Jun 2025 14:33:17 +0200
Subject: [PATCH 07/12] gpio: msc313: use new GPIO line value setter
 callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-gpiochip-set-rv-gpio-v1-7-3a9a3c1472ff@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1676;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=ZmOs9Rn2Ofc7KtPnQgf3fHbIJejOw5G9OgMOgcVcOTU=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoSCYPS6rMr9JHakl/jEzS6gu3nnJM5OwNcNdkw
 pcSFpc7hKKJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaEgmDwAKCRARpy6gFHHX
 cvrUD/9GpMmudRkoErJ8Jc3wJWG5D7s/6ppxZ4bAKfLPHuIf3cullW2xXMdGEisXFnYba5VEHpt
 VlXc3SJRZDpOEvM0F3v/+jUIZiuOD6pvawQnW/qxtq/Ozv1UfpKrpuN1fRrh7pL2XMWCAwwRnUw
 aBDKVyyJlBxP2MtvGqRaa982whCS2SZd6kG22Dddodz3o3nAzrh2kTO1S+fWFysy1uyhRTTIlpQ
 cXCVQ1wQMGQQOX44beuLfNlLd9SEPnqHDgf0Lj3MudgUqT22IGiNR10kwDiB3wQ1raD/uYBJnzl
 8vxKAn3c0fCywJcvMFP6K8S2ZAHGytispiNwpf8Pa9l06WV5vZCyzZswFKsDYk8zO45sEPi2IYK
 skKkUVLEkgJycvjqe9Z0PM21t3y0NVWKx5KjMcH6+hefemyBEzaHcFyl5ARdxki12GE3lCixf8f
 RHBvPI0sed+6K74ffsqTELAk4EffI6LaNvWOSEG6F6OvP91+rEkaHy/kCIJFTo7DMnnu+SKtCLB
 ghIRIU0nZmltloZYikzkZfcgB8uYVjw5f42C9UGksap9z2d2juN4inFBf0R8psL7OAHQB7occ8w
 nuAi7PvG6Lmjmnv+Hq6TmLCI75PEi8A9HehvhBXXbFG1lUF0a3ELPJqeFHbc8O3ZLGrwJsZY5KR
 oWc3lgWCenglKuA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-msc313.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-msc313.c b/drivers/gpio/gpio-msc313.c
index 6db9e469e0dc254e791d497b89a4c6d329d0add4..992339a89d19840fc03ccf849972a83cb86415ae 100644
--- a/drivers/gpio/gpio-msc313.c
+++ b/drivers/gpio/gpio-msc313.c
@@ -486,7 +486,7 @@ struct msc313_gpio {
 	u8 *saved;
 };
 
-static void msc313_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
+static int msc313_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
 	struct msc313_gpio *gpio = gpiochip_get_data(chip);
 	u8 gpioreg = readb_relaxed(gpio->base + gpio->gpio_data->offsets[offset]);
@@ -497,6 +497,8 @@ static void msc313_gpio_set(struct gpio_chip *chip, unsigned int offset, int val
 		gpioreg &= ~MSC313_GPIO_OUT;
 
 	writeb_relaxed(gpioreg, gpio->base + gpio->gpio_data->offsets[offset]);
+
+	return 0;
 }
 
 static int msc313_gpio_get(struct gpio_chip *chip, unsigned int offset)
@@ -656,7 +658,7 @@ static int msc313_gpio_probe(struct platform_device *pdev)
 	gpiochip->direction_input = msc313_gpio_direction_input;
 	gpiochip->direction_output = msc313_gpio_direction_output;
 	gpiochip->get = msc313_gpio_get;
-	gpiochip->set = msc313_gpio_set;
+	gpiochip->set_rv = msc313_gpio_set;
 	gpiochip->base = -1;
 	gpiochip->ngpio = gpio->gpio_data->num;
 	gpiochip->names = gpio->gpio_data->names;

-- 
2.48.1


