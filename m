Return-Path: <linux-kernel+bounces-726139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B42B008A9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E47BF54385B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9562F19B7;
	Thu, 10 Jul 2025 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyus2Otr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2D12F1995
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164881; cv=none; b=MRq6M6aM2UTQpEi2fYj5MMH5khh1ioL3Xm2CLBwqnt24M2qt5YQsZoH4aA5bvXWnVWSxXY207n7suHGIeHOZg26r5TucjuWc0N9f9hWUueNoTsMPrS4kVo5yp0GJXlKhkTFzAlGu3YmyyOn8dIxEMWEQ+b5a9SduFdv+koHX2sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164881; c=relaxed/simple;
	bh=LuIdTqZOB0IRg3CTS/bE+68lhiU63BV6cIYBbNqOn1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jjt2THfw3UxBvD/nIbOY8LJVsEXDXLzToI8xcrjLFUIohMFgVgy3IN/jGfrfX215F8JgKOFGRMepfTW37lVB9bB9FPGA7WiQ8yBc3VoVgsxvlkw2+NijBWswymmYfLUWjqhblBUWDKy2l78a/sXVIjfBZ5PpVDW5RHKlCVKdyfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gyus2Otr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752164878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m2sjN1873L1CKcSDssD7CQWNs9idoOcGFXZl6j2Le2Q=;
	b=gyus2OtrlxWRH8FIlnRImO3Otn1NsrMXidqEorx1z1WQ9/TMYjtW6UleLaR/7P4rR5ZWW8
	ymZ6ySuK2hwVUQv41bFJZHtRWk/o55oGXOh8HnJX4rfeZLuHzQw1N5dE5S0WPHblBzAyLq
	g0EXPbvSmMkYVzrLwpOiLiZwbgImodI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-ZC-wMknfP0mdNgL0w3P50Q-1; Thu, 10 Jul 2025 12:27:55 -0400
X-MC-Unique: ZC-wMknfP0mdNgL0w3P50Q-1
X-Mimecast-MFC-AGG-ID: ZC-wMknfP0mdNgL0w3P50Q_1752164875
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d44a260e45so213542485a.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752164875; x=1752769675;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2sjN1873L1CKcSDssD7CQWNs9idoOcGFXZl6j2Le2Q=;
        b=fIAFgfAsxKmHBRa8e3iGA4x0OsMeshJta3YAmKAujpnuvoJ2xZhC3XyvZSheu92FpK
         7qU+H8c7R9gijz4kSoQYTf/iZzYrElZKaS0Hs6GvSao28RtmfWGjJk7ueZqzbHiS29wW
         U6DK24ePhsjegsyfV04Irc90r266M18MK6scGqsNtWTPWd4Z+diVz5DGvUImxAN9VfqT
         qWwHXWHNNzugBVopEGRmRQkDX+FMkMPgwR5UvtbtSdi7RPmEBIsx7Ti1pKnHKCcx4+Mj
         1wAaOuH8fEld+GYKgCJMUDAOnolKAGfNuiLj2QLuAGTgYLMnvUUyEKncJr8FEDCBosxL
         /kIw==
X-Forwarded-Encrypted: i=1; AJvYcCUUXQ1P2YhNzoDu+Lwn17qde7l2RoxfLeyb9m8SxSPJYTezRZJ5NFhsmFMRaRW4NlyEteCWD/XWvljlIxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBKdrAJlPLm3YMhFajXiTY/DnAShr5rhlArmwJYmbhehZ3b7J1
	quwzCJ1I5SlzflswpcvwCSS3I/m/oejfwMz72uK500lGTClnV3wWN5iKWVBbwOBFHv3LHMUhnUP
	GJEE/b81rQXaVWTVy8B3Q8nKvWgvvMHP1heBjIuOYUJE2RsrtBCFZWrUMMHLNZ5koPw==
X-Gm-Gg: ASbGncvup9sF9cS+p3Qk69fhU9DcnOXrvuOzkGMdrt0uaS0N/DqjY/YFhG4Y9AIMVG+
	jYS9ayojOnJcxaoPinE4OCwfCrtO+ncFVQTqdjN1QEJ8Iz5ljYV55ZHLDR0TZNj7JPvplw35wu3
	WciYXZrSU5txYibaStGR4ZU7hSeBXfY6aJhw7yvFmuZMPS+Ij/mexyssT6PoRJz22h+mNO1VChb
	Sq/9/RgcF45l1cP1i7Nd/Tpve42TfNj55UjFyQ2Fdb75QsKNQsoWIBqp9uCa7gEK6W5lzGW6LCD
	RvWh+SKTA+JArUe5I8ybH0AlZrm3IbMPpHD9iTUCYDIShpnBlGvh67RGTpDq
