Return-Path: <linux-kernel+bounces-784458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E265B33C2F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527303B2B67
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E8A2DAFBE;
	Mon, 25 Aug 2025 10:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WPd41UW4"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A332D9797
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756116528; cv=none; b=TJSMJrwHhh8P/RvA+bwODbfUUwZMefOUVPk8+N0epjZs0WIUGoYmE4Eg8Ljj9wVT6ZGiJAY7NILEahB0INQfFvztZD7Jcmm9FhNHGx12amhfNgVHq/CZvLilPncF+JDmO+4+Df9ole2J9NLzF0cUc2AbyvgtpBhLXhq7iE6ufGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756116528; c=relaxed/simple;
	bh=xRhWfS3GzLuu0hrFBIPELg5N4OvgD+riMqL2Fl9jd18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WUT181W7xmvM9M+h2rZWinsAF420bKa9lYiw/OJm1AeJC6DQiwY+dF48epjAwM1NLkU2DT7+tb41zQbiMmvfhoDVrWqWIGKifF6WnFSc7EtN9c2fedhjb8kjip7HgbrUG7LKUCZ0RVJgMeO+/Omnnoy2Lp60Zh0YGNzn51kyMPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WPd41UW4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756116524;
	bh=xRhWfS3GzLuu0hrFBIPELg5N4OvgD+riMqL2Fl9jd18=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WPd41UW4AqZaWVrsYRNC47yN86rXILVX5hv/GZIUP2jQ8lO5U/vjgZjUfAZ95+LqG
	 iY9ri7vWbbvbYdkk8oagRSPe9XaIaSrwvr/LowQ+SySS62L/AtW0YbyKr5ZZzSTg9c
	 7YWhv00iP3cxYNdGeja2buDeBG3rin6HJaMuzgVU89j2M5CKNFoKHNBdYfZ5Nyj0SH
	 gljoVg4jiCDKr3wwq0GLwf0nM7spK447K2W0UcTMoXTXwVBmZ3SSdJo4FbYrUOZUtA
	 I4VpeZ9iTsIb61soKmzxgbtxPvFBJ9PWvUz3hjaRsGOL1iZSTpBxrUvEaosaOftqsB
	 bNbY9maRqV9/Q==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 3B6C317E07F2;
	Mon, 25 Aug 2025 12:08:44 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Mon, 25 Aug 2025 13:08:33 +0300
Subject: [PATCH v2 2/5] drm/bridge: dw-hdmi-qp: Handle platform supported
 formats and color depth
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-rk3588-10bpc-v2-2-955622d16985@collabora.com>
References: <20250825-rk3588-10bpc-v2-0-955622d16985@collabora.com>
In-Reply-To: <20250825-rk3588-10bpc-v2-0-955622d16985@collabora.com>
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
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Extend struct dw_hdmi_qp_plat_data to include the supported display
output formats and maximum bits per color channel.  When provided by the
platform driver, use them to setup the HDMI bridge accordingly.

Additionally, improve debug logging in dw_hdmi_qp_bridge_atomic_enable()
to also show the current HDMI output format and bpc.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 11 +++++++++--
 include/drm/bridge/dw_hdmi_qp.h              |  4 ++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index 42a90e0383061dad6c8416af21b27db7a3ba6d7d..8ff8ea8e0714ed6d6fa4b7865c86d04c32565d90 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -869,8 +869,9 @@ static void dw_hdmi_qp_bridge_atomic_enable(struct drm_bridge *bridge,
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
@@ -1299,6 +1300,12 @@ struct dw_hdmi_qp *dw_hdmi_qp_bind(struct platform_device *pdev,
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
index 76ecf31301997718604a05f70ce9eab8695e26b5..3f461f6b9bbfbf67934bf642452d3c6f9253c4f9 100644
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
2.50.1


