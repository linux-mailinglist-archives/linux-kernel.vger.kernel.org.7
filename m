Return-Path: <linux-kernel+bounces-596017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E3CA825E1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 15:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31FC24A3DE4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 13:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020322676F5;
	Wed,  9 Apr 2025 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Dhob8fck"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F82825E820;
	Wed,  9 Apr 2025 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744204415; cv=none; b=aGcE4l+FsJ99EMrdMQyCSPqP+O5GLdxeGPjqFa5gN+AgAOghxn0MZxiB/JiPCFrzu+oQF31TmIMDB6l7P566Afm1eTZuLDr+DQmZKv7QsOPyHQd0+qqZd04KtYcAC5ztdFWLQAKKNqUo+GjtDcXCAxOiKSmet+WeNY/P4LSX64Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744204415; c=relaxed/simple;
	bh=JqZ3/vTag+nSrONfUGF9B/sGFanxOhDFoU6S2gET7LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9RAitfieZm3a7NKLuz6IMEFVI3IvxUkb1sNA88yOHNVoiQsVwiQnm2zBUWb7mwEgjjbnPzvK/BI2msY8HQ8DFiyrm6URLzE8WVt7NsmtOulAz+dMC1iy8ipT+ioFQrtXrUuZh/28HQ5eFaky2rmmomELqLcLI+usBRifyk+tLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Dhob8fck; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744204411;
	bh=JqZ3/vTag+nSrONfUGF9B/sGFanxOhDFoU6S2gET7LY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dhob8fcknnTtYbof+pg96yD9Iulgg68hV8cAHNWF8QEHeYuuhHzP/k4lTMUpb173y
	 ZdAnz8knyjhTgoB6eMAc59xSHdK3C0Ir0MwhPDYXCN6/0XTxpytSMIQC+VcUnWeP+4
	 nUEVpVHe2LWt0q6nKsp9PMVZgXnwLC2XKUJBHbOPgUr6u1iAfINVYdFkln5ekVixoj
	 YWR2+q4KSRA60tqu0LNc64U0qeRMzPgd6rtc1pzgfoW7f1CA/Hm1WoV9RG48uUmVbF
	 oLqtzim0V9mipHwRkvuShq1n6OlBmXk81P74QEA4GqMEyoh9bcxs+3JIi08tm59GvX
	 k7No1koRJuPBw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 27AAC17E10F7;
	Wed,  9 Apr 2025 15:13:30 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ck.hu@mediatek.com,
	jitao.shi@mediatek.com,
	jie.qiu@mediatek.com,
	junzhi.zhao@mediatek.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	dmitry.baryshkov@linaro.org,
	lewis.liao@mediatek.com,
	ives.chenjh@mediatek.com,
	tommyyl.chen@mediatek.com,
	jason-jh.lin@mediatek.com,
	Guillaume Ranquet <granquet@baylibre.com>
Subject: [PATCH v8 06/23] drm/mediatek: hdmi: Use regmap instead of iomem for main registers
Date: Wed,  9 Apr 2025 15:13:01 +0200
Message-ID: <20250409131318.108690-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409131318.108690-1-angelogioacchino.delregno@collabora.com>
References: <20250409131318.108690-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guillaume Ranquet <granquet@baylibre.com>

In preparation for the addition of a new version of the HDMI IP
which will need to share its iospace between multiple subdrivers,
and in preparation for moving out the common bits between the two,
migrate this driver to fully use regmap.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 171 +++++++++++-----------------
 1 file changed, 65 insertions(+), 106 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 30eea57be991..190334aa7624 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -164,7 +164,7 @@ struct mtk_hdmi {
 	bool dvi_mode;
 	struct regmap *sys_regmap;
 	unsigned int sys_offset;
-	void __iomem *regs;
+	struct regmap *regs;
 	struct platform_device *audio_pdev;
 	struct hdmi_audio_param aud_param;
 	bool audio_enable;
@@ -180,50 +180,10 @@ static inline struct mtk_hdmi *hdmi_ctx_from_bridge(struct drm_bridge *b)
 	return container_of(b, struct mtk_hdmi, bridge);
 }
 
