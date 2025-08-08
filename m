Return-Path: <linux-kernel+bounces-760083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16117B1E644
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7D616618A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C647274FEB;
	Fri,  8 Aug 2025 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qD2qnHxq"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9023E2749D7
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754648012; cv=none; b=L/zsPEQi3etdixEOViMTVpAdbiBC/o5nJpoia7Ec/4ya333Dbceop7PjdyQOGCOCSftoE7MlEFGgg44JtosbT+AvhG/I6hEu3Vq28sVujaMW1xGIaa4fHQ8mRUP7rt8DrRbmfK/NAEI+7foJAEOTX6t7j5yWfWhol2br75XBVHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754648012; c=relaxed/simple;
	bh=fvVq52XFZbXufV8NpV5VFjgBa+WEI639gcHsO/EucdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WDG0+9o1PvuDz1vty21pBHunHf47ISt7r6OotCLZvgG5aYq/1Nt4xhMTTLJZ2sY+UVcxL3FctSqRNHyk4Coarn7Vh6WRoiprb6IJNCu+q3svz/Rpo6waZZOkW1dm0sIFdKToAhioz0eUQEBvPFdKuFLqIyqtNQts4RhDprDCtZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qD2qnHxq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754648008;
	bh=fvVq52XFZbXufV8NpV5VFjgBa+WEI639gcHsO/EucdM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qD2qnHxqMOTia4EYiwEFN+JUi8LJ0+KgNvlUAPSZDLMSnN1eVL+R3tH9xeTxc+iCl
	 dYD23J43GC059rikD4LkM666ogTFhxU8xStflrc7y9uulAhBNhf4Fzo57/7mjyT109
	 akgU7EgbHVZ0AiVT4XjsQ0kNsGANE+Ltx3YKrayn27mXCOyj2i2kMTEgJ6NREKvCXW
	 h3FI0rjPrQ7QlD7NnC2ACXdC9bMh6aYzeua8shjeCqPcBxQEags7axMwlYI/GFcndR
	 K8dxaoASnhuP/5llD1+0ehUjHen6Yo+7hOikioW7YCl7cSjrpqHxleLDhG6PrTqflX
	 ozepQM56d0/bg==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 641DF17E00A3;
	Fri,  8 Aug 2025 12:13:28 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Fri, 08 Aug 2025 12:12:18 +0200
Subject: [PATCH v10 08/10] drm/mediatek: mtk_hdmi_common: Add var to enable
 interlaced modes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-mediatek-drm-hdmi-v2-v10-8-21ea82eec1f6@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754648002; l=1712;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=F9CodMOckHFmVHgyCUyMC6SuXyKYebONAVjqKAzRLSY=;
 b=fnkaGNGHjtzzQnU19IfNtb/NPvgIS2ntw8HOnjzL0wvpsCMrsL/JenMyWPMGo0NmRGALmdFCd
 yYTpqOaVNfCAoENQpLdzv8C6bJfPAiIPs851JvTJKSjeoi3E+HLE7zb
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Add an interlace_allowed bool member to struct mtk_hdmi_ver_conf
which will be used to signal whether interlaced modes are supported
by the bridge (in our case, the HDMI IP), and enable it for HDMIv2.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_common.c | 1 +
 drivers/gpu/drm/mediatek/mtk_hdmi_common.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
index be63f33d39bfd4625a5f1edd83c873cc20ac0018..38986ab61795c22b5b0659ad2ca258b923034a34 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
@@ -421,6 +421,7 @@ struct mtk_hdmi *mtk_hdmi_common_probe(struct platform_device *pdev)
 	hdmi->bridge.ddc = hdmi->ddc_adpt;
 	hdmi->bridge.vendor = "MediaTek";
 	hdmi->bridge.product = "On-Chip HDMI";
+	hdmi->bridge.interlace_allowed = ver_conf->interlace_allowed;
 
 	ret = devm_drm_bridge_add(dev, &hdmi->bridge);
 	if (ret)
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.h b/drivers/gpu/drm/mediatek/mtk_hdmi_common.h
index d3de8afff40f2b1a16e87b157859c04109b6da9f..38d1bdf4c77e4f6684473abec0e8c1e6ddc7db0f 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.h
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.h
@@ -131,6 +131,7 @@ struct mtk_hdmi_ver_conf {
 	const struct hdmi_codec_ops *codec_ops;
 	const char * const *mtk_hdmi_clock_names;
 	int num_clocks;
+	bool interlace_allowed;
 };
 
 struct mtk_hdmi_conf {

-- 
2.50.1


