Return-Path: <linux-kernel+bounces-736011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD71B0969F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4C81AA7C0C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3485D239072;
	Thu, 17 Jul 2025 21:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ppw6/cyO"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C084321ABAE;
	Thu, 17 Jul 2025 21:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752789497; cv=none; b=rCfUYn8y/qUCLz05lK4Qy2LzxXdi2iN0fRQgVvsrSUAOHwtoANpJGE27gxe3JEn58mO/LXmSCvcOkO7rsU8J76x/bu+MWgszJcNeQCg17wun/y14gNGJl1wPMPjP24SeFBmnfYcWtuBoNaeJ91AaNjw8FMp+B4G4cumGzT4XinQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752789497; c=relaxed/simple;
	bh=l+stcsHBGwL0jJ++yfnXWYCS37dvD6reGe7NiDK7mwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqCncZZK5/gciYyW/a+uCa3OEBIjXXUaEaCfAOY7xAMNGeuZnlTLT0CyEUwpUQMF/2YMwyCqDqoBruIHKxgsT6D1wNydoDmKQ9PSj+ZBa0bzAszJRO1LkvR+MgJ2mdu1HadnX6vqAGPuny6mD8UNYn898xiddX6pthVSVq0fHUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ppw6/cyO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752789494;
	bh=l+stcsHBGwL0jJ++yfnXWYCS37dvD6reGe7NiDK7mwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ppw6/cyOHwtyjfkecEuwRUHjGbPCqIQzqOY+026KiIGMrvwtnd2kXThj1UBAaSCvY
	 r6Y436f8SDkac3TusYAu5lmrNhfoA//q5+xIIfa8a4pGMhkqh73BBH3+WFyUG2S8lC
	 MJoF8S6A1nTVxcTjkTyiP8Qm2xbYliVMRY+oTe2yMhlZZcLMQjjW8sEpqR6L7nS9hu
	 ZubEYvU8trJK39KfqHgcreWS0dZEKE07dz5BfJ7IEwdlLxy7Yf+a6JjZjEmtpBtqfb
	 FqONR0fKkBe7d9cxTZzrz3TzJBYRf9L8YD8TG7OjK15A9xYlQ+rWf7MscGF7+vFROY
	 zRq7HzGLytN1A==
Received: from trenzalore.hitronhub.home (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E6C0F17E1500;
	Thu, 17 Jul 2025 23:58:10 +0200 (CEST)
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
Subject: [PATCH 2/3] ASoC: hdac_hdmi: Use dev_info on invalid ELD version
Date: Thu, 17 Jul 2025 17:56:19 -0400
Message-ID: <20250717215620.288651-3-detlev.casanova@collabora.com>
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

When disconnected, the ELD data cannot be read by the display driver, so
it just sets the data to 0.

That makes the ELD parsing code read an ELD version of 0, which is
invalid. In hdac_hdmi, that is logged with dev_err(), but should be
logged with dev_info() instead as it is done in sound/core/pcm_drm_eld.c

This avoids printing multiple messages like:

    HDMI: Unknown ELD version 0

in the kernel log when userspace tries to open the sound device.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 sound/soc/codecs/hdac_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 1139a2754ca33..4cc3b7a1062bd 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1232,7 +1232,7 @@ static int hdac_hdmi_parse_eld(struct hdac_device *hdev,
 						>> DRM_ELD_VER_SHIFT;
 
 	if (ver != ELD_VER_CEA_861D && ver != ELD_VER_PARTIAL) {
-		dev_err(&hdev->dev, "HDMI: Unknown ELD version %d\n", ver);
+		dev_info(&hdev->dev, "HDMI: Unknown ELD version %d\n", ver);
 		return -EINVAL;
 	}
 
-- 
2.50.1


