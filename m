Return-Path: <linux-kernel+bounces-761639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 116B4B1FCDC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5FA43BA0E3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 22:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A9A1F12F8;
	Sun, 10 Aug 2025 22:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErIdCpN5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29FCC120
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754866040; cv=none; b=uQ8Yt6Yd25rxtIfH9mzAZRKd4PY+ZNOZmCuhx2isS1bBHCAPlSphrJsY3O0aXANfwScLPgUIE8CKQDqEdhpZBqVqqzC2fmF7mmm8X+VFO3/JP/kkXClUnNI9eDlaUcSUHzUzCiIc0wTUXxWVXgmhLYmkpFggitpsKnkClZU/6H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754866040; c=relaxed/simple;
	bh=PfVBnMEhY+1VXjQch+u5PcV+HyG2IR2115kG2w+VUSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MTRsOFvA3JbCNG2ypIEvaZ0DPmd6gT115LeI2BSk33+RCw0NVKXO5gUvQ7xDeO+mH/i6ngOaRixrGoNBsELhM/TZHKxqPatzOnZ7HYf3v8mz9kYcT4JjN8SqouEl/wfpGkWMhwBFP9VHFh480Q9aaFvLd6NdbWCV9Vc7ag4WXL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ErIdCpN5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754866036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9LIwrTzSIdW4XyPecxETwMmYAEX2pSsme7PIKfMfdJI=;
	b=ErIdCpN5woDuRf46WenRRCXh1cv7aMfEs2MmF9quTriNwLxYSELM/VC9LgLNH31U62TSKx
	DNB8qkHnQMFF5wgBQwLulWVzleFuj79tqNHM05oVirtP8WscEq43Zr0C/zrDAjCjx3V2b3
	lc4zFad8hUt4LqAotJrLfdQIF8ovpvQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-NcNys-MkM8-bvZRd6tQ0tg-1; Sun, 10 Aug 2025 18:47:15 -0400
X-MC-Unique: NcNys-MkM8-bvZRd6tQ0tg-1
X-Mimecast-MFC-AGG-ID: NcNys-MkM8-bvZRd6tQ0tg_1754866035
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4af156a27b1so152290051cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 15:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754866035; x=1755470835;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LIwrTzSIdW4XyPecxETwMmYAEX2pSsme7PIKfMfdJI=;
        b=m9jxAVyL0FdYGaZSI0xTtXtsREcMzdgf0nFhJz/asIUqNMsNfotYNUN8l65+PL8VYb
         myRvN6oRgpy8655GagiZdM0qhhYWWY+4CsTqQHtK5F49345Xx43AN4N5v2NECIXdj7Kh
         bqZB5yWYi39ufTVa8Pv07YrvZ20djPhBOMuCbiiDXOfYN3BG1Wy7kKGseYMoMIg+M+tg
         qHJL1+zmsl3R2wrBMDB0GOh7yupQsg7Z73AXXPg/bzSrCaIpul7qHNM1dHBqwehuPOu/
         nRk2c1gQ6BTkFm7D6Z92tVtn+pKt9Zth2oyYaVZYN53hC553EO6hKXksRchks+v75tpV
         4qYg==
X-Forwarded-Encrypted: i=1; AJvYcCVlPrrC4sAiZ80RyptFj4EzvN5YLeAX8Vn6YxNuFwSgwdVXOWU7Sc/GibnsdbuVv5dO225jZLt5d/48p7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YytuVmgU7ExzmDpUuq2/lIkW/2ZcuzzMxsaxDkuUKCXcwtpfTG3
	bX2wort7dBsHanjnN4wCg+QjTA8Xp8UHO7TnBlKE2779O58RHV7E8F0hKIiYdfvE6b8xLzZ7LqN
	19onkhNzogvgOKyhc7tvKZkY2GP3p+cfS57zXqF4zopMRxVV8Mj2Z81q6ZHf3Z1aH6A==
