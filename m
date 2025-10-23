Return-Path: <linux-kernel+bounces-866730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E24C00855
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE70B4FB7DF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3227830C620;
	Thu, 23 Oct 2025 10:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OJXenaL7"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA85430B532
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215570; cv=none; b=XKfha/aoaRWqYNKBW67tuGcNeuTVGgdpdToX4MRYBamDsaOlPmYoVYKySqU6Spam228m5xJgYhDfxRTaOIpFjTsgefx7fRE/D79L3HmOi2z+vx/KVfJ6jBttAppihvlWvRc1wfa4sOnuyIeodrqqML4ciWe4IZkyLWir5ZZW+NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215570; c=relaxed/simple;
	bh=lnlDA75XwSH6t7f4Sxf4Fx77SWg2aMAL/WovUBbyRHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OUtdvtDhnrEc3HBJV1Ecp2XyvtiVrfMjKfrmwv2V0nJszxaYTB7OVL6VxdZZkoCvFyGcZa9RLbNun3ZcvTYSfVGPM7RWl5RLlDSIh9B3xBhGo6LUUs04KzQrFw3rNeHcriAu1CiXrX2xGnLYzzANX7JNsiG6JQo9RGfFVYclDO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OJXenaL7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761215565;
	bh=lnlDA75XwSH6t7f4Sxf4Fx77SWg2aMAL/WovUBbyRHI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OJXenaL7/YKAsxPJgN1lkpSGik2JFQB7lfYuGAKYicZJ+UEIZ6wCWe3b/evLvv+cx
	 CZYy+OzOC4iv0M7MGSD9d11W8cE+AOsCS4aCvs2qGiDPb0Pu/cK0yAO3lKoENC9S7l
	 dui+oG9gMujlVZFT1rK7P/3nvIhOnYFnS7OjgABVORxkkQK5ZIFDAcnsA0zQ3FOBkA
	 KrrN0IOZWvu73ga6zLLUcrxBCiiFYkbeV2Z6ezuGx6fHy6vOZ5YtDo/nfi0RnFVH5t
	 UovxoaiCbFw0yzOfbugh7hT/F2hQzDw3M7NzlbYBwqiXOjGZ8LrasAvkYNuJCF9UFz
	 HI5Lb5w2upJTA==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 552AE17E108C;
	Thu, 23 Oct 2025 12:32:45 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Thu, 23 Oct 2025 12:32:36 +0200
Subject: [PATCH v11 10/11] drm/mediatek: mtk_hdmi_v2: Add debugfs ops and
 implement ABIST
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-mediatek-drm-hdmi-v2-v11-10-7873ec4a1edf@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761215558; l=4905;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=PMjpVsvfMlCl3nXG1Reu83S0JBpG21E5RMsIp2ijCpk=;
 b=8Y9bjN7PdetCOarBP+zHjHO0xlEueR9H8K0N/6GYT8crw4g6tJVjZrhfQTmRICuPkMnL7yEFT
 KynR8o+3i5iBeBlEFrXGoB0VKqX2qYg4GBvjCQQ550kiZvJ8SBREt+t
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Implement the Automated Built-In Self-Test ABIST functionality
provided by the HDMIv2 IP and expose it through the "hdmi_abist"
debugfs file.

Write "1" to this file to activate ABIST, or "0" to deactivate.

The ABIST functionality can be used to validate that the HDMI
Transmitter itself works and that can output a valid image to
the HDMI Display that is connected.

This is especially useful when trying to rule out any possible
issue that is related to the display pipeline, as the HDMI Tx
is always the last component; this means that HDMI ABIST can be
used even without prior display controller pipeline configuration.

The expected output is a 100% color bar (rainbow) test pattern.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_v2.c | 123 +++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
index 2e8d8aed3c47417200dd951755cc2e3ef41df75d..c272e1e74b7de03a726402f77296b05c87b24e05 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
@@ -1190,6 +1190,128 @@ static int mtk_hdmi_v2_hdmi_write_infoframe(struct drm_bridge *bridge,
 	return 0;
 }
 
