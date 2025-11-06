Return-Path: <linux-kernel+bounces-889521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41589C3DD40
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4BFA18868B9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A5F254855;
	Thu,  6 Nov 2025 23:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DmBJuQk8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LLAsugIZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA2533CEBB
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471600; cv=none; b=ZSCmzsqWumzJMBT9DH3yDGW9Em6NaUX4UQcpW+9HWjpBtTOgr/aLz0TQ+QYbpQHuV9dT2+ofuxthlelqT2ComAvOtWb2putzA4D2MT7XlWFpsdkhrAH5ctgSJhHnOOvN9wFeYQGbyvfkmY6tRMPZgRDY1AfhmL8H17S7BjZED5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471600; c=relaxed/simple;
	bh=tPB5NIPC9Tahtwhg+nx3O+ru7wuSB+giCQQ8ld+ZnPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CYiYHF+GXqjeQILONHRVL7T8nJvtmZ8N9TMjLpO67PJ2K2zwRqSz31fqpyzVpSD6f3G6uSHT9jTdvzVs5zcP8sdMwefYN7kFq0LkwyGCPUHo53Bmx1c+My+ybBO6Pxquhz2/vxYseefnl4z/EZ1DL+G6WQRHYXrYS5pyUqFrtC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DmBJuQk8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LLAsugIZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762471598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OIXhuN2h868r2lVLARvPty5kJy7WhDgZbJDR4n+1yHA=;
	b=DmBJuQk8XXh3rCQtpM7qeMXdBZaotgT0c+Jfvi1JskjKac7Qas0t16iLHizmCslNsemZ34
	YLgIVVUowzMWA6adjm5nNrncZgVQVx+E6ojjvsiEeK1oJwelX0g+myTJhV0fKIBJypO69e
	0HlwFs4wk8uPxSk4pq9Aixx7/fuRYHI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-GwDv10FvNQOpMmVODT6R4g-1; Thu, 06 Nov 2025 18:26:36 -0500
X-MC-Unique: GwDv10FvNQOpMmVODT6R4g-1
X-Mimecast-MFC-AGG-ID: GwDv10FvNQOpMmVODT6R4g_1762471596
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-880281dc4d9so5419016d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 15:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762471596; x=1763076396; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OIXhuN2h868r2lVLARvPty5kJy7WhDgZbJDR4n+1yHA=;
        b=LLAsugIZ5U6NlPGYm5+PaOx6v4LtD5y/PuN+RQFAO3hNTa61WpjvimE2I8K2GTmXF8
         kfFiIHTfHwXLh/QY+nbrxIdXAE1ezYCSOFounFNgpD9ibnsOLCmbp8pJEHWc+kMLH1Fe
         oStQTWuN+BXOPPo4fAKs8eSqPI7Gm/uw4UamvuHEn9Y3fked6Z6P5m04TNXTWObzyosZ
         GGNfUv9ergKBdh2RdqEbWB0FZX9ZYD4Pk5ycYNkQ0zKAAp4fv9fnmK88JhC0ewrSBhzq
         qFJtdbgst/uR70jZTrlgLu2BlEpyWSWcsWndT75G5ST7oWSMQcXaVNPnNFfH2YgKARF4
         pAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762471596; x=1763076396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OIXhuN2h868r2lVLARvPty5kJy7WhDgZbJDR4n+1yHA=;
        b=clrWJTIcr6vquQxRppkYYUPIy8GClgvEHsl2Zj+Ka2rEAF93hi/hkRS3ibCu5XjBXk
         xgu7ZvRFJe0SkVsdFmfBz1oVyIq203powQmXo7ReXoJCgEbytMJuHLMQGZabpEyx0tJs
         g2w/aVvKCh64yFWAuTw5ltTC+mvv1Yd6lAFZsE6W6myS+2KRqCo/pSxXfUCq6IBYi2Qm
         zgHuYtvrXPFrSUpvgHDMuZjzyFLeLBM3zbxMG50sPRVz92NT4JckoJHO23Bfx3ze/224
         h0BBjui5k1pLbv900VX+oKiwc09ARs3kYAe/4aoTTilaEffzf5dLflWkx+BWlTbaCbuk
         u45g==
X-Forwarded-Encrypted: i=1; AJvYcCVVB7dus3okHf8TSpYsaRf2/tJYNVbRYEFRRyfbHYNmQdu24YobEpamK2Mk+64dHWC6t1l5bI7QSE8dBEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4BghWbw4uvXClITiWQmpSceAFJh5FCz/8XdZB6wCTGUJ8Hfgu
	wegDp5skg9yse/kaWuQxDlYOdK8ekFt606/UZIEosICasvO3MosqaFykcsCEmkfvmJ8UqTgC/4t
	jkmf78AWvRWFPPHKBAibATyindl6ilL1UVtdM6bJQoldGtp8cBpC2zf6qao4Kw96S3w==
