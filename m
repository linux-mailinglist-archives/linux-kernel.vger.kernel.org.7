Return-Path: <linux-kernel+bounces-726261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98227B00A50
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29C71C83DBD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F782F3C02;
	Thu, 10 Jul 2025 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1NKOcA9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3532F199D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752169430; cv=none; b=ozdPTlf0yLskBwj/M5Eh3oFJdWIgk3Q29kIRVpUn4Rv6CBKDRMjZc9ISHGzYfVZxX473g9x0Vw31+NGDtt1ZcwhKgUYfTKBtAVZn1bet2tU8COO03wqhexUZe7zA39SDg2Yapy6lv09NX3LxDvBEmLrrAG8tFIg8q8TlpS89/Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752169430; c=relaxed/simple;
	bh=xPkagiW22ryYRgcFeUxKsYb4R3sx64zzzkaF7TIS6rk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RJrR9B4p+SvhwOTaWZ214jnB2ygYWSVpzPz1WZV+op/cYA5uHWSf0uZ2Kx8WODUsqRDMskLjuhSdRWj5lbLf83dijxBXcaD8Du02vwT8DE1ud/cbxAHSugG0HJ+WUP2YrG6vm3w4MK/wy/eb7ImYv1hjf1j3VsNbY9TEzp+x3Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C1NKOcA9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752169427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/OrtVi+H4smani+Wxuj7rrrlvdLEKHZeWuJz/QAEtZ0=;
	b=C1NKOcA9WOjno+qVJncqzTsNd6tK1OAbQ/UwBy4EBdMnt4Xsye00ti/gS9SWSzC72f3Qme
	7/4nj1LECVyixuEcNUN0nPDlCSFLDGPZNcQ9nKJJXF3v7bGm4gP1VEyNxbQNKMyEYFUU2b
	VY73g0YPuvBXipL1Hqt2qlcEP3OjR1U=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-nDi4K8eqM32orSXn-GXFLw-1; Thu, 10 Jul 2025 13:43:46 -0400
X-MC-Unique: nDi4K8eqM32orSXn-GXFLw-1
X-Mimecast-MFC-AGG-ID: nDi4K8eqM32orSXn-GXFLw_1752169426
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6face45b58dso19844326d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752169426; x=1752774226;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OrtVi+H4smani+Wxuj7rrrlvdLEKHZeWuJz/QAEtZ0=;
        b=Hl30QTOa7I0VRqe6HHr6BZjtu+5r8bu4tE/0sb2hrsm7lk1jr7pyQ61AG0Ob37xsYT
         SG1+r8cTjY6D9Pylc0CVh0boSkBe1Am3719VgI86Nzh5BpEP7tQQ+p2nNKf1MdH8Mat8
         j4W56fO7Qb3GKny5zXV5WOuoadcvzTiGHktAqMq0+hqd+AjCHtrFfvAzjvenS/jm81dk
         8jd2CTB8RpAzNwvFKZyTBJ7SoQf75pDSfVpGjND4YYpFrWIqyfW2rnFMMwaDY7VQTy9E
         cMeabH3Xv1Ozats+OkmK/pmMATwQJRHHlFoCT3nKccAGptURUeCdxO69iMPQTCfPmd4E
         mipQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+dWgBC2OBwZJVbP8DoX6QIUdzgs6y8sUDvxBAM8j6fpkHaZgjRucviYe/SyFclvMTLTrNg1J+QZoA/io=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNVBZMrw7EMecGMNg1vpoKynfCMXov0rnUodMI7UXpTDg8Hwro
	o1PosgXFAFbfWS/w1iKuOoIsHchR56t03oIcp8SsvG+lTsZMsKlXsl1moL8rMo57/CIcPw2n7+I
	fYp1E6afmFSvahIvOUYGoXtXoo3lDptbCO+3bk2ZvkCzCWBlpn0paf6WuMRLW+1ocRQ==
X-Gm-Gg: ASbGncvA8g9moHB/OTiOZPvy0ZbTeAIGyfJVvG5PDBVqMfOGVUaDL7cjjME/Hp9Pbcl
	An2wPbB4U/Q2dH+9own54Ldh5HBP0AsrgCiULCVThdxNbaiG0XQJKypVwoif4pXFeCkj12+FsI5
	NnbTbZEEMVqFBD8MF6+i4XYWrFQrM+q0BlZwnySPkxgKmjSHRWRcDXIhnHe+/kZ6ZtapZKixypR
	6lsNYNHaXK8tnHw1iPOyoMbsbvPhq/qcUDVO53K0ulS3DQTDf7+Vfq61BymK5glZsIP/46yNV8y
	/Rmj1fEu7lVRlOPGGfX70dz5s5HZALrgF+UUbas/vGBDQnZU5k783gtEqABc
