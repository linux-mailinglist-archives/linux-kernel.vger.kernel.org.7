Return-Path: <linux-kernel+bounces-726140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA354B008AA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B75169713
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7C02F1FC6;
	Thu, 10 Jul 2025 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GlFutpi4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754922F19A5
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164882; cv=none; b=T4CL/Anz8FL9mddUGDXzIyGYgUWGc2gi3Ok6apRoCpGqzopjhJWf09W7SCO2UuhijLAgdk53h8iTYgQJvHM2wujD8bByWxAt+d6mgoRcB1hi/gUbzDwSTVEERsMmsCVlA71ZJ78Yu/vOhRfA2E4sl8Cr+FTyvQ8MzLdGz/UH5bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164882; c=relaxed/simple;
	bh=3ODFGmq25OpFxWiAcH0OIyfIX2aQaxGLNyYzCPsECGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bjVxS+OYAy+o2QTXXj/9UrUEiVcwu3lgkXnTcDslohTAHaHJJxJ4DseRkp+sSrPoYHYCufblrMiZiC+6W6GIDfUDbH8Mo9AAhPEhEZigbtmmfI7PrMTJ0TenC5qNJ8zMShgOOSPeFgr6PScEnveK52FCKa/H45OaiKQ9eVwIKGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GlFutpi4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752164879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p9mwZB2plhUHbudI2oPn9i55OvcjPNJuoUdisMW4qVI=;
	b=GlFutpi4q+TX6dT6pbFs/8bDdtSkfPsiwhyWI3564OMrfUP1lHFhGou6NddxS8momSgJhK
	92A/iV8BuuOv2IS8+aOAKDOrikeXWlhDCEJSIO/GUaIRWB7CEqItMdeLLeJU3cZUwx5jzp
	19n1CfV0L7gdp0DHNZDLKXluLzepARg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-wUtiZfgkNDyHO0IbdQalmA-1; Thu, 10 Jul 2025 12:27:58 -0400
X-MC-Unique: wUtiZfgkNDyHO0IbdQalmA-1
X-Mimecast-MFC-AGG-ID: wUtiZfgkNDyHO0IbdQalmA_1752164878
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d4576e83cdso278785185a.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752164877; x=1752769677;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9mwZB2plhUHbudI2oPn9i55OvcjPNJuoUdisMW4qVI=;
        b=oE3nIxULmRTSQuTGVzow6YM3KSmWnbe6KpezyuTjSq4bqGFn+Luo1MqUvBkp334arB
         y/wJ3p4WQu3Ar8OfTnc23tjzhPcmet5cbxZF8dCuFcxlwKgUexXq+6s1/TEsJKa5sLR1
         9Glf7wIWn0OH3y1/LtFzFIkZJV2B46IZciowWOuCjgmt/JgKo3FbxkqLOWv00rCLYn5E
         N/Rg6SHF5OsIu8GrZ76+11aWg3bPeHxsRlVHCtB3kNmbiTLdFqQ/jo6hX6LmRZ7tzZJz
         V4HzDmikQGsPgcCS/X4jil1r8GSEbbSTdV2cJCMMJNo3BQCa1eEl78p/VhVDnVgCxPHj
         /YWg==
X-Forwarded-Encrypted: i=1; AJvYcCWkpLSmhe6nOBtvrFidZu7Kxc1lq3/Ov+lZEQB/sMggRmC4edp5V8MkZ89R5gtZ2LGGqpu2cXZnMIZAI+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YylcbFXKIj2Zory9ZFzn97HAzEbva0tWhjwnf6jOkW6GZMQO/Bm
	rtrODR2fWn43/EBAkUIzEFetP+2OHFx7hpfTx9fbnBhCvSIMtoj2JlSKvjtZO7NSDE4GjiZz2xy
	wCYodZubDZuAGYJUPezKy0eNubzvFAPhEcTFQ86wj5y6EQSX7eDN2KQ4ao1gCY5gTdl+iyGYX+w
	==
X-Gm-Gg: ASbGncvt6OKmTF7ECcwGPM8DNp/M60XkgO5wp0M/iY1JwHT31HdPHble7F2fkeb78t2
	LhKDociKix740v3GnLdSV3tTWUftXWw757bVLlu0rYU7xtYBgRgecpEE1pzYmVct5AXZhxm17jI
	t+Gtu5tIWt9pKXpjWrytD93LrObLb5RZOpA/AVn2ikSgom+HfxwnfGDV+f6WdydG6l0JZcOtwb7
	idrUl71ochZRouPGrubBde2HQ2bp3mKkjKkokvMfzaSNTBIPHOmNuDQ12Ma4/BXwPz9KkN22lh4
	6jTmbtU2h/gZ6uDFBNcrsYBHfzj6fZcfqk87RDdxecH0WWhKyTGvCCuaYRi4
