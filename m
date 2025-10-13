Return-Path: <linux-kernel+bounces-850661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B000BD37AA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B590C34CE52
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A80D30C60F;
	Mon, 13 Oct 2025 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HGTNrb/o"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD5D3081D4
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364911; cv=none; b=NVTo1Kp8Q6lFK9pJmEX/825K/JSmRfy1nyLGR2PCgrQDegwWtINq69qwY/n+Kz3jzO/Mbsk89zDPhoerkBmb3ox18XqbPwomlOv8vvRKLzjcrnyQNUqCNFKYmTOnrz3sB0AOCQrFuDoBIUpFfu//WE1/py5TPJCsvrPqJFDPsgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364911; c=relaxed/simple;
	bh=wrKOMHwKlcYP29CWxnwwTT7eHQ4f28o/AjBtQYuk4qk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KNSPafgoeerCqSR8mDwydi0q4iQXU77lEZAYiEirJdbFX6ie4Aw49ZdIp+OnRRmVKg8wKKYrQ5pKODuONwkAYDEfLXRkd2I7dtBRlrvS2CjhWECiX+HQ+TueJQ4ilEso6zCjP0zu43i0Xp0mpeCLuQ+VGxqrOLyRCFcUthkVbHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HGTNrb/o; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-57a960fe78fso4808774e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760364899; x=1760969699; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p8BE8cd4ehs+vvBX7b/XSqVzFH/A9VcJiWIwNhqGmEE=;
        b=HGTNrb/oldIeVPouKQ20E2UIpL7rvOEyVLwEfo5+bj5k5rlXh/IA7fJUKJ2rZ1/flE
         QiK4JlrXBqvZ47HCpc4N354Gmmks8IV0mmC43hCRrlVHockQVK7hcjjOGCMeFFsqjy+X
         Uue68ho47FRUvpI/yXBjJN7RXmmXCR74Aoqlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760364899; x=1760969699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8BE8cd4ehs+vvBX7b/XSqVzFH/A9VcJiWIwNhqGmEE=;
        b=Ccj2abP7dXfthLRMMSYH3HvhnpQcQWPD3QrgCcRpWHhRWC+nqsZ2A+Cn5LjCXaKeFQ
         9iw0uK/wDpGyRYBrRc8aoT6xJE/4tb+e6+PHJQfsXqukL2T98uG9Zb0kbjenyRMaj+aV
         5dJPlXKru6VaoQzmY6WyQo4BrvKEdKzLDylUEpamQc1nuF2f0bZuggEJw4S5dhNU9wpU
         PQVWWJWYjPAhfwU8G0bnG3ctVsByLC9j5Uwfv6QqnZ5W/wAHVfwSJmly4Id5R3ecjQtQ
         10pVKTeMHcxJYd0h0BA/SsrtejwXkppNOmS1x99SBabEey2w7vYX6QZuZHSuy+wBoH6w
         +Dnw==
X-Forwarded-Encrypted: i=1; AJvYcCWB4bC9+G/tQ5ynRnfFq7o2HraBMjvueXCbMh7+he5ANLgj7Zko0glzjihxQBd18MP/1QMlHfb5Ydz+SoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyodwwhJNNjbCDPcEVfRhl/Qh1gfDT0RDNQZlsF0mr53+blYjQ
	qi2cxGdp/jSuVUR847KxPsa7r8uoA65NMLrVGkBbAlJSLIDt99T2Cmkk62ZxvasxsA==
