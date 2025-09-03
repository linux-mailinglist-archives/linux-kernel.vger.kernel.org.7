Return-Path: <linux-kernel+bounces-798941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227D0B424F0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 859A17BDD3C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016D8253B73;
	Wed,  3 Sep 2025 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="El7VJnH/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F63D24C07A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912572; cv=none; b=RGjcllEUCSbQPhJfBL7tJDeu8gdaGKoveFmrqmhFplEW9mfVEURJaZeGguWKWCOy7mxlJJ7L2zX4IdC0PVED3/K1SM67S3Et16lPl9mo/9R2sMSBVyon1yd1oInzZe44Mq/3IQipEuMyBoUZ/RFNItriiHx9n9nq8v7zsvWdKBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912572; c=relaxed/simple;
	bh=43sEbwhMVLXr4Ugy2k4lhtQIjlFVPQRMntWIuVLuAbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RGPJHLCe/06IwE6O7IqASpxufS7bBV/U6EsGrQ5bLtrytlwDAXBcEI0m0DjPwQT7tzGbiBVrQ/ANq/iJaoPfhZFFdmTuF36mraEv/GFOGkgglMHe8VcER1XUqPcGNtbCgQW/17yKWUfbhnYvr2z+LcajNuHSwjMbuaSteKn/zS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=El7VJnH/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756912569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x9cuOYxu0U7DIdqQ6OT/K5slwo9p+cHFbhRnmBL6l1o=;
	b=El7VJnH/wjQD+FHX8m7PPhgEuApJ8dOdPqsC5NfiHsSV9PNL1w3ErHmCl9/72BKsMKsLdT
	ovxSUnbr929TzSmL2By58DyoApTH0lfCFENMqkPBsgwMMyJ6b/W+3O+J1okaPC46eCTB3I
	7DAyTvBbdjeLl/jAECdn3ew+xNP1JeY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-TJ2-aQ8cMoSxJk8MCAbfjw-1; Wed, 03 Sep 2025 11:16:08 -0400
X-MC-Unique: TJ2-aQ8cMoSxJk8MCAbfjw-1
X-Mimecast-MFC-AGG-ID: TJ2-aQ8cMoSxJk8MCAbfjw_1756912568
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70de52d2904so158934386d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 08:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912568; x=1757517368;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9cuOYxu0U7DIdqQ6OT/K5slwo9p+cHFbhRnmBL6l1o=;
        b=OjFgODIcI0DVigmdrRMnuJHQGtL6SpRFyVIEG6IcJeihgQl+4TG1vMAYkip7oHGrL1
         yHpl2aGHvwyW6WzL67gsQiOJlIMSD3VHccEsjcl09Fmg1pXEi86XKl9rg0jnRlQMVM3G
         aB7PBbluqh+yN3PvGmmbUOlWljSSF47yRiL6Ncf+K7yJW/IiDhPomOtr8GPxX0+Qpulv
         4l4VUUeteNOSQofiqRn2btIYeCzqwDO1z/JwxJLgZhixTb/HpFHcw/TO17Lbz1pBzWAG
         ka9buBmi4LQafSQgfslX+K2SQ9TMX5JYbT+EeSWfYBAbEvGdcs+Q0xNfE+Dp2dS3ZdPo
         /gxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXti46aFpWncX2XLbaYXWI7fI6f07thBZVlbJp1DdA7uAcqb3eeAhUy6H+RsQ0i8PmvO3hhS5k4LDFgQv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXsUHJMxdq+lp/q8elr2IgIhckM2nioovOo40TCrENd40YOH99
	9UpBeEAVi3+COyBO0SZEsh1zdnfVDg5G9iyYe3riY6N9w5tTju3a/u02Toqsmxt1vv+MBAWrMIM
	Ulr/l0wqePYelR7AQyfnrSv/Fvf2bx5OIsdqRZKbdTycuo70vi/E/R8t5GjG8lHkCPA==
X-Gm-Gg: ASbGncsvw1qLbKpyc+Qiy7SsfobxoiSfXd2fF91DXPkugnzIDgMYMBTcMw9ykjzUkTR
	py3JKlSkXMWzuEB5pXn7w4yXsbOxdQu5mD4qYxHtmtOnly1eDb39kmJQ2jL3pld5Okn7s07kWbV
	SG5TC9tFaFnPPZbKt48LFoLupdPwLkPVunPxkSaJcSjPdAIOdUR3Rv7iWnM/opwlly87Q8V7QAc
	j1a18OsOoSGJI6tZds9JjfHqYUPT5WKUXAOB1qund+FcMkOIEbgUTvFGadnEPd+6izPTpQL+RHk
	OcuJWC5sEsm6nTDQhTiIokId4JZ8fCfVvxL8JAPzvBP72rgSIuoExEbwuKwf3CA/cr01LrGHhu4
	=
