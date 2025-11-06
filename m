Return-Path: <linux-kernel+bounces-889525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 612D8C3DD5B
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE0174E8B80
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE587354AF6;
	Thu,  6 Nov 2025 23:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iee1nDl3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0bBjhGm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE52354AF3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471616; cv=none; b=O9uI1Cw6RRckQdd0AbO/63PZx+LejORFZPnmzb9tulyCTZA1KFgXPY4wv8DAFWNmEUmw4VZezUdU9yKcF9qypGHSvLp8M77tPca+ypF6qtNvbUz/o7T1gnG1uHozMWkDwlm3polMw9KkRW7e/euaS/Kqh2p24ezcDtgD2YRDC0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471616; c=relaxed/simple;
	bh=9vVtfY2SWJyaK316COu6cQ1f5v68xmVdCSUMuW44eRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N/K1QVrQiCcXFb45ExxOVYVd0+6yeKp2qAxLfMcoFENLT5ImMcYvkg2WzCLUwxxe9YroABeCNcAUetDusvypvHSiG54JhnIIRF+wczOW4liPcRbM5t+vPVLVX2ipf3btHIMGjoj57LH8knPD+jkBajTjgFUXQZhv+25qdvhp7wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iee1nDl3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0bBjhGm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762471613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r9SkuM/Zk54theYuUVPDuK/7cbD+hyZrLpLiRrTyy7g=;
	b=Iee1nDl3YvDzn3k1NbkeaV8bei06jIM0sQLQBT08pxcMW7jeXuGWd9hKzdm1J424TNdpCc
	zWBrUm6PKshOvTV3Vz9Uj1ORNyDsdtxiri5iZBFP/q2gcafwavOrQ+YuC1L+YL4LE+aqCI
	Pbftxkd1OLmigUbtJcBkwkSFBxP6/Ws=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-FI4nLTieN828oIJhgHRYAw-1; Thu, 06 Nov 2025 18:26:52 -0500
X-MC-Unique: FI4nLTieN828oIJhgHRYAw-1
X-Mimecast-MFC-AGG-ID: FI4nLTieN828oIJhgHRYAw_1762471612
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88022ad6eb3so6543696d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 15:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762471611; x=1763076411; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r9SkuM/Zk54theYuUVPDuK/7cbD+hyZrLpLiRrTyy7g=;
        b=M0bBjhGm1G+o8GjbnXYTqlJ4RwVBNpSuUucCRHhWo/6awm6UydSvfEZNm5o0CC+kDO
         v6LrAOX9gToVe2dYjksPWFFg0HB72qRpRKxBpe61NPkqxY37WoIoUYNeK4cpMpR/P7WP
         RuxWeIKz+RiqQDMbtqxLK2bTmM268Y6FErO0sQS1rLj+XbaoC+kHExjgtruHrEO4xvQc
         3xR4luVQKsclv0WdN0KykEFuOu9uQz61UQb1ONFDjhpIrpHkPXgKyk/KHnkgEmqPpez+
         N+KmamCnSJXQSwHJIaVWk5GmEuDYeW1qz3qdZ4e0Ieb10MBsR4X05YZG7x4SygSsgbU3
         aNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762471611; x=1763076411;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r9SkuM/Zk54theYuUVPDuK/7cbD+hyZrLpLiRrTyy7g=;
        b=BQdk5bs+/rnzwjH8YO/H48a0mfmW53VGapz4U3gUz/LF7RaJi03dtqhpZmFftcIxeQ
         rDsRJsRhnP1dBZvgSqTI4o3tVKgXGpapjmt3DQd5UkxSqldqiB6KyEUKVj1NQx8ODvTU
         kVtd/zvO6w7pBmHxJhAvD1ap1O0KcnIg3f5KaSLl0XZWn6l7Md6HhRxmV3y1bwKTZ5u7
         0HFaqEqhqpX9SzUw4D/DLXdUasqFr27N81eA08HgLZRgz1sPdaVw2Rp0HOAAUS+SrJri
         OLxM5h2iKCZuxhpO8Zr1Ckh5ra9yMz3X4nGgBIBXpX6mdyH8i4W4rgs3mH0aquS1aKjX
         JTCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+vU7w2MwhFmchNV/5s2z3KpjWyBFjyhLQJRplpVT5zczI5b7te9CwvEUVpB0uUj20+rXAcjQoYu13hKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD3LXbQcHK5uIP3KOvwTqKwdmdfzJE4PAtC5oHDyk9yWj/Hbvr
	1EhDWwZxRRK6QnzKn/KBNYgVVfR7kW5mzewggqISazgnrgXScuem3JAiFHdhenDRnDc2puFXQWO
	W6/SpBYogW7XqEy6ZaP1eE3kJXrcR5lN5tpesjUt4cWa+kcQHgLaMsyLcEksagDxit1bHDwUmmQ
	==
X-Gm-Gg: ASbGncv7tT8TjLAPN0HxZJRt89IAN4kfxPeevD2dzjccFD0iKesDuBXEJMAwZDf82Da
	URr17QSfEFfvnFezLclL8rcuyfifzJjDQogSEyyTq78fzmYqDHwQ3T3+gy7x5WR6o9+B8CmfkoM
	ZmsZQnTm1X8NnkufYCDyCzTAdI+JW1jyb3QWWVwyabNVyTzyVdlNFb/5M1QZd0kNhR6aYBihYVj
	VII/eJuofxTGvNYJ/c+J8Z4hFQ0Mi4yjUt2Not8Q5K27ls+x/j+v3aqOrWvig/zcRaKGe+x/7Hu
	/A9xrUmWhehymJEip7gHxE6K13HBbhLvVMgeeeeH8v42ptyWS+psW9mMdW6Esu1YiVUKBojM9/3
	tggYcnqUCtspbwUVn2BSeMb3Xvu/6fW51y1SllE9TwA==
X-Received: by 2002:ad4:5ced:0:b0:796:5c30:b079 with SMTP id 6a1803df08f44-8817678d8e7mr19319306d6.43.1762471611240;
        Thu, 06 Nov 2025 15:26:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSlSEV9dAuqFzCy0/F84dwpJ0FkW0yEvyVdQS2BVlZV8mmVJOC9OLuQQBUQWU2sDVef6rnHw==
X-Received: by 2002:ad4:5ced:0:b0:796:5c30:b079 with SMTP id 6a1803df08f44-8817678d8e7mr19318886d6.43.1762471610821;
        Thu, 06 Nov 2025 15:26:50 -0800 (PST)
Received: from [10.197.115.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88082a3aa91sm27389196d6.56.2025.11.06.15.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 15:26:50 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 06 Nov 2025 18:25:50 -0500
Subject: [PATCH v2 RESEND 4/9] phy: mediatek: phy-mtk-hdmi-mt8195: convert
 from round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-phy-clk-route-rate-v2-resend-v1-4-e2058963bfb1@redhat.com>
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
 linux-rockchip@lists.infradead.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1601; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=9vVtfY2SWJyaK316COu6cQ1f5v68xmVdCSUMuW44eRI=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDJ59RYoBp++/m+KnEwCw2Xzg4JMM1sv5LqlTfM8z3Ft1
 oPpKx5c7ihlYRDjYpAVU2RZkmtUEJG6yvbeHU0WmDmsTCBDGLg4BWAiTXqMDOsmKjWITF6W1vcw
 Rsfl37GwV6cmCusab9l/nnfG61Oh2ksY/pdXORfMfrL0V9JrDfar8z4f2SCwtyM0bMnTN+tL1n5
 89IIZAA==
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

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
2.51.0