-static u32 mtk_hdmi_read(struct mtk_hdmi *hdmi, u32 offset)
-{
-	return readl(hdmi->regs + offset);
-}
-
-static void mtk_hdmi_write(struct mtk_hdmi *hdmi, u32 offset, u32 val)
-{
-	writel(val, hdmi->regs + offset);
-}
-
-static void mtk_hdmi_clear_bits(struct mtk_hdmi *hdmi, u32 offset, u32 bits)
-{
-	void __iomem *reg = hdmi->regs + offset;
-	u32 tmp;
-
-	tmp = readl(reg);
-	tmp &= ~bits;
-	writel(tmp, reg);
-}
-
-static void mtk_hdmi_set_bits(struct mtk_hdmi *hdmi, u32 offset, u32 bits)
-{
-	void __iomem *reg = hdmi->regs + offset;
-	u32 tmp;
-
-	tmp = readl(reg);
-	tmp |= bits;
-	writel(tmp, reg);
-}
-
-static void mtk_hdmi_mask(struct mtk_hdmi *hdmi, u32 offset, u32 val, u32 mask)
-{
-	void __iomem *reg = hdmi->regs + offset;
-	u32 tmp;
-
-	tmp = readl(reg);
-	tmp = (tmp & ~mask) | (val & mask);
-	writel(tmp, reg);
-}
-
 static void mtk_hdmi_hw_vid_black(struct mtk_hdmi *hdmi, bool black)
 {
-	mtk_hdmi_mask(hdmi, VIDEO_CFG_4, black ? GEN_RGB : NORMAL_PATH,
-		      VIDEO_SOURCE_SEL);
+	regmap_update_bits(hdmi->regs, VIDEO_SOURCE_SEL,
+			   VIDEO_CFG_4, black ? GEN_RGB : NORMAL_PATH);
 }
 
 static void mtk_hdmi_hw_make_reg_writable(struct mtk_hdmi *hdmi, bool enable)
@@ -258,12 +218,12 @@ static void mtk_hdmi_hw_1p4_version_enable(struct mtk_hdmi *hdmi, bool enable)
 
 static void mtk_hdmi_hw_aud_mute(struct mtk_hdmi *hdmi)
 {
-	mtk_hdmi_set_bits(hdmi, GRL_AUDIO_CFG, AUDIO_ZERO);
+	regmap_set_bits(hdmi->regs, GRL_AUDIO_CFG, AUDIO_ZERO);
 }
 
 static void mtk_hdmi_hw_aud_unmute(struct mtk_hdmi *hdmi)
 {
-	mtk_hdmi_clear_bits(hdmi, GRL_AUDIO_CFG, AUDIO_ZERO);
+	regmap_clear_bits(hdmi->regs, GRL_AUDIO_CFG, AUDIO_ZERO);
 }
 
 static void mtk_hdmi_hw_reset(struct mtk_hdmi *hdmi)
@@ -272,25 +232,25 @@ static void mtk_hdmi_hw_reset(struct mtk_hdmi *hdmi)
 			   HDMI_RST, HDMI_RST);
 	regmap_update_bits(hdmi->sys_regmap, hdmi->sys_offset + HDMI_SYS_CFG1C,
 			   HDMI_RST, 0);