X-Gm-Gg: ASbGnctf1z3Ctt05g6DFee0WFGxzqVMzgrvlmDD+HyVjp7c/YjMXhj4Osn3JY5ScXaG
	EvaaxQUFPCVYHP9oWLX9m8cFPQshXl9GiI4aMgab0C1qUH2KNhUCHhZKivsiu6X5aLLCWDElijL
	oY0x4W6OpAnI6eUQqTN/l5l9U8w7FKJrtRTRAE/waUxTPIj7Ru6/R9v7guYTtenkMmERyXmthbz
	v50DvHAtkdIRyzlovo5/e8gpBODgXj7vP4Rln0dUma8S3AdpB5d5RwiLjDosKnd1wjTRGwK0M44
	mw4t2Lk/mY9TI1VsDqEOq92tsbqS8rR4joBkU5QuB3lQSvDZuGOf+k5VmIGkuuHyvKkmRQwTLu8
	jt3XyXsLu6x7co2+ePKgon52l1X1S1Dac7iGGoykFLdFT/bsDxc68HCL64NI/1q+Wpw1mWwtC2+
	Cqi8+B5pJetWhcafYYYwW0Ca9buiyJ
X-Google-Smtp-Source: AGHT+IGpJ2y0KS2EDpbOsMnyHnkw2vKTe9VvDcatboc6qkM7xgDjulc/G8CRi01zrNhs6YMLw6/H1Q==
X-Received: by 2002:a05:6512:1053:b0:590:651b:10e9 with SMTP id 2adb3069b0e04-5906dd514d8mr6137707e87.34.1760364898568;
        Mon, 13 Oct 2025 07:14:58 -0700 (PDT)
Received: from ribalda.c.googlers.com (56.213.88.34.bc.googleusercontent.com. [34.88.213.56])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e4e58sm4165256e87.25.2025.10.13.07.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:14:58 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 13 Oct 2025 14:14:55 +0000
Subject: [PATCH 15/32] media: i2c: mt9v111: Use %pe format specifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-ptr_err-v1-15-2c5efbd82952@chromium.org>
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
./i2c/mt9v111.c:1143:3-10: WARNING: Consider using %pe to print PTR_ERR()
./i2c/mt9v111.c:1151:3-10: WARNING: Consider using %pe to print PTR_ERR()
./i2c/mt9v111.c:1159:3-10: WARNING: Consider using %pe to print PTR_ERR()

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/mt9v111.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/mt9v111.c b/drivers/media/i2c/mt9v111.c
index b4f2703faa1854a3a5e7d92ef312d01a39879a5a..64a758c95ab7b767de452304615a8d1f986dd23d 100644
--- a/drivers/media/i2c/mt9v111.c
+++ b/drivers/media/i2c/mt9v111.c
@@ -1139,24 +1139,24 @@ static int mt9v111_probe(struct i2c_client *client)
 	mt9v111->oe = devm_gpiod_get_optional(&client->dev, "enable",
 					      GPIOD_OUT_LOW);
 	if (IS_ERR(mt9v111->oe)) {
-		dev_err(&client->dev, "Unable to get GPIO \"enable\": %ld\n",
-			PTR_ERR(mt9v111->oe));
+		dev_err(&client->dev, "Unable to get GPIO \"enable\": %pe\n",
+			mt9v111->oe);
 		return PTR_ERR(mt9v111->oe);
 	}
 
 	mt9v111->standby = devm_gpiod_get_optional(&client->dev, "standby",
 						   GPIOD_OUT_HIGH);
 	if (IS_ERR(mt9v111->standby)) {
-		dev_err(&client->dev, "Unable to get GPIO \"standby\": %ld\n",
-			PTR_ERR(mt9v111->standby));
+		dev_err(&client->dev, "Unable to get GPIO \"standby\": %pe\n",
+			mt9v111->standby);
 		return PTR_ERR(mt9v111->standby);
 	}
 
 	mt9v111->reset = devm_gpiod_get_optional(&client->dev, "reset",
 						 GPIOD_OUT_LOW);
 	if (IS_ERR(mt9v111->reset)) {
-		dev_err(&client->dev, "Unable to get GPIO \"reset\": %ld\n",
-			PTR_ERR(mt9v111->reset));
+		dev_err(&client->dev, "Unable to get GPIO \"reset\": %pe\n",
+			mt9v111->reset);
 		return PTR_ERR(mt9v111->reset);
 	}
 

-- 
2.51.0.760.g7b8bcc2412-goog


