Return-Path: <linux-kernel+bounces-830732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2814B9A6A7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8B9616749D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049B531AF12;
	Wed, 24 Sep 2025 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="eMbb8ca8"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B9B319877
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725528; cv=none; b=bdHzimexgKJGD8MLEoTsn02YnrbLyGSqx245mNbGZ6PhpR0L3AW1m9+F2Is5ir9rKPMrNzhE8NqTU9XldqVvK4rVoMPtUzEh/bEqXl8OZJ8EGEuABpNfoZAjgomXdYrp2NfKJ872VjC2tJh6Y61/KfeKc9aayIQh9fQEOeI4P+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725528; c=relaxed/simple;
	bh=qNrM3GBnH0eKznG4kYP6/Avn4DKIB1tkLH4xpvp9N7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N/aOevyZPzFNhFYX2/FoZmFGaUUxAds8ThvV5LgHpFMoD777HB6MFbSt5yO5eWeL8bcKwBo+ReXgf5PdGqETvOaOJQM/UjuqG1o0IcRicoSjf2fohI9zkJY15BdOXKI5S4MTQwp1O4nlGoD5dDU3Kec5weC+SRFAsfhBhFzupck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=eMbb8ca8; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so4170844f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758725525; x=1759330325; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZL4+irwvWE4SsBdHoCJTCTy+AX9NkTo9OPK52JUB9wc=;
        b=eMbb8ca8sBdbWV0Fnz1eH0KykRRQYmtkuePWtVu84Y8tHj/69feWqnN685QVe5y3hj
         1XhLPEWRhtJjxO6PurMHxkfnTjQcJWvx13LIWQF9887qpfFMTPVGEjSQsNVlWzga7n9D
         f7RlhjGvliW4/fqQsS6LpsV3n8U6k9EpZ05CS52XN/VES1PnPLqC6uH/vp8lX4J8JE4+
         55kdttOqk3V9QSQ7i6tmKB3DvPvFsg932HxM334PmlhMBIhoFoqOefdg4XFZ9j4CXVXQ
         hDPVbZy9MqrxCgUqcI5SulpL0fQGZCYM11x0QVLTIMwYBFLmzz/YQTVlerXLkfBKFkns
         c+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758725525; x=1759330325;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZL4+irwvWE4SsBdHoCJTCTy+AX9NkTo9OPK52JUB9wc=;
        b=H8o7xNTUd+evHTnmJtudijiUOb83WLGKsByJmN2wkt9H9rP1N3aEFvg4jfUPY6CP41
         S/WHTPzeQTOvPYC5HGT+JVoBSoq8dcCteyaCPwz+JALDXJlz7pJKL2mUBjAIE3Xv8ksb
         IUriTCUFWzAlJB7STiLdnB5YKW34aiwp82+UFlcXcOWbio3I14BehPBcbV9VPrYL3Cyh
         lMVJCrXPwAq3d27Lm8qFXq3p6K7lhT3CqlN8wWtk146GtmkSs8z6VqjUBfso7bsraq+G
         0GrFiT7Ae5AVPrbczP1Mb0Cv0pwGYAFbbUwsYVJjvykC83qUANSLJAFzEy7fdA906+4m
         TDZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsHSgfwLm6mpN/SGAV1fam3WRhRs66ZRk8dvcBxH6CLk0eGQ6I7cr8wpTPTYDoV6m0w0Ui90KHUki7j24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0TIaQI3T3fNvQ1Oqrv8La+bkBJjyFYSTT1HQPChvSs8POzyjC
	YyIt6CZYNPob97YB6S8NEPNaqV5XcJG2zyeG7v9uCEkGe6iaLVexk25WRdTK3K1/E1I=
