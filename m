Return-Path: <linux-kernel+bounces-726108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AF0B0083C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D5D188AF1F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2812F0C7B;
	Thu, 10 Jul 2025 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ewcv21is"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DD82F0C72
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163711; cv=none; b=ZePqJzKyM9Nty8RpUOeTBVxwT1hdmMEN5FYrRlUCbRkGaGcF6tuou+vTtgkVSXPeVBcT06xjYT84wnZ856y39G3yAjH2aJ2fQKVEw1pRmmkusnAcxbG02KCTa1wbX8RzB3rrrkHMLxXaGGDaOG/6Pc4ZMVN5MfxewgcoQujVnrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163711; c=relaxed/simple;
	bh=Sp7TBqvADBjUTdYv865HJDuwxPugQD7l6ebJ7mJAKsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O6eudW6ATaRbvPv+s7H5jHS/FCwzjJB0zy1rbzbsTcH+5Z3985II7SKSYOdq2h4EpSiW/D258mITCMOhzc+QDzWh4u+wwvSuHJkoPTDeqovJr0bTXMh+GhudSyZAe7s3+6XGdX/sPizJ37LRNzyeXAfNiWDP4E01pw//xeCwNOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ewcv21is; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752163709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4ASla69sSqfjU35JM1zsmkkZLK8k4ITigVacA38LgM=;
	b=Ewcv21iswEsH3CXmfCsaUmLTrP3ePttN9lngETRqLF3Ef/UskcP7iOvAuq5ydPoOdr/7I2
	8x3lYQQUX7kj8BpTC3cr36pdhPi2aiOGeByMcOQfAWyybpDcbtkbQaYY12nAXa+N7bjRqQ
	jLWI8HsElq617+HiCtVkIeboqkDYvYE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-6-dzoh_YOAag0dmHRZvDqw-1; Thu, 10 Jul 2025 12:08:21 -0400
X-MC-Unique: 6-dzoh_YOAag0dmHRZvDqw-1
X-Mimecast-MFC-AGG-ID: 6-dzoh_YOAag0dmHRZvDqw_1752163701
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d460764849so390302085a.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752163701; x=1752768501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4ASla69sSqfjU35JM1zsmkkZLK8k4ITigVacA38LgM=;
        b=szu7q7zii2QEj7h7vHeJzgnJ4SRDsLTgc7RUHHGJ/zEo5XX9mL6x4NV91951CXI7KJ
         GbeBgpHiKHH0hO/5/iJDTFW/FvJL+JsRSkJ2iSzSY2sJDhLzvxG58fr96GQoWEPhlVqM
         yQ7hNe6dh/qLJ8qpJteeGsiwlXtFi/nobD5hdvg6tOz9slkIDUbP1lNYlUC1fsf2ezEa
         hCWsH4NwEPmwMNtVOIzLWZNo0Y6DwGy5Tyt34rBShildSssRbF2sJgEICn3XkH9rbNJF
         fXWqqT9Bm7VrJ+P/8H0QtBwWDBmcCeTV5KFcpCPzlg9oLYFioFvRGzcNAhuintgNA6IY
         Y9SA==
X-Forwarded-Encrypted: i=1; AJvYcCUj2KFc63r5iVD+YDFaBGpu1FzC7iX1HZh0d9MUSTZxtkqjWoX/cfafrUPu56Wt/tn6gkjY/JYiW9mJfJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfcEXT3g6GB/kCuIXC+DXSRx3zHsUJNGopbWTIG5rmrEdHk6eL
	n+l0MWaHzH34y//gVkxO36WxNwPtIJoc328S8cTKbcdlPWG4/nAcmVCRfensWX1karxLn2f4MYD
	Bn5T1Twm7DLI5G2TxqVZl7LsEDF0VzDi2eg2ivWUxg6ZU2lE0C2jzdunwTRw51+EQbw==
