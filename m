Return-Path: <linux-kernel+bounces-726138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A8BB008AB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D64717B391B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6012F0E5C;
	Thu, 10 Jul 2025 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6VWCBrk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86312F0E3C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164877; cv=none; b=R03QHFlOKflT2nVLu88KSrWXBsD2AV35FEMPWcOr1BCCgMoKhx9gOja5dTHM66R27/DeZi/A1NR+lcsJPFjUg4bDnsQ0z1dlZjmhFoVuvYrdimZQEJM54bpOwQsmCFaEabbXxTbH243PJPnCkQ6eIqRGl4zmiQpCBbMHeHo3RJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164877; c=relaxed/simple;
	bh=nqAod6ptbkqWsY1ReyritvzpOhyiZE8UL5uK1TlylSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FOukdTug0p73xUt/rx9excYMYJ3XVB7YNPzfbTmT5iEKVbFUeRo/5iAArs2RMWu3CIzvpSCER56xuBCMBU6xavUwPVd/llqLPRFKx+7BTS7gcpG4BIMqlVXNJ+DA9MAtRMyd0MNk+8RxIvMadDIW+J2lZSgJqTBRkXSHho85tcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X6VWCBrk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752164875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5R3syR4S85etmH81khP1EmeTBgeUTYs1zijTxbmA/kg=;
	b=X6VWCBrkMGzBHHECQ3RwcoJZjBnrZxeF7S1uKxTyuKyScMl5mEzwhgXE9vqGobd6GYnFwI
	2tSDAsUgbbAc+1Jq5qEj+6qofCyl5HMBioIRMgIWS+AXhwB2+V03zJwnJq/YVc1p86DbXO
	hmWjblssc7cMARBW5WhunGxoU8fG5ak=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-gNYhPv04OwKojPQA-0qWcg-1; Thu, 10 Jul 2025 12:27:51 -0400
X-MC-Unique: gNYhPv04OwKojPQA-0qWcg-1
X-Mimecast-MFC-AGG-ID: gNYhPv04OwKojPQA-0qWcg_1752164871
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7da0850c9e5so198605785a.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752164871; x=1752769671;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5R3syR4S85etmH81khP1EmeTBgeUTYs1zijTxbmA/kg=;
        b=q7KLPTiJiYP2q2u8ypeDCjED173/9DVvgF5moBqN0eOGtVaNddilzY40+95/WPnAWY
         H8D/SXLzAVwUPsynzN0giG5WMBxzaHVres9UVNnweR2ds9Kr9v6tabA+70Uz+WH1XjKR
         JxkIk9uwLlCgUWvoiwNnBJphS4Zw8xi2s+s6XLEaZ8b1GJ2lGJQ7mZ8ekZDY4iUnEL/W
         4eg1iyEMmw/ItU335WpQ53QZpvDSiKwIfe/3tIQMnV/uJDVojipK4V31B0e33O5O7ggI
         pYLlm2esh+HLtumjBj3Qwn61fu+7rLOTlAvjDZlx+rPEas/vE9Cf/iiyhAtM+Cv1OGTC
         j3Rg==
X-Forwarded-Encrypted: i=1; AJvYcCU7whtRftGnjn8EqQUH2vMFFjIp1NvXFTI2JkoIY1h8/V4IFXLL6NpsMwId2pmNDqVPGjkpcc8qEBbhtq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLsxx3MIV2N7MptSAiPkBaRIXY2hwDluwiaSqT7YFYHzKvpId+
	9uEgnte/lLY7bLQd/z8zvsaST/E8GsM36b6BFq8CY4dlMVjCeJke6F1PHjIptoOA3GYzkqMbUiu
	1KpfhsSHwRI+xm/QuNGkzOlritBR8IWJlNK5Lda53fpt1f5gaCbKiVgPOCq1UAr0g3w==
X-Gm-Gg: ASbGncuM0g00Z98k1EM3wfoqaUsjA+V56hPhL0Ws631xPqHxZzdsR3lk1YW2LBrmwL1
	dmg+VM9Q1O8yaO1Yx5iKaREfFbFYo9cihYYSJKWQvf42TFe6t01fIqh8XlXxD66A19DEOEfA7jZ
	b+z8cBqWtMm0yO8Dz5E3H/TkzJrIhQCHcxel2WVVDKKqIkcqmJ1p5QNOkWIImq62jfD0my717cH
	rQGsHVOhlWFdLR87bUwQmQ800wSANi9cBSAdo6ekcAmNQ2NSavsgNZlXRaRc/4pOrkqBS/Is9be
	M+4qnstoOK465Dpe0b2qKApdFLM1R96OlLGqisSlE+m9WlD3eSGm+1jAobMr
