Return-Path: <linux-kernel+bounces-850677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D96DBD37CB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 288F13A66E3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5BC30CDA6;
	Mon, 13 Oct 2025 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Km69erHe"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8BC30AAB6
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364928; cv=none; b=N3TskMsmZ6AQOyui3z0iHIsueLntHr2RvRjR0H2NLwOcyqV3oRKn+MO6x5vWA2+YXIK/mtRqN4ABomdbSk2E+Wy5tAEVepzivjOQpXeUbnAhQheo2u2xe3EZ6ykrh9/TOYW0Cz70JznYDt5jpmn34trr2nVaqq/Vk3nbUdcvxX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364928; c=relaxed/simple;
	bh=GaYybwTc4NMu8YoQTyNOoa9jWFCzwJu0zC9otJ25O90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ujuK+irwVm4NSvpi+ESCtExi6j0+Kggmy3rZwq6Gl8U0/IMi4XonX+ZQoAlA52ChZdYsHILzmOS/9T943LbGTNIR1MYXgMXH9n2ZR1ZcDrtRUWwYooTglR9xBunRiZirBrmlWOF2V43U9OJg6i+eKUmMps/Kn03yxz4GneozsO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Km69erHe; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57bd04f2e84so4681999e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760364908; x=1760969708; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVsYamtIjQUiQyb/41UVrEZvV/AHr8CKvvGfsgypkrk=;
        b=Km69erHeXAoPWuNxrlssNsRB1gmru4/w/FFcXNri4xpB/pwAMm+H2/mYmbFWtned63
         KSwx+OgwhDg1op1JUNd3nyEQlFLYjqc9BsJ40Cb5Z5+yFWymCHElp1GjMdIhJCLnwp1k
         QiFLc7h1A0yxC2FjlFojyDAglIyDdXy+yv4nI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760364908; x=1760969708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVsYamtIjQUiQyb/41UVrEZvV/AHr8CKvvGfsgypkrk=;
        b=jTr8d/LcQkQDiQcHQ5EMQH/FpMLJwetqV+Bmb7eaLGgog0xaxSNSwa/iYieHG3/Icc
         Lzzceuu5/7/G+kxoJFeIedcHA0AApqhqk4Fz9qSBPI0iIROQxarKUAvBlvTqrTGWQ01v
         5MnZOBioBHGnLbsuqiS1dVTllsCGQrrEq3mL3hYIgLxwJIqqap4VWvuJccvklY89TGio
         S+wquRqe0rLAwjWlIShRMcx5Ba06j8bzeDH9cRTdaZqU3AU5+jcT1OK5LtoRTbeAVJ3x
         ETo3DZ2pu95vf7VMhErp7INVZXHRu7u4OjwJewmzrzqwpy7c62z6UUnJnh00cNaCvip8
         8qZg==
X-Forwarded-Encrypted: i=1; AJvYcCXJYtTXt64eT/x3kN+F5gQfyEZDwt3v88t0V8KRj3OtTRQlWtXPkrzowI72GypqzSMQLxva/4g2gaWMa8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVN2sIMyow7YdxCYNtj+1SuRQLEm2GZaZdYvvgwRLLGtvvfQ8z
	Nf5G+BZA4VT9viASfIXKpsmzZay4mHjFFmK2nH4s8ArjZkNFQi4HPt+M2rRN9lRcMQ==
X-Gm-Gg: ASbGncsVJg1/EqVBRiFizM+g8ER7mPJMM8SHQPV5r+bRy7WA6eic8b+WX0AN/ZcTvV9
	ShbP7qTz0OWrVdEB6KPmermmNnZ6g9I/yWF9sh/FhpZu4wROSyTDC0ZJnvkDGqvO+qEd/FCSpnt
	wtTFvtpFbyPzJ1UmvFfOLDyi4TlIxNXC8qTRJnJhDv7no+2E6qzyOAdLZHhJ6oL8XLUuCPIiqf8
	q3eh2FpiUJE2P9HgGGvNnUC1cDDsp41eHj9I6WMO+Ybnk9E0nJTrEthdPq6Jkq1MtLb98nYaQZp
	pZJt1GXxQRRDL/8tYAx02FdlKhy9vN9+7r1x6DUX9bVZhEToMmiGvrRzc4nEhio0eXENAohN3sA
	Ag2ZwsJNWos1Yt662ZXh3gNUJmco11wg6MS1HhMF0t3WsdoIposdZT5dDPev51CnBSi1K1v9imA
	WF4QCKO8SdSQpto2NxNGbl9K4j53m1
X-Google-Smtp-Source: AGHT+IHnTH3divp7fqt3s0C0bL0Y26kzFRRxIkA6dzGRmTI5xBy5IO/jgX2PIUsKvH8Kkie5THLlbg==
X-Received: by 2002:a05:6512:63d9:b0:590:9a11:9c23 with SMTP id 2adb3069b0e04-5909a119ec4mr1624042e87.55.1760364907731;
        Mon, 13 Oct 2025 07:15:07 -0700 (PDT)
Received: from ribalda.c.googlers.com (56.213.88.34.bc.googleusercontent.com. [34.88.213.56])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e4e58sm4165256e87.25.2025.10.13.07.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:15:07 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 13 Oct 2025 14:15:11 +0000
Subject: [PATCH 31/32] media: staging: ipu3-imgu: Use %pe format specifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-ptr_err-v1-31-2c5efbd82952@chromium.org>
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
./ipu3/ipu3.c:534:5-12: WARNING: Consider using %pe to print PTR_ERR()

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/ipu3/ipu3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/media/ipu3/ipu3.c b/drivers/staging/media/ipu3/ipu3.c
index e22a9c0921957ef2fbf7b8a11fab28e6d78c60eb..bdf5a457752b24bf35e38491d63fc1e059a1e058 100644
--- a/drivers/staging/media/ipu3/ipu3.c
+++ b/drivers/staging/media/ipu3/ipu3.c
@@ -530,8 +530,7 @@ static irqreturn_t imgu_isr_threaded(int irq, void *imgu_ptr)
 		if (IS_ERR(b)) {
 			if (PTR_ERR(b) != -EBUSY)	/* All done */
 				dev_err(&imgu->pci_dev->dev,
-					"failed to dequeue buffers (%ld)\n",
-					PTR_ERR(b));
+					"failed to dequeue buffers (%pe)\n", b);
 			break;
 		}
 

-- 
2.51.0.760.g7b8bcc2412-goog


