Return-Path: <linux-kernel+bounces-895355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA47C4D988
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 972224F9C58
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CA2357A5C;
	Tue, 11 Nov 2025 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mKGxSXXa"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8569339A8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862500; cv=none; b=cnmh58CwiGDJcUSl0YaPN61asIK9AT+zCrJK5fzJ2G66Dj9+o2kRsBU9+UW4KzRxY3AOSJLXNRgYQES5qxroQOX3WXRO9B5Vz/RIhFY5onokZddVyaSVzZpQmoM0y3j2eTPpnXN8DraJK7oS5LFYLdNdN8UHCccbWiCOaGEQDlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862500; c=relaxed/simple;
	bh=66UFiPeIx1CiukSkq45go2Bjzi4qq8ngKbrxkzDQykc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Qrg7AdFNcfIVx1D5oryoqez3HnPbB/ZNkLQQPiFdF4ShdV9fxuqYpCXILOpv6KB/4S7mfVRca/Rl68CzMshco9/6gMO72dDMlzzQ5DVewzuMLjLzXEKt5RmyZRvBIYLympQyZFMiXzg/BLWNILF+jhMRHEfWylVynfOR5PA12YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mKGxSXXa; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C7DC31A19D6;
	Tue, 11 Nov 2025 12:01:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 76951606FB;
	Tue, 11 Nov 2025 12:01:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D4E210371757;
	Tue, 11 Nov 2025 13:01:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762862487; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=XBfKYR3s+m4uVx66jqSCMnQk1nUYcz8gNJ4Bv4c9bQg=;
	b=mKGxSXXaaIsPQpGSWu7v1BAWleJGQZh7V99ViBVdahSv1LUom/NsV1e9OMBj8MrNMo5BsZ
	xOf7mEIWqdpH2bafshnrHPlaG4FGV3G6U93qGwLjp2xlwmgym59ZtMDSNUTKnAmyYX61n7
	y+kLvG6HiIQPbVkMB5heNdqo6qInUMbat5zyuW4sVDlwzM8G4aK7amOlGj1DfjO2kOdndo
	2QQ/fZlyfu+chIDn+wolnEZGwV0ezrpSyu1xMMX4n9N5hnRYKofkbDdxhFu/UyqgW6P57X
	caJOZzqgn0wv4hcrtMMLIAIGS4c4PQ0UydQ7DZoe1vYQsM6ixCMqkGud7WfLVA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v4 0/7] drm/bridge: protect encoder bridge chain with a
 mutex
Date: Tue, 11 Nov 2025 13:01:20 +0100
Message-Id: <20251111-drm-bridge-alloc-encoder-chain-mutex-v4-0-12b13eb8c0f8@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJAlE2kC/43NwY7CIBDG8VcxnB0zhULbPfkexkOBqU7SwobWR
 mP67qKJxs1eevxg8vvfxUiJaRQ/m7tINPPIMeRRbjfCndtwImCft5AoNTZSg08D2MQ+/7R9Hx1
 QcNFTgnzOAYbLRFewVe2NxFoTaZGp30QdX1+ZwzHvM49TTLdXdS6er++AWReYC0CQyhrpykpp0
 +5tjFPPYefiIJ6JWX7YAlGtZGVmq9p2ptA1tmj+s+qbbVayKrOuQfJVWVJH7i+7LMsD8Ue4V4g
 BAAA=
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

This is part of the work to support hotplug of DRM bridges. The grand plan
was discussed in [1].

Here's the work breakdown (➜ marks the current series):

 1. ➜ add refcounting to DRM bridges (struct drm_bridge)
    (based on devm_drm_bridge_alloc() [0])
    A. ✔ add new alloc API and refcounting (v6.16)
    B. ✔ convert all bridge drivers to new API (v6.17)
    C. ✔ kunit tests (v6.17)
    D. ✔ add get/put to drm_bridge_add/remove() + attach/detach()
         and warn on old allocation pattern (v6.17)
    E. ➜ add get/put on drm_bridge accessors
       1. ✔ drm_bridge_chain_get_first_bridge(), add cleanup action (v6.18)
       2. ✔ drm_bridge_get_prev_bridge() (v6.18)
       3. ✔ drm_bridge_get_next_bridge() (v6.19)
       4. ✔ drm_for_each_bridge_in_chain() (v6.19)
       5. ✔ drm_bridge_connector_init (v6.19)
       6. ➜ protect encoder bridge chain with a mutex
       7. of_drm_find_bridge
       8. drm_of_find_panel_or_bridge, *_of_get_bridge
       9. ✔ enforce drm_bridge_add before drm_bridge_attach (v6.19)
    F. ✔ debugfs improvements
       1. ✔ add top-level 'bridges' file (v6.16)
       2. ✔ show refcount and list lingering bridges (v6.19)
 2. … handle gracefully atomic updates during bridge removal
    A. … Add drm_dev_enter/exit() to protect device resources
    B. … protect private_obj removal from list
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
Changes in v4:
- No patch changes (this series was tested a lot since v3 without issues)
- Added Reviewed-by from Maxime
- Rebased on current drm-misc-next
- Small improvement to kerneldoc for the two for_each macros
- Link to v3: https://lore.kernel.org/r/20251009-drm-bridge-alloc-encoder-chain-mutex-v3-0-c90ed744efec@bootlin.com

Changes in v3:
- Re-added the drm_bridge_put() in the for_each macros, leading to largely
  rewrite them
- Removed the drm_encoder_chain_[un]lock() wrappers
- Fixed a potential ABBA deadlock in patch
- Improved some commit messages
- Link to v2: https://lore.kernel.org/r/20251003-drm-bridge-alloc-encoder-chain-mutex-v2-0-78bf61580a06@bootlin.com

Changes in v2:
- Improve commit messages and add documentation as per v1 review
- Patch 4: fixed infinite loop when encoder->bridge_chain is empty
- Link to v1: https://lore.kernel.org/r/20250926-drm-bridge-alloc-encoder-chain-mutex-v1-0-23b62c47356a@bootlin.com

---
Luca Ceresoli (7):
      drm/encoder: add mutex to protect the bridge chain
      drm/encoder: drm_encoder_cleanup: lock the encoder chain mutex during removal
      drm/bridge: drm_bridge_attach: lock the encoder chain mutex during insertion
      drm/bridge: lock the encoder chain in scoped for_each loops
      drm/bridge: prevent encoder chain changes while iterating with list_for_each_entry_from()
      drm/bridge: prevent encoder chain changes while iterating with list_for_each_entry_reverse()
      drm/bridge: prevent encoder chain changes in pre_enable/post_disable

 drivers/gpu/drm/drm_bridge.c  | 83 ++++++++++++++++++++++---------------------
 drivers/gpu/drm/drm_encoder.c | 18 ++++++++--
 include/drm/drm_bridge.h      | 73 +++++++++++++++++++++++--------------
 include/drm/drm_encoder.h     |  4 +++
 4 files changed, 109 insertions(+), 69 deletions(-)
---
base-commit: 71bedd70985a573db58ab62cbcc3c11f9ef66013
change-id: 20250925-drm-bridge-alloc-encoder-chain-mutex-b78d62085ee5

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


