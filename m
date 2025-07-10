Return-Path: <linux-kernel+bounces-726104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF38CB00841
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329FD4A40D7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D382E2F0032;
	Thu, 10 Jul 2025 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwhOn4OX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16472EFDB2
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163700; cv=none; b=BzjOHBWkvfY1Fh63r0js78yE3IfrWAT+a38aTuQ5L09LSAB+Cmb2V+iqHNL3e3FN/aQEZ2w31o4njc09ehPLwh7xPJv92TL691JQ7OQ1UWkrFa+d3VBOed2ORF1UL+G3IWaf08XARyh5z3BDsWWqJ6q6aegOBFR6Bcmpu6xuo8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163700; c=relaxed/simple;
	bh=iJAJsOBdjX5yU2h75u6+b08f3YAfQGGv0k5DSS+fdqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p86TqNOahJvs6JVr8CsKbqhnurAgeP5mXJa+x0p/FtfoBy62UbJ2uYDuXIV0eWwKswjaV7giQ9rWznYLFs+T6DmWCAhYYQSjkMBtCodOb4nqbime373qym8DLWhsYmpn+OzfLYRCe3rd4Y1iQuMrJUMvhO8SwMpc0Fd23Nfkluk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cwhOn4OX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752163697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fJQSlBKA2g43dFqB6TuRxKz7xFAHDfxLS8SwGXWJVrM=;
	b=cwhOn4OX+5TTyDWa8dyDLSpEZQAYidyXdEWqBMhF4xQmUiQhtIByEPV81Dm+3LWDI/aZGV
	LjY4HqKzwPxcea17vB2SDiW0WrgX1LiFiKj5L5n6S69zI9EkOp0Yumepgm+13kFquIsVlK
	PlmoO5vxbeCxXlSNRelJ7YHwAESEwkw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-g2akyHE9NgyJ3PLUhVqunQ-1; Thu, 10 Jul 2025 12:08:15 -0400
X-MC-Unique: g2akyHE9NgyJ3PLUhVqunQ-1
X-Mimecast-MFC-AGG-ID: g2akyHE9NgyJ3PLUhVqunQ_1752163695
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fb01bb5d9aso15760796d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752163695; x=1752768495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJQSlBKA2g43dFqB6TuRxKz7xFAHDfxLS8SwGXWJVrM=;
        b=tMuQVIeCj+hookG3IirudbkCjnqrgc8NI2L1u/6cne/j05AoovmVpsIxp/q0T5NVDQ
         Hg6rs8LJ0Pl2DkeCUqZj8I7kodq+n2Pcdd/rwUEf9FydUceMgOk9un9OCacnBtELIpiH
         5/u+5oGtDPy1TKot/sRMUD115uSALWuC9izFd1H2whivMfQGa8y6kJYay8SDErkRSjto
         qMNPM1UJGphCfUzBiI1jUaGHQTxGiNG2SO9XKUrBXVsUFKchiTTboEeYFBc2mgKLlVuh
         lF+v8vGvEyKONDy2qNeALsMMtJ4PYcKF9fkKCXXsO1pFDMwVykBjROLSYlIPB0C97Mv7
         nToA==
X-Forwarded-Encrypted: i=1; AJvYcCWUsNSPUxgSWpaQ89YkYyvGtNhbHA+1verGcnOXv/CuvLXT0Nk3hGxMU9OAbrmd045eU8gga1lgpGgSs6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUu2dy0S8NF+jEyny+8Gu7ytwz/XWesGlwYFwIG39XY9IisX3H
	+o0v/GveFqxMT2MrnuJZNryaKBTAsEIjSKCMIZpPnTbyXV3EBmfpuGK2rQ6OWZSn5B66dynuKrj
	FArgKdzZrcaY1x3zrwcZcUlK78FVvXMjjbjhQQiipbbVS6EllE0ECx2YJ6ik9E+sWPA==
X-Gm-Gg: ASbGncsXWuaylwrR9FZgQFIW3bO+X4GtJuhIqJ6gV4LWsNK0xpADK7Ar4E0XhLeANM1
	nU+NUeSAfXmVLtLriVnkPvA90fr2zg9HI1XLPmuhWDrsuE8U18r04FKipyGEwAYKndKslxClLzg
	34Dex0Q+tJasnjOfrv59tHG9RDsWe5T+d5SZ6wbi+mbApmdSGnt9kiGx93XspmTI3226PwYgR0g
	fGbpT1qoa/RVXMTbd6xHcvc6zCDu+gSzbMLtYTdVr7LL+kge8OyMhr6ayQOiCda72uBBwjXvPqn
	fa7R6A52G34qjAHobBEth4POFGY5JMmsqj/gRaDRxxbyL3zhYsM5LnQsicvI
X-Received: by 2002:a05:6214:d0f:b0:704:7dbd:2075 with SMTP id 6a1803df08f44-7048b79dbe8mr93046946d6.0.1752163694481;
        Thu, 10 Jul 2025 09:08:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEInLStwo1lDSg7F85FMOE58AhksEafUcDFpNGGZphskAtBc03MrN1OcVT08c+bAzB2AxSVXQ==
X-Received: by 2002:a05:6214:d0f:b0:704:7dbd:2075 with SMTP id 6a1803df08f44-7048b79dbe8mr93045996d6.0.1752163693579;
        Thu, 10 Jul 2025 09:08:13 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d39749sm9670216d6.58.2025.07.10.09.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:08:12 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 12:07:12 -0400
Subject: [PATCH 2/9] phy: mediatek: phy-mtk-hdmi-mt2701: convert from
 round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-phy-clk-round-rate-v1-2-0ff274055e42@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752163685; l=1429;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=iJAJsOBdjX5yU2h75u6+b08f3YAfQGGv0k5DSS+fdqc=;
 b=gM9Vog/PjfK+PD7kK6yqe+FHMUUn8OmRYlp0k9f9lt5ka6hie/ovQ2orPiYAUbVKPreNvVHLO
 BW8lUYOkRwPB/LUPMWdxoK3stAq+kbRSdWnBg6NGEyKUO9GNQDXxSDY
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
index e51b2d13eab473dddace48c75c2a8d73c8c65635..b0b6497e7eedcb6867541b573d22156ded29a4d5 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
+++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
@@ -90,10 +90,10 @@ static void mtk_hdmi_pll_unprepare(struct clk_hw *hw)
 	usleep_range(80, 100);
 }
 
-static long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-				    unsigned long *parent_rate)
+static int mtk_hdmi_pll_determine_rate(struct clk_hw *hw,
+				       struct clk_rate_request *req)
 {
-	return rate;
+	return 0;
 }
 
 static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -170,7 +170,7 @@ static const struct clk_ops mtk_hdmi_phy_pll_ops = {
 	.prepare = mtk_hdmi_pll_prepare,
 	.unprepare = mtk_hdmi_pll_unprepare,
 	.set_rate = mtk_hdmi_pll_set_rate,
-	.round_rate = mtk_hdmi_pll_round_rate,
+	.determine_rate = mtk_hdmi_pll_determine_rate,
 	.recalc_rate = mtk_hdmi_pll_recalc_rate,
 };
 

-- 
2.50.0


