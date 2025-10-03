Return-Path: <linux-kernel+bounces-841192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B8DBB6756
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 12:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DFFAA345082
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 10:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E34C2EAB64;
	Fri,  3 Oct 2025 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JWD16IXL"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8018327470
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759487983; cv=none; b=sALE+3qoxNtJfizyXA10dZlkR5uf5g1gttOhv722gJbMU6neDQij/x4SqkR622AsKJiUbra7f+SdXIRRYMV/OfE8gBjTGWt5LyKEiMGanXZ62JMJE3TbJPhs3QJzPUluzlufzvsoWTeNLv+T+UXeWISj4qG1/uqcTynAhl8zAvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759487983; c=relaxed/simple;
	bh=Y+3IKH/WFGhJzDLX0GpuHXdYnK3H2S3R9yn5XG3EHvY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Iakl+P/nt7PYE7LPRecYgwii8UN2FV9QtDwT9bq+mpk4f5DBQh5yv0QGKD368BmiZ00pm2VsSnHzoHw1XG77QpXIrlcJ9BDFOyGhGy1aGVBxXRA/X6e0uY8/98Ls8xEWsqpNcFoixByU02t3hV0WzZZt34+5OrwT84zbwuyojoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JWD16IXL; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D122A1A10C5;
	Fri,  3 Oct 2025 10:39:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9828260683;
	Fri,  3 Oct 2025 10:39:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 16160102F1C34;
	Fri,  3 Oct 2025 12:39:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759487978; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=g0ifPB/eYa8meuD70ncVR+Pbu9URi3BL9N1ASpxRhvg=;
	b=JWD16IXLpAdEGlchg51Agy/wqoZ+QR2DO13PjzoF/Z0w11AHS5sUxb+PW611IozUYe1ZP6
	Ovvlt2aWd81WazV2hsIyZioVwwdgqcsY9vVqROzhPGi4VjbahGjPESgmx/Gbm8LkD5II2a
	haF4CdnkL1fdxE4YGciFiN7pzqsemuQVEnpONlQDtPkPfflTCCfZHkImCkoIYmQdPcunzL
	ozrmPZuHG9CaOeuSc/Ogwxu6gkmzFBh9zsNdfufY3dGsP48VFrqcEXfJ+hglBCsY5Oai7I
	saUFBRlzCN41hp7js+ACXtn6nvzemkiiDyHg3mCazPaQe95Xj2vbi/K+xTLE+Q==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v2 0/7] drm/bridge: protect encoder bridge chain with a
 mutex
Date: Fri, 03 Oct 2025 12:39:22 +0200
Message-Id: <20251003-drm-bridge-alloc-encoder-chain-mutex-v2-0-78bf61580a06@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANqn32gC/42NwQ6CMBBEf4X07JpSbEFP/ofhQNtVNoHWbJFgC
 P9uJfHu8c1M5q0iIRMmcSlWwThTohgyqEMhXN+FBwL5zEJJpeVZafA8gmXyuemGITrA4KJHhjy
 nAONrwgVs3XijZKMRtchXT8Y7Lbvm1mbuKU2R37t1Lr/pT2D+E8wlSFCVNcqd6kqb7mpjnAYKR
 xdH0W7b9gH7mWjA2gAAAA==
X-Change-ID: 20250925-drm-bridge-alloc-encoder-chain-mutex-b78d62085ee5
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

This series ensures that the bridge chain of the encoder will not be
modified while some other concurrent code flows are iterating over it.

This is part of the work towards removal of bridges from a still existing
DRM pipeline without use-after-free. The grand plan was discussed in [1].
Here's the work breakdown (➜ marks the current series):

 1. ➜ add refcounting to DRM bridges (struct drm_bridge)
    (based on devm_drm_bridge_alloc() [0])
    A. ✔ add new alloc API and refcounting (v6.16)
    B. ✔ convert all bridge drivers to new API (v6.17)
    C. ✔ kunit tests (v6.17)
    D. ✔ add get/put to drm_bridge_add/remove() + attach/detach()
         and warn on old allocation pattern (v6.17)
    E. ➜ add get/put on drm_bridge accessors
       1. ✔ drm_bridge_chain_get_first_bridge() + add a cleanup action
            (drm-misc-next)
       2. ✔ drm_bridge_get_prev_bridge() (drm-misc-next)
       3. ✔ drm_bridge_get_next_bridge() (drm-misc-next)
       4. ✔ drm_for_each_bridge_in_chain() (drm-misc-next)
       5. ✔ drm_bridge_connector_init (drm-misc-next)
       6. ➜ protect encoder bridge chain with a mutex
       7. of_drm_find_bridge
       8. drm_of_find_panel_or_bridge, *_of_get_bridge
       9. … enforce drm_bridge_add before drm_bridge_attach
    F. ✔ debugfs improvements
       1. ✔ add top-level 'bridges' file (v6.16)
       2. ✔ show refcount and list removed bridges (drm-misc-next)
 2. … handle gracefully atomic updates during bridge removal
 3. … DSI host-device driver interaction
 4. ✔ removing the need for the "always-disconnected" connector
 5. finish the hotplug bridge work, moving code to the core and potentially
    removing the hotplug-bridge itself (this needs to be clarified as
    points 1-3 are developed)

The per-encoder bridge chain is currently assumed to be static once it is
fully initialized. Work is in progress to add hot-pluggable bridges,
breaking that assumption.

With hotplug and especially hot-unplug, bridges will be added and removed
without notice, and thus be added/removed to/from the encoder chain in
drm_bridge_attach/detach(), concurrently to the code iterating on the
chain. This can result in disruption of the code iterating over the
chain. The rationale is explained by a detailed example in patch 2.

Avoid bugs by introducing a mutex to make list insertion, removal and
iterations mutually exclusive.

[1] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com/#t

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v2:
- Improve commit messages and add documentation as per v1 review
- Patch 4: fixed infinite loop when encoder->bridge_chain is empty
- Link to v1: https://lore.kernel.org/r/20250926-drm-bridge-alloc-encoder-chain-mutex-v1-0-23b62c47356a@bootlin.com

---
Luca Ceresoli (7):
      drm/encoder: add mutex to protect the bridge chain
      drm/encoder: drm_encoder_cleanup: take chain mutex while tearing down
      drm/bridge: lock the encoder bridge chain mutex during insertion
      drm/bridge: lock the encoder chain in scoped for_each loops
      drm/bridge: prevent encoder chain changes while iterating with list_for_each_entry_from()
      drm/bridge: prevent encoder chain changes while iterating with list_for_each_entry_reverse()
      drm/bridge: prevent encoder chain changes in pre_enable/post_disable

 drivers/gpu/drm/drm_bridge.c  | 51 ++++++++++++++++++-----------------
 drivers/gpu/drm/drm_encoder.c |  4 +++
 include/drm/drm_bridge.h      | 62 +++++++++++++++++++++++--------------------
 include/drm/drm_encoder.h     | 39 +++++++++++++++++++++++++++
 4 files changed, 103 insertions(+), 53 deletions(-)
---
base-commit: 0f2efbe6d8305b91c9b2c92ebaf8c24a614bc305
change-id: 20250925-drm-bridge-alloc-encoder-chain-mutex-b78d62085ee5

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


