Return-Path: <linux-kernel+bounces-797957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BA8B417A5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC89A1BA3A94
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF552E7BAC;
	Wed,  3 Sep 2025 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EkhiNMDw"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EA72EB5DE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886435; cv=none; b=rZruvKm4kxxE9mqo37F3lzrlB6fLZGbC/82byM351aHKsgMQZ20EzdrgMUVBXbnnWPQBoo15hoqTlCsCWAUTwq4k7Vjfb44abhrHcqc09XTu45vuZLSP1it2H0iKV3l7mDoviBrS8FE7YwOSOTuqxBZQ/UtA79FFoyFWyMNs5ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886435; c=relaxed/simple;
	bh=IPumybGFRYFYQaM9OlD6dpGN1i1pIA9siLLRAwG3nFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YDjYHlD+WOf3A9NK9CI7cP9SygUi8vsc5SddNVFX3QQG9MNdS6bEVCcaQEfA+34xpsDXW0WAhUg/GaBNX2bn1rKMmNJD3NpVml4uWnu2ANL1kDNS+8xQCuT4VwA78My1eoJk8ouHrjBDqvaVRyrGpNqmgK0CD8w4mXR9csY/NY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EkhiNMDw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b79ec2fbeso42032595e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 01:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756886432; x=1757491232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xl9c50SijOEdAZRChzrnPJTZawBct2jboofqHxITrdY=;
        b=EkhiNMDwSeSay4o4etE3iYe1iCNYO74pCLy2KdN75HPPFowTLgRqmEDBeiCxLBoIwT
         YNMZVjGZ/AZL5B1Q27SKml4hre5nRdfJojdfKZoHDJISIA6wIYZ1eZyR0YAuK3qEJSJz
         bTOMvT2SUubGiVxVGRAW8v+dIBkpmIVZ2mkX2ypL+ghwxFQ/klis3jnv0USbciQ3DYYU
         DVms89IvBXFPUYMP06102zuX0ZxFmg6SzsAQAlsVEfjXMA1ydGAqRkny8jQcf/GRDZ+T
         URE0hlTJC2VV08TAB6m2oActstiPZ0W9st8DIkMG72Srmm3k83a+yXCdmq6TI79tYYBN
         5/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756886432; x=1757491232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xl9c50SijOEdAZRChzrnPJTZawBct2jboofqHxITrdY=;
        b=e0L0F/DxMB+6q6/tyGFd8DVGIz8G2+DCy74/uPzUWsN54jlaHG4G5t5PZXGzShJK6b
         rdaEoS1cRg8I1UuUXCxgOVGhJGv+gDWXfHiRWFy9ao3U60KY89SIAcPOzNxDnmedcjft
         qn00rNQoOd97szFe7E8kp5lHuW7KqoIVrHNvhfUnyV9pPnyHCc4u8Z0YTGY24SfvBMG7
         Lh7zq9ehLYeWGhR7vi/Pt3iaJ6Jd1bjWzDQcYFwN8tR3x0rzbh2Op8oXozAu6THK5j/5
         SmA4JbUxwoDMhnfSl7UyFgwNcrp1feGtlPgbB9RHeceF5NIeLTLwE579qBxbf9UEGOte
         Oyrg==
X-Forwarded-Encrypted: i=1; AJvYcCWD7BWxyseB7jC3oMc+rE0p1Y4TSgBaXD0nU62KqA5sPRriDu/2FY0obbPOyFiUPkMk/DS9HGearBWGnd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXw9cRD2oMuoqzrybulwTHK3EdotYqBM+HfCFG1LKHwH5AkLZT
	ZiH8StcT3ZH6x6ULg06UJWO5pRqw0dTn32ZFPcUWAEbkqFeignEj+5AybeQsfmmi5WA=
