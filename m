Return-Path: <linux-kernel+bounces-873490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4ECC140D5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 967B2563247
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B11304963;
	Tue, 28 Oct 2025 10:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pWDCE+fn"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D322D4813
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646612; cv=none; b=StphUVpMbLUhWukn9qmtWb1eJEk728Dsc+KmXEPppBtauNRge8RL7TSHTQtiKLjr97KcpmT8/DVOIjHw7IyV6am8Q91HTXzFVdbYwK20OFNxR7lwVum70hcsZiaPId70nJfXDBmf51KzbaSpjaOFLImKOcVhXBjNSvZ8orr7Yg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646612; c=relaxed/simple;
	bh=HNNcUjBlE2ezDrpCkSt1TAM29s3v4NT9WLUuWNfS/KY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S+f+Ih1X0dPdicwolHxhgtY3ultR05V9fC2pPR5IwN9YVIPydSA5CuviW7/Bf/ZcC3SRLALY2s3RHwdMPzFUkCoWMkrBGyGH7cEfJCNGMBSehudxNgAOpNWb/PK8gz02DQDmOfyMCYyuv5Oe2+1Wp13SAQBZ8AUYpxJVpqH10po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pWDCE+fn; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 64568C0BE9C;
	Tue, 28 Oct 2025 10:16:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A16BC606AB;
	Tue, 28 Oct 2025 10:16:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 126151179B191;
	Tue, 28 Oct 2025 11:16:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761646606; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vdYNl+jUov2A+6UN1VU5gxICmAEu5JVGl0RzN3EysYI=;
	b=pWDCE+fnq8i9VUHvOlzUK8F0XX42hsC0TBdhfPAc52Yq0huRzaEVKhDRn849CHnXrxmYl6
	nyow7QVbg+7gID4HfgcCAZChnRystZb9Jyn9GE3xyOgLzH4kDHKnnMsImZXTOAeSx97US+
	VE+L3tB48aVLcFz96hOWoreKCYkN05t8k0WG420X8vHVKWSOBHJnwgwc0zWpOZ9cerIcZz
	IpbdZ5Skw7bSZftXLEoZm3JWMTf+SHoCnk2SBmPyrv8hUAc1Hx5N+pqhi5ceWJqwlYkBmB
	aGDwdiybj15TolwWmRF/3myX5YPvOtInsnUnCkV9hzCRK3Bd7UEJaCBv3aibJw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 28 Oct 2025 11:15:46 +0100
Subject: [PATCH v3 5/6] drm/bridge: add warning for bridges using neither
 devm_drm_bridge_alloc() nor drm_bridge_add()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-b4-drm-bridge-alloc-add-before-attach-v3-5-bb8611acbbfb@bootlin.com>
References: <20251028-b4-drm-bridge-alloc-add-before-attach-v3-0-bb8611acbbfb@bootlin.com>
In-Reply-To: <20251028-b4-drm-bridge-alloc-add-before-attach-v3-0-bb8611acbbfb@bootlin.com>
To: Alain Volmat <alain.volmat@foss.st.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Andy Yan <andy.yan@rock-chips.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

The correct sequence for bridge initialization is:

 1. devm_drm_bridge_alloc()
 2. drm_bridge_add()
 3. drm_bridge_attach()

For bridges missing either 1 or 2 there are warnings in place already,
presenting an explanatory error message.

Bridges missing both 1 and 2 would still face a poorly understandable
message, as reported in a recent regression report [0]:

  WARNING: [...] at [...]/lib/refcount.c:25 drm_bridge_attach+0x2c/0x1dc
  ...
  Call trace:
  ...
   drm_bridge_attach
  ...

Add a new warning to ensure an understandable message is logged in such
cases. Use the same message and warning message already in place in
drm_bridge_add().

[0] https://lore.kernel.org/all/hlf4wdopapxnh4rekl5s3kvoi6egaga3lrjfbx6r223ar3txri@3ik53xw5idyh/

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

This patch was added in v2 after having received regression report [0].
---
 drivers/gpu/drm/drm_bridge.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 6dba601a056bb3cff8b8dd5b1ec46299235b2d85..8f355df883d8ac8de9d361ec302f4ccbf3bca0d6 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -441,6 +441,9 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 	if (!encoder || !bridge)
 		return -EINVAL;
 
+	if (!bridge->container)
+		DRM_WARN("DRM bridge corrupted or not allocated by devm_drm_bridge_alloc()\n");
+
 	if (list_empty(&bridge->list))
 		DRM_WARN("Missing drm_bridge_add() before attach\n");
 

-- 
2.51.0


