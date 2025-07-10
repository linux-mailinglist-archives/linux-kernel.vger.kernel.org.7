Return-Path: <linux-kernel+bounces-726489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598B9B00D9A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64EFA642282
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E689C2FF48C;
	Thu, 10 Jul 2025 21:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MX09eYRj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE762FE36C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 21:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752181914; cv=none; b=t9H5HLkZ47/RAQJjc2j5281oOpxYSdXpW9xbD/ZFG8gVLN0pgOPCiA+k/4DA0TJHG2TN9b9OM45ZvK55epTgntnc4sJ8uWa/PTm5xQFn6i+SPxBz2t92VayRn4tX5aKeCXJ1qR6dzUJUmyet/400F5b2+CsKvBpleCB4T8z/5NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752181914; c=relaxed/simple;
	bh=aywQz3CZ88oGIjl+zurv8EjAlYsjmJHyCtCGc5sgpww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dgxFdfEVSO07WKtirgg/rmB3docHHxCB7f1t6eYhNDwKmqpUXCBFzaznxjv0/0FfZ4CpqL8dtHUFtLyld9uCl/rI8Ld54L/up05huzibeLWAI2HOLKveFqQOD2nPbRqRtRNU3rhXLrBT7rmgK5MZJXTvxUkCLHUszH9UxzoI6Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MX09eYRj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752181911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kjELThxpzzAvI7EJgV2b+8qPZQoyQvdgHTrpH+0vcqA=;
	b=MX09eYRjay9Peoj/ERlhZIQHxHtprqCZeDL4g7A6MBzG70F26DtpeXzijFHbmuRfCF5IgO
	7idXbl4Xzz8KhykNmWkhdlPcxiCPCwZ5Q0nJBXPQDS2tecO6wVUGlTz/w7v1pcMVXXU8kZ
	eZSnP09jrajFKsmg60CWcrDq0M7cuTo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-eVCMvvmvPB-kPEvTTWmlzA-1; Thu, 10 Jul 2025 17:11:50 -0400
X-MC-Unique: eVCMvvmvPB-kPEvTTWmlzA-1
X-Mimecast-MFC-AGG-ID: eVCMvvmvPB-kPEvTTWmlzA_1752181909
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-235e1d66fa6so13037395ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752181909; x=1752786709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjELThxpzzAvI7EJgV2b+8qPZQoyQvdgHTrpH+0vcqA=;
        b=EQvVamTZjSkbO30K9AP3nV5kKtS1mklSpjHR702w2zHoyLjbBzWS8W8kTdGr4aEDE1
         mj+vejjjjq9RPeM+a/7T8xumTXdkmQF1GP5xAfM+AO01J9LaWMGCIlB6H4fj4h8pPUBK
         pvP0NT/Q2p6cEAARBu0H+uB+QZ+dS7zV9Aq45GX56l8FfIaMtMSdfY6ZOUNvl9ntQ7VX
         JCTjiauDRlGEYiHfsW9d8wrW+5Ktlxw4OQ7dAp1lh4GfSrgyNusQaUlhqWw2T3pC70e6
         d1/cVislP1xNNqzAukJUch9h0tlExYTVE7kI7DaD7u58Fq1roGWNpAzWvCRTmuUgHbZC
         VMWw==
X-Forwarded-Encrypted: i=1; AJvYcCUD1UaaB79HFuOXguXsWov1wbJalaPHPiyMnyrE+qWhlvArwsDjSkw7Wxb3EoFT+Jh/U+QDHGY+ipVr9EY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNffk4n5+uH2+bSPRKAZbJiXrrCYPLBiB6XJucE6cXretpao74
	ybPdJRotJr4igbs3Xj4ULxnmWah1RqIpKIlbzALFfssOX5b8LlSuK8dstnDWmHQKxrhOIBKWf9P
	U7V1nCj1GRjobYLpLFORfW2M9QnlVhnXHEpZNue8XhJFPJI0Ic8KOjcHNHI2LxBGsYw==
X-Gm-Gg: ASbGncvfBUbqkmEzLtZgrEbDRnjkcIBzREYGFXZJ6aVRzlU8J9mZ1eFxtFncZzCsoNj
	57VgArCFY7q9QzDyzRcxyZJj6Ela0EE5kmE0Xy6h7buARlpv5YXPs3EEE8Ol0E3+vvUChBrsPVd
	Lu9gPeTFulBh8QOeYOydntHvpW2lEKIRXSy4ABHz6IKlNSu27sarUi0lz2i7V50SfIHtz9l7fqE
	NhpoSzIey2RCUro83pzTevx9gCAY5zgeowc15IDDwuLjuIBQ6bpIo07whRDY6gjTZW9P7Yuxd3e
	6UujjJ2ejyM34Q+HJU92tmgrTHmQqCItW3heuLMOpia8cA==