X-Gm-Gg: ASbGncuU3etyHTKyprnM9kx/RsPNO0d3bSsn1MKr73FgQ3icQ7ktBJ6XW2PVJNJLLEl
	H8caXiIEp/n7/lYTflUPIzC6pNyyz0w5Y3eGzsynCGFyxox6nkQTf23V3OUftASou2CEzcVnrly
	GRsovdEHtXkXaQU9LEbuq70qU5JkuKmlZ3TnXGuhL8xa/yVUNDPP+9/u7uKPmowfXswYY1HYbpf
	2zYSZQtGB9suzLy1LjJcm4Nx+YRAiCtJQUu4USu35N8bNuUW3bi8WMFmhRaSapsRqPK6+hc30iT
	cVWEihd0OmcZ5rJL8sqG9Gfs11yOfn0jDtxOQ2IfhVLWVjxIj7fgGrOwJ/LnzYUoxFnJz7adcOb
	fqjCJNSs0hQz8wqWD2KYKVv9agospw9dp0zK7BhHAgw==
X-Received: by 2002:a05:6214:1c84:b0:880:5382:ff0a with SMTP id 6a1803df08f44-88167b1b487mr14732386d6.27.1762471596134;
        Thu, 06 Nov 2025 15:26:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwsDTQJb9qqBYb9v62fMP1IlTO5wvFmMfSLsEpd/QskmRbsWz9CRa2AbIiAewvIcXXmKGXjw==
X-Received: by 2002:a05:6214:1c84:b0:880:5382:ff0a with SMTP id 6a1803df08f44-88167b1b487mr14732096d6.27.1762471595757;
        Thu, 06 Nov 2025 15:26:35 -0800 (PST)
Received: from [10.197.115.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88082a3aa91sm27389196d6.56.2025.11.06.15.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 15:26:35 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 06 Nov 2025 18:25:47 -0500
Subject: [PATCH v2 RESEND 1/9] phy: freescale: phy-fsl-samsung-hdmi:
 convert from round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-phy-clk-route-rate-v2-resend-v1-1-e2058963bfb1@redhat.com>
References: <20251106-phy-clk-route-rate-v2-resend-v1-0-e2058963bfb1@redhat.com>
In-Reply-To: <20251106-phy-clk-route-rate-v2-resend-v1-0-e2058963bfb1@redhat.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, Stephen Boyd <sboyd@kernel.org>, 
 Maxime Ripard <mripard@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1978; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=tPB5NIPC9Tahtwhg+nx3O+ru7wuSB+giCQQ8ld+ZnPc=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDJ59RZ8qZ1y68Ds1+V38qKsPZ31ou/Hv9tT5Oq986XlN
 sMCmfTQjlIWBjEuBlkxRZYluUYFEamrbO/d0WSBmcPKBDKEgYtTACZir8XI8K3jqEHi251Sx7c/
 Yjraoi5f92KzyTYZ7+2Xkg/s6jMsmcHwP/jWullLg5MdIhTUAyNY/z+5IpspNzcipfx2v2sub7g
 DAwA=
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index 191c282246d96e3f6c5a8d17abe078892882bf44..d010fec15671d33cc363af79e9f1c3f26ecb3464 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -570,17 +570,20 @@ const struct phy_config *fsl_samsung_hdmi_phy_find_settings(struct fsl_samsung_h
 	return fract_div_phy;
 }
 
-static long fsl_samsung_hdmi_phy_clk_round_rate(struct clk_hw *hw,
-						unsigned long rate, unsigned long *parent_rate)
+static int fsl_samsung_hdmi_phy_clk_determine_rate(struct clk_hw *hw,
+						   struct clk_rate_request *req)
 {
 	struct fsl_samsung_hdmi_phy *phy = to_fsl_samsung_hdmi_phy(hw);
-	const struct phy_config *target_settings = fsl_samsung_hdmi_phy_find_settings(phy, rate);
+	const struct phy_config *target_settings = fsl_samsung_hdmi_phy_find_settings(phy,
+										      req->rate);
 
 	if (target_settings == NULL)
 		return -EINVAL;
 
 	dev_dbg(phy->dev, "round_rate, closest rate = %u\n", target_settings->pixclk);
-	return target_settings->pixclk;
+	req->rate = target_settings->pixclk;
+
+	return 0;
 }
 
 static int fsl_samsung_hdmi_phy_clk_set_rate(struct clk_hw *hw,
@@ -599,7 +602,7 @@ static int fsl_samsung_hdmi_phy_clk_set_rate(struct clk_hw *hw,
 
 static const struct clk_ops phy_clk_ops = {
 	.recalc_rate = phy_clk_recalc_rate,
-	.round_rate = fsl_samsung_hdmi_phy_clk_round_rate,
+	.determine_rate = fsl_samsung_hdmi_phy_clk_determine_rate,
 	.set_rate = fsl_samsung_hdmi_phy_clk_set_rate,
 };
 

-- 
2.51.0


