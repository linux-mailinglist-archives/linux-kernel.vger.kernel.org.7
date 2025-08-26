Return-Path: <linux-kernel+bounces-786385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9454EB3591E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02B4686E67
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD8A321432;
	Tue, 26 Aug 2025 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="OUT608NJ"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209CD3128AB
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200923; cv=none; b=KlV/Ost/rlivzgrZTUvK4o0AnlqwShrUBA8dAXyDPyFL4NsV3JEEeRoSj7nDlZtKKsswWVh0aFAfD2EHD08ntY/L1gPD/FekHhaPPq6o5AoubdFp+/hl+Y8krFEqp33Fg5L9Yzv5zpXm61ytlc7K2K+1hI20EczuvsTilxg9cGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200923; c=relaxed/simple;
	bh=NCDmR8VrFkSe2Rau/GRG0O7l/vHPKCnQury/GJvGAig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B8B8WWQN0Qxo0Hxl4nHNe91ju/DU1q0rWKYkSFrUIdnY95cglRafEwL2PjxEMiKXaxKNB+OLoNMshnurnmc0kHcOJugYdXR4QJrxUKGek7ifF+15cf50oqq5mKki8a0o8Eg5nwW59Uh7LkmdjItvTtaJ40pglI2qYO5iOm62G94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=OUT608NJ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3cbb0df3981so162185f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756200919; x=1756805719; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SdMjE/IUNg9nUBZWSwSrF0HUJBl5tL7A+dP3nDcIACE=;
        b=OUT608NJcGURwJrZUmUYKr3NTzJmSzvvzO7WUY9/jMHNfMzUS4N6bxpLU+6j3tzBpH
         Nt1XoLKmQzlfLqB915GG7+UjwDz+aCRtxx3bQRa+r3Xp59YkcPI0T0tzIcyXkcxHDtPm
         jB3nQY0P5Gabl7AFG3oD+JPssmgfDOoI4Ng0+qtn+e5bugNRPG6A9f+THHNmhNGGnT8M
         pEBeuuMNMu2FjK+xYnUL5XWA4w/lAznhIiaau9WOzItLoisTA6mrQoX+iUHdBzJbDuVR
         dH0velcUJWokChWNSNBMuwUxMIdWyRx+x+BWW1b7DPYuJXQvbpJzl+blb45iCAol6MLe
         KSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756200919; x=1756805719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdMjE/IUNg9nUBZWSwSrF0HUJBl5tL7A+dP3nDcIACE=;
        b=Lh9WB0HZTYSTfdnKnn5ES2XFj9oM2HHUmAxUzRO1XqV11UBzCxrblE2lfSk57BoCpK
         ZvdfuDLIvwPJG38d/v0KZxas0/uEirxqPaXpzRlRDTB57G2Yv7tKm/ni68aZy7IDukTn
         8HzT7Ji7XNaVqpAZl3ic/tTyy6fc0ZTeEJe/JjEGpn0stDzPovj9OaTM+iQxKpLtbL1F
         +YJxn0kQv3VxgkRBwx/5FwjSK2iwur4TL4m1FeVstJF/nMygz/RCJcNVv8Yk9hCP/1o3
         nBcYpQ6/2bR3cAQMt3dKAA055Rs1ZtiAGKl+KXFVFlxQImE+Fzbp7joPld/xGzUE9GmR
         pB/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWV0CEyOUL19W9kr/bwI8Xw0dS+f4rCYPgCOM85mKdEIV56rvvZysbPJBf/xP0rnTxknlSkSiWZpuQGwVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwbIbeYUNcCgGkU8X1aL3XT+nnIXYIBEZt55/hZ1SNhamYvEMS
	X/aRxaygjsMp70mECnnG3ypjEPDVQBSr/2gEcekjYIMerxZ/jco0O1S6rVRzXb05l0I=
X-Gm-Gg: ASbGnctNbWqttRv+K4lmdjsRyqU8nd1yulndvF/ZniGc6CLLQRvMHEKZDeH6yr+q3L1
	esm9yYYPyb41LqalOFH6IjCdXeB6uA2toGod4gzrBsP//9YWDRzwk6sZGc4yZhptbtCsoPQ4MhI
	ZT1N42yGsDosk0ehQwJvSqoCSDCr5pW3lgmBdNHBByGuXGjQ4eE2It7BDIaXGxsGOTw4j3CJfwI
	GTXZk6h20NO8lkcLsoPIr6sUcxIX/87vfgYLPcaakn0LymV7CAsuL3W2NxQZvuYKBB1uHp8Vi0n
	ZeoF2nEqO8A6pGcVSVlm7AULmBxp38E3JtI8NjLl2v0N+nLtIj8NxLRhVJn85vItLH4c0wLGtmp
	caLNpRkKg7upFO8kvDgQmhK/UzY8=
