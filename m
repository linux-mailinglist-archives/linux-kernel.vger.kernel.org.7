Return-Path: <linux-kernel+bounces-889529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB6BC3DD73
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF65E4E91E4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5C03563CB;
	Thu,  6 Nov 2025 23:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="by/RSgi1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sEiSKdS1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4043563EF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471635; cv=none; b=ZHsbB4V54XWBZ1c4EPqTlKfG+ZXRVuPkfe5ND+Fsk8Sa/573+hdY+fKHidKZlsh807zrgBFE+XdKUR5XDnxTZOvdJL6FDn6+QauYSw56kOnSRzGd9k/9R/utE6uGCDgfgWf/fTJi3lL8a/cjWcCaZHRMxGEFON8WqO3ObRYBLn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471635; c=relaxed/simple;
	bh=XNrncR0wdrogri0mOccJ1j7cRKzm0SbJrI8uS65MUBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dt5K5WGo5PES0mcZRvErTGMK5lhBIzKNDjlJBqesTErji9ZzYgME/1FJ+Qy/EWgrAqbufktHIEVLYNEH43chTR/SadM4NuNGZ8b7uC5Bd1wpZx+XQ265o35ts0yZyTA/3PLE72FV6pIj9YH5WOy+te2waJ8TGgook0uUUHYMf+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=by/RSgi1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sEiSKdS1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762471633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBx/RbO8BQMCKJrhX3UVFzNDKA/fgJo016hiP8kJ+pU=;
	b=by/RSgi15OpAY9bfkalQPnabc9ZvyUSmjdhiad1qaAjbyZGJF9U4lDB3Cq5LMbb3AknEtP
	K88SJrWVjYlLkgX+4k0V4Ks/QoOj19pjv8Nk8pYe0Rjy01KsdjVGog3o1t4VHfNoaSCkRt
	xUPD+p3e8ZbsDNeyyxI5QhvyzC1l6IY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-YjIQBby4PTSG4NKt1MIYnw-1; Thu, 06 Nov 2025 18:27:12 -0500
X-MC-Unique: YjIQBby4PTSG4NKt1MIYnw-1
X-Mimecast-MFC-AGG-ID: YjIQBby4PTSG4NKt1MIYnw_1762471631
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed6e701d26so5358961cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 15:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762471631; x=1763076431; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tBx/RbO8BQMCKJrhX3UVFzNDKA/fgJo016hiP8kJ+pU=;
        b=sEiSKdS1wO7WQI/t/RKVAtIS3aa8VrEZ9AGyY+ln4IGR/LcGLX7Ww2Bzncbynjt6eE
         BL3pAP4TCqW6qrHX4Vx0ucsbAnt5kSenTv3rg5sFJCRs0BC1gFdfUys6qoJCUim3YZdu
         kheKxq+KGHmHkRRYLHM+9E8Z/wqT7GVxzWXSskD4mbNohQ4sXPku8NU/AJAyu5YiTvZ2
         vSLZdyrg7aPtrIBHM8aKGcHh+amivBH5kiFclL4z4AZf7+9JAkh303190LRtd9EwSXHf
         4buuDpj35REhoZhaZw5OZctbmXCSr4uC4YlmB6P4MJGIeCubAo3YRM9GwMByeZGycZTL
         +dgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762471631; x=1763076431;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tBx/RbO8BQMCKJrhX3UVFzNDKA/fgJo016hiP8kJ+pU=;
        b=hpiyLgInN02xyVEGlf6iO7EpHkmjtbSPqPvZX/8e25TMynjVg7/ASZ3SyWjCp3Nw0M
         xzH11BAOJrJydc8zm1wPTbQZzegirx/FboNmq+PA9Ey8QvO7BxOH9pY5PG0ZT6gxtkpo
         sIPw9gHlwg+EiutchEzUjciEFU/Y8ON/rjCKdrrJ+koGshQndZ1ttGIeSB2VdrNxKxeb
         AXhY2e+6ESFMgsxM+C/bWoJR3aSq/jv7Y3FrtPCF4AKnEjBM+4QX4+QscQgT2cZlirts
         98D/IVE1ytfCfUKimvGNKkTDPiuznMyrwhgfsx8LqcVLJGI7inaIgB25HDS14USKPtVI
         GV7g==
X-Forwarded-Encrypted: i=1; AJvYcCWjNVvobxyeM7H+1NAW3P0Fv5mCSkCDzTERRhebmzTr2od8Sh5zqqpRNHORDJcj+HJhgVaR8/t07LIF6kY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsi+zi46WC+CFpRo+th8g9RHqQ0Lf7mLN80OFzxVzu18OwLVea
	gPaqY1qiGyR32BMkv2SbgSnc3TicPkLxcffsAt8CjIBsP+UayCmSAh+FgX7AgBXP7HHnZcMtEJU
	pl6w7ekyqPcmzV99jBZoyYl4SuscT20/65xZp6uNbkjNb4a0ffiFAsIR5/mZxVhUcBQ==
