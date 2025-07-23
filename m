Return-Path: <linux-kernel+bounces-742659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95629B0F4FC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1BCEAA7B7B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4802E92D4;
	Wed, 23 Jul 2025 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="L8jAOD5L"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B9D2BEC32
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279985; cv=none; b=ClsesQ9MiwY02XMba26JnQjgeXdBY9LUqeMPkmlizUaPTmIOberLsr8aJXypDKX2wIUucNO+4r41TxxRFQkBPPwhlVjw3Auz8+bsCz/vyLe5YEW6y7hLuslOmCq7nrKySLK0+m1YqjlC1SdeXfaTsVGxqjy7qZTqJesfPwMZM/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279985; c=relaxed/simple;
	bh=fNEjxVqvHUjEyYP7eF81ud6f43OvHX8nmedqPVXjWXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jRTIwKfd9Q00NPKC7ZT6FgwvezoMo9q7cs55H6Nel6R13AJsblS8x6VBy8YLq7iEUvEFOHwbwHIvCgH2umtOhIY3R708L0A6eETWx5I8lE1Psl6R7055Z2TZw0IreJtpRJSMTgtg5xTKBX/rVh1iTpoPdsu1yYwO7F1p8lTP1Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=L8jAOD5L; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a6cdc27438so5140349f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753279981; x=1753884781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jl80Bu6jGD0s+NTfuIcms5WgEbUpaplgB9B6tltiTec=;
        b=L8jAOD5LNo6VW7kg3hpq3IvrzvLtMNkJicUkX5cnMcYdU911GpyBc5oTN6xuZDITtJ
         23S3+ZPoJ9fnqs7oG80KlxywupriB5b3c9qlqk5Fsq/Ad2MJSBHKcm5M+EDHdh0prk20
         BwdcSlCxOtMEN6jo7kvNR7yMbF9zl8xCbiVzZFkjgTGGS0S/WiWTh03o05AOlEv+aSlq
         5yMvJrMhmDGLb41n9Ex1dJQtADMKIom09KpISXt7Q5cq9BhZRRzJgXPh57ifH045HoD/
         zDAb0DX6PKI7xNiUif9PanlTOjmCH1sWxJfNPcao/Obyv42uklr8HmgyaKcbYiaQtNlL
         tXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753279981; x=1753884781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jl80Bu6jGD0s+NTfuIcms5WgEbUpaplgB9B6tltiTec=;
        b=AM8gp2V44Gg0a70V6m4pXpsqRcopfXXEYk66RnbeNXOlDpjhoLLMPp78fPnrWqVpWf
         IlYK91JYlj6yjhbKJy/trGVSF/qRiozITaEAjpcykAYWOoWY0yYryr+REOQWsoP1W3mh
         H1cBWCV/fzm4S3pAaKRRysVzTY5FprUPl42rgVpPb5QtL9YosWbgf+EeOHmqDpCv1Y01
         9csrysQ0XAT9jGYh3CacQJACgFEE5sMzrqmKUbqURmOtFmLW5yxoahnZkqgrIG9h6j88
         HAerKxtSFQ2vnjhl+j230XwSxlt+WC8f9kNXNQrKp+V98ZUQye/JhWCHm85AD5I4Owi9
         di7w==
X-Forwarded-Encrypted: i=1; AJvYcCW31Dwp/3dpc+1Zwl8Bs72hiDu3KCw28MIQcn2/Qckzl6e7q/wwOyenU9MnlyDBCfdV4Xle/AJijetRFNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQlM3w8LS9I9fJFv72x8rG1t97Woh5s0p2XuldCgCM9K84CwlK
	qWqWD7NoQU7oaf5xwDVMCLGLqJUKsAziW6g2YMaoAs7h2+2HUg5gSHsjKXluuSmxzaA=
