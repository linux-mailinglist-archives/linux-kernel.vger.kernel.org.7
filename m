Return-Path: <linux-kernel+bounces-786381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9672B35915
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F99316FB04
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458A0319867;
	Tue, 26 Aug 2025 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="05Tnd2YL"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D10D31985D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200919; cv=none; b=Bu7KQ6WJp7Czb7Qe1NAflGiMx543jT1XZbeqsLEKK9W+DQF8UNCib0gwQHFWBnKL3zP7uivRmfJrHLpHYbTewXgAaCqn9eCF5Ob7hGY3ZW+k8LI6HyC8rUzI6H737ROpCNW1Ovn9gcJ/97hb15C5KbZ7xtk8+7NL8I9ojGtvdzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200919; c=relaxed/simple;
	bh=Gfv9Ago94CXP5utBaw4fU+EZTbz1Kj7tHHZOzfPLbKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UGzITUJw4ud1+HOVDgYIuaVV4dL9RSiNRMA5WAqWLSjc+NjsGvD9Pal2uwmltEjqH8Hfdb7uxHh9pCKwM2ujWc83CDU0mBrEUiExjMNzXaXpOM7c7Cyes6x5i2Rq85y+qLC8JR7UmyufkMY0lziskxJkP3USmHdl7/+ZEM12TXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=05Tnd2YL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3c7ba0f6983so1269690f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756200915; x=1756805715; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVtjQaO9FUN7/XwM1xAPJnZOqE+/4XCsmHPSuPjcvYw=;
        b=05Tnd2YLaIUWgva18xRPqEN5vRd/5kbVeuN/OAN4KWJGTZeTg/e/gFL39p9Le2A9Hu
         XvbkcAhZMLZdBAPfX8FnYQr+k4NxLSoOXATJSvwJAkmIi4xpuQJXSxshHl4FxcFIuE++
         pXz/CKkvpS3wWlOa3WceOzUDeBt//p0vU6B849ykqUPKsZ8eX5fcYFdoBaMHDGZCx2cU
         pR0nIjh/3nbsgsv/iSDDsIBVtDJNWMvMsDWjykhDcYRxsLcss6XNUP+EyhJB8tQk/5Y9
         y30DuTodYDsDLQEBubSBLdCEUdOFxIeYHkUdNTr4rtsfUx+hWUbto6Fwv0W8pIKpI/y4
         nCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756200915; x=1756805715;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVtjQaO9FUN7/XwM1xAPJnZOqE+/4XCsmHPSuPjcvYw=;
        b=lZth54t/cqlV+DIjX09GRbAMnvIy+GxZSR1nOWSKT3AzIxEJsdbUHVAY1sUtm4RL+R
         h8JjsF0BxGmn89lo75k1nb4IOgn1WPGHvSaiupyg8hVf9JH0IPozcxgVUB7syxUzvAwl
         f391nhYCSDvhP9LaK9tpWtue6EO5GG+ved0LeSQ8UY3Xg2/2NaRXoe+FgeUXEvesuDU5
         U9Yj4GckF8UCykfsEmh9J8LThjQkmXZspz+Jvcc8AW4tGLGvZDVQIrAqdqjCg0PL/O+a
         L9tlIKgkW3YAQSQeTez7yYaYqftdzL2IkCN4sdLiE9ovssxXDnbey5JpelIcSbs57xGx
         7Drg==
X-Forwarded-Encrypted: i=1; AJvYcCX0VmsqhX0TUob0BBUo4bMJWOIEvyP+L5qvbheLKegTeBZ0iRYovb1hUQUvyjapE73J2vK8QKzi3nq52Qs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1eYQTO8an49zmjW3WRKu7BB2XyJHpyf6uFwJYmore/G0zmapa
	++BsG0fFygtG9uWx1OEamDrftIX5RaXA9lTbjytq5ElxlqVePrSsM3ly+guR9nSjMX8=
X-Gm-Gg: ASbGnctsIX185DSwIf1f8tsoFZN+gN+zsVgLhWy9aPDxD3865NqFdD5zlThtZpdjdja
	Ivs8jEaeV6W4uQYZr3TM+SceaTWTKcJT6SQS1LRTpObapcT/k0xuL2d5qCfKQt8/aa6btJJEkAi
	ATwoQNlA+dSbsoAW6pJsXIokaEBZSBY1U7Iqx9V+lbhedXsGuztr5Dn+gYbPq2i5mldf5/jYRsh
	C9UHct8hpVaiNjZPqhVOvhO5aYq1GHL2W2VjmNL87FBK6kmLziZ2pTeYIFcVJ7QNp6REc22TjGq
	zdQTh1AnSvjQl9zwNVgwktW1p5lSJl2rmdQzPqioUTq4tHOJl8O82/WMGPdEEa4o5maZc6G6bsN
	oKTpM9ZfRy7gO5o6/
X-Google-Smtp-Source: AGHT+IEcoJsgmjphkLaCY8z1x0fKRWtSW7NIH2rbVg0Bebi0KJdLdeLAxxGphoPes56w3cIWmHwWUQ==
X-Received: by 2002:a05:6000:2212:b0:3c5:91be:2abb with SMTP id ffacd0b85a97d-3cbb15cb064mr776761f8f.13.1756200914980;
        Tue, 26 Aug 2025 02:35:14 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:fed4:79fc:9440:6629])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7117d5b10sm15308255f8f.47.2025.08.26.02.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 02:35:14 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 26 Aug 2025 11:35:04 +0200
