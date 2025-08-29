Return-Path: <linux-kernel+bounces-791431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5E2B3B6B3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9933A1897537
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06AF2FD7DA;
	Fri, 29 Aug 2025 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G22pMn2m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2972F9C53
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756458333; cv=none; b=b7q/jg25npRORG3jzEneNlQCzbDf4onIs0N6CMS8URqJfQA3hDUWB3xNnbwNP6xNU7mcNg9NJ503WOud4MyXMSTpwwuXjoM5Daz877YhfpKA3/BTKmthZDdnzGT2PMLEzOdk3EIl8XYTCE01H6n85Of1i3p2KQlsyd78YpLlGfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756458333; c=relaxed/simple;
	bh=vYVabSltptJRE83ss4FzMAYlVF/0xeNcsPWfCCvyH88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FpBb7QDlIDrdpD/pYX+ihtVPUCTQb7a7iD4H0ktuW3oLcalQb4kkkqG5tPkfEq+sMoO0FnGSThbuywld7F/eImQYs4JwCw865VIk362KderkOre0AXpsOdko88YaCQGPO6CRKsBXLKQahmrmYJm2MX84LtekeIUAx5SGAb6YOx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G22pMn2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997B4C4CEF5;
	Fri, 29 Aug 2025 09:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756458333;
	bh=vYVabSltptJRE83ss4FzMAYlVF/0xeNcsPWfCCvyH88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G22pMn2mPsU48neBJG5HJBNrKPDONRCT4j7/5Q1t9M8uJZGA7cmxMmok1u7yUgUoe
	 0t3AjiJpU0w4aHv8CHKUtCdp9BB5mwINnmG1kmuR5OmiNg/lOifbESKFe0ytn8VX1p
	 IZoX64m1TA/7Bp+fipeSq1WsPRbp9r/TUbziLrJDuS+YUWRxit9k2F07//4mLcGby9
	 Sd1fbIDU3ggDWf8/Yn6Z3JZ8Z50WKsmiSTXkSV9vhcp+6wi0JX93raVTzRqL8iYGX9
	 SOK0actdeTa34s9N28zD0ZqhOju8Q1phurizAqXkgU1Iem2rjm5dTflJmZv56OIg4v
	 hZi3+djVxatrw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1urv2x-000000005WH-0zjm;
	Fri, 29 Aug 2025 11:05:23 +0200
From: Johan Hovold <johan@kernel.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ma Ke <make24@iscas.ac.cn>,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] drm/mediatek: clean up driver data initialisation
Date: Fri, 29 Aug 2025 11:03:45 +0200
Message-ID: <20250829090345.21075-3-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250829090345.21075-1-johan@kernel.org>
References: <20250829090345.21075-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The platform and drm devices are only used to look up the drm device and
its driver data respectively when initialising the driver data during
bind().

Drop the reference counts as soon as they have been used to make the
code more readable.

Note that the crtc count is never incremented on lookup failures.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 3b02ed0a16da..33b83576af7e 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -395,12 +395,14 @@ static bool mtk_drm_get_all_drm_priv(struct device *dev)
 			continue;
 
 		drm_dev = device_find_child(&pdev->dev, NULL, mtk_drm_match);
+		put_device(&pdev->dev);
 		if (!drm_dev)
-			goto next_put_device_pdev_dev;
+			continue;
 
 		temp_drm_priv = dev_get_drvdata(drm_dev);
+		put_device(drm_dev);
 		if (!temp_drm_priv)
-			goto next_put_device_drm_dev;
+			continue;
 
 		if (temp_drm_priv->data->main_len)
 			all_drm_priv[CRTC_MAIN] = temp_drm_priv;
@@ -412,12 +414,6 @@ static bool mtk_drm_get_all_drm_priv(struct device *dev)
 		if (temp_drm_priv->mtk_drm_bound)
 			cnt++;
 
-next_put_device_drm_dev:
-		put_device(drm_dev);
-
-next_put_device_pdev_dev:
-		put_device(&pdev->dev);
-
 		if (cnt == MAX_CRTC) {
 			of_node_put(node);
 			break;
-- 
2.49.1


