Return-Path: <linux-kernel+bounces-790924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C48AB3AFD5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085D9188CB52
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359A91FFC46;
	Fri, 29 Aug 2025 00:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+Wqgfxy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2511F2BB5
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 00:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756427927; cv=none; b=Wt9CKVp7piopWCts72n2Kpkyji+6ks8KWFV3oYDjL4t+KmrtgXcPzXtzAUpQaiZkawwCuvgcmWGrtDw1t6FvSJWGzmots2lncT7dgdebyzf+uaY7iEGK5wdwhkxiCV/GJYUOjy9/5h4jjWWKKSxrUfXj7gzVD+uIp5EhwumV4pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756427927; c=relaxed/simple;
	bh=9nEbhYDzoBNmi/PobaJ6T7eWIrqDvbzH5yntpiRsu9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bNW10dKcThmw3PlTkqKVuu0oT5fmCjV41BJN1Kx2wvRsMMOdmp9XWVT/yB2OcI4YQKgHqGnnFf3ZzziSt3xAdEnq5OmDnxxZ88ng7+8eEb5r4c2suY91pI3MXF4dcohoo8V1aClSf4z7GtYxPJ+oOCrlQTrdCjlJ4Rh26x1tkT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G+Wqgfxy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756427924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INBKiFvw1l32bSX5fXP9bt/+Xv/TGJnC5X0C7163OaA=;
	b=G+WqgfxyxWNg57Tg1s3yFUg9jURMrx6OMYtGijGiFPaiCUW9GlNOmupMeB58oeMAxeVgIi
	kWz/a0iuB65yPs75nxFGcqiGu3ae/drd7go2zwzoJOf78uNI/wlel+XkAO0wlBmtkt9mrA
	5lfcRX+kS6r05HP2P2ev08NnvJLtyHQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-__7DGwIZP_m4e3x2fAvSNQ-1; Thu, 28 Aug 2025 20:38:43 -0400
X-MC-Unique: __7DGwIZP_m4e3x2fAvSNQ-1
X-Mimecast-MFC-AGG-ID: __7DGwIZP_m4e3x2fAvSNQ_1756427922
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70ddd80d02fso18604996d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756427922; x=1757032722;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INBKiFvw1l32bSX5fXP9bt/+Xv/TGJnC5X0C7163OaA=;
        b=CCHWG+KscH952Tp+ip/1uh5CHTL0Nq1if+QFD9oxHERrPAI93nAa8Kj3gOcxU4QrMy
         D6AUpvd8fUtK2OcrDOlVVkBGF3lj8rJOPEfT17crjUU3Cr7BdPNqA2m/O5RSwYyNZOYo
         kbQWv4s7LltgV05D8ra2cGq+HC3D/NA8gS1xU9l17u0yrDINFptJ4D0vir5hpLnnrROf
         l7W/WZItV0iYlH4cFGJOvY5zNkHmdog9jtaFcDBMZDR3S2sOyd8hDZePp8wQ1N+Qtyfj
         IijUCVT5qAbu+B7A1OV6J2l5tbhJQdMm03I1sg31qT75/V+205DXeqGAucza5xn8M3px
         4Mag==
X-Forwarded-Encrypted: i=1; AJvYcCXGkbDXz4c81pMqktmAkx0IdhDKTybcFeVl9FZEZYHPWOtnIBHvxbm/5KkaU61Wn1eujPP5o0PHBqijN6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyrqgz31mKuizB45ZCOmxo2kJtlmKm/BaV3atNIGr+QBNjD3hO
	75Fpluz199Gn6K5JSlgTVhY4doyV+AaBVJ68Zk1jftBcnTlKnTAY3EZnSAkmfMvY8SBetWuTClP
	/JMtWVQFf0NM3DVVvediGqV9aAv3PnsF0o7uXq6CYFkCtRXeVA3HgeBd7fyxKc+e/8A==
X-Gm-Gg: ASbGnctcMZDxPYrcxz8VHoEtKbwJiESvnQTFCMzzxx5nnKc5yK+gVOjDwIPc9Y5u6W5
	6QNEWY5t2LJPfJsMIeANhEQJTv6fmPwqdEVk8q5Dmoq6nUnytn+LDxCld6ZcYu2QVM/Z7ss0EA7
	4ROo0ssPsSx7Z4Zf6jnSGo6mmr5bYAp5DM3sUfR8bXC/k96mOlDnCpxUEZ4Ri545rutr+Y84CXE
	GnVtakJeo3S1WSqdlDM6505qBsbNFogn2VzX5ZXC3Rc+eJuPekInKFzar4MUtx6s23e62PTtMsz
	XFSvx+jh2Nx7ck2V/gnp54MNnalTed5SAS/u/okQtndQ9LHkF8WyBKVxHp8ASpTKWhPtAOZQpdU
	Go5ZoWC9j0hzkNn890sTm8Z3Q3X0zzpxfkg==