X-Gm-Gg: ASbGnctlsmaO/h8KJ4sudHEYK87peVdUeqSJBgvQF0HIs42Jcxakc3rkQqkHmvnNNdY
	yNMsweqX/4W/lqQtRb9RRkWhg/S9OqwjzEGlU0kqQMOVofkkuEUsRIuJ5o9PBKGE/nrlMoSEqfL
	7Z5G+66yKeKp5xnJKMyHcSjP5sdTvDiwelv34ZD5Ra70STfwA7+2NVMRNc2vuQ591Uab7oYrwtd
	Z71v3f918XgUjlJqs1pnzoQQEeEtZVLwyO126i3XmPGejKwHXdCXGjlGDp+DDEjnTWbNWGy6088
	ixernXVDTalSmtiIDnmGcb7goxa7+i0HnfT+X/hSBnzAUP7tnry1OwqZWjaz7q12ulaKnm1PQ98
	QxGZI/3AE/G/4Q3UygZ5LsV0/u9+1
X-Google-Smtp-Source: AGHT+IEWHNWM3PMiQi39DCUY0P65dMCtUAmW0aNINKZlaMoAKd9G+OFLiLVmnpWbGaFejBIGTe5r6A==
X-Received: by 2002:a05:6000:22c5:b0:3f6:9c5a:e202 with SMTP id ffacd0b85a97d-40e4a8f9b01mr211100f8f.24.1758725524742;
        Wed, 24 Sep 2025 07:52:04 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:1729:c9b6:7a46:b4a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7188sm29514750f8f.37.2025.09.24.07.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:52:03 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 24 Sep 2025 16:51:34 +0200
Subject: [PATCH RFC 6/9] gpiolib: support shared GPIOs in core subsystem
 code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-gpio-shared-v1-6-775e7efeb1a3@linaro.org>
References: <20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org>
In-Reply-To: <20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org>
To: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4422;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=D3LlX9JCIHILUSECKUB0i2KcvXBRhYifvdj8HcLrtsY=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo1AWGtEm9BZBoHOyi6MRlpVU3iN4/m5ugqizXb
 cb5jiakzJqJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaNQFhgAKCRARpy6gFHHX
 clvfD/9ggshaV+wkSDLG7IqfR2kbj7iMCsyqumue5okcVW4slPGxJZrj33JjG2A5jCcf5zg6aYH
 mBJRXK2dlpCQk6WnUdIITocpEX+OdGe7/sDWBRWoez9hMSLBgwjFRegmHLSTckq3MRMtccedLZj
 ktqpmoRdheHwIgrqtKKBYZEhMeSEfkFz5E5WwJ4XlzUmnS5XT0n/t1gpt4jHTmdrJRV9inQSCD7
 3iEIFwiCcO8NV05SRR52jeC9dOiu/EnhQmKZ9+v5UvLDkbdpnLJA+HuRFKyegz6Jve2KB4jngsq
 iabVmFlK/1ZLkfzuA1OBa7Wcc2ca1XKXAFCXoqRqDhxMcB56XsKHpUnj9tOQ9br2hGjXCh1Dmm7
 I/VgNk1ApegakrszD7wB+reSA4O8W+7flw4KRo821kAyRsSVxQm/gyAXYUHuVFfUA76aS0yE5Rq
 uedGX/Vc9Xa9J79webxMRgOyfdm03s8lWUxsqBWOupPZ7owkAMCk+NARXtgQvNyfhR9sofkHvpv
 wJUntMKhrtDw2qs/eMXDnzBG+3YLhGQg+bD351X+Auc/ZUnNt232Y9ndJpJKKCrf0gmtDNDQKWE
 jXk3uBqKSiBvrcGmhPTiIoqhXV1cBhxQf7FC4wyMQQpIdx4grMPvIc87j5rVL8IXMMpr1z/C/0l
 lBZI30IhdmleP1g==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

As the final step in adding official support for shared GPIOs, enable
the previously added elements in core GPIO subsystem code. Set-up shared
GPIOs when adding a GPIO chip, tear it down on removal and check if a
GPIO descriptor looked up during the firmware-node stage is shared and
fall-back to machine lookup in this case.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 50 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 9952e412da505c12ceddfefd9cfd778aad3bd5e6..1e4c991797126d0d91233bbe7c3ae3831bf77d6c 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -37,6 +37,7 @@
 #include "gpiolib-acpi.h"
 #include "gpiolib-cdev.h"
 #include "gpiolib-of.h"
