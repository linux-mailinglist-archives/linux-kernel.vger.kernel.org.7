Return-Path: <linux-kernel+bounces-797947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 037E3B4178F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC97817998F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E433E2D593A;
	Wed,  3 Sep 2025 08:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="eQClZACR"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F6F2E6126
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886426; cv=none; b=FYRmoLvV6qNMOrUpIZtz9U8DzW8sn6CvVvXAeQ+760p7u4TG9VUceLMtCqOyZ0bqmcC1yiBDMUgko5AnZLmDSp1yeYn/Bq+dWciWCFTZq66F7cw+rVXng3ObOLxqvhUnJKks0S0afmD3MwEtf42YsCDWV4suyjfGr5XXBsXntK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886426; c=relaxed/simple;
	bh=GAlunEqcyle+Dhk+JSKe/5t0VX7CfGJZL+xE62/AFRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QgmRGfriBZ4ZRa5Q0a0hRiZyG7mdjHsZWCvlYJYwTdIPG6bbwCWNcNdXu88sZU7JwTlILXfLBeEmK7bMMK3NY97pMSs2qkToin4bGu0VIzDDxbYRmYRiLY2rsunRWFMah03OwQO8VYmPoVmyJu3k7YgEHuHpwX+Z5yg44PkXy74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=eQClZACR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45cb659e858so1626425e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 01:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756886421; x=1757491221; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28SrxqKbfMpenNCR7Jms+O0M7RdbqCMd1LJP2Wh5U4U=;
        b=eQClZACRUZK+b+chhL7pwtDkSHm0yaZXQY2VLsGtGqyRcKrwj6bKawpkzv8npsgGy+
         lMGoWZY7YUj4Y4I6OdotWFxjuHd1ogHpin6FUSLUsvU1HEo4ubEqyHGyObqdi33ozQ71
         jg/f2QhwS37Su1z75V6S8FCNvAhToq9QFiWcXzgF+s4jlTk2ZEUxmao7hmDiGnEw8w2n
         IQ3Ar4roKj1g3SAN04fCcWlBCIPJvgRkRWw/44eAj1RDp4/QfmsGjrCFgMDlsZEQzSEJ
         6Xx4u/UzCb9jw/C2c8hrvTlKFWoTmBQIFBipV3wqcPTM3z5ZNNV0xFwTgGsefeGk1WPo
         me0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756886421; x=1757491221;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28SrxqKbfMpenNCR7Jms+O0M7RdbqCMd1LJP2Wh5U4U=;
        b=KTI2O4Djyw8Q16GHWe81NO1ECPHbGMj9WYGls/w0UE/NrCpTf5wfChNOJQi0p0Wjix
         HycwffQ1P9uvkSPxwvH8ZtQUaNmlpyGvXTuVpxFf5Y18kmGYNFNkqj7oWzQRaBkWpgxK
         4388E6OlWeRFLDjvLN+4kd63/xbqdlHBWo+KIuryLvMCUTOcibPdcbB0pQ6CXpze7+jS
         OSju5ZQt7ADd+zzBPVTk+2J28QJjzKqEi5xAFIqW7GaQhSUR1Lylc1L4EctIjgCaDp7Y
         +F4dIZd7kWwNBPFqyoVGN1ldqIPrlUkr/5PqanyNeXcbY4Q55j5LwYJr8bwRTCBLDBMK
         5lOA==
X-Forwarded-Encrypted: i=1; AJvYcCUA3b7dqb2JdCVeKCJSt1KbpH9htgcBgWT7FuqX5G9Ob/y9wwTow1vnT+TbWV+ba6xS/5dm1iUQhN5I50U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4TcmyC5dbYdC/dGwLdmawTTFpUhX7nFOha1rtz67xs8p+Zm3g
	P/4Mt8h+WGQvjhCX5r2of8uAWpRD/YFFwKsw7vDz2WVV8iss8iGTtGPAFzfVDTrx7kg=
X-Gm-Gg: ASbGncvyZwUt1NW3WUBnaS+G64KWSSI/BGrZVeOs1kds3J+KU4/3Bx5yORVO2ChQZLO
	YhcgWU5R2xD7t6K1Mj6dB1NaifrLw3aGPQolSQvLY3eIM4mOHCIPeRpwCQceq+k/xeb01Vq8CSU
	wJuARUdGYs5yWJoV2UrH6M+zxEojG22WkYU4f2HWZeLLjqFvyqAnzXAVbzxmbU6lTnp6CPpq7d2
	Woycg4F4QTuxHPmk1o1xkgt3wDvZahzRzgWK//gRhcVc1+7ZVrdeHOM1P96vG54bEGvYjoaiPsg
	knyX4ShDw1w69uEpF6/wTS/nXJaTqGvb3UopBLuoD99IPtIY/kGqQsyjYChmpWAEoiJj0E+L/gN
	FErWok9G0KWdk4kfhTqp2z70QpFY=
