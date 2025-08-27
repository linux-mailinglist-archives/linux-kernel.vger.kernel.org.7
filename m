Return-Path: <linux-kernel+bounces-788661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E095BB38856
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F229D1B61D9D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D363304975;
	Wed, 27 Aug 2025 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WlTBnPdm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D21F301030
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756314753; cv=none; b=q7UC59hIGcmMbR25QcQybc5zrwqtGTv+8k2IOCfk0GuTkLxrl3ubpQB7LWGm/4cebMiTK01BTRxgL8QnqbB2bLjt5Px3bprZQ24/FwEFgTxs+9dGFXGs+aCVvL/jthIA5Hn+wvGFm5Lw4eMNteZx5AtzEJgXpsCV/GBJ8KGVKjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756314753; c=relaxed/simple;
	bh=ocvtdTl2hOZOQ/4oos7E0kZJWuxHuy23o8Wb53TCSIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WkkqzEcvFEwp4BHfXEpKPIErYh90KQroaFxB3JdBXI0vF1wmXBfAvtC/PviViAqwb1n6Z3dYSdKfkPU5BBetENo7nYY24sH+1OzV68gWS0PkiN3cwjn7iLUprr/gxUOv3lxrCWTkLsq5g3gdY6baXJFj0Z4JMmmEGCYyzNYFpoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WlTBnPdm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756314751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UBRt2ellMgrU2jWQCq6P6WpGbiIdthsHZnAXPTIGBXY=;
	b=WlTBnPdmNmcyvHwFu6C1QcOjhbL+BPPxWENxEXzYYSirJNJu+u9fI4R5v/OnOixDt3w8Eb
	Ug9ZZ7BZ5EBFos/OJlYVfjyow7Y5nPLXrlgbQmpYkRw1PR/updxN+3VEPVGgM3kVTUOVaC
	kW1qkNErHl+EbIeUH4vdoWxdmDyVhuk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-25y5q8_CP-6uLXxYi2bQXg-1; Wed, 27 Aug 2025 13:12:29 -0400
X-MC-Unique: 25y5q8_CP-6uLXxYi2bQXg-1
X-Mimecast-MFC-AGG-ID: 25y5q8_CP-6uLXxYi2bQXg_1756314749
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e87069063aso43152885a.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756314746; x=1756919546;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UBRt2ellMgrU2jWQCq6P6WpGbiIdthsHZnAXPTIGBXY=;
        b=EanBawkjeMAlnCdEdC8feI8WlF3+tAQidlnzwNsnrCiDQe6Zv1qEu3Aa9ss4eal73A
         bhEypFuXHp7Y6c7FgtspjvH/r9YLJWM9DGPIsqj70NDQo2werysqXy+iX05NBYM+iQT/
         G18jJ603HRiGn5z7+1GTF4/awj2SLCJwRE9WNFh0af9ijAtsg43hcf3I/AOSbrKTnirZ
         cTAhSNeOy8b3tatX0fB1FYD1K87MH1v2HLGqN8o/59VI3+4mfNsnq9Pa1BfiK0rlBLNz
         ueeavc65C0j46F639bG3talpjPe4TL8R14GgahR3lbF9mbqSK7gg/pL3CbNRtMGjv2ZT
         PtYw==
X-Forwarded-Encrypted: i=1; AJvYcCXmklQSkH6XW+sdjCVbTtzee/ATODYUp0a6Jcz1Xk9jrNLgONPRQlpAmUXY8i9yW3yPIXFBD46Jw0ym/NU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpUQRDeeu2U1PiBQ4lfT9PxneKaED2RmQCCXCLD40yCzKhVChz
	2Q6d2l1afzkqCOmnJHZskKRF1ZOMn4AxUUQxUi+AwyHh3pzlsIGR26K2ZYOxnTNMDijW+Dp64ct
	b07mQdRyboQJy6a4H/leLpnzOn2aWZhZ5v9UP+duRhvQcaTF0e/Hnh0G5M47q/YW2YA==
X-Gm-Gg: ASbGncv0J/KbxbAPBCv9q3Vh/+1WsvCoekMKFkqmFXErht8I9TIBWoA8QmHN9QWuh7i
	I8oo9LUtNKSqFHQqk+oFZA3AzOTdZunXCgaFdmn0uVDn+O1RY1gNWcmGe88SffZGRdGqFX6P8qP
	cR+sGAAj5nuh7melCZP477ZdvFbwBeQ7p0W4G3uCuVXmut7rKOspsH54+sR6ti7ZVpdjSlidVo/
	L92LtVUiAcZlmSxBEd4tnvZI0XrEkom7gbl6Hm2xlzaBIX1oTEQ/PjAE/gY5A8RP6pKnGshaYCI
	qie1y0v7w25QB/Ywo8MOOoZWlZOcKZ0+EdaphSWY94GpuTliB27EUJVCSrY8zz/rbj2KjFTOeRw
	8HnGTirvTWPmYqEVauJeZoraGFCEqFmiX1Q==
