Return-Path: <linux-kernel+bounces-850652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9A0BD3759
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2458C4F3242
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E93A3090FF;
	Mon, 13 Oct 2025 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SuAki+bU"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515F324A044
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364899; cv=none; b=nmtKjKxcgLHXPKpX7yuEPXPbBmyOgkOsmgJaJlNIZ8acq9IcFgqyzgGDP4/t3U6yfrCmHvHlMsplfmB4uvjnML5qNetHiPhnZV8H41L4wtPgCeiQt6xmU+VJxEQpO/o8anLz+arFcljaQaKuGQOrW4p9MO6v6s0W8zpBj6/Twn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364899; c=relaxed/simple;
	bh=LrtS/QWSh262AIfz0Rm9zWkyxkdrbmKWBb/AyfTa1hs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P8t53f2j7dIwUqUUh9U0xj+HqpkcidunvHnxN54KTbJdpVEI6LROmPgNA8ZuoP08bCmwJA9UL6Qp/XvrzeFTqq/4rx7W9wuXwq7lE3mPL5GXjRE/FbY3Qi5tIezkPDWun3lPXnyi3eR4nomFg9LCpkmmizByHG2qaoPmIbOF8Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SuAki+bU; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59066761388so5005444e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760364893; x=1760969693; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ytl5LFG4k2lvKI1fHaoSkPXZntuyxjUYygC+V2GNf2w=;
        b=SuAki+bU1+sqx91zjRb8n0EEi+aIjyMjLemVQFqsrIJpCHciqG21hNvV8WEtkcKM+o
         vHvQC2hJ540h5mhQpavdS0PHWmnynxTuPOf15tH8Y2KhQVesWzck+u5y+6Q4YKaQ6BiE
         zbeixceW/BlfyD6aRiAVkeWSPbm7E32Fw4zlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760364893; x=1760969693;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ytl5LFG4k2lvKI1fHaoSkPXZntuyxjUYygC+V2GNf2w=;
        b=qVLlDro4EevwPN7DvSPY1vcablvjkAYKeor/u7H0gxmvkZm4/OLVCNtcaJqfEwyx6t
         OFIeLlMdoAbVqMVbxeIAh7//BO7iGQrs+Q9nvXfbDC84iFJhvVHf9aMWoTRXPOvgnzgt
         BEI6A9y6ir3kLHHuPOOeWCGTu8N7nwnn1yoPzLE955zVDcah9Gtxwds6YuYuefrGccka
         w5irjMLn/CN7tDqlNWe3DgOLfDhcVI40ysfDhWN0zsgKLxzHH+i42bOZ5hcSyMPPWYv3
         6oNxk4bJmYKOgVIqfABzvqDuo909I0OyAN8EMqrtQp6yXmuPZPQNeknSTMoFiLBmVWah
         POtw==
X-Forwarded-Encrypted: i=1; AJvYcCWFP46eUzUgHHlTw8ZX8JRWUwmxLv6JBOSzy46Uyfv1jVHh8LBQH9QoocXGnveS7sMDAFB8XmUMmBAX/7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4/ZyH8GwX12OHF+dUqc5TjJjqlGDrTPlF/yYfa28vdYrZ/0Hr
	vehNWN0mdQG85x4PDpMj6XbqhsTl/kFJJGyvKWP5+9SaIC4h9ixYI2FEkB6flecZKQ==
X-Gm-Gg: ASbGnct9BGDqNfgQmlGP5ldAem6g7C43aMZw0GbRgPn+ecUlmwmGJEJOY02cUL0kUOf
	olys11tv9wBuTsOLs+3yvmL5izyuEPjrHEN8h/WhuBkyIo58ccLoEHnbLaayYMTdYnG/3mlf+9Z
	dXyYbrYU7DsO4TvzB1ClLeyg0nMGodkusdjCMyC9NFZ7aLiLKVZYkFwM6ddLdEFfbKGE9/soarX
	xT9IUcjQYpMpoonEL6bT8mNqclpq1Aod0T3z1iubjfxZqHhUFZPEwdlQCwPLThbrwu0X6dUzZOH
	hWQW7g7mjh6u3ugmariy8paPVcqb/OvUvYkE1ezRRZe1oHKacRNdIcGn30hPVXFE5K9083s7Fhj
	ku+rCWatFEIsEK8V++gj8ZiU8WcU2eWBuDS+GCU99gTZEH/DEX86QgLRJPs0GulZ1DvRY2IN9bw
	0HEVH4b7sKSlNMFQGJtAJcVSW1Ke3E
X-Google-Smtp-Source: AGHT+IGVVbL5/vtkpaQMJQh0k7ML+5P3f5T7fpLYmv9ZzC8x6SpLBLD8o5pL52MoM0M8VLfq2lDuFQ==
X-Received: by 2002:a05:6512:3d09:b0:571:75c8:43a5 with SMTP id 2adb3069b0e04-5905e1d36demr7120769e87.1.1760364892853;
        Mon, 13 Oct 2025 07:14:52 -0700 (PDT)
Received: from ribalda.c.googlers.com (56.213.88.34.bc.googleusercontent.com. [34.88.213.56])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e4e58sm4165256e87.25.2025.10.13.07.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:14:52 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 13 Oct 2025 14:14:45 +0000
Subject: [PATCH 05/32] media: ar0521: Use %pe format specifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-ptr_err-v1-5-2c5efbd82952@chromium.org>
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
./i2c/ar0521.c:1113:31-38: WARNING: Consider using %pe to print PTR_ERR()

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/ar0521.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ar0521.c b/drivers/media/i2c/ar0521.c
index 939bf590d4b2107c6669b83903028744de1c2b30..f156058500e3dce5d7b5b831bf8ec4056e49ad5b 100644
--- a/drivers/media/i2c/ar0521.c
+++ b/drivers/media/i2c/ar0521.c
@@ -1109,8 +1109,8 @@ static int ar0521_probe(struct i2c_client *client)
 						ar0521_supply_names[cnt]);
 
 		if (IS_ERR(supply)) {
-			dev_info(dev, "no %s regulator found: %li\n",
-				 ar0521_supply_names[cnt], PTR_ERR(supply));
+			dev_info(dev, "no %s regulator found: %pe\n",
+				 ar0521_supply_names[cnt], supply);
 			return PTR_ERR(supply);
 		}
 		sensor->supplies[cnt] = supply;

-- 
2.51.0.760.g7b8bcc2412-goog