X-Received: by 2002:a05:6214:2308:b0:70e:d2e:4111 with SMTP id 6a1803df08f44-70e0d2e46bcmr17026546d6.64.1756427922355;
        Thu, 28 Aug 2025 17:38:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLPZMnvSXxQHGa0k0IMwMZFMp0jxAhWxs/gSafBJp9wXqI2erH7R4QN082+oWY3YxWFAjsLg==
X-Received: by 2002:a05:6214:2308:b0:70e:d2e:4111 with SMTP id 6a1803df08f44-70e0d2e46bcmr17026236d6.64.1756427921866;
        Thu, 28 Aug 2025 17:38:41 -0700 (PDT)
Received: from [192.168.1.2] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70e6264141asm5588696d6.65.2025.08.28.17.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 17:38:40 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 28 Aug 2025 20:38:21 -0400
Subject: [PATCH 2/8] clk: qcom: alpha-pll: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-clk-round-rate-v2-v1-2-b97ec8ba6cc4@redhat.com>
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
 Brian Masney <bmasney@redhat.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756427914; l=16351;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=9nEbhYDzoBNmi/PobaJ6T7eWIrqDvbzH5yntpiRsu9M=;
 b=yHjmM+DGGOe8RhI6LsZ4fKGbYLCUkFCUKPgF3b+Os98dKIFFNeETSye5rdIeMch6evCEu7Qc+
 inxr7bfCHGfCY6zkCyUCEGmPGyXcjFklda6J92sJyLbN0yRRIamnynB
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Note that prior to running the Coccinelle,
clk_alpha_pll_postdiv_round_ro_rate() was renamed to
clk_alpha_pll_postdiv_ro_round_rate().

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/qcom/clk-alpha-pll.c | 136 ++++++++++++++++++++++-----------------
 1 file changed, 77 insertions(+), 59 deletions(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 81a1ce42285f7eb19dba92cb7415c7e694a829dd..6aeba40358c11e44c5f39d15f149d62149393cd3 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -849,22 +849,25 @@ static int clk_alpha_pll_hwfsm_set_rate(struct clk_hw *hw, unsigned long rate,
 					clk_alpha_pll_hwfsm_is_enabled);
 }
 
-static long clk_alpha_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-				     unsigned long *prate)
+static int clk_alpha_pll_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
 {
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
 	u32 l, alpha_width = pll_alpha_width(pll);
 	u64 a;
 	unsigned long min_freq, max_freq;
 
-	rate = alpha_pll_round_rate(rate, *prate, &l, &a, alpha_width);
-	if (!pll->vco_table || alpha_pll_find_vco(pll, rate))
-		return rate;
+	req->rate = alpha_pll_round_rate(req->rate, req->best_parent_rate, &l,
+					 &a, alpha_width);
+	if (!pll->vco_table || alpha_pll_find_vco(pll, req->rate))
+		return 0;
 
 	min_freq = pll->vco_table[0].min_freq;
 	max_freq = pll->vco_table[pll->num_vco - 1].max_freq;
 
-	return clamp(rate, min_freq, max_freq);
+	req->rate = clamp(req->rate, min_freq, max_freq);
+
+	return 0;
 }
 
 void clk_huayra_2290_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
