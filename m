Return-Path: <linux-kernel+bounces-761643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFAEB1FCF8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD8E3B4C58
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 22:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07462D878C;
	Sun, 10 Aug 2025 22:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="STG8J45A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F631EB9FA
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754866675; cv=none; b=thjGpwRn4YCB5/cLYzhg6Ashj51zREnqo2zcvOvjZovyTdTYT66vu5zKd5qOGzIM1XeHDSXdgkR9DGikbYPlQGROXusI7zt/vXtfBd8CP1qLZifOQC4EQtEx3qH9+vCCLTVW+YdcAmHn5O5EWElnvnH7sDGmK7OUi2p+ZaAYiX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754866675; c=relaxed/simple;
	bh=S1ThvUuOJst13Y/YlkE34LQrjuUVO54/oWHL+6E9CBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jSYbeVFppvBbpc85qQ9etr5bDzYB6c+ZoQ2/cQAbxYQRcOT4FXsOae7V3FJCXD83Md4PHjXJrKdw/KPHAOGquBKAyqPwJTYR7omZp41+4+iR5JwZQH8K//tg75/3mAsAqnxEJLMt7PTe8s+IMZus63id34dZPuxSTbTYH58/tu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=STG8J45A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754866673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UO4UTVA/mzla0cfFiIXtkcaKSPEU88yVqzjz85er5YU=;
	b=STG8J45AD+ceA/9DBiKAsNZN1OqegcradKjcfVE0DRCgCspIbnwAdb8Kyr/hxi0ER1SG/S
	uW1ttb4V3YZXQ8XGtuLhUzcIRbPSS1DoS4mOdY4u+/JNfZxfChiOGHjIXssWbytEhs/BBp
	I6Em4q/5zIMBQQgSoUPGS4DwFy9QFwE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-Tx4EVvjLO-WWpsV3BEWoRw-1; Sun, 10 Aug 2025 18:57:52 -0400
X-MC-Unique: Tx4EVvjLO-WWpsV3BEWoRw-1
X-Mimecast-MFC-AGG-ID: Tx4EVvjLO-WWpsV3BEWoRw_1754866672
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70743a15d33so89404206d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 15:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754866672; x=1755471472;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UO4UTVA/mzla0cfFiIXtkcaKSPEU88yVqzjz85er5YU=;
        b=rJBE+zc0L/dFrKz/sU5KwgAcPQp3GnjLHjrf6nJ5hlpSOTdkWq0YFCjVzEV3B0sUl+
         xa7eNhaP8ZuWGkp0XqLdj/Zrv216NyIWPSsLg04+I1BRig7KDThtMN/78l5aGeTL2+Mn
         0tPQdWs9DA4MMAoPESmJpnRAE1Cm7m68O0wNJwL35WlINCgfEJtgGnrSHAewMvpnKnn+
         N3/ckvpylMEBUW0WSaYSc+MdAEPuDIrcrHuslBSi3iQz/2U6YmlGpOsi4EBOsz9L0YVz
         HyEv4sMGDKAmaMfyxBzUKFkJyTExPzoUBskD1rTMj/C6al3GUSZHn9KMmJ1k/Gv0yam7
         DH7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXejRlmqTV8HmJe+kDGp0PfbACd5UODvnerAGfrQyDHnwBHPXD+dJThBvF29ArVM31t1exd2JJdd7sqsm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwQQtMDW4XacJ3WCMIXRRh2ZNKCRiPlwIzPB8cT5t8DyrlfABf
	eruqtZ0m+8Cv0I+0lltlK4hv7yw/+laqZPVxX6V/3Lj2Z6RGg3iWmQxzDZ6kLRfz5DhRUifINh3
	AgSotky4LMQiSt+pO6/cDKvz4jv9rMmkINQNukKH+VE3w+JOKgLXxtUjU+cB3WfrGhg==
X-Gm-Gg: ASbGnct94mAylgk2cTx0JzDvTWtl3jJopVIorWr2NyB4VN0joeVeMWsAYgjWVT5u3zp
	M7ydALZ/z58zJ/ix+ER4T1zKr693AQRSc6hEEVkXsS6Bia38pXT6yxKSpHW09F+gNCSWftnaW9S
	ysnHBjTh7pvy9Sy8LiUfkNEq6rf9mBWjJwiU+GQErkx/ONCnnlbjkS6SfMAY/Wpx7aqLXGaF0ok
	cLqTe5+wiRsNj294yvdScEaq80NMmJtvEGOqSnlSR0rfEfnb7ZRaFVsu2RObc8NuvkxT2L5iQg5
	PAbZqMiFTMyyJqd26M4oXH6izwl6kyBFgrtPvpb0I3d3Kv/CK07MkwXEjn7zMsgnlXkYX/5TwL7
	pz4mHHQ==
