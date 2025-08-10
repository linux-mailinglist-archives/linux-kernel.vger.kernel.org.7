Return-Path: <linux-kernel+bounces-761634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5B3B1FCD4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D797C1897A60
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 22:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13042D837A;
	Sun, 10 Aug 2025 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JyYM0QKB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EE8246770
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754865990; cv=none; b=rO8ylTAQqVhFlGO0yb2uxYF5PUxJ1T8LCIRy6pZcOChBtOg2tWtPLu1FKztsE1juEDmqKGUi9ohPueSSgfjzY6dtEcG1pHYas+eO14TM7cblLQXJff0BhGyDWPu88YhkQxKOjAyUxgRmALP3MqzmL3dC8AMaNszXEvfKAEzaOHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754865990; c=relaxed/simple;
	bh=zpxjkKUS3Ja5Hl82pWOZy7M8iozPUZUnjje7JplMAuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IOH2cZEISeyBw1pAbAo4khTr2PJI5Rx1rZxdBaY8AV/XUDaSKjXJF51I3Vy0c+OgRPYaktzKq9Wx9ISw+tIoSl6ft0sOJ9Sr/yZj7++k9CVK1m4gdiL4oiP01KVS6xGTvAkgIOHGfUiy2WnhdRoNsgS00gP6BsFjKLQkchvhcLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JyYM0QKB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754865987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Xg8hqI9hY3cckPk/9kc3e4L3WNhIKfJgnhJhXBVxrY=;
	b=JyYM0QKBxDqkCfPEyyQbS3JULEsxpOXcgFRpKK27DDGUnkpLiWCLaD8DKOvTp62PAaGbI5
	NAPIq5WRL5lCBAvJ3ykE80rx5IBCN6USQEMiuMRlEHChZXxvS4IFPqqFK0byJuxRJ3lfjG
	QXhN8xZn7cuuZ0Gr6CqhSMb5Y47McdQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-oUdgtH4oN2On74IGLRrH5A-1; Sun, 10 Aug 2025 18:46:26 -0400
X-MC-Unique: oUdgtH4oN2On74IGLRrH5A-1
X-Mimecast-MFC-AGG-ID: oUdgtH4oN2On74IGLRrH5A_1754865985
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e7ff9e2738so853565085a.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 15:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754865985; x=1755470785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Xg8hqI9hY3cckPk/9kc3e4L3WNhIKfJgnhJhXBVxrY=;
        b=CAkScDtMAFWKWovMvRYgWlomjBLx0cSXRVQtt+uAr05Cp9AaWisLvVoBXw2hanCe8u
         wvynUKxWe50w0FOC0KF8JEApZKPEAw8QE7S6tWD9w8jjOM3UB+emb2mp1WgUknK3DSRd
         Vnwsgi7E4sT5ddKLem6oxexfZfSZXkcBi3DgzW34qIxufbaIj/MCrPW/cUpCUaeFf1YL
         kXksU3fp+MTMwUtyFpXPBfnHAvZxEBrczHhK0Ox5GAzzq2eu75WH1NwUzqZZQh6pgFjU
         Pe/tuymM2zZg050kx9kBVFO4uDpYcjeFElhIpm+9x6p/SKGF0UhGAdbwWMrrTCHMl6VI
         QvMw==
X-Forwarded-Encrypted: i=1; AJvYcCXcR9rKfpBnmiBmoLxPKmL4FeQ2RdjvnoVo1qNATSdd7f85t/I+d8VIaG//0friPAot/lPBaAfeXbTM+7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcZWHSOI+pTKttlkvFR3AfYLsyRriJi0XIykZked1fGOmcIsL6
	62dH8SNk9yZYKO/rjWmWtAi8HSHrm8QOp4NerS/mBI0A43zPvSsJvXCfLTvMcsOBQzCDW4CjfNL
	4hgL814vC5awlHRFeDiR9RecfqAmLNC1zQJOBP2UJfZwuDFo60TU4n1Er/+PhS4SuQg==
X-Gm-Gg: ASbGnctzOd57wkSEd25Z/OcjEhYz5MsBF9bgVkyF9A6euiflXcyORD4Vo2WdTHZ8cPl
	WNarq7jtTQ87/BO8fyJGXYX6AkTaTsDr2UpxroUbuVsrj3iNsEpEBLQnlw9DEGUA5TQ+b7GtB00
	yj7WAzfv7FncntND3PdA9yLX+DM2oeYcmzM8PxUCX9wJuCrF+dv0AfzcWoJpWUnJ7eAGD18uVqT
	+NPtTy3qAZcNbimyPDICt6T5Vjaw28UWZIDntF3AeRa8NPFTzzQq1kc0UXoNWPJC3wPaFR4VG0Z
	Ez5ohD9HOamq4vhd7nKemqn8oL46JfkXpT0MntAcJdengzzNtnwCDc6PAWEJNCch5mpCqTZZER6
	NgdP55A==
X-Received: by 2002:ac8:570f:0:b0:4b0:85de:483b with SMTP id d75a77b69052e-4b0aed794b6mr191405081cf.50.1754865985408;
        Sun, 10 Aug 2025 15:46:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlcV+VlJl2BMsCB1be7RUmGpPT7LkQkTuorr8gQ4HxbmtzB9yCp//naKxGcJVwwxqJ9LpWMw==
X-Received: by 2002:ac8:570f:0:b0:4b0:85de:483b with SMTP id d75a77b69052e-4b0aed794b6mr191404891cf.50.1754865985003;
        Sun, 10 Aug 2025 15:46:25 -0700 (PDT)
Received: from [10.144.145.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0ad996459sm42685171cf.46.2025.08.10.15.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 15:46:23 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Sun, 10 Aug 2025 18:45:32 -0400
Subject: [PATCH v2 4/9] phy: mediatek: phy-mtk-hdmi-mt8195: convert from
 round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-phy-clk-round-rate-v2-4-9162470bb9f2@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754865940; l=1601;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=zpxjkKUS3Ja5Hl82pWOZy7M8iozPUZUnjje7JplMAuQ=;
 b=TfkcMxwokTO3SFrhfFtRnY/2TB3MjvqVvGnOziGO+YGy6Hi3nXcV6PqOeuN7niocq8BeQPo/w
 8VIsZH9GTQrClIuzbrC8guMQvM6lpDsYvdZ4R19kOLm1cKrdM3gU0VK
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
index b38f3ae26b3f3d8c9e73b43d86510acf6cedb471..1426a2db984d53b91125b18f7725738c44f19555 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
+++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
@@ -418,13 +418,13 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	return mtk_hdmi_pll_calc(hdmi_phy, hw, rate, parent_rate);
 }
 
-static long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-				    unsigned long *parent_rate)
+static int mtk_hdmi_pll_determine_rate(struct clk_hw *hw,
+				       struct clk_rate_request *req)
 {
 	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
 
-	hdmi_phy->pll_rate = rate;
-	return rate;
+	hdmi_phy->pll_rate = req->rate;
+	return 0;
 }
 
 static unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
@@ -439,7 +439,7 @@ static const struct clk_ops mtk_hdmi_pll_ops = {
 	.prepare = mtk_hdmi_pll_prepare,
 	.unprepare = mtk_hdmi_pll_unprepare,
 	.set_rate = mtk_hdmi_pll_set_rate,
-	.round_rate = mtk_hdmi_pll_round_rate,
+	.determine_rate = mtk_hdmi_pll_determine_rate,
 	.recalc_rate = mtk_hdmi_pll_recalc_rate,
 };
 

-- 
2.50.1