X-Gm-Gg: ASbGncuzumrBobJ10yoAp0jbVopdPIepu1oQ15QkTTGNEavdShvokMfHiaB5VbHC9iv
	mwyJ94gzKPr28Hk2pWnOhcPbewyA09GlEFl5dLSxnIj/RsJ1WYFE9YcCtSK4SWNbX61PiO9sSzN
	SDSag4IlBuSIbUa1FHsJnsclTI0+FqVIGSD9QxOBRKTADiSqJ6bcQbgy+68gDNNrM0s3eS+/FX1
	KOnab2wCfUTc/z92T3A/YleNXVytDeTttHtTz2Zbe7Ql7Fxo11zdlmTH5owTYo98lPn7AYPwZWI
	nBL3mQ/2MeYLE70FeD7EfJB4qkdBCcqslVr1c2H77x+B1mxSRV5LxudD6yKTZQ5aWbcIOFIa/+l
	G7arlttIpxU0dj7z65LLPYw==
X-Google-Smtp-Source: AGHT+IG9+1w7YmO5GUnA4vkE6KJTbpONcQ8rqEmd5NJrNB57AzDfuCcgrodqrLbEMSV4zeN39Hktxw==
X-Received: by 2002:a05:6000:310d:b0:3a5:541c:b40f with SMTP id ffacd0b85a97d-3b768ee0463mr3152841f8f.9.1753279980477;
        Wed, 23 Jul 2025 07:13:00 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:34cd:b1d:d4f9:be03])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c9edsm16688077f8f.88.2025.07.23.07.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:13:00 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Michael Buesch <m@bues.ch>,
	Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] ssb: use new GPIO line value setter callbacks for the second GPIO chip
Date: Wed, 23 Jul 2025 16:12:57 +0200
Message-ID: <20250723141257.51412-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Because the other chip is guarded in an unlikely ifdef, I missed it when
converting this driver. Fix it now.

Fixes: 757259db79fc ("ssb: use new GPIO line value setter callbacks")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Johannes, Michael: I only noticed it now when randbuilding mips with a
patch that removed the previous callbacks. I would really appreciate it
if we could queue it for v6.17 as it will allow us to complete the
treewide conversion of GPIO drivers. Any chance you could fast-track it
into your tree?

Thanks,
Bartosz

 drivers/ssb/driver_gpio.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ssb/driver_gpio.c b/drivers/ssb/driver_gpio.c
index 14ad57954a66..e1f5f0a9c8a2 100644
--- a/drivers/ssb/driver_gpio.c
+++ b/drivers/ssb/driver_gpio.c
@@ -267,12 +267,14 @@ static int ssb_gpio_extif_get_value(struct gpio_chip *chip, unsigned int gpio)
 	return !!ssb_extif_gpio_in(&bus->extif, 1 << gpio);
 }
 
-static void ssb_gpio_extif_set_value(struct gpio_chip *chip, unsigned int gpio,
-				     int value)
+static int ssb_gpio_extif_set_value(struct gpio_chip *chip, unsigned int gpio,
+				    int value)
 {
 	struct ssb_bus *bus = gpiochip_get_data(chip);
 
 	ssb_extif_gpio_out(&bus->extif, 1 << gpio, value ? 1 << gpio : 0);
+
+	return 0;
 }
 
 static int ssb_gpio_extif_direction_input(struct gpio_chip *chip,
@@ -420,7 +422,7 @@ static int ssb_gpio_extif_init(struct ssb_bus *bus)
 	chip->label		= "ssb_extif_gpio";
 	chip->owner		= THIS_MODULE;
 	chip->get		= ssb_gpio_extif_get_value;
-	chip->set		= ssb_gpio_extif_set_value;
+	chip->set_rv		= ssb_gpio_extif_set_value;
 	chip->direction_input	= ssb_gpio_extif_direction_input;
 	chip->direction_output	= ssb_gpio_extif_direction_output;
 #if IS_ENABLED(CONFIG_SSB_EMBEDDED)
-- 
2.48.1


