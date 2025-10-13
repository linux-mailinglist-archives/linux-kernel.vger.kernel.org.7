Return-Path: <linux-kernel+bounces-850676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE77BD37F2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5FAC4F2918
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618F9308F0B;
	Mon, 13 Oct 2025 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VUGcie5S"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C92A309F03
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364928; cv=none; b=Y6PAdH9jr4YzImShZfLjbrkUno5kEn9y8M+2d0EHfuJnDomwuB+YBkBS1oX3iPW2WFFYvYpg50IA0gmyEyMuM9Gs9ZSc3L5UimbWD5uQAXts1rTTmEEI6uXhWTw5TKFcnTCMuOoQSIbvbsovZVAHAdf5v51600b5Z4id9F8ZhSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364928; c=relaxed/simple;
	bh=5KNyjJbgRQNGFLo6ZpLtI2lNcxP1iC+T2TtMMI7Vg6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H3ALdyna6FKNBnOLm+CY+2ZFM90A0fUiHjiImrDZ/IR3WqoAtpto4bHbSRseEHou2s7ARFDhYGwlefN8Bpk60Qwu4vU0bl+TzDqkESADWHjljNkyr+3wFveuZun3k2bfQ76ugGEL7L+xuJesEPs1/TT1h4p8O2g9vij6kVCQL6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VUGcie5S; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-586883eb9fbso5711891e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760364908; x=1760969708; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LGG/+lvAfLoFYTFsHBbdKee0g975J4ynYIjn3miRvz8=;
        b=VUGcie5S1susvs9eOKhoLdi24WXIQZAs74cSlLLObj/4B0VDJ7J255jCsK/xzGZS78
         7y5FTc+nM1JS6L31w1D+yU4Uoa7NbxZyV+5ypjCnFK/CL5GdhWO+2O5RmFAep9xFciTn
         O8yUSJ0NtB2k6PrjDzwY1S5fXvWXqNrB8weac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760364908; x=1760969708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGG/+lvAfLoFYTFsHBbdKee0g975J4ynYIjn3miRvz8=;
        b=c6+RVGLcq/RYShSbat7tHCbWJqHTleurA9A+DahIHXw6xroVJD/dKAeSUnrOo69l9q
         EfIXsIIYAXaX0xvQoL6JUFNQ2IE9y63/IEetwL89EyZmiZ3nAe5LFUygutilLBRGYWn/
         KpyQbzQyAn9s24raeLqZjacsyIlaHJOA9ZfPOYLY9EMEihvYCyB/lh78LT2aY1NPxbrk
         zJqLvOLPE9jLvKfaPoZru83gJ9a2t5FHQ5vbVPbMBrov2gcmhcNLVR8I9yZGCHODwr7F
         K85jtxm+xFINk22kso5QJI6/HCAA6rY0kvFK/enp3YbvfvGvEFR3JrWoXN7gzZRYCUgg
         nxBA==
X-Forwarded-Encrypted: i=1; AJvYcCWuPf3iP8ohMDyBM2KXoO5Is5uW1f17ey6MCiWYegW0h/Yp8WNctzCtsrWDlZfL0zrfrcEyMHLpfyk6tyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW1z/zkvj085tMjwkdfdqxAKfuK/Qp286/7Mo0DkNjqNVlsRit
	hYRMgeXHp2m+xrrbUK3fHafZVLbWo5HAuJFd/V7Cqh+0DD1q+kkCqzArSnuvXfe/Ng==
X-Gm-Gg: ASbGncv6ItRRaRciSq5/zbHPtE2f1qYy60/OUBVQ+QRoGMKj+jPSe02cr06vsNUbpxj
	R+o4rQ+/bSydcE8D98q8/WGWfxgMzk1RapAho8z9slsrKvMWzAVIoTnUauY5mSXl1gYpeVTAWil
	lcMFc65Xi7ypHjsjD6NLoyxqj8/VB9OeJkR7RAEWeMARO5EXlWvMtNoD+8x1/FUTfsmW6byr/oJ
	iw1tunzg+XEIpE3Yus7ZiOiAAdrsD+iU5fhhQHibXz3TxGNmfDp/yI33XPzSYAJ5G6eTH8xKt8b
	YlUGWnpeMy9OCwCdlv4H4PqlE0w6M8v7fbOlQg1bEk3DPIICVcDZE8IYWTtsMPNAiSEGoT1AUmS
	YSbLix0tUmnE62h+4IrpM8BMZNsXS8fcNj9BOUFcZHC3x8pmxpCQ13+NQ9q4HFxj3YucZgkQ5Z2
	3TMYwXVaD4lnkTbQFzNMe1eqylFG3VyW8127iKENs=