Subject: [PATCH 03/12] gpio: mxs: use new generic GPIO chip API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-gpio-mmio-gpio-conv-part2-v1-3-f67603e4b27e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2419;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=9MCYThfKCHi9V3LmNZZ162FlxVao+jUCJlB1GFrLa1U=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBorX/Ms1es94ApzC2OU6uJvsfb71RsumjFI0ECG
 asyeGyiBViJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaK1/zAAKCRARpy6gFHHX
 cpKbD/9XhCYwy0uO9HF7kjT7iMcsW+OG0CBIKIZNICRSe2gz9bxqp7ZkzGEFy75ZhruK8txyRHM
 1QljkZkUlMc4VHZzUDaTn0kmO0ZjZJj/UmWeLrjYxVZbScxHvwnXdUeoJCehxXtS1cAdFtdAo9j
 sIIQtC29Lvp3zyYgs/BvkqBz6uBHnlLUjrj2w0zpLYN2kA2xkMrCCP5RimnAeR0j8MBegwta1Hy
 l3c3S1WrVTF1umKHxWJsxC+8q57se+Sxzk6IIikNDu7M6aPAMZdFpaDVgkiaL0OMfRvemNNWa9S
 zIpJIt7g+l1NOBFXKsDLTWCbgpmS6YX6eNBgm2MX5Yv+MtmXitZL79GU8VNYNFkXaj1wS6u5UFn
 qVrUTfFWrnZ7ZoIU48RtQDHnN1pptQShtsKl2EPelamaZsPdPIRaslXV3N9YBf0Rr0z69fmAXXX
 PSqOBLuvaylNBGIq6RzxslEZ1rvVw60+LTt4/fmNiTsVt3cux6Lq3brvc1D+uWALEa9SF16ewWY
 b11ayAUAoiSCVWDX2uuSMQ/KTcFlW1qr4qce4u/2q/UjRxSIMf5xyDLtDJVtyYB6DJsiLrPX1pA
 /wdqeFK3IhPoU8Oy6rnINzo7Rk+u3uCZuefbHiJrOQv+IbOEZRsBgX0mZGtkwhT3pMQKcM85eoE
 PDNXJixR2NMtbxA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Convert the driver to using the new generic GPIO chip interfaces from
linux/gpio/generic.h.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-mxs.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index bf0c97f589c96a5dce37dc140babda5998d5e365..af45d1b1af6e049899ea6773bed92fb8a84a0dff 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -8,6 +8,7 @@
 
 #include <linux/err.h>
 #include <linux/gpio/driver.h>
+#include <linux/gpio/generic.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -48,7 +49,7 @@ struct mxs_gpio_port {
 	int id;
 	int irq;
 	struct irq_domain *domain;
-	struct gpio_chip gc;
+	struct gpio_generic_chip chip;
 	struct device *dev;
 	enum mxs_gpio_id devid;
 	u32 both_edges;
@@ -258,6 +259,7 @@ MODULE_DEVICE_TABLE(of, mxs_gpio_dt_ids);
 static int mxs_gpio_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct gpio_generic_chip_config config;
 	struct device_node *parent;
 	static void __iomem *base;
 	struct mxs_gpio_port *port;
@@ -319,19 +321,24 @@ static int mxs_gpio_probe(struct platform_device *pdev)
 	irq_set_chained_handler_and_data(port->irq, mxs_gpio_irq_handler,
 					 port);
 
-	err = bgpio_init(&port->gc, &pdev->dev, 4,
-			 port->base + PINCTRL_DIN(port),
-			 port->base + PINCTRL_DOUT(port) + MXS_SET,
-			 port->base + PINCTRL_DOUT(port) + MXS_CLR,
-			 port->base + PINCTRL_DOE(port), NULL, 0);
+	config = (typeof(config)){
+		.dev = &pdev->dev,
+		.sz = 4,
+		.dat = port->base + PINCTRL_DIN(port),
+		.set = port->base + PINCTRL_DOUT(port) + MXS_SET,
+		.clr = port->base + PINCTRL_DOUT(port) + MXS_CLR,
+		.dirout = port->base + PINCTRL_DOE(port),
+	};
+
+	err = gpio_generic_chip_init(&port->chip, &config);
 	if (err)
 		goto out_irqdomain_remove;
 
-	port->gc.to_irq = mxs_gpio_to_irq;
-	port->gc.get_direction = mxs_gpio_get_direction;
-	port->gc.base = port->id * 32;
+	port->chip.gc.to_irq = mxs_gpio_to_irq;
+	port->chip.gc.get_direction = mxs_gpio_get_direction;
+	port->chip.gc.base = port->id * 32;
 
-	err = gpiochip_add_data(&port->gc, port);
+	err = gpiochip_add_data(&port->chip.gc, port);
 	if (err)
 		goto out_irqdomain_remove;
 

-- 
2.48.1


