Return-Path: <linux-kernel+bounces-726259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5234CB00A46
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98DAA647FC8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F04C2F2C6F;
	Thu, 10 Jul 2025 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrbD/Gu2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7F82F0E47
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752169423; cv=none; b=AikRrAPrjz3sHhKtGML4SO0cade0uKkPMB9ghOOJuo9iVtSLm+Fs9vK54cP8Gh/SRICYIZqEgPGflOO1KWTthakvcGQprClcg8nh5UG49ORSm6cfX1mUDt+jo2sEx2DplHIxG6BpJWWspMAwzvSZo3XeC6kdb/ruoyZ8NY+jTEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752169423; c=relaxed/simple;
	bh=QsQxnV5P1fb5ziwiaykq6XlQnnjBowQ0Qm5g74Jm8ZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B5ePg5r1Sj8v8rA3ZAeiGv7f+mmoewyI2zdczLt8heDL8wfvl5/r+96TcFAuyQV0SUXd/sqpvceUuPpVKksDHHxs7ch1zkCbBQBGI6O1yxPT1xxZ90Bg3YMGO/I91PW2gemW6pu5/f/1T3yKO8yr+bF51/xPSdaVVxaW2lLOzLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KrbD/Gu2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752169421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCUkHqw4OIJFHYNlmvSZg7Gb7N9mp6WEkDCfyaw9PXU=;
	b=KrbD/Gu2fvGtJgy2zR1l438LVyMU4wyCcF6aL7v3Np7P2LaWs1vVicnNvnJ5TfWS0punHj
	GT2pQ7poa1WZVXCL6aR9pK2zaLO6SPCo3fzk5uyitlTZQ+1pGJWl9FnyxNTWCLJvIdfMSr
	f8yW8SswwyqdIxmrM0tyw1VezZVUIwg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-rgW3_YWwMJyYxgJcIoEOsg-1; Thu, 10 Jul 2025 13:43:40 -0400
X-MC-Unique: rgW3_YWwMJyYxgJcIoEOsg-1
X-Mimecast-MFC-AGG-ID: rgW3_YWwMJyYxgJcIoEOsg_1752169419
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fafc9f3e1bso20590696d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752169419; x=1752774219;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCUkHqw4OIJFHYNlmvSZg7Gb7N9mp6WEkDCfyaw9PXU=;
        b=LdO4KIDl0jlLcmpiTfKBJUUThgh/XHSHuaA3pUyHVVMvfGvocvNQCPtVjfXUYVc6aS
         5JNsMS0cWhILDXjhk2LIieIV4RKzr7ppOFNWPBM1TVgjRuVg5uuXhCBtYEr9KhNE9Nbs
         mLkxNmjcHKArnosgRhd4pYf9ihjk9R3K6VTxIyFRTWDnsfFsl4U+YyeKxsNP8hvkPSj1
         opMlY3Tz7tgKSYioJuJLJO6cb9OHT39Lwdr3rhlGd48heKiDHJaWKlD3aHKxTW1M64rR
         tPScuTHxMGPw9CM851rjPynXegypTgrK6/3t2nndb04T2J3DZjK0ShU9k37pKgo8wiEM
         J/cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfYc7nCqplhfqL4RWOmf0Ft91FNailoV8uKvsTYkbr6vPuoXgGGcooYFJfhDhA5sq4bzlQYaPcukPrq+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxex8ZuQSQng5jO9PR2kJE6UtG36hZQt3jfHmY3NeITQvZIs0OW
	6nr0KsDhSY+rh4C0s0ekxccAA2/2sgFXZwfUgRARYFZJ2IB7w12AHUwn9odZwYHhG8g6LKnm2Zt
	QIU2R/B8xp8woZpizBbUEkbWLoQ96LqgnwRgGW5hbAPRv7jIlwZZNu1NTufUyXGD6Iw==