@@ -1048,12 +1051,15 @@ static int alpha_pll_huayra_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
-static long alpha_pll_huayra_round_rate(struct clk_hw *hw, unsigned long rate,
-					unsigned long *prate)
+static int alpha_pll_huayra_determine_rate(struct clk_hw *hw,
+					   struct clk_rate_request *req)
 {
 	u32 l, a;
 
-	return alpha_huayra_pll_round_rate(rate, *prate, &l, &a);
+	req->rate = alpha_huayra_pll_round_rate(req->rate,
+						req->best_parent_rate, &l, &a);
+
+	return 0;
 }
 
 static int trion_pll_is_enabled(struct clk_alpha_pll *pll,
@@ -1175,7 +1181,7 @@ const struct clk_ops clk_alpha_pll_ops = {
 	.disable = clk_alpha_pll_disable,
 	.is_enabled = clk_alpha_pll_is_enabled,
 	.recalc_rate = clk_alpha_pll_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 	.set_rate = clk_alpha_pll_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_ops);
@@ -1185,7 +1191,7 @@ const struct clk_ops clk_alpha_pll_huayra_ops = {
 	.disable = clk_alpha_pll_disable,
 	.is_enabled = clk_alpha_pll_is_enabled,
 	.recalc_rate = alpha_pll_huayra_recalc_rate,
-	.round_rate = alpha_pll_huayra_round_rate,
+	.determine_rate = alpha_pll_huayra_determine_rate,
 	.set_rate = alpha_pll_huayra_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_huayra_ops);
@@ -1195,7 +1201,7 @@ const struct clk_ops clk_alpha_pll_hwfsm_ops = {
 	.disable = clk_alpha_pll_hwfsm_disable,
 	.is_enabled = clk_alpha_pll_hwfsm_is_enabled,
 	.recalc_rate = clk_alpha_pll_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 	.set_rate = clk_alpha_pll_hwfsm_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_hwfsm_ops);
@@ -1205,7 +1211,7 @@ const struct clk_ops clk_alpha_pll_fixed_trion_ops = {
 	.disable = clk_trion_pll_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = clk_trion_pll_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_fixed_trion_ops);
 
@@ -1240,9 +1246,8 @@ static const struct clk_div_table clk_alpha_2bit_div_table[] = {
 	{ }
 };
 
-static long
-clk_alpha_pll_postdiv_round_rate(struct clk_hw *hw, unsigned long rate,
-				 unsigned long *prate)
+static int clk_alpha_pll_postdiv_determine_rate(struct clk_hw *hw,
+						struct clk_rate_request *req)
 {
 	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
 	const struct clk_div_table *table;
@@ -1252,13 +1257,15 @@ clk_alpha_pll_postdiv_round_rate(struct clk_hw *hw, unsigned long rate,
 	else
 		table = clk_alpha_div_table;
 
-	return divider_round_rate(hw, rate, prate, table,
-				  pll->width, CLK_DIVIDER_POWER_OF_TWO);
+	req->rate = divider_round_rate(hw, req->rate, &req->best_parent_rate,
+				       table, pll->width,
+				       CLK_DIVIDER_POWER_OF_TWO);
+
+	return 0;
 }
 
-static long
-clk_alpha_pll_postdiv_round_ro_rate(struct clk_hw *hw, unsigned long rate,
-				    unsigned long *prate)
+static int clk_alpha_pll_postdiv_ro_determine_rate(struct clk_hw *hw,
+						   struct clk_rate_request *req)
 {
 	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
 	u32 ctl, div;
@@ -1270,9 +1277,12 @@ clk_alpha_pll_postdiv_round_ro_rate(struct clk_hw *hw, unsigned long rate,
 	div = 1 << fls(ctl);
 
 	if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)
-		*prate = clk_hw_round_rate(clk_hw_get_parent(hw), div * rate);
+		req->best_parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw),
+							  div * req->rate);
+
+	req->rate = DIV_ROUND_UP_ULL((u64)req->best_parent_rate, div);
 
-	return DIV_ROUND_UP_ULL((u64)*prate, div);
+	return 0;
 }
 
 static int clk_alpha_pll_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -1291,13 +1301,13 @@ static int clk_alpha_pll_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
 
 const struct clk_ops clk_alpha_pll_postdiv_ops = {
 	.recalc_rate = clk_alpha_pll_postdiv_recalc_rate,
-	.round_rate = clk_alpha_pll_postdiv_round_rate,
+	.determine_rate = clk_alpha_pll_postdiv_determine_rate,
 	.set_rate = clk_alpha_pll_postdiv_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_ops);
 
 const struct clk_ops clk_alpha_pll_postdiv_ro_ops = {
-	.round_rate = clk_alpha_pll_postdiv_round_ro_rate,
+	.determine_rate = clk_alpha_pll_postdiv_ro_determine_rate,
 	.recalc_rate = clk_alpha_pll_postdiv_recalc_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_ro_ops);
@@ -1542,7 +1552,7 @@ const struct clk_ops clk_alpha_pll_fabia_ops = {
 	.is_enabled = clk_alpha_pll_is_enabled,
 	.set_rate = alpha_pll_fabia_set_rate,
 	.recalc_rate = alpha_pll_fabia_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_fabia_ops);
 
@@ -1551,7 +1561,7 @@ const struct clk_ops clk_alpha_pll_fixed_fabia_ops = {
 	.disable = alpha_pll_fabia_disable,
 	.is_enabled = clk_alpha_pll_is_enabled,
 	.recalc_rate = alpha_pll_fabia_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_fixed_fabia_ops);
 
