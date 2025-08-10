Return-Path: <linux-kernel+bounces-761633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7282B1FCD2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727953B0DE6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 22:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF082D8360;
	Sun, 10 Aug 2025 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iy58V6RB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A977E2D77E5
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754865982; cv=none; b=Z/sNUXUchBC4oELrziwGsTMO1qF4Js9IYzzX3H2GN9a9P83ORzkuQFaISX13Zy4YAnMUkrk4kGQ5AlCAxFvtwAzd8X/U+hXAm9Jb1DtWFtlpgiw9C8ze87ZH6s5pzyUL4hwlTZy/x7S0viDQr6A7ZVmT6uRcz6GlU9kZhyiisZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754865982; c=relaxed/simple;
	bh=+ttqLK3CCvX22rG8r1u2aky/pyqBIfYJ3wcP4wTqxkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qGr4MZPNmoetg1AICobDAARhUJzkcWjrysKfu4mYdYB0aUQe6mZcJ+cHuJ5D7P0eriUxWB7LS+vpL+bKsCz7/1rOelf2Py7Mk9aGYDr6jmCZa5fC5C22xCZaUXDFAWqBmueiek+87+kpl9lSPUCpQTN/xMBq9HEiltg1sui9t0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iy58V6RB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754865979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CYtRvLWH1nEitW0lp1POxLyrQ3/VdPLRfNjB0vWutHg=;
	b=Iy58V6RBGZiiCVIntGmv0oNMbs9BskuJb37wGIhNqB9MYZoT5IkIzVHKq8eq+DFW4WIdnQ
	s+5//FDhOm7JyGtL+t5SvMYoYn4Xini3DtNkPDl/YRFHdxoHY2971/bkoOZBoqskYQiMxI
	mnx/UGBw9hzgSEFBsRB9Vdv6wF8Snsw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-ilSe1Bf-Ph2OLwj9GIrgsA-1; Sun, 10 Aug 2025 18:46:18 -0400
X-MC-Unique: ilSe1Bf-Ph2OLwj9GIrgsA-1
X-Mimecast-MFC-AGG-ID: ilSe1Bf-Ph2OLwj9GIrgsA_1754865977
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b092c12825so110891111cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 15:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754865977; x=1755470777;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYtRvLWH1nEitW0lp1POxLyrQ3/VdPLRfNjB0vWutHg=;
        b=HNibgtgEoDbhVh8RB8+WbIMLz7lbeNMp4wSCm3xAHlKWvFzTnUPQRa58F1jHTaWvck
         zkzKxBE7oQ+d4Ph8oMswtGRNU8hS80GjvtG5jvPE1RJKHdZIBGlL5c0bWJoct23j6f37
         V8xb6MB/txZffkzDU1c/LMLZnLOUnpcmwZICZYsEzroiREyQpLLj9iZJubGfMsULHNrH
         lqapOme+H4sMNYGEvd0YZfAmFsgR8sg5Zw3A/B85MfHn63UATvrwWpMSDyoFtNBHSmh0
         KvKDqHzv2ErwSdHiGGL790il/+mQmyvwALc3q4/a8u5P2Vn8RtM1QWLJAp5ZkL9jcr3U
         uI3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVx5hbYN2g7eV9Vo4HNHbKbJ2FM3yPd4C6/ItZolvhGmcXx1cEEUB2cMxcU3jnDdKrRzM26p7nophgA5do=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEZYs+8E8axyNIhqy6oQfEbsYbDz3XffljVRFX19Rho7RoEGiB
	RqJZzmMnzidioo/ks3Lah100MKAtQfD8S1uT6SrrczXVVZNMrS0iaVK9gAo0yQmTB0tI+bwZYEN
	BZ/JdzJg6admDsj2yZdxU6IeztCxPQJiZfVTh8L1ICodeB390lcoSloy4m6T6TLWgFw==
