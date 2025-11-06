Return-Path: <linux-kernel+bounces-889526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B316C3DD61
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7B7ED348D9D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F74D355042;
	Thu,  6 Nov 2025 23:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3XXE7MD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZamTKbOW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80A035504F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471620; cv=none; b=Mp1yQ9qoAjJnnfgC58e88chUQA3WsqO/j//AylaPQfH9YDDYeXALehjjlDzLZtWh7Nql35fe2zxOCkN7L6XHfNeHUZHnY7wdY6WioQOQUMIAsCl9KfuoA8ceVViEQqYhzTvNVwl1/HDoT0O6uEBPM6e2TLADDwrj+zu7GAwEamY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471620; c=relaxed/simple;
	bh=0ONTyRyj5ognfzdcLi6VRYwQ6d+KVHGkkiYfjM3qIvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mew63LU3H9plHYg3WqqoTFN8sCIeLvel7PsNseE0plCGW8ZpzxPWcWcUAZJbnDbR+Qk4xQAyZ+2LuW6qCZAs++4BGV2ru0Qt9vKqh+W2dnYe0hnKzd/uFpySnpRWg0V0u0ay6UcK9RqR7HddItabNChO5/+fDmgwnPJHV2/3iRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U3XXE7MD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZamTKbOW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762471617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SQCfd8zWOp32cxaZRehJq3msamMDwqa56w9I/w/HjpQ=;
	b=U3XXE7MDZx9CDExms5RAyWGklKo8mxtTrXfDxvaafsFxeYV6PrIBBrcmyry0lKukphXGpZ
	NPLJZgP4AW3mtkCmPJZ6HXk7kdd4mOaRmCa7hwSi80OUn4D8pMunw1ja2Pth1dAQubTdD4
	YnXgqWR6UcPJtBKhZmXLirkePVRC8ok=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672--Dj_ps5KNTak5-kxotkxDg-1; Thu, 06 Nov 2025 18:26:56 -0500
X-MC-Unique: -Dj_ps5KNTak5-kxotkxDg-1
X-Mimecast-MFC-AGG-ID: -Dj_ps5KNTak5-kxotkxDg_1762471616
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8804b991a54so6419156d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 15:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762471616; x=1763076416; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQCfd8zWOp32cxaZRehJq3msamMDwqa56w9I/w/HjpQ=;
        b=ZamTKbOWh5YP2cECbXP80KdmxGgZpo3Bc2zbYbfGUL6VL05HjnfptMgPw9vp0HfUtR
         d2LkGcdCWNpjb428k3ZYUa100lAu1Ru/iCVqncR0YZKXjgexglnYsCYsuygwSq1qheD/
         p4EU3Gj7B0oIi1PW7aVSwYCrKqGLv6lHLpNIHsem1X6Pao4Qd+JElBJNy5ZA+AL0+DQX
         YqeY8+hDKkFeKcajNcGf0HNhvruWCPGZxZ/MKtPL7UUSaH74wB08wsTIkNeOdQpcIgXG
         8d5oYbHkAvlJjw/igH/4go62Y9Tgw8QTinVvpWKK02uhqoeILYmZjsB64bqXmt9yARM1
         GgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762471616; x=1763076416;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SQCfd8zWOp32cxaZRehJq3msamMDwqa56w9I/w/HjpQ=;
        b=fD/TVJdBrHkDve5Hn3BIECHB9aCwA6+RZ7uXLBWGB8g5Dg08kWraYHxj6qJ9juey3J
         MjnWOVvAv3agK/2EafkQR9NL1Peez86YLDuSlK34dbUzwwBtMblsZUo46dX970gnr4Lo
         P03o1Dmwr85GLrlnCQCsqrL5tazW8hZii6XxQDmogINZH6KGvffmkIb4BT2uUW4FYCj5
         rZLmR6muszqcUX8szHV+PG2/pRPbj1Y3S0l6f6hVaNOZT/FX1YM9rpkrebTiE0PyrnVM
         ZGTT/T+MXfA/tAPIDoPDtYlbbJIzjg2uKnuq/4GlwuTGl2ELTcmIGpVyNKweZeaxYQE2
         6JiA==
X-Forwarded-Encrypted: i=1; AJvYcCW5A65zr+r+cScHE7iQ7v2U1X19ma3J8hBvV2cWriIFMbdv8FmD2yYMtTJ1f5LMQZ90zjhhhPHCnw2LzDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsG09YitrzUtxkj45oqf84t6zyN8uy/R4fdRSqWnJpVY0m8CXb
	AzeybxTq6X/ttypzlSHYlQ/9aS6O1h7M1M09ZnvdT8qFTfw8FTOipvsC2AqXNSvCSji1aB5sUdk
	kjvg9bdVjWWyg6RP093Ca698jyTzN0lcZccFUcM4VoDw9DFQr1zG3jHkRvppoE42oiQ==
X-Gm-Gg: ASbGnctglq9GrYIdfGQtGN74FLsxWIFkDqEMJcWkjsvRgDK+82QdGFfdsHVCjvnst0/
	6P8rsQp7OgY7vrbOu/oHhzvQyYQ9+uPfuGfg4UiqNTrRgS3LlPCH7u/9ph/nKh5bQSH0dYEXSMy
	+uC300XlN0xUOxwMuV8sakUJ3WhHDWB4LtoxcVEu9navNXGuklYrZZ9PnSIWQFObOT8RQuCxLKs
	XSxIQVmFBi/7hKncv8/5vsetTxj0Jrd8ox3a+k38aQP5eteCWZ85+aB+xjPCHGSdUmX3tn3hKYW
	i0y4MFW2+VYn/7XjkeoKysdj6vQnsYnmeqJIq2M7xsnbzmDED0RAgVbsQQFk3Yj9rZwP7DR4v/P
	Yd4P1cd7Pa8+9kcycum0weh2ntBSK1NTboGoUeG/ioA==
X-Received: by 2002:ad4:5e87:0:b0:880:5a05:925f with SMTP id 6a1803df08f44-88167afd114mr17958126d6.13.1762471616004;
        Thu, 06 Nov 2025 15:26:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5Z5NCJiDJsbMHVlrtUlpGjakDqi2/fs01RriUHfEFSw/5HUZvbsIZYCzQ2U5thVfZ2fi0FQ==
X-Received: by 2002:ad4:5e87:0:b0:880:5a05:925f with SMTP id 6a1803df08f44-88167afd114mr17957826d6.13.1762471615658;
        Thu, 06 Nov 2025 15:26:55 -0800 (PST)
Received: from [10.197.115.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88082a3aa91sm27389196d6.56.2025.11.06.15.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 15:26:55 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 06 Nov 2025 18:25:51 -0500
Subject: [PATCH v2 RESEND 5/9] phy: mediatek: phy-mtk-mipi-dsi-mt8173:
 convert from round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-phy-clk-route-rate-v2-resend-v1-5-e2058963bfb1@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1519; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=0ONTyRyj5ognfzdcLi6VRYwQ6d+KVHGkkiYfjM3qIvg=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDJ59Rbkf3oWx/vTtHDr4ZNVHnvrgjPm/1vnKvxMrOSmb
 750m5RhRykLgxgXg6yYIsuSXKOCiNRVtvfuaLLAzGFlAhnCwMUpABNZ+pWRYV4nm13uT+GVUvvf
 X+i7YP3Pldvp2mr/m16xsrMLpB9/nsjIMFm0TLfkQZN196ctK6/pBDG+ze6XNL4ZuiJg7iIPl1U
 XuAA=
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

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
2.51.0


