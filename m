Return-Path: <linux-kernel+bounces-726492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE72DB00DA2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A221CA4B34
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E1B302067;
	Thu, 10 Jul 2025 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRefkhYZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B914E302066
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 21:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752181932; cv=none; b=HsFq8UKKaVbGiLKYJ+yX4Pi2c6z6BpdD5VBj/8iEny+lJfP+XLF0ncbuQIa61b7shBZ5UKyOLkY5Md4DToeJJTCC80KRB/TJrbQyZjCqKp7E+UhVIhHfqKmbuSuUcKF3ead5tbqk6aOzvV+Hby/B/ac87intcx6iN+7Ih3JV52g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752181932; c=relaxed/simple;
	bh=eYghFW8p4DYIUBCaUWp+/iE+HslCUlPDg0t9I+XyN/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HZhVwbEjIJWcaj7+11jyOZCZKdwAhEEndSAIfib5Q+JxB14V67IMklXvB17qjKNu0HVFUx+q/GwUfLVGmRU27rs3yqYr1iO5lXjNsz5XLGt8wWo3IWcqAkxA8yp2PpzMAtEVs08lXYwLbvePA5hmdlDAGiKJl699JHZFrVi9GKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dRefkhYZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752181926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RMxn3qGVHET6C9gd+BL5oIIz2htkls+w6noefj8NRsw=;
	b=dRefkhYZeD9b8MQ6Wox6ZYPS9fLCUrkgVSVLq6QtbyuJzvCwBtQko7fikVC16iUowfV8HU
	e+b2oqmVqfq44nbA2EzSGtAQ88kwlapi+uIhlq8D7ZXuLBcgPJByOhLNm4BXOGMr/pqbtY
	QraLzEXmIj+MN+Rn2TQKpJzY2m0fZAY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-brVTJ3K6NLidYhHrpT-1Vg-1; Thu, 10 Jul 2025 17:12:04 -0400
X-MC-Unique: brVTJ3K6NLidYhHrpT-1Vg-1
X-Mimecast-MFC-AGG-ID: brVTJ3K6NLidYhHrpT-1Vg_1752181924
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31215090074so2348552a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752181924; x=1752786724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMxn3qGVHET6C9gd+BL5oIIz2htkls+w6noefj8NRsw=;
        b=BPAdUHSxZGL5E9XOsKypD4HMSm/KfYZRZRO997zl7q4Gm5LTP2g/IOPVON7D8oGqp/
         zzxI6Kq0B1+G4TlLQANvN6DNtDXtN6qMlFCWsowPPlLHWrLbNT2c77j/P0DCEBdysQiu
         Uu/C/InfgXK4CbtSpmp1fMBLkLlQnSYlvy1u2WxuqqzzH4p0bNkRsndGO2T7xiNfJHrr
         ZbJlu1AKlw+4crnP9v3xMyJfDHgs9lcSb+RvrzYu+GRFXDfDRG5/VB1hed1NupF0M3XI
         IQgZDr5ISDz0UohhwDKGBMcKuMJLla1e/ZG86fPNHORSj0AsSYh3UTswXdXSx5BKqU1v
         UveQ==
X-Forwarded-Encrypted: i=1; AJvYcCXInerEQu7OwmCq2B72IPcgJ2f7ACsGMSgqJ2J9ng3J4KzPap12wA+Zbt9/Mxt8r0kuObwYTaGiYyUipmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy54dxcq9Fp5csERRkbU1sjF/ZMtZ5XzQqNJ8zqQEyzEFPTalq8
	Hvu3eS8J2oBvQhDDfG7oiUEcKH8AgY0bAyo4bJIQfwwnGhWhRQNutkH6doBbTwHuIDQRxRHP9Rp
	AZpSW5WBPMXOumR8lKse0u0Ic3QfJJx39GcljOn3sFJpYeOp0uCHNiK2YqBa5pvpgaw==
X-Gm-Gg: ASbGnct/WkgfKpXpHQaLVc3eyB0kxiREvzWrmIZFfHl3z2X7B4CgUoqf7xniW7hJEpN
	OdyFav1MUWOK65UmKPMWzPAMSTZ/aFM6TCYlMpcN6pX+8H6/si7X4k5N6pR3z/TByRrVq7nSDRG
	wtuhkqxTY12JpKzxmsEfcQCj5ybdajAE/m90v6m59R89pITqJTzo4vdzuR+5W8b36q5EgpaSLeb
	ZQEC2VwlwOnSc3jAVXlCDHq0Pn5LnNzsk6q2NJ+/2X+cfjl7lieIGJOfxn7fURFY1urnH87VHT+
	wM7qEqP5Y3ctKuewOllUdshwxVEA
X-Received: by 2002:a17:90b:4b83:b0:311:e8cc:4248 with SMTP id 98e67ed59e1d1-31c4f5d782fmr181001a91.33.1752181923696;
        Thu, 10 Jul 2025 14:12:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZJwG4kbKUPKJJw9NlPg14COmpPc23m7MFfrg7F5+Wtg/2WFXr5ADA1o8ZCRL9BuYnk5dhrA==
