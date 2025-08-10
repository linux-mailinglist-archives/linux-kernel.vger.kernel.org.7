Return-Path: <linux-kernel+bounces-761644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FEAB1FCFB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E331897E97
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 22:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E07E2D8396;
	Sun, 10 Aug 2025 22:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGvPqkJT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D242D879E
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754866681; cv=none; b=AEqCv+A63OqsXqEeXXSF6TA1WTaqTgvv01ifvIEDgHvxbDZQRsaNUDSd+qzCo7Cwoy3+9VFKVRrNauydmG9InwzOBUloeMhXgTDhnhGZgoy6XQ+TJ02c4UjHZo6D6Vsn8rvbDPq9F9aDOMZ4MzTYxnaydE2Benlbzlt55EPPNb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754866681; c=relaxed/simple;
	bh=p3ik0LUSdZ7pAUi9CZauKm9YuXyhxLdYH6tXOMz9RD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TPZXKcKoN8DPaep12t1+DcRv9sNP1ZQP4PSYMiCLFxijt8jOSb2Vxkh/97J8cxGCf1rJp3XpFZVY1nZP+IMiPSqciiXCIVQyKjEdLudG7OxNkgQjsVpZZ1ZFYVF982ekgSau3SDHcg88N8eM3lQD7ZLdDI0K5+XkbmRhhx+TwAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGvPqkJT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754866678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dBLZ3cfmxr+kqQkwT3NrM5Of/dkFLZw54pOqr7tKcVM=;
	b=YGvPqkJTqPF18WrxSjlm2zaooXZGPHxoUAYSyqJHo33ZuHpLuBG1QlEQGV9+nZ0PIjS4K6
	pddYqkr/uNMUjWfUP+gIjn9z4sI9HWecPFRMb+bZCoVSmyo9bzH7vevdtjpbcXfI0BGsA7
	szZ7cN2Y64oK9Ry2GnJECugw7HQ1/S0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-8RZeFMeuNWuGne48EWHwHg-1; Sun, 10 Aug 2025 18:57:57 -0400
X-MC-Unique: 8RZeFMeuNWuGne48EWHwHg-1
X-Mimecast-MFC-AGG-ID: 8RZeFMeuNWuGne48EWHwHg_1754866676
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7074f138855so71734336d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 15:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754866676; x=1755471476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBLZ3cfmxr+kqQkwT3NrM5Of/dkFLZw54pOqr7tKcVM=;
        b=W6TQWUilr54EK70QW30HAS9thJZdKpzAbDC2Dj6i6B31ge2EcYbD01cpjkiY87rfzL
         uu3M0wyL++yg9kv7Z9lJ4/CLCh5OwQqz+G4zbNRxoI5LilRfZk4Sxbza5eUKQhyrJKim
         z84OY4vJzg/5PKbZXSRqKpRllfuAna4MZ2zwIuDCGZWoUQx2c6DKlmoCq2KMZBJdfnCl
         uAvk0Fy2plgJZU0ajNcxdxIB8vHUcb3b+fFlvcTVrp/ZETmZDlLDxAJiJlPg596q0vfo
         lEASTKgK5lH0D0iy0PlXUZAiqdLJUY9X4nE6EiTAc+ThQBfsX3ztLQj+H3nAIcxa1JK9
         jWVA==
X-Forwarded-Encrypted: i=1; AJvYcCU6aGcbFzkakktbaEzZR5F8p1fF9o4S+9ldCQlzkFr4sXaLcqIEh9wInxyJBaS5KU/QdT5eUKNrHmi2BDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaSKUnI8VM2vcBloEuCJxoImY5qdNSjRlyCCBEXVHLu4vZE6yH
	yYP+PUsGHveITf83e59NNHXm0S+p0Jk4W0TNVYXoimLyt9nlEJ65R1QlhMWJ+xI61X4B0a7ymzd
	PYiTymAtULTuBAlhkYlEK8U7oZI1m9lZ6OqzUvhsgzj4U8MPzMN8ZhTNxGmBetECQIQ==
