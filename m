Return-Path: <linux-kernel+bounces-866726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D8DC00843
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262C819A1889
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E19030C34E;
	Thu, 23 Oct 2025 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CtjEusBi"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679B3306481
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215567; cv=none; b=cJudPy1ywPzRZXQRrb/5HuNY4p+z9cuww6OuyIXmugWMz+y7EAnjJ93rXsQX3MOY3k8dW3BHgxPGpDCNUTrqgpPlCJaMV6UxvUgx/KViOvMNB9RDtBF7SvFmhJLhLL8foujhyHGKk0dv1hkyykwPPMuKDKOYnOHqBkMcF5eRhdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215567; c=relaxed/simple;
	bh=WnFjNChrbtpk/2v7evsrtmDbZUUbQIbg9xxfDzSTit0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=if2CcbBOc/PKXQlX1e7ewRV3GPKHCWPTHL2kgXJ941v5RmczaHdEJygaZ10DjgDWiQDbtaMlhZN5hybn3FuPtFD+f9J2Y40o+wDZOoGvQ3T232xPXZe+4bJZypAM+1G2MmBgDCJwv15TsXLKtAKV7OzW1RVexDmvUB3Rf87b3to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CtjEusBi; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761215563;
	bh=WnFjNChrbtpk/2v7evsrtmDbZUUbQIbg9xxfDzSTit0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CtjEusBi8L8NaBFBjKT8oUXYtZZnU7vdc0iqNqdcd3eUkG9y7xaf2/qltBgJ1ks8S
	 B5o9CDmM4TMMGUT0GEA5JmaPyJItwI09ZW/u3WFiai17sEbaiTEza8ecRI/M4KWgIG
	 olT93zwvh94tTqcH9GZKimtDYT7FOqM1a/qrNd+XUlc1y1Xjecw3OEmBIkqhjd6VJv
	 iGW0jF/8oETBjDZJdM1tgxJzWhWsdacK43gWtSPdCgAi5OIFZzVlJM6YdSMUEN7VF9
	 Fwngl4+U0whe0mqkEyTIg9LZNDDYylRgtwV8BPm1CJuf3QmfGQHeL/vRW73w+xt/qj
	 7MJjlvS2dL1ow==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8735717E1414;
	Thu, 23 Oct 2025 12:32:42 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Thu, 23 Oct 2025 12:32:32 +0200
Subject: [PATCH v11 06/11] drm/mediatek: mtk_hdmi_common: Assign DDC
 adapter pointer to bridge
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-mediatek-drm-hdmi-v2-v11-6-7873ec4a1edf@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761215558; l=1180;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=nhWq0AUZF9mOGcHD7ubNmCv4pfxd2Wo1OwAO9nUMngg=;
 b=hQTsTm4qHb7QJ12VpeMBvrQ9Ax6JnvHgcfwVhqDv1XRMax98QCG7Do0/VFRz6PL8yStfQVg7g
 fT+Ka/41zmjCtxYlZEzvsyrceGbUm7RQLqL+DnhM5UFhZHIvwh/z8V9
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

In preparation for adding the new HDMI TX v2 IP driver, assign the
pointer to the DDC adapter to struct drm_bridge during probe.

This commit brings no functional changes.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
index 989479fdfe40952762a1b63797bf602b520dcac5..3b589706d61b1e0e4aa66d0c81253b8aeb70c0d3 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
@@ -412,7 +412,9 @@ struct mtk_hdmi *mtk_hdmi_common_probe(struct platform_device *pdev)
 	hdmi->bridge.of_node = pdev->dev.of_node;
 	hdmi->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID
 			 | DRM_BRIDGE_OP_HPD;
+
 	hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
+	hdmi->bridge.ddc = hdmi->ddc_adpt;
 	hdmi->bridge.vendor = "MediaTek";
 	hdmi->bridge.product = "On-Chip HDMI";
 

-- 
2.51.0


