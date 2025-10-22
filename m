Return-Path: <linux-kernel+bounces-865135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD27BBFC681
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152AD665D53
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B738234CFCE;
	Wed, 22 Oct 2025 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hDbl+cls"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F226734CFA7
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140488; cv=none; b=jDbTkN1rqMdOXgwZKcTStgK5oBiVQaqP0G2GWQ6mOeXk5liXOBr69BYKoD9HhSaaYs6xMIEKp9OJjm1BsqjHISQs2nzfeZJVJXJQAWc/IBbm3aUjO9jKl0f33dIbPhGDYsVCMVoCLzkzlxbdcVhoek1yIzxVimaQxyNj1mQESIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140488; c=relaxed/simple;
	bh=K8U+CHaEDTDTAOOAhIZGQLKRldV6biiXuo/pIPzTEZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MMDeEuRbMlHuSE4mR7dLz/mGXeFQgJmUmAU9E624NJYQGTrP88JzkoK5ZavZKIv9po9LAG8BWGsRKt90e5duUXratOdjfsyA7euvL3PE6yk/E7mgFqjpeToAy9QMn4HcLBN9dzTc6fjEv67/ufx3/OUxuKc+KwtYVY4N4op+mj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hDbl+cls; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-471066cfc2aso21197355e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761140485; x=1761745285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6pKa9jDqQ70bpsXEO6w9amEFdc6+U1mZOoJWBfQBYnU=;
        b=hDbl+clsC4I6duTYcdmEXkaRVm7iPBkIxr2mHkRdQ6JCgNN435e3uD3nNcvhTU82pt
         WIV55BNY0Teh5aBk64T7oKRQCaU4MI6hGuj9mPP+b/5TIaAZ+MapMvaynY4RP4AYWZim
         SOcsA2bBLhVAHIw17b2R047ieFBR4Gn9mFp4r7cStVrT93z16BDBHcLiKL61R37w5MwU
         haKfATbEdgLGtVn1zvLAKBFYjKMvEDP84XP52Zb3C5OKD//9pyQiFfXDRCoDJn+y1bjm
         rydXqxnKwb1bok7PW4NJ7l55CJFn8TUJT1EMhQ+OsFjNvQR5P72Q0jYc+RlDh1rzfkNj
         Tg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761140485; x=1761745285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pKa9jDqQ70bpsXEO6w9amEFdc6+U1mZOoJWBfQBYnU=;
        b=iMyB9N3eFK4zmDq8h7txJVBmR//OfuIOhp0Ulww2/J5MACdtLw52c1P2EEiuFf7Op7
         216/O2t1PBngecpH6SkrzvwkAcQQ5uuFYdgDozRXXIo7k4/uMU2b+KMV4mp6fN1LJWEH
         Ay0NFTLBzl+FAV2FeTHGftPFvMpOgCNZF2acFNwS22yok9ea0/WNvEqvz8gAQxlajVNv
         qcI6FlK98kw5DtSB7JwI6Gy+2332DuXJTKnoCcQeZVJCslHkcbqX2BPsX5IWZ7DfLNjp
         03jhgaEIxsXdjxpF+NOCgIj5q7n07DxcAT/Z1d14XM8E/g4pLm+4qla+1HtJq6NE8e99
         m4bw==
X-Forwarded-Encrypted: i=1; AJvYcCW5PMqKcajdDX89GWsAaxUzsXNmynqC9SXjXqRGfl/Mpo8YFFbuXO/sMzxICVa8vVaUdXehcOu2cGGfxbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUN3bKQtRJ3RX3QPoUuiGky8idHKnKxY8M1uSdF2JMb9ORSsE9
	b8yw94Mg4VbbYZYq6jntg6MZsG8TsJVk265oKaqEFlvnU4AomP2ZH3R/pQSET6iLT9Y=
X-Gm-Gg: ASbGncv30oCUZkpt5UVUPAbfIIVQsrabsOnFpV/dv0UWTrlNkpbSYs+/OucHV0Q/E1o
	dw42VtsrlKSQM89zOnrZK3q0S64X7SGsMwMs0WFuBygVTGv2XJrUr63jdNVbHe9KLIguYTX0uSd
	73T0u5InpPCbbQ+w4Uu+2HUjnOIxSF7uNWKH53e9AwFpdVFSgJR6xC9yjwHmjj4L51MI2OJZzbq
	L4Y5Em2rLjePCe8EZU0Gq4+sHVazGykYcJCXmBe7+HZdrtyMWiei8uSaFZsrW1jkPZ+TqgvDoGa
	FpevkzWDjAM6f2P3IYI0W3N+8dapCo/7G9HA/6oFoBycT6ReF/1U/pTh/kQ0PaA/qOiFbLjQMWr
	X00j62vn+0uwYta5AlaquKUulYmz5AybSlB4sRzvaZK/hQzBttkBVF/GLqhh79mAuKScfnjw=
X-Google-Smtp-Source: AGHT+IEWodi9VtfUFgyR0PhAnN9d1R5dKHAQUd7Av95doTmMXw7eZ/NeFsiiRrgT3YqE4AKBtoHKjA==
X-Received: by 2002:a05:600c:64cf:b0:471:12ed:f698 with SMTP id 5b1f17b1804b1-4711786c793mr167093185e9.8.1761140485406;
        Wed, 22 Oct 2025 06:41:25 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69df:73af:f16a:eada])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b97f8sm24863066f8f.36.2025.10.22.06.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 06:41:24 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 Oct 2025 15:41:06 +0200
