Return-Path: <linux-kernel+bounces-850663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7166ABD37C5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680E73A3169
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE62030C626;
	Mon, 13 Oct 2025 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C7jMGw5a"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212FE3090D4
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364915; cv=none; b=c6UniDBaKxiDt+aL8i04AflSapq7ynWHqCeK/UXjjJMO/h4L8AHYHjIulpiHaHhgNSG3bF5AcXtSLIsKReLyr+6mG2dOHETYL5OCNAlGwodkaPgblRUkPaXU8FGD8vUqaKr359nAIE1oUKsOrKJStlkp1oKRuw4m/fkGcWRhx0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364915; c=relaxed/simple;
	bh=Pzzu7GhYxyifz0hH0hqoTi5DPNxH7bOKzjeCFjKc3co=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S4RmGPKo1eJChTr+coWhptlSD66KtWbt36AZ8vIh0/uwPII5UBM6HzQJ5TgkiBdTPkzfdlmiyDS2IhRceZDp0YWDYT5V1a3/V+5wXzSSMGiRS1VYlO27aEWR10J8yOKmapm9b8rZXVKm3ibMYGQHqfnaQdW3P9c/JxPON1YAIr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C7jMGw5a; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-586883eb9fbso5711651e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760364901; x=1760969701; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQZvCnP1P0SuqiqaQUtwVRm3JfcVlv6UnYBLGV8/TWE=;
        b=C7jMGw5ap0b3UkHYi5TYPhtTGUfLpuyWVjuXwsJrSLgqJxJDxv8Jrs+je2ZCgNLctd
         IPAHDOh3zhmKkw1CCI7aS2w3211raMFFlAQpiKVI+vR9tZpuhjrFx+t0h9uNW3k+nvfq
         MIg4WjxOOEXDLl6YAqKyAG9au+eMxO3EnQrx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760364901; x=1760969701;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQZvCnP1P0SuqiqaQUtwVRm3JfcVlv6UnYBLGV8/TWE=;
        b=IhoUr/iGud2c1m/LEFwYnny1T2m+tmV8BuEqpcc1sklCF1bKxCpiL7TB7k1C5aIM64
         8+SmeWM3rKSahwZi9Wy7xMKGDbAR01aN0Yqu+vCCN7bh09AjmAv2vODeMFlEbJuaAzH2
         EH3OvhR38fKzhozDLT1W55m3avP3i2OTTJdHEg4ZYJoAaOe2S74GVdBnhkwHp1oFw1LG
         hh2AFKEriLHonlGa3MTgu/ysyCRSxILoJq5KTbl7HLwJEE9yuTsTKpCC2c/cq+CA/9MR
         Q+MNKI0i/WORa0meHdSx7Ik8HDgnpBeXm4ObcBzubbwhayH4SdIPf8fankOoc0eAp+NN
         C+yA==
X-Forwarded-Encrypted: i=1; AJvYcCVe7G9uzh10EPwN+Wvei9ay+cPAGgEfBNfrHX1sd1kHnqj6Ullieyn9QYk2s/+m7yoLUHJb15AkNpAH54M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8DjLhToK5my0SU0E4/pwwwrohvUtzcmyt1e7QNEwaC1YMK5/d
	z6+wdSOi/8HIkCBrcMUg/o80RuYPQxk4XomACWGKQVyMzIitwWrJ08RjI2pntelmQ1lCoXlIy9l
	T81GXFxbi
X-Gm-Gg: ASbGncu350ZJOvd1iu2Pep6VhH8m5NB2YQn6cp/0uKFzX/M4sc4m2Xg3aYtP9my8DU7
	e0XV4Z1b5eb3jugmMe6xWu40s3XbGA8s6kw/nbjtj8coFmf+eIeeXCzKGP/Va0DAfaSSJFSiWLi
	IWk6YdNQwjjl1j7zcvQ2lo2YkoZqnYEjDGGg3UrSJNAheH7q8fA0kiZ2RnjY2Nw3g5Bzi9TLBOb
	AK/ulPa7FvI8siVhIvB4LPR2be1rwYIkmP+y2utUB34unZLDRKBDDRk5kGZdyhqtJ4HHMYv/yq7
	BMfFfZTqiVmJn1SCuOIGuN3iQwsm3KQUQElPHmmXPOZmUaeyTaOennpoGZBGLmYHA2wk01rJrub
	A0c+i1uHVnbSlPjuJZV6a5PCQWwsdimkITueXPVaObhtyJtmhTslrYvBn9xLr1TeqqpZpg90aRp
	At/smrX1ucTha1i9yOpNHP5Z0jjCLN
X-Google-Smtp-Source: AGHT+IHp8qUEbZiZFjcq8gL768jxh7/txPc1OJzdAQ1KXrMavPh6zmcAuzYCqI5NGEMHZ2sFOcmEXw==
X-Received: by 2002:a05:6512:a90:b0:55f:6759:a792 with SMTP id 2adb3069b0e04-5906d8ed836mr5438343e87.34.1760364900643;
        Mon, 13 Oct 2025 07:15:00 -0700 (PDT)
Received: from ribalda.c.googlers.com (56.213.88.34.bc.googleusercontent.com. [34.88.213.56])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e4e58sm4165256e87.25.2025.10.13.07.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:15:00 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 13 Oct 2025 14:14:59 +0000
Subject: [PATCH 19/32] media: rj54n1cb0c: Use %pe format specifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-ptr_err-v1-19-2c5efbd82952@chromium.org>
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
./i2c/rj54n1cb0c.c:1361:4-11: WARNING: Consider using %pe to print PTR_ERR()
./i2c/rj54n1cb0c.c:1370:4-11: WARNING: Consider using %pe to print PTR_ERR()

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/rj54n1cb0c.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/rj54n1cb0c.c b/drivers/media/i2c/rj54n1cb0c.c
index 6dfc912168510fb1bd308f834911f9de705844b7..e95342d706c39a853e8c18de1ce447a5fa508565 100644
--- a/drivers/media/i2c/rj54n1cb0c.c
+++ b/drivers/media/i2c/rj54n1cb0c.c
@@ -1357,8 +1357,8 @@ static int rj54n1_probe(struct i2c_client *client)
 	rj54n1->pwup_gpio = gpiod_get_optional(&client->dev, "powerup",
 					       GPIOD_OUT_LOW);
 	if (IS_ERR(rj54n1->pwup_gpio)) {
-		dev_info(&client->dev, "Unable to get GPIO \"powerup\": %ld\n",
-			 PTR_ERR(rj54n1->pwup_gpio));
+		dev_info(&client->dev, "Unable to get GPIO \"powerup\": %pe\n",
+			 rj54n1->pwup_gpio);
 		ret = PTR_ERR(rj54n1->pwup_gpio);
 		goto err_clk_put;
 	}
@@ -1366,8 +1366,8 @@ static int rj54n1_probe(struct i2c_client *client)
 	rj54n1->enable_gpio = gpiod_get_optional(&client->dev, "enable",
 						 GPIOD_OUT_LOW);
 	if (IS_ERR(rj54n1->enable_gpio)) {
-		dev_info(&client->dev, "Unable to get GPIO \"enable\": %ld\n",
-			 PTR_ERR(rj54n1->enable_gpio));
+		dev_info(&client->dev, "Unable to get GPIO \"enable\": %pe\n",
+			 rj54n1->enable_gpio);
 		ret = PTR_ERR(rj54n1->enable_gpio);
 		goto err_gpio_put;
 	}

-- 
2.51.0.760.g7b8bcc2412-goog


