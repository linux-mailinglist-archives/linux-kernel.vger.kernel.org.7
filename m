Return-Path: <linux-kernel+bounces-745958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 713C9B120F2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1722E1CE662F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E35C2EE61F;
	Fri, 25 Jul 2025 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bmVD4eIs"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62461D5165
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753457296; cv=none; b=WQ0xbOSfSMGCmj+HXqewm2w3OysdfkDqH8chnUVJBNq4AbjShjqvX5fXviSZnhOIHNROww1/BYyYN8K+0VEWsniu0h1MMmEnPkQsiJnGTfh9FGbPrzSpqqozrwwbyYHmwOy01LtgGcYO4EGAzz+JMrIGOd6xVRQZp6SBJRl5K8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753457296; c=relaxed/simple;
	bh=J7X4J+cLLg7qpiL1tXaxLb6R/X2I4vC2GP49KLLiIMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Eby27IYkTiJ1qyDkdeDcrwlhNuV9Xe9lBPkazGm+b06qzCQbuXcesLc3VSfk45K3aR+DsNhLAc1a1T7cdy9sb8kzO0gF7lhoI1YkvbMY0HjVbYBzSjwndOj0tTaq872VfTA/5zH9aAtHfVaRzazhq0ued7SFpKTJ+S6Wms9UIzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bmVD4eIs; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 902F8441D6;
	Fri, 25 Jul 2025 15:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753457292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W4q+49YQT2l30vtbVxxXxy6RyV8DhHrfMHle8faAKM0=;
	b=bmVD4eIsVTojpcJ4GSdQTGRHFum/Lfzq8sRACxVLdz3gBXiL1UTwlEeUZ1F3bQJt1jCjfq
	sDKfrwvkYKHklvrh17oUIkvwmNQRSCUZyCThMC0YRS4lZZjM9EnPb1904ywVO4C2BAlQJD
	uqXeRzmRo2WiXU2dFrmqxcWVWAtVzqCmfJZ/Mp8vUmpOxewZzgxuDOKgD/wKcZr/wzglA+
	ZHb1iJ8ycy3J2MCu175uSy0hdggcaYAcUpmV5AVCH+2TvLG0NyBFubS6jkkjmbW1aaUGn0
	rS2rcqxDNCEosxu0YEqaiA/jDHbce+vTSZXTCcT7+ctsVTKD6frgNEJRySXvxQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 25 Jul 2025 17:28:03 +0200
Subject: [PATCH] samsung-dsim: move drm_bridge_add() call to probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-drm-bridge-samsung-dsim-add-in-probe-v1-1-b23d29c23fbd@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAIKig2gC/x2NQQqEMAwAvyI5G+h2reJ+RTxUEzWHVknYRRD/v
 sXjMDBzgbEKG3yqC5R/YrLnAq+6gnmLeWUUKgze+eA6H5A04aRCxVhM9s0rkknCSISS8dB9Yuz
 m0PTv1sWld1BSh/Ii57MZxvv+A8pKoUx2AAAA
X-Change-ID: 20250725-drm-bridge-samsung-dsim-add-in-probe-7c549360af90
To: Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekfeeklecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepleeuheehfefgkefhgfekgeefueektdefkeefveetudfgjeegteefkeduvedugeegnecuffhomhgrihhnpehlphgtrdgvvhgvnhhtshdpkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegludelvddrudeikedrudejkedruddukegnpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudelpdhrtghpthhtohepjfhuihdrrfhusehgvghhvggrlhhthhgtrghrvgdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepjhhonhgrs
 heskhifihgsohhordhsvgdprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrghgrghnsegrmhgrrhhulhgrshholhhuthhiohhnshdrtghomhdprhgtphhtthhopehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggvpdhrtghpthhtohepjhgvrhhnvghjrdhskhhrrggsvggtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomh
X-GND-Sasl: luca.ceresoli@bootlin.com

This bridge driver calls drm_bridge_add() in the DSI host .attach callback
instead of in the probe function. This looks strange, even though
apparently not a problem for currently supported use cases.

However it is a problem for supporting hotplug of DRM bridges, which is in
the works [0][1][2]. The problematic case is when this DSI host is always
present while its DSI device is hot-pluggable. In such case with the
current code the DRM card will not be populated until after the DSI device
attaches to the host, and which could happen a very long time after
booting, or even not happen at all.

Supporting hotplug in the latest public draft is based on an ugly
workaround in the hotplug-bridge driver code. This is visible in the
hotplug_bridge_dsi_attach implementation and documentation in [3] (but
keeping in mind that workaround is complicated as it is also circumventing
another problem: updating the DSI host format when the DSI device gets
connected).

As a preliminary step to supporting hotplug in a proper way, and also make
this driver cleaner, move drm_bridge_add() at probe time, so that the
bridge is available during boot.

However simply moving drm_bridge_add() prevents populating the whole card
when the hot-pluggable addon is not present at boot, for another
reason. The reason is:

 * now the encoder driver finds this bridge instead of getting
   -EPROBE_DEFER as before
 * but it cannot attach it because the bridge attach function in turn tries
   to attach to the following bridge, which has not yet been hot-plugged

This needs to be fixed in the bridge attach function by simply returning
-EPROBE_DEFER ifs the following bridge (i.e. the DSI device) is not yet
present.

[0] https://lpc.events/event/18/contributions/1750/
[1] https://lore.kernel.org/lkml/20240924174254.711c7138@booty/
[2] https://lore.kernel.org/lkml/20250723-drm-bridge-alloc-getput-for_each_bridge-v1-0-be8f4ae006e9@bootlin.com/
[3] https://lore.kernel.org/lkml/20240917-hotplug-drm-bridge-v4-4-bc4dfee61be6@bootlin.com/

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index c4997795db18280903570646b0a5b2c03b666307..173f730edb3707823b0a85460968a11b8206b508 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1633,6 +1633,9 @@ static int samsung_dsim_attach(struct drm_bridge *bridge,
 {
 	struct samsung_dsim *dsi = bridge_to_dsi(bridge);
 
+	if (!dsi->out_bridge)
+		return -EPROBE_DEFER;
+
 	return drm_bridge_attach(encoder, dsi->out_bridge, bridge,
 				 flags);
 }
@@ -1749,8 +1752,6 @@ static int samsung_dsim_host_attach(struct mipi_dsi_host *host,
 		     mipi_dsi_pixel_format_to_bpp(device->format),
 		     device->mode_flags);
 
-	drm_bridge_add(&dsi->bridge);
-
 	/*
 	 * This is a temporary solution and should be made by more generic way.
 	 *
@@ -2011,6 +2012,8 @@ int samsung_dsim_probe(struct platform_device *pdev)
 			goto err_disable_runtime;
 	}
 
+	drm_bridge_add(&dsi->bridge);
+
 	return 0;
 
 err_disable_runtime:

---
base-commit: e48123c607a0db8b9ad02f83c8c3d39918dbda06
change-id: 20250725-drm-bridge-samsung-dsim-add-in-probe-7c549360af90

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


