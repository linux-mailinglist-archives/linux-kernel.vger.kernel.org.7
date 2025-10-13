Return-Path: <linux-kernel+bounces-850675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3757BD37E6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CECF84F395E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5921E3081DF;
	Mon, 13 Oct 2025 14:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Obg8UI+A"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992EB2F9DB7
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364926; cv=none; b=ZVNmmBWj1y0WpLDWFcktmhFrAYh3ORsKcepF6lCjusRH3CsxFYZyj4pkTr+gLaSduhIE6ZE1FUWmLOY2bURXcmFBawYDp5rBtLPZPj87O2EqdB0JBsC1EqJCb5hK9Uq8Ej/okNow/5KmkYQe6JfTj8IN2BHyPp3Qbb7gLgKoW/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364926; c=relaxed/simple;
	bh=c9Kb2b0T3BLAmckMzo48k+Ue6UmlyuOLb1cyxCq4tlI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J1gUI71hMsAjo3UP7V3HFSYO+yHHO0MMGVxb+BVyAmZXFfMy5uMbwxLn4k80xPAkfvPd5QR3Mg+YuzCOylwQo6jSbD7jQRVbtRnB3rBflUO5/wpDIca6zdY4Egt+fo8qmw+jCMBgDDISdvrNcOyFNwGa65gDvqlhxrf9sBac7/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Obg8UI+A; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-586883eb9fbso5711825e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760364907; x=1760969707; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Smwvmk+cDkyGjYaS177QmxkSssvQt/cgmiOzwIecscI=;
        b=Obg8UI+AAndLMjNpmQNSR4pFxdQvBmATLrW0tjlJBW3Ga82UvE5E7Bd355kVGoaHO4
         ttMWfRew/peUsFe5SIcszYqZy+eR2HHN2crwjPNUufybpRdiTHm0Bwnbfh/KyzTHuQqV
         O8YBh5SXSt+L03mH/Ayyllpx3mbN6eJlqmJrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760364907; x=1760969707;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Smwvmk+cDkyGjYaS177QmxkSssvQt/cgmiOzwIecscI=;
        b=HFPyjljVsC9gAIZASKxXN2qX01IpsR2EFy8G2NGs5AwleOvyMkWPXWqvX6yvj+XLmX
         AhWEWHf3DO6p/0kxmfgu/A/Yn8YZ/HYptzahu28Jv6Lu26ccOKb4oS/QgDNjnm7JfR6Q
         cfUd0SIBE/pQ6zYim7lrTF8RzROsEI4glIMSRSsbbUD4kNgOmmVQgTysxaqVRyWpvoH4
         R4hPxu2r0hTGyEYswifvV/QwpEPsR3Qj1sRDHJOAF19dHxcZgFbO4uHFTVcViS+fHeXt
         EaXhXrVQIlx73ws5S3HGpTiBd7L8irvSwLsdLdQ3EZZxJQSkqJUTdexATW4e8MdpiPzQ
         bJbA==
X-Forwarded-Encrypted: i=1; AJvYcCVwKe2ZXL7Ww73yonq6rIQU+IhfY781iatmPSh44VubaFS4Umaj/JKGq/bc4d/QuzSuOt+IjG1x0rIxL0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxijqyHyCcZVOg08v/cCUMI9HUcCc0jmMiIDn571uOqhcblGLfo
	6qsBjuuIXcV5Pkt+3hnV4Q++ccNKSgmZotrHBXe5K9AVZzXles2GqZhbGpn+AsFq7g==
X-Gm-Gg: ASbGncupAT+OaKCd5OHkEQ81dG9qg7YMYvxUdQsf260jPYtmito2+vl6APX6aOSoOSw
	ZBCfCXp0J73udVtPTw1I0nwuhtEyXUSffgmK6BGRNzaEATaX7P8O8n5jtqJDrelrLglt2jqiCa/
	Xp9wn+OLjlLvBkETvhN5bEp9IblXbCHCyQZkG3/hf4HhCIfOMW2JLdCeIe9QvEGbL5dJOfJmEm/
	UYv5afe8fPRWZRNsRAPVW4zQx/YYoUYUB7TysOCfO7+rWEqNzMAR7w+Gh9HH70bXG0cZXdOTuvl
	O9s0vE7g2uNp/ePumLbaUY428t5XWe/4RYlILS5e8ycQ4NUHlQ2guvKnTECw7atkmZZFAMnEpE4
	ardi2X0nm9hOoQrlmDu2KFKHYhPeZ2SbvH8Tc6IpPuJfE/K62u9G4fKbZ18gZJpgSQ/LxWY/Ue6
	ONwYAoEyYEcupu3miq5Q==
X-Google-Smtp-Source: AGHT+IG0XyykaxSpAJZEJBiMkxB//rHuKsliNYYIqdi4qrxeJQYdIviCb9iwNXvzzJnUAUziWI3Chw==
X-Received: by 2002:a05:6512:ea9:b0:585:bc5e:237c with SMTP id 2adb3069b0e04-5906dafca4dmr5906081e87.49.1760364906745;
        Mon, 13 Oct 2025 07:15:06 -0700 (PDT)
Received: from ribalda.c.googlers.com (56.213.88.34.bc.googleusercontent.com. [34.88.213.56])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e4e58sm4165256e87.25.2025.10.13.07.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:15:06 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 13 Oct 2025 14:15:09 +0000
Subject: [PATCH 29/32] media: samsung: exynos4-is: Use %pe format specifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-ptr_err-v1-29-2c5efbd82952@chromium.org>
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
./platform/samsung/exynos4-is/media-dev.c:1337:16-23: WARNING: Consider using %pe to print PTR_ERR()

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/samsung/exynos4-is/media-dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/media-dev.c b/drivers/media/platform/samsung/exynos4-is/media-dev.c
index c781853586fd21996105c050e587bf8079cfc095..d6f7601de597e3d3517ef9195d728deb578e74f1 100644
--- a/drivers/media/platform/samsung/exynos4-is/media-dev.c
+++ b/drivers/media/platform/samsung/exynos4-is/media-dev.c
@@ -1333,8 +1333,8 @@ static int fimc_md_register_clk_provider(struct fimc_md *fmd)
 
 		cp->clks[i] = clk_register(NULL, &camclk->hw);
 		if (IS_ERR(cp->clks[i])) {
-			dev_err(dev, "failed to register clock: %s (%ld)\n",
-					init.name, PTR_ERR(cp->clks[i]));
+			dev_err(dev, "failed to register clock: %s (%pe)\n",
+				init.name, cp->clks[i]);
 			ret = PTR_ERR(cp->clks[i]);
 			goto err;
 		}

-- 
2.51.0.760.g7b8bcc2412-goog


