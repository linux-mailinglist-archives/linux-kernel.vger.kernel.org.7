Return-Path: <linux-kernel+bounces-850655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4CCBD3789
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4883C6D01
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FAD3081A8;
	Mon, 13 Oct 2025 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h/H2RjIx"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475A1308F34
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364908; cv=none; b=IXouk74ki1AZizU2nELTUrExpaRHjQCmznRzZ5y3YNiOS8BThXshja/FRO/gay9W6je2eJInWJt+QCXVb4S1l0pY4HIoIREQr5euyhESbhqcMFkX1O+ZL5EDjoRtP6/xsFxs+hueeFudw5GkNfHI1oXQjoDjjmc+x1PKsprFfU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364908; c=relaxed/simple;
	bh=JPx0giLNBAPr7LhNStN/lfffepZheYGDJQPhVGzb+6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RBpbYjBaowVF0JONcvLNqsggdyTsI/AfMUaZUenClmQH41+3F76hn4uMeVF+mRP3JJY2CoJLMW3d+TAYuURW6J5PW315XONt2TXk75EzHiRxx6OtvDhLytH8I0O17rr3SPIUh4u02EzxiTPP2vqeYJ05hjUJ/LwsdG4Ufn6MtIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h/H2RjIx; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-586883eb9fbso5711630e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760364900; x=1760969700; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8uWudxYngdjU1rcL6v5EBbp/gDU20W7uHc3A+q35uM=;
        b=h/H2RjIxmODKT6pS6/j7HGH0PivvkPqHlFtbwRpzPHaCFPJBX8vAcx4TvobJEg6GW1
         mdMuWCWSyuvLusid4Pq0Z9xn6VnjL214RA3NhDRMvUAoJRteM5ag7EMACNz0ObDyixBh
         Ih40Mwa+8GDJTFMrI0dtajJ0gYzo2p7QiCQXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760364900; x=1760969700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8uWudxYngdjU1rcL6v5EBbp/gDU20W7uHc3A+q35uM=;
        b=nXGZYyLWy/vN3l1yyNpyJNSvfseZcfhjJjqs2UHyeJP33QnlAuw4kqdkmJ7NeAFthw
         BGHIgr438Eb9UvaGII8b9n5BzPYd7oJOkzUAqksPhe2XgerdJ4jDd1rrzZD9uCn1C7nK
         ZeLAXkeeG8I9tPLpRqmYbXpyDUOv5IJ6fJlUF1kuq5Q6kBQTNmb6rpTQoueRGCaeQzce
         CZvKicEWaSOCO7aI4XnCdl6NyslLXU9mhx0FrX2voxgZeZfhjtKD8L+M3THz5sg2oRX8
         mphf3457xdJRTmC0jmpfUl5gtX1OCIIMMqBYu4WDzEC4aDxlNPBMLaRuEZ6sWoepokMY
         uYPg==
X-Forwarded-Encrypted: i=1; AJvYcCWyyfQBS/lGKTgIDvX3VelyXx0ROyTD7nL4cTfABmISz+oKT6rDIV2Y2on2JQIusy1Z8gJLBMHLP78xSe0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6UNVkwWE3b6OV9ipnJyW9Q2/FtGUJgTIzjen5UJouFAVXl03J
	/izfFbzGhY2/4rclPQhzsKl4BQZMf8kOCom3M+b3xEeRR+aJYRYb2wZ8r65L72W61w==
X-Gm-Gg: ASbGncuQ92zKXwVJRXqLAzeBNKWYaPaRfkxtuPx5d5C98FehwETKKqZPZ/Kq6hj0Nqq
	AXrzDQ+3bm7YfH5t6RrHQMYPjtgrf4h4Qf6mObxspMV/t+pjgCUDvbpbslbeiXDyQB0H9FZM15c
	NhREjgUbNpODWfH1ZLAcM5+ojbSaSDv9+2KjTAAH9ZCRyvVVagsiA2Dj9v2fj5jASZ/HnVLz5Ua
	7Zb8SbvClMJt72vQpWdMlGIeP9N8BTNPG8o2xWkQeUyaObdqnfVZlGSCp0zzK7NLGbjWuZg+wVa
	nR0Q2rY6YdPDKp0vhIw7RjJwdzPWTPloVjm7icbm9iOEHIWHnu/+ceAGRXQcv5LZKxmXx1tgMm6
	C8AuJ3cGQNUz778II0JxtL/EQQkWu9jlV/J5fK6VqUvWxSE0jgVQOLTJda5Bsxz8MGI+SiGNPkZ
	eSgQB41kO+WECYyQCvzA==