+#include "gpiolib-shared.h"
 #include "gpiolib-swnode.h"
 #include "gpiolib-sysfs.h"
 #include "gpiolib.h"
@@ -1200,6 +1201,10 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	if (ret)
 		goto err_remove_irqchip_mask;
 
+	ret = gpio_device_setup_shared(gdev);
+	if (ret)
+		goto err_remove_irqchip;
+
 	/*
 	 * By first adding the chardev, and then adding the device,
 	 * we get a device node entry in sysfs under
@@ -1211,10 +1216,13 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	if (gpiolib_initialized) {
 		ret = gpiochip_setup_dev(gdev);
 		if (ret)
-			goto err_remove_irqchip;
+			goto err_teardown_shared;
 	}
+
 	return 0;
 
+err_teardown_shared:
+	gpio_device_teardown_shared(gdev);
 err_remove_irqchip:
 	gpiochip_irqchip_remove(gc);
 err_remove_irqchip_mask:
@@ -1283,6 +1291,7 @@ void gpiochip_remove(struct gpio_chip *gc)
 	/* Numb the device, cancelling all outstanding operations */
 	rcu_assign_pointer(gdev->chip, NULL);
 	synchronize_srcu(&gdev->srcu);
+	gpio_device_teardown_shared(gdev);
 	gpiochip_irqchip_remove(gc);
 	acpi_gpiochip_remove(gc);
 	of_gpiochip_remove(gc);
@@ -4652,11 +4661,29 @@ struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 	scoped_guard(srcu, &gpio_devices_srcu) {
 		desc = gpiod_fwnode_lookup(fwnode, consumer, con_id, idx,
 					   &flags, &lookupflags);
+		if (!IS_ERR_OR_NULL(desc) &&
+		    test_bit(GPIOD_FLAG_SHARED, &desc->flags)) {
+			/*
+			 * We're dealing with a GPIO shared by multiple
+			 * consumers. This is the moment to add the machine
+			 * lookup table for the proxy device as previously
+			 * we only knew the consumer's fwnode.
+			 */
+			ret = gpio_shared_add_proxy_lookup(consumer, lookupflags);
+			if (ret)
+				return ERR_PTR(ret);
+
+			/* Trigger platform lookup for shared GPIO proxy. */
+			desc = ERR_PTR(-ENOENT);
+			/* Trigger it even for fwnode-only gpiod_get(). */
+			platform_lookup_allowed = true;
+		}
+
 		if (gpiod_not_found(desc) && platform_lookup_allowed) {
 			/*
 			 * Either we are not using DT or ACPI, or their lookup
-			 * did not return a result. In that case, use platform
-			 * lookup as a fallback.
+			 * did not return a result or this is a shared GPIO. In
+			 * that case, use platform lookup as a fallback.
 			 */
 			dev_dbg(consumer,
 				"using lookup tables for GPIO lookup\n");
@@ -4679,14 +4706,19 @@ struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 			return ERR_PTR(ret);
 
 		/*
-		 * This happens when there are several consumers for
-		 * the same GPIO line: we just return here without
-		 * further initialization. It is a bit of a hack.
-		 * This is necessary to support fixed regulators.
+		 * This happens when there are several consumers for the same
+		 * GPIO line: we just return here without further
+		 * initialization. It's a hack introduced long ago to support
+		 * fixed regulators. We now have a better solution with
+		 * automated scanning where affected platforms just need to
+		 * select the provided Kconfig option.
 		 *
-		 * FIXME: Make this more sane and safe.
+		 * FIXME: Remove the GPIOD_FLAGS_BIT_NONEXCLUSIVE flag after
+		 * making sure all platforms use the new mechanism.
 		 */
-		dev_info(consumer, "nonexclusive access to GPIO for %s\n", name);
+		dev_info(consumer,
+			 "nonexclusive access to GPIO for %s, consider updating your code to using gpio-shared-proxy\n",
+			 name);
 		return desc;
 	}
 

-- 
2.48.1


