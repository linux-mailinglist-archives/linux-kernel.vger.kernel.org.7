Return-Path: <linux-kernel+bounces-761641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D3BB1FCEC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B9163B0FC6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 22:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A408A2D839C;
	Sun, 10 Aug 2025 22:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UvucMBJN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBAB2D8384
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754866667; cv=none; b=IqsscLvesCdr4QdSFjwLVJIaHqNXwE9w6sZmjJXnO1ArW6we9hF13sU1BnC5Ahw2EfLfCTiVGyk/SrWFiHzkIK4X6Oo2Kwr2y9F038pyM044smWd75BvxUoSlxf9k9dIc54PQf2Uu1p88o6mCr8PHhmhe/vHwRmXEPvco+mM/9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754866667; c=relaxed/simple;
	bh=mlZH8VUTbF6GjSuW92dEJqa/xMC0PXyQyKOZ+vDaxME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q3GrzMhqaH+sBFUVAI//LmxUq9Ynm5cmXaAOseg/mxUjhAIUVjxMKVZGOEnF++TiESeaucbRbvrcf/4eT5VU9NdsOW/b3xVwvpeBsq1cRD+HEfxtHqOkaHa0yHzsF4oqeFrxfn/zigTZHFOf1WMm/y9ieMKjF6rgKrq585U8udc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UvucMBJN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754866664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bVC0fsmzSbmTSL6eyVRHt/hFHyj+fClbPc4jjMQBQNc=;
	b=UvucMBJNkkznm4M7nwGZX/p6h8Weq+K2EPxtcd8QsuFvBIK5NVN5qZeavgdnV3d9QoR4hL
	8axkZahunuip+2WP05oaUK4tgeyCzveUITZjY5Sd3XTzwcTj+ZrzmJfvUBrTakAP/Ee5cZ
	JV4Pid4zgOJ6aR/B5z9uHgbXizGC0SI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68--hqm_1zaMPyW2mU9mqNZ8Q-1; Sun, 10 Aug 2025 18:57:42 -0400
X-MC-Unique: -hqm_1zaMPyW2mU9mqNZ8Q-1
X-Mimecast-MFC-AGG-ID: -hqm_1zaMPyW2mU9mqNZ8Q_1754866662
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70707168c59so40446176d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 15:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754866662; x=1755471462;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVC0fsmzSbmTSL6eyVRHt/hFHyj+fClbPc4jjMQBQNc=;
        b=GyyUw4ZSZhisgnKTG2lSvLONcgEmQz1ALUWcYFUgqTCLmquyhNH7B7VFQF8xu+8dOe
         uUp1RNiypF6iENbJuHCfFi6el26wcHRbJcDFknEiFKk1e+v1QA/wOVGDT34qmTjZLUDw
         G/H58hZG6QhWs6GX/IPUpgX9cRTU2YYImptQ6qHBE40oTTEzg7Jdb/hAy9gbisDhc40j
         GIitrmhlcnYeBPqj8m6tHPyYXlmQtEefA0/IV8n/dcPLi4Pq5UUjcAOsv/AMaA2hCe9Q
         dOfG9KIcrHiisNaJZ+7Ea6PAHUZ+Dkbz2TOhnLxgc9QYbZyomcE7F2BXTE+jc33DdROU
         qZ5w==
X-Forwarded-Encrypted: i=1; AJvYcCXX814zzJo7J5bV1Gc7LFIpTdMvn1nWwaQ+R8XCVWTeeCxDM638y6kgEn08BEsYCwv6nK2vRK8uljFGX7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkEfn0WnH2DSTkX+VeX7XRDbJ8X+qPSHM6i/VcZU85DIe4AgQH
	30mD7porM1xXyDeGQGZ5NkCV0nJhBwlDzTGMGbMRNpdQXaCgIi8RYEM2zXkx4HjBSmwg9agw/DQ
	70jzBLMui0823eWMDLN5OuivdcErjqjhIRj8X/57xGO9s9qVEheU0AeJIuyMFVMK1KQ==
