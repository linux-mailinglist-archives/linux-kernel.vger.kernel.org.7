Return-Path: <linux-kernel+bounces-829229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA3EB96928
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF50481476
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDEC26D4C7;
	Tue, 23 Sep 2025 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUTeYdA5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6A925949A;
	Tue, 23 Sep 2025 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641173; cv=none; b=BJRkYqsNCN++aAV5qTEH41t9ihanSU++8rjis2otRQVrukiRU9v62WchDhlNo5mUhYYTr/yq4mfxrRvrhRUO8bcNK4Cj76+IsUABvSk10MlkSwmiAs9FekU8mpTQh55lviVBl6LyoOfK72QkmUbg7V5h2ppz745nFsNLGUwuWk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641173; c=relaxed/simple;
	bh=600+gl2y/5DXDE8JzKJY5V6QLYLeY4g2SnvrcP9hV44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kIajgdSGRBpqfTLDOK5/F2gDTLV8YH33JgO3pO2DSSk3yfDFK5I3bCAd+RY7D2pcALly8RjdxdK0BVZL6RE44g/qU3L1SpMTW6p74+5oTss2eepgo5/5QjPbCyaDaTKAUIJv8bjRf38B67aqT9hztUB/soRiUa16t1AmHKtouuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUTeYdA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D40C113D0;
	Tue, 23 Sep 2025 15:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758641172;
	bh=600+gl2y/5DXDE8JzKJY5V6QLYLeY4g2SnvrcP9hV44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EUTeYdA5pQktnE96dmZRLl7V/ujUZJQApclxLmczzcUy0dOOVY1AQUPIhKrP4a4W6
	 E0wDpFyjZjf0N4zCEjTTJF8oeH8vvlgfGpoet8ohApUcbg/YKUI/CtcHNaOZhkPxxr
	 65AYe+vUh/tfzo2kgh2b0YwzqXLrLtDyAQrVTm+xjio27qXRcuy82p0eyrfsBX0Cgq
	 hAy4L6BlL9j+3vvOszbzOIvnWNqsZ4Cbn+xMa9nglrtaIV/b8XYtDpnhC2kPjwolQs
	 MNeC5vhqdPPNX2sIbHnAVjzYottYaeeuF24Yu4Jx6m6PlDhg53GljSEBIbzz/Dpzzb
	 4Q+0d0WHkoJJg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v14u6-000000004mq-46Hf;
	Tue, 23 Sep 2025 17:26:07 +0200
From: Johan Hovold <johan@kernel.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	CK Hu <ck.hu@mediatek.com>
Subject: [PATCH 2/5] drm/mediatek: fix probe memory leak
Date: Tue, 23 Sep 2025 17:23:37 +0200
Message-ID: <20250923152340.18234-3-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250923152340.18234-1-johan@kernel.org>
References: <20250923152340.18234-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Mediatek DRM driver allocates private data for components without a
platform driver but as the lifetime is tied to each component device,
the memory is never freed.

Tie the allocation lifetime to the DRM platform device so that the
memory is released on probe failure (e.g. probe deferral) and when the
driver is unbound.

Fixes: c0d36de868a6 ("drm/mediatek: Move clk info from struct mtk_ddp_comp to sub driver private data")
Cc: stable@vger.kernel.org	# 5.12
Cc: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
index 0264017806ad..31d67a131c50 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
@@ -671,7 +671,7 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node, struct mtk_d
 	    type == MTK_DSI)
 		return 0;
 
-	priv = devm_kzalloc(comp->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-- 
2.49.1


