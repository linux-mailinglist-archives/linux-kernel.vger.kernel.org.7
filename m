Return-Path: <linux-kernel+bounces-761642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF176B1FCF5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1CCF7A9105
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 22:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A0F2D77E7;
	Sun, 10 Aug 2025 22:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHHfrfUB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20DF2D8384
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754866672; cv=none; b=j6VV0VA366kFy1L4C+AcwVb+qUEPnVI27XFkV+c2552SWBqhJz3cfFpCOHlOWOhwZNrJx/efjbGKwVAE3PMJxnkpILGtk9+laZ774fHpYDKN0yjT2VT6rOpAAaXY9uM68hDF/0EqGudfXEplYruyPa6sIIFHWtugvVvWD4dZlfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754866672; c=relaxed/simple;
	bh=zgC0RAqMfe4QHFoCK3ImKc6JYhHbtGs2pWeVB9da7xM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OO8MfT3OYd9YEZ9p7y4iElrU5B1zjgisJFTSIKMCpFd8Deyjb8+pufAIRq9NMQeLpE8VTyIl3lZ0MWJASkY5FMDH87PCo55GLRGn3rxid+GOu4Hs3wjRXmUZw/Sz0OUnYiEfc/uyrgjODHYv6FVoUlarxnvZRqA8Q1GBZRno4nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BHHfrfUB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754866670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8SfCqXrLXFpaQOsEIXkeTXLB3lBS80oYBheI2i61aRI=;
	b=BHHfrfUBzolgUbq/K8ygy+h/KTXAXJJj0IJFH5VoRwcEnnSQUJodA5BxoPfPvJpVvNZAWY
	fyW7XjiQKgpdj1mSS/qvj5DYNV0CgC3ksEg55Weap2Gipog3zNqYBpfFbVR3L4ft028uFD
	bIIWtrwUDKr0zYnOimX99c7bvjhh5lo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-zqJYlU6eOWWducw5gVwtOA-1; Sun, 10 Aug 2025 18:57:48 -0400
X-MC-Unique: zqJYlU6eOWWducw5gVwtOA-1
X-Mimecast-MFC-AGG-ID: zqJYlU6eOWWducw5gVwtOA_1754866668
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7075a0b5580so79079766d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 15:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754866667; x=1755471467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8SfCqXrLXFpaQOsEIXkeTXLB3lBS80oYBheI2i61aRI=;
        b=XVuRWqnC5+dMl0ParqR+cLZYrIUaRMFzeFO3KmjHMvwK9K54gdZ5ChzXXAxa6tYQPA
         L4GgcI2lSeJxLM12um/vjrg3sU/xA1edEQ/91c5ZlqJxWXqYkQYaOQ9Kchquk8EupMy3
         UtSzefUfdu07VpWQKnDn5fS++lX+w7un3VMH5Zx+fLkDxr0xNprVcbm1T0uoPNMYpjQE
         YyG4gwfkHZdtV2N+J6MMSHSFe4bC+ybcDK1SMS1X+mKwoYIsqipRfAgeT9UjN8ULI6NY
         OPiwLYg7mWTRAGgSoZOb02yhlUKl7EhcxeB+VaSVYjOZ3qDBALvqIL4+MXaaRdeH2E1A
         4HfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxGq1/Fi9MzYiL+0kWIE9OfFGjicH7exAmBRhYIOH//1BPoGRV+iUVVqjSZSy3f3ghKcugVmApdnMIyjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHvAoEoRtjobFI9GePFM+/hkJ+GpC39RaIkgXwRng2gAQtkqbd
	rlM6v/eDBI59+ui5IOpLbqO+ZM6N1f6alvYyrTs6+k50nUgSmOUc+0dljnBWA93EQ9U1c51P2VH
	r9MFJwo3DuNn+MV7sw3Q9va9V1Oels+Hv1RTbeuaj2qUO65m4SUTfEiel3p8XASroOA==