@@ -1602,14 +1612,16 @@ clk_trion_pll_postdiv_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	return (parent_rate / div);
 }
 
-static long
-clk_trion_pll_postdiv_round_rate(struct clk_hw *hw, unsigned long rate,
-				 unsigned long *prate)
+static int clk_trion_pll_postdiv_determine_rate(struct clk_hw *hw,
+						struct clk_rate_request *req)
 {
 	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
 
-	return divider_round_rate(hw, rate, prate, pll->post_div_table,
-				  pll->width, CLK_DIVIDER_ROUND_CLOSEST);
+	req->rate = divider_round_rate(hw, req->rate, &req->best_parent_rate,
+				       pll->post_div_table,
+				       pll->width, CLK_DIVIDER_ROUND_CLOSEST);
+
+	return 0;
 };
 
 static int
@@ -1635,18 +1647,21 @@ clk_trion_pll_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
 
 const struct clk_ops clk_alpha_pll_postdiv_trion_ops = {
 	.recalc_rate = clk_trion_pll_postdiv_recalc_rate,
-	.round_rate = clk_trion_pll_postdiv_round_rate,
+	.determine_rate = clk_trion_pll_postdiv_determine_rate,
 	.set_rate = clk_trion_pll_postdiv_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_trion_ops);
 
