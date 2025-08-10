Return-Path: <linux-kernel+bounces-761635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F37B1FCD6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88CB97A65E5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 22:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C422F2D837D;
	Sun, 10 Aug 2025 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFp6fqVy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BC72D839A
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754865998; cv=none; b=GRejtKLYORsamCv7LNhkHljBVRfS1UsK3bWOqfBjhyNB736/YbQqfCSUzveJVLgDQBKg/+4oDkJuz695MfXtCJo+2ujaglZ5PZBYfRyO4aRBjxM6xqk38p2jVQidAVsyfx0nJDKS3+AafQDAwupp7kQy4ZohjlpQMcabdX7Sums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754865998; c=relaxed/simple;
	bh=x3H+bi72Ud0O2ADBCQwtbhpk+18O8IQnZUeD4zYXytc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jqJ1CsDjIJ2K8iKYETKf6kwqBKWA4HSccw74kP/aXZ2jAQSC+JNIlsoFzoI6/NcgL1fMHO6pdD1DrlSebTUTK71pcUiMWYtqVv1wZlQBfLDsKytEL5CADkGLT5Yqb0vUATUbWVCP4OqZhOkNF+omRa8bYfhEhKAX/UGVl3hMKFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iFp6fqVy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754865994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sw1cLvgEhua8i3WpG4C9LAPsxagtK2jeoB8fPKEx0SE=;
	b=iFp6fqVyLh3jXZVxthCwW3aHywYWAyBEAgMSRUjXLVaL9l8S2a8v8cfrVngK+TAqWHvp9a
	noabNTutbDJxP/5XBmd9e4HHM6thN2XezgdDLNf3L51S02pTkavq1a+h2t68OGnrC2q/j4
	NPIdp6l+CJWJ6Qm8lavEdp8N6WNbu8Y=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-KH473wCYOCiTavyAN7Fwzw-1; Sun, 10 Aug 2025 18:46:33 -0400
X-MC-Unique: KH473wCYOCiTavyAN7Fwzw-1
X-Mimecast-MFC-AGG-ID: KH473wCYOCiTavyAN7Fwzw_1754865993
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b081d742d9so149093691cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 15:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754865993; x=1755470793;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sw1cLvgEhua8i3WpG4C9LAPsxagtK2jeoB8fPKEx0SE=;
        b=RhbIUPmI6gfMgTmGrZ4c9aLQ+SvOwnK7wI0VDf5WTaKSA9/SoYqTYhnqA3c0YrXyWZ
         7mSKrWjp5+oP3FZ4itlWWcaSyYK4pWeHCcXqbVzICRgv8Qsh/x58+BRobNUVC+2peI7q
         +WA6ddiSyG4vKI5jEWEV+oBf3LuGAMv9hlRPIAb7dGBTAdKGdw9F4NcKoUy8CrVYbsdR
         rKnPcwIMVpI26ahsd7x7wuGAZess5i47OLWH4G8fYOUg3zxPnFwLQ3HgXvBLqzV6CQkF
         QSkXv5tKzggVMLJWgZaTWNDBQq4OaWJArKvt3KmEg97E/VjTPqk43yi1ApQv8QhrCcCf
         V+Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXa0+S+cwe9L9ZTgMJtprECmhL8j5NXIh3CPYQrflvzQf7L5LcQEPtaFKDX+Jqh7RF4opTc3EnzD2dDgRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYmZRikSxOjuoZB4SYSzmt2rraIUwI4vzvDBHoLKB1EmS8w9Mu
	XOAOWr87IeSDvpVduKHMo6v1kj04eCSKwgXWU0P/bbei7avh1tNrcdLtrwb3kzOGJB3/q4DyPmc
	xSE9olg0w38VWnRUj4LtZOpdcj2pfJGNp/eMDzwFLEBmBut3jvyMm1ZV2jJmeHHJatA==
X-Gm-Gg: ASbGncseZmV3KLryGZBO/hPOB+z/GMxadfe40SowVoARawPkwqB5aBYX4bRWEi7phMg
	dsS5auyxJgqADN6FQxo/CfskDPfsyLPz0hMfxvoIVie6rZeS2f+j1GtrLGGZZd3ACLzSNF/ttlC
	TQs4kQye5jGWbfa15yTSWvViaPKSn2Y/42e63TcaXDxWj8ZZoyqQLNBXS7wtPwY02UoSOiDZ71H
	MWg3v0g2RpAesnqKZSVkJVXguiwwdHuvBCJ7D7hI/Lj/VIqGe3BqiM5aO4cQVX89IJVZNCjkZZj
	Dp76s2XSoEy1rPKauhCZ/wuuDfnxdK2UqQWF5onoXSeQ4VBKClTnUlMQq1eFhmL4UdDsSX5oZP/
	RL+ajEA==
X-Received: by 2002:a05:622a:2b08:b0:4af:1fb2:339b with SMTP id d75a77b69052e-4b0aee5ae32mr145137571cf.59.1754865992938;
        Sun, 10 Aug 2025 15:46:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3TxaNlOm6CWR20thRFc4k1fydx3ZMYAWuNcAfSFTfYY5caqw80RA7wi77MbUh3gKnqnfd0A==
X-Received: by 2002:a05:622a:2b08:b0:4af:1fb2:339b with SMTP id d75a77b69052e-4b0aee5ae32mr145137151cf.59.1754865992498;
        Sun, 10 Aug 2025 15:46:32 -0700 (PDT)
Received: from [10.144.145.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0ad996459sm42685171cf.46.2025.08.10.15.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 15:46:31 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Sun, 10 Aug 2025 18:45:33 -0400
Subject: [PATCH v2 5/9] phy: mediatek: phy-mtk-mipi-dsi-mt8173: convert
 from round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-phy-clk-round-rate-v2-5-9162470bb9f2@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754865940; l=1519;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=x3H+bi72Ud0O2ADBCQwtbhpk+18O8IQnZUeD4zYXytc=;
 b=Ko6nm+pXyNo8X1nQDJr+lVHcu4cXjZr/njvgKDiWI9hUw5g4z0iGWyficBfc/rHylfr1bFBC5
 OcjcwnYNCZzC9mq0m1MLk4fjF5rjaP4zt/gCvk1nnxylsB0GMKTpJxJ
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c
index 673cb0f08959e0e4f2b1ade2ebaf796e8b76f8bc..438ff3605d90121b7bfe02b3ddca8194437ed9ba 100644
--- a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c
@@ -237,16 +237,18 @@ static void mtk_mipi_tx_pll_unprepare(struct clk_hw *hw)
 	mtk_phy_clear_bits(base + MIPITX_DSI_PLL_CON0, RG_DSI_MPPLL_DIV_MSK);
 }
 
-static long mtk_mipi_tx_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-				       unsigned long *prate)
+static int mtk_mipi_tx_pll_determine_rate(struct clk_hw *hw,
+					  struct clk_rate_request *req)
 {
-	return clamp_val(rate, 50000000, 1250000000);
+	req->rate = clamp_val(req->rate, 50000000, 1250000000);
+
+	return 0;
 }
 
 static const struct clk_ops mtk_mipi_tx_pll_ops = {
 	.prepare = mtk_mipi_tx_pll_prepare,
 	.unprepare = mtk_mipi_tx_pll_unprepare,
-	.round_rate = mtk_mipi_tx_pll_round_rate,
+	.determine_rate = mtk_mipi_tx_pll_determine_rate,
 	.set_rate = mtk_mipi_tx_pll_set_rate,
 	.recalc_rate = mtk_mipi_tx_pll_recalc_rate,
 };

-- 
2.50.1