X-Google-Smtp-Source: AGHT+IE23n8KEnm9RVMvzUtmDbHmQx/BpqNBQW7ho4oltG87X/6lye41dV5DPXCUu+eVURRe7SjPfA==
X-Received: by 2002:a05:600c:4f51:b0:45b:9c93:d237 with SMTP id 5b1f17b1804b1-45b9c93d3a5mr28813005e9.14.1756886421328;
        Wed, 03 Sep 2025 01:00:21 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:2f8b:4799:6bd6:35df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b83e954b7sm113331635e9.1.2025.09.03.01.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 01:00:20 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 03 Sep 2025 10:00:05 +0200
Subject: [PATCH 01/12] gpio: ixp4xx: allow building the module with
 COMPILE_TEST enabled
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-gpio-mmio-gpio-conv-part3-v1-1-ff346509f408@linaro.org>
References: <20250903-gpio-mmio-gpio-conv-part3-v1-0-ff346509f408@linaro.org>
In-Reply-To: <20250903-gpio-mmio-gpio-conv-part3-v1-0-ff346509f408@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linusw@kernel.org>, 
 Imre Kaloz <kaloz@openwrt.org>, James Cowgill <james.cowgill@blaize.com>, 
 Matt Redfearn <matt.redfearn@blaize.com>, 
 Neil Jones <neil.jones@blaize.com>, 
 Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=732;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=t1lfr9CGD5hAUu0wxuYijAuMnGmaaqaWqRG/nWsgM6o=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBot/WQJnZVk4R49ta4SC2jyrvwBxAkuePGg6LgL
 Ag/zatRYt6JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaLf1kAAKCRARpy6gFHHX
 cowZEACJ60IcLQ33Gz4l+86NKu9gu7IpmgUlHDd5ok5S+95AVHa3s8fnM0+K4kB56bF83VDaANV
 wgnvG4d+jxv2c+uOb8GaLQTh3wusDzZroIkwQXZtNXRb+4nAF26tcRvI1x5awtyZoCQM0YSwIB7
 scKnSsoX7vafPALdlagy+sI4e5KQNXE/NdRhpU+Tb4GMZIl2bpHxT6vUOOtyOrySECDUityOItj
 SqBuDtgAjmXzJAuoxxmnLyRRnpTfNsSlw/zYyheFaoGKk+Vpg19Y/OG11E+7GexnzSGL1YVdII9
 dPffXmg7PaYnj+HMKJc8dw9SGTJcdhrAXQPtCXiEwZVLuSi3+NyHq0HSckkE8o9PBJ8/esnCDLg
 uiUDTFUOHBKHeXXEi3zcUmxZAdAHgv5H/GlSLo2h7UMXa9W7+4gPE2ItftlQOEYUkAICy6m4Q3O
 GVAw+ZWh16zaNnpdGEokgNkH7wys0wJLg+Plfxet7SUyYkGh+HQONUtKeOBBfgZgVQbTF0THurd
 hPIExC4/Y586Z0iEv3YXgVKp/d8rEnFhQo0Y4k3E9/N4Y/e3D7wlB3RRmjIX19rElcAfUIozH/l
 BGtTomeoRJJwjNtLbB2Iva15e58xgNg8qvTiReFziP918VanQq0LCKcYzQraiwkI3li7j2N8GpS
 kTn8PiXSsFdscfQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Increase build coverage by allowing the module to be built with
COMPILE_TEST=y.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 6fd904e29c3e744acf599c75147a25a01a3a2cc2..0fd5b09c499ac8468269b62a306f9ec03c3f7a9b 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -408,8 +408,7 @@ config GPIO_IMX_SCU
 
 config GPIO_IXP4XX
 	bool "Intel IXP4xx GPIO"
-	depends on ARCH_IXP4XX
-	depends on OF
+	depends on (ARCH_IXP4XX && OF) || COMPILE_TEST
 	select GPIO_GENERIC
 	select GPIOLIB_IRQCHIP
 	select IRQ_DOMAIN_HIERARCHY

-- 
2.48.1


