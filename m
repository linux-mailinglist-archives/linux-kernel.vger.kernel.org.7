Return-Path: <linux-kernel+bounces-761638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF50B1FCDB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59591897F1A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 22:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633B62D8388;
	Sun, 10 Aug 2025 22:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EhcIpGTl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305392D3218
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754866031; cv=none; b=lX4QCAk9HSKOHAmDmN5cBBdp+zfNP7oh73VIFRhERhxRxQaAtdAydXXVXI3E6/WDvfWBGq/+BIlT6LAi/RAOkrkk+ByWkg+GArGs+Q2fngr+EXJP9oz/7Smckq3nBnZ56MLYYSogR6QzHDsOLQVhYkTCq7pMUuIWadBkQI1omIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754866031; c=relaxed/simple;
	bh=ndDF7+BW9z3oZgdFS9E606ToKp/Oxm2MLZrOcNPZM6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NybBXyFQlfyhVLyuBd2uF36R6nsOcb0PKzoe5AMQut5nobmrcNdzWUh8ar8v0J7JENFlQtQDctvqKAFQZP1aef8HIopoaCpjMUkIMB53GvdStMD6UBxjEy40r4ELKaaNrV6A6OAm+uFhSo7pqiwma5OzMUX3bHqjqnKMOoAOnkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EhcIpGTl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754866029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMcTNy0e5RVfi5VVz1vP+dp2IXm5jO1AgXXTZDV98Gs=;
	b=EhcIpGTljjgHb/xxiBi6ocFnMvaAg46U9SK7yEDf9/t66p44cRPAUKjieIarXlbe6BIRis
	3mZ2BWNI01wCFSbGiAlpsFBjQlDlAjemL5yigdXQCayXm30wJMJFXgHl80xOFDwzDxnxL1
	UYCjROETwWjuocWv71cUYIel/Lcc6/I=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-PinzZvUjPN-G3ilNKZzGvA-1; Sun, 10 Aug 2025 18:47:07 -0400
X-MC-Unique: PinzZvUjPN-G3ilNKZzGvA-1
X-Mimecast-MFC-AGG-ID: PinzZvUjPN-G3ilNKZzGvA_1754866027
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4af18aa7af8so106702561cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 15:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754866027; x=1755470827;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMcTNy0e5RVfi5VVz1vP+dp2IXm5jO1AgXXTZDV98Gs=;
        b=AZHZ+sIjBiwA8PchlZvyrdQJb/eMpUhGAAJwkl+u6cCn+Q26JkMl9thbohkK0xHS4T
         cCQcieJGt+u5kU29whxAP819I0hRHuZjbykr5FmJqrvbkhrVY97AIcH5KBkC6PnLH0Zr
         Xy5+8VZXqA+jrdqnNTSN9TZMxDWk7YCcDZa7fZRrh2Y62LT5pd/eNWCUPI3nfE7hD1gJ
         BT/2uxxqoVqHMxhTp/eV0lineWMLoLGbjQSWzisil3WBzhmgIzPsBszC5Vh/y8exxlgi
         HQ32+EuZ8EQ+FGXxy/K5HNeWLG3E+/8TM4+VnPQuFDMYHnqtffTtSGcZcrXX2GocZ8xj
         AsMw==
X-Forwarded-Encrypted: i=1; AJvYcCVjBJ7vqAp2onwzf4pL2QlIrINJXC4ofYJCU1AlEnYEe2wCBsi5Ia6DcYGm6oA1ZTWkJLk/d3RV1l5yqFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKvd34ru1LfY4EDsZgVdSL4171G1c1S1ghu9xylThl9ZR5DV/6
	T34drCbAGEcp3EjnNKB+Yr10X4grs8vJ4uNR/YPvID5CcM6+RjhCK0dlWGxur18qdqVt/WjdQ5t
	B95U+pjrfvB73YQk3Hy7dz1NmzfRl3EYxHEbaBLZzkCM1I+qpnu8muCLaYj+04SuFiQ==
X-Gm-Gg: ASbGncvh3dq7fW1AW2XGqamqW14SfIslbgw6v69yHBZqw8MfIvUhxhq7m87Z+HDo1Js
	9IiXQx6TDtgUhtXvtkn4ITTOr4pPgwb+mnLco3tLlG97EQjAFU/oo/t/gNjgIp6WOmANLVeHgxv
	EhU4WUg/1KX8WT2/XXMmZGf3Shx3rRq6L3JaLCCAVYqhqr5p7tm8OTxOsLErPVTbPN1Y5p0qvBd
	njLNRkkkX4cscnsIUeqNMYRoX0/v/9QV3Lj0WBomR+n4XphA/8srO7Q5pn2YeC2HowKDHSq7/fc
	0L5WaAv4y65IPIxwdcJSvOj2Q/wqDqHwwZYkFZM7PTsImjcwaT437iqyCVAtM07xSY8VrzChUDp
	dXlM4PA==
X-Received: by 2002:ac8:5fc6:0:b0:4af:2139:7721 with SMTP id d75a77b69052e-4b0aed6a5f7mr163617601cf.51.1754866027083;
        Sun, 10 Aug 2025 15:47:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHP5IJU8z9koSl05icwsQuLC7xmNyQP3PO70C+KlxY+wzOdhzlnvRlzStjW1m9tN2vsBSQZA==
X-Received: by 2002:ac8:5fc6:0:b0:4af:2139:7721 with SMTP id d75a77b69052e-4b0aed6a5f7mr163617431cf.51.1754866026637;
        Sun, 10 Aug 2025 15:47:06 -0700 (PDT)
Received: from [10.144.145.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0ad996459sm42685171cf.46.2025.08.10.15.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 15:47:05 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Sun, 10 Aug 2025 18:45:36 -0400
Subject: [PATCH v2 8/9] phy: rockchip: phy-rockchip-samsung-hdptx: convert
 from round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-phy-clk-round-rate-v2-8-9162470bb9f2@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754865940; l=2424;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=ndDF7+BW9z3oZgdFS9E606ToKp/Oxm2MLZrOcNPZM6U=;
 b=pM8GpM7PgNX1YsF24F8XlkiAdBklsmNw8Y01AAorZPrlImrF+x3wsR7deHwg6cBB+ANx46J6N
 A3zeH3x5Hu0ChDcu4CSeqRjFPm8eSd0GERqlUeKO53YvLSfbTdxsOMF
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 79db57ee90d1487b51f4ddadde870a275dd7b17b..0d4e578c8c6a08aad355aa8aa5a1cf75c7d354ed 100644
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
 
@@ -1879,9 +1879,9 @@ static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
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
 
@@ -1896,7 +1896,9 @@ static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 	 * hence ensure rk_hdptx_phy_clk_set_rate() won't be invoked with
 	 * a different rate argument.
 	 */
-	return hdptx->hdmi_cfg.tmds_char_rate;
+	req->rate = hdptx->hdmi_cfg.tmds_char_rate;
+
+	return 0;
 }
 
 static int rk_hdptx_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -1925,7 +1927,7 @@ static const struct clk_ops hdptx_phy_clk_ops = {
 	.prepare = rk_hdptx_phy_clk_prepare,
 	.unprepare = rk_hdptx_phy_clk_unprepare,
 	.recalc_rate = rk_hdptx_phy_clk_recalc_rate,
-	.round_rate = rk_hdptx_phy_clk_round_rate,
+	.determine_rate = rk_hdptx_phy_clk_determine_rate,
 	.set_rate = rk_hdptx_phy_clk_set_rate,
 };
 

-- 
2.50.1


