Return-Path: <linux-kernel+bounces-850662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C92BD37C8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 608B14F5AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808A530C619;
	Mon, 13 Oct 2025 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ab6j/PZC"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4AD308F1D
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364911; cv=none; b=gmTskZl7xxgM8OtaZORDmcW5W0UXCaFEVEgQcTnB4Nbzo6gGHUUgSpGij2KE+TLtTbFgFV8U98MhCnhL3tL0m+Dk+N/RZc6ubvpUDOitn8m8IjHiL3neBoEbo9eSnqmDEPF0NPVigz2HOdYwRZ7yhK93uhbIUOiln1Sn6FT8iSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364911; c=relaxed/simple;
	bh=nBAqAoz5fuJ6xQXtbwYZsAnoOFC+ZH9eAjSHPSKxyx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WzMDBgF0jjaXGQYig7AVhkJfSs25x7VG5BGnUyKkq9gdIdaE70xJdiL02ObnDieGGSE85I6NS19CIF9Hbxmubg3mLZpnexMiRZ96ibFXMFxeoQPZ4HKYsyfnwg1sbgMkkpfJMH5+varcu5lZYc1l2FO3qoybkLfn4dBjAvJHs2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ab6j/PZC; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57d8ff3944dso4608817e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760364900; x=1760969700; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWalVF0nnSBnNQ4jdDd+P85V6zyjZ9PX8Y+NqBliTWQ=;
        b=ab6j/PZCEZRQoZ+SfvDUsC4WrKz+6HQ+bkqjamVf74uQ+VytlVxom1T1xTuFaN+6mW
         7dHoCSH7YG3nJ4dqstQH8mghCi7UiUQmmBk9juCC7X2jDonpt1b5KasdxEWWX8YfbSB8
         fJM9PF6xMnub/BTW3VcVFebI1ybLhwK/beBvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760364900; x=1760969700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWalVF0nnSBnNQ4jdDd+P85V6zyjZ9PX8Y+NqBliTWQ=;
        b=k/xqleEOICvina0wR1H+r+AhJ/tqqm+ZdpCewufWujFme7tO4yU456WesKbbtVQsMd
         rcuMlqT5SHst3/W6EOSJJndGY8TaysdFBSLBEr/dEKXb98myinwewjKU6gOu85gJvFEt
         b7uzxt0TKqma2x2selMPPd5R+jwIPE8FDn3cLtsmjvHWgysVUCN2a+MOQU/5HwfAKIoN
         PVtfrJFuFRgb2LZDnwfcWoEoKY9p7ZMz5jIcw7RaqGnoJ6TUa+kLX0RhF7zxBXcgop6X
         htRAgU926ZmCmksJvnrLPXBC9pLdiqgD/Xh6uC2leN4c3ecImqPQwQ7Yn3HFO92xfpVU
         AK2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVObSi1UA9YuVXEkpPGFdwicv/FTE0riDrIMbhL6Yk6vanO1b5uYduTQjSQEFEuA4ZcBopFAXoWLYReUtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLvvIYF5d3+TMGEVsa/ZfiEeAXZ8M9+0S+WGoNLF0cWaBPkGWs
	z21qHAFRMgVzf18WUcffXh3hE+rxUFEO89xUIfLlpLxF3/dy8JA9IiAmMaRwPFaTRA==
X-Gm-Gg: ASbGncsbKD2v/Wkx2ajMx5jh0cTq+tP07OlhsTWKdja6ImrUyCzCAmqLzJqllzv6HrB
	EFlCJxy7vaN/fHdaf1m143LlFM6yDG2RDOIQ0YkM57YXZKbOtO/ice3+VH4jcGZvRfEDLZ+7eRJ
	TsVDzF47utFsl8XdI47D92JV1EaviadxX8s0/nDHQ4M+gGOYAOHTx7hGxuhYkAFMEn4lDzNLJGt
	vP/Hc2kxo1AWuvDxi0Udq2jEvdQOfPC3/NReShdBc6OAqA3Dr637JZyYOxjQi/3We1QQKlLdcbT
	ZON6LsFTLsFLGQhNoJ4a7a3I24AP+9Kbw373m1ad0DW+wQdId34cBGgL3jGYOXoY4ARgvyTKjoP
	eUC76hBB5mXuRt4HkNWa170s9CHhhPDT0BzGaRenjqZNGVyFrbqY38BEwQLke/dx09G8MGLKCH+
	tsG/3qjurA7cUqVMKl4g==
X-Google-Smtp-Source: AGHT+IGPZ0GBnGH+/De00vLY51zTi7j6Ya9EGY1cvcSTJfIjXM0TP8WRpiQmjBMOUob4MSX3WpygTw==
X-Received: by 2002:a05:6512:a91:b0:58a:f865:d7a4 with SMTP id 2adb3069b0e04-5906d5da909mr5473662e87.0.1760364899579;
        Mon, 13 Oct 2025 07:14:59 -0700 (PDT)
Received: from ribalda.c.googlers.com (56.213.88.34.bc.googleusercontent.com. [34.88.213.56])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e4e58sm4165256e87.25.2025.10.13.07.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:14:59 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 13 Oct 2025 14:14:57 +0000
Subject: [PATCH 17/32] media: i2c: ov5693: Use %pe format specifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-ptr_err-v1-17-2c5efbd82952@chromium.org>
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
./i2c/ov5693.c:1296:9-16: WARNING: Consider using %pe to print PTR_ERR()

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/ov5693.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
index d294477f9dd30704d2e43a0ed3e222aff3af365f..4cc796bbee9263c032384d8327961b5cee52b9e7 100644
--- a/drivers/media/i2c/ov5693.c
+++ b/drivers/media/i2c/ov5693.c
@@ -1292,8 +1292,8 @@ static int ov5693_probe(struct i2c_client *client)
 	ov5693->xvclk = devm_v4l2_sensor_clk_get(&client->dev, "xvclk");
 	if (IS_ERR(ov5693->xvclk))
 		return dev_err_probe(&client->dev, PTR_ERR(ov5693->xvclk),
-				     "failed to get xvclk: %ld\n",
-				     PTR_ERR(ov5693->xvclk));
+				     "failed to get xvclk: %pe\n",
+				     ov5693->xvclk);
 
 	xvclk_rate = clk_get_rate(ov5693->xvclk);
 	if (xvclk_rate != OV5693_XVCLK_FREQ)

-- 
2.51.0.760.g7b8bcc2412-goog


