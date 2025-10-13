Return-Path: <linux-kernel+bounces-850659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C02BD37AD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D865A3A26CC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65323305E31;
	Mon, 13 Oct 2025 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JJ7VrwwD"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633D72F5A37
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364911; cv=none; b=lXi9hc7GhCJtRUXS4MZ5UT3lOmfwMSX0wHggS37BfxD1js7IyII7soVSF01nXxfD0HjlqD17F8my7aub6ik9q4CcsTmd3OGj/uNndKvLwPDaxroA5wjWriF+bIzBAvtQuuG9/waMqiNJfbQQkW5YWLm2BkCMpIk3XyyEjxKIFYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364911; c=relaxed/simple;
	bh=UX1suooorPOW+0wpmL90mAmcoe3Uhg6r2V2q7D2u2Ug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Km698towPEAmgbUq2US6xBALJTVPdWh8UItim9bUyXhvkRf/YjPOfUVElzKtRfVUv5Dw2tpIiL19it+tWo4dZXSmKqkktGiSRpX1QyKxGCCvEYdM5Ro1Dg1PymmrNnHeTCsUYWn+CVg+c3CCcbPaGfxzRxnKwdFSVj0jjtLFoy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JJ7VrwwD; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-578ecc56235so3649569e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760364895; x=1760969695; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtOz2kIfaFHaB3b4Ap3srNj5aje/vDsBh7jaOB3MjlI=;
        b=JJ7VrwwD0xTj5oFHoPrYY1A6v8ph2F7pkOAIjLne/o0gGf6LpMjHxnpC6GQMLZtrZs
         rSlaHRE/pnFPbGOxJNlu2dHCbhHvdUi8FjenhMmQUnTskhDtVHHeqgHHNdzpEiAvItoG
         cffa5rRzoeHwetqgNvQlPKt9KtD6gFapQkizk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760364895; x=1760969695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtOz2kIfaFHaB3b4Ap3srNj5aje/vDsBh7jaOB3MjlI=;
        b=r8V9gNe6VRdkQl9SMa1pKLknNbGhz/rNGT+gZh8lCw6qL89DXXCKFmIEgh7YS1u6/I
         u9UWDp1dVzbTagT5divoCmBfekab02ffB7l4d5cvwKKh+WefM1IYFylTI++29FpRTtqX
         WjZ6XeYgdAmNeiWJoh6tUv3FhKwKBAYZK1p3BUqPEUBU3NRS9Dtvj8FDa142Yxj2i3xJ
         YlbPVk8/rna06D4Nr404QW7ayITKE8VMe4Q+NXfYjyQpNJRuJLlADhrTkM5FdDTQ1qXL
         J7TF6e+4f1CwSV2UANYQCzas9uPyft/wFWd1ROgMWUUHLfnRM1A6rbi1RBHY5BvEttiD
         k7gw==
X-Forwarded-Encrypted: i=1; AJvYcCUUD/Us4s2xbfGRlsSNHHtBh5nYgHShqy+zZsNv39LrGqFThr16Vax4q+f2/s54qFJHVC86ekaIUpJm3+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDW5ulNO77FJLC4hkpvVCI3qz5EiRLzvgPsy629jSRrJ57mxuV
	E3pRvUm83q68+7TyhT4X1e4zzeTjEjRPYrymMRGM+frPIPfxyjePte0qtq1wwHih8g==
X-Gm-Gg: ASbGncs/+w5hkc4diy2BB5oLk0T69oNe3XedW4T3rQGlAMxYxr4nosdOpZwyRNRHAs5
	Yjy5O3Jf4v63U0D0P74niqeTuJ/EBgPDeKdXaHmKeKsbkquho1uoqtoRGwCE3xqI3vHP4JZTWNy
	3ClLLo7OdhBJi8aTfmYslsVBw/XmbmW4GIyaqDU5fgRMtBBPRmE5dvsftA3TMXuSJxdOl51JLb+
	XDtmm4YNPlG+rj9VjiLki53l7ucSo1uH/A8ArwdcsNYtw904K0WNSstksZEPVlYOkOCEp9jAYhJ
	1DSAc4MqxVB+Ot9nDBQbwj2guE7IwoIi4OGdxdOhnLdPgmEW+tOZ0MEUOMd+iNdAOvdyX97IIoZ
	zTtGTwO4mSGxpt8QbomA5PLp3LtFRO5uj3L/I9X07ksxVPh7lIWjqgoWr2Y6FSxZze9FGQrwmcT
	baoeGt4uk2oeMbimoifg==
X-Google-Smtp-Source: AGHT+IHgj8C7exDJvyPI6OyYwB6RVmsRdyW2/dMuvAdiNw0oCeaD3q0MVrstbMSTaMktl9t7RYe3uQ==
X-Received: by 2002:a05:6512:3caa:b0:586:8a68:9c4d with SMTP id 2adb3069b0e04-5906dafe47cmr6138791e87.52.1760364894546;
        Mon, 13 Oct 2025 07:14:54 -0700 (PDT)
Received: from ribalda.c.googlers.com (56.213.88.34.bc.googleusercontent.com. [34.88.213.56])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e4e58sm4165256e87.25.2025.10.13.07.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:14:54 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 13 Oct 2025 14:14:48 +0000
Subject: [PATCH 08/32] media: i2c: ds90ub953: Use %pe format specifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-ptr_err-v1-8-2c5efbd82952@chromium.org>
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
./i2c/ds90ub953.c:779:44-51: WARNING: Consider using %pe to print PTR_ERR()

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/ds90ub953.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ds90ub953.c b/drivers/media/i2c/ds90ub953.c
index e3fc9d66970a762d284955f14db48d7105b4b8c4..087bb4ea555977692c66387a43dab54c12134e60 100644
--- a/drivers/media/i2c/ds90ub953.c
+++ b/drivers/media/i2c/ds90ub953.c
@@ -776,7 +776,7 @@ static int ub953_v4l2_notifier_register(struct ub953_data *priv)
 	fwnode_handle_put(ep_fwnode);
 
 	if (IS_ERR(asd)) {
-		dev_err(dev, "Failed to add subdev: %ld", PTR_ERR(asd));
+		dev_err(dev, "Failed to add subdev: %pe", asd);
 		v4l2_async_nf_cleanup(&priv->notifier);
 		return PTR_ERR(asd);
 	}

-- 
2.51.0.760.g7b8bcc2412-goog


