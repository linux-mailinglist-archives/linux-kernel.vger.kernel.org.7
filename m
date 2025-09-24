Return-Path: <linux-kernel+bounces-830789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953DAB9A86A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C09C1768C5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6C031282C;
	Wed, 24 Sep 2025 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VrFz0L9o"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2842E3126C7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726708; cv=none; b=ExXwDC0clU1nLjrtDn/tQgIuxBf6bSVK2o/xiuGBDhwg+y0khnaY4yuXf1We5k1gNTrnQoKv1UqbX9JovSpGm39b/YN/4ZXpm/AWvB1KxUxsBgu0dEGIcGHqEPF2U20TyckOlSnfVsyOXOFe0VmoW+GhIzBaDOs4JXWGR7Xsuyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726708; c=relaxed/simple;
	bh=hS5GfJiN5bcp84jFvqsXh/CVRXpuOo9fMkcJcGNMeZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AA7HVBQBVkgIl7TzbJjKEqzpNb70TEesRG/ESpftq4upWDePnJboPTSswSD79d1G4utZ3umm1o/OQBVGOQaZi3bX8+pibthTUncCo7QVGTdic8nGc1HJv2eFgr1P94ykn03aHIE7ugn3lu3MmJ7owbqF4aXG92xpbkdRi6Ujgq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VrFz0L9o; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 200CBC011C4;
	Wed, 24 Sep 2025 15:11:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3C47B60634;
	Wed, 24 Sep 2025 15:11:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B0B6D102F1979;
	Wed, 24 Sep 2025 17:11:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758726702; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Oyd7mxpQpGZEIT9VImfQifpqR5vXWnAg+ZLzNdsxxOI=;
	b=VrFz0L9oXdbzHIZes4H5QrDxYUlAy2Qzm+Z/NhnMLWEdU4API5rygTdulKqxWVexsjNIFc
	E3djMhjEJsCQ+QYP0ADdnZg+zmxYYLmhg3alE7ER1PyEgGDpE7mdQqIFtOHe02nHnzUyZX
	RFpiTZ7p5bfZzIGBAhJLlGO3eTAXqdAbq2QwzYQJxvC93xbgfG1ZEP8VIA3vd+2LocyrnF
	97DYBTx5E/Q0m99xVJnMZNuTYdflr4bJXuCcbSW66q4xeUmGnt0vaif94U7/ruyCesI4u0
	KdkuipB4Pd+ymjzBwovh23xiAc6QCyGUJ/z1jy20wbkTNA84w3jAiVXfurM3ww==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 24 Sep 2025 17:11:01 +0200
Subject: [PATCH] drm/bridge: refcount last_bridge in
 drm_atomic_bridge_chain_select_bus_fmts()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-b4-drm-bridge-alloc-getput-drm_atomic_bridge_chain_select_bus_fmts-v1-1-f8c2efdb783f@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAQK1GgC/yWO2wrCMBBEf6Xk2UCMUdRfkbLksq0LuZRsKkLpv
 xv18cyBmdkEYyVkcR82UfFFTCV3OB4G4Z82zygpdBZa6bO6aSOdkaEm6SqFLm2MxcsZ27K2bw6
 2lUQe/hp6BWVgjOgbuJVhSo3lFU/uopTxDrXoQ0vFid6/E49x3z/NJuQUlAAAAA==
X-Change-ID: 20250924-b4-drm-bridge-alloc-getput-drm_atomic_bridge_chain_select_bus_fmts-8e3b6004cbe2
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
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
X-Last-TLS-Session-Version: TLSv1.3

Get a reference for the last_bridge when it is obtained and release it
using a cleanup action.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_bridge.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 630b5e6594e0affad9ba48791207c7b403da5db8..53e7ece36dd940aabd1c0880f296fce7224a12ac 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -1086,12 +1086,12 @@ drm_atomic_bridge_chain_select_bus_fmts(struct drm_bridge *bridge,
 	struct drm_encoder *encoder = bridge->encoder;
 	struct drm_bridge_state *last_bridge_state;
 	unsigned int i, num_out_bus_fmts = 0;
-	struct drm_bridge *last_bridge;
 	u32 *out_bus_fmts;
 	int ret = 0;
 
-	last_bridge = list_last_entry(&encoder->bridge_chain,
-				      struct drm_bridge, chain_node);
+	struct drm_bridge *last_bridge __free(drm_bridge_put) =
+		drm_bridge_get(list_last_entry(&encoder->bridge_chain,
+					       struct drm_bridge, chain_node));
 	last_bridge_state = drm_atomic_get_new_bridge_state(crtc_state->state,
 							    last_bridge);
 

---
base-commit: 90315cd293f321ada7bbd43a59636716e102d68a
change-id: 20250924-b4-drm-bridge-alloc-getput-drm_atomic_bridge_chain_select_bus_fmts-8e3b6004cbe2

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


