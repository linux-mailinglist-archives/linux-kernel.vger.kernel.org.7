Return-Path: <linux-kernel+bounces-762437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DCFB2069C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBD7818C0C13
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C6427FD4A;
	Mon, 11 Aug 2025 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vlbpd4d1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A05A2777FC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909799; cv=none; b=oQ4d5FyVy/Vxku3jUh/mt99W8HOytZxKzh7dX/CN5V3dP3j3gxNRbR23d8vjKXoK7TGd0Sxa8+b0ROhbzbputvF4jIzbFATHtaEmMwvtf73TiVZ5AfE3x6bWXfxXRnVA8imiTcrYQ7i0VNHMvI4Mn5IsylpG4JcLoaqlgSNcK8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909799; c=relaxed/simple;
	bh=9BXAN9WaQXGACsWVgeakYqAdywyzgmh/IMziqVvQDEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=feG+erUSKcictVpk8SKXpKSx006tiJFQc34/dPV7k+3vsu5u0HmI6teTwYL77Fbr71ApAt/tmTUZGwBc1JrpVDaHNhmm1t6oWAaBs0icpD/26974QJP1ZVbh9Mc5RZ3D889+CMiqIv+oMcdn8RTvDLn+VrgQa0x1t2lFbt2jJ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vlbpd4d1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754909794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tWkAq+ld75LwDG/hGRVHHPxuHrsiy/sV3D7XIB1FZRs=;
	b=Vlbpd4d1GWLigeSUtZRUv6DKjNBdXibb4g9JbYbVitRrPiFoji9hYKRStDLadmK5tBebGE
	O8pfANZy2JB4mvj9zgRNWtcrWGCIF4PAp5CDs9jbUW2m0xzVyPlEO/n0D/CWyW+5FVEsWZ
	+c3yXwS/mQYrfBi/vxjzhSLMtzshwp4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-q7yZ1fVnMLCPexlK8n0geA-1; Mon, 11 Aug 2025 06:56:33 -0400
X-MC-Unique: q7yZ1fVnMLCPexlK8n0geA-1
X-Mimecast-MFC-AGG-ID: q7yZ1fVnMLCPexlK8n0geA_1754909792
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e696444d0cso1003465085a.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754909792; x=1755514592;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWkAq+ld75LwDG/hGRVHHPxuHrsiy/sV3D7XIB1FZRs=;
        b=Ny85lYCkdUcyxkobjxDxqfiogxdAHjdss2BoBC6pdtlznGQyM886eRPwzpU3Qwxhg0
         E9YbUUuNZ61ykD0yEjCH4PuZ/9oZn9RHcqt1RvQAOnVRkh3Itu9PwH6JxV4Q7nY6laj+
         K55Sj/2uLOl6Y1SDVYQ1J9Smc1EYK1iOnT5k442yjHDkenJokxD4DK5lLxcV3O943vX1
         KcXVF6B+ymeSk3sAI9tMI2CB1Cn8ncH3p0VQPfTxzJX0PGu0loidVUU1vF93HmFXHZ03
         yA5HrJ0BfD22ucolY8oKOPzr9DX/RXk1ZKGpXLQoBqHthm8c49C4MDq0YuxzqVhUnRbJ
         +9yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuiUupo2AbKAhvYglcIQL8uJv7xmhYGInzfhheB6qKm6VUFsG7hciu7pVboSkiKCbPaCJMFZliEIDrJ2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwG8hUaiJQ4PZBNw9VCoYCXMkdR+FC/T4npPpJFS9Qm8jxBZsJ
	BPlIZq1ZBH8uoXCdR1jxC02/Qy1nDDXczCH58IrG5IPR1oCMZ0PLyG/L6sF+vTrf7/b9u2F6JGD
	/SjXtebYBjSuX/w5RdyrUCmxRdPphK33GRgHfaxjx9PQX3E5BBpunrENvGJKxDhNYiQ==