X-Received: by 2002:a05:620a:2544:b0:7d3:f17d:10c8 with SMTP id af79cd13be357-7dded1f16b8mr20792985a.43.1752164871217;
        Thu, 10 Jul 2025 09:27:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOyyYlCkE/VGPozckcGjQXSedTTbkLOtyXFJPCLzGJ2sRyA8bY8gLQAjWSxObzTseQLmP6BQ==
X-Received: by 2002:a05:620a:2544:b0:7d3:f17d:10c8 with SMTP id af79cd13be357-7dded1f16b8mr20785785a.43.1752164870612;
        Thu, 10 Jul 2025 09:27:50 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdc5df99asm113487685a.49.2025.07.10.09.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:27:50 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 12:27:28 -0400
Subject: [PATCH 2/7] drm/msm/dsi_phy_14nm: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-drm-msm-phy-clk-round-rate-v1-2-364b1d9ee3f8@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752164864; l=3196;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=nqAod6ptbkqWsY1ReyritvzpOhyiZE8UL5uK1TlylSY=;
 b=OoNhhsZUbmAMdwPUtra7QULaHqehIf0/38bmAqXxUkaMeC3doTAw/V/9TIJKb+x9w7DYvOig4
 Gf4oVrvhKVRAcfxi2pcc58T03+pEYH6XMrMX4bp1bgSK7BzZMg4R1Tf
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c | 36 ++++++++++++++++--------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
index 3a1c8ece6657c988cfb0c26af39b5d145bc576f8..4bc9b7e44ce775f676fc89cf4565adeb309f0177 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
@@ -578,21 +578,21 @@ static void dsi_pll_14nm_vco_unprepare(struct clk_hw *hw)
 	pll_14nm->phy->pll_on = false;
 }
 
-static long dsi_pll_14nm_clk_round_rate(struct clk_hw *hw,
-		unsigned long rate, unsigned long *parent_rate)
+static int dsi_pll_14nm_clk_determine_rate(struct clk_hw *hw,
+					   struct clk_rate_request *req)
 {
 	struct dsi_pll_14nm *pll_14nm = to_pll_14nm(hw);
 
-	if      (rate < pll_14nm->phy->cfg->min_pll_rate)
-		return  pll_14nm->phy->cfg->min_pll_rate;
-	else if (rate > pll_14nm->phy->cfg->max_pll_rate)
-		return  pll_14nm->phy->cfg->max_pll_rate;
-	else
-		return rate;
+	if (req->rate < pll_14nm->phy->cfg->min_pll_rate)
+		req->rate = pll_14nm->phy->cfg->min_pll_rate;
+	else if (req->rate > pll_14nm->phy->cfg->max_pll_rate)
+		req->rate = pll_14nm->phy->cfg->max_pll_rate;
+
+	return 0;
 }
 
 static const struct clk_ops clk_ops_dsi_pll_14nm_vco = {
-	.round_rate = dsi_pll_14nm_clk_round_rate,
+	.determine_rate = dsi_pll_14nm_clk_determine_rate,
 	.set_rate = dsi_pll_14nm_vco_set_rate,
 	.recalc_rate = dsi_pll_14nm_vco_recalc_rate,
 	.prepare = dsi_pll_14nm_vco_prepare,
@@ -622,18 +622,20 @@ static unsigned long dsi_pll_14nm_postdiv_recalc_rate(struct clk_hw *hw,
 				   postdiv->flags, width);
 }
 
-static long dsi_pll_14nm_postdiv_round_rate(struct clk_hw *hw,
-					    unsigned long rate,
-					    unsigned long *prate)
+static int dsi_pll_14nm_postdiv_determine_rate(struct clk_hw *hw,
+					       struct clk_rate_request *req)
 {
 	struct dsi_pll_14nm_postdiv *postdiv = to_pll_14nm_postdiv(hw);
 	struct dsi_pll_14nm *pll_14nm = postdiv->pll;
 
-	DBG("DSI%d PLL parent rate=%lu", pll_14nm->phy->id, rate);
+	DBG("DSI%d PLL parent rate=%lu", pll_14nm->phy->id, req->rate);
 
-	return divider_round_rate(hw, rate, prate, NULL,
-				  postdiv->width,
-				  postdiv->flags);
+	req->rate = divider_round_rate(hw, req->rate, &req->best_parent_rate,
+				       NULL,
+				       postdiv->width,
+				       postdiv->flags);
+
+	return 0;
 }
 
 static int dsi_pll_14nm_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -680,7 +682,7 @@ static int dsi_pll_14nm_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
 
 static const struct clk_ops clk_ops_dsi_pll_14nm_postdiv = {
 	.recalc_rate = dsi_pll_14nm_postdiv_recalc_rate,
-	.round_rate = dsi_pll_14nm_postdiv_round_rate,
+	.determine_rate = dsi_pll_14nm_postdiv_determine_rate,
 	.set_rate = dsi_pll_14nm_postdiv_set_rate,
 };
 

-- 
2.50.0


