Return-Path: <linux-kernel+bounces-703017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9047CAE8AC7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 18:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5057189780C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 16:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483142E11A7;
	Wed, 25 Jun 2025 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jM+SF/Tc"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6E82DF3F9
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869954; cv=none; b=VqXj442GommQrq3LcQW6hr7DH6cHwSobcttvueGU0aMlioHJ36Yk4Aj+tEwkdeUVNyJZxC0tUR5z2eJ9xPobwAc06GYqPyyJC89nQOKfxzswlHwoWvkYBOZMkIvzJd5/xAxTjx8XcYz9nA3gzCVRe+FDtgQiS5HD3H4eLGMr/HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869954; c=relaxed/simple;
	bh=y7phsgYs6TlPsFl3otsPkwWT+BEZA8ZWwUF3NhMaJqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ibXp27Za1828AoonbYOhS/DmUKrWj21rQBW8ENl+PccexQCg+yeLmCs+4Xg8oIJpBUnug6ObTC3vDDcRtbe2JpfJZAQ9QDWmu7t82U2SJNrEmIwv7Zu2zlUOdtoZPMDtbftRVYIeNc72PysEICKADAFsnDl1lVJTTzkxpJBPq3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jM+SF/Tc; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 846A944390;
	Wed, 25 Jun 2025 16:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750869951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FpAGFyy0CoYwC3ILaqHXglDkRDaZKdjlkfagsIr09OQ=;
	b=jM+SF/TcNpgpG08ytDav/3pxjqESZ19YK6ihhrOXlOacVBC0JXCyARvtYkHwIh0TI6Xeq5
	9JkA9rI3VAUybUMCvlzPXvrs+HOEQSIggPzmpdr/8Zl9/WjDxOFL8CYyxMDbrgSOInXzXt
	P687Ic6avEwPiAM5dxVS4Nt6FFU49oOrpihgGRBC9FVnPuQH9tHkvXy8Ms4MiglHCdhvec
	VABWTSPksyY1VdSKttkt2+AplqZQHFFVIbCPcQ/tIRbM43XK7pCsLN34yAnnGxROWcAMC8
	MxtX3PjytFuptMJ2QJxYZEaw8owSP8lblgnR6NEiF0cTXasZa+ubSIOCmecUHw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 25 Jun 2025 18:45:11 +0200
Subject: [PATCH 07/32] drm/bridge: nwl-dsi: remove redundant logging
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-drm-dsi-host-no-device-ptr-v1-7-e36bc258a7c5@bootlin.com>
References: <20250625-drm-dsi-host-no-device-ptr-v1-0-e36bc258a7c5@bootlin.com>
In-Reply-To: <20250625-drm-dsi-host-no-device-ptr-v1-0-e36bc258a7c5@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfedvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepieeiuedvffetgfeuudelheeutefggfejieettdetteekueeuueeukeevvedvueevnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgepieenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegludelvddrudeikedrudejkedrjeehngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopehjohhnrghssehkfihisghoohdrshgvpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhugidqshhunhigiheslhhishhtshdrlhhinhhugidruggvvhdpr
 hgtphhtthhopehmrdhsiiihphhrohifshhkihesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehrfhhoshhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopehjrghnihdrnhhikhhulhgrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-GND-Sasl: luca.ceresoli@bootlin.com

This line logged as info is too much, drivers should be mostly silent when
everything works. And now there is an equivalent dbg line logged in
mipi_dsi_attach(), valid for all DSI hosts.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/nwl-dsi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index ccce663192b35a795dad8cb479203d05b414173b..94356d02a7009a4d333f2df6c628d57c4bf66fdb 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -347,10 +347,6 @@ static int nwl_dsi_host_attach(struct mipi_dsi_host *dsi_host,
 			       struct mipi_dsi_device *device)
 {
 	struct nwl_dsi *dsi = container_of(dsi_host, struct nwl_dsi, dsi_host);
-	struct device *dev = dsi->dev;
-
-	DRM_DEV_INFO(dev, "lanes=%u, format=0x%x flags=0x%lx\n", device->lanes,
-		     device->format, device->mode_flags);
 
 	if (device->lanes > 4)
 		return -EINVAL;

-- 
2.49.0


