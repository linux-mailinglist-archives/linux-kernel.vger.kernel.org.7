Return-Path: <linux-kernel+bounces-889528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A02CC3DD79
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70AA6188AB05
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBA83502B3;
	Thu,  6 Nov 2025 23:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h8n3FkUF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/omTHUw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787163563C2
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471633; cv=none; b=TUA701UP2IW/NTxKS9NFnu3ynHMF9YM5TFAx4VfDsnXYjUExwx/yeCEzEP6I99uhZEguk9mvi9AcE4hYQ2U46rRxe9FbJkqHy2g1LAFszaL5X7x8U7LTo8fpTkfbePaP4Wyap9rykv9ArUaaAibZAlDRjBkroERkEF2ieeDs3Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471633; c=relaxed/simple;
	bh=B3cRh6p3LgoB2SM5XPxaNOqjVUw8A6Swuk8MPDVITuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=roasH0479GVTuEkQo44C0MbpLXEFSin5ZYk9Ub5gccknCCYi4kGmsW3YczVxRejNmaXV5LGtXcj9IGU0OMC6mJ6vurZ5/MGhVMzBr3UuPDjir0nTBHJ6pQa/w1pDgWBvI1hdglur9FcJ3rA6AIG/WOXCAYZvjhQ1voP5j0+ktQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h8n3FkUF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/omTHUw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762471630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bcn3zMZ53AoVHBM0SU+ff4cP6ID7GbGsImYTlghLRvo=;
	b=h8n3FkUF3e1fY3px3vl8CJDNgJaqo76vX+IqrZRz5PP651IdghP15jSTV2XZiu4l+hfvES
	sa08iGZqRnRqoQ6tguLUnzc0NRc4BlJ67KCi4yvClbKE4EyT9XGQ+2iqdmAGqFqopTQpCJ
	eB3tst3ZSnra5XNkd9KG3XV69kZYPlU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-lBBQVavzNGeepPXquS8yDg-1; Thu, 06 Nov 2025 18:27:07 -0500
X-MC-Unique: lBBQVavzNGeepPXquS8yDg-1
X-Mimecast-MFC-AGG-ID: lBBQVavzNGeepPXquS8yDg_1762471626
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ecf9548410so4917061cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 15:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762471626; x=1763076426; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bcn3zMZ53AoVHBM0SU+ff4cP6ID7GbGsImYTlghLRvo=;
        b=e/omTHUwU+CANw4p+YuwP9sp/dIxI0+fLm6lkvqNGDlgPjwoZ2I/doHvsdzZpMAf7b
         n9/Fp+uuVqHfKlrSluFlLsJ/vfUtRKDqN+Azi68LOxHaBAV2p42y7XmpnYCTx1+j+MJA
         oBRV6njikL7TGpCVc6et+CILyTMEV6IEEzbit2Kb0kAIcogDEc8yIquOvC9zRzy5hCxC
         eQXZ5oHU7XEdQ4NPvwgSH8O1PTbnvpsYlV3HJMEWQWvfZr2peSNq8OCMLryhJZ12KxH1
         lkNaNINOHReieIdetyMPhypyQEm7sn8BnhA/rOImmZyNSnGMRDOAsU6mo+EwY7eJCf/3
         35KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762471626; x=1763076426;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bcn3zMZ53AoVHBM0SU+ff4cP6ID7GbGsImYTlghLRvo=;
        b=nF/zrJNLJS6Lx04wBacJOqZhVS75W+vpZ3mblYk7GOOIyZB6SSPnBoKoENNL4EAfe8
         /8MR3xQX5pZ2WfgV+u7AL5jedA2rDSYTPJBPslVhxBTU8KiBxSsnreoHrLRgIhH8H3u5
         o+Flnb/9X6U6PTFg76KbaUoH5nNpFMT0eQ6Oy9RgXfIMvWTw8KsYjGZ5CkZOOpX8yaKr
         KsOQZAtPqfETmaGzbEKHaVGyKm2inFA5SSg16i+3mtYHgK3aT4iNGcGPswyDOw7qytTc
         usdmWZJVn6hi+ZB8wbekelXq/KBMIFpz2CBvB+Dcw6+2L+MKbwQrMIxvr+oKh69tFh1U
         /qPA==
X-Forwarded-Encrypted: i=1; AJvYcCXyf05kgjHSMETurtS7krQrnIe3a7QSTDuSJslT7qOOgat775yGcG7AjjZJkDxausb6fEtJNkFzEXOOe6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCgRCbFPAD7FQk4+cPnZgAwesBhOffyMgY4xlowD0CN+WZIHyR
	hdzb2GKX3qmfuSTcEjKptYjoyNvIt2MWnWOMrStJUQLRndk2am1aP145bn8O/fGPTQ+FCqmGayW
	l8XuG+9gn08ypQetVgY1w8U8bCHD4COHsBGahyKX3Mi0DCP2MsxTBTVgri1Z0h2Kc3Q==
X-Gm-Gg: ASbGnctBpKoMKQZbPi9FQXfptLAzFv/GrTzWuewJ5RuVW5RrmPX+dT5gMvoIuOAFAlC
	+rImaN/nM1KQR3kJiCDH1ozjT8geFUxR3Vq7EwjOHS6yqj1dgfI7G2wDcR/Fxo0EeMtcCjXKUqk
	zWxyHxeOFaIl9kG/dJHyrvwZ/1oPAy4XjhjaQkGLtWy0r9mwbUa8y4vCfmMN1RVmh806FX59fTZ
	srgSMD/XeasdCVSeF7DNqsgLemuaLfxk4mZsRgBS7tNG/xRT9gRBBIC+umKC+noyQ6f8is+/O9p
	4MAtdu3XsDrlvej23Coycl18i3xeBbYBB/4mpopmo2WXCETqa3jClJpavP5Nqz1v1HqZH3eyT+q
	EiZwII3kMybcgo1sfrBuCaCRjhdssiiqxDzXf4aH4PQ==
