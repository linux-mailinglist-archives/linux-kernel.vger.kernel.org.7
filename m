Return-Path: <linux-kernel+bounces-726109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2234EB0083E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9DF2188C297
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932A32F0E25;
	Thu, 10 Jul 2025 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bthxsAQC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FC72EF9DE
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163712; cv=none; b=VuhvwVd0h8GEEKz+zh+z6DjtFjHJ+6+GtL1mmPap2enZSvaZMGWn5unsVIiiT3W7ky6tJWm3H591JKSNOAl2ESArdOvnfKrbHBpFapgJgry9n3uokz/4CrIl5VpvrqLaJPuG+MXbhoMWd2WT84nDVP4SDpZd0Ld4731K2MCihkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163712; c=relaxed/simple;
	bh=tFpHMfoqDqhzNTaVv7v0N0qvUtE+54itjjhNS/n95Lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kniI6+F+XxWgo3APq4NJ+AwmGjtR/zmUHC0kCy03KH75a5iQiBXNcy8cH1WIIA/J3/mctX8wZbJDk2D8QAf5EA7rY3Lm7zLeTsDvFbSDX+b24C7rZTd51+bKtGR6QHzdNWZyYQP8tpmBH3pAA2y1UEQ0rIKDJy0TyBKeL95fNAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bthxsAQC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752163710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X6cvCt1VBmJTFRCGYPDZTJ8fBnxpBorEBWf40KWv3BU=;
	b=bthxsAQCXNWwbwvXzaEbn9ouhiJJhyo7t1A+USOxc+7yJV7tWm61ED40srOG4DMAeUdoI4
	tW2jSePqcdxFF47B32ImotU0TsWvC1Uoe1rLqCZC/UCdIkqn+tjNT+NPlBlZrOua9G6BWg
	un4Ul0gJWE7j59ft5jSsmxSaL1GtevY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-VmCm2l05OlCq8aCfl5VouA-1; Thu, 10 Jul 2025 12:08:29 -0400
X-MC-Unique: VmCm2l05OlCq8aCfl5VouA-1
X-Mimecast-MFC-AGG-ID: VmCm2l05OlCq8aCfl5VouA_1752163709
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fb3bb94b5cso18557266d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752163709; x=1752768509;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6cvCt1VBmJTFRCGYPDZTJ8fBnxpBorEBWf40KWv3BU=;
        b=EeT9WDaYUdxAwhN7Lz07i9gNjcrVixAA602Kn8sqIJzQYECiMiJk0NLqr+33pkiV8a
         H+lKLJ73h66fOIVRFKirVHPkD+IhkFlvIF9H+pSLzLS6YbusxfrdUqp//yUWVgsk0JCg
         wHS30conwSmie59P7S14asaZJ5U4BCaCV1mcwFFdDIDK1YlcP17zYpaKHegb6gnEJK5l
         Brli53rOef24UJoXBUV6YNrg7UADEJ+oRNgbQQNqwsCy2XKB6eLK9ibNTtqcoyA/0R9h
         IE5Yr7TfIYFvl5jHfzv093kpfuVbL9GTxsVDqfIjPN4SQ1N94IUdPmO98tagVwK0vVdQ
         lSLA==
X-Forwarded-Encrypted: i=1; AJvYcCW+p8TEAJB9k4AYsyHqpCFoIE9Nb9fEtD4VgjgR3ddmKSshQwjHCrRfMdu4IA1zDL8b5cdIfJ6uGPHBkRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnu2qKXMHVgh9kpcgHE/Gzi7+sURKT1Cqh5SNH3u0PXtRVDcDo
	8hlePd4k9j020UzkJfUJ3c4OJ21UuMCHcvf/rZgfU13mhkVCcQRaZfBGQNTVoibUs6zZPxQckMw
	SbYGuYR6DzYSdXIDXOcPNKdks5SE0F/hwoMiHyShy+5g6S1YE25m26KgUeo/ckDedpQ==
X-Gm-Gg: ASbGncssXd3XvdhuTTj4C8zbmyiPj78itg/jLOdG8DhJVSVe2JnV//DIhvIJqytMEqS
	J5nwzoUb8xIsMmTDAftFi2pRAFdw7UdR8nxSIHEWgMKKGuvSqlj8GR94XycFhWHI8UgFHNiOI2R
	BGI0RocMRs3o5NhvXXUhD0DwoSfxEYSG61PYAmC2TOYMwUs1UYl2VIn1U+G9BU0ZqVBGoY6psyN
	UL8pZSkc/yEDczl2QqOWi3mCL5hC2m0cLRIGVpLpcz5HsFPAn733mCplDxjAAMVu0gA57b1GB2g
	sNKTj2m8cz36DhjiufKiACbhDd/pT7GLUNWrMQPHqOIa/c/0sVrrho3DmcMP
