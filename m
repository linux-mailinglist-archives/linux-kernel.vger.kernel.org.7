Return-Path: <linux-kernel+bounces-762642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0289AB20944
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50783188EF1B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735792DEA61;
	Mon, 11 Aug 2025 12:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ERqRWZ1J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373282D3A94
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916533; cv=none; b=Eb4sRtpkINeme+fGHBg5D9HFVH+Rz28p/OtI/O5uccQNLkOGxaL92e3H4fbjimWNvkxtWnotN0tEsbbFRywAoLKnGWIKo0t0E1sC08YLT06Nz9cR3xjjmgHIpwUTgu4kvCT/zkFBPE+LXDMZV4lRi/7nCfL+EPZMbT3Gpkj3Dbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916533; c=relaxed/simple;
	bh=35dv85IMLqZUQXMLmdKz9Cv7IO7JQIrFzXOoEzRX50w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mJpSpjyj2k9xtFSFlFIXbw0MEm+FjlQeWk7kjo/tALpnPBEYtHpRT/peerzdoeQr2TVFZSfz+nDru/FN4gBpGTjiBbO6KL/5kLZ4sPhU1w2y7y5Rl4ss+/0jASsiru/WV+27Ovq1xmoDvluXHiOsCweOGWiO/o1N24k7Lt5IE9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ERqRWZ1J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754916531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BtyPh5Rep6ndb1ie2bs8QMsXOPj7v24ITj6+XUeoPUQ=;
	b=ERqRWZ1JRftZqxILYSSdVFrtPeE2XqMeQEL/zbTO+V3Gq68LKTrPkfn4xFG3F0H+mFQt8M
	Z8CyQSczqL8h5oYuWatgNBqMj95MI4BxLXe2OvTaurWRmbhuLgORGwLO0WFI/aZfGo/jxY
	CwqtnEeYpoW72bte3MtiRzc4ZVIUO3M=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-Kup5UJKYPNesNRzcINiL5w-1; Mon, 11 Aug 2025 08:48:50 -0400
X-MC-Unique: Kup5UJKYPNesNRzcINiL5w-1
X-Mimecast-MFC-AGG-ID: Kup5UJKYPNesNRzcINiL5w_1754916529
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4af1a20cbcfso114441301cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754916529; x=1755521329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtyPh5Rep6ndb1ie2bs8QMsXOPj7v24ITj6+XUeoPUQ=;
        b=hz3mSXO8bz+KAv2F43di8OTQ4aSPVbjX/oZUXvdgMbv/RUi4ljD4vns7/jYuOnUXWJ
         +dK7D6jNBF0BWHuHt9ShQXI85U8w07SPFBtI14JUnuUPXoRANCgXFFKxmsfw545RFb19
         +a80pXjLlQBX2Nl8jYTyL0kbfQ/6DK/+hVn1Szmd9ANaMeHXiRHHT8YAH+kwG4/kQ73c
         K4D7GFkfIM/Pyc2G8alAsY7xjr827KMW+j3YHBsZDsBK/JZR7zrdEtOsl4dTOysAe6UC
         mO7drxO9wJTYte+G+h4Hu7Y+Nt6CLWXmlTPQiLlfvPF9FlOcmeDwWoHM8g0GVX6o4NdL
         BfSg==
X-Forwarded-Encrypted: i=1; AJvYcCUhNmGWdx4F05FZRKWvPZCG4xKKUKJp/67ZRQMNUdzeZ1K7AQIpux6c6ONtLwbH+R0R7XQVxdfXw5Gt+Lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKWN+tgvEfPb/S0h56hErd+qHmtcSqstFsJpKmap+lplANwaqT
	gSvMFS7tz/aX3sC6ymyXeiVmAc5hz8IUFr5eGwmgRMrCUGiI5v97lfErWtW95g+zwaQfFGK63qa
	5A6pf0sgIfBPnqcit4FQleSlvY3Z6RDdSchRBIntA4HG09nmuuP8Na5y8ccdVGEgq1Q==
X-Gm-Gg: ASbGncvTp0wUmkvSdt/ZmOm6QgnZrpkug6L8FBfiUWNiDJrHMEM7FmxWdoCc1HGSjQn
	maGG5YDEkUvkDKc8ShR5WtRvLRnrgRRujdh73nVZEr4ylUhLJuJUFpO+QnKixyU6icq6t9nCksz
	K602g1bJAesb3FI2J5q7+H0efZFudcqh4BHNFq/0xMa5m0vbnOOuf9MNwDfGVODp45GNjzA4+JO
	x7BHQDXVaDIFGOCeIrA+j+DAdSp0ftDRK/BycjCtoD6tCV0F0bbW7MJBJapxtmGi7k1CSD6+1bh
	PTIfi54jDB9TiZfRhOXQgs1YqMY8kdwwFaW3ts4pgmtIyx0UEB+90dKKS8+uehUR3ypLwz/qPUn
	oHXA=
X-Received: by 2002:ac8:5acd:0:b0:4b0:38b2:3808 with SMTP id d75a77b69052e-4b0aedfe2fdmr162633001cf.43.1754916529302;
        Mon, 11 Aug 2025 05:48:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOFYaboytdNKOBRzhLoN9MZffA8UmKe9qe34eqfRP8OtsDONwuXkIVTkk9L+30HMgM/cyS1Q==
X-Received: by 2002:ac8:5acd:0:b0:4b0:38b2:3808 with SMTP id d75a77b69052e-4b0aedfe2fdmr162632611cf.43.1754916528836;
        Mon, 11 Aug 2025 05:48:48 -0700 (PDT)
