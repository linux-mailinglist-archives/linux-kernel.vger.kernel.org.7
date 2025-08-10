Return-Path: <linux-kernel+bounces-761645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DAFB1FCFE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648D8173687
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 22:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166832D879E;
	Sun, 10 Aug 2025 22:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RjTmiGNL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0D623B629
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754866688; cv=none; b=UhZ10X4KxMHl2wxxq8oW999Dw0nTuXPHD1CuQTdSjH+r46vpgoosOiXG+aKoYRqGYsGY6WvkyqECyg8FS+bx901Uqf9kM4tqJdt+yXKg96v91jDjdFgRA+xUYO9M3sZEMvx5Uob+HdaxylDvSI3nYXGDTAx+RSLzztlTEdkgBBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754866688; c=relaxed/simple;
	bh=TCVYIFivGNX+30I7CcW+hQ/ILyWbQUzfCulxzbwFiso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hnBG8KmQoZNdsnt/O6Rv6nirVMs/RFPocW3Zj5+RiP5LksShM7I3GdDEpxIk1Y9CpCB2vzzKO7DUUxXEQSKC0ok/6TIj/hO2gQWZHfT+Wq0yUQ1gRFKTWa9xFxblEDocUGLeEKSzOxnMNtsM14qqLXW6wb/O7oNJ2xMKIM+dz5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RjTmiGNL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754866685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+jg/1yqiU75KoHv1FanEm2OpTvKZ33dl3uYGaGgUwg=;
	b=RjTmiGNL2tjpiJzMXUy9oCYJ0aLb3y2RWfg/bbkUHb++BM9eO6h+IMwwhbDrFwaqLc4lUJ
	ENh11W+/GmLhEvd7WEf39j4Ke9cFhCGaAcALSdqQX4NC5/wvOngKisFysRgXf/khw/X3SO
	d9hC6S5C5WOwC++nfIQwpBAT4E8Jp+U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-vDcKZO7vOqm_u7FsF1o9kw-1; Sun, 10 Aug 2025 18:58:04 -0400
X-MC-Unique: vDcKZO7vOqm_u7FsF1o9kw-1
X-Mimecast-MFC-AGG-ID: vDcKZO7vOqm_u7FsF1o9kw_1754866684
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7073cd24febso38312456d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 15:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754866683; x=1755471483;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+jg/1yqiU75KoHv1FanEm2OpTvKZ33dl3uYGaGgUwg=;
        b=l05h3rnXsQTVfLbl9D0+FMKDfH0ZNjBwBTeUrEEmVD+53P+CpkkmoP0quAs57CJROz
         8dokbokBqrnvcRXjvxp5DFvhc14nCLDJ042mxDOWkuiiEu0Neo5+LahPx9CtI7rpNTuj
         Zhdpq55PX8Sx7oVEjna/wFPFHjligfbsWUZsf95xoexLaMzEYWQ+s2J79XBdhOaMwMQP
         9agW8j/hrN3VIjHvnw/YxigAKjJM8f1g01wQSpOLYE+Fg9VlrAPzHATwpNturlj64/cB
         vb3IfVIYiIHBMRjlIl7iPmkr8OU5nKk+eGWyZ5TSljP+2vS1FE+4y0/VIrmiPgSJW4hh
         El0g==
X-Forwarded-Encrypted: i=1; AJvYcCXhMS4QxRbXB00GZIfrzDIAjj6NsTCFbpebjqAZPxpehrQgGgBCvKIeIZ2jswMJBFFnr0c7YlJNerRea2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv16iUY/I9TOHu3nEUw90NCNn/MGxg7QPYLr+pF9w/Pzm0QEqr
	js7gCM0Xay5d0T7l+mkI+J0XNlKh5Gja3FBg9jVW3ssAMRvGU+nbv8PiOhfy6g8yLfBfrK1E0+F
	/XFQMYLoNSzAa2xU5GAfQbGoznO9deWTl8tPQmES/L9CKxYHSG2l1X/iYdffIeEHUL4nlTxTotw
	==
