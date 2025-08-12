Return-Path: <linux-kernel+bounces-764722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4628FB2267F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBE9B562B6C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209042EFD82;
	Tue, 12 Aug 2025 12:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qZMr88H+"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A542EF672
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755000780; cv=none; b=HgWD/6ZxwSExtu99XH4yzbLS9IG5/q9lAi3Yflv1sZkKINOGyA02jPzMWkW0t/IKHbcYjrCLwUp/75QDe0t3zC9u4tfX4QyXug9sKfci08JBY2Ur7fCYo6AX7Gxni88TkJGi8UFfsDYVHAZgcGiyswtp6X1ukthH+JJ05N1qeRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755000780; c=relaxed/simple;
	bh=1thbdLmTFudV7ob9RYvrVsAtyDB0jUXy5XVU1fSzbt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L1hVs9qXXk6EXxJOKP4z5Qn5w9ZZLBfx0ea58Nowctdm9MAjhlyXdBP94v2v7VXtW584nxkyIX/qV0OPl89mEANj/6EyuszYltBAVKcAVGSUOmkzVO8doxGHYLf2s5/4Ul0uN/dcX97+CKDBpIgWdFdv/wlGKBvy6/VTHZ91zJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qZMr88H+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-459e3926cbbso22760685e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1755000777; x=1755605577; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=leTFdfCJ6+RyienTiSwh2q3pg0tznaooZOPdYThkYBU=;
        b=qZMr88H+wU1M1bZgOc1RQlKbd/L2hQnNUsOaHoSOOAuSPCALSIKOe9Dz+jtZPOSDPE
         HYoHc+wptfbK8DBf5h0gCCpbdSYz++q+NCNupNdE5S7ZUDFKbj/F6J0uVykmQmqoPfjH
         b0Z1Qc3qD2OIqwMcNLiXyTMVdJsO8Zk1bTtfVYLMlxR78eMe/dHrJGTizfxDhqLv4X4h
         XSZfwTZfdsCX7GwuEkdwWYcDBauDEzX8bGt8TwyrcpLh6f3lJ1ZM5ZyFGUMtPPrlWIC5
         +sB1xzLToGT20+6WpZYb8/Ux3JTwOxbkCE0SCzXoW1HYI18w0Mbv/7BInMZVc20XkMUB
         CDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755000777; x=1755605577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leTFdfCJ6+RyienTiSwh2q3pg0tznaooZOPdYThkYBU=;
        b=vyR9pshr7PReQ5q/r5LnUpgWSmf3rKSiuWSBN4tsrzvpgJilvt5Th2PrpbxoU+n0Dg
         sMtiQ+Drk84r2teOLbF4MM30oC/Ca9X4JjjVrAdG+KpdeVmw0/i0Tzg4+KUYxOhSn6pC
         v6Vwi9dR1xYuzra3EaPNbngW8B8eQCSdX7TtItKNPfKPD7tI2m2lC+flsTB1jO/3zkil
         SW3rKaoISRdOkk+ULg6C5J6TvuFVUmZfUVqxpMyxddPZNA+8ckfwc74je+9tuLCh1pFp
         FwRvM/OUdqFTe6+mxJSjBrh36IbeooOyFHugwiZsQUy4/LQqzTg9e1KbQPLUfvFWwpHm
         x3RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk1Cb1tC1b+lxLcSw7X98v+Md7w715uyFeJs1NSErJB0Uo/ALYmkYhRV46SXPtEzkbb5C+E3EXY4PZaQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFNZybcPCwnLoRr8Zw5vE8G3nv3vOVoi7SzCk15FPklhW3oC9X
	PoRhiBCM1w1eGGhE14DpM8VEquU8/15B+CQDvuOAdHwBXIGfXvFUZh2Ds67TwoCxcBc=
X-Gm-Gg: ASbGncs+3U6+NkVbPQKnWUeWm17dz7PFYc/7FzU4aR7eE9SlyxxCiHtgfGZxpK7olQR
	djMR6fzeERNl7lQ6FSWfD/xqDi3+IXYup5xqMVyzOhGbH+71WZyESXKohWRdpxkuYneyezEhciZ
	eMswX9G0t1mL33z7kXlcSSOJLHSjN5Y/1kcFhk+lLGwz/Ne8i46MmjlmVpjxJcsgfK07O8uKASS
	2rZD4iUoBSUnE4+EUC5jpYWEAp7+MmQGkK+mK8ZuXoOs+RgRgtSX5tqbVUG4X2VxuUrSsHFQIYk
	4k6UJKhjta5NFRxTsxkggMmHK/IXnZB1+mYGFvrwTlqaARQAsWThrrm3PqjRGq1uItGi0dcz6Mf
	PekdIBqbrbaFgaZw=
