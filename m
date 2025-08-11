Return-Path: <linux-kernel+bounces-762438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 501F2B2069F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CEC618C0C5A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BAB28936F;
	Mon, 11 Aug 2025 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ign7rONB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE5028853C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909802; cv=none; b=s9/et1OW7ZRj5mTtxKoEOUW2RBALgwi7kFoTrQwFggFczFKV5S1/tceC+GfS5A7hFv8+VJy1X2MtPMabKLoKIC8C7cOeZD3EduBpKYqU4rTW/qTIZzKvC4rscdQWj+H1T2Fww4k3OdjnCd1KGvIBvMZ3DeJXQ3DrapFcuPy5y8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909802; c=relaxed/simple;
	bh=QhsR7m95oQQJWiR4k5sEM+znPy8RVqMfVFdEDgPgP5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rsbQSE3OQz3WUaY7xmkyYxD43Grp+iLn1ZbCTdf4buOfiqhf1KeYb6TkDrpXgyQuulDoLmCRNcnXiWNdKA+STmj1tHVaej0NtPiL6q0Q5PxZ9HUumv2Yp+qzIH3aTyP3tQlOFNJe/dzfac6fJP4+c0sXyA9+ST8HJcUILdJrBwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ign7rONB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754909798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SmZ5OhIFbDNhhdemRjccJWJIhJ+GPeWDy3CnIwZY5Y0=;
	b=ign7rONBCv8z3tMyAs+qKJUu0MXZjnCRh0CxIGY4VW6cwVrbvxPktZ+NjBha8BYhod/fp3
	eX8fA8VKwPC00wrJOP7ARxBU3GfoxET0f4VmUXv7x2YaZADlIW7EyjmxUgDDidGyaqwgYQ
	691wPJinScKtuQ4SeQLct8tblcNmkCA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-4ntU-ryjPsCPk-qLiVqaYA-1; Mon, 11 Aug 2025 06:56:36 -0400
X-MC-Unique: 4ntU-ryjPsCPk-qLiVqaYA-1
X-Mimecast-MFC-AGG-ID: 4ntU-ryjPsCPk-qLiVqaYA_1754909796
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e69e201c51so996663185a.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754909796; x=1755514596;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmZ5OhIFbDNhhdemRjccJWJIhJ+GPeWDy3CnIwZY5Y0=;
        b=MKsfpCJh1oX+JKfuD8BQMQrCNg6r5SPAE2LhcPXkHgNc3Y19Vvpg4KMQFzYF3gVFDk
         9FHEhtFPCKeA+9LnkQstjPG5G1JFm6nVGecT4tsmN5omFZfCsgtEPyOsPEA483HVIHmI
         nFQFeJJ15hiShtL84P9OBuCctBkSJU3JmLRWC1l/zkpUUJNRgygunebmkySMIZJf7oua
         qRq4lQ8htm904hy4h+xtfG8ZOx4bOgDj+8ZS2JL/uobkAchHBadmHtwmGfmN5MiO2Mv4
         xkECxmNHRGdJjeLZ1R3VOOQaEtAFPnGgg0+74yFMWhChneXSuRPu6z8Z2fGQ5IsvKXgU
         sI6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzYaOuEOx6/zZzS3Ri70IrQBywN1w9BHzTf7u3G1fSDAtFWe+ULaUCdma6+KQn+bIuIdirPMHS8/ExQq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj2i7+CwwZ0JFlWaQyl9GCNonigO+0cadtsyD3hGromZbS7JOP
	iMaoidPibjdcsD7ig1HSqWXyGxJSXEJpzELal0o8jn0wEvU/7sHKrWC+s4DV3BWQAOichgs/NWg
	8kO84+tazxOUdbnn0wtF29KqkKEuikIuo0NaQa1TOGQPbKCrUGcyvNjKTra89dmgQ+g==