Subject: [PATCH v2 7/9] reset: make the provider of reset-gpios the parent
 of the reset device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-reset-gpios-swnodes-v2-7-69088530291b@linaro.org>
References: <20251022-reset-gpios-swnodes-v2-0-69088530291b@linaro.org>
In-Reply-To: <20251022-reset-gpios-swnodes-v2-0-69088530291b@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2973;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=Zc+xs5tXGUpl9lw3Fpnc7se6u+D5QtL6RaYw/hFc3wY=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo+N70lgZq/69WAbh86SPgtuNEqqEozH06DyaiZ
 R6ZoYzwJeOJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaPje9AAKCRARpy6gFHHX
 cr1hEACB871FkPQGyrxMmMwg4Chadg/Dp0ONPm/eImZG1uBp0NRFosuslDu84tSGaH++9yIU6VJ
 30U7x223V7RFMO+5zEFa6uo1AMgsqIu+3DRvY3JINIZ7HMQgZDf/2WXRQxTgKnJbn6734osLn/0
 WhizdzOz+JgrsPQR7daT7UtovtUOTpHGWVL0mtvVLQzYD9x/Ex14afMFoaINkbtmhq5le2S+fft
 EmUU28/S3OyHpjmWnBgCecSbmmjA3j/yISgPC4jbCq4tzE5VSQDzxSiRFSKz3wYgEh07R4M7R9O
 WKAnbl410ijLHiSyMLtMpLzWqfRBj35Q9t4YSaSGNpkoqbbafkCCWhQjDM7OZi4XFIdR0vRA4q5
 tvDt0eT5IGnihe3xmv1lZBGs/JyY5WF9n7pQo5j7hzrh23aADGI4c4SrYMumIVqELlXe+p1h1hw
 89gQqssC2sBn/FnySDHZGk+brD1N/v0doEXLKQR9iIAXMIan1GyBUFrcE7Jq34VttnXAoGfTMeB
 udmkYVvLdmyQJIe3QTxMF8myvfyxVcdG2wyEGueXWncvJin4xjcRwwcEXGUTPYm4kOBN8MPV0yB
 NGXDrgXjDdN39wYjnDccEB6H8swXqoeSf0UBG0CG4pNSTOjHpAmWigReTw5WB9e2Vd9s2XOhBns
 xjyALBpYdzZdzRA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Auxiliary devices really do need a parent so ahead of converting the
reset-gpios driver to registering on the auxiliary bus, make the GPIO
device that provides the reset GPIO the parent of the reset-gpio device.
To that end move the lookup of the GPIO device by fwnode to the
beginning of __reset_add_reset_gpio_device() which has the added benefor
of bailing out earlier, before allocating resources for the virtual
device, if the chip is not up yet.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/reset/core.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 5a696e2dbcc224a633e2b321da53b7bc699cb5f3..ad85ddc8dd9fcf8b512cb09168586e0afca257f1 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -849,11 +849,11 @@ static void __reset_control_put_internal(struct reset_control *rstc)
 	kref_put(&rstc->refcnt, __reset_control_release);
 }
 
-static int __reset_add_reset_gpio_lookup(int id, struct device_node *np,
+static int __reset_add_reset_gpio_lookup(struct gpio_device *gdev, int id,
+					 struct device_node *np,
 					 unsigned int gpio,
 					 unsigned int of_flags)
 {
-	const struct fwnode_handle *fwnode = of_fwnode_handle(np);
 	unsigned int lookup_flags;
 	const char *label_tmp;
 
@@ -868,10 +868,6 @@ static int __reset_add_reset_gpio_lookup(int id, struct device_node *np,
 		return -EINVAL;
 	}
 
-	struct gpio_device *gdev __free(gpio_device_put) = gpio_device_find_by_fwnode(fwnode);
-	if (!gdev)
-		return -EPROBE_DEFER;
-
 	label_tmp = gpio_device_get_label(gdev);
 	if (!label_tmp)
 		return -EINVAL;
@@ -919,6 +915,11 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 	if (args->args_count != 2)
 		return -ENOENT;
 
+	struct gpio_device *gdev __free(gpio_device_put) =
+		gpio_device_find_by_fwnode(of_fwnode_handle(args->np));
+	if (!gdev)
+		return -EPROBE_DEFER;
+
 	/*
 	 * Registering reset-gpio device might cause immediate
 	 * bind, resulting in its probe() registering new reset controller thus
@@ -946,7 +947,7 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 		goto err_ida_free;
 	}
 
-	ret = __reset_add_reset_gpio_lookup(id, args->np, args->args[0],
+	ret = __reset_add_reset_gpio_lookup(gdev, id, args->np, args->args[0],
 					    args->args[1]);
 	if (ret < 0)
 		goto err_kfree;
@@ -958,7 +959,8 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 	 * Hold reference as long as rgpio_dev memory is valid.
 	 */
 	of_node_get(rgpio_dev->of_args.np);
-	pdev = platform_device_register_data(NULL, "reset-gpio", id,
+	pdev = platform_device_register_data(gpio_device_to_device(gdev),
+					     "reset-gpio", id,
 					     &rgpio_dev->of_args,
 					     sizeof(rgpio_dev->of_args));
 	ret = PTR_ERR_OR_ZERO(pdev);

-- 
2.48.1


