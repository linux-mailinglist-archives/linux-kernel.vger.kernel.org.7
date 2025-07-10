Return-Path: <linux-kernel+bounces-726487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A3DB00D95
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7926411ED
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194292FF465;
	Thu, 10 Jul 2025 21:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnPl4mGO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E656E2FEE38
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 21:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752181905; cv=none; b=aBsQoQi/kW+NuV+yWvUTQNk4AWUy9AC63Q6RpTnmcDkloCl/8KJiGaPWMLu2Ke448gm0Mr+ofr5DQ0nOymgj8SguhQM2hiM8O0u8tzVLEO6A/5PJh6+hiNs4fzdKYkU2DiGPPBCl9+MVGurrwOXR+6Nrka4VQx7DfIB79nuCF4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752181905; c=relaxed/simple;
	bh=NGioEqdKfaiC6BdH82T/f7jr0ImhDC6mx8MiIxU4MxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HJd6OeL9d7r4KyiBJkbGqt1yQ9cNwDKfmYSmbV54kttcit1VQUOx6a8RcxYndgAMAyxkw2IzOW9ZDdQcOTaZbgMdKF43LoQ0E2AGQouzcHUjVzQ5XWilcq+OzjrjyElj0UnWfXDlXG341T8nE/zvnBu84N+NEty3rLwQlwDBlEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gnPl4mGO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752181903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W339JZdcr7UmhBbOcIPiqXu+Gdd7sYxPv9WXyGXxLMY=;
	b=gnPl4mGO7mfNJtIerlB0w0w+v+0h20wChY6S6Hl2UvppITgmokgFLB8eY/TQHWbGxnz5Rw
	On/DHmfF7EzTSsWfOtdUOah8WK/NCQvDjb6Qfe/v5H/tOU7Gn5HfQNy27aWLwKrKZ35al1
	B7n6dgzyjC2ajMT9uAPWsQ8Gt7X+c3Q=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-Yb_vfNQcPRuWBO8McQeMUQ-1; Thu, 10 Jul 2025 17:11:41 -0400
X-MC-Unique: Yb_vfNQcPRuWBO8McQeMUQ-1
X-Mimecast-MFC-AGG-ID: Yb_vfNQcPRuWBO8McQeMUQ_1752181901
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-236725af87fso22667335ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752181901; x=1752786701;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W339JZdcr7UmhBbOcIPiqXu+Gdd7sYxPv9WXyGXxLMY=;
        b=RF8D1rxj0MhI4bRWF38OUeRVUw9jJLoyRVmUxfdrx0v8I9rvwDPwmlQbtosion6C7B
         soIsM6I26+6LTHXoDnqG1uMzN7iGJWi5Q3HfFDSFteu5h38lwA6kGWCTsEkUUuB3cXmw
         /H53o7NI+N9nnnJUMP4ZDU1WGqj9IIgdt6OsURtv+S8OitwrJB2qzrLVZj6Aao4GyS4Q
         DxFOzfZmqxZPuXXBSvZlJ5SWw3CnNWZANswmoFJ1DshixrtKeLfVKBHUpgK2UI1F3bQ+
         L66ogzWDnfTc2IPAGAIA4LpMqmtSFMmVKebcvyQN8erZBN/lIGrZfzkF03hyXRjdXFdL
         SXYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+Qo0uGslQvcJcY80XpncSi+g1CkrAPYoddG3i+iXCxKT3NdfstZ6SqetMWrqDBJGtJcin2U3Ml9MqzcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtUAz1Hss4NK1gqYPUfEOhoOthSjo6tk5dxbeqluQfrpPTtU29
	DpgJqLRZiOJqj2PODNPO2rHXYjKu/c/HuT1jJKgfHr8B6Sbp9+cswHgpzsP47ehiUVaSIOSAqqN
	NPSFxfJUuo8GLW7MfjftJjhE4cpqBUY5kXaUQ+Ivto3CBiS8qeM0GlPHHF7v/ExtCWg==
