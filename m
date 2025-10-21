Return-Path: <linux-kernel+bounces-862613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B90BF5C03
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEFE04660C9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBC832D425;
	Tue, 21 Oct 2025 10:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kIGkpJlA"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22C032B9BB
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041981; cv=none; b=Ao36z7LJTGwGiUMk2e0dIo9E8zW7nZpFkKWFFF1oDtyz2oQ/klqpBnAOO44g/FORmD0NLJUQXim9ry367yXio1m+qMeNB7oOktxxNzi+Fc+OySXaoUvM3pbOplh0d93mxJCxL4vbXQ8MR8Vl9Nj638ybQXow9DD3yW5IKbE5eFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041981; c=relaxed/simple;
	bh=Oq23yGZ/GtFdV1bxn1QAep1nMXJorSEThDKlDL/e8Ec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SzMqxH0GRbWOAwCuqe4qBoBJvX1i7IoobgLzjGtZidyxc9HBPz+nBYtLeNZeMmeCYVyLAZjAdJABByf+IiA19XVXhv1qpA4DpD9FAlSA+zlmbk0du2azKQSy6z1lKWgCX5bMxlrzxJLCnBEpcXP2/Xj70zOsouAgPfjmcANEY00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kIGkpJlA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761041972;
	bh=Oq23yGZ/GtFdV1bxn1QAep1nMXJorSEThDKlDL/e8Ec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kIGkpJlAeylMJRXzfCmSUMtS0keJbPqm8Z9JcspzOjrzHj46Er9JoxjYPE1fVI9q7
	 H1XO4dqZDTAQwwOa5Vf8v6YziT5LVO05qpUi6IPaXJXKAmoPYpNO+X5kjgrxt/U249
	 QEe11QEAQz8RpY/FDBm/m18V0bxJEN1miKxToZ935lhji3LE/PsxCgOSoQXkSE1drh
	 0/ZNacYRTkyOe8lBz0bMJFh82bPxalZ3IkzR5G4oKpjGzFh6yQJoNHhXItyJ9fV0Y8
	 dZhxEthXWlFqmjYFRoqMTD35idig58BL8W8sWVYAnAe+h1Y8aY+NWWOu79K3gLDL3w
	 GuRwu8p2jwQbg==
