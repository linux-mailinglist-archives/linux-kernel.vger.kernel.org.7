Return-Path: <linux-kernel+bounces-862996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD69BF6C14
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55234543CB0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6E1338917;
	Tue, 21 Oct 2025 13:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ugR/uiZI"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079C13385BB
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053028; cv=none; b=Xx1+BhxuKFlXIPcke6UaopHyWEhKJSY2yH4SlkS3g+ZC7mvsJ4IJ2CsOkqsaMdHOeP5ATBa57RpjnxxP8TVaqqVYE6mggsQKgleOnhOiJBprJGVDjk/CFZDCSKiVwUEUvvoxEHxgeEr+YW1cOYeWDpRSoQIh1X+cn8/yZrM11EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053028; c=relaxed/simple;
	bh=DU4mBpP4n9/aq51wPIxRsXdLU74pFSj4hjJV4fvEkxo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=itlnMWgoSiPPwvy5qEKMCt+1slzJgUFf+1fym4FirNpMpPsvaWKddKSG/bobS2DY+hf+dQm/6BvBy2BbOkisr+ftQbg7RZ2xjQcayA9+FqA+eMifBSjH7dxPJ7P6kDVe7JINRzKsutI2TTEUASFMKuEDDhxWP4M4a0D7XLjz8Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ugR/uiZI; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id BFD46153F;
	Tue, 21 Oct 2025 15:21:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761052913;
	bh=DU4mBpP4n9/aq51wPIxRsXdLU74pFSj4hjJV4fvEkxo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ugR/uiZIBzg3c2XJsGN83qOMdxV4VxJN5tPnlhjMfvK/du4/s4fMKROkSAqIXk/vy
	 3c69+uTuRCEd2GIoZeTwr4M70igIvoR/XKt8kyMeiuGG+tu3RHiZkhC3wy4goXlgWD
	 uPOip7/S98hLWu/t5BHUivT+RWA2MNrSNXr8zMqw=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 21 Oct 2025 16:23:03 +0300
Subject: [PATCH 7/7] drm/bridge: tc358768: Add support for long command tx
 via video buffer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-tc358768-v1-7-d590dc6a1a0c@ideasonboard.com>
References: <20251021-tc358768-v1-0-d590dc6a1a0c@ideasonboard.com>
In-Reply-To: <20251021-tc358768-v1-0-d590dc6a1a0c@ideasonboard.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4903;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=DU4mBpP4n9/aq51wPIxRsXdLU74pFSj4hjJV4fvEkxo=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBo94lQfnIQF5JGu4C8aVEOtOY178EaeIu6l/lPR
 PmtZOdxZVCJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaPeJUAAKCRD6PaqMvJYe
 9TuoD/9XIMQFnv2Y0T51ZhnvBh+rd46g0GpbDT52js2KScp6SlSZRUfLR+082FgOTO6Tclxy3DO
 4GB7ZDBP3ycGbGKXlKlEzw0qLwO9vR48BJnM3R5mxHmDW+VUgzCnOj9I7jx+zJci2c+rzbeW1p/
 cLJu9k6asjoFMbNAnjBOG32aSpoSNJqjQwiQLsDpNFhI4ntJZ9RZcjtKs9Td4OISQunYeoJGjk2
 6pf1x16KqtCVXCu2KKwDfCg0MJDOiR+hvk7Ca70ss+Z9Gt+Ix/6xG9BcbN/s+yXrbDZYdqXNXuW
 8UqEGzd8nyM2GaRvfe8sYq0kia3GI1s4H6p7FgOYuAylWcdSH4CWZVjf1ZG2FAydUb6RP6jExd1
 J8yXvI7dQ5m0k1sScEZW0Ne9UeRCj3+eydEWyk2UUvdnh4QvDJSVKQOZOu/vvLReqUAfglv+IHn
 bIENa2DO+ZFelqpgV7UywHi3CdYviAjDRYnpnzK/v7V1IJtr2m4XJOAUd0pxAzTOE/srrokIYQt
 pgVGqak80Vj3XvFUh3Sud/Z5Dg5eFvZdQNhdrDoEtvla/OEzQCdwiz3x8PpF98xdeitP2ocQzkY
 Fh+rdH3AzC8y4BaPJQJ3qJA/lVS0F9itbTOQBxxdE9H0KOdfFhD7o5NEnKvURKPjtgLOx4eAkn7
 bPdYFrZgLqehGiQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

TC358768 has two ways to send DSI commands: 1) buffer the payload data
into registers (DSICMD_WDx), which supports up to 8 bytes of payload, 2)
buffer the payload data into the video buffer, which supports up to 1024
bytes of payload.

The driver currently supports method 1).

Add support for transmitting long DSI commands (more than 8 bytes, up to
1024 bytes) using the video buffer. This mode can only be used before
the actual video transmission is enabled, i.e. the initial configuration.

Original version from Parth Pancholi <parth.pancholi@toradex.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358768.c | 79 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 70 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index e1ed4003b3c5..e0b5a4b5abbe 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -45,6 +45,9 @@
 
 /* Debug (16-bit addressable) */
 #define TC358768_VBUFCTRL		0x00E0