X-Gm-Gg: ASbGncuKEsxKHke+GOdZIlyx5/a28Flzsih1uLn24u0tjdTfmD04wW1jiEqlxeYR0i+
	QDlAnW+MniFqrC4FbnU56sueec60AtBr3BhNtb7pjQ75++JiFccnuu881hUOWEfg7AKkpt+t9cc
	7cyvViOvTPGaOVyiy5pSkZqC7IpYrC7wFWd20LyXuU3NtAEcluDoVbFOgdBGhKSjbEqPyQ12kX9
	wmifZZQk0rOl8ZLyhaHmGrJ8dN9IUu9w7pg8hYCtqN6zJZ6JpJ4JhYFkZL5Uxz64JfQcNVYG9jY
	yOmkjRNbz7Fg2Wpi1HNNzl+XktqEJUve2e6TX5a4z0CqCpAEF4hRWrvHdUmKU6tsFrbKr1x4Nvf
	Ukc/gfw==
X-Received: by 2002:a05:6214:4e17:b0:709:ade9:742c with SMTP id 6a1803df08f44-709ade97506mr71682856d6.43.1754866683162;
        Sun, 10 Aug 2025 15:58:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkOu59xQUnrcN/f1twSlF1BrFwL5WoLAQ12FYDXq2PWIP1hHCC8VcITCPbW5zGS+dtgeykrQ==
X-Received: by 2002:a05:6214:4e17:b0:709:ade9:742c with SMTP id 6a1803df08f44-709ade97506mr71682586d6.43.1754866682705;
        Sun, 10 Aug 2025 15:58:02 -0700 (PDT)
Received: from [10.144.145.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cdd9916sm144266336d6.61.2025.08.10.15.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 15:58:01 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Sun, 10 Aug 2025 18:57:29 -0400
Subject: [PATCH v2 5/7] drm/msm/dsi_phy_7nm: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-drm-msm-phy-clk-round-rate-v2-5-0fd1f7979c83@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754866653; l=1762;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=TCVYIFivGNX+30I7CcW+hQ/ILyWbQUzfCulxzbwFiso=;
 b=hYrBk5VBcqe8AFaw5M0JbEMNQ/+5/EqgXMuDpqvpMtHJTmo1+Ev+Hog1C/ZssRnCSzPfMgO4W
 91f5Z5fMemWBs805qoxKufqYrIgn1TJu66F/ixECjawgTEoSUzz+mJo
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series. The change to use clamp_t() was
done manually.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
index 8c98f91a5930c9f2563a6b4824690ceef56987c0..c3bd3f89434eb7d3d0f3bb9455d22aa00915e797 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
@@ -561,21 +561,19 @@ static unsigned long dsi_pll_7nm_vco_recalc_rate(struct clk_hw *hw,
 	return (unsigned long)vco_rate;
 }
 
-static long dsi_pll_7nm_clk_round_rate(struct clk_hw *hw,
-		unsigned long rate, unsigned long *parent_rate)
+static int dsi_pll_7nm_clk_determine_rate(struct clk_hw *hw,
+					  struct clk_rate_request *req)
 {
 	struct dsi_pll_7nm *pll_7nm = to_pll_7nm(hw);
 
-	if      (rate < pll_7nm->phy->cfg->min_pll_rate)
-		return  pll_7nm->phy->cfg->min_pll_rate;
-	else if (rate > pll_7nm->phy->cfg->max_pll_rate)
-		return  pll_7nm->phy->cfg->max_pll_rate;
-	else
-		return rate;
+	req->rate = clamp_t(unsigned long, req->rate,
+			    pll_7nm->phy->cfg->min_pll_rate, pll_7nm->phy->cfg->max_pll_rate);
+
+	return 0;
 }
 
 static const struct clk_ops clk_ops_dsi_pll_7nm_vco = {
-	.round_rate = dsi_pll_7nm_clk_round_rate,
+	.determine_rate = dsi_pll_7nm_clk_determine_rate,
 	.set_rate = dsi_pll_7nm_vco_set_rate,
 	.recalc_rate = dsi_pll_7nm_vco_recalc_rate,
 	.prepare = dsi_pll_7nm_vco_prepare,

-- 
2.50.1