-	mtk_hdmi_clear_bits(hdmi, GRL_CFG3, CFG3_CONTROL_PACKET_DELAY);
+	regmap_clear_bits(hdmi->regs, GRL_CFG3, CFG3_CONTROL_PACKET_DELAY);
 	regmap_update_bits(hdmi->sys_regmap, hdmi->sys_offset + HDMI_SYS_CFG1C,
 			   ANLG_ON, ANLG_ON);
 }
 
 static void mtk_hdmi_hw_enable_notice(struct mtk_hdmi *hdmi, bool enable_notice)
 {
-	mtk_hdmi_mask(hdmi, GRL_CFG2, enable_notice ? CFG2_NOTICE_EN : 0,
-		      CFG2_NOTICE_EN);
+	regmap_update_bits(hdmi->regs, GRL_CFG2, CFG2_NOTICE_EN,
+			   enable_notice ? CFG2_NOTICE_EN : 0);
 }
 
 static void mtk_hdmi_hw_write_int_mask(struct mtk_hdmi *hdmi, u32 int_mask)
 {
-	mtk_hdmi_write(hdmi, GRL_INT_MASK, int_mask);
+	regmap_write(hdmi->regs, GRL_INT_MASK, int_mask);
 }
 
 static void mtk_hdmi_hw_enable_dvi_mode(struct mtk_hdmi *hdmi, bool enable)
 {
-	mtk_hdmi_mask(hdmi, GRL_CFG1, enable ? CFG1_DVI : 0, CFG1_DVI);
+	regmap_update_bits(hdmi->regs, GRL_CFG1, CFG1_DVI, enable ? CFG1_DVI : 0);
 }
 
 static void mtk_hdmi_hw_send_info_frame(struct mtk_hdmi *hdmi, u8 *buffer,
@@ -336,22 +296,22 @@ static void mtk_hdmi_hw_send_info_frame(struct mtk_hdmi *hdmi, u8 *buffer,
 		dev_err(hdmi->dev, "Unknown infoframe type %d\n", frame_type);
 		return;
 	}
-	mtk_hdmi_clear_bits(hdmi, ctrl_reg, ctrl_frame_en);
-	mtk_hdmi_write(hdmi, GRL_INFOFRM_TYPE, frame_type);
-	mtk_hdmi_write(hdmi, GRL_INFOFRM_VER, frame_ver);
-	mtk_hdmi_write(hdmi, GRL_INFOFRM_LNG, frame_len);
+	regmap_clear_bits(hdmi->regs, ctrl_reg, ctrl_frame_en);
+	regmap_write(hdmi->regs, GRL_INFOFRM_TYPE, frame_type);
+	regmap_write(hdmi->regs, GRL_INFOFRM_VER, frame_ver);
+	regmap_write(hdmi->regs, GRL_INFOFRM_LNG, frame_len);
 
-	mtk_hdmi_write(hdmi, GRL_IFM_PORT, checksum);
+	regmap_write(hdmi->regs, GRL_IFM_PORT, checksum);
 	for (i = 0; i < frame_len; i++)
-		mtk_hdmi_write(hdmi, GRL_IFM_PORT, frame_data[i]);
+		regmap_write(hdmi->regs, GRL_IFM_PORT, frame_data[i]);
 
-	mtk_hdmi_set_bits(hdmi, ctrl_reg, ctrl_frame_en);
+	regmap_set_bits(hdmi->regs, ctrl_reg, ctrl_frame_en);
 }
 
 static void mtk_hdmi_hw_send_aud_packet(struct mtk_hdmi *hdmi, bool enable)
 {
-	mtk_hdmi_mask(hdmi, GRL_SHIFT_R2, enable ? 0 : AUDIO_PACKET_OFF,
-		      AUDIO_PACKET_OFF);
+	regmap_update_bits(hdmi->regs, AUDIO_PACKET_OFF,
+			   GRL_SHIFT_R2, enable ? 0 : AUDIO_PACKET_OFF);
 }
 
 static void mtk_hdmi_hw_config_sys(struct mtk_hdmi *hdmi)
