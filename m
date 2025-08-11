Return-Path: <linux-kernel+bounces-762441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECF2B206A9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1B1918C0E05
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3006228C035;
	Mon, 11 Aug 2025 10:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+W2sHlO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23D8261593
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909809; cv=none; b=ZjmQSpncpxzGPQ0K1idkWwTF4SmSPIqyF4eauOQGUoGO7gHn2opiG2CcwXBzxhlbV1UQHrw/oVNDiGd2MswZO2Vn1ZUlCsGJYrJ/8ATBy6+Gpl7oOn0Uyqk1WE/6S4FH3/yOQpwX0tJR0hr2T5MeCs+cr/6NGE4t+td0fhHrZsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909809; c=relaxed/simple;
	bh=TQX7y0WLJPoT2FXW3ljOONLbYB3hMMDCH4wBpr8HvE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G5EDhDulocdOJL44WC5NOl5vg4QMkPD9T9aszy6fCu4vimRgZZDtLa0mcUMDssK7x+J3Vv14dmTz1Sh/QFpD/mPuhEGJ1CoWOEj+9NFUaBr41N3cOtmxLQCbUxGOPVmL+iFVn61gDGAFNaO1+JGKRDu0vJtAbDTjLpdOkoq8Bqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+W2sHlO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754909807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fe1/zFdrNglpQdcc7DcZ0ub2lnvduP/lEo2aekbxLh4=;
	b=A+W2sHlOsiYlkc6hjXR76yphB9YU0IaXThzauHDVMcgplUya7cqsxSOur1tNQ8tjmI/NQX
	2sNCaMm++tH50bdv3GJfTecO/VQR9HJ3rtjZ/LD+sBg3txcE//dKIdtkgmQn9qE17//3cF
	FSgJ5Txbx5e7hQ65knPZbxZ9GH9NspA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-VOzexD_qPdiH3sGX4vf8KQ-1; Mon, 11 Aug 2025 06:56:45 -0400
X-MC-Unique: VOzexD_qPdiH3sGX4vf8KQ-1
X-Mimecast-MFC-AGG-ID: VOzexD_qPdiH3sGX4vf8KQ_1754909805
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b076528c4aso46245351cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754909805; x=1755514605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fe1/zFdrNglpQdcc7DcZ0ub2lnvduP/lEo2aekbxLh4=;
        b=Bf9zNNZUe6NunVTeOoFy3oS5nsEGNhImQ/VqFjJsRpfGTwitoLASgC3e+SyYNj8IEA
         xHHoyKDdLLJEvX/hza2m4AQ63CkWi6MigYa08MPbQjxpFKz9BmBJusz9JZXRcezX6K+F
         yR0tTkclei6WtuUEevx7okyZa+ddxPFk4JM+ioLG6UF8QTvganNTxgrIipQZR6jbJhTb
         4Bnvr/qfkIMvlkw1s2q965TYnzbD/hVVuCPVdupdZVvnz9Cu7N9IG0y2NvdEp52YsOMW
         ioumWo2pSgCi7oFGSlE+QoVRnJVvZX8C47Klj0c/59dD6MvtzCn+gmbthS+KHHYQPfBh
         a5rQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1+QVfHj0RV6qBW0EGcCHG/fe2dJk1QU2e4GQyxN6ifvApblM8jYMlTQNGSyl1xGhTHaYzJfrLll7e14k=@vger.kernel.org
X-Gm-Message-State: AOJu0YybaEFmsGDCkH/wuINSs0VxNQIMbeEv+YkE5ISD8Fm+F2y3XRrl
	aodCnOFQQlqn75t2p//vhvGar603ledYhylwnFXcKd19dvEnWw2m+1f3SXHGLxAo1iFYhLm/kFo
	zthfAhnFMYsTzEsMNy4739mMtsQgtNY999XX2ykwe48wGLAOUvXzom9r7Qk4NvIvp9A==
X-Gm-Gg: ASbGncvj6sfoJrXUTJ+H2skXxGqpWG7bmsOtphS7+TZXBXyKkgjobfWOSB7s5D2k3/0
	Z4prAnQyfAS21RW2UdHLCYsq5d63YpEi1YegNFtdbtlohA/9X2HlxCjRgZkwpQv5+4Mn0Y5vAEM
	NSnH8wz3l9P+l04KCbatsl91Y/F+eAxkNZcJeTXL8ZKqX2jfRqaIy5yU/uLd6gpCuPL3gDTTim1
	P4rrUJhjvU8W+TjJy+LMMZSRWbgLUbWaDYN2xv3ULhOpX96RHNVlNVCRkUpoqk6lJ6ym0DCrQhH
	hKQJ1K0k4nsw2K9vDOPOaMTvtjKDFLa178Ayq05Rs6LMzrvSoO3KaooYF7Kh4BG+xTW3WNiYhrE
	vU8M=
