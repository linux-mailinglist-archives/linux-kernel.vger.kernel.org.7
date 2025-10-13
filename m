Return-Path: <linux-kernel+bounces-850649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E87BD364A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F913A42B1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B92A299A96;
	Mon, 13 Oct 2025 14:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cdr1hIq2"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7261B26C385
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364897; cv=none; b=GaTWYo0B3F2gNmCgQ+fvNlxKfvI+GGwPn0tPTk8aG2fIhquNa06iwvUv3tG6YhndLQcBbzj0aexM5IMIAgb0FRXJxdKM4rpVZabYgwU3DWRHyvmXXgZ4hXVy4E6a+EmG161IzKshuSw0ER7lV/2iLVRVOY/tIVdqG6G0baKzpjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364897; c=relaxed/simple;
	bh=XGq0AYT0RAu45DkehU73efZ+CKhGLsp22KsMW3sZ7KM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FBV7XkFigQNy3ZHBW/RdZA08ReA3JY1r58/eleLzqMeesuWJ4FsGsa6Z0eeKmcPLjO6hlq+wuSSnLZQAZY9MlEQHEuBsxSigpJgYDTNmJ6GIRP179kS61VpYtCAETovL46Jxgs8k5LvetG62SBFG8SpU6ISrgzt4iH/H0ewzShU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cdr1hIq2; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57a960fe78fso4808546e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760364892; x=1760969692; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cw6YFePVdJ/w0HUJNx+YTiAEhWK3QpB9xmEBqnhTSDQ=;
        b=cdr1hIq2jUiqlyHGLSraYFrMIEgscJ0C3ydDRuFlZqjZJ0QmjNxOHzRpUarGhnONZd
         T2dVSrsiuzxzW2E+F5lvJ/ymxtYRYlPh6mixBVDiXF8lG4jP6uStRtyY/LWNKWk8jApG
         wMspUiD0gImABlPWlgz6zQlaao1am/6ZcmJpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760364892; x=1760969692;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cw6YFePVdJ/w0HUJNx+YTiAEhWK3QpB9xmEBqnhTSDQ=;
        b=NXIc9waH9Q8rqkBoH9u1g90qE9HFdWYISYAQZVUEKXUq3SNGIE19E8Uj7PTkq4i4K2
         1o5ES17g9QxNC73tq/gIXO0MlKOvMjXIXp8Fp26MaNNt2M3miB5sw5LZlL1l6LGhRzct
         wF1Khbpi6Rb3dhPy1g+fJWCoHsck7UzBgKbRU9bk3YmZMCZHoOS08mYpNFGbMGIppZzM
         c+7EWFZp+EpgaI11rtKyoTnrX57JO8YWKLy7v2BDPOH36O4sQIO6HLPoim6f0XcPhjZ9
         EhGH1vf85BNlhiFRBwmWADG7m+VwT8L6pUVR0dQaatqRlqLEX/ujOa9s/CUvBzLhd/3h
         /ewg==
X-Forwarded-Encrypted: i=1; AJvYcCUgyMo88/HZ+JKMJIU14eL3zf61i4Qmuy0xx7MOT8v6AvhjyczjfhY4HLjMkKk8nk1vvd4SdC/akYoPL+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YysW8vEstNWhNRcboovUH1InYXw1VRNv+yYe3cDt4d02AaskNsA
	dUiHmTkkyvW8IqV9Yw8K3CQwGcDjY+Rl1+M6UJHphFWUO7yVaL0+SupRUGNNFbRDQg==
X-Gm-Gg: ASbGncvFRvqdSLZmXKMiN1Pgr89iCW3kp/yIAvLisFnY++KT071vhZq3INPGja+AJ0D
	++SW1HaNBZstDycFD6m44jtDXgADFivwF7CMiOu704797NWQlQ0IjxmNtPhYS9vB5pnjWFKsBX4
	oXbCs/FR54Q6Jdlh27k9SSzeffzS2k1MgwOMvy6umPK48Sx0CQsQ9YlSTlEfHUcHXODRo5EZh/d
	cjLzAEe0BWSdEOWJJ6rPi2kP5DKGsyTtDXHnhcQKOuaLz2nvrg95U2u2BwuNPrC7X3G0Bzd+o/7
	Ze+N9RBZ2WMwI7DUR3mNB1SnXFqY7rBkJNAyBGgP3NGltEGLsWRL0U0QyA8v+htvywGCr1S4nac
	UffCTRDeGD2g+65vCtXy3f01K+UJpaTSQSvbwbRSiJrqypE1scbtgCieUWlDcDXoVOwJ8vuw5vC
	g1FyMOQRvRQGjA2AJZig==
X-Google-Smtp-Source: AGHT+IEKVe60oXFEuaV/5sAfkl2vR8IvNhsEsPje9O6F0QVcXOQ4CmYWAzNOjArzbT4yXoFh7KUNeA==
X-Received: by 2002:a05:6512:2309:b0:57a:baaa:394 with SMTP id 2adb3069b0e04-5906dd51898mr4676162e87.27.1760364891849;
        Mon, 13 Oct 2025 07:14:51 -0700 (PDT)
Received: from ribalda.c.googlers.com (56.213.88.34.bc.googleusercontent.com. [34.88.213.56])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e4e58sm4165256e87.25.2025.10.13.07.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:14:51 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 13 Oct 2025 14:14:43 +0000
Subject: [PATCH 03/32] media: mn88443x: Use %pe format specifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-ptr_err-v1-3-2c5efbd82952@chromium.org>
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
omitting PTR_ERR()

This patch fixes this cocci report:
./dvb-frontends/mn88443x.c:698:3-10: WARNING: Consider using %pe to print PTR_ERR()
./dvb-frontends/mn88443x.c:713:3-10: WARNING: Consider using %pe to print PTR_ERR()

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/dvb-frontends/mn88443x.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/media/dvb-frontends/mn88443x.c b/drivers/media/dvb-frontends/mn88443x.c
index 7a58f53ab9996031e319711a21b1a8f1c13abed4..818c4e67364c7c6ec2bfc17f21e2cac360f6bfb3 100644
--- a/drivers/media/dvb-frontends/mn88443x.c
+++ b/drivers/media/dvb-frontends/mn88443x.c
@@ -694,8 +694,7 @@ static int mn88443x_probe(struct i2c_client *client)
 
 	chip->mclk = devm_clk_get(dev, "mclk");
 	if (IS_ERR(chip->mclk) && !conf) {
-		dev_err(dev, "Failed to request mclk: %ld\n",
-			PTR_ERR(chip->mclk));
+		dev_err(dev, "Failed to request mclk: %pe\n", chip->mclk);
 		return PTR_ERR(chip->mclk);
 	}
 
@@ -709,8 +708,8 @@ static int mn88443x_probe(struct i2c_client *client)
 	chip->reset_gpio = devm_gpiod_get_optional(dev, "reset",
 						   GPIOD_OUT_HIGH);
 	if (IS_ERR(chip->reset_gpio)) {
-		dev_err(dev, "Failed to request reset_gpio: %ld\n",
-			PTR_ERR(chip->reset_gpio));
+		dev_err(dev, "Failed to request reset_gpio: %pe\n",
+			chip->reset_gpio);
 		return PTR_ERR(chip->reset_gpio);
 	}
 

-- 
2.51.0.760.g7b8bcc2412-goog


