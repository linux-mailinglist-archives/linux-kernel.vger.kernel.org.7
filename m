Return-Path: <linux-kernel+bounces-726066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8E1B007A8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0814E2911
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AD927A47A;
	Thu, 10 Jul 2025 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YHh8AYwA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3882797BF
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162713; cv=none; b=LtMu+rbg3HnKX4GaJkZt392gzz9zeSyvUTbvn6x/sbUxi7cCinEEAfAzLcOTccvwm+mETuNOcpwir23Z9t2r/d9q28pOYqXwLJ0hdY2lq1MZgGyKTu8c6hEEZhuv6rN7r87wNeHAAqJ/hR9TZ1j1GYFmB4QOn8PcIh6N4SkTDKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162713; c=relaxed/simple;
	bh=t2hjGCARaRQgI0Ustel3aF+sNP5ba1R6WUsBnvpS8Gw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EFaQUJu4TSCJ1rMUqmxzsapUu0E9YJ4W2Nz8jZuYxUhGDdIriWGxc8vWLA00GWugSFvbvfiOYvT1hmA92L0Wg8ORwckBD6xdh4+slggl/59sGDY48w3vQ5e6HvUnSn+y4YuZYjIbu2mrbPGfMpam/1Pmka4ZoU3CO8kl8N3SOk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YHh8AYwA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752162709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cGKF6eOX7Jk+EpeggU8l+LOb8l3CYbEDXRYR6gPHE9Q=;
	b=YHh8AYwAyzK+jB93+mepqjpUaCxV5Gj4iuWVYrT02PfUgxof500PayGGdPBMZ3tfp81cak
	m6N9PbBkrJ98z7ci0UtYGr471vuT1YNmvLIjqGKkbwBNE0L9QbX1eoLI+bI045OO+WXEw5
	R7ThANAzVRM9dfKs2ajN4oUDvDOfk+0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-2qK4abB3PH-pugQNitO5kg-1; Thu, 10 Jul 2025 11:51:48 -0400
X-MC-Unique: 2qK4abB3PH-pugQNitO5kg-1
X-Mimecast-MFC-AGG-ID: 2qK4abB3PH-pugQNitO5kg_1752162708
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-704817522b9so16603306d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752162708; x=1752767508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGKF6eOX7Jk+EpeggU8l+LOb8l3CYbEDXRYR6gPHE9Q=;
        b=DkG0VjQcdJf0+y7YZA8qQnzADJKegtHg/55/3N8ANqo0IPNWZfljtKsQWkz5A/ohMj
         ne400hjU9PzDOGoS64z6FrWd+fB8jlehTPBYsOLCqS5hgJXDUIlz7h3OLzA32wxNxYAD
         6p2Jr5icav8k3wFIWHij4ke1+2As/NRWhvTGEcLLFzKehlHA/QA7LgGBCWMK/GZrKWGf
         IPIly5BizTHwglB0D4Ovxdte0HQ7jeFYgert2oMa6e5/HZHAnkP6weVcmBJFJNQd0y7a
         twu7AN8xoo3vKAy8pFAjdD4LIHXSuKH8e3BAv1GHHYERPSY1XX4ElSrkz7+JEafCDnle
         ndPg==
X-Forwarded-Encrypted: i=1; AJvYcCWRBQ4gx7b8F0DrMqcHyG8zWdJAJiaxkvYKFeeDwog9pIvuC/h8jBNjRyY+/4o5Tc4BRAiFnsLRFSKnkNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsNPCIeBndXiGjXzPSHk7ZdF3junGXu0AfdwinrpUAmG3GHT3d
	cpJBPNhKDbQqx9Dzhp5zvnX7jSAwJbucGkZphijYYyX/Ux9chR9wBJ8+oUM3xR+jTiH4BpD0Z3r
	EnKNe0UDsXDDvI2DdI8cnDXYsxsBqL9LagVwslJLmXF3I7JJnklGvG7sJWASQFB9f2A==
X-Gm-Gg: ASbGnct+pa50c5S2LuQ3DVJKH8fh3Zxo62svON/ezwRb5xWmV+fZXLTE5vT7HurcMv1
	ZpPAYIOUUKgd6XKDoo3ajR3i0T1ZfINPoDc7g2LicJfQwRmN05k7ylhUiF6E+EAwx4/Z+5+Z+3U
	kqDAzyxGxDn3iFzo/yb6pg6CPAJXgu2L5zZffygzcETO6ma002hLBMsri17FWcYqzUtnMCo6RBR
	8//dMOQkpRZJZNjzXD2eZpOOj4BHBTOZidsdOQuQMxvUzfpeFCI1BreYv+QcIT+ZS8bCwcCmDAP
	QXshv90D8jZEEt1sPZZ/rVrRiQr4tjywp7JEQHER4tn8Ev2AZibv0CY/KRJK
X-Received: by 2002:a05:6214:246f:b0:702:d6e7:18bf with SMTP id 6a1803df08f44-70494ee3ed9mr73517886d6.3.1752162707911;
        Thu, 10 Jul 2025 08:51:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiBnQKyOU9ItMPJPrgQVPScQNEJSbolGEYy2qaZnVPuAr8zwJYLa8LtkWFTwl7pjIeSY0WKw==