X-Received: by 2002:a05:6214:3107:b0:6fd:61b6:3360 with SMTP id 6a1803df08f44-7048b8bd8b7mr113600486d6.5.1752163708698;
        Thu, 10 Jul 2025 09:08:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7IKnx0oGY6DzZmPHsoNfOxbxEl/6NrEujAZIrZneNt1HGeFa55m0X6zYpF5NdeeHumqI+Dw==
X-Received: by 2002:a05:6214:3107:b0:6fd:61b6:3360 with SMTP id 6a1803df08f44-7048b8bd8b7mr113599866d6.5.1752163708155;
        Thu, 10 Jul 2025 09:08:28 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d39749sm9670216d6.58.2025.07.10.09.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:08:27 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 12:07:18 -0400
Subject: [PATCH 8/9] phy: rockchip: phy-rockchip-samsung-hdptx: convert
 from round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-phy-clk-round-rate-v1-8-0ff274055e42@redhat.com>
References: <20250710-phy-clk-round-rate-v1-0-0ff274055e42@redhat.com>
In-Reply-To: <20250710-phy-clk-round-rate-v1-0-0ff274055e42@redhat.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, Maxime Ripard <mripard@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752163685; l=2561;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=tFpHMfoqDqhzNTaVv7v0N0qvUtE+54itjjhNS/n95Lc=;
 b=e7X3yn2YeXeKXrOkS5F+e0IypwltHuyXsyzMnUIUuprHWBg0Yjbm20ihxHiKGf27VyMww7dN8
 zNFlSuHfbztAbMvbZ4Tm4rj9g4qefWj2ql3S7qfHwrgGweB+1fYDH7N
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 79db57ee90d1487b51f4ddadde870a275dd7b17b..f027d2caa4c2ebfc0fdec08bcebf3f415ff1a064 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -1869,8 +1869,8 @@ static unsigned long rk_hdptx_phy_clk_recalc_rate(struct clk_hw *hw,
 	return hdptx->hw_rate;
 }
 
-static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
-					unsigned long *parent_rate)
+static int rk_hdptx_phy_clk_determine_rate(struct clk_hw *hw,
+					   struct clk_rate_request *req)
 {
 	struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
 
@@ -1879,14 +1879,17 @@ static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 	 * To be dropped as soon as the RK DW HDMI QP bridge driver
 	 * switches to make use of phy_configure().
 	 */
-	if (!hdptx->restrict_rate_change && rate != hdptx->hdmi_cfg.tmds_char_rate) {
+	if (!hdptx->restrict_rate_change && req->rate != hdptx->hdmi_cfg.tmds_char_rate) {
 		struct phy_configure_opts_hdmi hdmi = {
-			.tmds_char_rate = rate,
+			.tmds_char_rate = req->rate,
 		};
 		int ret = rk_hdptx_phy_verify_hdmi_config(hdptx, &hdmi);
 
-		if (ret)
-			return ret;
+		if (ret) {
+			req->rate = ret;
+
+			return 0;
+		}
 
 		hdptx->hdmi_cfg = hdmi;
 	}
@@ -1896,7 +1899,9 @@ static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 	 * hence ensure rk_hdptx_phy_clk_set_rate() won't be invoked with
 	 * a different rate argument.
 	 */
-	return hdptx->hdmi_cfg.tmds_char_rate;
+	req->rate = hdptx->hdmi_cfg.tmds_char_rate;
+
+	return 0;
 }
 
 static int rk_hdptx_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -1925,7 +1930,7 @@ static const struct clk_ops hdptx_phy_clk_ops = {
 	.prepare = rk_hdptx_phy_clk_prepare,
 	.unprepare = rk_hdptx_phy_clk_unprepare,
 	.recalc_rate = rk_hdptx_phy_clk_recalc_rate,
-	.round_rate = rk_hdptx_phy_clk_round_rate,
+	.determine_rate = rk_hdptx_phy_clk_determine_rate,
 	.set_rate = rk_hdptx_phy_clk_set_rate,
 };
 

-- 
2.50.0