X-Gm-Gg: ASbGnct9AgKcXBDkXNdeBa4mTwEF4Dh4Ekc6Zx95Fjk1dfe1EXirYLTV1KoioqrP+O+
	Fj2W0d7siGTPr4nkqWkQggAnBxBgWcWXZ2HI9PXXYw/sMXdhLCaJkb6qxdsV4H94yRCpSIIr9Dj
	9Nqk02v+E5uOueeT6uki+nLQ5bLK+JSjJn1ZtN8l6NVbEnbbw899HO4Y/38WFDuKV6sPjK6QW4j
	93sOJZXKJCV2JT0uSbLUcfWcaNx3VFgTCPoG8lS5XJ7ptL918obYqNmpWR7iYWyUWxHAPHmqol+
	UNw6wJm0lcLIi+NylfCjBr0H48LhfzLOmvwRAaq5xTmO4mfbnJgU3iCOcNAGhlaYjA6lL2dh7aZ
	Seg5RLw==
X-Received: by 2002:a05:6214:2a45:b0:704:e0ab:a9bd with SMTP id 6a1803df08f44-7099a3e56f8mr122299126d6.24.1754866662366;
        Sun, 10 Aug 2025 15:57:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcMnOEXwtR8lN8UlPgOjL9+Zy3/GaRT4D7BPMh+oeXRYAdB1ptGpb4wo7alWACslPJfTQXCQ==
X-Received: by 2002:a05:6214:2a45:b0:704:e0ab:a9bd with SMTP id 6a1803df08f44-7099a3e56f8mr122298976d6.24.1754866661965;
        Sun, 10 Aug 2025 15:57:41 -0700 (PDT)
Received: from [10.144.145.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cdd9916sm144266336d6.61.2025.08.10.15.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 15:57:40 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Sun, 10 Aug 2025 18:57:25 -0400
Subject: [PATCH v2 1/7] drm/msm/dsi_phy_10nm: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-drm-msm-phy-clk-round-rate-v2-1-0fd1f7979c83@redhat.com>
References: <20250810-drm-msm-phy-clk-round-rate-v2-0-0fd1f7979c83@redhat.com>
In-Reply-To: <20250810-drm-msm-phy-clk-round-rate-v2-0-0fd1f7979c83@redhat.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754866653; l=1786;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=mlZH8VUTbF6GjSuW92dEJqa/xMC0PXyQyKOZ+vDaxME=;
 b=x0tYnThWbgPO4mmw+Gsp2C+ceOXEYoVMWAX/rkUBoIKXhbcdtiiiH5Qx0bZYWg7rb85fOnwgn
 te+Em4v6YAqCUom67xxN5Ay9xj6+tIi+ghcjTR1lViL5pmDtQqvYeDu
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series. The change to use clamp_t() was
done manually.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c
index af2e30f3f842a0157f161172bfe42059cabe6a8a..ec486ff02c9b5156cdf0902d05464cf57dc9605b 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c
@@ -444,21 +444,19 @@ static unsigned long dsi_pll_10nm_vco_recalc_rate(struct clk_hw *hw,
 	return (unsigned long)vco_rate;
 }
 
-static long dsi_pll_10nm_clk_round_rate(struct clk_hw *hw,
-		unsigned long rate, unsigned long *parent_rate)
+static int dsi_pll_10nm_clk_determine_rate(struct clk_hw *hw,
+					   struct clk_rate_request *req)
 {
 	struct dsi_pll_10nm *pll_10nm = to_pll_10nm(hw);
 
-	if      (rate < pll_10nm->phy->cfg->min_pll_rate)
-		return  pll_10nm->phy->cfg->min_pll_rate;
-	else if (rate > pll_10nm->phy->cfg->max_pll_rate)
-		return  pll_10nm->phy->cfg->max_pll_rate;
-	else
-		return rate;
+	req->rate = clamp_t(unsigned long, req->rate,
+			    pll_10nm->phy->cfg->min_pll_rate, pll_10nm->phy->cfg->max_pll_rate);
+
+	return 0;
 }
 
 static const struct clk_ops clk_ops_dsi_pll_10nm_vco = {
-	.round_rate = dsi_pll_10nm_clk_round_rate,
+	.determine_rate = dsi_pll_10nm_clk_determine_rate,
 	.set_rate = dsi_pll_10nm_vco_set_rate,
 	.recalc_rate = dsi_pll_10nm_vco_recalc_rate,
 	.prepare = dsi_pll_10nm_vco_prepare,

-- 
2.50.1