X-Gm-Gg: ASbGncvwMqK8x07+Yt0RwSu4JwEPw3Z8+zNgt9gWItmhBW+kn/u1qEjA+A+wtL+P9OE
	Gshg2T6JPT+Oiy5Dl+6yFBaGLM5Dbi21/9f83quTzvi7ZPjCGRadlGdXjsvmEhWC0HPgh6/AsT6
	oVXRKoPsYKRL8Ao8EGjTSW7qfEhNd71Wq+iJLXSn3dMADIrD5Bl9l4ZywKRXVDAsgQs3Pww2rDa
	Sec66w825AdrK1DrpqF6iIlbuyS7Rp2NlImNnFNHu4m1gvYN/pGs6llD8rDCQ/wI4pbrh1YzKXl
	q4exN5TzLjXBZabU12Wn+kV6CFkx9pAOPnBhOy84ogGZhRrdUvprZRusuy60fFm1PI+3Y/NxIwC
	RQyKIELOsWe2DHmqYXTxVM6YQtlnQq1pYbzgeNwee6Q==
X-Received: by 2002:a05:622a:189b:b0:4e8:affc:29a7 with SMTP id d75a77b69052e-4ed94a4c31dmr14935811cf.69.1762471631435;
        Thu, 06 Nov 2025 15:27:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFt4j9euZosp2hZeGEJaF3Zc+V1HHaVy/kAkeKIc2HE/iGD894+L3jbsBB5eqZssh32fH0eaA==
X-Received: by 2002:a05:622a:189b:b0:4e8:affc:29a7 with SMTP id d75a77b69052e-4ed94a4c31dmr14935481cf.69.1762471631061;
        Thu, 06 Nov 2025 15:27:11 -0800 (PST)
Received: from [10.197.115.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88082a3aa91sm27389196d6.56.2025.11.06.15.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 15:27:10 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 06 Nov 2025 18:25:54 -0500
Subject: [PATCH v2 RESEND 8/9] phy: rockchip: phy-rockchip-samsung-hdptx:
 convert from round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-phy-clk-route-rate-v2-resend-v1-8-e2058963bfb1@redhat.com>
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
 linux-rockchip@lists.infradead.org, Brian Masney <bmasney@redhat.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2539; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=XNrncR0wdrogri0mOccJ1j7cRKzm0SbJrI8uS65MUBg=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDJ59RZa/lLcfPtOav3l31tLb3NLLrj9XuLfm2MKzO8eb
 lmSfiJesaOUhUGMi0FWTJFlSa5RQUTqKtt7dzRZYOawMoEMYeDiFICJLLFjZFjls3zG0W8X965q
 XmO0fd3SSvnMpefLahKc57Dc3CGSpOjH8Fe6eEW0erXU1wzZ+KO6q++4quybaPjtwWm7bfZNNya
 mn+QHAA==
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 01bbf668e05ef94e24a3fa11f96f219c4f942451..e5436c99a3c435715358a07da73b4d10d78ef1fc 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -1868,8 +1868,8 @@ static unsigned long rk_hdptx_phy_clk_recalc_rate(struct clk_hw *hw,
 	return hdptx->hw_rate;
 }
 
-static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
-					unsigned long *parent_rate)
+static int rk_hdptx_phy_clk_determine_rate(struct clk_hw *hw,
+					   struct clk_rate_request *req)
 {
 	struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
 
@@ -1878,9 +1878,9 @@ static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
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
 
@@ -1895,7 +1895,9 @@ static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 	 * hence ensure rk_hdptx_phy_clk_set_rate() won't be invoked with
 	 * a different rate argument.
 	 */
-	return hdptx->hdmi_cfg.tmds_char_rate;
+	req->rate = hdptx->hdmi_cfg.tmds_char_rate;
+
+	return 0;
 }
 
 static int rk_hdptx_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -1924,7 +1926,7 @@ static const struct clk_ops hdptx_phy_clk_ops = {
 	.prepare = rk_hdptx_phy_clk_prepare,
 	.unprepare = rk_hdptx_phy_clk_unprepare,
 	.recalc_rate = rk_hdptx_phy_clk_recalc_rate,
-	.round_rate = rk_hdptx_phy_clk_round_rate,
+	.determine_rate = rk_hdptx_phy_clk_determine_rate,
 	.set_rate = rk_hdptx_phy_clk_set_rate,
 };
 

-- 
2.51.0


