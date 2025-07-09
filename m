Return-Path: <linux-kernel+bounces-722875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B00AEAFE029
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FFB2581EF3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 06:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1168F26FD9A;
	Wed,  9 Jul 2025 06:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ALhk9X6e"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4FF26D4E7
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 06:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043341; cv=none; b=PUycCOyQpL2OkezHc/1TAht2eNKgFSpeTi46KqFVmZQL0G/anyhPWyaxDnPgIhlNL/BwpIEYcje2viijf0E7FGo65isccfzDjwxzGkTeFAVf6RoQOPu0BPM+NPAIGup/ZMRSXlN7vjKXbedZWYGy3Ie+pA/LbgT2rZGQI646bGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043341; c=relaxed/simple;
	bh=URNrSWHV7G9o6r4qyGnEPBeM2eKMBuscOiq6l7X9CB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gZlZC3yFNEB82OdUK3PuuDyEZH8LgoJxYUWaKSuPrhDjpNtVEQ6v3U8NNrlMVTAbNv1PQ8Dxu4sqdN0JanDCbdQdG8aD26MIQwW1MeB/Encyqi58Xrg5WyCBHbASYO9c/1kGOpQ7dF0kthrmf4dfWGJvBlTmQvM8XCIx3BsF4+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ALhk9X6e; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a6f2c6715fso4614561f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 23:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752043337; x=1752648137; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3sOO8GRYzH1LAIie/qr6XG8UhR9sQ84kZJSd2ImbOfE=;
        b=ALhk9X6emabY5SN2Si1aqe0gLJWNnCgddgCKl6rBBnYTburiqcxmz0QEs3hgEVOG/Q
         nJnnaoubHrLXmIVRwxeQImWjo+2cw/JBSB5zjEABYyZ/Y3h5BSpfF3ubquKFIkXLT0fC
         F4rUvnHPuVFeFpKmkZS13/XVi69eKR1pFFb+KZ/fyY6skkhVZdK66PohLpxIGmrYrvsl
         9+/3W4EQZIxTx/HcIVX+J5izgF8w7BJnIOZ+GEwdbOgp+qCpYu6UD2h8W+iSNZvAY8GR
         oWWaQvOTolN4QS0qD74uvf4sF2icVKZqg5Em2mO66cOJ3AW0N5mShQX4eOGt+vPqzDRy
         kCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752043337; x=1752648137;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3sOO8GRYzH1LAIie/qr6XG8UhR9sQ84kZJSd2ImbOfE=;
        b=DzTxbr2SKclrM1rA9Blwch9G5TtnnQmar5zeA9OB7CQ3hZ+b3e3gNhGOXpIVTSJTDq
         UMeM345ylXDxdTqnDTpTcbDPZd/1zX3wQCoC3cl1WdiHFBTYubAJ65hxZq9L88/6xx+N
         v8LYT/+cZ/ocWgQOgjonUjQJlnmYCzvlbHlbxCbnmoXNQV2YAaHFpD1+KakfOlM6x+Ag
         WfaYZs1Amb9AQ63B6GmoBgDZ6legiiHWNDtSM/wzXG2kdOQvpnJX5OUbfX5HDxY3AS7C
         5m3loQ0Qk+6pfdtvME57uMgwomLMNxL9pAsKai+UG+FlAQZQQMDZCVM2jAxD5oue4f4w
         Tn7g==
X-Forwarded-Encrypted: i=1; AJvYcCWjh81LNogcHkv+iaKVArf1awuibiMt5MnXFJhkaBDEKpRzoP2sahOjPZRoso36FZZ5zgrPxTWppdStH/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/GLP0A22JhF7E22r5BE0pWfOYNyfYM0QOiO5Q4w1g9cGC/3O8
	r3U97SNYoV7fuIQYUew+DysdbhEUkIfBESZyW7z8550GqOs14fqwpCBxutVPk/YpsYAnvfmDwj1
	nyAVHILs=
X-Gm-Gg: ASbGnct/QCvdv6xhxrbviagAoNy2Iw3kmGE3FFsVb3hbKLBUo3cHQcH5fsJrKz9zzBB
	pAq6Ft0Kh1TC5/pt6LzKAZPOW6NbomOsymXW/Cx7eM330u8huF5zy1KaSa6zJ9xAhdJsit7YFst
	TBrAtzygQ95WVxv81GP0wQr91Ozof/Fy0JDfpinAwHb9Oa2AefPryZXtKVH6dDrQNqayfS/Hmdx
	dQgohlsHO9Ud6NTgQHP7T96Pi619X3FJ94N1+wbPr+nJdfEBMFeMbeKmDpduf5i3ihTajJYmngq
	fLI4f5NjKXOitJyaZyCI2Ff4SsqHX+fWKG5jHS3VUsxSaEar3a+MrIDL