+static int mtk_hdmi_v2_set_abist(struct mtk_hdmi *hdmi, bool enable)
+{
+	struct drm_display_mode *mode = &hdmi->mode;
+	int abist_format = -EINVAL;
+	bool interlaced;
+
+	if (!enable) {
+		regmap_clear_bits(hdmi->regs, TOP_CFG00, HDMI_ABIST_ENABLE);
+		return 0;
+	}
+
+	if (!mode->hdisplay || !mode->vdisplay)
+		return -EINVAL;
+
+	interlaced = mode->flags & DRM_MODE_FLAG_INTERLACE;
+
+	switch (mode->hdisplay) {
+	case 720:
+		if (mode->vdisplay == 480)
+			abist_format = 2;
+		else if (mode->vdisplay == 576)
+			abist_format = 11;
+		break;
+	case 1280:
+		if (mode->vdisplay == 720)
+			abist_format = 3;
+		break;
+	case 1440:
+		if (mode->vdisplay == 480)
+			abist_format = interlaced ? 5 : 9;
+		else if (mode->vdisplay == 576)
+			abist_format = interlaced ? 14 : 18;
+		break;
+	case 1920:
+		if (mode->vdisplay == 1080)
+			abist_format = interlaced ? 4 : 10;
+		break;
+	case 3840:
+		if (mode->vdisplay == 2160)
+			abist_format = 25;
+		break;
+	case 4096:
+		if (mode->vdisplay == 2160)
+			abist_format = 26;
+		break;
+	default:
+		break;
+	}
+	if (abist_format < 0)
+		return abist_format;
+
+	regmap_update_bits(hdmi->regs, TOP_CFG00, HDMI_ABIST_VIDEO_FORMAT,
+			   FIELD_PREP(HDMI_ABIST_VIDEO_FORMAT, abist_format));
+	regmap_set_bits(hdmi->regs, TOP_CFG00, HDMI_ABIST_ENABLE);
+	return 0;
+}
+
+static int mtk_hdmi_v2_debug_abist_show(struct seq_file *m, void *arg)
+{
+	struct mtk_hdmi *hdmi = m->private;
+	bool en;
+	u32 val;
+	int ret;
+
+	if (!hdmi)
+		return -EINVAL;
+
+	ret = regmap_read(hdmi->regs, TOP_CFG00, &val);
+	if (ret)
+		return ret;
+
+	en = FIELD_GET(HDMI_ABIST_ENABLE, val);
+
+	seq_printf(m, "HDMI Automated Built-In Self Test: %s\n",
+		   en ? "Enabled" : "Disabled");
+
+	return 0;
+}
+
+static ssize_t mtk_hdmi_v2_debug_abist_write(struct file *file,
+					     const char __user *ubuf,
+					     size_t len, loff_t *offp)
+{
+	struct seq_file *m = file->private_data;
+	int ret;
+	u32 en;
+
+	if (!m || !m->private || *offp)
+		return -EINVAL;
+
+	ret = kstrtouint_from_user(ubuf, len, 0, &en);
+	if (ret)
+		return ret;
+
+	if (en < 0 || en > 1)
+		return -EINVAL;
+
+	mtk_hdmi_v2_set_abist((struct mtk_hdmi *)m->private, en);
+	return len;
+}
+
+static int mtk_hdmi_v2_debug_abist_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, mtk_hdmi_v2_debug_abist_show, inode->i_private);
+}
+
+static const struct file_operations mtk_hdmi_debug_abist_fops = {
+	.owner = THIS_MODULE,
+	.open = mtk_hdmi_v2_debug_abist_open,
+	.read = seq_read,
+	.write = mtk_hdmi_v2_debug_abist_write,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static void mtk_hdmi_v2_debugfs_init(struct drm_bridge *bridge, struct dentry *root)
+{
+	struct mtk_hdmi *dpi = hdmi_ctx_from_bridge(bridge);
+
+	debugfs_create_file("hdmi_abist", 0640, root, dpi, &mtk_hdmi_debug_abist_fops);
+}
+
 static const struct drm_bridge_funcs mtk_v2_hdmi_bridge_funcs = {
 	.attach = mtk_hdmi_v2_bridge_attach,
 	.detach = mtk_hdmi_v2_bridge_detach,
@@ -1209,6 +1331,7 @@ static const struct drm_bridge_funcs mtk_v2_hdmi_bridge_funcs = {
 	.hdmi_tmds_char_rate_valid = mtk_hdmi_v2_hdmi_tmds_char_rate_valid,
 	.hdmi_clear_infoframe = mtk_hdmi_v2_hdmi_clear_infoframe,
 	.hdmi_write_infoframe = mtk_hdmi_v2_hdmi_write_infoframe,
+	.debugfs_init = mtk_hdmi_v2_debugfs_init,
 };
 
 /*

-- 
2.51.0


