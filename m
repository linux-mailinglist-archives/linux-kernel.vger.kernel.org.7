Return-Path: <linux-kernel+bounces-860537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806A5BF05B4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA83D3ADBB8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0666A2F5A24;
	Mon, 20 Oct 2025 09:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="p5uO8gDC"
Received: from mx-relay90-hz2.antispameurope.com (mx-relay90-hz2.antispameurope.com [94.100.136.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163522F5A0C
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.136.190
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954370; cv=pass; b=hN1t5fy1fJzfNG7tTwaCnOS/6zASSppttBGIiUuSwXOpIkgq7iIXNRB2RM1miihWiR1nW0w8n7xOo/KXW9Mv9DmTv6UaeiHfmNaaA5slA6bVvk9iblb8UtFQ6mM9wkpmuBN5NNo+Ad1FHoYh0rR7ns8K3fokrjjY3Wi7X2/rbZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954370; c=relaxed/simple;
	bh=LEugHl+T2Qjsz7Dwy5Eo2XDiHbOrQbuBQ+4N6hD52oM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AlmOyJjs4n3bWKF6a7TpV65mjrvWoUUN1h6O/+ptQZwVqAb7qqKENOKujaluEhAHrbUHZ4LPe0NhZHZQ+/oy7Ykvyp/rFP7hcuqaOy7aCBUcAvF8boBZVf0Mv3DD483snTn+85kGPbLPOnQEj2NGWdY6SNh4jXehKvxWxFBK7j8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=p5uO8gDC; arc=pass smtp.client-ip=94.100.136.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate90-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out03-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=Vy47wkPi9vz9nd/Ubb0WzYYj5086de9de6TtEsO3Zns=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1760954344;
 b=md6hKWS4qig5+TTftjXPcpwOzgpetjQqk7jnQsJ/T3WyqbGcGarfl73xT/gh3qNsCg9dyghG
 REULXF3LrkI3zdU2OBib40qJI8U81NiYsXkBEZqIo5m1Q7f2Fbm9epDltYfqtjS09je7tLs+Zbt
 pNXT5qfzbRihPRl3xNweNWPx+OpY/E6MrOiE8OOMUK/6S8pjfGPzM57sjoXmrl9Xh5edvxxlZ2p
 1deg2L2rYJuLzy2+HjxawR5ePBkOqjPIkPPfkVYaLYzeotUSV9G6t0TZ0exsjXjPJKhguOsGola
 4s8PdMNJpxw/tV50t3BUKtytgvdtIcSedUyPUV9jCm3rg==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1760954344;
 b=bH/eJjYnEWzv0WBsMjKkwCROC9TPNHFXX+AEgHSy13+dQwAGJjGXLMv6lHgh6yFe+M27X0+C
 prFK4DBnG4I90N7AkIdNiLm0LWUP+Mz1xgIN3DdS3s37sOWrtyXEyMlgw6ZeL6d3FvekfBn164Y
 UeJjOnbPF+T5HVH4V+P60TAmgi5MGimyNKnypwcTiQI/CQJcWa0+tZtRYcPgpXDOC9qgoO8WJog
 gsNEGj59802ISqt1wKj+R+uf+XsSfEoXcslyejWcJLml2LvUnKB5bdS+i6xEjBrwJfaPVdAr1C2
 63wFuvVJTzgh/wgCTBRMogdPUjchP1mKbPnB9ppFXH1YA==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay90-hz2.antispameurope.com;
 Mon, 20 Oct 2025 11:59:04 +0200
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out03-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 88256CC0DD7;
	Mon, 20 Oct 2025 11:58:49 +0200 (CEST)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Marek Vasut <marex@denx.de>,
	Stefan Agner <stefan@agner.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Liu Ying <victor.liu@nxp.com>,
	Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH v2 1/1] drm: lcdif: Use dev_err_probe()
Date: Mon, 20 Oct 2025 11:58:45 +0200
Message-ID: <20251020095846.116202-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay90-hz2.antispameurope.com with 4cqrVL377fzX01q
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:303711fa30182f3b5e5363e87477579b
X-cloud-security:scantime:1.797
DKIM-Signature: a=rsa-sha256;
 bh=Vy47wkPi9vz9nd/Ubb0WzYYj5086de9de6TtEsO3Zns=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1760954344; v=1;
 b=p5uO8gDCr3XHeuoY4nyiiqi1iuIgFAWmywjODp8hcmLXycwUnMv2aZBU0pEL/8vMuibLNznw
 ci/4mgRNCfXQhj/OwPehRDjy+9vY38CLcneCB22wBxhiODgzGAfbPRqWL6HI9PziIQLauHulCqT
 uChEpqayIMXFbLJawVS5rhuyaIH/ijDOm5dEW+o6RV0H7fAliOzSOf4jifzaCmVRJCLTy6aUtH1
 CXwWAzq//DnQVQP5Dw1n9vVp+V1Pux+LH2dX8vVxXR1vIMOEohOaupS68bpoFrG6IElr7qsd8eW
 tkg6zHF0dqy4Bnrm4WzUxaD5Yyx4wkJSCL6fIkS+iB2bg==

Use dev_err_probe() to add a reason for deferred probe. This can
especially happen on lcdif3 which uses hdmi_tx_phy for 'pix' clock

Reviewed-by: Liu Ying <victor.liu@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v2:
* Collected Liu's and Marcos' R-b

 drivers/gpu/drm/mxsfb/lcdif_drv.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lcdif_drv.c
index fcb2a7517377e..47da1d9336b90 100644
--- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
+++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
@@ -149,15 +149,17 @@ static int lcdif_load(struct drm_device *drm)
 
 	lcdif->clk = devm_clk_get(drm->dev, "pix");
 	if (IS_ERR(lcdif->clk))
-		return PTR_ERR(lcdif->clk);
+		return dev_err_probe(drm->dev, PTR_ERR(lcdif->clk), "Failed to get pix clock\n");
 
 	lcdif->clk_axi = devm_clk_get(drm->dev, "axi");
 	if (IS_ERR(lcdif->clk_axi))
-		return PTR_ERR(lcdif->clk_axi);
+		return dev_err_probe(drm->dev, PTR_ERR(lcdif->clk_axi),
+				     "Failed to get axi clock\n");
 
 	lcdif->clk_disp_axi = devm_clk_get(drm->dev, "disp_axi");
 	if (IS_ERR(lcdif->clk_disp_axi))
-		return PTR_ERR(lcdif->clk_disp_axi);
+		return dev_err_probe(drm->dev, PTR_ERR(lcdif->clk_disp_axi),
+				     "Failed to get disp_axi clock\n");
 
 	platform_set_drvdata(pdev, drm);
 
-- 
2.43.0


