Return-Path: <linux-kernel+bounces-866728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F72CC00840
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3141884CEE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F59430C354;
	Thu, 23 Oct 2025 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="n44EJIIX"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFB5309F1D
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215569; cv=none; b=mgN7G7k+TF26w7yB98MJ1jJzCAMRQiuqZtLiXt3GSvk3rLKjwE07HWYcKEIOgnib2L/KRjqzjKEXDhu7XuKN7oVSP2NzcnmPxuVXBCbHOVJgpS4wmoFOCeAgbYVwwsVJmWGc5Kj9t8UvfO4niQYBseAt0xFNz/4EFBqsCVMqFug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215569; c=relaxed/simple;
	bh=MQSK8eGfZb88NZ3j7UoADOEH321wqDKatMU6JULsmYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fS6baFMgS+PAGiqahtJleGRpew6I3tV1nnW8cMfg2kDnK0S+hle9HhotMitTKVxqN6HfqkaTltsOnoe6jL48Q+J2NwxI+1KIXsQjmYJ/s97ZuZxDwbyvLUEmDb0jxshxBdP7qME09iXAwA5bJJVEVjKcRGYyqdy1odePzWyXDX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=n44EJIIX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761215564;
	bh=MQSK8eGfZb88NZ3j7UoADOEH321wqDKatMU6JULsmYg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=n44EJIIXeMlyRQO6GFwEtVAy8Yqx1E20uEFWIFb0rzsgl5roh3hbVOAH9ELifEV6c
	 ufEoQxe41PfutgWhOjKD4Q4SSFVvhiJn9ff6SiruK3S2jlg081k1UZnzdk0gVPED9M
	 KzYfw5bRFrAflxpPWTJ5hFpvE6zdeIu6+xP6WGjZJ6V6b46+NOpLsWbXk8FNOM6h23
	 6JY5DC/8UExUyoUQv6tFwMm5z57xt9y86TFgIyqG1TdqiZAWrpjSM3uf9iapVnWRDB
	 0m9rJXx0BWw8kxqtb/nnutlB3XYI8GBtoHeVdtOX36LWy66GyAJKf/L3AtC1KV82nD
	 pyHu3DemrpGcA==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E3BDC17E0CF8;
	Thu, 23 Oct 2025 12:32:43 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Thu, 23 Oct 2025 12:32:34 +0200
Subject: [PATCH v11 08/11] drm/mediatek: mtk_hdmi_common: Add var to enable
 interlaced modes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-mediatek-drm-hdmi-v2-v11-8-7873ec4a1edf@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761215558; l=1712;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=ooyxyCrBJchtLibasSNhjEb1Q7PQIVAYDmD7Jp6t8XU=;
 b=KzQIqWedLyDZ6Bpa5QjWOcBPAqPgH0S4OcFpdkTeChXSy7obIj2+73rcLMaUNKtfechrnP/6c
 nmsyG145JWSB/WLcAVhELKoxnAjG2WeuiDd7kBvpdDiP58ZgyuAlUba
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
2.51.0