X-Received: by 2002:a05:6214:5d0a:b0:704:9bc2:be36 with SMTP id 6a1803df08f44-704a4083bcemr2613516d6.7.1752169425761;
        Thu, 10 Jul 2025 10:43:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxO+/+2HUAUPTiUYztt/lC4Yi0Q22OZoIfFBMZk64H2H2sqirYgZh1L3qOGgIkQVmmCaX6kA==
X-Received: by 2002:a05:6214:5d0a:b0:704:9bc2:be36 with SMTP id 6a1803df08f44-704a4083bcemr2613296d6.7.1752169425386;
        Thu, 10 Jul 2025 10:43:45 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d71419sm10652876d6.86.2025.07.10.10.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 10:43:44 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 13:43:10 -0400
Subject: [PATCH 9/9] drm/sun4i/sun4i_tcon_dclk: convert from round_rate()
 to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-drm-clk-round-rate-v1-9-601b9ea384c3@redhat.com>
References: <20250710-drm-clk-round-rate-v1-0-601b9ea384c3@redhat.com>
In-Reply-To: <20250710-drm-clk-round-rate-v1-0-601b9ea384c3@redhat.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-sunxi@lists.linux.dev, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752169393; l=2262;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=xPkagiW22ryYRgcFeUxKsYb4R3sx64zzzkaF7TIS6rk=;
 b=l1P9iwEOFZ7iseMUGqrDwyTv1j/GS/74kLm+7ZgYbXOn1R2j8JwTxirCensojfrRCiquhbnNY
 RQW74FdbQM8B7MkeQZA7rAthmyuLBvNMin91wee7+2bXtn9fga4VsSS
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon_dclk.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon_dclk.c b/drivers/gpu/drm/sun4i/sun4i_tcon_dclk.c
index 03d7de1911cd654f395ea85ad914588c4351f391..9b85bf512d4c81d0a12e8cf726d5d5440343519c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon_dclk.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon_dclk.c
@@ -67,8 +67,8 @@ static unsigned long sun4i_dclk_recalc_rate(struct clk_hw *hw,
 	return parent_rate / val;
 }
 
-static long sun4i_dclk_round_rate(struct clk_hw *hw, unsigned long rate,
-				  unsigned long *parent_rate)
+static int sun4i_dclk_determine_rate(struct clk_hw *hw,
+				     struct clk_rate_request *req)
 {
 	struct sun4i_dclk *dclk = hw_to_dclk(hw);
 	struct sun4i_tcon *tcon = dclk->tcon;
@@ -77,7 +77,7 @@ static long sun4i_dclk_round_rate(struct clk_hw *hw, unsigned long rate,
 	int i;
 
 	for (i = tcon->dclk_min_div; i <= tcon->dclk_max_div; i++) {
-		u64 ideal = (u64)rate * i;
+		u64 ideal = (u64) req->rate * i;
 		unsigned long rounded;
 
 		/*
@@ -99,17 +99,19 @@ static long sun4i_dclk_round_rate(struct clk_hw *hw, unsigned long rate,
 			goto out;
 		}
 
-		if (abs(rate - rounded / i) <
-		    abs(rate - best_parent / best_div)) {
+		if (abs(req->rate - rounded / i) <
+		    abs(req->rate - best_parent / best_div)) {
 			best_parent = rounded;
 			best_div = i;
 		}
 	}
 
 out:
-	*parent_rate = best_parent;
+	req->best_parent_rate = best_parent;
 
-	return best_parent / best_div;
+	req->rate = best_parent / best_div;
+
+	return 0;
 }
 
 static int sun4i_dclk_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -155,7 +157,7 @@ static const struct clk_ops sun4i_dclk_ops = {
 	.is_enabled	= sun4i_dclk_is_enabled,
 
 	.recalc_rate	= sun4i_dclk_recalc_rate,
-	.round_rate	= sun4i_dclk_round_rate,
+	.determine_rate = sun4i_dclk_determine_rate,
 	.set_rate	= sun4i_dclk_set_rate,
 
 	.get_phase	= sun4i_dclk_get_phase,

-- 
2.50.0