X-Gm-Gg: ASbGncu+NVD1ht0R+g+LXfGBygFBV3qFX3No7ED5dBNDr5HsNraQGRKQhn1GyhnCbQR
	J2hbnbsrUfH9PHS31EdfTA9DUdiDXtIXxi9csmvZC/gWn8t1ra7Y613rQ3QlbZvMeiQNz1d2p7d
	72a41oYyCHR+kh3u3TM7vKTgQBhEDn2jh2mn586HEx0VrGpLm1rqvyvcQbOG2nz96xnYInocdK3
	4LU1t0RxII8sXIG4fum4zYSJ6mVbv//TeHiy9HoeSMrRAUPqjIqAuyZIBXhLG+JVJnDuGAk7Nqk
	XIp3xs01tqyurKPQrXzP3SNySSN+WNAwCppNWDTy4F+gcj2MNYhhP6A/GWP7mW0t86elMPUMXCI
	r+aY=
X-Received: by 2002:a05:620a:2ae2:b0:7e8:23c1:f472 with SMTP id af79cd13be357-7e82c64cc0dmr1348329685a.3.1754909795614;
        Mon, 11 Aug 2025 03:56:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9n70Dnsh0oekI6lYBsj+g6fiHD2aJUNrf5ZRMtmoVkJvAZxcIb6V9PGnNEHDigLw+MQojEQ==
X-Received: by 2002:a05:620a:2ae2:b0:7e8:23c1:f472 with SMTP id af79cd13be357-7e82c64cc0dmr1348326285a.3.1754909795068;
        Mon, 11 Aug 2025 03:56:35 -0700 (PDT)
Received: from [192.168.1.15] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e698de2df7sm1273446485a.80.2025.08.11.03.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:56:34 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Mon, 11 Aug 2025 06:56:07 -0400
Subject: [PATCH v2 3/9] drm/msm/disp/mdp4/mdp4_lvds_pll: convert from
 round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-drm-clk-round-rate-v2-3-4a91ccf239cf@redhat.com>
References: <20250811-drm-clk-round-rate-v2-0-4a91ccf239cf@redhat.com>
In-Reply-To: <20250811-drm-clk-round-rate-v2-0-4a91ccf239cf@redhat.com>
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
Cc: linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-sunxi@lists.linux.dev, Brian Masney <bmasney@redhat.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754909781; l=1737;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=QhsR7m95oQQJWiR4k5sEM+znPy8RVqMfVFdEDgPgP5I=;
 b=Yf+/AEJVSVpYyfmQu4W8WyuhOAot3PpTJ66fonHG6NgwPWqhvr62JRFBH9lf6jrYZTbKGBwD4
 RLchj5Jj8AWD0/ZZRq0fRTK+W2ARhNi43oK0yq2QvGqqPc6Fg70Vyhk
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_pll.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_pll.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_pll.c
index fa2c294705105f5facbf7087a9d646f710c4a7fe..82e6225c8d491d44e30631cd5a442fb7c2de3f75 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_pll.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_pll.c
@@ -98,11 +98,14 @@ static unsigned long mpd4_lvds_pll_recalc_rate(struct clk_hw *hw,
 	return lvds_pll->pixclk;
 }
 
-static long mpd4_lvds_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-		unsigned long *parent_rate)
+static int mpd4_lvds_pll_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
 {
-	const struct pll_rate *pll_rate = find_rate(rate);
-	return pll_rate->rate;
+	const struct pll_rate *pll_rate = find_rate(req->rate);
+
+	req->rate = pll_rate->rate;
+
+	return 0;
 }
 
 static int mpd4_lvds_pll_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -118,7 +121,7 @@ static const struct clk_ops mpd4_lvds_pll_ops = {
 	.enable = mpd4_lvds_pll_enable,
 	.disable = mpd4_lvds_pll_disable,
 	.recalc_rate = mpd4_lvds_pll_recalc_rate,
-	.round_rate = mpd4_lvds_pll_round_rate,
+	.determine_rate = mpd4_lvds_pll_determine_rate,
 	.set_rate = mpd4_lvds_pll_set_rate,
 };
 

-- 
2.50.1