X-Google-Smtp-Source: AGHT+IFWKDqKOZ2L/KZvqJCnN8qQD3YIoVrT5a1mUHbgBeSL6yTbT0/+VvV21K5H/B4ELkfg4LvHuw==
X-Received: by 2002:a5d:5f89:0:b0:3a3:7baf:f06a with SMTP id ffacd0b85a97d-3b5e4521ecbmr757039f8f.37.1752043337411;
        Tue, 08 Jul 2025 23:42:17 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:b04e:cfc4:3bd9:6180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030c443sm15115341f8f.11.2025.07.08.23.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 23:42:16 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 09 Jul 2025 08:41:40 +0200
Subject: [PATCH 03/19] gpio: wcd934x: use new GPIO line value setter
 callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-gpiochip-set-rv-gpio-remaining-v1-3-b8950f69618d@linaro.org>
References: <20250709-gpiochip-set-rv-gpio-remaining-v1-0-b8950f69618d@linaro.org>
In-Reply-To: <20250709-gpiochip-set-rv-gpio-remaining-v1-0-b8950f69618d@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, 
 Srinivas Neeli <srinivas.neeli@amd.com>, 
 Michal Simek <michal.simek@amd.com>, Nandor Han <nandor.han@ge.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com, linux-arm-kernel@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1583;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=Tl8ZXK09HDgun+whKg1NHBj4f20MoyV0KnJ4JPr3RU4=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBobg9BRffvSvflEPnMK75nSizEGaQYFrRJKallm
 FD14255i/6JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaG4PQQAKCRARpy6gFHHX
 cjPGEADR4Pmj4bWhhCGStbfaVxmL+G8r4NKc5ZarOliqjTvy7GZovvlqcvpXCk35GFbc8S+ub+7
 I+BqSvZHhvJMvj0xv+bVfT7r8/0HkAdbyrgx0QzylGDEz1eo72GCy9fz2XRokyv+UsU4DRmE/Zr
 uiMKQXEQqBQE1Xnk5o3bzF1xgZ56rvGZmIpSIbrUg6rnTmCQGokPzLq9JLI4l8UwDt3tTqTxlJe
 RedE9ojZ7CQSp/H0RTDIn/V9FVa64XfYjZso2bUPUw16DWID1U1iFLdqO8miKnaNlYolLDEB//o
 Zmhvs68VMxqq6S0DhFhdhujpiCV5vbenuMFnyruHQFCvo706gnRwHha/la9gI4bsMs/J11A7Rpv
 js1gm+ApMryxCgH3OFiCzLJ3n7xDdsXTMhf37QFtrvpCeuX4XbjEoES/UcMIyUS+A8T/pkK4w7J
 8LMRGbge0CxDuGHXUqLyLEGylFmMJDMiEeJyEpfhV1CsQGhinblP2+eKd2Db0dEVr25fFdGO1XY
 okolfMaZMS0cenMDpy/TlSMpJSmjXOfZ0M9ESoOotBlDqDNjLrOhIqx2XiQhQypJbGK8TK9xNeB
 uPgO1XhHt3FSmzMr7QZIMU9UxCnWa7f+jypq9DchT9R6zASZXFV184GGUc7WDSXEXn8fNKcIE4m
 GrdZs5+ohNuqkIA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-wcd934x.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-wcd934x.c b/drivers/gpio/gpio-wcd934x.c
index cfa7b0a50c8e339603bc5fc70a8d7354f3bc6486..c89da9a220168e1317131d2428fa4105ebae2aab 100644
--- a/drivers/gpio/gpio-wcd934x.c
+++ b/drivers/gpio/gpio-wcd934x.c
@@ -68,12 +68,13 @@ static int wcd_gpio_get(struct gpio_chip *chip, unsigned int pin)
 	return !!(value & WCD_PIN_MASK(pin));
 }
 
-static void wcd_gpio_set(struct gpio_chip *chip, unsigned int pin, int val)
+static int wcd_gpio_set(struct gpio_chip *chip, unsigned int pin, int val)
 {
 	struct wcd_gpio_data *data = gpiochip_get_data(chip);
 
-	regmap_update_bits(data->map, WCD_REG_VAL_CTL_OFFSET,
-			   WCD_PIN_MASK(pin), val ? WCD_PIN_MASK(pin) : 0);
+	return regmap_update_bits(data->map, WCD_REG_VAL_CTL_OFFSET,
+				  WCD_PIN_MASK(pin),
+				  val ? WCD_PIN_MASK(pin) : 0);
 }
 
 static int wcd_gpio_probe(struct platform_device *pdev)
@@ -97,7 +98,7 @@ static int wcd_gpio_probe(struct platform_device *pdev)
 	chip->direction_output = wcd_gpio_direction_output;
 	chip->get_direction = wcd_gpio_get_direction;
 	chip->get = wcd_gpio_get;
-	chip->set = wcd_gpio_set;
+	chip->set_rv = wcd_gpio_set;
 	chip->parent = dev;
 	chip->base = -1;
 	chip->ngpio = WCD934X_NPINS;

-- 
2.48.1