@@ -372,44 +332,44 @@ static void mtk_hdmi_hw_set_deep_color_mode(struct mtk_hdmi *hdmi)
 
 static void mtk_hdmi_hw_send_av_mute(struct mtk_hdmi *hdmi)
 {
-	mtk_hdmi_clear_bits(hdmi, GRL_CFG4, CTRL_AVMUTE);
+	regmap_clear_bits(hdmi->regs, GRL_CFG4, CTRL_AVMUTE);
 	usleep_range(2000, 4000);
-	mtk_hdmi_set_bits(hdmi, GRL_CFG4, CTRL_AVMUTE);
+	regmap_set_bits(hdmi->regs, GRL_CFG4, CTRL_AVMUTE);
 }
 
 static void mtk_hdmi_hw_send_av_unmute(struct mtk_hdmi *hdmi)
 {
-	mtk_hdmi_mask(hdmi, GRL_CFG4, CFG4_AV_UNMUTE_EN,
-		      CFG4_AV_UNMUTE_EN | CFG4_AV_UNMUTE_SET);
+	regmap_update_bits(hdmi->regs, GRL_CFG4, CFG4_AV_UNMUTE_EN | CFG4_AV_UNMUTE_SET,
+			   CFG4_AV_UNMUTE_EN);
 	usleep_range(2000, 4000);
-	mtk_hdmi_mask(hdmi, GRL_CFG4, CFG4_AV_UNMUTE_SET,
-		      CFG4_AV_UNMUTE_EN | CFG4_AV_UNMUTE_SET);
+	regmap_update_bits(hdmi->regs, GRL_CFG4, CFG4_AV_UNMUTE_EN | CFG4_AV_UNMUTE_SET,
+			   CFG4_AV_UNMUTE_SET);
 }
 
 static void mtk_hdmi_hw_ncts_enable(struct mtk_hdmi *hdmi, bool on)
 {
-	mtk_hdmi_mask(hdmi, GRL_CTS_CTRL, on ? 0 : CTS_CTRL_SOFT,
-		      CTS_CTRL_SOFT);
+	regmap_update_bits(hdmi->regs, GRL_CTS_CTRL, CTS_CTRL_SOFT,
+			   on ? 0 : CTS_CTRL_SOFT);
 }
 
 static void mtk_hdmi_hw_ncts_auto_write_enable(struct mtk_hdmi *hdmi,
 					       bool enable)
 {
-	mtk_hdmi_mask(hdmi, GRL_CTS_CTRL, enable ? NCTS_WRI_ANYTIME : 0,
-		      NCTS_WRI_ANYTIME);
+	regmap_update_bits(hdmi->regs, GRL_CTS_CTRL, NCTS_WRI_ANYTIME,
+			   enable ? NCTS_WRI_ANYTIME : 0);
 }
 
 static void mtk_hdmi_hw_msic_setting(struct mtk_hdmi *hdmi,
 				     struct drm_display_mode *mode)
 {
-	mtk_hdmi_clear_bits(hdmi, GRL_CFG4, CFG4_MHL_MODE);
+	regmap_clear_bits(hdmi->regs, GRL_CFG4, CFG4_MHL_MODE);
 
 	if (mode->flags & DRM_MODE_FLAG_INTERLACE &&
 	    mode->clock == 74250 &&
 	    mode->vdisplay == 1080)
-		mtk_hdmi_clear_bits(hdmi, GRL_CFG2, CFG2_MHL_DE_SEL);
+		regmap_clear_bits(hdmi->regs, GRL_CFG2, CFG2_MHL_DE_SEL);
 	else
-		mtk_hdmi_set_bits(hdmi, GRL_CFG2, CFG2_MHL_DE_SEL);
+		regmap_set_bits(hdmi->regs, GRL_CFG2, CFG2_MHL_DE_SEL);
 }
 
 static void mtk_hdmi_hw_aud_set_channel_swap(struct mtk_hdmi *hdmi,
@@ -437,7 +397,7 @@ static void mtk_hdmi_hw_aud_set_channel_swap(struct mtk_hdmi *hdmi,
 		swap_bit = LFE_CC_SWAP;
 		break;
 	}
-	mtk_hdmi_mask(hdmi, GRL_CH_SWAP, swap_bit, 0xff);
+	regmap_update_bits(hdmi->regs, GRL_CH_SWAP, 0xff, swap_bit);
 }
 
 static void mtk_hdmi_hw_aud_set_bit_num(struct mtk_hdmi *hdmi,
@@ -458,7 +418,7 @@ static void mtk_hdmi_hw_aud_set_bit_num(struct mtk_hdmi *hdmi,
 		break;
 	}
 
-	mtk_hdmi_mask(hdmi, GRL_AOUT_CFG, val, AOUT_BNUM_SEL_MASK);
+	regmap_update_bits(hdmi->regs, GRL_AOUT_CFG, AOUT_BNUM_SEL_MASK, val);
 }
 
 static void mtk_hdmi_hw_aud_set_i2s_fmt(struct mtk_hdmi *hdmi,
@@ -466,7 +426,7 @@ static void mtk_hdmi_hw_aud_set_i2s_fmt(struct mtk_hdmi *hdmi,
 {
 	u32 val;
 
-	val = mtk_hdmi_read(hdmi, GRL_CFG0);
+	regmap_read(hdmi->regs, GRL_CFG0, &val);
 	val &= ~(CFG0_W_LENGTH_MASK | CFG0_I2S_MODE_MASK);
 
 	switch (i2s_fmt) {
@@ -490,7 +450,7 @@ static void mtk_hdmi_hw_aud_set_i2s_fmt(struct mtk_hdmi *hdmi,
 		val |= CFG0_I2S_MODE_I2S | CFG0_W_LENGTH_16BIT;
 		break;
 	}
-	mtk_hdmi_write(hdmi, GRL_CFG0, val);
+	regmap_write(hdmi->regs, GRL_CFG0, val);
 }
 
 static void mtk_hdmi_hw_audio_config(struct mtk_hdmi *hdmi, bool dst)
@@ -499,14 +459,14 @@ static void mtk_hdmi_hw_audio_config(struct mtk_hdmi *hdmi, bool dst)
 	u8 val;
 
 	/* Disable high bitrate, set DST packet normal/double */
-	mtk_hdmi_clear_bits(hdmi, GRL_AOUT_CFG, HIGH_BIT_RATE_PACKET_ALIGN);
+	regmap_clear_bits(hdmi->regs, GRL_AOUT_CFG, HIGH_BIT_RATE_PACKET_ALIGN);
 
 	if (dst)
 		val = DST_NORMAL_DOUBLE | SACD_DST;
 	else
 		val = 0;
 
-	mtk_hdmi_mask(hdmi, GRL_AUDIO_CFG, val, mask);
+	regmap_update_bits(hdmi->regs, GRL_AUDIO_CFG, mask, val);
 }
 
 static void mtk_hdmi_hw_aud_set_i2s_chan_num(struct mtk_hdmi *hdmi,
@@ -547,10 +507,10 @@ static void mtk_hdmi_hw_aud_set_i2s_chan_num(struct mtk_hdmi *hdmi,
 		i2s_uv = I2S_UV_CH_EN(0);
 	}
 
-	mtk_hdmi_write(hdmi, GRL_CH_SW0, ch_switch & 0xff);
-	mtk_hdmi_write(hdmi, GRL_CH_SW1, (ch_switch >> 8) & 0xff);
-	mtk_hdmi_write(hdmi, GRL_CH_SW2, (ch_switch >> 16) & 0xff);
-	mtk_hdmi_write(hdmi, GRL_I2S_UV, i2s_uv);
+	regmap_write(hdmi->regs, GRL_CH_SW0, ch_switch & 0xff);
+	regmap_write(hdmi->regs, GRL_CH_SW1, (ch_switch >> 8) & 0xff);
+	regmap_write(hdmi->regs, GRL_CH_SW2, (ch_switch >> 16) & 0xff);
+	regmap_write(hdmi->regs, GRL_I2S_UV, i2s_uv);
 }
 
 static void mtk_hdmi_hw_aud_set_input_type(struct mtk_hdmi *hdmi,
@@ -558,7 +518,7 @@ static void mtk_hdmi_hw_aud_set_input_type(struct mtk_hdmi *hdmi,
 {
 	u32 val;
 
-	val = mtk_hdmi_read(hdmi, GRL_CFG1);
+	regmap_read(hdmi->regs, GRL_CFG1, &val);
 	if (input_type == HDMI_AUD_INPUT_I2S &&
 	    (val & CFG1_SPDIF) == CFG1_SPDIF) {
 		val &= ~CFG1_SPDIF;
@@ -566,7 +526,7 @@ static void mtk_hdmi_hw_aud_set_input_type(struct mtk_hdmi *hdmi,
 		(val & CFG1_SPDIF) == 0) {
 		val |= CFG1_SPDIF;
 	}
-	mtk_hdmi_write(hdmi, GRL_CFG1, val);
+	regmap_write(hdmi->regs, GRL_CFG1, val);
 }
 
 static void mtk_hdmi_hw_aud_set_channel_status(struct mtk_hdmi *hdmi,
@@ -575,13 +535,13 @@ static void mtk_hdmi_hw_aud_set_channel_status(struct mtk_hdmi *hdmi,
 	int i;
 
 	for (i = 0; i < 5; i++) {
-		mtk_hdmi_write(hdmi, GRL_I2S_C_STA0 + i * 4, channel_status[i]);
-		mtk_hdmi_write(hdmi, GRL_L_STATUS_0 + i * 4, channel_status[i]);
-		mtk_hdmi_write(hdmi, GRL_R_STATUS_0 + i * 4, channel_status[i]);
+		regmap_write(hdmi->regs, GRL_I2S_C_STA0 + i * 4, channel_status[i]);
+		regmap_write(hdmi->regs, GRL_L_STATUS_0 + i * 4, channel_status[i]);
+		regmap_write(hdmi->regs, GRL_R_STATUS_0 + i * 4, channel_status[i]);
 	}
 	for (; i < 24; i++) {
-		mtk_hdmi_write(hdmi, GRL_L_STATUS_0 + i * 4, 0);
-		mtk_hdmi_write(hdmi, GRL_R_STATUS_0 + i * 4, 0);
+		regmap_write(hdmi->regs, GRL_L_STATUS_0 + i * 4, 0);
+		regmap_write(hdmi->regs, GRL_R_STATUS_0 + i * 4, 0);
 	}
 }
 
@@ -589,13 +549,13 @@ static void mtk_hdmi_hw_aud_src_reenable(struct mtk_hdmi *hdmi)
 {
 	u32 val;
 
-	val = mtk_hdmi_read(hdmi, GRL_MIX_CTRL);
+	regmap_read(hdmi->regs, GRL_MIX_CTRL, &val);
 	if (val & MIX_CTRL_SRC_EN) {
 		val &= ~MIX_CTRL_SRC_EN;
-		mtk_hdmi_write(hdmi, GRL_MIX_CTRL, val);
+		regmap_write(hdmi->regs, GRL_MIX_CTRL, val);
 		usleep_range(255, 512);
 		val |= MIX_CTRL_SRC_EN;
-		mtk_hdmi_write(hdmi, GRL_MIX_CTRL, val);
+		regmap_write(hdmi->regs, GRL_MIX_CTRL, val);
 	}
 }
 
@@ -603,10 +563,10 @@ static void mtk_hdmi_hw_aud_src_disable(struct mtk_hdmi *hdmi)
 {
 	u32 val;
 
-	val = mtk_hdmi_read(hdmi, GRL_MIX_CTRL);
+	regmap_read(hdmi->regs, GRL_MIX_CTRL, &val);
 	val &= ~MIX_CTRL_SRC_EN;
-	mtk_hdmi_write(hdmi, GRL_MIX_CTRL, val);
-	mtk_hdmi_write(hdmi, GRL_SHIFT_L1, 0x00);
+	regmap_write(hdmi->regs, GRL_MIX_CTRL, val);
+	regmap_write(hdmi->regs, GRL_SHIFT_L1, 0x00);
 }
 
 static void mtk_hdmi_hw_aud_set_mclk(struct mtk_hdmi *hdmi,
@@ -614,7 +574,7 @@ static void mtk_hdmi_hw_aud_set_mclk(struct mtk_hdmi *hdmi,
 {
 	u32 val;
 
-	val = mtk_hdmi_read(hdmi, GRL_CFG5);
+	regmap_read(hdmi->regs, GRL_CFG5, &val);
 	val &= CFG5_CD_RATIO_MASK;
 
 	switch (mclk) {
@@ -637,7 +597,7 @@ static void mtk_hdmi_hw_aud_set_mclk(struct mtk_hdmi *hdmi,
 		val |= CFG5_FS256;
 		break;
 	}
-	mtk_hdmi_write(hdmi, GRL_CFG5, val);
+	regmap_write(hdmi->regs, GRL_CFG5, val);
 }
 
 struct hdmi_acr_n {
@@ -721,9 +681,9 @@ static void do_hdmi_hw_aud_set_ncts(struct mtk_hdmi *hdmi, unsigned int n,
 	unsigned char val[NCTS_BYTES];
 	int i;
 
-	mtk_hdmi_write(hdmi, GRL_NCTS, 0);
-	mtk_hdmi_write(hdmi, GRL_NCTS, 0);
-	mtk_hdmi_write(hdmi, GRL_NCTS, 0);
+	regmap_write(hdmi->regs, GRL_NCTS, 0);
+	regmap_write(hdmi->regs, GRL_NCTS, 0);
+	regmap_write(hdmi->regs, GRL_NCTS, 0);
 	memset(val, 0, sizeof(val));
 
 	val[0] = (cts >> 24) & 0xff;
@@ -736,7 +696,7 @@ static void do_hdmi_hw_aud_set_ncts(struct mtk_hdmi *hdmi, unsigned int n,
 	val[6] = n & 0xff;
 
 	for (i = 0; i < NCTS_BYTES; i++)
-		mtk_hdmi_write(hdmi, GRL_NCTS, val[i]);
+		regmap_write(hdmi->regs, GRL_NCTS, val[i]);
 }
 
 static void mtk_hdmi_hw_aud_set_ncts(struct mtk_hdmi *hdmi,
@@ -751,8 +711,7 @@ static void mtk_hdmi_hw_aud_set_ncts(struct mtk_hdmi *hdmi,
 	dev_dbg(hdmi->dev, "%s: sample_rate=%u, clock=%d, cts=%u, n=%u\n",
 		__func__, sample_rate, clock, n, cts);
 
-	mtk_hdmi_mask(hdmi, DUMMY_304, AUDIO_I2S_NCTS_SEL_64,
-		      AUDIO_I2S_NCTS_SEL);
+	regmap_update_bits(hdmi->regs, DUMMY_304, AUDIO_I2S_NCTS_SEL, AUDIO_I2S_NCTS_SEL_64);
 	do_hdmi_hw_aud_set_ncts(hdmi, n, cts);
 }
 
@@ -872,7 +831,7 @@ static void mtk_hdmi_aud_set_input(struct mtk_hdmi *hdmi)
 	bool dst;
 
 	mtk_hdmi_hw_aud_set_channel_swap(hdmi, HDMI_AUD_SWAP_LFE_CC);
-	mtk_hdmi_set_bits(hdmi, GRL_MIX_CTRL, MIX_CTRL_FLAT);
+	regmap_set_bits(hdmi->regs, GRL_MIX_CTRL, MIX_CTRL_FLAT);
 
 	if (hdmi->aud_param.aud_input_type == HDMI_AUD_INPUT_SPDIF &&
 	    hdmi->aud_param.aud_codec == HDMI_AUDIO_CODING_TYPE_DST) {
@@ -904,7 +863,7 @@ static int mtk_hdmi_aud_set_src(struct mtk_hdmi *hdmi,
 
 	mtk_hdmi_hw_ncts_enable(hdmi, false);
 	mtk_hdmi_hw_aud_src_disable(hdmi);
-	mtk_hdmi_clear_bits(hdmi, GRL_CFG2, CFG2_ACLK_INV);
+	regmap_clear_bits(hdmi->regs, GRL_CFG2, CFG2_ACLK_INV);
 
 	if (hdmi->aud_param.aud_input_type == HDMI_AUD_INPUT_I2S) {
 		switch (sample_rate) {
@@ -1459,7 +1418,7 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
 	}
 	hdmi->sys_regmap = regmap;
 
-	hdmi->regs = devm_platform_ioremap_resource(pdev, 0);
+	hdmi->regs = device_node_to_regmap(dev->of_node);
 	if (IS_ERR(hdmi->regs)) {
 		ret = PTR_ERR(hdmi->regs);
 		goto put_device;
-- 
2.49.0