X-Gm-Gg: ASbGncvGpuOdbG2udXVwegbyRWF93LEqHOHRN0KIY+Ms/Gwl5MtTDzT22X7TOn9IoV0
	VZNaVs6L70sV69vW2om1izqPYm2Rm1vGQUYWxbR3Nt3cseLD4VQVNTqLgAT58OoZdROqEFyAFkV
	zIsd8zJzkw7st6rPw+we82sIV5LxMXwtnnmId0STVerk8AI2LFd95tMP2APLCkbjfqHQBwf44vq
	b3uUREbKNzqUBCgkst8q+z4+I7zjrOMS+WRRUTszLB8kv5BSYRr4LDFXTLnr4TpI8PgiZq3Qxsu
	R3Jn725OFUQlRXJtUFrRyfsU7Za6loRHOe9iqA609CqbRw1PfFh3MZsFzTzrT1kmX3ux+M7SHWR
	8wiW0Mw==
X-Received: by 2002:a05:6214:21e3:b0:707:616f:fff4 with SMTP id 6a1803df08f44-7099a199543mr177311406d6.10.1754866667578;
        Sun, 10 Aug 2025 15:57:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmz3g1MbcKxpKoE+L/OvCm0G94lPBEhAXAtzenne1OaexYFo15GBJiT3E87eJ0e4mZmWm1MQ==
X-Received: by 2002:a05:6214:21e3:b0:707:616f:fff4 with SMTP id 6a1803df08f44-7099a199543mr177311176d6.10.1754866667214;
        Sun, 10 Aug 2025 15:57:47 -0700 (PDT)
Received: from [10.144.145.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cdd9916sm144266336d6.61.2025.08.10.15.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 15:57:46 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Sun, 10 Aug 2025 18:57:26 -0400
Subject: [PATCH v2 2/7] drm/msm/dsi_phy_14nm: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-drm-msm-phy-clk-round-rate-v2-2-0fd1f7979c83@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754866653; l=3160;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=zgC0RAqMfe4QHFoCK3ImKc6JYhHbtGs2pWeVB9da7xM=;
 b=g/OyIxfyVmL0j+PhW5RWDXbEs2uOlzP1vLM9nzajU+5emPdyje17xtKS5Qd4HfejxqWdsQWeZ
 8ROBSPZGhvzDt9b3VBZA5OUUGLIt5EVJPoH+qM81ctxrdXWei/umj9J
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series. The change to use clamp_t() was
done manually.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c | 34 +++++++++++++++---------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
index 3a1c8ece6657c988cfb0c26af39b5d145bc576f8..fdefcbd9c2848a1c76414a41b811b29e5fed9ddc 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
@@ -578,21 +578,19 @@ static void dsi_pll_14nm_vco_unprepare(struct clk_hw *hw)
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
+	req->rate = clamp_t(unsigned long, req->rate,
+			    pll_14nm->phy->cfg->min_pll_rate, pll_14nm->phy->cfg->max_pll_rate);
+
+	return 0;
 }
 
 static const struct clk_ops clk_ops_dsi_pll_14nm_vco = {
-	.round_rate = dsi_pll_14nm_clk_round_rate,
+	.determine_rate = dsi_pll_14nm_clk_determine_rate,
 	.set_rate = dsi_pll_14nm_vco_set_rate,
 	.recalc_rate = dsi_pll_14nm_vco_recalc_rate,
 	.prepare = dsi_pll_14nm_vco_prepare,
@@ -622,18 +620,20 @@ static unsigned long dsi_pll_14nm_postdiv_recalc_rate(struct clk_hw *hw,
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
@@ -680,7 +680,7 @@ static int dsi_pll_14nm_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
 
 static const struct clk_ops clk_ops_dsi_pll_14nm_postdiv = {
 	.recalc_rate = dsi_pll_14nm_postdiv_recalc_rate,
-	.round_rate = dsi_pll_14nm_postdiv_round_rate,
+	.determine_rate = dsi_pll_14nm_postdiv_determine_rate,
 	.set_rate = dsi_pll_14nm_postdiv_set_rate,
 };
 

-- 
2.50.1


