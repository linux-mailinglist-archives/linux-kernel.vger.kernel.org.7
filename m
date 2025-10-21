Return-Path: <linux-kernel+bounces-862610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E03F7BF5BF4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF544189D5E1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C4B32C33E;
	Tue, 21 Oct 2025 10:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="I/vScD0R"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473222EA17D
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041980; cv=none; b=Kq0Z6jgv91xMjv6AjMKFT0mLNRbutQ3+Dsj5/dS9VR3w7300y6RaDRNCNzxWK+yT/6A3YlBHTdfv7mBFcVV+JNZzk/ZsGYNvqliup/MQYMuOjjxE2fQckR6y/+0vU3qaaIxrkKuXt5ZpXFkH1LdRomdPu2fhFsLUReJoZjL7mOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041980; c=relaxed/simple;
	bh=2cSPcRcetu19nIiABMe7i4sAQC6sGYCknXIE9y1yPg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nN23R0zOAnA2OiruZSD09guaOFgmXHRKcZ1JnggCWe1/R+VgB9JYRmIZbXyN0fDlLhR6B+D9mPOAfLAyWfRd53F/8i9lEUkdlWR8008YY3UfQenrfBpGjMa2sHPDroFt/q3JdYoSADIKdH1r7CccItPQh7Nr50+8i6TeesvJpXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=I/vScD0R; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761041970;
	bh=2cSPcRcetu19nIiABMe7i4sAQC6sGYCknXIE9y1yPg4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I/vScD0RgKo6qV+1u18CpreOi5kY6DYeVZmAm5GSw7erjg8HIAw27q8SScgniCurG
	 Eb2LIyztM/Sum8WHvABFjs90vI2qFlVW+K3+sef2yCYxkm4+bu6yR3YHmZ5TOh3ZJp
	 he8N1EK3q+mt6j0vZCR/rb2eAF1hkG87JjYVDyeEjDkxBc8ZTEXzSm0IjzgqhfjTZI
	 pW8tQXPYkAwi5RQ2iRcmgs+4wn9L55Apai/F9IoMb8wAOoZiEHo0DBaqQ2mt2sruf5
	 r4OEMlF2D007Kfa2ANTUYDChuUCcQcZWLzIl7nnq0LvTVhIGFMFB1GL+cc7jS2GAfu
	 WsSF/97ewgWWQ==
Received: from localhost (unknown [82.79.138.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id DC98117E13A5;
	Tue, 21 Oct 2025 12:19:29 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 21 Oct 2025 13:19:15 +0300
Subject: [PATCH v3 2/5] drm/bridge: dw-hdmi-qp: Handle platform supported
 formats and color depth
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-rk3588-10bpc-v3-2-3d3eed00a6db@collabora.com>
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

Extend struct dw_hdmi_qp_plat_data to include the supported display
output formats and maximum bits per color channel.  When provided by the
platform driver, use them to setup the HDMI bridge accordingly.

Additionally, improve debug logging in dw_hdmi_qp_bridge_atomic_enable()
to also show the current HDMI output format and bpc.

Acked-by: Daniel Stone <daniels@collabora.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 11 +++++++++--
 include/drm/bridge/dw_hdmi_qp.h              |  4 ++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index 4ba7b339eff6..fe4c026280f0 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -868,8 +868,9 @@ static void dw_hdmi_qp_bridge_atomic_enable(struct drm_bridge *bridge,
 		return;
 
 	if (connector->display_info.is_hdmi) {
-		dev_dbg(hdmi->dev, "%s mode=HDMI rate=%llu\n",
-			__func__, conn_state->hdmi.tmds_char_rate);
+		dev_dbg(hdmi->dev, "%s mode=HDMI %s rate=%llu bpc=%u\n", __func__,
+			drm_hdmi_connector_get_output_format_name(conn_state->hdmi.output_format),
+			conn_state->hdmi.tmds_char_rate, conn_state->hdmi.output_bpc);
 		op_mode = 0;
 		hdmi->tmds_char_rate = conn_state->hdmi.tmds_char_rate;
 	} else {
@@ -1287,6 +1288,12 @@ struct dw_hdmi_qp *dw_hdmi_qp_bind(struct platform_device *pdev,
 	hdmi->bridge.vendor = "Synopsys";
 	hdmi->bridge.product = "DW HDMI QP TX";
 
+	if (plat_data->supported_formats)
+		hdmi->bridge.supported_formats = plat_data->supported_formats;
+
+	if (plat_data->max_bpc)
+		hdmi->bridge.max_bpc = plat_data->max_bpc;
+
 	hdmi->bridge.ddc = dw_hdmi_qp_i2c_adapter(hdmi);
 	if (IS_ERR(hdmi->bridge.ddc))
 		return ERR_CAST(hdmi->bridge.ddc);
diff --git a/include/drm/bridge/dw_hdmi_qp.h b/include/drm/bridge/dw_hdmi_qp.h
index 76ecf3130199..3f461f6b9bbf 100644
--- a/include/drm/bridge/dw_hdmi_qp.h
+++ b/include/drm/bridge/dw_hdmi_qp.h
@@ -25,6 +25,10 @@ struct dw_hdmi_qp_plat_data {
 	int main_irq;
 	int cec_irq;
 	unsigned long ref_clk_rate;
+	/* Supported output formats: bitmask of @hdmi_colorspace */
+	unsigned int supported_formats;
+	/* Maximum bits per color channel: 8, 10 or 12 */
+	unsigned int max_bpc;
 };
 
 struct dw_hdmi_qp *dw_hdmi_qp_bind(struct platform_device *pdev,

-- 
2.51.0