X-Google-Smtp-Source: AGHT+IGFYppzg7ppfW2qCUHYBmIKcwWqnK+38KV0dVpWZJbB4VXKyNsvmKpRrAApETlF5QIhTbSsTw==
X-Received: by 2002:a05:6000:220f:b0:3c9:b8b7:ea3d with SMTP id ffacd0b85a97d-3c9b8b7ec0amr4709288f8f.51.1756200919352;
        Tue, 26 Aug 2025 02:35:19 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:fed4:79fc:9440:6629])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7117d5b10sm15308255f8f.47.2025.08.26.02.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 02:35:18 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 26 Aug 2025 11:35:08 +0200
Subject: [PATCH 07/12] gpio: ftgpio010: order includes alphabetically
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-gpio-mmio-gpio-conv-part2-v1-7-f67603e4b27e@linaro.org>
References: <20250826-gpio-mmio-gpio-conv-part2-v1-0-f67603e4b27e@linaro.org>
In-Reply-To: <20250826-gpio-mmio-gpio-conv-part2-v1-0-f67603e4b27e@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Yang Shen <shenyang39@huawei.com>, 
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1018;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=5rbP7dwhRhfDrSbAgYMHtgCgxy4erM0JGqfIF8jsC5k=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBorX/N9SEBtr9CQED5vzENsLuHUQqYMiCsah98i
 +4dFAPqdECJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaK1/zQAKCRARpy6gFHHX
 cpDiD/4801Pac5QlHO6D9jKqnSPRvfkYUesEBYjOQoRoQO7T3lf+1NnMxw62VB+bKhsMavf0Pbm
 hO4Nf/NyHZpSXp3pPIPf9G+kVN6fcNQ5qBrs+gvi7JsR0X2JGRgfZlxh91Vk12yRTsW+NDErwPh
 JmL+8+8nQeFJ6q3ss63UDHJvgZILjabTP5RSIH0wb7M50VPU+8QwdjAhENUEiBirB8f9QNC6jNb
 goJ5DFK2XnM7sIEvMN5gTAz9sbtGbRZCKyoI/HbhHu+eITH4TGjUPJPRuPmZHXqnRFoa8nz0T7E
 cVm1uU1U7CDvOl9ovupCoxm+qdoi4XfEqjtS9aOP6J8pXUCn+WHqJTSDseqMZwEEy8x9eN1gYKE
 GzQRnaSgDGQdZmp5eheDhiV8FTP+ayHa9JLVmpT+Z85XPGz3YPLU7c/nrRHKNlM+n6XO7w3wqrs
 B4BGQ9Bnzs1NMsnAQ4IbStfy/yuv9BJrt64xwx96w2WkgjmViYp7gMuz+DfAprX7CHwjoVvR8Zz
 inkriWAohdiEy6QdfmfNRMyyzE8mbYJDNdWopcB8mztbZOHe+frPa5b3pRbzTNFsFcxOIedt0b3
 k2dPSKvKi5mp0nqiyLBCC+x3tg02ix1A+UI421kKbUVpGS36GNX4S99VMZqQFJwElEDaiuX68Md
 6dX8YoVapsqzaew==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

For easier maintenance: put includes in alphabetical order.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-ftgpio010.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-ftgpio010.c b/drivers/gpio/gpio-ftgpio010.c
index c35eaa2851d8533309fe04a3e6265d9a7947606d..56666ca8889bc92b91b160751728b65e287b0123 100644
--- a/drivers/gpio/gpio-ftgpio010.c
+++ b/drivers/gpio/gpio-ftgpio010.c
@@ -10,12 +10,13 @@
  * MXC GPIO support. (c) 2008 Daniel Mack <daniel@caiaq.de>
  * Copyright 2008 Juergen Beisert, kernel@pengutronix.de
  */
-#include <linux/gpio/driver.h>
-#include <linux/io.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
+
 #include <linux/bitops.h>
 #include <linux/clk.h>
+#include <linux/gpio/driver.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
 
 /* GPIO registers definition */
 #define GPIO_DATA_OUT		0x00

-- 
2.48.1