X-Gm-Gg: ASbGnctIFFe7NrwSx8q+SRVAzopgrj94GhoCrSfNVAWVo9bziTMl3n7aM1zxg3eOyXL
	RETulPin5ApUhq27rxCejBWiOMHsC2pOB2iSTqS1nhaaIsv9JJKtk0nPZ62Ao6X6R3DiOrHkX9E
	edKxMy4LAu4V4XzXx0fXBx7GYGL1J14VuxAnauhsRZjRUaz2IpemJruUUaUWT8yUmJ3aIAhtLy7
	8LaE5HVTV/fI+1DyHq8hPzuCxGl1r9Q4jn4aqzMyBAR7kfABIoi3bHlUaVcyoZm5NBr49l3jpvd
	PrDCj+j/Rm53Jxk7H2hzBCiBFI2aj9O+ST9m8lqIcv8ZEg==
X-Received: by 2002:a17:903:11c8:b0:234:cb4a:bc48 with SMTP id d9443c01a7336-23dede81d32mr8954745ad.31.1752181900880;
        Thu, 10 Jul 2025 14:11:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVxsG4cF9e07o0fMM8SypmofzmmXFkufyYymThzTUMbMJcOt8FiqD1GLXyQH26eIqaxdUn2Q==
X-Received: by 2002:a17:903:11c8:b0:234:cb4a:bc48 with SMTP id d9443c01a7336-23dede81d32mr8954465ad.31.1752181900538;
        Thu, 10 Jul 2025 14:11:40 -0700 (PDT)
Received: from [10.144.155.224] ([2600:382:7716:65ad:9491:c054:6f2d:80ed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de433e51asm27790595ad.180.2025.07.10.14.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 14:11:39 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 17:10:39 -0400
Subject: [PATCH 07/13] clk: imx: frac-pll: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-clk-imx-round-rate-v1-7-5726f98e6d8d@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752181866; l=1965;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=NGioEqdKfaiC6BdH82T/f7jr0ImhDC6mx8MiIxU4MxA=;
 b=vLaVKR/Gomur36zH3CqP5lEgRbRlTdzb1/EbzNsI0+mDIrE5MvniljGNo8RYbLE5lZaLSopai
 jwWqi5WbNQ1DJdufnQA1SGqyhwTLz/HV1JEu8Gcj2ppy3By4Yvi6s/v
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/imx/clk-frac-pll.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/imx/clk-frac-pll.c b/drivers/clk/imx/clk-frac-pll.c
index c703056fae85cca492b2edcfaadab58fd13c6b5a..eb668faaa38fd085f90bd1c01811e0deba5d0102 100644
--- a/drivers/clk/imx/clk-frac-pll.c
+++ b/drivers/clk/imx/clk-frac-pll.c
@@ -119,19 +119,19 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
 	return rate;
 }
 
-static long clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-			       unsigned long *prate)
+static int clk_pll_determine_rate(struct clk_hw *hw,
+				  struct clk_rate_request *req)
 {
-	u64 parent_rate = *prate;
+	u64 parent_rate = req->best_parent_rate;
 	u32 divff, divfi;
 	u64 temp64;
 
 	parent_rate *= 8;
-	rate *= 2;
-	temp64 = rate;
+	req->rate *= 2;
+	temp64 = req->rate;
 	do_div(temp64, parent_rate);
 	divfi = temp64;
-	temp64 = rate - divfi * parent_rate;
+	temp64 = req->rate - divfi * parent_rate;
 	temp64 *= PLL_FRAC_DENOM;
 	do_div(temp64, parent_rate);
 	divff = temp64;
@@ -140,9 +140,11 @@ static long clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 	temp64 *= divff;
 	do_div(temp64, PLL_FRAC_DENOM);
 
-	rate = parent_rate * divfi + temp64;
+	req->rate = parent_rate * divfi + temp64;
+
+	req->rate = req->rate / 2;
 
-	return rate / 2;
+	return 0;
 }
 
 /*
@@ -198,7 +200,7 @@ static const struct clk_ops clk_frac_pll_ops = {
 	.unprepare	= clk_pll_unprepare,
 	.is_prepared	= clk_pll_is_prepared,
 	.recalc_rate	= clk_pll_recalc_rate,
-	.round_rate	= clk_pll_round_rate,
+	.determine_rate = clk_pll_determine_rate,
 	.set_rate	= clk_pll_set_rate,
 };
 

-- 
2.50.0


