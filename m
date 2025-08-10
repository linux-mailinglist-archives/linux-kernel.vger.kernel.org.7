Return-Path: <linux-kernel+bounces-761632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A50DCB1FCCF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A09DF1896E80
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 22:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709772D77E1;
	Sun, 10 Aug 2025 22:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ps/tSGwr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661D1C120
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754865975; cv=none; b=UyzLe1H+DHoo+hU8BHB28XXkhqqFjE2FwX9J6W7rIC6zLpFvkJM/KlsZodv7GGQdemPVcC1XTwftQSe1AZ0XeqfK+lyYl3r+DU14TVOYAT4CiS34RPUZi/31F/GmWKwzcfxB8/5EnoT30T1ZEyqlCP0X6kJsY29sm1YSkRvj5YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754865975; c=relaxed/simple;
	bh=K/vzlwQbHrPXAsE0zMa+ZWELLEN88HFuPFzZqi1CGSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aTHdo2d8HAGV/rBlxNR4jX1NksohAoFLprhMaiEkUcmOhDgvIXykNWXqFG3Xok7rUhdQ45W1g9nfT8J3hHwGD0pmpG2b8y2kVwc1mVrZfSJQfc7w7oQeNaqdzAQ6TBOkoH83FciybjRIqOVio0UNaPgeEDskRkKD7uX5KsBWbws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ps/tSGwr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754865973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uno9AFMoEyhj2DAPDWvWv4t+hFccS8StsfhUFSrHj9I=;
	b=Ps/tSGwrCIvminyGZUwkO38K5LMaP1YDhcaUPpNGsROBDdRNoOWgGNJFHPQ5NUI/rRLeM4
	FoEnvRj2hY8QpykUCyS7Nt2zE7Mfs/KP62684XDDie2f2w9LfceXkakBMGMe7B6xP+I21R
	CJGikGE/cHDQKoQBc2M8tx7i0vjR2fg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-cTXwUITrMsW772L_ZQ6ehw-1; Sun, 10 Aug 2025 18:46:11 -0400
X-MC-Unique: cTXwUITrMsW772L_ZQ6ehw-1
X-Mimecast-MFC-AGG-ID: cTXwUITrMsW772L_ZQ6ehw_1754865971
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4af117ffc70so100691851cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 15:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754865971; x=1755470771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uno9AFMoEyhj2DAPDWvWv4t+hFccS8StsfhUFSrHj9I=;
        b=GY1YenDIBxRG01VINFpB1OLISpifPTIfTK3Ey1g9IxBI/cUxN3DlML+UkhYhaXoXax
         qhjb+dbQM7MCV9pSYLtV1y/KlFUIInBsOcELSNsUR+cyvP4GLwjGYE++PFyLqtvUrOq+
         eSvMC0O1tw904TDYnoJGcbMXro9b0ymWdjNz5vxZzbrUkva13A9t2gwcX9sZQ4bo3r6I
         OUmbh97oZIL5ctd8eppCFyGcg482c35jwv8S+0+hml0ZqqzSEtYmx+q/udPvZ2QCNXIx
         9axo39kIRi2QNRlbz2rg4er3/+si1SsOf07uqt+Iad1wRuK8207KaxXDm+NFroJ/tR7o
         jykQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEO5xo4DrkuKUAiYMD3cpSc7soGl6pAieK+Pf9aM6ixnJs7a9O6VWh3yWa87ZkwzElGo+isJSFubcM09A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRzao/0za7ZhzrWC+I+oSJdKDGzlR6c4AeybjCzBuqFvkGNNE+
	UO6KNtczGtpTZmjleWMASX1ErW98iHKE/U0WpG7ZGkB64vNqsVcuv7VXaV/Elg7kvfWw/f+H7By
	xwQ6v7kjBXIubT2HDfVvGGsvW+4n6W8UTT9qrH9ugnBvHO4D16m+Ss+5C1bS7lvj6Cw==
X-Gm-Gg: ASbGnctM35PZuxFINO860aFjbQoK0JDI9nf1ZUbqItdtBEcjYHlljaKh2wUZNNtwgZl
	DhmWzBvTMyv0D7BBPVGknVrh1l+YyLo+YP7wqvV9LE+p/snBlOMB7XWPjBVXEM45QTzRIcttEOv
	y9ZCLY4hAjVvwMAKn5PgIbtJ/vdlTmxJ7wBqqTXCodfJgUQmJZkdtHnuhR8dMhxTrw+P+/X3jwr
	qkDdLVBPr/mUAFlUm7j5C4Rqrm3u9si5d5u1WTY66eXGofQ3CBHLlgXGxoqBWxU713uz/jZQw5b
	wt1Lk7UdAotCAuM5gYn9jPZQLhxC3AlR+ypD+DMfmSoxjWR8+eRzxUT3g17IZzGi1gp5I0JHypV
	/GtLslQ==
X-Received: by 2002:a05:622a:1304:b0:4b0:dedc:1176 with SMTP id d75a77b69052e-4b0dedc131cmr16273881cf.49.1754865970552;
        Sun, 10 Aug 2025 15:46:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjMTodXpCZJI+V6X66BJdKc/nrAgZZBHfrq0FWIY+BTXEFv3Zqfof1whkxmm2vRWEJM7gJDQ==
X-Received: by 2002:a05:622a:1304:b0:4b0:dedc:1176 with SMTP id d75a77b69052e-4b0dedc131cmr16273521cf.49.1754865970110;
        Sun, 10 Aug 2025 15:46:10 -0700 (PDT)
Received: from [10.144.145.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0ad996459sm42685171cf.46.2025.08.10.15.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 15:46:08 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Sun, 10 Aug 2025 18:45:30 -0400
Subject: [PATCH v2 2/9] phy: mediatek: phy-mtk-hdmi-mt2701: convert from
 round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-phy-clk-round-rate-v2-2-9162470bb9f2@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754865940; l=1429;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=K/vzlwQbHrPXAsE0zMa+ZWELLEN88HFuPFzZqi1CGSY=;
 b=qwO8ilR67ycB5abLTz8lkcaaMraMyT4Kb+y602Glvxo2Z7+fRcKOb5tXSI4yVR6HcJvX+lHrH
 QHpiy2uGNJpBVV9WhaW5knt2IT2dHcrLcTidOIeNTq7nKUw5m+AZu3i
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
2.50.1