X-Google-Smtp-Source: AGHT+IEH9NSSx39JZw7O8X2sLmRDHl36VtDy7qnNgdDgO7X/hYoH/eK9oEmeokNHWwuJqGEVp7ffAA==
X-Received: by 2002:a05:6512:2388:b0:57a:6d7d:dd7b with SMTP id 2adb3069b0e04-5906d773bedmr6254025e87.8.1760364900095;
        Mon, 13 Oct 2025 07:15:00 -0700 (PDT)
Received: from ribalda.c.googlers.com (56.213.88.34.bc.googleusercontent.com. [34.88.213.56])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e4e58sm4165256e87.25.2025.10.13.07.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:14:59 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 13 Oct 2025 14:14:58 +0000
Subject: [PATCH 18/32] media: i2c: ov9282: Use %pe format specifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-ptr_err-v1-18-2c5efbd82952@chromium.org>
References: <20251013-ptr_err-v1-0-2c5efbd82952@chromium.org>
In-Reply-To: <20251013-ptr_err-v1-0-2c5efbd82952@chromium.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 =?utf-8?q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Leon Luo <leonl@leopardimaging.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Jacopo Mondi <jacopo+renesas@jmondi.org>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
 Julien Massot <julien.massot@collabora.com>, 
 Jacopo Mondi <jacopo@jmondi.org>, Daniel Scally <djrscally@gmail.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Benjamin Mugnier <benjamin.mugnier@foss.st.com>, 
 Sylvain Petinot <sylvain.petinot@foss.st.com>, 
 Yong Zhi <yong.zhi@intel.com>, Bingbu Cao <bingbu.cao@intel.com>, 
 Tianshu Qiu <tian.shu.qiu@intel.com>, 
 Tiffany Lin <tiffany.lin@mediatek.com>, 
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
 Yunfei Dong <yunfei.dong@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rui Miguel Silva <rmfrfs@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Martin Kepplinger <martink@posteo.de>, Purism Kernel Team <kernel@puri.sm>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dafna Hirschfeld <dafna@fastmail.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Yemike Abhilash Chandra <y-abhilashchandra@ti.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, imx@lists.linux.dev, 
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-staging@lists.linux.dev, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

The %pe format specifier is designed to print error pointers. It prints
a symbolic error name (eg. -EINVAL) and it makes the code simpler by
omitting PTR_ERR().

This patch fixes this cocci report:
./i2c/ov9282.c:1133:3-10: WARNING: Consider using %pe to print PTR_ERR()

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/ov9282.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov9282.c b/drivers/media/i2c/ov9282.c
index a9f6176e9729d500a40004de92c35b9abf89b08c..3e24d88f603c1432865b4d880670e4b67f1b5cec 100644
--- a/drivers/media/i2c/ov9282.c
+++ b/drivers/media/i2c/ov9282.c
@@ -1129,8 +1129,8 @@ static int ov9282_parse_hw_config(struct ov9282 *ov9282)
 	ov9282->reset_gpio = devm_gpiod_get_optional(ov9282->dev, "reset",
 						     GPIOD_OUT_LOW);
 	if (IS_ERR(ov9282->reset_gpio)) {
-		dev_err(ov9282->dev, "failed to get reset gpio %ld",
-			PTR_ERR(ov9282->reset_gpio));
+		dev_err(ov9282->dev, "failed to get reset gpio %pe",
+			ov9282->reset_gpio);
 		return PTR_ERR(ov9282->reset_gpio);
 	}
 

-- 
2.51.0.760.g7b8bcc2412-goog


