Return-Path: <linux-kernel+bounces-741467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFDCB0E476
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC56DAA2D7A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D3D285CB8;
	Tue, 22 Jul 2025 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Kepk5EVG"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638BA285CA4;
	Tue, 22 Jul 2025 19:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753214099; cv=none; b=sRDlmWzhLDCSWW5AcfMml9dHxxMiw2MNG9OVViHu0T1blwNTZVoN0vIdGWC595BvAbHumVgSJTGQg3J6pEzhjQTeV5pjSsSN+w36B98puFf0WsY9zZern+3oRqCxKjJuNHTdUivewMLXSnmsXgkBQ5f6+MO/5xZ+/MGlyAbrg8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753214099; c=relaxed/simple;
	bh=I7PZbKqL4kwtVAmBKVfDZdnaU2GuujBflmjQGhxXSaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLx2PiPf6kJ1Jnmni9IDD8waFz2uQzzoVmPqul1zC1sXEq772magYIGI4tG6C/VCxjA3pN3Ie1XooTPP52xQxs/QY7JxsFJpT5p0+WDrqFZ9a190xlqn1zou8eUEWuIzngO9WtxfVXoRTUZaxdFghn34Hr19yqcGD/9c72DDaDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Kepk5EVG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753214095;
	bh=I7PZbKqL4kwtVAmBKVfDZdnaU2GuujBflmjQGhxXSaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kepk5EVGVHqu4n9LHGOJrKdeNWiJUdTRWXGWtrruzydHc9+vlx8TzNmMg5gxZoJ32
	 kUDf6aOe6gNvzbppm9qDFamWSxUvo/loiqxgGP5vsBbdx46oVsOFdzwqsyzJBtvTVr
	 Uc1zLxe/D39R/uUv+O1fNbrFtkV6puB7AY9VARApdxr8RCDc1pW0zOAuJzWx46qT6l
	 D20UjQs1HFM1Jt2RPlXQXXxVVxZ953lFPBTN9O+8kGmHFqninrKBbL+NgmK6TRh/08
	 ptMph/fD3acESRN1HQwqM5rCpiR0jtLdpPdlrTDAsLE5Li24aiORyr1N3QKn53VQjf
	 m0ag2VHwh1iAg==
Received: from trenzalore.hitronhub.home (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 59E1D17E0497;
	Tue, 22 Jul 2025 21:54:52 +0200 (CEST)
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
Subject: [PATCH v2 3/3] drm/bridge: synopsys: Do not warn about audio params computation
Date: Tue, 22 Jul 2025 15:54:37 -0400
Message-ID: <20250722195437.1347865-4-detlev.casanova@collabora.com>
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

There is no need to warn about non pre-computed values, just change it to
dbg.

Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for dw-hdmi-qp")
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index 9b9d43c02e3a5..d974bcad8f94a 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -276,8 +276,7 @@ static unsigned int dw_hdmi_qp_find_n(struct dw_hdmi_qp *hdmi, unsigned long pix
 	if (n > 0)
 		return n;
 
-	dev_warn(hdmi->dev, "Rate %lu missing; compute N dynamically\n",
-		 pixel_clk);
+	dev_dbg(hdmi->dev, "Rate %lu missing; compute N dynamically\n", pixel_clk);
 
 	return dw_hdmi_qp_compute_n(hdmi, pixel_clk, sample_rate);
 }
-- 
2.50.1


