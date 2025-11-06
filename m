Return-Path: <linux-kernel+bounces-889522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97873C3DD3B
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84E494E4AD8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF94934DB65;
	Thu,  6 Nov 2025 23:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0fIbBAy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdLxcUCm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80924348895
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471605; cv=none; b=mAf3CtKSOu//tzFeVwNqYCEg4d3N9A4LtT5sxCdm+JrasMs9yMx+D5XTeFobjmh2fHuaboY8/x9D363ABEWvB/OXAJ2oDL8R2jcfMY2/q1V7nGgGRfEC06WngQD/ZAp9mZN77GEJKbZhOzKqyG532+2Kt2ie2G7KlnoeE0uLZ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471605; c=relaxed/simple;
	bh=kakNurIzgUJYDq3FSiWnwOldSD2Dsz8eAB7sKp0pFFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ja5aBT3amBG8ZSc79oxcYxvBHl1luEr5x0/cYJ6pnMjeiXba7wsjErDrKwJJHwkUCuUEJWpLIweS7XmwvuWg8fK+2YFEXrTyLvzomFhzCFO16eSHrpZIv3EAtWabrogqnG5OIPMGfgtHegojfmvDloa9ZeDPSUpjPqz1Slv1Mqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h0fIbBAy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YdLxcUCm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762471602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fzzoA0sgvtO6Huy28YTNePP1cZ5wFE7gDr3kf/Jxy+g=;
	b=h0fIbBAydu/MM+mjjmd+hjsTLZPoNedNMMoRC1ReymnrZY+ZQTeeEj6LbUPePaqLaJrmdj
	qvQH1xIUtV9mTxmaziCn6UFBp8fRRV11P6YTr28ow/lMk7MgRrwIaFItTOFHk+AGSKKWBv
	GMibajoVHLqeHqMm5Dj6FpOWRknlbgU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-PLXWwtGZNre-E90S2VCVSg-1; Thu, 06 Nov 2025 18:26:41 -0500
X-MC-Unique: PLXWwtGZNre-E90S2VCVSg-1
X-Mimecast-MFC-AGG-ID: PLXWwtGZNre-E90S2VCVSg_1762471601
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e8a4c63182so5704961cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 15:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762471601; x=1763076401; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzzoA0sgvtO6Huy28YTNePP1cZ5wFE7gDr3kf/Jxy+g=;
        b=YdLxcUCmeg3ZhRKYNAwzXMRJC/Z3l0nk7YzKPo+NgD/W6Hj+N7Jxy06cKgZc9SfP/z
         zr5Nlpq9AzZgOhyOOcne+zgaTTrYal3WHRruBjBPmWPJfNFgN6bPtklDEcWldiEzRCCv
         UexParhvcY9GsyxlLI+JfmZveaW41DG4Y5O60QnMSuoKipNrP5MRzbK9TDq4ED20ZL3m
         Dp8mvj5G5L+3Dz0w2AFmT5SnYgJ7r3zlNVnHQT7Lw9oiJ9JfWiWgtf3j0tZbgnusjZmW
         iurweKEi/X6aX92X9O/YUzfugTUm09NfT+tAtkInd5QKx0yQMFkI/H2Bnm+/j+2op074
         C4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762471601; x=1763076401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fzzoA0sgvtO6Huy28YTNePP1cZ5wFE7gDr3kf/Jxy+g=;
        b=XeuxuWOHWNyPS08qN1xlZT5Nhp2O+5oBR4hcN/mBaT3Ku+EpWX42F4hu9XFO2V5Xw/
         sVJjituFQnkTsNuhP648esTIpE4iKnzcHil/egEXIUw7V2Z0v+2FSAl/XOuUDUb2bmOW
         Q7gisVT7/DhvUvy5bwCkgi3W0+RMMiep+ndfpwEsFBZfhyEUuD5OxR8dIj3nbFZsWiIo
         /JvEo6BLGGbHEvQfcLhNsCuMBqrQdM6PQ9+PXBXjnLHcDQIU5+p/hDoUy7tQ6lgDihLc
         qxlUVDXF7QlgAp1RPoKT4Tn+kUjXFVBc2T9VeERaXgjuj7RV0x9hfypqlHduAp96ZNTg
         cnQg==
X-Forwarded-Encrypted: i=1; AJvYcCVSgJX1BDlOxWUGuAglcg4xllqHzZHn+5tFpppxOONQf6Z4S4OPZ+UquaubPIEWb4aNYB8nIV1T6l+w5FE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFl+sBZJAajA3Mjuoug/AFzD6w1qHHyiTIrL0ezTwB+MdZGIXP
	hf2q3qSuk9hwXj5bEXvMr6mZHj0V3mgNnvPxTeXa3N3m6urEc4KMg0jlcuG/FcI+3Mno08fQtPK
	22sxxYP0SyyZqNLVLZcZnlXwPXcEHjWig4v9QD31BoY0SNfHGx1NFEO3IDh29AovUtA==
X-Gm-Gg: ASbGnct0RxhiJCwo+tVDLGfgOOgvlROpUsEvi3et2XTbnJKCc3meOqOFftU1PxoLNjR
	KePXBT8bpFfFEP9iA6ndOKjgM5FqhB3hJZzDpHyyrdznR4jM4v1bBqwtFD448qTUTmlqNrKaYJj
	qN0p0Xxz4nkl5c5ASdLrDixEd5/mx9BH2nfST8wTKnP2KSbesmgyHod5qExIgoImJqm++tg59bS
	vDEvOpMFIQdDgViq1k/dRpy3gAEKIPC3YIqcXUqo+wbWG/k0ng1unmqdl5hMk2iDDyWRyD0Jky7
	QR9aBCTVwDCsd7JsGdHgSAYVyf9y4iBAPMFWSVc0vBVzbMEDIBgi/gIYm2Mu5YTFPKb44MczGLa
	OhoiaSYTEKz5iP482XbPJfgR9N5VBEvW4Mh3tUxgYHA==
X-Received: by 2002:ac8:5e0b:0:b0:4ec:f8c7:228e with SMTP id d75a77b69052e-4ed94965d2cmr14670421cf.20.1762471600798;
        Thu, 06 Nov 2025 15:26:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBSY6ZC3uinTD+3Ty3ImTkmn67RZYU0qwyag+7rpP+kdNpFJpdcKxM23Wr/jw9wVVKFtdCLA==
X-Received: by 2002:ac8:5e0b:0:b0:4ec:f8c7:228e with SMTP id d75a77b69052e-4ed94965d2cmr14670131cf.20.1762471600494;
        Thu, 06 Nov 2025 15:26:40 -0800 (PST)
Received: from [10.197.115.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88082a3aa91sm27389196d6.56.2025.11.06.15.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 15:26:39 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 06 Nov 2025 18:25:48 -0500
Subject: [PATCH v2 RESEND 2/9] phy: mediatek: phy-mtk-hdmi-mt2701: convert
 from round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-phy-clk-route-rate-v2-resend-v1-2-e2058963bfb1@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1429; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=kakNurIzgUJYDq3FSiWnwOldSD2Dsz8eAB7sKp0pFFg=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDJ59RakLvNXLXp4dKGpoLGdvd/lA+kBXBxPQrUnzGDJn
 31ZbNPtjlIWBjEuBlkxRZYluUYFEamrbO/d0WSBmcPKBDKEgYtTACYysYrhr9DBktS9ynMn++tf
 k5w20/RkIMMWe4YlR42kDylzcPtNSWX4n7cyZM6jjhVMr1oMFc86Lt7ee3N2m+epE1GRUfUfZDP
 2swIA
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

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
2.51.0


