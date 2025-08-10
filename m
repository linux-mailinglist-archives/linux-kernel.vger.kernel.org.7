Return-Path: <linux-kernel+bounces-761637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30994B1FCDA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29DBB1897B73
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 22:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760E41E25EF;
	Sun, 10 Aug 2025 22:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f04WMM+x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DF8EEDE
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754866018; cv=none; b=prjHPBeasdz0aVw64+UfXpHOgMNh54fBFQ7owboWytS86qzZrUGB9Zembjsa3j07f3uleXI9Opiczk2i+tndQoZMw4YWKqYx0rx4ErRl8cRSb0Mu38uePDqO5KHLRoUSy5wQU9OdNl+2Rs5bIpvrlhPXGrpwvVR5gJ77nOhB1y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754866018; c=relaxed/simple;
	bh=cKQDgyjW9ziRVEOEeZhANbLz60Yx7I/xu3+zURpXhB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uyzkYbkCozrQDR88IPHR089oxAn7R21ePjq3MsjzRqLsD9j2kdlnuFqSbW6+rPb1AVAZYV/yjng0ykG5Eor1kiXqZOBM7ENjmBrPoM8cetapKsioKLZ6jADjOuOpMUpajXMesbfHTPuCw8SJmIjillbNnO6qnrSGZMlgSZ00AWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f04WMM+x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754866016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNnDUdz3gK4q6slcX3XODNycmDK0nBwCY+DO25+Es8I=;
	b=f04WMM+xYpDpsrbEl2lQ03+ovETDsHkmyGrqRm/ItuCDwHCE0FXIAl4K9tpSdFZhX2X8aq
	O0QC4lkN7z6ZYhMGILx5EA+30S1DO5dOznYA0yw0cNKm6FT70ShykkUuOV4fA8ZuyJQPuH
	y0y2zWDOKISkeK1BXo4s2Bsp89dslnQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-EPivVa3KMvKZg3XvX7rsHw-1; Sun, 10 Aug 2025 18:46:54 -0400
X-MC-Unique: EPivVa3KMvKZg3XvX7rsHw-1
X-Mimecast-MFC-AGG-ID: EPivVa3KMvKZg3XvX7rsHw_1754866013
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b096d8fc3bso98115051cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 15:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754866013; x=1755470813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNnDUdz3gK4q6slcX3XODNycmDK0nBwCY+DO25+Es8I=;
        b=CNwYDn4jGqDiuoE1BuAHV+XSTcTjHpTgxOlgHW8ZpIBJ1OIiKNwhEW7V2Xj4fxR7Oh
         Ct4qOaNExQARWTLjBtDfDjOI0HNMp4mAcZRjdtd369nMPDECcXiMbwZIogx1PpNgARB/
         FUNOJxcVnWnEayGtIH9/bb6B1rMo4T1FIKALYnhiIfFr1r8mdUJpIJzo/5O9E1SnaDxD
         f5BrdHHgZmVHedOq/MwnrwFYln98oHtr+Pj4GKwu67Je/DuN1NeCsBlM8o71ckKdsQsA
         Y2ADJncquYqNjJ448ql+TUQ7Cv6pfaiWjDxiFp5TPSDzowYP1YSPIMBk4DeNgnFDijaT
         uZ8w==
X-Forwarded-Encrypted: i=1; AJvYcCWkWUhrzSUIERZAM4yzSegItm7SL849AjSNz5uKVmIzVaLpdZA0pITlx4zE8NuFYBd76PKrtVNJYocdY8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZhGwTFCmftT0pJW38NjKeQXf5a+b6SHn1H+d0CQWa8+78j0ua
	Ul5DBw8EZaZa5iVDnzl3VPfl60B7jUkIyRNWuzVJoAWzODuzH0C8T3eDhc5gXfmwe6IMkfvysRy
	JW+MuWmGlgXn8L6CnsOlOEFNWrbmb+4PTghuv4PFdvJLcCzk4ddYKtDvak1AvT/RoyQ==
X-Gm-Gg: ASbGncutWcstrpYdsbg4pBRTVK+PnT70J3PXfPIsywabI1Zv1aFq1ZjLl0zOL08W55Q
	gS5gRzZKC0zhRS+vVDk3Hv1VLYFzgxfMPlqehKJ43JfYlm2M1YnYVdz7oATVHE6Tja3gwsm4Vk4
	TFWVQdMi5uzGGtXF+hfEHKUVNYyJg2RQVWPguwZLIf9dXmSgf30YmgvtGV3pqqy6uqG8kQ8v8l+
	SCP9Spu8PSnjNHGbFnSDayD2h7ljEZLgUFB7ELYYFkA3y1ICPD/rPWsQg/VR+ZwOWw+TwB3XROr
	RThP7/xRzvRNLvDlVRcOnYfGH88fWN3z9iFgEVC88/63hBMijKuBLYifr8PONaLaEZ11MRCx0Sy
	su9K5UA==
X-Received: by 2002:a05:622a:4c06:b0:4b0:9c0c:f62c with SMTP id d75a77b69052e-4b0aedd616emr157202911cf.31.1754866013422;
        Sun, 10 Aug 2025 15:46:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzBkZptPsYAU3FTRK+ndIewqVNVtwKayuUxmee7QLaZcahzXf2pV/ZFq3ye47SvzpbuHnnjg==
X-Received: by 2002:a05:622a:4c06:b0:4b0:9c0c:f62c with SMTP id d75a77b69052e-4b0aedd616emr157202631cf.31.1754866013021;
        Sun, 10 Aug 2025 15:46:53 -0700 (PDT)
Received: from [10.144.145.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0ad996459sm42685171cf.46.2025.08.10.15.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 15:46:51 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Sun, 10 Aug 2025 18:45:35 -0400
Subject: [PATCH v2 7/9] phy: rockchip: phy-rockchip-inno-hdmi: convert from
 round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-phy-clk-round-rate-v2-7-9162470bb9f2@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754865940; l=3209;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=cKQDgyjW9ziRVEOEeZhANbLz60Yx7I/xu3+zURpXhB8=;
 b=ubxW3dDssQ9yAkb8tdXuvrTvn/pHg2yvGTU+fNLDZ2kHxtV9S6BpsFJwTSIz6e+KtTNUexPkp
 SQMN9QW7undDFAjxcu/0ARBSNmYy90wYl7KSLg0AAAuddMqm2btJcAi
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
2.50.1