X-Google-Smtp-Source: AGHT+IF6XUNQqdgkTgQ1x508mMFEJILvogWUQiqNdeAa6GhrQVsxNo41mqXOWucvHGax0Ff1hCkQoQ==
X-Received: by 2002:a05:6000:2501:b0:3b7:7904:58e1 with SMTP id ffacd0b85a97d-3b910fd9b5bmr2609829f8f.18.1755000776890;
        Tue, 12 Aug 2025 05:12:56 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:16c8:50:27fe:4d94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e6867193sm298878535e9.6.2025.08.12.05.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:12:56 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 12 Aug 2025 14:12:47 +0200
Subject: [PATCH RESEND 05/14] gpio: ts4800: use generic device properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-gpio-mmio-gpio-conv-v1-5-aac41d656979@linaro.org>
References: <20250812-gpio-mmio-gpio-conv-v1-0-aac41d656979@linaro.org>
In-Reply-To: <20250812-gpio-mmio-gpio-conv-v1-0-aac41d656979@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
 Hoan Tran <hoan@os.amperecomputing.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Yang Shen <shenyang39@huawei.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1370;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=nK9pJAlcVqEpACXDhaB9m0pP1KYR56NEQPbKtHUMK9c=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBomy/AfBGPkXA/Gx1NQTrE2MGWSh+bbw9a6LktC
 tVUC+TxlsKJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaJsvwAAKCRARpy6gFHHX
 cg6ID/9R0nU4FuZj92E69M440ZEDgNL+2sVxByXP837eQ+0pL6Y2i1Rw+Z88ZfQU2/dVmAZu5XB
 3LCHN/2SKxRnxiicvpAsM6/Qg6kbLJR2D/A3ZqDSNSqxU4BxLbDKQBR7pPgiyUzGQGVhI5eumI3
 9jd6TKMUtcvXnU9n5/oAgEUvybw0ZSixmd9PZv+v2e4d2bztBg8XJECzIdgJPZf9qZScDDXE+Q5
 aNae4RGa8YOKTXlZNf5GHeeFg40lk7CeWyouIVscIWnX0xIOrjiGLTks1C5gLF/W+xa8K8SXYJ7
 On7k5ZBDUcBWQOsS45qPB5KeuJKERjrPhIib3p9RWyy0YIiJKOkNhGpWzTQ2ThD6Gn3XLzARP27
 s1JHeWYporbRbxsJyB7MqG2QGHQQSO79J4EoFYhxjB+TmxGFcC5ZbuIk38c3IlnuE7mnWozKIW6
 tzx9VHG+5kG5FVEUNval2YsE2eo7RZQ52ccIJjf+vcU7+b3LGpjsKacexIFpoFhCudFmERx/Uo3
 eOvmi6E1R9aIw5XJTETiRhS5AeuDxrYW1390uJe18Ga/NzGyu7qrpS2Kl+nWrsdxfq3vwUi4rW0
 /bZdLyMNxFfZHLTUfOhnB9ame2IXik5GQeaSz2XKEEwUvpvgnnqdeNklJRO/wFzASV5FFwdIJIv
 s1zeHp0yIMdAwVA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Avoid pulling in linux/of.h by using the generic device properties.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-ts4800.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-ts4800.c b/drivers/gpio/gpio-ts4800.c
index 86f7947ca9b2d23292c1e6660fe93c611e0cb837..f4ae87325393c909c66eda3bb7b2f849e645b7a4 100644
--- a/drivers/gpio/gpio-ts4800.c
+++ b/drivers/gpio/gpio-ts4800.c
@@ -7,8 +7,8 @@
 
 #include <linux/gpio/driver.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 
 #define DEFAULT_PIN_NUMBER      16
 #define INPUT_REG_OFFSET        0x00
@@ -17,7 +17,7 @@
 
 static int ts4800_gpio_probe(struct platform_device *pdev)
 {
-	struct device_node *node;
+	struct device *dev = &pdev->dev;
 	struct gpio_chip *chip;
 	void __iomem *base_addr;
 	int retval;
@@ -31,11 +31,7 @@ static int ts4800_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(base_addr))
 		return PTR_ERR(base_addr);
 
-	node = pdev->dev.of_node;
-	if (!node)
-		return -EINVAL;
-
-	retval = of_property_read_u32(node, "ngpios", &ngpios);
+	retval = device_property_read_u32(dev, "ngpios", &ngpios);
 	if (retval == -EINVAL)
 		ngpios = DEFAULT_PIN_NUMBER;
 	else if (retval)

-- 
2.48.1


