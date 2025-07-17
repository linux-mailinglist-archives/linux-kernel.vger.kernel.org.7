Return-Path: <linux-kernel+bounces-736012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C71B096A0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F951AA7965
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A622C23E34C;
	Thu, 17 Jul 2025 21:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Op51+9z5"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584F5239E81;
	Thu, 17 Jul 2025 21:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752789500; cv=none; b=CMLeh+ReMVzxJurNgiEvJFR/mHFC2q1HviguRYxZhUh0VxX1orYZzz3VAqFkECk6AjJSMn4bg/TvnhX8c9A5jdjBYCq+FiZjJi9P1dwIBiQAlCeE2wdkn1LQPAVsw70eXMjQ50yjNqs4Nxsfjn+YJDZiWHHNwVDzJIUev0dVHp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752789500; c=relaxed/simple;
	bh=MpnLCBk/z6fk9C4FatnsuMYJlg8KasyNf221+sK6I1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJq+D4ZU9WVkJVhu3vURk0/CrkBO5IM+YHdSxRzum9wTu0pZ+Zv3JTy7xiTS0/4V9vZWbZZ5S35CEI1507weyaw6AAncJOZ7Wc83EmB0qiaYvaaJE3jRG+3pQhQT/GxxaAZwrJQZTxDc/q29H4ES6Tdu3RzLrEjJcHkdLe3C3U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Op51+9z5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752789490;
	bh=MpnLCBk/z6fk9C4FatnsuMYJlg8KasyNf221+sK6I1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Op51+9z5d5GqRGudh44ZP6IOiW0kiMFdowhA9L2S2s9wFqcvH/rp9sB6KPDJBm0U7
	 IuHGMUnuw9GUNABGypcY1Th7fFKzgSpvinihXQteyggcZOyJg58aIJllc7NfPmc5W7
	 P2zxmeH00tOFQkjuuQk5zf9MjCwDGciEwAriSVarS+56YpNCXjmkicpN9stVTH4t5H
	 nhWNQfvuJMPCQCgUAuqzs1ajET7BwLxxoLtgZ+BDUIlXj3DZ9QruVv97Zzq2lhSKVe
	 kV7aBFCpa5o6rtbruOZYzp8oQq1SA26UC2jL2KCBSwLPbkSeLQS86Egi5Kk82t8kb6
	 2o4XXKbaeXPpg==
Received: from trenzalore.hitronhub.home (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 68CF617E132A;
	Thu, 17 Jul 2025 23:58:07 +0200 (CEST)
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
Subject: [PATCH 1/3] drm/bridge: dw-hdmi-qp: Return 0 in audio prepare when disconnected
Date: Thu, 17 Jul 2025 17:56:18 -0400
Message-ID: <20250717215620.288651-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717215620.288651-1-detlev.casanova@collabora.com>
References: <20250717215620.288651-1-detlev.casanova@collabora.com>
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

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index 5e5f8c2f95be1..7d3d7b5084c8d 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -459,7 +459,7 @@ static int dw_hdmi_qp_audio_prepare(struct drm_connector *connector,
 	bool ref2stream = false;
 
 	if (!hdmi->tmds_char_rate)
-		return -ENODEV;
+		return 0;
 
 	if (fmt->bit_clk_provider | fmt->frame_clk_provider) {
 		dev_err(hdmi->dev, "unsupported clock settings\n");
-- 
2.50.1