X-Received: by 2002:ad4:4eeb:0:b0:70d:961c:bb0e with SMTP id 6a1803df08f44-70fac9202d8mr197031946d6.58.1756912550967;
        Wed, 03 Sep 2025 08:15:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnqDjIqsiZca+ggH4RMjYaXqAO0ErU7lwak2EX2JoTANTpehd9a2V8hc1liqn8FqdeAjJJmQ==
X-Received: by 2002:ad4:4eeb:0:b0:70d:961c:bb0e with SMTP id 6a1803df08f44-70fac9202d8mr197013286d6.58.1756912536653;
        Wed, 03 Sep 2025 08:15:36 -0700 (PDT)
Received: from [10.12.114.224] ([2600:382:850c:786a:ff8e:13a:e47c:3472])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ac16de16sm30827706d6.3.2025.09.03.08.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:15:34 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Wed, 03 Sep 2025 11:15:05 -0400
Subject: [PATCH v2 4/6] clk: tegra: pll: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-clk-tegra-round-rate-v2-v2-4-3126d321d4e4@redhat.com>
References: <20250903-clk-tegra-round-rate-v2-v2-0-3126d321d4e4@redhat.com>
In-Reply-To: <20250903-clk-tegra-round-rate-v2-v2-0-3126d321d4e4@redhat.com>
To: Peter De Schrijver <pdeschrijver@nvidia.com>, 
 Prashant Gaikwad <pgaikwad@nvidia.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756912523; l=5433;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=43sEbwhMVLXr4Ugy2k4lhtQIjlFVPQRMntWIuVLuAbk=;
 b=rpRJizWaPvqeE8fyxaXKWGMOtJvlvuOaw1CCwjSgxH0jKIiYpjpuikcEEp7O69HVv0KF16BxN
 TXt73fGvnjOAYUe30HyZWWwnRS3516J0fBBdhdXNA86DnGkXxGPj02D
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Link: https://lore.kernel.org/r/20250710-clk-tegra-round-rate-v1-4-e48ac3df4279@redhat.com
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/tegra/clk-pll.c | 52 +++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index 100b5d9b7e26e906f71963152ad50bd0a89d14d6..591b9f0c155a033ab46fbb0a1de742efed560b5c 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -840,8 +840,8 @@ static int clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	return ret;
 }
 
-static long clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-			unsigned long *prate)
+static int clk_pll_determine_rate(struct clk_hw *hw,
+				  struct clk_rate_request *req)
 {
 	struct tegra_clk_pll *pll = to_clk_pll(hw);
 	struct tegra_clk_pll_freq_table cfg;
@@ -849,15 +849,20 @@ static long clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 	if (pll->params->flags & TEGRA_PLL_FIXED) {
 		/* PLLM/MB are used for memory; we do not change rate */
 		if (pll->params->flags & (TEGRA_PLLM | TEGRA_PLLMB))
-			return clk_hw_get_rate(hw);
-		return pll->params->fixed_rate;
+			req->rate = clk_hw_get_rate(hw);
+		else
+			req->rate = pll->params->fixed_rate;
+
+		return 0;
 	}
 
-	if (_get_table_rate(hw, &cfg, rate, *prate) &&
-	    pll->params->calc_rate(hw, &cfg, rate, *prate))
+	if (_get_table_rate(hw, &cfg, req->rate, req->best_parent_rate) &&
+	    pll->params->calc_rate(hw, &cfg, req->rate, req->best_parent_rate))
 		return -EINVAL;
 
-	return cfg.output_rate;
+	req->rate = cfg.output_rate;
+
+	return 0;
 }
 
 static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
@@ -1057,7 +1062,7 @@ const struct clk_ops tegra_clk_pll_ops = {
 	.enable = clk_pll_enable,
 	.disable = clk_pll_disable,
 	.recalc_rate = clk_pll_recalc_rate,
-	.round_rate = clk_pll_round_rate,
+	.determine_rate = clk_pll_determine_rate,
 	.set_rate = clk_pll_set_rate,
 	.restore_context = tegra_clk_pll_restore_context,
 };
