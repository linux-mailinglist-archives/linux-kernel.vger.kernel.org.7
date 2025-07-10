Return-Path: <linux-kernel+bounces-726111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008A5B0084C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965F1583B97
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C852EFD9D;
	Thu, 10 Jul 2025 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bysuyFf5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F212EF9DB
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163727; cv=none; b=J202bxyNNAEXmHC9b5n2GHrkYaLDDxS6GeLLuRbYhi2SpnRl+sGncIWlC1twxny1pNcwcHZ/zHYLFlhhmyRc5zNWHzp6DGbmiOBBoDuk26cG0naLXAJuChZTMKPbaCYNSZHkA6VSFN4pS6zF4Co7H7NqCF2bI6h4sIbsYH7N6Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163727; c=relaxed/simple;
	bh=NHf2WrVpFvBK9rcSwwdfI+z+ewWwe162I0ZQpinGzTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pJarK0dOvPQ3CkDWR+5XF9YVJnXV+Ug9MO03+Qw7nVUpmdPRODyKQWOoUBypuI4sr2DBe4J+IOWKP53aVWrTlV1P9Em6l0FGgtmJELwLbpOutEhz/r/hcALnFL15a6kFZPXVU3OSp1U70hU+cUt6LsQ4QFqbf4a4+fyW8zhEdQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bysuyFf5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752163722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qNMz/xyi0Wuf6bpUroOTdzgXVTFsqzyhX4e3vihgsBg=;
	b=bysuyFf5FvlKsIZaPqeOkEEFsXg9BrptUqJSpNMMz3LDlL6KFDaL+jQhYJSEG+5xhalGBk
	/sqv3nV97HUOG5qwwJCDljGzvxWQytQ0hEqMmc1pL/eKw4Rp+NBI7M+hqXzZDSZHaWu9xk
	pCPbB1hlCNfxLAw2vaA1MtKx2WXFni8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-nHR5cR_CNr2K9IASAoMQkQ-1; Thu, 10 Jul 2025 12:08:29 -0400
X-MC-Unique: nHR5cR_CNr2K9IASAoMQkQ-1
X-Mimecast-MFC-AGG-ID: nHR5cR_CNr2K9IASAoMQkQ_1752163707
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4a9764b4dc9so20731871cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752163706; x=1752768506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNMz/xyi0Wuf6bpUroOTdzgXVTFsqzyhX4e3vihgsBg=;
        b=ETygILYfWvo+cnsPt8jtuwW58tLdudXFp24K8g7u6Avnh2wloJMdLqkCrjneyARngQ
         AurKjGVF79u/u/DK/zkCclCwJIHUaD+dTJzbTq/kgNdClc17ggnElkEq8Nzr3o6kGz1a
         a95eihmSYJCipm1m+wNaRvtCXUipnPKqbxiSqiQIUiLpxJxYBn7tRzRyuEAx4M0W4JCI
         Lv6+yugE/LEWu1qeO8qlu/f/wdWjnSZehsJLF8kkO6RR8GcpodrnnMutmpzA8q/t+PfW
         +s2SIXd4VT8xS4DzMF+1x3FnVrEQRbH2jCbpwCOxKsacDNa2Na4CUDZ/PuaZ8OEpiz7t
         /EeA==
X-Forwarded-Encrypted: i=1; AJvYcCXxrscquUaF6NUchbavk56ZG1KWyqnhh3Hylr519QswHUWNA5Xu0m3dJ6mn7WU4hNjozt/pWDIVOxapKG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/V3wA9OVQ8eovxg2qH4dByyttcZ+XNLtDfxqEih/feqe6ENLr
	avsaGKOmL6r4Lgqa4X5Rgmo4TPSGK52+0aSZROhenMVp05en7drT6pWjJYnWHbMgm1U3xRQDIAs
	Gnm/JufX77F16LoAHRKijRYTo1XdYQrXW8U+YITN9eZgAOgZNwuW98kRhuQlOOtU3Q32YxWDYYA
	==
X-Gm-Gg: ASbGncuOD5IkvCiziNMEr5Jrd/4rZV6vIj5QZMWM2t8DSMiE+ke4fWfp+FGcDFKo4cc
	bG6O2vjq+NLePmzdO/J0V82nK1oeV6c9YBjix+W0m4xs6xibrBuFQ+5yc9aAZcEANW3W57acRaw
	lHsyxB7cebVaFWcaZwTS03VrwZ/QVmRA/6QzbIWEM3qW1dBWDNJ/lprEecXmdKIbqphpl9u3Au0
	IM7c/O18naV7sKxn44Xn7xrbuf9tsJLbGNTW3nnstNodNQPol+z9tu5DXd92ENBrBgZ6Py1YFgh
	mlYLKT1cI9Fh+zbUtiILnkFo7AtsaPfw4L++ysrDFQWsHiLNbWPrBCXc9Yj7
X-Received: by 2002:ad4:5bce:0:b0:6fa:fea5:4da0 with SMTP id 6a1803df08f44-70498064944mr50151316d6.10.1752163706239;
        Thu, 10 Jul 2025 09:08:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYhZa76cHQRjJPw3H7mkaAzOvkiyujQRGMNOmHLyrMH7YSa97wvn3nU7BthDnNKd7pp0944g==
X-Received: by 2002:ad4:5bce:0:b0:6fa:fea5:4da0 with SMTP id 6a1803df08f44-70498064944mr50150786d6.10.1752163705661;
        Thu, 10 Jul 2025 09:08:25 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d39749sm9670216d6.58.2025.07.10.09.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:08:24 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 12:07:17 -0400
Subject: [PATCH 7/9] phy: rockchip: phy-rockchip-inno-hdmi: convert from
 round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-phy-clk-round-rate-v1-7-0ff274055e42@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752163685; l=3209;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=NHf2WrVpFvBK9rcSwwdfI+z+ewWwe162I0ZQpinGzTg=;
 b=iJFp8tAaWU+wHaHcUB7nA5t7RfDvvhf4kk9dD1nEljg5ScIgHcdVuYZrpCfyQ1GumV9HBW7D3
 o5sEUuXM1iaDquqPWph1RO6DawQwo5Fhz2pFk4nTpsSuuAzjb7NEMsz
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

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
2.50.0