X-Received: by 2002:a05:620a:720d:b0:7ca:efed:8644 with SMTP id af79cd13be357-7dde9d4b40emr22153085a.5.1752164877018;
        Thu, 10 Jul 2025 09:27:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5Dc+meUY3eLJ1nyNqdTNqbIqZwCg2pxyiI+KO5nsXIe7JUd0ZvtudqCR2DM307gX30VZuYQ==
X-Received: by 2002:a05:620a:720d:b0:7ca:efed:8644 with SMTP id af79cd13be357-7dde9d4b40emr22149985a.5.1752164876637;
        Thu, 10 Jul 2025 09:27:56 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdc5df99asm113487685a.49.2025.07.10.09.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:27:55 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 12:27:30 -0400
Subject: [PATCH 4/7] drm/msm/dsi_phy_28nm: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-drm-msm-phy-clk-round-rate-v1-4-364b1d9ee3f8@redhat.com>
References: <20250710-drm-msm-phy-clk-round-rate-v1-0-364b1d9ee3f8@redhat.com>
In-Reply-To: <20250710-drm-msm-phy-clk-round-rate-v1-0-364b1d9ee3f8@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752164864; l=2599;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=3ODFGmq25OpFxWiAcH0OIyfIX2aQaxGLNyYzCPsECGw=;
 b=6/oStFWVrSUL8wUy/Yr+UeM9R3GqucZAe/BmJ+rdDWThekiBeQJQsTbUFCiwYDPvTUlOQurv+
 kZVgof83EB5BMQUlmdA4vkC4n6yoCb7TJpusAuMVQfBfOhbDoFBQBI1
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
index 90348a2af3e9dac72924561b23b169a268abc3b0..6f500f6ac72813b542775e392680499f2eea6df5 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
@@ -533,21 +533,21 @@ static void dsi_pll_28nm_vco_unprepare(struct clk_hw *hw)
 	pll_28nm->phy->pll_on = false;
 }
 
-static long dsi_pll_28nm_clk_round_rate(struct clk_hw *hw,
-		unsigned long rate, unsigned long *parent_rate)
+static int dsi_pll_28nm_clk_determine_rate(struct clk_hw *hw,
+					   struct clk_rate_request *req)
 {
 	struct dsi_pll_28nm *pll_28nm = to_pll_28nm(hw);
 
-	if      (rate < pll_28nm->phy->cfg->min_pll_rate)
-		return  pll_28nm->phy->cfg->min_pll_rate;
-	else if (rate > pll_28nm->phy->cfg->max_pll_rate)
-		return  pll_28nm->phy->cfg->max_pll_rate;
-	else
-		return rate;
+	if (req->rate < pll_28nm->phy->cfg->min_pll_rate)
+		req->rate = pll_28nm->phy->cfg->min_pll_rate;
+	else if (req->rate > pll_28nm->phy->cfg->max_pll_rate)
+		req->rate = pll_28nm->phy->cfg->max_pll_rate;
+
+	return 0;
 }
 
 static const struct clk_ops clk_ops_dsi_pll_28nm_vco_hpm = {
-	.round_rate = dsi_pll_28nm_clk_round_rate,
+	.determine_rate = dsi_pll_28nm_clk_determine_rate,
 	.set_rate = dsi_pll_28nm_clk_set_rate,
 	.recalc_rate = dsi_pll_28nm_clk_recalc_rate,
 	.prepare = dsi_pll_28nm_vco_prepare_hpm,
@@ -556,7 +556,7 @@ static const struct clk_ops clk_ops_dsi_pll_28nm_vco_hpm = {
 };
 
 static const struct clk_ops clk_ops_dsi_pll_28nm_vco_lp = {
-	.round_rate = dsi_pll_28nm_clk_round_rate,
+	.determine_rate = dsi_pll_28nm_clk_determine_rate,
 	.set_rate = dsi_pll_28nm_clk_set_rate,
 	.recalc_rate = dsi_pll_28nm_clk_recalc_rate,
 	.prepare = dsi_pll_28nm_vco_prepare_lp,
@@ -565,7 +565,7 @@ static const struct clk_ops clk_ops_dsi_pll_28nm_vco_lp = {
 };
 
 static const struct clk_ops clk_ops_dsi_pll_28nm_vco_8226 = {
-	.round_rate = dsi_pll_28nm_clk_round_rate,
+	.determine_rate = dsi_pll_28nm_clk_determine_rate,
 	.set_rate = dsi_pll_28nm_clk_set_rate,
 	.recalc_rate = dsi_pll_28nm_clk_recalc_rate,
 	.prepare = dsi_pll_28nm_vco_prepare_8226,

-- 
2.50.0


