Return-Path: <linux-kernel+bounces-726486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD77AB00D90
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28700566960
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B562FEE23;
	Thu, 10 Jul 2025 21:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="brfZIvRJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05512FEE1D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 21:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752181901; cv=none; b=HKMuiuMIYKQ47b9bBGPw2lzsJ5DwFRzbAuy54ZFvYrBmoUvLPPufdVJ/SPDsuwUc3Dge831XJP8PyIoeYrI2EIrnmIpFJkWh9pTOMAwxMaIyuoQJf9o/2M1LfB4KOV7QHmnKz2JajORoviXYFU4iRU/w/EhbLR7Ao7PtPF9PGNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752181901; c=relaxed/simple;
	bh=VD/h4deqJxDRtMemjjzR/QMh0EFhcWSP+gpO2FdBBQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=msJKHil5uyFbYKv2Czr+JWHDXXHt3f3Wb8SYT5ibKDxDfwhb04nML3MSuwgUzSJCgyTecnArUTmsJbAwnG0iGE0MV2rVD9JKHcz8KJ847IyccXx6spZL07v1gATQxrfhCWrHt3036Lvf5DF51e5QRjPOb8LTvrs07n7YVHM/9Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=brfZIvRJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752181899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t+c4BMiRqhsfmVjVjooOln1HDcuyuqfAoeFZzGp3Oyg=;
	b=brfZIvRJ6Wns5SQihio3pIO36fJcpmhcfuOsDjFuwZaQKn9QM2uYsaXk+ESTv8kPsEwxao
	7Sv8SRQnFdIKChtjreoZaFe7RmKiVv4aPg3lZunDmskCq4qLyj+ZX11JoTTaJIu4L5ROyF
	MaoY7h11JvP7dp3rvEfcW4lz+ZhLgYY=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-R18jUqeoPx2_Qjqjhmjbow-1; Thu, 10 Jul 2025 17:11:38 -0400
X-MC-Unique: R18jUqeoPx2_Qjqjhmjbow-1
X-Mimecast-MFC-AGG-ID: R18jUqeoPx2_Qjqjhmjbow_1752181897
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2356ce55d33so20838425ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752181897; x=1752786697;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+c4BMiRqhsfmVjVjooOln1HDcuyuqfAoeFZzGp3Oyg=;
        b=pSDVLVU4QmQ7dGwfrB/LVLZwJJjCCZenTWyt8LzpPH3h7hzJjaUZbFynhHdumyKV4P
         Kq4xz1ZHS9ZkJZRfEi5uSYFtP12JdfSeoy38lD5WAdxGSeThDyR7pdEwJouJdnawEDAe
         0Yi1bsD8xevH8WAS7LHZ8r+wdAHDrjVuPC/Jf/Z2dvxbGKfRYlNU+wyJ8zYr8ctaDSq9
         WdB5YDg7blXQ91VRKlAjfx7qU/XhnT7IEI2phppMnnB+bsXZ4k4IyzqwOi8oWRWv2aNA
         7D7WpQi8rHP9YfngGJN7fdyw4X4hw8q/RNvcLC5c16oDQ7yPuXkb74HubScZpB5zJBZ7
         umgg==
X-Forwarded-Encrypted: i=1; AJvYcCXkFHlO/aS1PjldCFPJBX/mc/wJFyhsWfm+tSWLO9R9xRy3w5TNZK5Jwt+cFXOXH3KSeeZuKMYSKDbS5Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkJUi8/AWDu0X3DxinjC75BpUTQB2P93CwXzyXgQu/hI1q+2W9
	CY4tZWrOMA0pLcJpc5G6WTFD65Go0S9cUZ0QmlXfvtK5zKevQk/zTBfTZOKRYm2UaQFqchxf2tK
	H6qjiVVA1YxrM7WCARpmGwW4+6AqAVUqYGyiReE68YkDCCXBJoI9q+U2Cpg4NI5jJ6Q==
X-Gm-Gg: ASbGncvO8I00mjynQH7jcTiryhWjnR17kHTjqT0I3mJtYTEvIh8dNVgQ7s8naJ21BZB
	4Md8oP+vmD5iPRYwi/TMURK+/L13J0ahtFlQFZCuRX7iSOg2Ue7Yl83O9zOB2Ryfd30BmYwux/N
	BYa+X0H/6aSnbfOYH1lqeI+XgfEy3tqHKhHZMFg7nla8wGWBCK3XyY3zIuIUEC1dILF3PgC5vbb
	8/EvKqvcNemGfV9/zmqOaPfVeuOGvOV9cS7US32Bx8+q8Nhi/27tBpqabXCVzyWIKLvsJYBoetB
	F48bU8kgcti4JcOzH0tA3sgf6w9cwbeyqZmCbZ0fblZgHg==
X-Received: by 2002:a17:902:d4c2:b0:235:f77b:4b0e with SMTP id d9443c01a7336-23dede8f48amr9643665ad.41.1752181896852;
        Thu, 10 Jul 2025 14:11:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPRMNzco5hMf5jOp7523hX2VWgJWkY++oDzSNhjm8eOYKWsovv/oV4s5Gbjr4r11917Kcp/w==
X-Received: by 2002:a17:902:d4c2:b0:235:f77b:4b0e with SMTP id d9443c01a7336-23dede8f48amr9643185ad.41.1752181896451;
        Thu, 10 Jul 2025 14:11:36 -0700 (PDT)
Received: from [10.144.155.224] ([2600:382:7716:65ad:9491:c054:6f2d:80ed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de433e51asm27790595ad.180.2025.07.10.14.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 14:11:35 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 17:10:38 -0400
Subject: [PATCH 06/13] clk: imx: fracn-gppll: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-clk-imx-round-rate-v1-6-5726f98e6d8d@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752181866; l=2079;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=VD/h4deqJxDRtMemjjzR/QMh0EFhcWSP+gpO2FdBBQk=;
 b=5Ui19/xk/tp/Ugea3+/nwqiHWYk2PsB/qQtwW1y5YoHaF9vuntCaSoAbXSlcQ1cptzIm0HmNV
 83NR/q7STAWB/g/gDErKl6FKo4XjXkfr7vonqPw2ysDmESMhgT4SSiT
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/imx/clk-fracn-gppll.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index 85771afd4698ae6a0d8a7e82193301e187049255..090d608672508a8819dc68eedec5b8d4a2c140c8 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -134,8 +134,8 @@ imx_get_pll_settings(struct clk_fracn_gppll *pll, unsigned long rate)
 	return NULL;
 }
 
-static long clk_fracn_gppll_round_rate(struct clk_hw *hw, unsigned long rate,
-				       unsigned long *prate)
+static int clk_fracn_gppll_determine_rate(struct clk_hw *hw,
+					  struct clk_rate_request *req)
 {
 	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
 	const struct imx_fracn_gppll_rate_table *rate_table = pll->rate_table;
@@ -143,11 +143,16 @@ static long clk_fracn_gppll_round_rate(struct clk_hw *hw, unsigned long rate,
 
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
 
 static unsigned long clk_fracn_gppll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
@@ -345,7 +350,7 @@ static const struct clk_ops clk_fracn_gppll_ops = {
 	.unprepare	= clk_fracn_gppll_unprepare,
 	.is_prepared	= clk_fracn_gppll_is_prepared,
 	.recalc_rate	= clk_fracn_gppll_recalc_rate,
-	.round_rate	= clk_fracn_gppll_round_rate,
+	.determine_rate = clk_fracn_gppll_determine_rate,
 	.set_rate	= clk_fracn_gppll_set_rate,
 };
 

-- 
2.50.0


