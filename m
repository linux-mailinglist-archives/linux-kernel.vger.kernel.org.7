Return-Path: <linux-kernel+bounces-889530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4288C3DD7F
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DB4F4E975B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9991351FB7;
	Thu,  6 Nov 2025 23:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0/4RRD7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCTfgydq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B203570C1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471641; cv=none; b=AhadtP+cgCUHOBesNdXOd0MzjycnTE0MnZUZnaRPEi1RfMY6lDkr1L22O//3TRiheEQKBprLa9RiSRRd0pGYPOzKn1IFVb/ozawnjmLsXpgY+pQ8KcXptRJi44Z+lYmSH9ws7BaAR1ffsspnLI8zOp+I0ZrZ3QZ62OUcojTLtxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471641; c=relaxed/simple;
	bh=9iXptdlJzmQYbdsB4jJh8DRjbxMfRMBdZBM5EQuFpPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k66QRO09sHMFIzwlRO0lbNHh/UkSAbtsrI+LTv25U666+Fmaq2PdRZ34v54m0q9k6CsLfICFUFW9zvc+pBimEDamz3porKiwoNcnE3Ua8riMvDFf8E6NK2bIdH1qigTQTvQoueVOka1NXbsejMZfELz1R7/0KB85bmnrB9nck5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0/4RRD7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hCTfgydq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762471638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9L/sBg5p+zCSkuU8Rgk43t0p2SpxKRb70QYldBV7fzA=;
	b=M0/4RRD73TOjOC/srL/Zti/d6viNCFQvtfaa9Xoq7aGJau98zKpF8t6uqpZMsdzPrL4fGF
	HsGKd0baB9Gi2GuPLRf3mLgnNEUHQYnmhEUUgAwjGsOFY81lI8RvEnxKBKpDwO0kXh6gUX
	5/PKn77fFbON30fUt9NrWZQaUhZGec8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-4dOn_i7mOuiVqmyChtaPHw-1; Thu, 06 Nov 2025 18:27:17 -0500
X-MC-Unique: 4dOn_i7mOuiVqmyChtaPHw-1
X-Mimecast-MFC-AGG-ID: 4dOn_i7mOuiVqmyChtaPHw_1762471637
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8804dd4acafso9004076d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 15:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762471637; x=1763076437; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9L/sBg5p+zCSkuU8Rgk43t0p2SpxKRb70QYldBV7fzA=;
        b=hCTfgydqWcpYYbxDd0JnTTJLuObO8lAvPKpDfWwnE/KMASe71mBMCgsnGPjWHot2Q9
         X7wap079XUmaubDxACq8p8jF7Rn4sXYZRkhZyMBEKuYs8L7w70sB9Yh992yU+HW21Jdz
         /FP3NSp/6/JHMNAu9RuIrGSqVdKCkZnmzF+0Sz0xhOxFXJv3J9aDKMGSC1BaoqkpBn0a
         gAS7JJVcaQSuZUM4heXfun3SYqgyuxK2bCCL0BiBxUZGnSRE88NNsSDrDgNzSKLRpyVx
         iGd4OJAFwaGJ60j0B7ne8Y01hrubU86lB56HxBYepkRJn/INxrU6INqPVXktExH7u++B
         C6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762471637; x=1763076437;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9L/sBg5p+zCSkuU8Rgk43t0p2SpxKRb70QYldBV7fzA=;
        b=ONxbTIzLOYZwMYBa8T8OPypj/s5POdRF88FubKsDhzNj5c12nV4S2BbelsD+oRkxcn
         DEDNn5qJl0uWlWllk11k2vsqSRjhSufAOaVuqwiynO5PqiJrKZxVdzDf/Lf79SKtNnjh
         Y+p/joqL/j0zqNLLbuk7DWI2SPl0u5AWBcHNoyJ1Yz2veEpj96DndH8ghgGJ6x9ajcSF
         f3tBmsdxN7LaLcHbcz5Sa36JEBZH5hWPSVPlcu4JwX9P58SA9EoTUQgugXjI59qT24DU
         Zfu0RhTKZGrimcY5970PWh5RSeCJoq2JlL8fL4wP5eHhXK50b7STbiumv3v7kwWeT1Sp
         upLg==
