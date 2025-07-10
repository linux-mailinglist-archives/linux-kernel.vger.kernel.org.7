Return-Path: <linux-kernel+bounces-726073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C02B007D4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02D8B16CEC9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4DA280008;
	Thu, 10 Jul 2025 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ItkMz4UV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4333227F01C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162726; cv=none; b=EsTrmk5yJBHjKvdY+kOPdcvsAoq1aTkm1Zu2Zjb/Jl289JGO2+PvjW4wAXIxJ4uouT8ZUgEiD0AAdb/xEvoX60I8UvUCDTEFNrsDczpZmiJeaexUh8mhRsjz/S1skvijKWvsfnHsnGsutJw2YOS4SPKxJ5sm/XL0d75T9s+ng8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162726; c=relaxed/simple;
	bh=vZWFDt1fg2g84/6CbpXmdsOPkf8vAndRakJ7mBAnblA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZACuzQ8eUqnnVfmFsWgk8KHpWt/5cHZp4pYSlbdswJMpnQlUsOnn0+NzHVPyHAbZDxItVZM7sV5FVukOilJAW9262v/xF+StPKeNfhLPM+amaa8O47brfhwwNp9YfdCfuCs57xSi3cPjyV0SyXBKPD7KHH3lY6wRt0V90TYFTFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ItkMz4UV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752162723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JJwHo4Zhfo+XQdxC69KbVscnMO2afRdyYYJQIDGMOLg=;
	b=ItkMz4UV1KnYOz+yXngBIuH4Uznhyojo6DnNGF+x4GKTuRhytxgIAOsRaFSMhbuFPD+fqN
	2MixTpfLTcejy9Sdku4Fij39bBb7dpOSgtTGKOGs97nniBiE+J+r0Bx5In7iZb4r1FNbyF
	L7mRf1LXML+W/vyGCG06h6M47bWRn90=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-fR1s2gggMgWPsOWXpDTo-Q-1; Thu, 10 Jul 2025 11:52:01 -0400
X-MC-Unique: fR1s2gggMgWPsOWXpDTo-Q-1
X-Mimecast-MFC-AGG-ID: fR1s2gggMgWPsOWXpDTo-Q_1752162721
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fb50d92061so16875046d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752162721; x=1752767521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJwHo4Zhfo+XQdxC69KbVscnMO2afRdyYYJQIDGMOLg=;
        b=TYNq0Wfn06LuCwM5v6B79YnM25pcpJC59NuQ2zdKnJSZG2eh/vAfbY0VOXxtFmcHCU
         QeG1xPGbJ0x1w4TE2W41EbseUFABr0YHCZq7AXz4flmTzXYpNzNGgzOaUO9+NRgdEmK1
         /MW0C3IMn5pQDuZb4xMbbpoFRzW/XqHfUXnCvqSyy12YCaH/QCbaN5Q9xb692wm+BxaR
         JSROVTjb1GWnSyaNws/EV7+KMkTJZcQgG0vuSpLi1ireuK+ZaUsMPotNSbU3qkWemHWo
         xkd0X0zWs6LX++KV3MxT4YJJ68wsRmfJY9j8hU9+xFXOLO7mL5GiqyafSbG3bF7lVBdl
         6Vpg==
X-Forwarded-Encrypted: i=1; AJvYcCU0X3SIsqVyCdOs39bEW5MYB2+ipaAPjdgG+R7PHiWgBdSpl7MQSV7V9oTwz76K+fD/La1/m96pz7EXru8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu0AYDMmFeWMIT9NdkYWTM1/ZhkVcwSDwNW/1KNwiK9DVoKIOM
	CmBnxNbJvaPnySx44dcml7eufZEAgJhV9yC1NFFWHMmQan/B6xJfunN7bGxTeVCn7Jql7oIOtWc
	ohwoSbToDqX+ItgWi4XDOQCgtqiVoNjN2l7wikgBy/TuhqMy/cfz1y8kLSORF7S138A==