@@ -1195,7 +1200,7 @@ static const struct clk_ops tegra_clk_pllu_ops = {
 	.enable = clk_pllu_enable,
 	.disable = clk_pll_disable,
 	.recalc_rate = clk_pll_recalc_rate,
-	.round_rate = clk_pll_round_rate,
+	.determine_rate = clk_pll_determine_rate,
 	.set_rate = clk_pll_set_rate,
 };
 
@@ -1353,15 +1358,15 @@ static int clk_pllxc_set_rate(struct clk_hw *hw, unsigned long rate,
 	return ret;
 }
 
-static long clk_pll_ramp_round_rate(struct clk_hw *hw, unsigned long rate,
-				unsigned long *prate)
+static int clk_pll_ramp_determine_rate(struct clk_hw *hw,
+				       struct clk_rate_request *req)
 {
 	struct tegra_clk_pll *pll = to_clk_pll(hw);
 	struct tegra_clk_pll_freq_table cfg;
 	int ret, p_div;
-	u64 output_rate = *prate;
+	u64 output_rate = req->best_parent_rate;
 
-	ret = _pll_ramp_calc_pll(hw, &cfg, rate, *prate);
+	ret = _pll_ramp_calc_pll(hw, &cfg, req->rate, req->best_parent_rate);
 	if (ret < 0)
 		return ret;
 
@@ -1375,7 +1380,9 @@ static long clk_pll_ramp_round_rate(struct clk_hw *hw, unsigned long rate,
 	output_rate *= cfg.n;
 	do_div(output_rate, cfg.m * p_div);
 
-	return output_rate;
+	req->rate = output_rate;
+
+	return 0;
 }
 
 static void _pllcx_strobe(struct tegra_clk_pll *pll)
@@ -1598,12 +1605,15 @@ static unsigned long clk_pllre_recalc_rate(struct clk_hw *hw,
 	return rate;
 }
 
-static long clk_pllre_round_rate(struct clk_hw *hw, unsigned long rate,
-				 unsigned long *prate)
+static int clk_pllre_determine_rate(struct clk_hw *hw,
+				    struct clk_rate_request *req)
 {
 	struct tegra_clk_pll *pll = to_clk_pll(hw);
 
-	return _pllre_calc_rate(pll, NULL, rate, *prate);
+	req->rate = _pllre_calc_rate(pll, NULL, req->rate,
+				     req->best_parent_rate);
+
+	return 0;
 }
 
 static int clk_plle_tegra114_enable(struct clk_hw *hw)
@@ -2003,7 +2013,7 @@ static const struct clk_ops tegra_clk_pllxc_ops = {
 	.enable = clk_pll_enable,
 	.disable = clk_pll_disable,
 	.recalc_rate = clk_pll_recalc_rate,
-	.round_rate = clk_pll_ramp_round_rate,
+	.determine_rate = clk_pll_ramp_determine_rate,
 	.set_rate = clk_pllxc_set_rate,
 };
 
@@ -2012,7 +2022,7 @@ static const struct clk_ops tegra_clk_pllc_ops = {
 	.enable = clk_pllc_enable,
 	.disable = clk_pllc_disable,
 	.recalc_rate = clk_pll_recalc_rate,
-	.round_rate = clk_pll_ramp_round_rate,
+	.determine_rate = clk_pll_ramp_determine_rate,
 	.set_rate = clk_pllc_set_rate,
 };
 
@@ -2021,7 +2031,7 @@ static const struct clk_ops tegra_clk_pllre_ops = {
 	.enable = clk_pll_enable,
 	.disable = clk_pll_disable,
 	.recalc_rate = clk_pllre_recalc_rate,
-	.round_rate = clk_pllre_round_rate,
+	.determine_rate = clk_pllre_determine_rate,
 	.set_rate = clk_pllre_set_rate,
 };
 
@@ -2321,7 +2331,7 @@ static const struct clk_ops tegra_clk_pllss_ops = {
 	.enable = clk_pll_enable,
 	.disable = clk_pll_disable,
 	.recalc_rate = clk_pll_recalc_rate,
-	.round_rate = clk_pll_ramp_round_rate,
+	.determine_rate = clk_pll_ramp_determine_rate,
 	.set_rate = clk_pllxc_set_rate,
 	.restore_context = tegra_clk_pll_restore_context,
 };

-- 
2.50.1


