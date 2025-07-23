Return-Path: <linux-kernel+bounces-742274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A588B0EF60
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5FD3A6918
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E25E2D3A83;
	Wed, 23 Jul 2025 10:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="BBgY89Dn"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647DE28C2B1
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265162; cv=none; b=qBpt/1tpGFF3IIg4DBn5dkzJK6O9KGa0MZb7yHxpJ7L6d9RCYkFFhVVp4c/9EOXx7NtymuMOnsHqO9YRbvWMEg1G233E6XJg6zzfmf+QFcryFSTBNXOfQ+p8TjOMQtn92Rln8J3t/9YM4TLkWR6VaXL5Qn//bK6eQvpOELuzYjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265162; c=relaxed/simple;
	bh=usdH24NFgjCtHwDY/tSf4Hpg487eePqFpjGZq9SVFBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s3ilYmwvFLDTg62BvZ/egqR3jkP6Octg+D+M8qvQFDLX3gKCPHg1/ne8E/sjhTdfFT5ZqOU6olovBVIEw+uiOXTX/SJdjqiVr72YBrTOKZV4225JfkIxVt8RgM0ubdhmuR2eLNBoxRqzGx1/JAqF+SJz7RhlauYRwfEeSacodFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=BBgY89Dn; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D6C0510D8;
	Wed, 23 Jul 2025 12:05:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1753265118;
	bh=usdH24NFgjCtHwDY/tSf4Hpg487eePqFpjGZq9SVFBc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BBgY89DnZUDJVl8h4UBK7Q25PEM/ZRy9OccWzEdHCJUyHbDg2L5XCplfrmYK1yYf6
	 0TUISaqZEJxrgRihqpICYZa+UIVRlkSW6xn13UJlkpaYOZ+8mZfyOVLB3YDFCkJfDK
	 Obd/saerjjyjgzPwT9CZoFSHJuuWAdytCG9jldsI=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 23 Jul 2025 13:05:21 +0300
Subject: [PATCH v5 15/15] drm/bridge: cdns-dsi: Don't fail on
 MIPI_DSI_MODE_VIDEO_BURST
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-cdns-dsi-impro-v5-15-e61cc06074c2@ideasonboard.com>
References: <20250723-cdns-dsi-impro-v5-0-e61cc06074c2@ideasonboard.com>
In-Reply-To: <20250723-cdns-dsi-impro-v5-0-e61cc06074c2@ideasonboard.com>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jayesh Choudhary <j-choudhary@ti.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, Francesco Dolcini <francesco@dolcini.it>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1295;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=usdH24NFgjCtHwDY/tSf4Hpg487eePqFpjGZq9SVFBc=;
 b=kA0DAAgB+j2qjLyWHvUByyZiAGiAs+6gb7tGkSYWDCfmRK9uQeLWaEaI2gv+uhaNpuFlMIrzX
 4kCMwQAAQgAHRYhBMQ4DD6WXv2BB5/zp/o9qoy8lh71BQJogLPuAAoJEPo9qoy8lh71yM4P/1vv
 FGeCXKo0Oa6m0RMXINa+6+MJy10b9pxBf6pdQTlRh6vx4OlKsz1Yu3nIGz95G4MD7kAVrkQhjNe
 1QSyCZyMvQ5dxWumi98V1Hp9C2EpIV759FSUJ6Y9/F0BfB4GYfIjqDdzY6buGvC0+CdTh6SplKD
 AE+jPot8YV8AYIKFy3HEjXbrUvy+7S1lnutgbZPDgHhXNcHoP6GISNBCxa2jeCAXvKnAw+u7doc
 gfSwPhyJB85h5YF6VAkBabFD6k/HLWgQuBCs3YC0yGhXRyenD0E95cleemdoYZLFu2DKa1fpryk
 AapUvbzEgtV+fGzZtanzHPvPgaihSGs0LEerm3kcdt5FFGi7ybENv30q3PfNurdUqZ+s9bCTS7e
 E+IFZ3ifRpuBQcirmQWm0DiCPp08czCHU6VArhbw4Hlp/GH9KPT3zSOIF/YI560rOv9N310uY2L
 HDdpuPFhqX5RvmTQZlR2Z8v0B/vg7M5WD6p6kqIT56+5HaWxXcMw9MxzI5KAZtVLLHaHCDVyzo0
 sQOrxoUGxn+ldXRZMw4ovPo+GlcLDY0lLTKvFgUNR+7gjND+2pEvVVbeyrQi1YlQHMhnjc28SCn
 AoNo8fNclWeHZS6fzFxApgdXL59aNOhxd/f7W6bRBr3MHFmP9OZyR01s6mfvcb4ipoHjYrw9h2O
 t2P8V
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

While the cdns-dsi does not support DSI burst mode, the burst mode is
essentially DSI event mode with more versatile clocking and timings.
Thus cdns-dsi doesn't need to fail if the DSI peripheral driver requests
MIPI_DSI_MODE_VIDEO_BURST.

In my particular use case, this allows the use of ti-sn65dsi83 driver.

Tested-by: Parth Pancholi <parth.pancholi@toradex.com>
Tested-by: Jayesh Choudhary <j-choudhary@ti.com>
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 114d883c65dc..09b289f0fcbf 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -1052,10 +1052,6 @@ static int cdns_dsi_attach(struct mipi_dsi_host *host,
 	if (output->dev)
 		return -EBUSY;
 
-	/* We do not support burst mode yet. */
-	if (dev->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
-		return -ENOTSUPP;
-
 	/*
 	 * The host <-> device link might be described using an OF-graph
 	 * representation, in this case we extract the device of_node from

-- 
2.43.0