X-Received: by 2002:a17:90b:4b83:b0:311:e8cc:4248 with SMTP id 98e67ed59e1d1-31c4f5d782fmr180978a91.33.1752181923366;
        Thu, 10 Jul 2025 14:12:03 -0700 (PDT)
Received: from [10.144.155.224] ([2600:382:7716:65ad:9491:c054:6f2d:80ed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de433e51asm27790595ad.180.2025.07.10.14.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 14:12:02 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 17:10:44 -0400
Subject: [PATCH 12/13] clk: imx: pllv4: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-clk-imx-round-rate-v1-12-5726f98e6d8d@redhat.com>
References: <20250710-clk-imx-round-rate-v1-0-5726f98e6d8d@redhat.com>
In-Reply-To: <20250710-clk-imx-round-rate-v1-0-5726f98e6d8d@redhat.com>
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Maxime Ripard <mripard@kernel.org>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752181866; l=3218;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=eYghFW8p4DYIUBCaUWp+/iE+HslCUlPDg0t9I+XyN/I=;
 b=GlygFKUJrkVpwE7GHwRPUG7uDzpRjwh+PDyr1kcDB3zP0XEHH7Gkt8tVur2GVkNuwZ24eg+r7
 k/5dyQToeGkBYWaTeEwsUjiUla04efU+hrImZBsDIo9uilD8+vVwD3U
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/imx/clk-pllv4.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/imx/clk-pllv4.c b/drivers/clk/imx/clk-pllv4.c
index 9b136c951762c23cb7424405e1a66ec70af57d5c..01d05b5d543852c9eb48d1ae2b63e8f32b4f4a89 100644
--- a/drivers/clk/imx/clk-pllv4.c
+++ b/drivers/clk/imx/clk-pllv4.c
@@ -95,11 +95,11 @@ static unsigned long clk_pllv4_recalc_rate(struct clk_hw *hw,
 	return (parent_rate * mult) + (u32)temp64;
 }
 
-static long clk_pllv4_round_rate(struct clk_hw *hw, unsigned long rate,
-				 unsigned long *prate)
+static int clk_pllv4_determine_rate(struct clk_hw *hw,
+				    struct clk_rate_request *req)
 {
 	struct clk_pllv4 *pll = to_clk_pllv4(hw);
-	unsigned long parent_rate = *prate;
+	unsigned long parent_rate = req->best_parent_rate;
 	unsigned long round_rate, i;
 	u32 mfn, mfd = DEFAULT_MFD;
 	bool found = false;
@@ -107,7 +107,7 @@ static long clk_pllv4_round_rate(struct clk_hw *hw, unsigned long rate,
 	u32 mult;
 
 	if (pll->use_mult_range) {
-		temp64 = (u64)rate;
+		temp64 = (u64) req->rate;
 		do_div(temp64, parent_rate);
 		mult = temp64;
 		if (mult >= pllv4_mult_range[1] &&
@@ -118,7 +118,7 @@ static long clk_pllv4_round_rate(struct clk_hw *hw, unsigned long rate,
 	} else {
 		for (i = 0; i < ARRAY_SIZE(pllv4_mult_table); i++) {
 			round_rate = parent_rate * pllv4_mult_table[i];
-			if (rate >= round_rate) {
+			if (req->rate >= round_rate) {
 				found = true;
 				break;
 			}
@@ -127,14 +127,16 @@ static long clk_pllv4_round_rate(struct clk_hw *hw, unsigned long rate,
 
 	if (!found) {
 		pr_warn("%s: unable to round rate %lu, parent rate %lu\n",
-			clk_hw_get_name(hw), rate, parent_rate);
+			clk_hw_get_name(hw), req->rate, parent_rate);
+		req->rate = 0;
+
 		return 0;
 	}
 
 	if (parent_rate <= MAX_MFD)
 		mfd = parent_rate;
 
-	temp64 = (u64)(rate - round_rate);
+	temp64 = (u64)(req->rate - round_rate);
 	temp64 *= mfd;
 	do_div(temp64, parent_rate);
 	mfn = temp64;
@@ -145,14 +147,19 @@ static long clk_pllv4_round_rate(struct clk_hw *hw, unsigned long rate,
 	 * pair of mfn/mfd, we simply return the round_rate without using
 	 * the frac part.
 	 */
-	if (mfn >= mfd)
-		return round_rate;
+	if (mfn >= mfd) {
+		req->rate = round_rate;
+
+		return 0;
+	}
 
 	temp64 = (u64)parent_rate;
 	temp64 *= mfn;
 	do_div(temp64, mfd);
 
-	return round_rate + (u32)temp64;
+	req->rate = round_rate + (u32)temp64;
+
+	return 0;
 }
 
 static bool clk_pllv4_is_valid_mult(struct clk_pllv4 *pll, unsigned int mult)
@@ -229,7 +236,7 @@ static void clk_pllv4_unprepare(struct clk_hw *hw)
 
 static const struct clk_ops clk_pllv4_ops = {
 	.recalc_rate	= clk_pllv4_recalc_rate,
-	.round_rate	= clk_pllv4_round_rate,
+	.determine_rate = clk_pllv4_determine_rate,
 	.set_rate	= clk_pllv4_set_rate,
 	.prepare	= clk_pllv4_prepare,
 	.unprepare	= clk_pllv4_unprepare,

-- 
2.50.0