Received: from [192.168.1.15] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aef746b6efsm138724001cf.15.2025.08.11.05.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 05:48:46 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Mon, 11 Aug 2025 08:48:12 -0400
Subject: [PATCH 7/7] clk: ti: fapll: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-b4-clk-ti-round-rate-v1-7-cc0840594a49@redhat.com>
References: <20250811-b4-clk-ti-round-rate-v1-0-cc0840594a49@redhat.com>
In-Reply-To: <20250811-b4-clk-ti-round-rate-v1-0-cc0840594a49@redhat.com>
To: Tero Kristo <kristo@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754916502; l=3724;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=35dv85IMLqZUQXMLmdKz9Cv7IO7JQIrFzXOoEzRX50w=;
 b=N25Ia/p/HvCELWsArvVY0UtQVgJ3XAaJSxes8tGYmI13Fnbu/6iFvl8iKyxqGdFoqRprtooUL
 btcrwmBZrFsDgLojbWvoFnBiuu79baJzYrO8uPhWQ0uNx1ED+hva180
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/ti/fapll.c | 48 +++++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
index 2db3fc4a443e052722d5c01e5ef38cc1417d818f..4f28138d2d8abfa63e13c23d6a7326f3a2cdbf86 100644
--- a/drivers/clk/ti/fapll.c
+++ b/drivers/clk/ti/fapll.c
@@ -214,24 +214,27 @@ static int ti_fapll_set_div_mult(unsigned long rate,
 	return 0;
 }
 
-static long ti_fapll_round_rate(struct clk_hw *hw, unsigned long rate,
-				unsigned long *parent_rate)
+static int ti_fapll_determine_rate(struct clk_hw *hw,
+				   struct clk_rate_request *req)
 {
 	u32 pre_div_p, mult_n;
 	int error;
 
-	if (!rate)
+	if (!req->rate)
 		return -EINVAL;
 
-	error = ti_fapll_set_div_mult(rate, *parent_rate,
+	error = ti_fapll_set_div_mult(req->rate, req->best_parent_rate,
 				      &pre_div_p, &mult_n);
-	if (error)
-		return error;
+	if (error) {
+		req->rate = error;
 
-	rate = *parent_rate / pre_div_p;
-	rate *= mult_n;
+		return 0;
+	}
 
-	return rate;
+	req->rate = req->best_parent_rate / pre_div_p;
+	req->rate *= mult_n;
+
+	return 0;
 }
 
 static int ti_fapll_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -268,7 +271,7 @@ static const struct clk_ops ti_fapll_ops = {
 	.is_enabled = ti_fapll_is_enabled,
 	.recalc_rate = ti_fapll_recalc_rate,
 	.get_parent = ti_fapll_get_parent,
-	.round_rate = ti_fapll_round_rate,
+	.determine_rate = ti_fapll_determine_rate,
 	.set_rate = ti_fapll_set_rate,
 };
 
@@ -399,14 +402,14 @@ static u32 ti_fapll_synth_set_frac_rate(struct fapll_synth *synth,
 	return post_div_m;
 }
 
-static long ti_fapll_synth_round_rate(struct clk_hw *hw, unsigned long rate,
-				      unsigned long *parent_rate)
+static int ti_fapll_synth_determine_rate(struct clk_hw *hw,
+					 struct clk_rate_request *req)
 {
 	struct fapll_synth *synth = to_synth(hw);
 	struct fapll_data *fd = synth->fd;
 	unsigned long r;
 
-	if (ti_fapll_clock_is_bypass(fd) || !synth->div || !rate)
+	if (ti_fapll_clock_is_bypass(fd) || !synth->div || !req->rate)
 		return -EINVAL;
 
 	/* Only post divider m available with no fractional divider? */
@@ -414,23 +417,26 @@ static long ti_fapll_synth_round_rate(struct clk_hw *hw, unsigned long rate,
 		unsigned long frac_rate;
 		u32 synth_post_div_m;
 
-		frac_rate = ti_fapll_synth_get_frac_rate(hw, *parent_rate);
-		synth_post_div_m = DIV_ROUND_UP(frac_rate, rate);
+		frac_rate = ti_fapll_synth_get_frac_rate(hw,
+							 req->best_parent_rate);
+		synth_post_div_m = DIV_ROUND_UP(frac_rate, req->rate);
 		r = DIV_ROUND_UP(frac_rate, synth_post_div_m);
 		goto out;
 	}
 
-	r = *parent_rate * SYNTH_PHASE_K;
-	if (rate > r)
+	r = req->best_parent_rate * SYNTH_PHASE_K;
+	if (req->rate > r)
 		goto out;
 
 	r = DIV_ROUND_UP_ULL(r, SYNTH_MAX_INT_DIV * SYNTH_MAX_DIV_M);
-	if (rate < r)
+	if (req->rate < r)
 		goto out;
 
-	r = rate;
+	r = req->rate;
 out:
-	return r;
+	req->rate = r;
+
+	return 0;
 }
 
 static int ti_fapll_synth_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -477,7 +483,7 @@ static const struct clk_ops ti_fapll_synt_ops = {
 	.disable = ti_fapll_synth_disable,
 	.is_enabled = ti_fapll_synth_is_enabled,
 	.recalc_rate = ti_fapll_synth_recalc_rate,
-	.round_rate = ti_fapll_synth_round_rate,
+	.determine_rate = ti_fapll_synth_determine_rate,
 	.set_rate = ti_fapll_synth_set_rate,
 };
 

-- 
2.50.1


