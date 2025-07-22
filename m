Return-Path: <linux-kernel+bounces-741465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AE6B0E474
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40D907A3CAF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90862857D2;
	Tue, 22 Jul 2025 19:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="p7kOQl2S"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420902853E7;
	Tue, 22 Jul 2025 19:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753214092; cv=none; b=U+ebGp87RNibi72TZpLl3JhfPERrdAvkI7ixWCdTShoDvr8CWipLhZZNlg6k4HRJ06Z/6DNADdl5bqWlrX2qOC3tAPJ1ZAFSg59x8miPOqyZIcjcJCRyMRZnhXjedftxySu0uUUYvF2sMYadKIiH96ZsPl5txR7CuXrlZSUCJiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753214092; c=relaxed/simple;
	bh=mtENC6BN0sB5OMWMRTcHCpxBXeo+DFs033MQq3LZxKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qiOnT2tINJMapAOMR3U/3etNbL6b4gPcIetfHyG7WngmFHgvtiEgb1Ds8DW/FMHL/IYfcF60B//D+Ieuu2uy8bGlf6uy434wg7EY26IOfhA0Il3VrsMNh+fsoTIXy6igv3tnINLzJmDxazky65/pwbwHBT/szu3cPJo0Odt6E5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=p7kOQl2S; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753214088;
	bh=mtENC6BN0sB5OMWMRTcHCpxBXeo+DFs033MQq3LZxKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p7kOQl2S8BS6xzi9H9TX87Sesl7tBnlqiFPjyGB6+bKJhIsRDXr70YtrgaZEYYvqm
	 kIsUaeSfJ6rpEu/qc66dpipZjKzQoQlZVlF94uZ+N098LvDhN99qC+aJYZgSjSN7nr
	 rnOAT3okBISM8foU/FNtnPDgwV36RhHsJuX0zl0Pohn5X0SRn9vNrzN0yCn6Q04vwu
	 +lCKstrZi6iPwnPQfRrPWZcHXFJzo1nnHvWiXlfcYpZS75x2hAun6aamTNQ/uFkwN7
	 o3+L3Okt5aWBwXtZ36H+pit2EYf7c9h6DbSk2qmCxjRvhHfDkVGGNavvmluG7J7Ato
	 gw9tZq0DmXzGw==
Received: from trenzalore.hitronhub.home (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EA7F617E04D6;
	Tue, 22 Jul 2025 21:54:44 +0200 (CEST)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Douglas Anderson <dianders@chromium.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sugar Zhang <sugar.zhang@rock-chips.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Raag Jadav <raag.jadav@intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-sound@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v2 1/3] drm/bridge: dw-hdmi-qp: Return 0 in audio prepare when disconnected
Date: Tue, 22 Jul 2025 15:54:35 -0400
Message-ID: <20250722195437.1347865-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722195437.1347865-1-detlev.casanova@collabora.com>
References: <20250722195437.1347865-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To configure audio registers, the clock of the video port in use must be
enabled.
As those clocks are managed by the VOP driver, they can't be enabled here
to write the registers even when the HDMI cable is disconnected.

Furthermore, the registers values are computed from the TMDS char rate,
which is not available when disconnected.

Returning -ENODEV seemed reasonable at first, but ASoC will log an error
multiple times if dw_hdmi_qp_audio_prepare() return an error.
Userspace might also retry multiple times, filling the kernel log with:

hdmi-audio-codec hdmi-audio-codec.0.auto: ASoC error (-19): at snd_soc_dai_prepare() on i2s-hifi

This has become even worse with the support of the second HDMI TX port.

Activating the clocks to write fake data (fake because the TMDS char
rate is unavailable) would require API changes to communicate between
VOP and HDMI, which doesn't really make sense.

Using a cached regmap to be dumped when a cable is connected won't work
because writing order is important and some data needs to be retrieved
from registers to write others.

Returning 0 to silently fail sounds like the best and simplest solution.

Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for dw-hdmi-qp")
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index 5e5f8c2f95be1..9b9d43c02e3a5 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -458,8 +458,16 @@ static int dw_hdmi_qp_audio_prepare(struct drm_connector *connector,
 	struct dw_hdmi_qp *hdmi = dw_hdmi_qp_from_bridge(bridge);
 	bool ref2stream = false;
 
+	/*
+	 * Silently return if tmds_char_rate is not set.
+	 *
+	 * Writing audio registers requires that the clock of the Video Port currently in
+	 * use by the VOP (dclk_vp<id>) is enabled.
+	 * That clock is guaranteed to be enabled when hdmi->tmds_char_rate is set, so we
+	 * only configure audio when it is set.
+	 */
 	if (!hdmi->tmds_char_rate)
-		return -ENODEV;
+		return 0;
 
 	if (fmt->bit_clk_provider | fmt->frame_clk_provider) {
 		dev_err(hdmi->dev, "unsupported clock settings\n");
-- 
2.50.1