X-Received: by 2002:ad4:5e8c:0:b0:87c:fbf:108a with SMTP id 6a1803df08f44-88167afbb01mr19476766d6.10.1762471626530;
        Thu, 06 Nov 2025 15:27:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAKV5Z7B7KevWNhDrMQhaFFBe79yFfIMSER6+SS9G7GG9yGBlDbjxgm5e37vbwHrzd8zri1w==
X-Received: by 2002:ad4:5e8c:0:b0:87c:fbf:108a with SMTP id 6a1803df08f44-88167afbb01mr19476536d6.10.1762471626163;
        Thu, 06 Nov 2025 15:27:06 -0800 (PST)
Received: from [10.197.115.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88082a3aa91sm27389196d6.56.2025.11.06.15.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 15:27:04 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 06 Nov 2025 18:25:53 -0500
Subject: [PATCH v2 RESEND 7/9] phy: rockchip: phy-rockchip-inno-hdmi:
 convert from round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-phy-clk-route-rate-v2-resend-v1-7-e2058963bfb1@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3256; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=B3cRh6p3LgoB2SM5XPxaNOqjVUw8A6Swuk8MPDVITuM=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDJ59Raa525zMnJS/r9qwT+FG4FH7p/2ecBceX+1fMSF5
 feuhew/3VHKwiDGxSArpsiyJNeoICJ1le29O5osMHNYmUCGMHBxCsBEAv8xMjSUXVyxZ7uixJnX
 YgUTf0if+PYmbwaXxuFNHqoeua3y8fkM/2M+/Ld89F1Hxzyt1aThga0O43ShJKVrPI/Xnd1dkHL
 +EAMA
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c | 30 ++++++++++++++-------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
index 8dcc2bb777b5455d21a10f06c5ad842b2ddbc834..1483907413faa5ce1dc8614db05e6e929410404d 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
@@ -749,22 +749,23 @@ unsigned long inno_hdmi_phy_rk3228_clk_recalc_rate(struct clk_hw *hw,
 	return vco;
 }
 
-static long inno_hdmi_phy_rk3228_clk_round_rate(struct clk_hw *hw,
-						unsigned long rate,
-						unsigned long *parent_rate)
+static int inno_hdmi_phy_rk3228_clk_determine_rate(struct clk_hw *hw,
+						   struct clk_rate_request *req)
 {
 	const struct pre_pll_config *cfg = pre_pll_cfg_table;
 
-	rate = (rate / 1000) * 1000;
+	req->rate = (req->rate / 1000) * 1000;
 
 	for (; cfg->pixclock != 0; cfg++)
-		if (cfg->pixclock == rate && !cfg->fracdiv)
+		if (cfg->pixclock == req->rate && !cfg->fracdiv)
 			break;
 
 	if (cfg->pixclock == 0)
 		return -EINVAL;
 
-	return cfg->pixclock;
+	req->rate = cfg->pixclock;
+
+	return 0;
 }
 
 static int inno_hdmi_phy_rk3228_clk_set_rate(struct clk_hw *hw,
@@ -835,7 +836,7 @@ static const struct clk_ops inno_hdmi_phy_rk3228_clk_ops = {
 	.unprepare = inno_hdmi_phy_rk3228_clk_unprepare,
 	.is_prepared = inno_hdmi_phy_rk3228_clk_is_prepared,
 	.recalc_rate = inno_hdmi_phy_rk3228_clk_recalc_rate,
-	.round_rate = inno_hdmi_phy_rk3228_clk_round_rate,
+	.determine_rate = inno_hdmi_phy_rk3228_clk_determine_rate,
 	.set_rate = inno_hdmi_phy_rk3228_clk_set_rate,
 };
 
@@ -906,22 +907,23 @@ unsigned long inno_hdmi_phy_rk3328_clk_recalc_rate(struct clk_hw *hw,
 	return inno->pixclock;
 }
 
-static long inno_hdmi_phy_rk3328_clk_round_rate(struct clk_hw *hw,
-						unsigned long rate,
-						unsigned long *parent_rate)
+static int inno_hdmi_phy_rk3328_clk_determine_rate(struct clk_hw *hw,
+						   struct clk_rate_request *req)
 {
 	const struct pre_pll_config *cfg = pre_pll_cfg_table;
 
-	rate = (rate / 1000) * 1000;
+	req->rate = (req->rate / 1000) * 1000;
 
 	for (; cfg->pixclock != 0; cfg++)
-		if (cfg->pixclock == rate)
+		if (cfg->pixclock == req->rate)
 			break;
 
 	if (cfg->pixclock == 0)
 		return -EINVAL;
 
-	return cfg->pixclock;
+	req->rate = cfg->pixclock;
+
+	return 0;
 }
 
 static int inno_hdmi_phy_rk3328_clk_set_rate(struct clk_hw *hw,
@@ -989,7 +991,7 @@ static const struct clk_ops inno_hdmi_phy_rk3328_clk_ops = {
 	.unprepare = inno_hdmi_phy_rk3328_clk_unprepare,
 	.is_prepared = inno_hdmi_phy_rk3328_clk_is_prepared,
 	.recalc_rate = inno_hdmi_phy_rk3328_clk_recalc_rate,
-	.round_rate = inno_hdmi_phy_rk3328_clk_round_rate,
+	.determine_rate = inno_hdmi_phy_rk3328_clk_determine_rate,
 	.set_rate = inno_hdmi_phy_rk3328_clk_set_rate,
 };
 

-- 
2.51.0


