Return-Path: <linux-kernel+bounces-726258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCA0B00A49
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7811C84992
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C922F2733;
	Thu, 10 Jul 2025 17:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIxkbYzh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3882F1FF6
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752169421; cv=none; b=fsbO3ZG+y9GCQ2FrKkqS9wLiC2HczDD7Nc9ver745RBpa9tsUkJDep+mduvBIbeRuaqNkB/X5cKrI1ZKTJfAbdojTzvkqlsuy32Xc2NMoP3E5N5Kpsg57oZJhCxJUlcaev0cfu1XlwgvlOHa9tT3q6oIz646a42+UXoaGlANm/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752169421; c=relaxed/simple;
	bh=zHcO3z3+e99osmKzMokPyvWC6/DSceppfY/05RlRXYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oi2xzKfTSqDRP+sOXs2+FxUzF4B1AwQyb86S30FFTDFox1hxDn0ZVRyneAMLK2r8q5PWjpXQN+hKcTiEKfIFVQLLYhKqxI+9ktyxy5tFgeqnyMQPDfGLD0GYUWeWwEIWyxG4W/G2u8ckaAP5olO2pBJLPtkiB0xboAzXKUkogTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gIxkbYzh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752169418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kaCFEBEkzEIEZX6+yQZzsmVx8NsnWbygGYV4RPX8K+w=;
	b=gIxkbYzhzJu9VXAhX0wu0qWinqNz/xR4w9iiOZTxiv+FyLatwWf3B6i73Rwg9HJFIsU6Fq
	XgljN4s7m+HJu5Kow/8aEnc2/vbjHtl+19UvZLc8tQCiPaobidwJYcfwVNuNY9M1W1CTq7
	NWrJnlIh52wp7Z0cEjnEhOI8kby0kq0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-r4_C8ZqONNmxWE-Lu3L7lQ-1; Thu, 10 Jul 2025 13:43:37 -0400
X-MC-Unique: r4_C8ZqONNmxWE-Lu3L7lQ-1
X-Mimecast-MFC-AGG-ID: r4_C8ZqONNmxWE-Lu3L7lQ_1752169416
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fb3654112fso21627276d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752169416; x=1752774216;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kaCFEBEkzEIEZX6+yQZzsmVx8NsnWbygGYV4RPX8K+w=;
        b=fBMS+sMygqJHnRD7u+MZhyvLy4aglYzSaNBsgn99p4GUMXxHFVViLk5JiGrtbLGEnR
         x/EMDSKpvuIhpZ6Apl7itpeLyRzHgTF0gznZ8+DLvNVV2f06jG3MFjJeNL1UCZftr1EX
         9KZkOs5z/ukeO1LLljcgcNgj0et8MeiNHehZ+j/2fvG83hsjcCT1bPlfNS9d/tsEP+2A
         XD7UWq2uBVR1xy6JVW/t6vI91B5s6EBa6KP1Gi4X6cuvhcLTafsshh/38GrTWrrbSljm
         yWuxVvxhw7EvdlPalGgMwTX+xwDYgG4tjc4TFZ85Yiw3PTRFiWA5hVplSt7C9YkWato3
         wviA==
X-Forwarded-Encrypted: i=1; AJvYcCWmF3qzupfn8QQ2ZueqhzEGFZELxiyiRsGNFOZfvWUOVaLuGZh5DWRQe8jES0F2QRMSilQZUDn+ujKTXEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSpla+nts+tIx6QnOA1jlisBvYCb7ah58FS/ma0NItIBijhu9r
	W1I9Qot6OTSinzcSoqy8b3RBjJy1ShjgfZAkxHOWwYlCe48rEkqyqCk8Or37J1S6NLB+JGet/SG
	VoY1ydUBJF+X6JS9AzB/y8Enr1sby9u65AHMNXHXcNRrUqc1S8mfUNlKiGstfkoBwug==
X-Gm-Gg: ASbGncupsBKXXB6b6s9r7O72HcoSLi3nwPmijITRjQgFupaBJatSlyzy7uj94YJLyjj
	3SapCo960Nlnt6M8ueg9qHw2A27DN0ynp1mpMaA9o8vWY8ZwSHrJTb9PFaYikIeC2vudTAdSE4t
	ShI5A0UZsxwt/6idQR7j8r2nSc9Ph9xKBAfknY0q/2KlUBfX0QqPx6bt+xNJ3GxDGL1F1xI6/ry
	VcICZRbmwyly02YfHSBqDATHDuy1PyCivz0V1p5cJ9QDxkh6L/9KcZvlsSWdK++j0zB7I5fAJWK
	Hd8YY4GpcH1CCJNYBp00UYeISnPh5A78XS/2iD+i9ZNwdG9rGM8hhozkvqD0
X-Received: by 2002:ad4:5f89:0:b0:704:7f0e:ca9d with SMTP id 6a1803df08f44-704a3885c2emr3440236d6.24.1752169416341;
        Thu, 10 Jul 2025 10:43:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSS2Rzm0JfKmIyrTldYCoa+GfaWxjePB16xygyyHje51M4cEE7holVyPZ8C5FzqtnGtvcUbQ==
X-Received: by 2002:ad4:5f89:0:b0:704:7f0e:ca9d with SMTP id 6a1803df08f44-704a3885c2emr3439666d6.24.1752169415753;
        Thu, 10 Jul 2025 10:43:35 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d71419sm10652876d6.86.2025.07.10.10.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 10:43:34 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 13:43:07 -0400
Subject: [PATCH 6/9] drm/stm/dw_mipi_dsi-stm: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-drm-clk-round-rate-v1-6-601b9ea384c3@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752169393; l=2405;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=zHcO3z3+e99osmKzMokPyvWC6/DSceppfY/05RlRXYo=;
 b=QXQyVz/ESQN/1lpuOY+kiAZj2ii+/13EpYKJAuvi9VgjSVMZZp3cWkyo089YF/6/d4LrccG+3
 IcOoOTC43L3AvbwBhN/wVyDOB1m1IcbEamuqRU2PQsvtkEzD5/kz2nO
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

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
2.50.0