X-Gm-Gg: ASbGncsjrpC7MM9TFF4TptcvEG3x2iE/jcX5oLBuhccGJgaDWQnBPd13uvmn754LyYC
	10uimbUE7BdpGzXxkeUbN/ASUvD9SwaYUvxEQ9yffvjDtXVPP+RkYfh3Pcin9SBrvVW+1yJvBk7
	hLmiV9MPZm/xX1l0rHHMnMGbLb2shBtENNEw5p5HPyHGPZmoJhHtbIzO7fEW/8McTZ6o90vh2du
	fCm9rnokJDMOgHACpNefJixVfJei2T/91T4QWKBYaFcQOnMboi4zkzyr+rjvOINjDVOTHn9ZHGb
	YiJyo09Jm07M2EJ7H+nCdMbFuyLPlcwrSX2ZCN33h6BK4c/Lyacp2byy6ubs
X-Received: by 2002:a05:6214:5883:b0:6f2:c88a:50b2 with SMTP id 6a1803df08f44-704a354cf6bmr4070126d6.3.1752169419288;
        Thu, 10 Jul 2025 10:43:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHT9fVCmhXOEcnhqu3VFHhqJP8lRdJ7DzuHPSbjh7k32ODCAsPCUcL2Z7QyeRoPgckrF6a+A==
X-Received: by 2002:a05:6214:5883:b0:6f2:c88a:50b2 with SMTP id 6a1803df08f44-704a354cf6bmr4069566d6.3.1752169418934;
        Thu, 10 Jul 2025 10:43:38 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d71419sm10652876d6.86.2025.07.10.10.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 10:43:38 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 13:43:08 -0400
Subject: [PATCH 7/9] drm/stm/lvds: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-drm-clk-round-rate-v1-7-601b9ea384c3@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752169393; l=2097;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=QsQxnV5P1fb5ziwiaykq6XlQnnjBowQ0Qm5g74Jm8ZQ=;
 b=Ksw8mIL+2RRN/KI5dE4mx3sGUsPAEzJtg6FBiWBslMJaF5i+drzv8/2cRkcR9a0IBfQcYS2SG
 tVJ/WPvWyYACv81xH4ZsEZ5zwtnc4MB29saRvfEdAfzM+LmC3xps5M8
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/gpu/drm/stm/lvds.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/stm/lvds.c b/drivers/gpu/drm/stm/lvds.c
index 07788e8d3d8302a3951e97d64736b721033998d3..fe38c0984b2b552e1ccaef4d1e589b9d86a40ee3 100644
--- a/drivers/gpu/drm/stm/lvds.c
+++ b/drivers/gpu/drm/stm/lvds.c
@@ -682,8 +682,8 @@ static unsigned long lvds_pixel_clk_recalc_rate(struct clk_hw *hw,
 	return (unsigned long)lvds->pixel_clock_rate;
 }
 
-static long lvds_pixel_clk_round_rate(struct clk_hw *hw, unsigned long rate,
-				      unsigned long *parent_rate)
+static int lvds_pixel_clk_determine_rate(struct clk_hw *hw,
+					 struct clk_rate_request *req)
 {
 	struct stm_lvds *lvds = container_of(hw, struct stm_lvds, lvds_ck_px);
 	unsigned int pll_in_khz, bdiv = 0, mdiv = 0, ndiv = 0;
@@ -703,7 +703,7 @@ static long lvds_pixel_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 	mode = list_first_entry(&connector->modes,
 				struct drm_display_mode, head);
 
-	pll_in_khz = (unsigned int)(*parent_rate / 1000);
+	pll_in_khz = (unsigned int)(req->best_parent_rate / 1000);
 
 	if (lvds_is_dual_link(lvds->link_type))
 		multiplier = 2;
@@ -719,14 +719,16 @@ static long lvds_pixel_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 	lvds->pixel_clock_rate = (unsigned long)pll_get_clkout_khz(pll_in_khz, bdiv, mdiv, ndiv)
 					 * 1000 * multiplier / 7;
 
-	return lvds->pixel_clock_rate;
+	req->rate = lvds->pixel_clock_rate;
+
+	return 0;
 }
 
 static const struct clk_ops lvds_pixel_clk_ops = {
 	.enable = lvds_pixel_clk_enable,
 	.disable = lvds_pixel_clk_disable,
 	.recalc_rate = lvds_pixel_clk_recalc_rate,
-	.round_rate = lvds_pixel_clk_round_rate,
+	.determine_rate = lvds_pixel_clk_determine_rate,
 };
 
 static const struct clk_init_data clk_data = {

-- 
2.50.0