X-Gm-Gg: ASbGncvbGpmzbolP4si8JUbly3W8t5iuFkYIaOzdCP5jDN8eI9jF7xWg90MdxuQjGrf
	/aFUIDkgdj60RrkDEsLuxArQ/2dThFQmNH2gdotGCqcNwT5lKjqxdY+rFXOoqSGpMprsTC9GUs1
	sjzO1+D105vTnnnK3e+tkAuAgzgO5IREt5CeQaC0PvNNzFRYuKQ16lLcNymuSjMlBA/85N8c0AX
	okSj75zcOW3Fne78ExDZDDTzXfPEwpioWw2KaIf9WoXGROPqy4ffEGzc71RdBfJmCvzuLloujGr
	zh6btlJ5wGeR6R158sSNPjPP/1YglgwaI6HEAB1jnmcApig7J63CXF3g1jU9
X-Received: by 2002:a05:6214:54c2:b0:704:9584:c370 with SMTP id 6a1803df08f44-70495a595bamr70247766d6.7.1752163701120;
        Thu, 10 Jul 2025 09:08:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDRrDKWwpckJ37fdbyhC+PMLfUgyhQZCTV67/zNoDsc5Ut1ZyXEkNXO6Agbo3M33HxjAj7/A==
X-Received: by 2002:a05:6214:54c2:b0:704:9584:c370 with SMTP id 6a1803df08f44-70495a595bamr70246876d6.7.1752163700571;
        Thu, 10 Jul 2025 09:08:20 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d39749sm9670216d6.58.2025.07.10.09.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:08:19 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 12:07:15 -0400
Subject: [PATCH 5/9] phy: mediatek: phy-mtk-mipi-dsi-mt8173: convert from
 round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-phy-clk-round-rate-v1-5-0ff274055e42@redhat.com>
References: <20250710-phy-clk-round-rate-v1-0-0ff274055e42@redhat.com>
In-Reply-To: <20250710-phy-clk-round-rate-v1-0-0ff274055e42@redhat.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, Maxime Ripard <mripard@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752163685; l=1519;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=Sp7TBqvADBjUTdYv865HJDuwxPugQD7l6ebJ7mJAKsk=;
 b=QdRXZy3WXcCDAKY+nITPfzBZtQ8RpvdKNlvOltT6ZNVcwHEAkVhWAcnk2UBWK7KubiIjAaW2b
 RaP8yKzs4UnCzedb/XCmTGOR6M6qboXHNuqR38QkPjLse9NBJ4Rx33V
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c
index 673cb0f08959e0e4f2b1ade2ebaf796e8b76f8bc..438ff3605d90121b7bfe02b3ddca8194437ed9ba 100644
--- a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c
@@ -237,16 +237,18 @@ static void mtk_mipi_tx_pll_unprepare(struct clk_hw *hw)
 	mtk_phy_clear_bits(base + MIPITX_DSI_PLL_CON0, RG_DSI_MPPLL_DIV_MSK);
 }
 
-static long mtk_mipi_tx_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-				       unsigned long *prate)
+static int mtk_mipi_tx_pll_determine_rate(struct clk_hw *hw,
+					  struct clk_rate_request *req)
 {
-	return clamp_val(rate, 50000000, 1250000000);
+	req->rate = clamp_val(req->rate, 50000000, 1250000000);
+
+	return 0;
 }
 
 static const struct clk_ops mtk_mipi_tx_pll_ops = {
 	.prepare = mtk_mipi_tx_pll_prepare,
 	.unprepare = mtk_mipi_tx_pll_unprepare,
-	.round_rate = mtk_mipi_tx_pll_round_rate,
+	.determine_rate = mtk_mipi_tx_pll_determine_rate,
 	.set_rate = mtk_mipi_tx_pll_set_rate,
 	.recalc_rate = mtk_mipi_tx_pll_recalc_rate,
 };

-- 
2.50.0