X-Gm-Gg: ASbGncu57vXUe6z6+71S6QXF6plVDrlzOhOKeoLrSYmL7xYR9PdrEt/EC+FYfHUGIpV
	rjLIqU6sztqfs1rB48xlYr3NzOhDpq2aZeVSuv7Izq5r982HRW9mLYrwYuLZcICjMnwO3rLi4gE
	Ry6XS1Kf8lIZDS2J5r/p6+1OyWQtRy3W7pGM+FpYgbSZJMzXkTsWyaHwkrNbeqOQQ2FfDpdzlCS
	026qVWoeByC/3mkMaYw4PJvQhyDHcrBqw3IQSkyWmVCSr0OwnLmMZFF9kvY21FlaP41hw17QGtj
	VHPiS25xhozQXL9trj34spAnCQvlcm6unsXUGW6a1ot6O2z62MoHiluF0EBi
X-Received: by 2002:a05:6214:27ef:b0:700:bae3:e1a5 with SMTP id 6a1803df08f44-70494f70162mr73492286d6.19.1752162720404;
        Thu, 10 Jul 2025 08:52:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG03Gb2AMowqF+jhr90PyL5QhMQySpCZDY992sVjt31FhV8SI5QbSkQU4E7TgwJWA3WWhabRg==
X-Received: by 2002:a05:6214:27ef:b0:700:bae3:e1a5 with SMTP id 6a1803df08f44-70494f70162mr73489626d6.19.1752162717842;
        Thu, 10 Jul 2025 08:51:57 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d3940asm9475456d6.73.2025.07.10.08.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:51:57 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 11:51:12 -0400
Subject: [PATCH 6/6] sound: soc: stm: stm32_sai_sub: convert from
 round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-sound-clk-round-rate-v1-6-4a9c3bb6ff3a@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752162699; l=1764;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=vZWFDt1fg2g84/6CbpXmdsOPkf8vAndRakJ7mBAnblA=;
 b=qoEKZTVvf/Mg1qqHNBU8HndCgCmiS0GmOJSvOpA45N85Yb6978lTjjiSZ4dbTnh0LPFhTtH2p
 Pn2SWV3e4UADKJGs88lQVhTDLPfehYeojWCySSStGKSngtnmPzV3I8g
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 sound/soc/stm/stm32_sai_sub.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index bf5299ba11c3c95ad89dfb00612ade7ed42b9d0d..463a2b7d023b9cae802f88041c23a9bcc3219a6a 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -489,20 +489,22 @@ static int stm32_sai_set_parent_rate(struct stm32_sai_sub_data *sai,
 	return -EINVAL;
 }
 
-static long stm32_sai_mclk_round_rate(struct clk_hw *hw, unsigned long rate,
-				      unsigned long *prate)
+static int stm32_sai_mclk_determine_rate(struct clk_hw *hw,
+					 struct clk_rate_request *req)
 {
 	struct stm32_sai_mclk_data *mclk = to_mclk_data(hw);
 	struct stm32_sai_sub_data *sai = mclk->sai_data;
 	int div;
 
-	div = stm32_sai_get_clk_div(sai, *prate, rate);
+	div = stm32_sai_get_clk_div(sai, req->best_parent_rate, req->rate);
 	if (div <= 0)
 		return -EINVAL;
 
-	mclk->freq = *prate / div;
+	mclk->freq = req->best_parent_rate / div;
 
-	return mclk->freq;
+	req->rate = mclk->freq;
+
+	return 0;
 }
 
 static unsigned long stm32_sai_mclk_recalc_rate(struct clk_hw *hw,
@@ -558,7 +560,7 @@ static const struct clk_ops mclk_ops = {
 	.enable = stm32_sai_mclk_enable,
 	.disable = stm32_sai_mclk_disable,
 	.recalc_rate = stm32_sai_mclk_recalc_rate,
-	.round_rate = stm32_sai_mclk_round_rate,
+	.determine_rate = stm32_sai_mclk_determine_rate,
 	.set_rate = stm32_sai_mclk_set_rate,
 };
 

-- 
2.50.0


