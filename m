Return-Path: <linux-kernel+bounces-790926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF68B3AFD8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 941425E440F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B7619E7F7;
	Fri, 29 Aug 2025 00:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVYP7bXw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE16620E314
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 00:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756427932; cv=none; b=TqlJKgOsvPRTddMoHx+JqXFyZzLt1+HY+90M2sE8V2BntQElJopcewwsfBbmN15RuHjqg3CdkXFGVqx5QQeY6/Ut8Oz4efLdfLO5N7XImnp5TM2hTyxya2LR8wwUM/HN/mnfZqfZ5wyuHtV9+85KpnC9q2srMJi7uWfSwdLmuYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756427932; c=relaxed/simple;
	bh=77mT8lxlHfMf8DpsPLJTC4LdP2OKAfcaRTXAq7sQvCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bvcFBtoXPSuvpFL8TG4ZI1xyccyJ6me3HbcBiyEUxHlwq6S4KcSJPr7R/z2UifDkXZHJNJHCoKev6HORggB73coxnQZ7n8w3ta1ZjrB9jLaBv21+8KxgI75RMx/rg1/IKZnK28jluz4/SdIiK6mrjT4WpwPA1cZm7/P67NButVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OVYP7bXw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756427929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FWlxamEZBABa/bI8LuC0OjVu3fNQXV2BqGZu8lwg93s=;
	b=OVYP7bXwkTesYtWbR6mM6AlCOuZ/CRBtRDW83E6pUG1shFTuOZlLKGqPRhS33K3QFikCiO
	tVSOKdPU8t4kSCQmwyZTq5JzdD5cvAIfk/SSGmG78FDwJK2WzTEbvzMANny/vIqoEmftLy
	ud/IVjbPAaI5XeIZZSVv9bsu+zLOv1Y=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-zjGYCCxPOquaKd6obUd1aQ-1; Thu, 28 Aug 2025 20:38:48 -0400
X-MC-Unique: zjGYCCxPOquaKd6obUd1aQ-1
X-Mimecast-MFC-AGG-ID: zjGYCCxPOquaKd6obUd1aQ_1756427928
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70dd6d25609so40292116d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756427928; x=1757032728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWlxamEZBABa/bI8LuC0OjVu3fNQXV2BqGZu8lwg93s=;
        b=mhzIJMOfTwyVl74+s4y/FT824C7vTUwCBheawak9jYAYth1rghpaXTKMnaztYsVe7Y
         vvTE2syGMy+ipDHm+y51YeYkqsKVs6xn84coEtpxrp+VpSm/JdDS2lMpBk9srDEAcCZt
         fHbCP+2DMIytb+wiDLpdbe+/8AlhNjdUHSnqLtT8e3Y4l9/dxrEKZ0sFdnPjifFSKipa
         gqk1FVhohvmXq8EqAGbvJpjUW7dBckQFr5t14U6t0npXePoSxOF2nlgBPnHfHu7v8Oqh
         tQBgPO++qlQV5mR9jIkTJf96xvv3rx5Se4jFnAuWBfU04hMusmVA8tPwDX07N8cZ3ryn
         7kDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+Aj+lGCI7Jus0LREnOQIqIvp9jyZdwkaPG1hvx+OOVdjVN5CZuGWcaUYhuoyM9iXLkBTCz9muyfjFqnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3kZ/j0M5/GzFHPvncNa7URfMyAWgmmBoTqyAWxSU68UIMOGWh
	Qrq6O4p/Q/wSp2eIqKaxgA9BHmJ8RGOgOCdJqQ8Pq6Zo2Dp95xQ113KPWp8bhPI37SjA42A2ZTR
	5q6wzrZYRhbEuCcLeOvpQU0RWuSZxrQ4upamXjeeEYfF7XGAfTsNkQew5qbLVuX1skQ==
X-Gm-Gg: ASbGncu0sMW1phdIZuZ0DRi6AaIlAH4iDTdjOAj6ShVLNV0dxmuEaSayGnRnJcHDuh1
	rL41s88cRV5w1WPrx+SYfVEnBf0DcgjusW7/sK/GG6TTy6ahKTfYjOjlJM3xm1WXIaGKZakL4k3
	oBKMnPu8u1z6iZqUttco2JBpl/GXVPv0K2w4k68sKGVoHu3cDnwJp7ks53qBRjsBhTes8E0Y4WL
	vg9++2BK//Y7FiXOGw6GDX9FPa5MYj6byEhl59oI0xeGNpxkOxT+EBji+V8sZB65ATfbWxP5OD4
	zeRr1V2/9v76QktjYIYTcekKNi3+rqp9Cz3OzRQSP3K2E1ezxFDf5392utEJiK2hGNwm0I/+iyD
	Y/UZ1h3lKqKTqiyH/gkdMSChJDrp2iuzYfg==
