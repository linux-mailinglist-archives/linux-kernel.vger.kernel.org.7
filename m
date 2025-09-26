Return-Path: <linux-kernel+bounces-834426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FC6BA4AA4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B32431697C3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC3B242D9A;
	Fri, 26 Sep 2025 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ee90gbZT"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B5726CE37
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904510; cv=none; b=XNua1ANJFh0lA4+gyUSwWyzX+0snk6pCqfsgXQy43xBeKkZZdxcmJ6lUO0N72ZGBeW2ffIxzKf4eU60YiY95XcsTNOMlUug1CHg3Vvxw2i5MZrVMjk0lEr1Sxv2XSv5n3DMmZGWyDhzznNcg2WSZPocVqDcQb0n3kdmaiBhqFN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904510; c=relaxed/simple;
	bh=2wF+7JJF3EO22vRtbVo5pY7DnwC4RoTBohnnYGq7J2o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p89MCmBevEHWYQRyeCJIHArY4t9bgPV0EyLXP3ZYAwiUADm/gEMfKPZgeLBnT7KV9K3M2EE++YHml1hQlEbK43TELwxOvYEMZC1ERpd4lx8uJqSM6g3eZoRYaY4a+FJ6NTu0PSd9E7XO6imsGl+rMaaau8/ad75unbNDwdfoIC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ee90gbZT; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2878A1A0FF4;
	Fri, 26 Sep 2025 16:35:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DC49D606B5;
	Fri, 26 Sep 2025 16:35:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 505CB102F1829;
	Fri, 26 Sep 2025 18:34:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758904503; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=dP7cb8o2uFEBoyofslfnxXahVZmwUp4Kz0PnzXuPHDk=;
	b=Ee90gbZTPY8VrFruFBP8JzReQjP4yCTGgwmdTSnbPEtwnphM1TMkESZnek4Vm+iqd+UceN
	Q6MtWKkCC8gRBkETAKXArcBZ8OFo/wTJTvq4bIRPnTDrSbcjKkBJEyawljxr9a27PYJPli
	XJwK3upveKCpexllbgsQ6qWo4bDtaLZRE9yvnOm6Nb/JLHtdQYcdqwwAPI2dwKB6/tMweo
	6JErhkMbI0kKeb/YslsU/tRx8uHa2TBLGCSO6kXby0pR9nGZcJUijToO6pKK1HQfPagMiT
	9XUrMO0AzgSoSqPOtCVYmq31VcA4kCGb05ex6506qNc0CHr59J1fPkJ4E8NqQw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v2 0/2] drm/bridge: handle gracefully atomic updates during
 bridge removal
Date: Fri, 26 Sep 2025 18:33:26 +0200
Message-Id: <20250926-drm-bridge-atomic-vs-remove-v2-0-69f7d5ca1a92@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFbA1mgC/42NTQ6CMBCFr0Jm7ZhSQqyuvAdh0Z9BJrGMaUmjI
 dzdyglcfu+9fG+DTIkpw63ZIFHhzLJU0KcG/GyXByGHyqCV7pVRBkOK6BKH2thVInssGRNFKYR
 tuDhXl97QBNXwSjTx+7APY+WZ8yrpc5yV9pf+5y0tKrS9pmvXOWWsuTuR9cnL2UuEcd/3L8AHF
 JHIAAAA
X-Change-ID: 20250808-drm-bridge-atomic-vs-remove-1d7bb202c8ef
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
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

This is a first attempt at gracefully handling the case of atomic updates
happening concurrently to physical removal of DRM bridges.

This is part of the work towards removal of bridges from a still existing
DRM pipeline without use-after-free. The grand plan was discussed in [0].
Here's the work breakdown (➜ marks the current series):

 1. … add refcounting to DRM bridges (struct drm_bridge)
    (based on devm_drm_bridge_alloc() [0])
    A. ✔ add new alloc API and refcounting (v6.16)
    B. ✔ convert all bridge drivers to new API (v6.17)
    C. ✔ kunit tests (v6.17)
    D. ✔ add get/put to drm_bridge_add/remove() + attach/detach()
         and warn on old allocation pattern (v6.17)
    E. … add get/put on drm_bridge accessors
       1. ✔ drm_bridge_chain_get_first_bridge() + add a cleanup action
            (drm-misc-next)
       2. ✔ drm_bridge_get_prev_bridge() (drm-misc-next)
       3. ✔ drm_bridge_get_next_bridge() (drm-misc-next)
       4. ✔ drm_for_each_bridge_in_chain() (drm-misc-next)
       5. … drm_bridge_connector_init
       6. …  protect encoder bridge chain with a mutex
       7. of_drm_find_bridge
       8. drm_of_find_panel_or_bridge, *_of_get_bridge
    F. ✔ debugfs improvements
       1. ✔ add top-level 'bridges' file (v6.16)
       2. ✔ show refcount and list removed bridges (drm-misc-next)
 2. ➜ handle gracefully atomic updates during bridge removal
 3. … DSI host-device driver interaction
 4. removing the need for the "always-disconnected" connector
 5. finish the hotplug bridge work, moving code to the core and potentially
    removing the hotplug-bridge itself (this needs to be clarified as
    points 1-3 are developed)

The idea was proposed by Maxime [1] and is based on the existing
drm_dev_enter/exit() already existing for the DRM device.

This small series implements the core mechanism in drm_bridge.c and uses it
in the ti-sn65dsi83 driver. This prevents usage of device resources by
various code paths that can happen concurrently to unplug of the SN65DSI8x
bridge.

[0] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com/#t
[1] https://lore.kernel.org/all/20250106-vigorous-talented-viper-fa49d9@houat/

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v2:
- No changes to patch 1, discussion pending
- Use devres instead of a flag in patch 2
- Link to v1: https://lore.kernel.org/r/20250808-drm-bridge-atomic-vs-remove-v1-0-a52e933b08a8@bootlin.com

---
Luca Ceresoli (2):
      drm/bridge: add drm_bridge_unplug() and drm_bridge_enter/exit()
      drm/bridge: ti-sn65dsi83: protect device resources on unplug

 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 85 ++++++++++++++++++++++++++++-------
 drivers/gpu/drm/drm_bridge.c          | 58 ++++++++++++++++++++++++
 include/drm/drm_bridge.h              | 12 +++++
 3 files changed, 138 insertions(+), 17 deletions(-)
---
base-commit: 7acbe30813f04cccf7b2e8b571eb7936cfec0a87
change-id: 20250808-drm-bridge-atomic-vs-remove-1d7bb202c8ef

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


