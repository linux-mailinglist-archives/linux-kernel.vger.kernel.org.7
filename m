Return-Path: <linux-kernel+bounces-850651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C9BBD378F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32883C700A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B033081A9;
	Mon, 13 Oct 2025 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fxb7gTr9"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8F73016FC
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364901; cv=none; b=pFWovDUqaapxtoJLlMjdWDohOuUP0KAijM/oAAN+mMaJ+GJvwq/dHsOCH5UKxU61rDAe36TIA3/7wWBBABgTR86n09uOk8/bY1gd+rgny9FXXb/NbvkuNBJ8d9NFXyayyaP+vnjY6vaspsYQ6XoWU/zEC1CY2omJuYUN+qzlnvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364901; c=relaxed/simple;
	bh=pmGQL7z0+U5zmtLLLSlcQCPIG/Bd/l8NvjVo2rUdVUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zasmg6R8zJFbooacu9hdouFIaBd8xywgfyf4wAOz571+i2P+w0rR/yB9hWylVbIhQA9SLbHWxTta/reiU2o1l5s39F7bv67poJaGbDPZaLYdlnNcXj0ir8ja2atc6+9QZaWga07XBmUMOZq2SmPq+Xr3l0MG9d7TSfuNgaP15ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Fxb7gTr9; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-586883eb9fbso5711490e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760364895; x=1760969695; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d45bLyS6OUqH7RU6UEzRVYwiTiUKaQxVUhJVNzyYRQY=;
        b=Fxb7gTr991GUn7uo4xSbPt8iwdtilosl8pAeRTMnD9Lm278xC7w4wpPaQzXgJFzmbj
         EfLCigGgxPUX3e8NU537x38CTPgPQciVPwIJR6Koj24ByOoY/scL0Gw2+yAEWsnyKjPf
         GBZGSM+uqmIf2Cnh9Wk3lYrSpI8ylXSx3yDxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760364895; x=1760969695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d45bLyS6OUqH7RU6UEzRVYwiTiUKaQxVUhJVNzyYRQY=;
        b=HwFPCqCtrhImuTckwZw1PUjXJ9voEKYtcU5/CzFXdWfgLDE9+BY6u73IkLLOR8u6oG
         qU0UaLxEx8WlLtKFT2DHQRNS3tlqFcBAQh5/0ZJMi0jXbr2jrDT3a8abqoUusecRFxro
         Qb3EaCxme4u9iUES7T1Z0GVFjwsYIVXGTXknrGOzDCgyWYF+A07Pz5/CAlyARToH8bSn
         0Ca4u3Pe1z4xMIpP6BYLsw0EcSbQXKdoBQyBQzINGgDsMZ5ZzZEUF/Co2mwdJQgWLbFW
         o8xFS0BwPASZOxSibqem2SBLyAuraeDFC2MlCzzrAKsiUrQfdOJ2ymA88jjH3i/gAcfA
         COvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6E94uuUlbnj6Y/fmZWTc77NI3N8OtAGC2NgYlgVGKsNwmxzJAOUBYP3Zr6FHP1ne1m5Q/hxf42zCw6nM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5FUDdw+y+Jfi1xg12nsnSz9RqmCfuX1kaS0lgDtuXwpiPlC/s
	poSHFqVMKkoX935379NIZG7+NCtg8HMuqjlpfJ/Nuqgm+6IP5HOd3M8eVrbIcIaa1Q==
X-Gm-Gg: ASbGncs4+sLxTRQhB8qEydcgPPPAYFV77nhFKcAEoRge49VrSmETzhQcYQxeVsAmm+/
	pEIJYH8XnAcGliB+Y3yPW0ZcoGCt/SfZ+sKbl3SysEFKsYP2iVfYkdn1ZPR9/DkIGDr+OeyMh+c
	ZrIeME7Bf13QfO9n5jMKptRljpWP/sDvIFsrlBWvnDP4XF3ex20+V17IuxgZPAtY4Cbnr8SWDr9
	mAdGb8tqtI/Z+p543Kop7PIuByfxSGSrhApm2GpeWXUzuxAUuzu4R3lqa+kH6zW6I93NMFHj3Jx
	qxNPnO2e0PhrZpgfj6YPGt+CjZW4lXHtV5vm++eXzK3FegMDa7jFTh3cZo2ustBUBhB+YdSrg5R
	qCyx8RsafIOtwxT6QnLXXT59K7f4OyVzK9gEqrjzmbwmuG0W5yzU4JKKjhKJQceHl6LLIjRml6e
	YcMmZk+5SJyM4hoFh1obriVT2q/iZE
X-Google-Smtp-Source: AGHT+IHgHmnkM5LbjRZWE+rax/DE80YYaaKxmy85wL7to7vxyhdrC5Nac5EP5ziTh632ueTTsgzZbQ==
X-Received: by 2002:a05:6512:2388:b0:57a:6d7d:dd7b with SMTP id 2adb3069b0e04-5906d773bedmr6253929e87.8.1760364895143;
        Mon, 13 Oct 2025 07:14:55 -0700 (PDT)
Received: from ribalda.c.googlers.com (56.213.88.34.bc.googleusercontent.com. [34.88.213.56])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e4e58sm4165256e87.25.2025.10.13.07.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:14:54 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 13 Oct 2025 14:14:49 +0000
Subject: [PATCH 09/32] media: i2c: imx274: Use %pe format specifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-ptr_err-v1-9-2c5efbd82952@chromium.org>
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
./i2c/imx274.c:2038:32-39: WARNING: Consider using %pe to print PTR_ERR()

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/imx274.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/i2c/imx274.c b/drivers/media/i2c/imx274.c
index d86d08c29174584b26e109a7858542313219c19a..8ec78b60bea6d47d2088b8251b679224e0d34980 100644
--- a/drivers/media/i2c/imx274.c
+++ b/drivers/media/i2c/imx274.c
@@ -2034,8 +2034,7 @@ static int imx274_probe(struct i2c_client *client)
 	/* initialize regmap */
 	imx274->regmap = devm_regmap_init_i2c(client, &imx274_regmap_config);
 	if (IS_ERR(imx274->regmap)) {
-		dev_err(dev,
-			"regmap init failed: %ld\n", PTR_ERR(imx274->regmap));
+		dev_err(dev, "regmap init failed: %pe\n", imx274->regmap);
 		ret = -ENODEV;
 		goto err_regmap;
 	}

-- 
2.51.0.760.g7b8bcc2412-goog