X-Received: by 2002:a05:6214:d02:b0:707:4b51:a490 with SMTP id 6a1803df08f44-7099a19aad2mr137562926d6.5.1754866671695;
        Sun, 10 Aug 2025 15:57:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8jqqdlU+xWojFno54cfUqsUBZEN8YO23eSx1vJ00mPnhAbDT9uCqATLlZeCwNyroK4P6n/g==
X-Received: by 2002:a05:6214:d02:b0:707:4b51:a490 with SMTP id 6a1803df08f44-7099a19aad2mr137562776d6.5.1754866671327;
        Sun, 10 Aug 2025 15:57:51 -0700 (PDT)
Received: from [10.144.145.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cdd9916sm144266336d6.61.2025.08.10.15.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 15:57:50 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Sun, 10 Aug 2025 18:57:27 -0400
Subject: [PATCH v2 3/7] drm/msm/dsi_phy_28nm_8960: convert from
 round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-drm-msm-phy-clk-round-rate-v2-3-0fd1f7979c83@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754866653; l=3029;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=S1ThvUuOJst13Y/YlkE34LQrjuUVO54/oWHL+6E9CBo=;
 b=4rVxfvm9gI5nV5UAVPsesymzsnSyxITGfXVS5e8nQ7ETrG0DkGZDJjcM2GeRttJ1xTdECTbGI
 s8fyPCx6Vs0B/8HLHCZbs2HwuxniL7G5vx63VQcoWh5nqmwlomL+2OO
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series. The change to use clamp_t() was
done manually.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c | 32 ++++++++++++-------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c
index f3643320ff2f2bae5301bb94f1fe19fa03db584c..8dcce9581dc38730ab725e0e435ab93a04c527ed 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c
@@ -231,21 +231,19 @@ static void dsi_pll_28nm_vco_unprepare(struct clk_hw *hw)
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
+	req->rate = clamp_t(unsigned long, req->rate,
+			    pll_28nm->phy->cfg->min_pll_rate, pll_28nm->phy->cfg->max_pll_rate);
+
+	return 0;
 }
 
 static const struct clk_ops clk_ops_dsi_pll_28nm_vco = {
-	.round_rate = dsi_pll_28nm_clk_round_rate,
+	.determine_rate = dsi_pll_28nm_clk_determine_rate,
 	.set_rate = dsi_pll_28nm_clk_set_rate,
 	.recalc_rate = dsi_pll_28nm_clk_recalc_rate,
 	.prepare = dsi_pll_28nm_vco_prepare,
@@ -296,18 +294,20 @@ static unsigned int get_vco_mul_factor(unsigned long byte_clk_rate)
 		return 8;
 }
 
-static long clk_bytediv_round_rate(struct clk_hw *hw, unsigned long rate,
-				   unsigned long *prate)
+static int clk_bytediv_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
 {
 	unsigned long best_parent;
 	unsigned int factor;
 
-	factor = get_vco_mul_factor(rate);
+	factor = get_vco_mul_factor(req->rate);
+
+	best_parent = req->rate * factor;
+	req->best_parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw), best_parent);
 
-	best_parent = rate * factor;
-	*prate = clk_hw_round_rate(clk_hw_get_parent(hw), best_parent);
+	req->rate = req->best_parent_rate / factor;
 
-	return *prate / factor;
+	return 0;
 }
 
 static int clk_bytediv_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -328,7 +328,7 @@ static int clk_bytediv_set_rate(struct clk_hw *hw, unsigned long rate,
 
 /* Our special byte clock divider ops */
 static const struct clk_ops clk_bytediv_ops = {
-	.round_rate = clk_bytediv_round_rate,
+	.determine_rate = clk_bytediv_determine_rate,
 	.set_rate = clk_bytediv_set_rate,
 	.recalc_rate = clk_bytediv_recalc_rate,
 };

-- 
2.50.1


