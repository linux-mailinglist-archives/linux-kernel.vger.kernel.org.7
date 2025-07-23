Return-Path: <linux-kernel+bounces-742260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED9EB0EF4C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B681188C136
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF17F28C01E;
	Wed, 23 Jul 2025 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KaihtoYF"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0630286D4C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265141; cv=none; b=gpWJIzjkzh82o+CMVk3O1d/a2rTrBRP9+iKULO8S3vW6C5RMF0jxoF7imKfgN02hbUVZ2CEND9lODEUih8SRnEIqdfoXUC38VAaPsebVKtSy1DxnbssgNgnpx5faoBE/CLOFXyZRZKeUUGsGifBXbyGW4ji37i8jrdsdTO7wAxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265141; c=relaxed/simple;
	bh=j87NeKlc9anpUXCbEig4homQtezEMDttOfQxDN4FPIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rO0QALfkpn1K/jwgTXadxweg6p2NGdiCncxjdK4NqWTgepEFH0/YQS/QU5+dQfX4ApYj14P2vsV6rQzt/E6IxZQW/+SvWDWsgmv/Q9aecfI8vBBNogtKncQI6xSNGoWMxUcO+SR3gB5v4/2+kWCLFOfoNqAk/Hhkr6HC0OFoTzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=KaihtoYF; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6D036F06;
	Wed, 23 Jul 2025 12:04:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1753265099;
	bh=j87NeKlc9anpUXCbEig4homQtezEMDttOfQxDN4FPIA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KaihtoYFNTD1kuuRosBUc6R31TXd0ojQKLc23zUJzBBFE3rMqDTc4vS4h3B1z96Fu
	 URszaM91zy4ahEf3hhckXKAzhqosAFyYcPQVUcBddylJzzLrmhKH5IGgqrbDxbpNEl
	 FEijYHr/+lsNFvxPkn0C2IpLVGXo7fIP5PcJ12oQ=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 23 Jul 2025 13:05:07 +0300
Subject: [PATCH v5 01/15] drm/bridge: cdns-dsi: Fix the _atomic_check()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-cdns-dsi-impro-v5-1-e61cc06074c2@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1760;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=+iBIKU6n3zpwp3bvYiJEm9dNQvFt67iy0FOXdcvLF+o=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBogLPpMF38GOVq5ARd08pP2pPYl/yZs2MBNHs30
 3/cs9dFEwyJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaICz6QAKCRD6PaqMvJYe
 9aD2D/9jHisLIjf1YghAMVIHwfNJJ2tixN1LL+yqR9U8Zdyjo0e3oiuvEUqKyQGWC9TJVVVhlSg
 2kQI7vQuqXy9njrFtMc6SD2Hq6fiiVFUW7pRxri5Nr135JAdtZul6BzqpHZQ247A4aaD+4WfG9v
 /Gq/oqFsc5ShTbpt/wG/MGYFt/Fy/Dwn/poBPxGBHUdT/VvPpdxj4GBB3Sj/ogeSWt9TlYHfhh+
 rRSDDddjwcu2zxOsUb58hPMnWnOMTVwHuwjsR3u8ub0/WEWKNEGjo19sROeIZAyGBs6GgxvQ0S1
 zM0D89/+HGabWBjKHp2rAopCpLEBLZDn+s3urx6xTOKrFNiwvnqkZSa5NxYLleh+nk2se4A4CVi
 Sa8MrIqlJFxc2dNSIzfMqRJzdUAYMUkFGLNMCtPKq8w8Wgm4FUOtUMbiW9IBbUQW8j6Tw5Q39XO
 S2lytxA4kfcfj1dlYxi1MPqkpFMso72F7J7opL0cOwA0ax351J3JO1hoNnxjFO0kzZuOgUN2l9h
 8Fn0mU5fWy0PoR1Ix+CYXd6nvqqAhqKF9cEILAbwVZrtqVlw0POzsXN5pqLjqS/I+ck3IuHCOkt
 YYXgFtjLPBmqQUepH8/6znWgHRPYBspwnxgyd4XXiSYMEmqqATRyNUvuQu9y3rSzQVvShrhJ0rM
 u2FqDSGFtd7KIXw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

From: Aradhya Bhatia <aradhya.bhatia@linux.dev>

Use the "adjusted_mode" for the dsi configuration check, as that is the
more appropriate display_mode for validation, and later bridge enable.

Also, fix the mode_valid_check parameter from false to true, as the dsi
configuration check is taking place during the check-phase, and the
crtc_* mode values are not expected to be populated yet.

Fixes: a53d987756ea ("drm/bridge: cdns-dsi: Move DSI mode check to _atomic_check()")
Signed-off-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Tested-by: Jayesh Choudhary <j-choudhary@ti.com>
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index a57ca8c3bdae..695b6246b280 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -997,10 +997,10 @@ static int cdns_dsi_bridge_atomic_check(struct drm_bridge *bridge,
 	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
 	struct cdns_dsi *dsi = input_to_dsi(input);
 	struct cdns_dsi_bridge_state *dsi_state = to_cdns_dsi_bridge_state(bridge_state);
-	const struct drm_display_mode *mode = &crtc_state->mode;
+	const struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
 	struct cdns_dsi_cfg *dsi_cfg = &dsi_state->dsi_cfg;
 
-	return cdns_dsi_check_conf(dsi, mode, dsi_cfg, false);
+	return cdns_dsi_check_conf(dsi, adjusted_mode, dsi_cfg, true);
 }
 
 static struct drm_bridge_state *

-- 
2.43.0