-static long clk_alpha_pll_postdiv_fabia_round_rate(struct clk_hw *hw,
-				unsigned long rate, unsigned long *prate)
+static int clk_alpha_pll_postdiv_fabia_determine_rate(struct clk_hw *hw,
+						      struct clk_rate_request *req)
 {
 	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
 
-	return divider_round_rate(hw, rate, prate, pll->post_div_table,
-				pll->width, CLK_DIVIDER_ROUND_CLOSEST);
+	req->rate = divider_round_rate(hw, req->rate, &req->best_parent_rate,
+				       pll->post_div_table,
+				       pll->width, CLK_DIVIDER_ROUND_CLOSEST);
+
+	return 0;
 }
 
 static int clk_alpha_pll_postdiv_fabia_set_rate(struct clk_hw *hw,
@@ -1681,7 +1696,7 @@ static int clk_alpha_pll_postdiv_fabia_set_rate(struct clk_hw *hw,
 
 const struct clk_ops clk_alpha_pll_postdiv_fabia_ops = {
 	.recalc_rate = clk_alpha_pll_postdiv_fabia_recalc_rate,
-	.round_rate = clk_alpha_pll_postdiv_fabia_round_rate,
+	.determine_rate = clk_alpha_pll_postdiv_fabia_determine_rate,
 	.set_rate = clk_alpha_pll_postdiv_fabia_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_fabia_ops);
@@ -1833,7 +1848,7 @@ const struct clk_ops clk_alpha_pll_trion_ops = {
 	.disable = clk_trion_pll_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = clk_trion_pll_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 	.set_rate = alpha_pll_trion_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_trion_ops);
@@ -1844,14 +1859,14 @@ const struct clk_ops clk_alpha_pll_lucid_ops = {
 	.disable = clk_trion_pll_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = clk_trion_pll_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 	.set_rate = alpha_pll_trion_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_lucid_ops);
 
 const struct clk_ops clk_alpha_pll_postdiv_lucid_ops = {
 	.recalc_rate = clk_alpha_pll_postdiv_fabia_recalc_rate,
-	.round_rate = clk_alpha_pll_postdiv_fabia_round_rate,
+	.determine_rate = clk_alpha_pll_postdiv_fabia_determine_rate,
 	.set_rate = clk_alpha_pll_postdiv_fabia_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_lucid_ops);
@@ -1903,7 +1918,7 @@ const struct clk_ops clk_alpha_pll_agera_ops = {
 	.disable = clk_alpha_pll_disable,
 	.is_enabled = clk_alpha_pll_is_enabled,
 	.recalc_rate = alpha_pll_fabia_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 	.set_rate = clk_alpha_pll_agera_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_agera_ops);
@@ -2119,7 +2134,7 @@ const struct clk_ops clk_alpha_pll_lucid_5lpe_ops = {
 	.disable = alpha_pll_lucid_5lpe_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = clk_trion_pll_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 	.set_rate = alpha_pll_lucid_5lpe_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_lucid_5lpe_ops);
@@ -2129,13 +2144,13 @@ const struct clk_ops clk_alpha_pll_fixed_lucid_5lpe_ops = {
 	.disable = alpha_pll_lucid_5lpe_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = clk_trion_pll_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_fixed_lucid_5lpe_ops);
 
 const struct clk_ops clk_alpha_pll_postdiv_lucid_5lpe_ops = {
 	.recalc_rate = clk_alpha_pll_postdiv_fabia_recalc_rate,
-	.round_rate = clk_alpha_pll_postdiv_fabia_round_rate,
+	.determine_rate = clk_alpha_pll_postdiv_fabia_determine_rate,
 	.set_rate = clk_lucid_5lpe_pll_postdiv_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_lucid_5lpe_ops);
@@ -2304,7 +2319,7 @@ const struct clk_ops clk_alpha_pll_zonda_ops = {
 	.disable = clk_zonda_pll_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = clk_trion_pll_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 	.set_rate = clk_zonda_pll_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_zonda_ops);
@@ -2529,13 +2544,13 @@ const struct clk_ops clk_alpha_pll_fixed_lucid_evo_ops = {
 	.disable = alpha_pll_lucid_evo_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = alpha_pll_lucid_evo_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_fixed_lucid_evo_ops);
 
 const struct clk_ops clk_alpha_pll_postdiv_lucid_evo_ops = {
 	.recalc_rate = clk_alpha_pll_postdiv_fabia_recalc_rate,
-	.round_rate = clk_alpha_pll_postdiv_fabia_round_rate,
+	.determine_rate = clk_alpha_pll_postdiv_fabia_determine_rate,
 	.set_rate = clk_lucid_evo_pll_postdiv_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_lucid_evo_ops);
@@ -2546,7 +2561,7 @@ const struct clk_ops clk_alpha_pll_lucid_evo_ops = {
 	.disable = alpha_pll_lucid_evo_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = alpha_pll_lucid_evo_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 	.set_rate = alpha_pll_lucid_5lpe_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_lucid_evo_ops);
@@ -2557,7 +2572,7 @@ const struct clk_ops clk_alpha_pll_reset_lucid_evo_ops = {
 	.disable = alpha_pll_reset_lucid_evo_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = alpha_pll_lucid_evo_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 	.set_rate = alpha_pll_lucid_5lpe_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_reset_lucid_evo_ops);
@@ -2732,22 +2747,25 @@ static unsigned long clk_rivian_evo_pll_recalc_rate(struct clk_hw *hw,
 	return parent_rate * l;
 }
 
-static long clk_rivian_evo_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-					  unsigned long *prate)
+static int clk_rivian_evo_pll_determine_rate(struct clk_hw *hw,
+					     struct clk_rate_request *req)
 {
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
 	unsigned long min_freq, max_freq;
 	u32 l;
 	u64 a;
 
-	rate = alpha_pll_round_rate(rate, *prate, &l, &a, 0);
-	if (!pll->vco_table || alpha_pll_find_vco(pll, rate))
-		return rate;
+	req->rate = alpha_pll_round_rate(req->rate, req->best_parent_rate, &l,
+					 &a, 0);
+	if (!pll->vco_table || alpha_pll_find_vco(pll, req->rate))
+		return 0;
 
 	min_freq = pll->vco_table[0].min_freq;
 	max_freq = pll->vco_table[pll->num_vco - 1].max_freq;
 
-	return clamp(rate, min_freq, max_freq);
+	req->rate = clamp(req->rate, min_freq, max_freq);
+
+	return 0;
 }
 
 const struct clk_ops clk_alpha_pll_rivian_evo_ops = {
@@ -2755,7 +2773,7 @@ const struct clk_ops clk_alpha_pll_rivian_evo_ops = {
 	.disable = alpha_pll_lucid_5lpe_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = clk_rivian_evo_pll_recalc_rate,
-	.round_rate = clk_rivian_evo_pll_round_rate,
+	.determine_rate = clk_rivian_evo_pll_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_rivian_evo_ops);
 
@@ -2964,7 +2982,7 @@ const struct clk_ops clk_alpha_pll_regera_ops = {
 	.disable = clk_zonda_pll_disable,
 	.is_enabled = clk_alpha_pll_is_enabled,
 	.recalc_rate = clk_trion_pll_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 	.set_rate = clk_zonda_pll_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_regera_ops);
@@ -3169,7 +3187,7 @@ const struct clk_ops clk_alpha_pll_slew_ops = {
 	.enable = clk_alpha_pll_slew_enable,
 	.disable = clk_alpha_pll_disable,
 	.recalc_rate = clk_alpha_pll_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 	.set_rate = clk_alpha_pll_slew_set_rate,
 };
 EXPORT_SYMBOL(clk_alpha_pll_slew_ops);

-- 
2.50.1