Received: from localhost (unknown [82.79.138.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 2F35217E1414;
	Tue, 21 Oct 2025 12:19:32 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 21 Oct 2025 13:19:18 +0300
Subject: [PATCH v3 5/5] drm/rockchip: dw_hdmi_qp: Add high color depth
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-rk3588-10bpc-v3-5-3d3eed00a6db@collabora.com>
References: <20251021-rk3588-10bpc-v3-0-3d3eed00a6db@collabora.com>
In-Reply-To: <20251021-rk3588-10bpc-v3-0-3d3eed00a6db@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Stone <daniels@collabora.com>
X-Mailer: b4 0.14.3

Since both RK3576 and RK3588 SoCs are capable of handling 10 bpc color
depth, introduce a pair of new helpers to program the necessary
registers, as well as passing bpc at PHY configuration level.

Note max_bpc is unconditionally set to 10 before initializing the QP
bridge library, as there is no need to adjust it dynamically, i.e. per
SoC variant, for now.

While setting up .enc_init() callbacks of rockchip_hdmi_qp_ctrl_ops,
also replace the unnecessary whitespace chars before .irq_callback()
assignments.

Acked-by: Daniel Stone <daniels@collabora.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 54 ++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index ac5ec697b9a2..ca3fa3965302 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -70,6 +70,12 @@
 #define RK3588_HDMI1_LEVEL_INT		BIT(24)
 #define RK3588_GRF_VO1_CON3		0x000c
 #define RK3588_GRF_VO1_CON6		0x0018
+#define RK3588_COLOR_DEPTH_MASK		GENMASK(7, 4)
+#define RK3588_8BPC			0x0
+#define RK3588_10BPC			0x6
+#define RK3588_COLOR_FORMAT_MASK	GENMASK(3, 0)
+#define RK3588_RGB			0x0
+#define RK3588_YUV420			0x3
 #define RK3588_SCLIN_MASK		BIT(9)
 #define RK3588_SDAIN_MASK		BIT(10)
 #define RK3588_MODE_MASK		BIT(11)
@@ -97,6 +103,7 @@ struct rockchip_hdmi_qp {
 
 struct rockchip_hdmi_qp_ctrl_ops {
 	void (*io_init)(struct rockchip_hdmi_qp *hdmi);
+	void (*enc_init)(struct rockchip_hdmi_qp *hdmi, struct rockchip_crtc_state *state);
 	irqreturn_t (*irq_callback)(int irq, void *dev_id);
 	irqreturn_t (*hardirq_callback)(int irq, void *dev_id);
 };
@@ -111,9 +118,16 @@ static struct rockchip_hdmi_qp *to_rockchip_hdmi_qp(struct drm_encoder *encoder)
 static void dw_hdmi_qp_rockchip_encoder_enable(struct drm_encoder *encoder)
 {
 	struct rockchip_hdmi_qp *hdmi = to_rockchip_hdmi_qp(encoder);
+	struct drm_crtc *crtc = encoder->crtc;
 
 	/* Unconditionally switch to TMDS as FRL is not yet supported */
 	gpiod_set_value(hdmi->enable_gpio, 1);
+
+	if (!crtc || !crtc->state)
+		return;
+
+	if (hdmi->ctrl_ops->enc_init)
+		hdmi->ctrl_ops->enc_init(hdmi, to_rockchip_crtc_state(crtc->state));
 }
 
 static int
@@ -126,16 +140,19 @@ dw_hdmi_qp_rockchip_encoder_atomic_check(struct drm_encoder *encoder,
 	union phy_configure_opts phy_cfg = {};
 	int ret;
 
-	if (hdmi->tmds_char_rate == conn_state->hdmi.tmds_char_rate)
+	if (hdmi->tmds_char_rate == conn_state->hdmi.tmds_char_rate &&
+	    s->output_bpc == conn_state->hdmi.output_bpc)
 		return 0;
 
 	phy_cfg.hdmi.tmds_char_rate = conn_state->hdmi.tmds_char_rate;
+	phy_cfg.hdmi.bpc = conn_state->hdmi.output_bpc;
 
 	ret = phy_configure(hdmi->phy, &phy_cfg);
 	if (!ret) {
 		hdmi->tmds_char_rate = conn_state->hdmi.tmds_char_rate;
 		s->output_mode = ROCKCHIP_OUT_MODE_AAAA;
 		s->output_type = DRM_MODE_CONNECTOR_HDMIA;
+		s->output_bpc = conn_state->hdmi.output_bpc;
 	} else {
 		dev_err(hdmi->dev, "Failed to configure phy: %d\n", ret);
 	}
@@ -371,15 +388,45 @@ static void dw_hdmi_qp_rk3588_io_init(struct rockchip_hdmi_qp *hdmi)
 	regmap_write(hdmi->regmap, RK3588_GRF_SOC_CON2, val);
 }
 
+static void dw_hdmi_qp_rk3576_enc_init(struct rockchip_hdmi_qp *hdmi,
+				       struct rockchip_crtc_state *state)
+{
+	u32 val;
+
+	if (state->output_bpc == 10)
+		val = FIELD_PREP_WM16(RK3576_COLOR_DEPTH_MASK, RK3576_10BPC);
+	else
+		val = FIELD_PREP_WM16(RK3576_COLOR_DEPTH_MASK, RK3576_8BPC);
+
+	regmap_write(hdmi->vo_regmap, RK3576_VO0_GRF_SOC_CON8, val);
+}
+
+static void dw_hdmi_qp_rk3588_enc_init(struct rockchip_hdmi_qp *hdmi,
+				       struct rockchip_crtc_state *state)
+{
+	u32 val;
+
+	if (state->output_bpc == 10)
+		val = FIELD_PREP_WM16(RK3588_COLOR_DEPTH_MASK, RK3588_10BPC);
+	else
+		val = FIELD_PREP_WM16(RK3588_COLOR_DEPTH_MASK, RK3588_8BPC);
+
+	regmap_write(hdmi->vo_regmap,
+		     hdmi->port_id ? RK3588_GRF_VO1_CON6 : RK3588_GRF_VO1_CON3,
+		     val);
+}
+
 static const struct rockchip_hdmi_qp_ctrl_ops rk3576_hdmi_ctrl_ops = {
 	.io_init		= dw_hdmi_qp_rk3576_io_init,
-	.irq_callback	        = dw_hdmi_qp_rk3576_irq,
+	.enc_init		= dw_hdmi_qp_rk3576_enc_init,
+	.irq_callback		= dw_hdmi_qp_rk3576_irq,
 	.hardirq_callback	= dw_hdmi_qp_rk3576_hardirq,
 };
 
 static const struct rockchip_hdmi_qp_ctrl_ops rk3588_hdmi_ctrl_ops = {
 	.io_init		= dw_hdmi_qp_rk3588_io_init,
-	.irq_callback	        = dw_hdmi_qp_rk3588_irq,
+	.enc_init		= dw_hdmi_qp_rk3588_enc_init,
+	.irq_callback		= dw_hdmi_qp_rk3588_irq,
 	.hardirq_callback	= dw_hdmi_qp_rk3588_hardirq,
 };
 
@@ -472,6 +519,7 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 
 	plat_data.phy_ops = cfg->phy_ops;
 	plat_data.phy_data = hdmi;
+	plat_data.max_bpc = 10;
 
 	encoder = &hdmi->encoder.encoder;
 	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);

-- 
2.51.0


