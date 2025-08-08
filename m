Return-Path: <linux-kernel+bounces-760081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C713B1E642
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A06724F50
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8B1274B52;
	Fri,  8 Aug 2025 10:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WYSgl12Y"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF14D274676
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754648011; cv=none; b=MqV8KY3RGSSBKTP6wcimzXR9VFx0oKYGpE9+hJ+k7mIDLor14tAKZw/XOZlySdlXAcFMGQssDSJb2s7XMDVU5MB98+L03ei+CQFGy9J0QnoLwqrlf12IEcYDEbmKNZxbNvaAkFI0js85xkmTlqZgs4mEj7Xzq9QK7YKitoJ2oAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754648011; c=relaxed/simple;
	bh=EGx3yE8rfdW+AiowBjEmyHsbvFWWmYRTHvFW44bdB6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NoTRFZNXEXqyxdnsl0K/zHTnK/2EZFI/c0wXWGTXobxPx/oaC5CEQI6Cpg1bN840RY6frx/wMtyzDUM3/JqinffC5vnZexZkZNkIHc1U1GRPz5eN+dnR8HjsMf2cEEg6urOhhqmA80empPoTcYK496nFWN9d/kEul5F7RqyPNrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WYSgl12Y; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754648008;
	bh=EGx3yE8rfdW+AiowBjEmyHsbvFWWmYRTHvFW44bdB6E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WYSgl12YrPQWvkntXNq/enVIK8f5Ogoig3DPvtuOTwwp6RafopzJJz4c3hr2yVeKE
	 EenCETbyhW3flpLC+eKI4o9wu+LMBa/AjRg8vM3231Zp5egTfnbmIjPeWMi0AQ+I0x
	 xJVJxuHPcsbvzGJrMDeafX1oiPRXpZzg8mdbvi/TSdEctSYIJnUDMzZJahn/xXROu7
	 y8mR+8SJYlwA1sZYrAJ+cEK7KFcu5ttbu/EBdyLC3pp81ooYX2G/DGhXxQFHDFkqHc
	 sFyieTzBszZw1+mdGNCiLjqZeeDpi0pdJsVsjBTG8OYv/hMcw7LAeKwsH9byPsafMz
	 r2oRg58RbkStA==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B084217E132A;
	Fri,  8 Aug 2025 12:13:27 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Fri, 08 Aug 2025 12:12:17 +0200
Subject: [PATCH v10 07/10] drm/mediatek: mtk_hdmi_common: Add OP_HDMI if
 helper funcs assigned
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-mediatek-drm-hdmi-v2-v10-7-21ea82eec1f6@collabora.com>
References: <20250808-mediatek-drm-hdmi-v2-v10-0-21ea82eec1f6@collabora.com>
In-Reply-To: <20250808-mediatek-drm-hdmi-v2-v10-0-21ea82eec1f6@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754648002; l=1902;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=VFgIkvVzJkA3pH1XUiXTo9X/HXrtyxZhRMF4j8V/Alg=;
 b=sqyNimNTio89XgmkCZ4TDb3/csaRfDrYegf5ikdYGugP1m5WGZZS4gkK5UlR4Ux+skPTuwIqw
 HEZr9kQyaavDWlRWFB+5OG0YiOt2gozRAz0A4ds1Nq7Bkeah2au5Jhb
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

In preparation for adding the HDMI TX v2 driver, and to allow
a future modernization of the HDMI v1 one, perform changes
that enable the usage of the HDMI Helpers provided by DRM.

Check if the HDMI driver provides the function pointers to
hdmi_{clear,write}_infoframe used by the HDMI Helper API and,
if present, add DRM_BRIDGE_OP_HDMI to the drm_bridge ops,
enabling the drm API to register the bridge as HDMI and to use
the HDMI Helper functions.

If the hdmi_{write,clear}_infoframe pointers are not assigned,
vendor and product strings and HDMI helpers will not be used,
hence this commit brings no functional changes to drivers that
have not been refactored to use the new helpers.

This also means that, in the current state, there is effectively
no functional change to mtk_hdmi and its other components.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
index 3b589706d61b1e0e4aa66d0c81253b8aeb70c0d3..be63f33d39bfd4625a5f1edd83c873cc20ac0018 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
@@ -413,6 +413,10 @@ struct mtk_hdmi *mtk_hdmi_common_probe(struct platform_device *pdev)
 	hdmi->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID
 			 | DRM_BRIDGE_OP_HPD;
 
+	if (ver_conf->bridge_funcs->hdmi_write_infoframe &&
+	    ver_conf->bridge_funcs->hdmi_clear_infoframe)
+		hdmi->bridge.ops |= DRM_BRIDGE_OP_HDMI;
+
 	hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 	hdmi->bridge.ddc = hdmi->ddc_adpt;
 	hdmi->bridge.vendor = "MediaTek";

-- 
2.50.1


