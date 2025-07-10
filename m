Return-Path: <linux-kernel+bounces-726107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C514B00835
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05FDA7BD2BF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6792F0C65;
	Thu, 10 Jul 2025 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mz7duTc/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0530D2F0C5D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163707; cv=none; b=sUXH8/YgwV6ncnYe3hydD7xWHqJ8mQijw7KOVZzqNQG59SPpUzJExEHwR1C0cfE5aUsPLMeMcGUGbKTrRbWw+CcYv7bO8oxBQrHz2S7dJVgucBZsncEUhMrORiCyQ0QYhx/sHh9kzTyOz3hO42uu+zctwcLSmYMi1UALl9kDGHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163707; c=relaxed/simple;
	bh=ZKlsIvlM5HHyda796a+VTO47/qeucu/BCMXwHXG/S40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NVIja0o9uSgSgfvPyDKvOPCX8p3k9fRqRWhFgfc+BjsIQO5i7x6aJ6ZnSt2oDHLLsjK1fqpkdX0NAv1SXlpGn3xAnCf0F/zDcQL47kYKLlq+GR3kY8pcs5AcjYTeXQsOHprfsR/WEHrWFGQnp5+DRQekJwzA2e6cIys/LA5BsQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mz7duTc/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752163705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g80E3oSz/omJ6RwmtY0/wAHZ8ite3UzHVCEfpHhebcI=;
	b=Mz7duTc/s2VgEY5xR95Ic+GAlYvyBxKyfOh7VEzaKGULzP/SbIePxexbqQWI+NyAz5iqSP
	+ERRBjif4hiKoWlDfa1QQDP6gIxDXryhLnWcxJ49PqbWtt/LfGLXgvKbf1qoIRXJYsf1tD
	LDxiGacK1csstZkG4lmVG2ks1HB2tm4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-XHmEPXwDOiuoINDgRNBXZw-1; Thu, 10 Jul 2025 12:08:23 -0400
X-MC-Unique: XHmEPXwDOiuoINDgRNBXZw-1
X-Mimecast-MFC-AGG-ID: XHmEPXwDOiuoINDgRNBXZw_1752163703
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d446ce0548so183275085a.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752163703; x=1752768503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g80E3oSz/omJ6RwmtY0/wAHZ8ite3UzHVCEfpHhebcI=;
        b=M9Zv7qxXXycMuoATwcykG7FNSTZC+4uHoa+5Qy5N2z1fSR21+baZH58wBSoaMQ/96Z
         kYigpQRBBLfPxz1vt4ybkmpmrkNbv+d6XFlZ0SPNSUX/qGvADSJbsx0tI1K3wb5URDK4
         NMhzz9CWO5u+Fk5wAeHPA7DdWYzW+aBJulyTFXqYPc8ETxV38sQ2bKn66Py1pbzP9hQz
         TQxrUWXZpcVV9snTWgqmzHJNwZm+l8x5sUZ9RmJIjKeh/wyElvDrspHBJNINiqPEfwaC
         p08uTkG5wG/eOyk9866OZbCE0wbZzRUtTS+Glip5ZO7D4N868Ahx6nvfezVJucSc7Eaj
         6EAg==
X-Forwarded-Encrypted: i=1; AJvYcCXpJ+Jrjob/e/IvL/BAJ+hAB+AyTzjbrxq5GOmWHqzTu1cmnbIjKGSDfjaHofOXkKq6YCdRoIYKbGBdi6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl6gmYsYquvY99JYQQ8ptrsENKY9+HCXvoT6NTHKvPrN/nBMYl
	kQ9ralPnfiZKPmv8sxlVHm8yWeTZSjkE5IytpiEZZcWyKhfI9AT2ambGFuRkp3pcV7mTazvMYwF
	Cid4uwjJiuxmgbVw9sjYKjDAyktAZcwgJs/N/aTMACsdzaYOkqaf9r36eLsV+T0wrIg==
X-Gm-Gg: ASbGncuNW2R4NTay2fhQ2Qs5gSqfzDoU3EJ/OFDEBRTJfVj2jnN2Rthi4GM4ZkvEobL
	DAw1GKX3BxZ6tloyTTyGJocN6r0Ct/F1BOX5rkI430r6obwmPAm1ic4STm7L2PS4kn+ow8ztv1W
	NtKvtJnKHCTuif/uRwsoBYXmlgXVKgfsKkHXCwVNMoZ6VjEfP1q/6X4hFZjJ3Z2zU1qMF9ycvfG
	E43flz8TpJFgAe4iSdbQRkMwt776JBWzv6L7YwbJeVJy9WStPZTa3Zmo0aN05wWlKfVPqhqmzef
	4U8exziXoI1aFnbxCBvVD6fQHsx7hF0qHn9wPxTp3lWR6oW5U66Gqokqtm9F
X-Received: by 2002:ad4:596a:0:b0:704:761c:d021 with SMTP id 6a1803df08f44-704980653a9mr39030236d6.12.1752163703068;
        Thu, 10 Jul 2025 09:08:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdCZQ7W3y8kThWl4w+CnUCECNX6Cyj79KFh3PeC/HpUcHl6P8QBnf3iscE4pNrdpapav2INA==
X-Received: by 2002:ad4:596a:0:b0:704:761c:d021 with SMTP id 6a1803df08f44-704980653a9mr39029866d6.12.1752163702588;
        Thu, 10 Jul 2025 09:08:22 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d39749sm9670216d6.58.2025.07.10.09.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:08:22 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 12:07:16 -0400
Subject: [PATCH 6/9] phy: mediatek: phy-mtk-mipi-dsi-mt8183: convert from
 round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-phy-clk-round-rate-v1-6-0ff274055e42@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752163685; l=1507;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=ZKlsIvlM5HHyda796a+VTO47/qeucu/BCMXwHXG/S40=;
 b=+r3EuMe/pzh9qF2oPdX67HS2VmnZ350abewNM1edJtWvBPtHINXt26quhidSdRFg7SeVLEzsu
 YVJmnDogbgKAaAbXcN1nbXJrSBi27Fk+BJ7qXWfiPpZHj+x2CtpRepu
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
index 553725e1269c9d7ad88f89367dfa1cf367aaf1ce..a54d44ef70ab49937d210f04fdf42300e8e5f2de 100644
--- a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
@@ -97,16 +97,18 @@ static void mtk_mipi_tx_pll_disable(struct clk_hw *hw)
 	mtk_phy_clear_bits(base + MIPITX_PLL_PWR, AD_DSI_PLL_SDM_PWR_ON);
 }
 
-static long mtk_mipi_tx_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-				       unsigned long *prate)
+static int mtk_mipi_tx_pll_determine_rate(struct clk_hw *hw,
+					  struct clk_rate_request *req)
 {
-	return clamp_val(rate, 125000000, 1600000000);
+	req->rate = clamp_val(req->rate, 125000000, 1600000000);
+
+	return 0;
 }
 
 static const struct clk_ops mtk_mipi_tx_pll_ops = {
 	.enable = mtk_mipi_tx_pll_enable,
 	.disable = mtk_mipi_tx_pll_disable,
-	.round_rate = mtk_mipi_tx_pll_round_rate,
+	.determine_rate = mtk_mipi_tx_pll_determine_rate,
 	.set_rate = mtk_mipi_tx_pll_set_rate,
 	.recalc_rate = mtk_mipi_tx_pll_recalc_rate,
 };

-- 
2.50.0


