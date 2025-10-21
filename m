Return-Path: <linux-kernel+bounces-863699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10442BF8DD9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B7EFD356BE1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBE728724D;
	Tue, 21 Oct 2025 21:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Vv/CUjIe"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DAC280A58
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080488; cv=none; b=g0aCp8+Kqy2fA9iwKWbKN5ofjf/BYoo63/NisYczz32AOz6LOYuJ7tbq8RYavl2xNS0iAYKyGuyRrAdupUkfbi1ewV9+r0yCFKfp5T+AudHQNQc+NrwplX1RmFwLwhTsjAXJzg8XaAdVJxzi7XJAGvY7Cab0K3uzkah58aZ7dlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080488; c=relaxed/simple;
	bh=0DXON5mT7BeW24BxRlTCJMjtuhADOpj9r16JxuuL5rM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=goFSPes1fkr+tr8IEJKAwG39U4Mh6dAf/28HBxHbnu3jkHhzeRRMbZeR+uDPABea1d0+fPLLKtHwDtMirK3gK5gOdFZXN7s7nPKUlubvn68R5TTyK38qrvezCbu0fkvktWk3TlslXWHj8E4j3ulb/moDkGtSg1fCGeomKWWQbTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Vv/CUjIe; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3C3991A15AB;
	Tue, 21 Oct 2025 21:01:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CA3D860680;
	Tue, 21 Oct 2025 21:01:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0E508102F2415;
	Tue, 21 Oct 2025 23:01:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761080483; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CO/6DLIe3Dzo5sLr1BlifC8tEkQKj1yPrLzvRzKt3Ik=;
	b=Vv/CUjIe1vJrZztQ95kwHBlz/iBfIC69LTOrXDSrszA4Rif5S53zDvIZ/saIr2HZvMw40E
	fdmBI1IKkZMxV8p/eV0XZtrEbLFDZO1/QU1DT9ZAobZCjC5TVjR/5SBPgVEE2Hgc0vcLNW
	615SxHdNqBWdL62X7HgSU/4bOIQDV2R+ZdSGOFwwXvrxrvtWAqhrOgGaE5nq076yK8p5dL
	lMRXF1VENXqoLSiTBQMnAmUfcONWTf3jb+BhbhwXfC06xi7Wscj1OOgz6r3SrNwVTBOTZX
	BVARI0fA1sHlrjWIuf5399Jz6qhA59opqjnl6+BKROS0H3q7RBGj8twzUqjWjA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 21 Oct 2025 23:00:46 +0200
Subject: [PATCH v2 3/5] drm/bridge: document that adding a bridge is
 mandatory before attach
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-b4-drm-bridge-alloc-add-before-attach-v2-3-c17cc1bbff72@bootlin.com>
References: <20251021-b4-drm-bridge-alloc-add-before-attach-v2-0-c17cc1bbff72@bootlin.com>
In-Reply-To: <20251021-b4-drm-bridge-alloc-add-before-attach-v2-0-c17cc1bbff72@bootlin.com>
To: Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

At the moment it's not documented that you need to add a bridge before
attaching it. Clarify that.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Link: https://lore.kernel.org/all/20250709-sophisticated-loon-of-rain-6ccdd8@houat/
Reviewed-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_bridge.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 53e7ece36dd940aabd1c0880f296fce7224a12ac..1246a52f8767b52c5f10139aa897824b3c2f28da 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -422,6 +422,9 @@ static bool drm_bridge_is_atomic(struct drm_bridge *bridge)
  * If non-NULL the previous bridge must be already attached by a call to this
  * function.
  *
+ * The bridge to be attached must have been previously added by
+ * drm_bridge_add().
+ *
  * Note that bridges attached to encoders are auto-detached during encoder
  * cleanup in drm_encoder_cleanup(), so drm_bridge_attach() should generally
  * *not* be balanced with a drm_bridge_detach() in driver code.

-- 
2.51.0