X-Gm-Gg: ASbGncvB4xqbGpe0APuvc8pitSZUopGmSCSoZh8t8qqrmKAHzzRlp/jMSwky4eNVjiS
	+aLigxVoKIryVO8zUpmMGO+QK5Gr61PoUlyofXy3OHZM3fPSk0KijCV8xlIJe69sQyyrlzqcH1V
	XYO/w3NEbyuLuR20TeseA7+6BipbclVapJEZCmli2+myKM9xpqb1pJwV1zggCzJ5abAQEay1rl/
	6ZOOEgyg40VCpRLl55kdXlB1QWKqnGOH0QI/23THm28I+hCYIkkuV5SnutCIFcFqdICcyOJLdFD
	ET/5Y0EWThfJ8+lDuv24ogSooAk28tvoYdaB/2IfWIQqUFYpAjnfeFQ9nSUAioAiNKPVN/LCgdi
	b6PQEbA==
X-Received: by 2002:a05:6214:4585:b0:709:b911:5f9a with SMTP id 6a1803df08f44-709b9116168mr79859956d6.15.1754866676475;
        Sun, 10 Aug 2025 15:57:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGd1TtWL5ynfgJb6QbL2wAAD9tHrHovMXdTygkPUrPT2VeRi/mGn+68aKi3/k5cra2LUregkg==
X-Received: by 2002:a05:6214:4585:b0:709:b911:5f9a with SMTP id 6a1803df08f44-709b9116168mr79859716d6.15.1754866676119;
        Sun, 10 Aug 2025 15:57:56 -0700 (PDT)
Received: from [10.144.145.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cdd9916sm144266336d6.61.2025.08.10.15.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 15:57:55 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Sun, 10 Aug 2025 18:57:28 -0400
Subject: [PATCH v2 4/7] drm/msm/dsi_phy_28nm: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-drm-msm-phy-clk-round-rate-v2-4-0fd1f7979c83@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754866653; l=2571;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=p3ik0LUSdZ7pAUi9CZauKm9YuXyhxLdYH6tXOMz9RD8=;
 b=R7LKKqyn/rze/YXErkV3FfpM8ZZMu5HZaOQr/tvP8aTxcbbN5RaDR0RWZNNF6WqbyaV3q+ft9
 fhWV9Cc8U6ZAQX8LrMGjTqjByHpN1lvRTa0Cj7+2O1r3z78hDY0dUWJ
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series. The change to use clamp_t() was
done manually.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
index 90348a2af3e9dac72924561b23b169a268abc3b0..d00e415b9a991cd515e01d78a48ac6fe3e830b04 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
@@ -533,21 +533,20 @@ static void dsi_pll_28nm_vco_unprepare(struct clk_hw *hw)
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
+			    pll_28nm->phy->cfg->min_pll_rate,
+			    pll_28nm->phy->cfg->max_pll_rate);
+
+	return 0;
 }
 
 static const struct clk_ops clk_ops_dsi_pll_28nm_vco_hpm = {
-	.round_rate = dsi_pll_28nm_clk_round_rate,
+	.determine_rate = dsi_pll_28nm_clk_determine_rate,
 	.set_rate = dsi_pll_28nm_clk_set_rate,
 	.recalc_rate = dsi_pll_28nm_clk_recalc_rate,
 	.prepare = dsi_pll_28nm_vco_prepare_hpm,
@@ -556,7 +555,7 @@ static const struct clk_ops clk_ops_dsi_pll_28nm_vco_hpm = {
 };
 
 static const struct clk_ops clk_ops_dsi_pll_28nm_vco_lp = {
-	.round_rate = dsi_pll_28nm_clk_round_rate,
+	.determine_rate = dsi_pll_28nm_clk_determine_rate,
 	.set_rate = dsi_pll_28nm_clk_set_rate,
 	.recalc_rate = dsi_pll_28nm_clk_recalc_rate,
 	.prepare = dsi_pll_28nm_vco_prepare_lp,
@@ -565,7 +564,7 @@ static const struct clk_ops clk_ops_dsi_pll_28nm_vco_lp = {
 };
 
 static const struct clk_ops clk_ops_dsi_pll_28nm_vco_8226 = {
-	.round_rate = dsi_pll_28nm_clk_round_rate,
+	.determine_rate = dsi_pll_28nm_clk_determine_rate,
 	.set_rate = dsi_pll_28nm_clk_set_rate,
 	.recalc_rate = dsi_pll_28nm_clk_recalc_rate,
 	.prepare = dsi_pll_28nm_vco_prepare_8226,

-- 
2.50.1