X-Received: by 2002:a05:620a:6182:b0:7d5:db8a:22ea with SMTP id af79cd13be357-7dc99c97b06mr637918185a.13.1752164874732;
        Thu, 10 Jul 2025 09:27:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0LILioTmsFFFim3P7vjwaGEN2yDghNBYxo2rYKbBHf33eWtihemHAGlXYjN5wVdu8ijbLNA==
X-Received: by 2002:a05:620a:6182:b0:7d5:db8a:22ea with SMTP id af79cd13be357-7dc99c97b06mr637913285a.13.1752164874254;
        Thu, 10 Jul 2025 09:27:54 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdc5df99asm113487685a.49.2025.07.10.09.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:27:52 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 12:27:29 -0400
Subject: [PATCH 3/7] drm/msm/dsi_phy_28nm_8960: convert from round_rate()
 to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-drm-msm-phy-clk-round-rate-v1-3-364b1d9ee3f8@redhat.com>
References: <20250710-drm-msm-phy-clk-round-rate-v1-0-364b1d9ee3f8@redhat.com>
In-Reply-To: <20250710-drm-msm-phy-clk-round-rate-v1-0-364b1d9ee3f8@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752164864; l=3065;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=LuIdTqZOB0IRg3CTS/bE+68lhiU63BV6cIYBbNqOn1E=;
 b=f34Vu5Am3Epc8RhAvgL3lZpMgFt7lkFGSFFJPkt5Aq5xZNEfkcTpI3h6rM13pyuzPIwSSvM1F
 NgAw7WN4IMXByyDaw/F9whWSiB6hkeMO9L2CsMqwBUVASiJ/wkk3IUg
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c | 34 +++++++++++++------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c
index f3643320ff2f2bae5301bb94f1fe19fa03db584c..8d234685c1aa3d4579e3dc766c000de1909f87f6 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c
@@ -231,21 +231,21 @@ static void dsi_pll_28nm_vco_unprepare(struct clk_hw *hw)
 	pll_28nm->phy->pll_on = false;
 }
 
-static long dsi_pll_28nm_clk_round_rate(struct clk_hw *hw,
-		unsigned long rate, unsigned long *parent_rate)
+static int dsi_pll_28nm_clk_determine_rate(struct clk_hw *hw,
+					   struct clk_rate_request *req)
 {
 	struct dsi_pll_28nm *pll_28nm = to_pll_28nm(hw);
 
-	if      (rate < pll_28nm->phy->cfg->min_pll_rate)
-		return  pll_28nm->phy->cfg->min_pll_rate;
-	else if (rate > pll_28nm->phy->cfg->max_pll_rate)
-		return  pll_28nm->phy->cfg->max_pll_rate;
-	else
-		return rate;
+	if (req->rate < pll_28nm->phy->cfg->min_pll_rate)
+		req->rate = pll_28nm->phy->cfg->min_pll_rate;
+	else if (req->rate > pll_28nm->phy->cfg->max_pll_rate)
+		req->rate = pll_28nm->phy->cfg->max_pll_rate;
+
+	return 0;
 }
 
 static const struct clk_ops clk_ops_dsi_pll_28nm_vco = {
-	.round_rate = dsi_pll_28nm_clk_round_rate,
+	.determine_rate = dsi_pll_28nm_clk_determine_rate,
 	.set_rate = dsi_pll_28nm_clk_set_rate,
 	.recalc_rate = dsi_pll_28nm_clk_recalc_rate,
 	.prepare = dsi_pll_28nm_vco_prepare,
@@ -296,18 +296,20 @@ static unsigned int get_vco_mul_factor(unsigned long byte_clk_rate)
 		return 8;
 }
 
-static long clk_bytediv_round_rate(struct clk_hw *hw, unsigned long rate,
-				   unsigned long *prate)
+static int clk_bytediv_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
 {
 	unsigned long best_parent;
 	unsigned int factor;
 
-	factor = get_vco_mul_factor(rate);
+	factor = get_vco_mul_factor(req->rate);
+
+	best_parent = req->rate * factor;
+	req->best_parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw), best_parent);
 
-	best_parent = rate * factor;
-	*prate = clk_hw_round_rate(clk_hw_get_parent(hw), best_parent);
+	req->rate = req->best_parent_rate / factor;
 
-	return *prate / factor;
+	return 0;
 }
 
 static int clk_bytediv_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -328,7 +330,7 @@ static int clk_bytediv_set_rate(struct clk_hw *hw, unsigned long rate,
 
 /* Our special byte clock divider ops */
 static const struct clk_ops clk_bytediv_ops = {
-	.round_rate = clk_bytediv_round_rate,
+	.determine_rate = clk_bytediv_determine_rate,
 	.set_rate = clk_bytediv_set_rate,
 	.recalc_rate = clk_bytediv_recalc_rate,
 };

-- 
2.50.0


