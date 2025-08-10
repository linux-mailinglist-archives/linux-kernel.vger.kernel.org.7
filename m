Return-Path: <linux-kernel+bounces-761636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10586B1FCD8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2A6167087
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 22:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6352D839C;
	Sun, 10 Aug 2025 22:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCNb9DtD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14352D8376
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754866007; cv=none; b=mnyhtRTF0IGfO+WjFszo91L/BxKT1geymvq51XXzHhCeAcA0K36Fl1l2pyYV//iGiaUlcsj75mv+B7up3cEtp9GS59mCOw/5eXWRsmh0SKzhNEHlvtqsNsfWNrvzF4v5S/mZt3J+yGfpV3oDDdSOmphRFs9/6CcrEXhXJcAxTFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754866007; c=relaxed/simple;
	bh=tcM4xXKkkn7MFiutyaRVfeJ/7drFohogN+jyo8wqt4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OxTTVSvEzTqKi8ojWXL8Ql3PQ9SRi2GaO1zG0SUf8sY1mazy6lGyO8DEJbksnIuF7VGrctSwjTri9yiFc2t/WjvJTM8Sd1+pV/XBIqsWUHBLXG36t835GZv4aktoBPCdLgv9gj5+Gm+xFnudg4AkxaX6BUtjrCRVF+voMwcVPwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GCNb9DtD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754866004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hq8kcIcUVamqXRpaO0muDR92j7XbTu3OW8hMLpghTgI=;
	b=GCNb9DtDQZEZiZxY11qWu8YIJIJVxhzI8urWBMzeoHU3oxDp0c7PR/qIPodhu/KFSPg3hy
	Xo8Rgq5NyKjnfMTfP2yLe8FRK7tN8ySZElun6Zq1jIr9fu5HT9y+2bRSN1eczOZLm/8ZZC
	80uK1UwIyEMJuFX19J8eYiYW+yBjFqY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-lmJucguuMiydqcV6JMN1NQ-1; Sun, 10 Aug 2025 18:46:43 -0400
X-MC-Unique: lmJucguuMiydqcV6JMN1NQ-1
X-Mimecast-MFC-AGG-ID: lmJucguuMiydqcV6JMN1NQ_1754866003
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e6a5428a76so1248714185a.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 15:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754866003; x=1755470803;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hq8kcIcUVamqXRpaO0muDR92j7XbTu3OW8hMLpghTgI=;
        b=kfUxzyJTzEN3lFbZZkDYi3XWKQOWgqFw9ar/1UT1Envp/VwHqAe/g3UwdNTDtewNMN
         zEYDqSFr5TWIbaEu+19EdKIlbA3rOzbotrT2eVAzkqLJaXQvKM0dtiuYSbkP65UnCvzl
         fEegdOm2rU+iA7loiMcbShZBVwgkVI2uxBGiit7rGMzFGDyCvbMmYUB3vmvug+5A9kZR
         f5J3wPIqTGHJ+ukD6eZo9hnh6csZS/Id4tleWbKULgrYxB1Ucg6eL7olHGfP2KBucNXz
         K30+GcSrkgWskTE6aKFDj2VNcS+HRsedCKvfqsQhEp9QifRzPcC+34prkh/c/5tfwkhU
         YzAw==
X-Forwarded-Encrypted: i=1; AJvYcCV422nofSp0uc7lysAlNImEtC2xOLT/pEMVkn04t747YKb9RUWg/EwFVz4DFdsPoy4mrLIEFlibUO5HewU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd58vvPCYfKT2ylT8wvxgMkXePXBUjEKl7B1feNNJfdwLFGhY/
	GcOhhqHvYRSQQJenlK8DC4utdiGtH56vaxSmqTTIgCFRYlEb0hJt8YjgxUHtM9HIJehQrWiCdtP
	Z+aO+BocpGbF6NzI1/EOtxyxeTjK9e06ptI9cO+GLZoZQcljD6e3Rp7toKhUnjcbOyg==
X-Gm-Gg: ASbGncuCaB8Wfijc+uMnY90R8iacmb7oGwTTQLNBO2yXp7h3QaLTndhp8QPYA3ZutMm
	nz0+lWgIGoREnG7wKScpn3NP46m7WeBrmNfKwX47JzYUyTOWScS8AvaETH2yqcH41CS+OcfXAf9
	dBzbgdUdU5WSOdLP10GHDWe2tim1WSHfOFJKtP7DrYh3xUHgz5oTu2kgAROe2B0a+mZX5NuO736
	VeBIK53jd8c/HHyE/DsmMwfxYKJkd4eaqdEl75BB0ZIl0ZwFwBwdCS0/6JIMVRjTValnVUb31H/
	OTtLAKfJN1Fzb3SwGyb8JZxyG6IP3TLtr4WDD0jxbo4ColGj9YBOivlyA0wja7PcbC8fTgU79DD
	ari6GXg==
X-Received: by 2002:a05:622a:1487:b0:4ab:622b:fffb with SMTP id d75a77b69052e-4b0a06eec4emr195091111cf.5.1754866002600;
        Sun, 10 Aug 2025 15:46:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFh5lS/n97PBNJSxOrFycNhagzbIhlgW9qQ3w8XV40W5m4XhN8ds0cjQ0NNa80CSmcd6Go3LA==
X-Received: by 2002:a05:622a:1487:b0:4ab:622b:fffb with SMTP id d75a77b69052e-4b0a06eec4emr195090871cf.5.1754866002209;
        Sun, 10 Aug 2025 15:46:42 -0700 (PDT)
Received: from [10.144.145.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0ad996459sm42685171cf.46.2025.08.10.15.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 15:46:41 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Sun, 10 Aug 2025 18:45:34 -0400
Subject: [PATCH v2 6/9] phy: mediatek: phy-mtk-mipi-dsi-mt8183: convert
 from round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-phy-clk-round-rate-v2-6-9162470bb9f2@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754865940; l=1507;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=tcM4xXKkkn7MFiutyaRVfeJ/7drFohogN+jyo8wqt4g=;
 b=q0MF517SEn6EZmLxnbXxB6XM3YYpy8tWmSgApsuH3irA3Q16tHw+AsuYoggeySatst9jw32Il
 A73zaG5FOWFDy/zGALRujdwgvPQdV6YkqHRZBcR/ePkMLWkrWepZFcj
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
2.50.1


