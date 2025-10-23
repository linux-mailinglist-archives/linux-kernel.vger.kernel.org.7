Return-Path: <linux-kernel+bounces-866723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1745C00812
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB653A25C7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68184306B01;
	Thu, 23 Oct 2025 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="X8QryNv6"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802AF29B8C7
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215564; cv=none; b=C73WAeAIRqQShswcR6vkhLMXNEPfQky+widRMnh8SyyRn7w+7EW9MQmitnCAf/auLaAiy6j1fafPOgnTnULrygxLLFiEld/0Z3LowXNZxgk31lIDvHp8zP27pcDEj7yYNVOy5ekAAa/QBwxILO2wNvoIiTrXUoP96NL+tGCpVA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215564; c=relaxed/simple;
	bh=Nm8W7cpMeOafms4KMKvssQ+rEiEsG+k/uHcRPolGSvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p814sPHzv1V8sEFvJJTuQpMkBHRcQ2DH13afIco+BhtXRXovg3spym1MOp4shIsfUBVbhTRBKuNXhoxJJBvNmCVq8Nl8t2egA7aR3A0He90eD0wj0AhXBIbVxmqqw5Rv8QyjqH9DFw3Z8+BknhvfQE3bPxi6cOTgH6C2MJzJiIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=X8QryNv6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761215559;
	bh=Nm8W7cpMeOafms4KMKvssQ+rEiEsG+k/uHcRPolGSvs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X8QryNv6qgKMRhud8znNKkw2n2Pv+08G2q6QyGKpBI6CcOIxQ1/XqpPLpFb2MnIH8
	 RR/BRBy0Pdk6Mi546kqkSG1slV6RcCqB21P0rt6jEW3dKBPHmfJDAUSM+97rUfTi4H
	 nIgYOTRYFcJH58Ruowt+7CRxIB3L8QCdLSSjVfflZzCvRtyetpIFITElRNzKlGHvX5
	 xyg+/kWvpg+yhNCpG/UMvPA49rPwDFeYh8J/ur4KTiH8qJZM5rjAMav0SzvIjJM2Yc
	 qtW5EPZdnY4BBfLO6e2bYpOTzFagTZyiJI5CXPgqPIfbm7+rXHx+DUwm2ZKt3/ajcn
	 bbBVTQxBMOcjA==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 05C9B17E108C;
	Thu, 23 Oct 2025 12:32:38 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Thu, 23 Oct 2025 12:32:27 +0200
Subject: [PATCH v11 01/11] drm/mediatek: mtk_hdmi: Drop redundant clock
 retrieval in mtk_hdmi_get_cec_dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-mediatek-drm-hdmi-v2-v11-1-7873ec4a1edf@collabora.com>
References: <20251023-mediatek-drm-hdmi-v2-v11-0-7873ec4a1edf@collabora.com>
In-Reply-To: <20251023-mediatek-drm-hdmi-v2-v11-0-7873ec4a1edf@collabora.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 CK Hu <ck.hu@mediatek.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761215558; l=1441;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=Nm8W7cpMeOafms4KMKvssQ+rEiEsG+k/uHcRPolGSvs=;
 b=LVF5OOiJXiruSKNxVaopiTypS6rAfNxxeL2tRuoNJ+qCgnQYMlnHlPyjvqgr2PDtpUHVE02c0
 eBL+k1IVDS0BlKO0Y2hJ9+fITNsf5KTQ2DxnEVIJ8PVr9sA5AQzrb0C
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

In mtk_hdmi driver, when the CEC device parsing logic was moved from
mtk_hdmi_dt_parse_pdata function to the new mtk_hdmi_get_cec_dev sub
function, the call to mtk_hdmi_get_all_clk was kept in both functions,
whereas it was only called once in the original mtk_hdmi_dt_parse_pdata
code and does not need to be called a second time.
So, remove this call from mtk_hdmi_get_cec_dev to keep the same sequence
as previously.

Fixes: 7485be967f7f ("drm/mediatek: mtk_hdmi: Move CEC device parsing in new function")
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index b766dd5e6c8de6d16bff50972b45c3c1a083b985..9a2d4a904ff12b5abfbbd47a803fc568c0a09147 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1349,11 +1349,6 @@ static int mtk_hdmi_get_cec_dev(struct mtk_hdmi *hdmi, struct device *dev, struc
 {
 	struct platform_device *cec_pdev;
 	struct device_node *cec_np;
-	int ret;
-
-	ret = mtk_hdmi_get_all_clk(hdmi, np);
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to get clocks\n");
 
 	/* The CEC module handles HDMI hotplug detection */
 	cec_np = of_get_compatible_child(np->parent, "mediatek,mt8173-cec");

-- 
2.51.0