X-Gm-Gg: ASbGncvQsMuEe92bFpDnPaN+2d2BAmYqn3HpfrpIvjSMopVWTQnwrWbC+b0cLFdZClq
	Y9hO9XNnNbt6O2xJ7xiG8M+hQVtVBEYYwdD+UGybVxvJQ5drITptL+AmnAZ6m6a19ASuGhbsjM8
	DzppxKg+2sxhkEgPbpVcnUifehu8TiiGl9TDxbENvyKRoqyKD6K6N2BIQQuuK1P+sc/LQb0O7tv
	JlksNOmCVSa1WoGsOMSej2KT6rFfF37jrUeAK3P9CWw8kV207Pm2pLd20TIsAEZCzDGpKsJnD8J
	LFXISKWP1ms+eiEFmuIea+AtrJFy6qK2V70YbBIddZ3zwieSaClGotevs8WsuBdFy7YWBDW1rki
	2d1E=
X-Received: by 2002:a05:620a:45a3:b0:7e6:9a4f:a299 with SMTP id af79cd13be357-7e82c646f33mr1843251585a.16.1754909792392;
        Mon, 11 Aug 2025 03:56:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgW8gZJYQbVSn9A8dMelBcES9raZpoqJep5i7D+EdYN7YXUJOpmuR1qZ1AM51jM57roxoq8Q==
X-Received: by 2002:a05:620a:45a3:b0:7e6:9a4f:a299 with SMTP id af79cd13be357-7e82c646f33mr1843249285a.16.1754909791988;
        Mon, 11 Aug 2025 03:56:31 -0700 (PDT)
Received: from [192.168.1.15] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e698de2df7sm1273446485a.80.2025.08.11.03.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:56:31 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Mon, 11 Aug 2025 06:56:06 -0400
Subject: [PATCH v2 2/9] drm/mcde/mcde_clk_div: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-drm-clk-round-rate-v2-2-4a91ccf239cf@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754909781; l=1730;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=9BXAN9WaQXGACsWVgeakYqAdywyzgmh/IMziqVvQDEg=;
 b=ylupjg1fmCNBXXxO3X3BdCWItZxz3hbcUzYzU1GUNiNNWUiYrAb17RJCYD00k/EMPQMfWhWKC
 RXc0CDE9VnwCgzocNA8sHN+o4QXxCM6UpLGynPKDC6JbO0dbhiFFntj
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/gpu/drm/mcde/mcde_clk_div.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mcde/mcde_clk_div.c b/drivers/gpu/drm/mcde/mcde_clk_div.c
index 3056ac566473487817b40f8b9b3146dbba2ae81c..8c5af2677357fcd6587279d58077d38ff836f0c0 100644
--- a/drivers/gpu/drm/mcde/mcde_clk_div.c
+++ b/drivers/gpu/drm/mcde/mcde_clk_div.c
@@ -71,12 +71,15 @@ static int mcde_clk_div_choose_div(struct clk_hw *hw, unsigned long rate,
 	return best_div;
 }
 
-static long mcde_clk_div_round_rate(struct clk_hw *hw, unsigned long rate,
-				     unsigned long *prate)
+static int mcde_clk_div_determine_rate(struct clk_hw *hw,
+				       struct clk_rate_request *req)
 {
-	int div = mcde_clk_div_choose_div(hw, rate, prate, true);
+	int div = mcde_clk_div_choose_div(hw, req->rate,
+					  &req->best_parent_rate, true);
 
-	return DIV_ROUND_UP_ULL(*prate, div);
+	req->rate = DIV_ROUND_UP_ULL(req->best_parent_rate, div);
+
+	return 0;
 }
 
 static unsigned long mcde_clk_div_recalc_rate(struct clk_hw *hw,
@@ -132,7 +135,7 @@ static int mcde_clk_div_set_rate(struct clk_hw *hw, unsigned long rate,
 static const struct clk_ops mcde_clk_div_ops = {
 	.enable = mcde_clk_div_enable,
 	.recalc_rate = mcde_clk_div_recalc_rate,
-	.round_rate = mcde_clk_div_round_rate,
+	.determine_rate = mcde_clk_div_determine_rate,
 	.set_rate = mcde_clk_div_set_rate,
 };
 

-- 
2.50.1