X-Received: by 2002:a05:6214:246f:b0:702:d6e7:18bf with SMTP id 6a1803df08f44-70494ee3ed9mr73517366d6.3.1752162707432;
        Thu, 10 Jul 2025 08:51:47 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d3940asm9475456d6.73.2025.07.10.08.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:51:46 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 11:51:08 -0400
Subject: [PATCH 2/6] sound: soc: codecs: rt5682: convert from round_rate()
 to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-sound-clk-round-rate-v1-2-4a9c3bb6ff3a@redhat.com>
References: <20250710-sound-clk-round-rate-v1-0-4a9c3bb6ff3a@redhat.com>
In-Reply-To: <20250710-sound-clk-round-rate-v1-0-4a9c3bb6ff3a@redhat.com>
To: Support Opensource <support.opensource@diasemi.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Oder Chiou <oder_chiou@realtek.com>, Srinivas Kandagatla <srini@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752162699; l=3278;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=t2hjGCARaRQgI0Ustel3aF+sNP5ba1R6WUsBnvpS8Gw=;
 b=aqGq6Wwv3mN+qouYIGF3pJ+rhEvmpUrlcSVA+xDWGeOk1pwtlMf/NqlX0M/HemN2IEuG5nCBi
 JURzf2JUU/1A51p4xURtCdQ1xTp4/K/hH/dOMIbhw6NBEwmj4I/5xek
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 sound/soc/codecs/rt5682.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 7c88370e2dee6a4c2332f1e3db885c980f5e8079..a0abd2ce0c1e1f6cf59fecdd426db16136befe66 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2675,8 +2675,8 @@ static unsigned long rt5682_wclk_recalc_rate(struct clk_hw *hw,
 	return rt5682->lrck[RT5682_AIF1];
 }
 
-static long rt5682_wclk_round_rate(struct clk_hw *hw, unsigned long rate,
-				   unsigned long *parent_rate)
+static int rt5682_wclk_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
 {
 	struct rt5682_priv *rt5682 =
 		container_of(hw, struct rt5682_priv,
@@ -2689,13 +2689,13 @@ static long rt5682_wclk_round_rate(struct clk_hw *hw, unsigned long rate,
 	 * Only accept to set wclk rate to 44.1k or 48kHz.
 	 * It will force to 48kHz if not both.
 	 */
-	if (rate != CLK_48 && rate != CLK_44) {
+	if (req->rate != CLK_48 && req->rate != CLK_44) {
 		dev_warn(rt5682->i2c_dev, "%s: clk %s only support %d or %d Hz output\n",
 			__func__, clk_name, CLK_44, CLK_48);
-		rate = CLK_48;
+		req->rate = CLK_48;
 	}
 
-	return rate;
+	return 0;
 }
 
 static int rt5682_wclk_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -2795,15 +2795,15 @@ static unsigned long rt5682_bclk_get_factor(unsigned long rate,
 		return 256;
 }
 
-static long rt5682_bclk_round_rate(struct clk_hw *hw, unsigned long rate,
-				   unsigned long *parent_rate)
+static int rt5682_bclk_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
 {
 	struct rt5682_priv *rt5682 =
 		container_of(hw, struct rt5682_priv,
 			     dai_clks_hw[RT5682_DAI_BCLK_IDX]);
 	unsigned long factor;
 
-	if (!*parent_rate || !rt5682_clk_check(rt5682))
+	if (!req->best_parent_rate || !rt5682_clk_check(rt5682))
 		return -EINVAL;
 
 	/*
@@ -2813,9 +2813,11 @@ static long rt5682_bclk_round_rate(struct clk_hw *hw, unsigned long rate,
 	 * and find the appropriate multiplier of BCLK to
 	 * get the rounded down BCLK value.
 	 */
-	factor = rt5682_bclk_get_factor(rate, *parent_rate);
+	factor = rt5682_bclk_get_factor(req->rate, req->best_parent_rate);
+
+	req->rate = req->best_parent_rate * factor;
 
-	return *parent_rate * factor;
+	return 0;
 }
 
 static int rt5682_bclk_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -2849,12 +2851,12 @@ static const struct clk_ops rt5682_dai_clk_ops[RT5682_DAI_NUM_CLKS] = {
 		.prepare = rt5682_wclk_prepare,
 		.unprepare = rt5682_wclk_unprepare,
 		.recalc_rate = rt5682_wclk_recalc_rate,
-		.round_rate = rt5682_wclk_round_rate,
+		.determine_rate = rt5682_wclk_determine_rate,
 		.set_rate = rt5682_wclk_set_rate,
 	},
 	[RT5682_DAI_BCLK_IDX] = {
 		.recalc_rate = rt5682_bclk_recalc_rate,
-		.round_rate = rt5682_bclk_round_rate,
+		.determine_rate = rt5682_bclk_determine_rate,
 		.set_rate = rt5682_bclk_set_rate,
 	},
 };

-- 
2.50.0