X-Gm-Gg: ASbGncsRF1xgS9B662pUYoGA2/tX3aCGnybd2sl/Bh2CuOW2B4lFRDT/7V1LIFHjItc
	XUu20G7IFBKtmW2rtw7xRTT65NEV+uCFYmULVJJZCeB1RIklF7urU1XpKXl597nNAOssHW0d9T5
	Xajb3lGDNsxnNpFcclAc5RQDdblhG48ADOIhVQ8XpRmaSpgNdfkNMpv9Vt3xfO+hZkedKBfZA3y
	lguTzCvg3Co4oOT2DJAKpiw9I6BYmjMaUTkAxaYQa54UkpfLhLGl5qnA2JeJg2xtygmqZQQ9BsD
	J9TmocLcLZL2Duk0nM8oFfg0aqbU1okgYqJw0jgmYqo0FoeB4JBZiHdiVRDm6U/1Hy14hI1q7f6
	nTO2tYYv1ZJ7ItL/UgVveug+JHXU=
X-Google-Smtp-Source: AGHT+IF2bnM3rciUVbRMrNwmO+YSe6bBRk0RN/gGbq8L7FMVer7GZO86jwyTuVa/jTrPDmY9JPEBSg==
X-Received: by 2002:a05:600c:46c8:b0:45b:80ab:3359 with SMTP id 5b1f17b1804b1-45b8549c269mr116288125e9.0.1756886432069;
        Wed, 03 Sep 2025 01:00:32 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:2f8b:4799:6bd6:35df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b83e954b7sm113331635e9.1.2025.09.03.01.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 01:00:31 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 03 Sep 2025 10:00:14 +0200
Subject: [PATCH 10/12] gpio: ep93xx: order includes alphabetically
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-gpio-mmio-gpio-conv-part3-v1-10-ff346509f408@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=SeHuZ4DyFwDbjs5OShkvtEguX9jqUfBZsavpnJL0KgY=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBot/WSv3trZSskCN08g6ztefjtu8g89Qs468UlP
 JhNKWGRoYqJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaLf1kgAKCRARpy6gFHHX
 ck6qEACV9xM3Bt5eAt5FKZW48qyPbqMf5pY7l5XUTZ+Li09j3ed6/2R3UB6jMZWQvEkintiENSV
 J8By/NYAK4bUYnVe3rZL6Riuz3NnRt7SLjU/DI7P6sMgGwkeEITYCQgZgFKik31jX3hK5gWyxEv
 WJKvrt8Tk8EhJyGrJMmng7ppj0kLU4CsB9hcW+GzGja2pjhI8d/gLF7weFg8JX2JynngL72C8bH
 gS8LKxDx4JtjReUqTJFVJ1yWBkQ9uHZ8Zn5qlbivGwdoo5B4raqBIUmUqMhz8L4/CyrRFFWJtSs
 TxAjpLuAI5tOzztMl42AyAKnG23mT5670+oLdSCC+g0Ns0jIUO2cLwFi3DaEbFhBiZYO1oaaOyj
 jdmnMzotD1HvlI0COVxnNFdd9uTvZxhduLOD6yR/RLWTAR3GalX78PTp2R2CcBYXT6UG/pWFPgr
 F75LNdWHDcmCUZx4JeOIHBvGjz3Km2w+ecrIAM4VrxrIxZQ0G1U6PMPXSXfzdrNf63fp/lYWicD
 LINF1QLAlwABiyEVV6qD/0i/gc6iWIyL9e62/lvSQk7+qbIduSlgn24qa/2QyKZSPe8LKslBWhq
 d88D5wmIoE10KJBLDO8WAbYyPPia8OWbIJJlL9z73xorUARUXsnHkOyz3s57BhAuuVwF3vo2WKR
 OFj2ms6wO2yJIJw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

For better readability and easier maintenance, order the includes
alphabetically.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-ep93xx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index 58d2464c07bc360137f3100de4e4147030bb121c..08e5ae8bf4d1a80ca26680a3c7bff0b8039fa41a 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -9,16 +9,16 @@
  *  linux/arch/arm/mach-ep93xx/core.c
  */
 
+#include <linux/bitops.h>
+#include <linux/gpio/driver.h>
 #include <linux/init.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
-#include <linux/slab.h>
-#include <linux/gpio/driver.h>
-#include <linux/bitops.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/seq_file.h>
+#include <linux/slab.h>
 
 struct ep93xx_gpio_irq_chip {
 	void __iomem *base;

-- 
2.48.1


