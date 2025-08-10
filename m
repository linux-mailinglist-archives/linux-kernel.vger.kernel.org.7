Return-Path: <linux-kernel+bounces-761631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D61B1FCCD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B5A87A68C8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 22:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FC51EB9FA;
	Sun, 10 Aug 2025 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YLCOyhnN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21468C120
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754865968; cv=none; b=jf/y4P6uT9c/Cvh7Spv+de5HrJnIO1dT8FaTEnWeDGgNVjPDXkvsUMbh3VBv9F2t/7rjKcHOxQyadAdlO6aWhMvpKKI5kvwY27KE3Iz36I56THIQCCmgZVfKxvdiLJt6h8mBHtviRTOpKrarUkF1h9OL1aF4gy/TYZLkcxTVL6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754865968; c=relaxed/simple;
	bh=a0rSL2H1S/HUaruR4lcZ7Ks+0rkYUs1GnZzD7mNCe3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=barHdatJIQ/dOqE/728whdnQ2yBZF82KLmrZwBhGbfCg8NSkAQmRPUYbE98A7yZIVnDEktkBOf36wsRIXO5ESGVoaDrBeroa+DPgo1sItNjiW3qNBxETEizoAQD2lJjBDS0VV00v8lKK/M+DRCF+XIr98RobOMu2iqnrbyLxoDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YLCOyhnN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754865964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vnGrlNLU39XteVbV9vgE2Sk+xvdwKQpHrkhTkr/Vktc=;
	b=YLCOyhnNu8Lo2cheCKTiEY7w5DLJoJtVg5qqFckzh1v7FkwX/feV69fZiqP4KBKJKkqRNr
	DDak+J/bfcW4LysrGrSfhVHoHehzGaShW0X3cvmExmxn4UpIGXkcGUfpTzH42vHca2zgPX
	i4mqEQ7d7KZ/Igpmgc3EofTSNUGuPTI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-CkqNjckiPS2hv_mL0SNcGQ-1; Sun, 10 Aug 2025 18:46:02 -0400
X-MC-Unique: CkqNjckiPS2hv_mL0SNcGQ-1
X-Mimecast-MFC-AGG-ID: CkqNjckiPS2hv_mL0SNcGQ_1754865962
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b085852fb8so157974411cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 15:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754865962; x=1755470762;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnGrlNLU39XteVbV9vgE2Sk+xvdwKQpHrkhTkr/Vktc=;
        b=DsVPOWbNzn9N6n/TxHO2A8vGgsnlPmwofYAHhC0icV2DBaIR1tWej9OISdIPXl8VCf
         sXTCb0s3ilcHUm+Z2BMFQnIrVE+Cb5t1vCFWUNq5j2IJyKudZx0hhA9numlQoEQFHcRq
         3NuUehPJFHQM3FvAOzZk5Fp6NK/GldIgLPwOgfd0KMcMGa/OOBr3hU+pKzIK5GbUjOUi
         lpV8h4DhhyDZYHhhD+X1Qc27TI7lV8bVefJf5i5Mp6fqHgoLfBEml2O9iz+tX5aERODq
         3bq3ne5McfG7XAI4FvSJsHrYlLicvIU+GaHAXKoAY7dwbN4BE5+54dLcD6ss3yuUgJsI
         hTUg==
X-Forwarded-Encrypted: i=1; AJvYcCWDM8x/nx11arAfGI+zg+UwvmYwFGJk3TniPUdBvGG6aAXMalR59+PRJdObF9i/gvRLtG9f3Na4q0dgkL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyHoJzKwfDiRmuDp4C7hWKc8GLcniU5Q2F28QpDqouAJuioDow
	Guh3LwLQ9NCz1GXqzQ7mqPs5eHJIvRT3y4fW0YQOgwwAdfkCXIbiS1YSPiJGXnQfKjp3rnRS1d4
	oO38thwRMD0mkBHjphm4k+Q3bYLavcOLWrM2ubLqdz0LnOGyKJcJTT32FlNy214GGRA==
X-Gm-Gg: ASbGncsGnS0PQUHuP+Dhgvut7ysDcc8VZr5WIZ+5ZJB0tvX7mahkS8y4Ss7d0/mTzBC
	LItC7NIRAyzpj5Sx7BZ6d4j7XbqkTCEXwqGOVOE/PhNRfCoMxOG+ewt2fEmDCzb0SSqksyAUBnw
	ISasgXLcZBb2TUh0PWIa83zxRSbRBXGViLcHRzVquj4Sx9oGm174rOrMHQc6haUjmsv9bPQyIAy
	g3undkc2vl+Oj9AbaiyeIBgZzIS5KKTHkgytDkRZ7N+7l/ZDutfpNBVbKFWWX7QwNgyvW0NICYm
	Am0+pUsKxdF3CGqXKZ8q5qvuoY3og+hikmMrRAA0W4amBns0wJ3v7eDwZ5iDTqu1oCNNWQHNCCH
	KeEORZQ==
X-Received: by 2002:a05:622a:1910:b0:4b0:77ae:17bb with SMTP id d75a77b69052e-4b0aed3134dmr164413221cf.14.1754865962215;
        Sun, 10 Aug 2025 15:46:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUie+6kdU1EHKp7zY7Gli2dqcxw3eGLN8zRdb828DF1xFrgrp8MAMR0KX4wPSSD6n4ZYgkPA==
X-Received: by 2002:a05:622a:1910:b0:4b0:77ae:17bb with SMTP id d75a77b69052e-4b0aed3134dmr164412901cf.14.1754865961731;
        Sun, 10 Aug 2025 15:46:01 -0700 (PDT)
Received: from [10.144.145.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0ad996459sm42685171cf.46.2025.08.10.15.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 15:46:00 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Sun, 10 Aug 2025 18:45:29 -0400
Subject: [PATCH v2 1/9] phy: freescale: phy-fsl-samsung-hdmi: convert from
 round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-phy-clk-round-rate-v2-1-9162470bb9f2@redhat.com>
References: <20250810-phy-clk-round-rate-v2-0-9162470bb9f2@redhat.com>
In-Reply-To: <20250810-phy-clk-round-rate-v2-0-9162470bb9f2@redhat.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754865940; l=1978;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=a0rSL2H1S/HUaruR4lcZ7Ks+0rkYUs1GnZzD7mNCe3M=;
 b=/U1k55v3iKOX6MHHG4y2eGAMFrca8JkeVtSpJcoc1Z54FeYml6kJU2G+QOt1KduqEhi06mYeN
 FwMvRbQ0c3QASmeUiY3XU6Pm6Wwj0gFLroBs3uKkqqGAWHVZhKteVKw
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

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
2.50.1


