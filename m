Return-Path: <linux-kernel+bounces-820290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA97B7D8C6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91BCC3B5887
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FD030F953;
	Wed, 17 Sep 2025 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="JpQFqBLy"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3727430F93A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758099269; cv=none; b=BKrw83ZkFxvUNuWW2JCgTBKHNp1f+sRyjkCbBiobReC6inWcyJaphy4m1OHgg9XYXwzcHETlTxyue62u/ElnDXJZhYuOiMXSokGvO3tmtB6HMGNDc6TiSYhr7TgR3/AJgZK9r+mzCbnkStZNjzqhdlFEgjuSlPf36NVX6AlX0XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758099269; c=relaxed/simple;
	bh=FfXwH830Tj0CwzILt3Sw8EU8yHiwIE8aiCiJ0ReymGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YpUoJr15RNdJfzRpzi1bf+KePK0NsnRy6QE1O5udf9CkLe/cI7BffPq+hvzeCbl8URcvwMCjkk6wlWxjUBlyBlVU+DDfwfXhjjic9wkynwDYgrZLZUutpUPyFsCJUidpmG308OA72c6UWzjDz/mTIIB3FmajYSjBZTm4IlMG6Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=JpQFqBLy; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3c6abcfd142so3176433f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758099266; x=1758704066; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5KmsTiol19nWz6UXn/GDuj0fgurTsqg9KVdLaCOAS2k=;
        b=JpQFqBLyORpU9I73XAk0CjzUjFBiTGDyKhOuIH5CuoH8TKz7GRcltMYEFOpq1N21wj
         mz0BkMW1VDFIbWvNFsTH4VwWBdsy/GQ0DWmSgUPXKrr9v+oJi93pO/85YKp7lPcloKxi
         qoZthoEr+Csix+ioi+kahMqEabilWlePHsnj0pyX+P3IdJOi4sB8gLJObQ3i7S8ZWwcR
         HMhcEVUDlcS/vqByrSFCRqOLZjQ/68iFqXJEFtpEN5OfQ8tp0c6eyFYb21n4pjHxh8F6
         Cm7vd1EBEczyybrwALTA04vojnADQiapd6mmdDlD8P+ORMratQ7PhZfQ9N/FuYmMCo8w
         +ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758099266; x=1758704066;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KmsTiol19nWz6UXn/GDuj0fgurTsqg9KVdLaCOAS2k=;
        b=PNp9PCh278U4dYTBlCNjeRF/TY1TFZJLDeSMFF0xrLJr2ZB68epC7+Huzt8RqT2HrI
         hmRIRG4WEktu78N0EzRJAKYkrBYOz+exI19RizdZnCnTOwHIwizx0hs/l+9XoXCPd2oM
         3n3ZuGc/WSESMQXq5tzH1i8MDhMec1b4XaGUbk2FC3uriHsKsy0UY1FGOE8EsPNUDG/Q
         jxc2sBjUGKyrBgS1yIJIRoBdyNMpUMAEl4dNiLY1fY5m+6+GWNavMCdJb+VNk6fL/jud
         SrvBaRQK+NyNqk4F/HLbZxTCETYcK5Wv15eF2WyLq5O8I2VJHERIHSOQK6h81IYknvpL
         1RiA==
X-Forwarded-Encrypted: i=1; AJvYcCV+Z8n2zkcQGJUB0EoeYeYupSb2s9J8pjg1il0hmglPYfBfgeYgslz7Ni63T7YQTs/3Jd1vEbqpW3T+1q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIlccJvep1pDyLqiEUIqJsOv3zVLhw7IypGlxwEOtwUdkDx2VG
	8cqnJTQoJy6rJ6k7JefM5AKlVjlAifNUGYV7eoiUiH/Rpc88gg2oMSWSygCuCFFJlujPADKH7bK
	+p+jLryyAHA==
X-Gm-Gg: ASbGncsghOdzYNXsIUZFc6T8art6LIN/SGvIKOCenXREWcjYeq0eDR7lc5IyehkI9pp
	GU4ZGnk3oZ3NM8Ps1P4HJypXP679N6kTebZXLV5LdtjaYuV/cZfIGvO+ox8SGnjQM308dgP6Mtl
	SP0Jwnoo6euhk5EWZXT1n+2EdKgyHvOTxhE3A9b70VHzw9K4iJw7I1yJ74llOnTRrfcdG0t05cb
	B7aeEb2L0b8C62/vKxFmYxQqRyVaK/wBAoPv4lIJ4rUGtePxnVKzjH75E656gaYAK0o70VCzvj3
	5vTJBNwvZ6+WIGAg093E9hh61rPQWFX96tJ6AZcLhelC5exS67aInVDQY58JQFY+AJc2Jumjszf
	AkHPT9FgxW3somY7RIFrUil9XpQFjGlDlbTXyzCpr8jQGcNquqa05h6SE6Q==
X-Google-Smtp-Source: AGHT+IEjJ6O7ONf18g63thwOhZBSdBxpTXBQi3VbWqPMv+a/8mZ4PcTkeGeTVvmLXvY42CX6XxUddQ==
X-Received: by 2002:a05:6000:2c05:b0:3eb:eefa:619a with SMTP id ffacd0b85a97d-3ecdfa3f9cemr1047409f8f.41.1758099265624;
        Wed, 17 Sep 2025 01:54:25 -0700 (PDT)
