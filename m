Return-Path: <linux-kernel+bounces-726105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA19EB00842
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831514A4FD7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D7D2F003F;
	Thu, 10 Jul 2025 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKctWFA1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D4A2EFDBE
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163700; cv=none; b=iXTuv1r/pEhMJn5B1rcjB/fThlvjZHGQ52Rdrf5mPbaU2H8/jEv9peO3RSV1+7j+6OUxjKyS0epzUYF5tunAH5nySa5qMGvQu69qiLt/hXzfmwxazL9AgDMpwSYAQ4rygFgna0l7Mtzffoa271TYE/q6SvjMqvCB7ngsNJaAJMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163700; c=relaxed/simple;
	bh=4qM0ky7zv1CT6MbG0sETVffzH28Znb5sgT9aMpTi5PM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PsIfjzT7ELrjsG+GVNA3znTkYJzNo9CJkTdO5spR203l3OJ3ctGYgOwLSROlXq+d5SsLUhgQl3XWZ3x7b0ePaa6N1xeVERzJERXW7OkIX1gGAWI85UPfSdE6rKbntJyczQh5epRB1W2t93c98ljOKoXBNJTPwHRQ7lWcwb5AsX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YKctWFA1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752163698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Em92yw37YUfd/ntHD3Imspo2RSo4KaG6Dl0swLQCNKk=;
	b=YKctWFA1oODu5ckp64+DR5I+OEvHsv9fhZn/ZQndyaMzW/Gx3FGdbmG8p6ddWVp6YW3uBI
	J9lBlyYItv2bWYB9SHi1Ep/uxiJ4vutKVApwMQcQ4gd4f3PNfHS3F2j8GXnzKb6BFEET8o
	GyXK16EIjpWLQchdrh+OIh4lVQGwDLk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-TfAEGjQeP6-DOX93pImh2w-1; Thu, 10 Jul 2025 12:08:17 -0400
X-MC-Unique: TfAEGjQeP6-DOX93pImh2w-1
X-Mimecast-MFC-AGG-ID: TfAEGjQeP6-DOX93pImh2w_1752163696
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fb5720eb48so37319306d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752163696; x=1752768496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Em92yw37YUfd/ntHD3Imspo2RSo4KaG6Dl0swLQCNKk=;
        b=kdcZys03kKZtquuvVlf4vROpFxzIqvtlY9+U+emNzZ3NIULQlrMuZ0vMQM35RXtZp+
         JF0hXyG81DDG4IV4Svm/6bVIMhm7p7Ix1EjeMxBaqI/4iFt36Y9WBk62oW59iWHoJsQ9
         jTQ8CCJb4LMww+zI3QfVAVDG3e+9he5icJx5PHe1gborxvzMXZ8HskLn6MZNOHe/mugc
         oQqYlRqwA8igiU9x6tzMnBtiaQMr3/ERgbR8LzF43OLIW808upcHw+R056MCSdY/rYck
         EtlGO4d0ZzNV9SPLWgEts04czGxe5CmZvhZE9XP6auBwxWXJDeOCd9utqRDDIRRt6Mem
         EvMA==
X-Forwarded-Encrypted: i=1; AJvYcCW3F/z0wD7Y+ZqbTJ9nUzcZDdJPuuyT51rBKcRV/LKhJvDJmiZDeoKnztf2wCWJkUr2sw3YjxhDq6tVgyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAj7d2DHf669EsxiyOl6kCacw1gxoHb0Xsmy1FfLdGwTY5ussD
	AZNRHiNIaTYnpk3Ly3nGvvomlVhKBTxUJnSkXtvm15J67/rah0twmNXweRCTz4KEVOGhHmfZQ7x
	DpwFn8XCZDOezy/QL2Oy4hfj3X3QpJvAcBO7DuNQvyeO28wZbUoOIrq/rbDep+vO6/g==
X-Gm-Gg: ASbGncs4EHhLFpEWqxVdnx3rI/RNtb05S6RhuAgF+PIc2JxWqDenZocLD6leLRXYTpB
	z5Kvfs1oQKWEp5dJPdXE6CEaA3C2DUTlnpodtrCayyeWR0BsgJ6uYL1jb1NsCVuQlfI+TOOx46l
	DIUAo5fnSZEu2scHO3AfWl2AOTmEPkapINLZzarMPA4zpkWQ8HCHnaZVOzF2q8Ig/ZwB17slOyX
	RUhDFftaA4UlAEpB4KTOriwAkbhnmfaqVGu7ZCbhwPhp0ClXFvAYKrq0y0zAWYAuo9BqD4d6I8O
	+doCWEWYP0qpXi0OHaWP2V3xsfJNrjpGpT7YLQ6dhNEU38yH23dWYSgwpzBK
X-Received: by 2002:a05:6214:21c4:b0:6fb:6913:868d with SMTP id 6a1803df08f44-70495b03340mr56700586d6.22.1752163696313;
        Thu, 10 Jul 2025 09:08:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLcSXwBvzMgHcxvaGx+jxenoScUgyuQu1/XLMH/JsUnJsRg9oDtwMu2U2WZdTeBYZEBbFhcQ==
X-Received: by 2002:a05:6214:21c4:b0:6fb:6913:868d with SMTP id 6a1803df08f44-70495b03340mr56699946d6.22.1752163695850;
        Thu, 10 Jul 2025 09:08:15 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d39749sm9670216d6.58.2025.07.10.09.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:08:15 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 12:07:13 -0400
Subject: [PATCH 3/9] phy: mediatek: phy-mtk-hdmi-mt8173: convert from
 round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-phy-clk-round-rate-v1-3-0ff274055e42@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752163685; l=1767;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=4qM0ky7zv1CT6MbG0sETVffzH28Znb5sgT9aMpTi5PM=;
 b=OlOFj1qtOHlC4RTSWWBUoK0UK6p8kJw7bEiAXyh697CDgkPWtlCgHYWxO4MvlcT4VtmGy896s
 MhkQvLZz992BJ4ENElsvaaczY9Qr1s/zBYA7f5mWOE8/m/uo3t62K5q
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
2.50.0