X-Received: by 2002:a05:622a:164b:b0:4ab:81c7:b992 with SMTP id d75a77b69052e-4b0aee0416fmr177626521cf.41.1754909805237;
        Mon, 11 Aug 2025 03:56:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH84pkBd6GJf8XCR9+s0wYsjRXbW3CjMG1+xiMebELRnnC0y+m6C0KXWBUqdNOSAQDFJQ+q/g==
X-Received: by 2002:a05:622a:164b:b0:4ab:81c7:b992 with SMTP id d75a77b69052e-4b0aee0416fmr177626021cf.41.1754909804709;
        Mon, 11 Aug 2025 03:56:44 -0700 (PDT)
Received: from [192.168.1.15] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e698de2df7sm1273446485a.80.2025.08.11.03.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:56:44 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Mon, 11 Aug 2025 06:56:10 -0400
Subject: [PATCH v2 6/9] drm/stm/dw_mipi_dsi-stm: convert from round_rate()
 to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-drm-clk-round-rate-v2-6-4a91ccf239cf@redhat.com>
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
 linux-sunxi@lists.linux.dev, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754909781; l=2470;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=TQX7y0WLJPoT2FXW3ljOONLbYB3hMMDCH4wBpr8HvE4=;
 b=lgrz8b1APu4kFbIpIygfaPAMyZa9PSq0qCqlA9d2JnXNchMfPplzKOoa7IYJs93TVO9unUYBZ
 Y9qrAO5hmIoCqBBrlG0p/QgoeneH78eck1EdJ9ad2HPr3tup0+0Nd5I
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Acked-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
index 2c7bc064bc66c6a58903a207cbe8091a14231c2b..58eae6804cc82d174323744206be7046568b905c 100644
--- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
+++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
@@ -274,8 +274,8 @@ static unsigned long dw_mipi_dsi_clk_recalc_rate(struct clk_hw *hw,
 	return (unsigned long)pll_out_khz * 1000;
 }
 
-static long dw_mipi_dsi_clk_round_rate(struct clk_hw *hw, unsigned long rate,
-				       unsigned long *parent_rate)
+static int dw_mipi_dsi_clk_determine_rate(struct clk_hw *hw,
+					  struct clk_rate_request *req)
 {
 	struct dw_mipi_dsi_stm *dsi = clk_to_dw_mipi_dsi_stm(hw);
 	unsigned int idf, ndiv, odf, pll_in_khz, pll_out_khz;
@@ -283,14 +283,14 @@ static long dw_mipi_dsi_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 
 	DRM_DEBUG_DRIVER("\n");
 
-	pll_in_khz = (unsigned int)(*parent_rate / 1000);
+	pll_in_khz = (unsigned int)(req->best_parent_rate / 1000);
 
 	/* Compute best pll parameters */
 	idf = 0;
 	ndiv = 0;
 	odf = 0;
 
-	ret = dsi_pll_get_params(dsi, pll_in_khz, rate / 1000,
+	ret = dsi_pll_get_params(dsi, pll_in_khz, req->rate / 1000,
 				 &idf, &ndiv, &odf);
 	if (ret)
 		DRM_WARN("Warning dsi_pll_get_params(): bad params\n");
@@ -298,7 +298,9 @@ static long dw_mipi_dsi_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 	/* Get the adjusted pll out value */
 	pll_out_khz = dsi_pll_get_clkout_khz(pll_in_khz, idf, ndiv, odf);
 
-	return pll_out_khz * 1000;
+	req->rate = pll_out_khz * 1000;
+
+	return 0;
 }
 
 static int dw_mipi_dsi_clk_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -351,7 +353,7 @@ static const struct clk_ops dw_mipi_dsi_stm_clk_ops = {
 	.disable = dw_mipi_dsi_clk_disable,
 	.is_enabled = dw_mipi_dsi_clk_is_enabled,
 	.recalc_rate = dw_mipi_dsi_clk_recalc_rate,
-	.round_rate = dw_mipi_dsi_clk_round_rate,
+	.determine_rate = dw_mipi_dsi_clk_determine_rate,
 	.set_rate = dw_mipi_dsi_clk_set_rate,
 };
 

-- 
2.50.1