X-Forwarded-Encrypted: i=1; AJvYcCXYk1dW5zMHxcYXFEAH6u1m/fBtuuar/8+glhQcd4DFDJ3/NnrX5fPbKxm6RCyhru+EjzYzfpjRShNSliM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1cW3ZDVaewAKkVTIlWCLCz4Ko5Wsf8BUWclSlBg4lCNc6DLQi
	co/NpWGiS5deo1oe2cCldkbpVjFaTnrKIsCEwmKHLvF690ZlBg0PF68cjXMC2ItFsMV31Ak7eyo
	bAefgo4SRGUf1MgXO7iVnZU7dMq8wnCOSFvePmmYb1qC4BO9VzVLTesEo1QdF4GCjAw==
X-Gm-Gg: ASbGncuKu4PP654KAifQYbVhxQVjCgWFFxjJL9zXXuAkj2yZIP7c3dFNjvdIIVgSyOT
	WD2uXmr1Cv+bAS2maiTnOMwmM/fbICj4YrUD1tZXJ5SOlfVQT0L0V/9RKQbh5HBY7+xpvic5L8/
	L6mRTMm+a5fCI77w1x1krAdZUq/JOl0DCqDl+4wNUZQ0JbUQrrdpBA7hNz5mtKwJuDekiCLSO0C
	uACNWT+rGKz8AeIR1ABuQEFScSVPd9DDNrYRfgQXb/8ELPGXRuPUgP6bbQZaqboLeAbRRYH6dIF
	+7MQr7GWLM5GKXAB+qoV0tvHZn/g9uhylXKxFRaRhDquwICGH5DowDPXA8RnE/hEwPPyhBCQccX
	l4bfnVNCVABxAvgSj8GwJD9IZsaNoj8kCab9PnmkIbw==
X-Received: by 2002:a05:6214:810f:b0:882:2b58:af05 with SMTP id 6a1803df08f44-8822b58af3fmr5877116d6.48.1762471637086;
        Thu, 06 Nov 2025 15:27:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1XCrROxUSSUDeHa7EYXOjY7BlUSEU+1KN5k26BLJ97420LzOY9XBUmBbdolqjriVUn6gaKw==
X-Received: by 2002:a05:6214:810f:b0:882:2b58:af05 with SMTP id 6a1803df08f44-8822b58af3fmr5876876d6.48.1762471636685;
        Thu, 06 Nov 2025 15:27:16 -0800 (PST)
Received: from [10.197.115.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88082a3aa91sm27389196d6.56.2025.11.06.15.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 15:27:15 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 06 Nov 2025 18:25:55 -0500
Subject: [PATCH v2 RESEND 9/9] phy: ti: phy-j721e-wiz: convert from
 round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-phy-clk-route-rate-v2-resend-v1-9-e2058963bfb1@redhat.com>
References: <20251106-phy-clk-route-rate-v2-resend-v1-0-e2058963bfb1@redhat.com>
In-Reply-To: <20251106-phy-clk-route-rate-v2-resend-v1-0-e2058963bfb1@redhat.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, Stephen Boyd <sboyd@kernel.org>, 
 Maxime Ripard <mripard@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1629; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=9iXptdlJzmQYbdsB4jJh8DRjbxMfRMBdZBM5EQuFpPo=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDJ59RbO/3Cz6ImvwxqVjjs9Zh9cXkt4xi/3tFVrrZvCq
 FzoYa7RUcrCIMbFICumyLIk16ggInWV7b07miwwc1iZQIYwcHEKwETctzMyrN97Xj/FqOTyx8Oe
 BVe/fe0KOWr9ZnGj8AlvNc/C2uUJqxn+p125kiPwTLJszq/Ph01tT7ZsTxc15DEN4BHV5fj7Yrc
 TLwA=
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index a8b440c6c46bb0c754845655f9c2c0ba6b435b8d..cbc98d4dec74560e6403fb899ebe2bb916440f45 100644
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
2.51.0