X-Received: by 2002:a05:6214:769:b0:70d:fe59:7449 with SMTP id 6a1803df08f44-70dfe597674mr27992236d6.61.1756427927618;
        Thu, 28 Aug 2025 17:38:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdFHJee0qbyUjnxuiLN/Oq1qdZlcxXPT+mkBSQmGVwNZcP/pQI/tabzwXXU/AzIdm5XAEiew==
X-Received: by 2002:a05:6214:769:b0:70d:fe59:7449 with SMTP id 6a1803df08f44-70dfe597674mr27992056d6.61.1756427927178;
        Thu, 28 Aug 2025 17:38:47 -0700 (PDT)
Received: from [192.168.1.2] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70e6264141asm5588696d6.65.2025.08.28.17.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 17:38:46 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 28 Aug 2025 20:38:23 -0400
Subject: [PATCH 4/8] clk: rp1: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-clk-round-rate-v2-v1-4-b97ec8ba6cc4@redhat.com>
References: <20250828-clk-round-rate-v2-v1-0-b97ec8ba6cc4@redhat.com>
In-Reply-To: <20250828-clk-round-rate-v2-v1-0-b97ec8ba6cc4@redhat.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Bjorn Andersson <andersson@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Andrea della Porta <andrea.porta@suse.com>, 
 Maxime Ripard <mripard@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756427914; l=5547;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=77mT8lxlHfMf8DpsPLJTC4LdP2OKAfcaRTXAq7sQvCc=;
 b=3gMx5iuOgrCwNi+DCXX7JQxOvLwFiVApn+7Bvb0HH6OCc8cBz7oI4PL5ZGPz6XlAL7fZhaSTw
 0t/u6mMD55zBBJ4Vh8Qfol7XUf066XGn9A4V2i5zqigVDsEhG7+J6Un
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/clk-rp1.c | 58 +++++++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/clk-rp1.c b/drivers/clk/clk-rp1.c
index e8f264d7f34e42f7186dbba31e5ace95d67b9a7d..fd144755b879862612ea5e22e913dbb44a140033 100644
--- a/drivers/clk/clk-rp1.c
+++ b/drivers/clk/clk-rp1.c
@@ -532,13 +532,16 @@ static unsigned long rp1_pll_core_recalc_rate(struct clk_hw *hw,
 	return calc_rate;
 }
 
-static long rp1_pll_core_round_rate(struct clk_hw *hw, unsigned long rate,
-				    unsigned long *parent_rate)
+static int rp1_pll_core_determine_rate(struct clk_hw *hw,
+				       struct clk_rate_request *req)
 {
 	u32 fbdiv_int, fbdiv_frac;
 
-	return get_pll_core_divider(hw, rate, *parent_rate,
-				    &fbdiv_int, &fbdiv_frac);
+	req->rate = get_pll_core_divider(hw, req->rate, req->best_parent_rate,
+					 &fbdiv_int,
+					 &fbdiv_frac);
+
+	return 0;
 }
 
 static void get_pll_prim_dividers(unsigned long rate, unsigned long parent_rate,
@@ -616,18 +619,20 @@ static unsigned long rp1_pll_recalc_rate(struct clk_hw *hw,
 	return DIV_ROUND_CLOSEST(parent_rate, prim_div1 * prim_div2);
 }
 
-static long rp1_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-			       unsigned long *parent_rate)
+static int rp1_pll_determine_rate(struct clk_hw *hw,
+				  struct clk_rate_request *req)
 {
 	struct clk_hw *clk_audio_hw = &clk_audio->hw;
 	u32 div1, div2;
 
-	if (hw == clk_audio_hw && clk_audio->cached_rate == rate)
-		*parent_rate = clk_audio_core->cached_rate;
+	if (hw == clk_audio_hw && clk_audio->cached_rate == req->rate)
+		req->best_parent_rate = clk_audio_core->cached_rate;
+
+	get_pll_prim_dividers(req->rate, req->best_parent_rate, &div1, &div2);
 
-	get_pll_prim_dividers(rate, *parent_rate, &div1, &div2);
+	req->rate = DIV_ROUND_CLOSEST(req->best_parent_rate, div1 * div2);
 
-	return DIV_ROUND_CLOSEST(*parent_rate, div1 * div2);
+	return 0;
 }
 
 static int rp1_pll_ph_is_on(struct clk_hw *hw)