X-Received: by 2002:a17:903:1ae3:b0:22c:3609:97ed with SMTP id d9443c01a7336-23dede890e9mr8285935ad.30.1752181909511;
        Thu, 10 Jul 2025 14:11:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECK3Rh9qQPkxPSM0R/QYf7bGscsWItQHb+tVdgkQkXMbgAQUKK5B8ZCSq9eX+Hd7XEABkBBA==
X-Received: by 2002:a17:903:1ae3:b0:22c:3609:97ed with SMTP id d9443c01a7336-23dede890e9mr8285715ad.30.1752181909173;
        Thu, 10 Jul 2025 14:11:49 -0700 (PDT)
Received: from [10.144.155.224] ([2600:382:7716:65ad:9491:c054:6f2d:80ed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de433e51asm27790595ad.180.2025.07.10.14.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 14:11:48 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 17:10:41 -0400
Subject: [PATCH 09/13] clk: imx: pll14xx: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-clk-imx-round-rate-v1-9-5726f98e6d8d@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752181866; l=2836;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=aywQz3CZ88oGIjl+zurv8EjAlYsjmJHyCtCGc5sgpww=;
 b=t0asgbTbAH8KoNuVVM39DzXSGvl//TC0qYGt737gsaK5wItf91xeznIgnO8ZL9Jjocs20L418
 bxN9ze5HEUKDU6gnMLUSNH3r8xYrx3TkODx4d9fg01mSEbjxDTrtl65
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/imx/clk-pll14xx.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index f290981ea13bdba3602af7aa44aaadfe0b78dcf9..36d0e80b55b80385a065808916187d6d4c30137c 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -216,8 +216,8 @@ static void imx_pll14xx_calc_settings(struct clk_pll14xx *pll, unsigned long rat
 		 t->mdiv, t->kdiv);
 }
 
-static long clk_pll1416x_round_rate(struct clk_hw *hw, unsigned long rate,
-			unsigned long *prate)
+static int clk_pll1416x_determine_rate(struct clk_hw *hw,
+				       struct clk_rate_request *req)
 {
 	struct clk_pll14xx *pll = to_clk_pll14xx(hw);
 	const struct imx_pll14xx_rate_table *rate_table = pll->rate_table;
@@ -225,22 +225,29 @@ static long clk_pll1416x_round_rate(struct clk_hw *hw, unsigned long rate,
 
 	/* Assuming rate_table is in descending order */
 	for (i = 0; i < pll->rate_count; i++)
-		if (rate >= rate_table[i].rate)
-			return rate_table[i].rate;
+		if (req->rate >= rate_table[i].rate) {
+			req->rate = rate_table[i].rate;
+
+			return 0;
+		}
 
 	/* return minimum supported value */
-	return rate_table[pll->rate_count - 1].rate;
+	req->rate = rate_table[pll->rate_count - 1].rate;
+
+	return 0;
 }
 
-static long clk_pll1443x_round_rate(struct clk_hw *hw, unsigned long rate,
-			unsigned long *prate)
+static int clk_pll1443x_determine_rate(struct clk_hw *hw,
+				       struct clk_rate_request *req)
 {
 	struct clk_pll14xx *pll = to_clk_pll14xx(hw);
 	struct imx_pll14xx_rate_table t;
 
-	imx_pll14xx_calc_settings(pll, rate, *prate, &t);
+	imx_pll14xx_calc_settings(pll, req->rate, req->best_parent_rate, &t);
+
+	req->rate = t.rate;
 
-	return t.rate;
+	return 0;
 }
 
 static unsigned long clk_pll14xx_recalc_rate(struct clk_hw *hw,
@@ -470,7 +477,7 @@ static const struct clk_ops clk_pll1416x_ops = {
 	.unprepare	= clk_pll14xx_unprepare,
 	.is_prepared	= clk_pll14xx_is_prepared,
 	.recalc_rate	= clk_pll14xx_recalc_rate,
-	.round_rate	= clk_pll1416x_round_rate,
+	.determine_rate = clk_pll1416x_determine_rate,
 	.set_rate	= clk_pll1416x_set_rate,
 };
 
@@ -483,7 +490,7 @@ static const struct clk_ops clk_pll1443x_ops = {
 	.unprepare	= clk_pll14xx_unprepare,
 	.is_prepared	= clk_pll14xx_is_prepared,
 	.recalc_rate	= clk_pll14xx_recalc_rate,
-	.round_rate	= clk_pll1443x_round_rate,
+	.determine_rate = clk_pll1443x_determine_rate,
 	.set_rate	= clk_pll1443x_set_rate,
 };
 

-- 
2.50.0