X-Received: by 2002:a05:620a:1920:b0:7f1:8b22:35b1 with SMTP id af79cd13be357-7f18b2235ecmr1243374685a.83.1756314746325;
        Wed, 27 Aug 2025 10:12:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDHgQzklZ25afIN2UyeYjisBxqH9PGDR2eAcGa4awGEaZEQH/Lm6l47YrGmmWNZAyud13+rQ==
X-Received: by 2002:a05:620a:1920:b0:7f1:8b22:35b1 with SMTP id af79cd13be357-7f18b2235ecmr1243369985a.83.1756314745803;
        Wed, 27 Aug 2025 10:12:25 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebf4a1cfe3sm887374785a.75.2025.08.27.10.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 10:12:25 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Wed, 27 Aug 2025 13:12:07 -0400
Subject: [PATCH v2] clk: scmi: migrate round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-clk-scmi-round-rate-v2-1-3782a50835ed@redhat.com>
X-B4-Tracking: v=1; b=H4sIAGY8r2gC/x3MTQ5AMBBA4avIrE1SRfxcRSyadjBByRSRiLtrL
 L/Few8EEqYAbfKA0MWBNx+h0wTsZPxIyC4atNKlqnWFdpkx2JVRttM7FHMQVpS7QjVNlhcGYrk
 LDXz/165/3w8ePB4OZQAAAA==
X-Change-ID: 20250827-clk-scmi-round-rate-7e3d4099134a
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756314744; l=3344;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=ocvtdTl2hOZOQ/4oos7E0kZJWuxHuy23o8Wb53TCSIg=;
 b=EUWRUgkqHWynVd1A4xl577sXaTq1HwLS666cge+27XtKzJ1tgwSvxjvJBVFfBZCaPJJV+FVrZ
 6+ZZlQE6K7YAopYkUFzodxnL2XGOChCHk9zD5shzQ0A1tzFxrW4Fqte
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

This driver implements both the determine_rate() and round_rate() clk
ops, and the round_rate() clk ops is deprecated. When both are defined,
clk_core_determine_round_nolock() from the clk core will only use the
determine_rate() clk ops.

The existing scmi_clk_determine_rate() is a noop implementation that
lets the firmware round the rate as appropriate. Drop the existing
determine_rate implementation and convert the existing round_rate()
implementation over to determine_rate().

scmi_clk_determine_rate() was added recently when the clock parent
support was added, so it's not expected that this change will regress
anything.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
Changes since v1:
- Split out individual patch from larger v1 114 patch series
- Drop noop determine_rate implementation; convert round_rate
---
 drivers/clk/clk-scmi.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index d2408403283fc72f0cf902e65f4c08bcbc7b4b0b..78dd2d9c7cabd18f2a05cffd0408cfefaf34fce0 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -54,8 +54,8 @@ static unsigned long scmi_clk_recalc_rate(struct clk_hw *hw,
 	return rate;
 }
 
-static long scmi_clk_round_rate(struct clk_hw *hw, unsigned long rate,
-				unsigned long *parent_rate)
+static int scmi_clk_determine_rate(struct clk_hw *hw,
+				   struct clk_rate_request *req)
 {
 	u64 fmin, fmax, ftmp;
 	struct scmi_clk *clk = to_scmi_clk(hw);
@@ -67,20 +67,27 @@ static long scmi_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 	 * running at then.
 	 */
 	if (clk->info->rate_discrete)
-		return rate;
+		return 0;
 
 	fmin = clk->info->range.min_rate;
 	fmax = clk->info->range.max_rate;
-	if (rate <= fmin)
-		return fmin;
-	else if (rate >= fmax)
-		return fmax;
+	if (req->rate <= fmin) {
+		req->rate = fmin;
+
+		return 0;
+	} else if (req->rate >= fmax) {
+		req->rate = fmax;
 
-	ftmp = rate - fmin;
+		return 0;
+	}
+
+	ftmp = req->rate - fmin;
 	ftmp += clk->info->range.step_size - 1; /* to round up */
 	do_div(ftmp, clk->info->range.step_size);
 
-	return ftmp * clk->info->range.step_size + fmin;
+	req->rate = ftmp * clk->info->range.step_size + fmin;
+
+	return 0;
 }
 
 static int scmi_clk_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -119,15 +126,6 @@ static u8 scmi_clk_get_parent(struct clk_hw *hw)
 	return p_idx;
 }
 
-static int scmi_clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
-{
-	/*
-	 * Suppose all the requested rates are supported, and let firmware
-	 * to handle the left work.
-	 */
-	return 0;
-}
-
 static int scmi_clk_enable(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
@@ -300,7 +298,6 @@ scmi_clk_ops_alloc(struct device *dev, unsigned long feats_key)
 
 	/* Rate ops */
 	ops->recalc_rate = scmi_clk_recalc_rate;
-	ops->round_rate = scmi_clk_round_rate;
 	ops->determine_rate = scmi_clk_determine_rate;
 	if (feats_key & BIT(SCMI_CLK_RATE_CTRL_SUPPORTED))
 		ops->set_rate = scmi_clk_set_rate;

---
base-commit: 3c642997252eef4449cb6b6e02af3dc22515d817
change-id: 20250827-clk-scmi-round-rate-7e3d4099134a

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