X-Gm-Gg: ASbGnctZDOGYmWD4R0kPM+IVfyDtr55EAYqnHgQAwoLea8Vg9rChK1Y3Opxs5cf9w4d
	3U3P5WcVUsi7fOZoxs0kJl9RfTa5dcgI/gEzM6WTvdgIL+7Qfdy4OeWWRme2C0yv8bAmszNMsSq
	Kg8+v/K2e+ncYY9GnsBUpIar9e2OV79FM6k+7JvPHo2B1BF3NCKEuC8MF4CpHJ0JLwMQT6ugptd
	5P5OtkTeCbbR9vTQBwWurS1NQ41HTrqQ3rZeuH3qyJQdsyRSdorr/EYpHPd6U+w0HA3i+dBVjvT
	hyJ1leqwXYC7oXpCh5FWsYULafFb7XCVpzLmdFr0X2gWavoBQ9Dedcx+yVp8pk4xET/lBp1rSlu
	LOLvq+g==
X-Received: by 2002:a05:622a:1a93:b0:4b0:8037:c0fa with SMTP id d75a77b69052e-4b0aed93038mr151727431cf.58.1754865977530;
        Sun, 10 Aug 2025 15:46:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExCDCgOrUi7VTan6/AGqAAE3FbTWvD0DlZHmaitVHPb5PTrx90u14A2hmRLrvSxJ8XKrUUiA==
X-Received: by 2002:a05:622a:1a93:b0:4b0:8037:c0fa with SMTP id d75a77b69052e-4b0aed93038mr151727231cf.58.1754865977145;
        Sun, 10 Aug 2025 15:46:17 -0700 (PDT)
Received: from [10.144.145.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0ad996459sm42685171cf.46.2025.08.10.15.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 15:46:16 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Sun, 10 Aug 2025 18:45:31 -0400
Subject: [PATCH v2 3/9] phy: mediatek: phy-mtk-hdmi-mt8173: convert from
 round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-phy-clk-round-rate-v2-3-9162470bb9f2@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754865940; l=1767;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=+ttqLK3CCvX22rG8r1u2aky/pyqBIfYJ3wcP4wTqxkI=;
 b=3obEgP8yrDCMdOaBGI+w4Tat/8TZLPDL5bV/fvqowKe5RG+J17OP5TtRquid0xdyZAAnUyd/x
 LCD0oPAU7awC9owBT91elCcJ0kc+tWZOGloj7ttnD+fpn6ULYnrgJiH
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c
index d04758396046363ab9edc584ae10bf31e9c5fb0f..58c6596c8c20bdacf96a97709b8f5709f447e85b 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c
+++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c
@@ -118,18 +118,18 @@ static void mtk_hdmi_pll_unprepare(struct clk_hw *hw)
 	usleep_range(100, 150);
 }
 
-static long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-				    unsigned long *parent_rate)
+static int mtk_hdmi_pll_determine_rate(struct clk_hw *hw,
+				       struct clk_rate_request *req)
 {
 	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
 
-	hdmi_phy->pll_rate = rate;
-	if (rate <= 74250000)
-		*parent_rate = rate;
+	hdmi_phy->pll_rate = req->rate;
+	if (req->rate <= 74250000)
+		req->best_parent_rate = req->rate;
 	else
-		*parent_rate = rate / 2;
+		req->best_parent_rate = req->rate / 2;
 
-	return rate;
+	return 0;
 }
 
 static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -223,7 +223,7 @@ static const struct clk_ops mtk_hdmi_phy_pll_ops = {
 	.prepare = mtk_hdmi_pll_prepare,
 	.unprepare = mtk_hdmi_pll_unprepare,
 	.set_rate = mtk_hdmi_pll_set_rate,
-	.round_rate = mtk_hdmi_pll_round_rate,
+	.determine_rate = mtk_hdmi_pll_determine_rate,
 	.recalc_rate = mtk_hdmi_pll_recalc_rate,
 };
 

-- 
2.50.1