@@ -677,13 +682,15 @@ static unsigned long rp1_pll_ph_recalc_rate(struct clk_hw *hw,
 	return parent_rate / data->fixed_divider;
 }
 
-static long rp1_pll_ph_round_rate(struct clk_hw *hw, unsigned long rate,
-				  unsigned long *parent_rate)
+static int rp1_pll_ph_determine_rate(struct clk_hw *hw,
+				     struct clk_rate_request *req)
 {
 	struct rp1_clk_desc *pll_ph = container_of(hw, struct rp1_clk_desc, hw);
 	const struct rp1_pll_ph_data *data = pll_ph->data;
 
-	return *parent_rate / data->fixed_divider;
+	req->rate = req->best_parent_rate / data->fixed_divider;
+
+	return 0;
 }
 
 static int rp1_pll_divider_is_on(struct clk_hw *hw)
@@ -760,11 +767,12 @@ static unsigned long rp1_pll_divider_recalc_rate(struct clk_hw *hw,
 	return clk_divider_ops.recalc_rate(hw, parent_rate);
 }
 
-static long rp1_pll_divider_round_rate(struct clk_hw *hw,
-				       unsigned long rate,
-				       unsigned long *parent_rate)
+static int rp1_pll_divider_determine_rate(struct clk_hw *hw,
+					  struct clk_rate_request *req)
 {
-	return clk_divider_ops.round_rate(hw, rate, parent_rate);
+	req->rate = clk_divider_ops.determine_rate(hw, req);
+
+	return 0;
 }
 
 static int rp1_clock_is_on(struct clk_hw *hw)
@@ -1166,10 +1174,10 @@ static unsigned long rp1_varsrc_recalc_rate(struct clk_hw *hw,
 	return clock->cached_rate;
 }
 
-static long rp1_varsrc_round_rate(struct clk_hw *hw, unsigned long rate,
-				  unsigned long *parent_rate)
+static int rp1_varsrc_determine_rate(struct clk_hw *hw,
+				     struct clk_rate_request *req)
 {
-	return rate;
+	return 0;
 }
 
 static const struct clk_ops rp1_pll_core_ops = {
@@ -1178,13 +1186,13 @@ static const struct clk_ops rp1_pll_core_ops = {
 	.unprepare = rp1_pll_core_off,
 	.set_rate = rp1_pll_core_set_rate,
 	.recalc_rate = rp1_pll_core_recalc_rate,
-	.round_rate = rp1_pll_core_round_rate,
+	.determine_rate = rp1_pll_core_determine_rate,
 };
 
 static const struct clk_ops rp1_pll_ops = {
 	.set_rate = rp1_pll_set_rate,
 	.recalc_rate = rp1_pll_recalc_rate,
-	.round_rate = rp1_pll_round_rate,
+	.determine_rate = rp1_pll_determine_rate,
 };
 
 static const struct clk_ops rp1_pll_ph_ops = {
@@ -1192,7 +1200,7 @@ static const struct clk_ops rp1_pll_ph_ops = {
 	.prepare = rp1_pll_ph_on,
 	.unprepare = rp1_pll_ph_off,
 	.recalc_rate = rp1_pll_ph_recalc_rate,
-	.round_rate = rp1_pll_ph_round_rate,
+	.determine_rate = rp1_pll_ph_determine_rate,
 };
 
 static const struct clk_ops rp1_pll_divider_ops = {
@@ -1201,7 +1209,7 @@ static const struct clk_ops rp1_pll_divider_ops = {
 	.unprepare = rp1_pll_divider_off,
 	.set_rate = rp1_pll_divider_set_rate,
 	.recalc_rate = rp1_pll_divider_recalc_rate,
-	.round_rate = rp1_pll_divider_round_rate,
+	.determine_rate = rp1_pll_divider_determine_rate,
 };
 
 static const struct clk_ops rp1_clk_ops = {
@@ -1219,7 +1227,7 @@ static const struct clk_ops rp1_clk_ops = {
 static const struct clk_ops rp1_varsrc_ops = {
 	.set_rate = rp1_varsrc_set_rate,
 	.recalc_rate = rp1_varsrc_recalc_rate,
-	.round_rate = rp1_varsrc_round_rate,
+	.determine_rate = rp1_varsrc_determine_rate,
 };
 
 static struct clk_hw *rp1_register_pll(struct rp1_clockman *clockman,

-- 
2.50.1