X-Google-Smtp-Source: AGHT+IHonGCa8by4IRlUhFwqne0G+xChLaB77A4Elu7KHX/ytkwCKxhNDSfo6zsqaOoV+Q8fGGx9SA==
X-Received: by 2002:a05:6512:1093:b0:587:a4fa:1e50 with SMTP id 2adb3069b0e04-5906dae5b56mr5886844e87.41.1760364908274;
        Mon, 13 Oct 2025 07:15:08 -0700 (PDT)
Received: from ribalda.c.googlers.com (56.213.88.34.bc.googleusercontent.com. [34.88.213.56])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e4e58sm4165256e87.25.2025.10.13.07.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:15:07 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 13 Oct 2025 14:15:12 +0000
Subject: [PATCH 32/32] media: staging/ipu7: Use %pe format specifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-ptr_err-v1-32-2c5efbd82952@chromium.org>
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
./ipu7/ipu7-isys-csi-phy.c:311:23-30: WARNING: Consider using %pe to print PTR_ERR()
./ipu7/ipu7-isys-csi2.c:59:22-29: WARNING: Consider using %pe to print PTR_ERR()

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/ipu7/ipu7-isys-csi-phy.c | 4 ++--
 drivers/staging/media/ipu7/ipu7-isys-csi2.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/ipu7/ipu7-isys-csi-phy.c b/drivers/staging/media/ipu7/ipu7-isys-csi-phy.c
index b8c5db7ae3009e16264d7aaca6d4d237c1402ab7..2d57178835188a44b002b38712437cbd551751a5 100644
--- a/drivers/staging/media/ipu7/ipu7-isys-csi-phy.c
+++ b/drivers/staging/media/ipu7/ipu7-isys-csi-phy.c
@@ -307,8 +307,8 @@ static int ipu7_isys_csi_ctrl_dids_config(struct ipu7_isys_csi2 *csi2, u32 id)
 
 	pad = media_entity_remote_source_pad_unique(&csi2->asd.sd.entity);
 	if (IS_ERR(pad)) {
-		dev_warn(dev, "can't get remote source pad of %s (%ld)\n",
-			 csi2->asd.sd.name, PTR_ERR(pad));
+		dev_warn(dev, "can't get remote source pad of %s (%pe)\n",
+			 csi2->asd.sd.name, pad);
 		return PTR_ERR(pad);
 	}
 
diff --git a/drivers/staging/media/ipu7/ipu7-isys-csi2.c b/drivers/staging/media/ipu7/ipu7-isys-csi2.c
index 4023db4a6466dd57f0ac007847bdd74bcdf394f7..f34eabfe8a985f29fa48b4a8896a058fde2f2b2f 100644
--- a/drivers/staging/media/ipu7/ipu7-isys-csi2.c
+++ b/drivers/staging/media/ipu7/ipu7-isys-csi2.c
@@ -55,8 +55,8 @@ s64 ipu7_isys_csi2_get_link_freq(struct ipu7_isys_csi2 *csi2)
 	src_pad = media_entity_remote_source_pad_unique(&csi2->asd.sd.entity);
 	if (IS_ERR(src_pad)) {
 		dev_err(&csi2->isys->adev->auxdev.dev,
-			"can't get source pad of %s (%ld)\n",
-			csi2->asd.sd.name, PTR_ERR(src_pad));
+			"can't get source pad of %s (%pe)\n",
+			csi2->asd.sd.name, src_pad);
 		return PTR_ERR(src_pad);
 	}
 

-- 
2.51.0.760.g7b8bcc2412-goog