X-Gm-Gg: ASbGncuv1CLMsgBXehn5SQTAiddEWmTgRmIvnfKHwIE8RYYSocIXEWMIzEnsFkzmC79
	B7p8FoSS/aH7HkF8KwZmS4dAjJMyL30iBPVnkES5j1EOmSExOqLo0tmlfaWoB7g8xZuxY4v45b9
	Wa5XvVSlMD2afvJkD1ogH+UUnX1hPSxRPrKOAMLn0+AH9y9Nw7jPxew/vmwa+uIW5UqdgWiSd32
	OxkAQ8oW4MOyWZKmrPTA5lTK6bemvVubSQQ48UYMDZ68h9eBkxtDvsT0wHnQA2StmOTlQJL6gtr
	PSLXctOqElMqlKDKRVrOgz6Ubk+XMLyQYOMCv/1ygbb1VUReLUjXyJSmDHArkRLITt35Z8uQGCh
	WnsiP4g==
X-Received: by 2002:a05:622a:400c:b0:4ae:cc29:829e with SMTP id d75a77b69052e-4b0aed983f4mr137421471cf.59.1754866035177;
        Sun, 10 Aug 2025 15:47:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEI4R4FgcBh6uwgYNS05a9B+ckO+bJARHrSqSCTHnGOa6vmcxR/BVXe8/wOen8M9+MhpG9xPw==
X-Received: by 2002:a05:622a:400c:b0:4ae:cc29:829e with SMTP id d75a77b69052e-4b0aed983f4mr137421231cf.59.1754866034829;
        Sun, 10 Aug 2025 15:47:14 -0700 (PDT)
Received: from [10.144.145.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0ad996459sm42685171cf.46.2025.08.10.15.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 15:47:14 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Sun, 10 Aug 2025 18:45:37 -0400
Subject: [PATCH v2 9/9] phy: ti: phy-j721e-wiz: convert from round_rate()
 to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-phy-clk-round-rate-v2-9-9162470bb9f2@redhat.com>
References: <20250810-phy-clk-round-rate-v2-0-9162470bb9f2@redhat.com>
In-Reply-To: <20250810-phy-clk-round-rate-v2-0-9162470bb9f2@redhat.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754865941; l=1629;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=PfVBnMEhY+1VXjQch+u5PcV+HyG2IR2115kG2w+VUSA=;
 b=sL0ngpJvf7ih79HfcU+J6TF8fc534hLr/WKGFEbE4MP2Jf9cX1ovwrN2LEAg3nNaEFb5Q2o2o
 4np7Je1hPi0C73RtTCBtGYON4LSvFYcTDMVZedGa2hpQZpsBbEsg5Fg
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index ab2a4f2c0a5bf3aa4b77045f4da8b0ddcc079f7a..12dafb2bd49bc33c13dd49246bc26df082e3dd40 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -934,12 +934,15 @@ static unsigned long wiz_clk_div_recalc_rate(struct clk_hw *hw,
 	return divider_recalc_rate(hw, parent_rate, val, div->table, 0x0, 2);
 }
 
-static long wiz_clk_div_round_rate(struct clk_hw *hw, unsigned long rate,
-				   unsigned long *prate)
+static int wiz_clk_div_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
 {
 	struct wiz_clk_divider *div = to_wiz_clk_div(hw);
 
-	return divider_round_rate(hw, rate, prate, div->table, 2, 0x0);
+	req->rate = divider_round_rate(hw, req->rate, &req->best_parent_rate,
+				       div->table, 2, 0x0);
+
+	return 0;
 }
 
 static int wiz_clk_div_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -958,7 +961,7 @@ static int wiz_clk_div_set_rate(struct clk_hw *hw, unsigned long rate,
 
 static const struct clk_ops wiz_clk_div_ops = {
 	.recalc_rate = wiz_clk_div_recalc_rate,
-	.round_rate = wiz_clk_div_round_rate,
+	.determine_rate = wiz_clk_div_determine_rate,
 	.set_rate = wiz_clk_div_set_rate,
 };
 

-- 
2.50.1