Received: from [127.0.1.1] (94.red-217-127-72.staticip.rima-tde.net. [217.127.72.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3eb9a95d225sm10117552f8f.54.2025.09.17.01.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 01:54:24 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 17 Sep 2025 10:54:06 +0200
Subject: [PATCH 2/2] gpio: generic: move GPIO_GENERIC_ flags to the correct
 header
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-gpio-generic-flags-v1-2-69f51fee8c89@linaro.org>
References: <20250917-gpio-generic-flags-v1-0-69f51fee8c89@linaro.org>
In-Reply-To: <20250917-gpio-generic-flags-v1-0-69f51fee8c89@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2434;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=1Leh/9DOGiKOvWd/T3NGcZK2HnnCJt97WGZWNHoUPG8=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoync8gbutJJklv+3wEtvzITBKOjLrT+rIER/VD
 FiS/3PyRFOJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaMp3PAAKCRARpy6gFHHX
 cpiEEADd3wIA+21YzIr9XWN3l5geUdfcMThZQZhNtSB6PuCz0Oqv+FdWGE+2mFK2lYShwvs5IOE
 hMxnTstjjZSTJo8WDW66pCzecjMCNqnNkFNcwCnJqy8fhqb2yMgAat6QBArtu4DOV4hgdlAFZ+j
 WNnD8RTQKAnaOZI7PIZOxKGiD2gu50QRYMfskAVLVKaLpDTS1pPYhERlDpKaDTr3ASrAEJEo/0u
 NoIp6RqLXDRStYnnGcXK8dlP83lzKJ1M3fYMZ8Vikhfn0U1f1rhTq+mgUFb3Nh+spFepYnejATV
 TRL7uRcWerEpLMJzLYXrSgmQte2rpXWKtBJmhEHcvBOhTU/aVyHgzgMqEkzSVxatMpZPjlN7Ycs
 tqmjq244SsXVQvpxAEsD4kBPmNA0gOW93iPVVWqmcy1U3HIZIK47EQC0/CH1reGWOqru3vS+Ejq
 fTuJie7R/PVeeJ4nRgoeJ4/WeeEDk+EwHVrZCzYsOjwsdFc+EKUY7l6FuF8H2bHNuguczx95dBi
 rVAuw26Q3fwg8wKIeNlV8+sQm/P1Q6HSO4I8c2MBSW83I9hfADIWg6eUsUfiCdxWNcS8pQkbvv6
 FqEng/T5DqnG2F3o5MADNm769gjpFjLLomGrZjGOVlpd24JrKSPm0xwffVYl+5AgOliKZV3cf1S
 GMZpshF30uo6oHg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

These flags are specific to gpio-mmio and belong in linux/gpio/generic.h
so move them there.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/gpio/driver.h  | 10 ----------
 include/linux/gpio/generic.h | 10 ++++++++++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index e62622e42cad378f6c0bee12fb9a0b29eff1f471..fabe2baf7b509059c9d05cddb3c63eaf8b6f0542 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -684,16 +684,6 @@ int gpiochip_populate_parent_fwspec_fourcell(struct gpio_chip *gc,
 
 #endif /* CONFIG_IRQ_DOMAIN_HIERARCHY */
 
-#define GPIO_GENERIC_BIG_ENDIAN			BIT(0)
-#define GPIO_GENERIC_UNREADABLE_REG_SET		BIT(1) /* reg_set is unreadable */
-#define GPIO_GENERIC_UNREADABLE_REG_DIR		BIT(2) /* reg_dir is unreadable */
-#define GPIO_GENERIC_BIG_ENDIAN_BYTE_ORDER	BIT(3)
-#define GPIO_GENERIC_READ_OUTPUT_REG_SET	BIT(4) /* reg_set stores output value */
-#define GPIO_GENERIC_NO_OUTPUT			BIT(5) /* only input */
-#define GPIO_GENERIC_NO_SET_ON_INPUT		BIT(6)
-#define GPIO_GENERIC_PINCTRL_BACKEND		BIT(7) /* Call pinctrl direction setters */
-#define GPIO_GENERIC_NO_INPUT			BIT(8) /* only output */
-
 #ifdef CONFIG_GPIOLIB_IRQCHIP
 int gpiochip_irqchip_add_domain(struct gpio_chip *gc,
 				struct irq_domain *domain);
diff --git a/include/linux/gpio/generic.h b/include/linux/gpio/generic.h
index 162430d96660e96b995eb4a2e64183503fc618e3..ff566dc9c3cbed31bbc4e2d595895f20641f8c12 100644
--- a/include/linux/gpio/generic.h
+++ b/include/linux/gpio/generic.h
@@ -9,6 +9,16 @@
 
 struct device;
 
+#define GPIO_GENERIC_BIG_ENDIAN			BIT(0)
+#define GPIO_GENERIC_UNREADABLE_REG_SET		BIT(1) /* reg_set is unreadable */
+#define GPIO_GENERIC_UNREADABLE_REG_DIR		BIT(2) /* reg_dir is unreadable */
+#define GPIO_GENERIC_BIG_ENDIAN_BYTE_ORDER	BIT(3)
+#define GPIO_GENERIC_READ_OUTPUT_REG_SET	BIT(4) /* reg_set stores output value */
+#define GPIO_GENERIC_NO_OUTPUT			BIT(5) /* only input */
+#define GPIO_GENERIC_NO_SET_ON_INPUT		BIT(6)
+#define GPIO_GENERIC_PINCTRL_BACKEND		BIT(7) /* Call pinctrl direction setters */
+#define GPIO_GENERIC_NO_INPUT			BIT(8) /* only output */
+
 /**
  * struct gpio_generic_chip_config - Generic GPIO chip configuration data
  * @dev: Parent device of the new GPIO chip (compulsory).

-- 
2.48.1