+#define TC358768_VBUFCTRL_VBUF_EN	BIT(15)
+#define TC358768_VBUFCTRL_TX_EN		BIT(14)
+#define TC358768_VBUFCTRL_MASK		BIT(13)
 #define TC358768_DBG_WIDTH		0x00E2
 #define TC358768_DBG_VBLANK		0x00E4
 #define TC358768_DBG_DATA		0x00E8
@@ -537,9 +540,21 @@ static ssize_t tc358768_dsi_host_transfer(struct mipi_dsi_host *host,
 		return -ENOTSUPP;
 	}
 
+	if (msg->tx_len > 1024) {
+		dev_warn(priv->dev, "Maximum 1024 byte MIPI tx is supported\n");
+		return -EINVAL;
+	}
+
 	if (msg->tx_len > 8) {
-		dev_warn(priv->dev, "Maximum 8 byte MIPI tx is supported\n");
-		return -ENOTSUPP;
+		u32 confctl;
+
+		tc358768_read(priv, TC358768_CONFCTL, &confctl);
+
+		if (confctl & BIT(6)) {
+			dev_warn(priv->dev,
+				 "Video is currently active. Unable to transmit long command\n");
+			return -EBUSY;
+		}
 	}
 
 	ret = mipi_dsi_create_packet(&packet, msg);
@@ -552,23 +567,66 @@ static ssize_t tc358768_dsi_host_transfer(struct mipi_dsi_host *host,
 		tc358768_write(priv, TC358768_DSICMD_WC, 0);
 		tc358768_write(priv, TC358768_DSICMD_WD0,
 			       (packet.header[2] << 8) | packet.header[1]);
-	} else {
-		int i;
-
+		tc358768_dsicmd_tx(priv);
+	} else if (packet.payload_length <= 8) {
 		tc358768_write(priv, TC358768_DSICMD_TYPE,
 			       (0x40 << 8) | (packet.header[0] & 0x3f));
 		tc358768_write(priv, TC358768_DSICMD_WC, packet.payload_length);
-		for (i = 0; i < packet.payload_length; i += 2) {
+
+		for (int i = 0; i < packet.payload_length; i += 2) {
 			u16 val = packet.payload[i];
 
 			if (i + 1 < packet.payload_length)
 				val |= packet.payload[i + 1] << 8;
-
 			tc358768_write(priv, TC358768_DSICMD_WD0 + i, val);
 		}
-	}
 
-	tc358768_dsicmd_tx(priv);
+		tc358768_dsicmd_tx(priv);
+	} else {
+		unsigned long tx_sleep_us;
+		size_t len;
+
+		/* For packets over 8 bytes we need to use the video buffer */
+		tc358768_write(priv, TC358768_DATAFMT, BIT(0));	/* txdt_en */
+		tc358768_write(priv, TC358768_DSITX_DT, packet.header[0] & 0x3f);
+		tc358768_write(priv, TC358768_CMDBYTE, packet.payload_length);
+		tc358768_write(priv, TC358768_VBUFCTRL, TC358768_VBUFCTRL_VBUF_EN);
+
+		/*
+		 * Write the payload in 2-byte chunks, and pad with zeroes to
+		 * align to 4 bytes.
+		 */
+		len = ALIGN(packet.payload_length, 4);
+
+		for (int i = 0; i < len; i += 2) {
+			u16 val = 0;
+
+			if (i < packet.payload_length)
+				val |= packet.payload[i];
+			if (i + 1 < packet.payload_length)
+				val |= packet.payload[i + 1] << 8;
+
+			tc358768_write(priv, TC358768_DBG_DATA, val);
+		}
+
+		/* Start transmission */
+		tc358768_write(priv, TC358768_VBUFCTRL,
+			       TC358768_VBUFCTRL_VBUF_EN |
+			       TC358768_VBUFCTRL_TX_EN |
+			       TC358768_VBUFCTRL_MASK);
+
+		/*
+		 * The TC358768 spec says to wait until the transmission has
+		 * been finished, estimating the sleep time based on the payload
+		 * and clock rates. We use a simple safe estimate of 2us per
+		 * byte (LP mode transmission).
+		 */
+		tx_sleep_us = packet.payload_length * 2;
+		usleep_range(tx_sleep_us, tx_sleep_us * 2);
+
+		tc358768_write(priv, TC358768_VBUFCTRL, TC358768_VBUFCTRL_MASK);
+		tc358768_write(priv, TC358768_VBUFCTRL, 0); /* Stop transmission */
+	}
 
 	ret = tc358768_clear_error(priv);
 	if (ret)
@@ -752,6 +810,9 @@ static void tc358768_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 		return;
 	}
 
+	/* Release RstPtr so that the video buffer can be used for DSI commands */
+	tc358768_update_bits(priv, TC358768_PP_MISC, BIT(14), 0);
+
 	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
 	conn_state = drm_atomic_get_new_connector_state(state, connector);
 	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);

-- 
2.43.0


