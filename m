Return-Path: <linux-kernel+bounces-863696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 392BEBF8DC4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB38A1886CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CC526A08C;
	Tue, 21 Oct 2025 21:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ewEDuw8L"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD813FBA7
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080484; cv=none; b=fdozphHbp0aNvpYtdhuEz+Iw/0l7jiu/FE7v3PnQ8hSXxfzXgyI3gf6j8w8Lt4WPiIBIy1gq3C9tY+PiRrTvIWAswXl4BrDO0JW6hBUwuYuUplZxClxGYAHDCkYzXCVal7LiYKK546f7ICe8BIhKIn6hMb4zgwPZ9uEFIFhNIUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080484; c=relaxed/simple;
	bh=EAI/Y6nsft/bHHXZ40zvJjSM8UEnKMb40D2gEvFGtK0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X1Vcskv3j89RREB+Gzkd/5my4DfcfpRlmmkHXmcmeXgTDERRgMoOvRGcNwGnkPxwdPAhKP6TGL+VofH//0zzNwEzzZd7yAtZddqptP9T4hc6S1xGmkF7aGjaNZueT3K7BLYlgZm0anPbupl4Tkb6PcPgnTwqXNrEBZc+681xaG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ewEDuw8L; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1C39E1A15AB;
	Tue, 21 Oct 2025 21:01:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D890F60680;
	Tue, 21 Oct 2025 21:01:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AA96A102F2415;
	Tue, 21 Oct 2025 23:00:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761080476; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=StWZV3qPQUGaxlrgnNwyHxQJLDbPYSKXBfhgcG7aLzo=;
	b=ewEDuw8LXOPWt52sCLrhohoFRi4re2+XU0UoggViAiOe8SBIB/IGOo5ha4XHEIn2Jd7QPv
	X7XL8P/XsoxItFymzcyJ1/0vV57BjBZ5MCcXEGWO5M5jFtThXMa/uH0nsaWsRrH6rkngWu
	uUouW/Pna6352LY4mKxQaHSXCs5aIx0f2y0lfCI7129NAy7iKJVTT4Yer/0pXSxq9BsWaN
	QmRIpgN8MM4Cm6G4wxlv5Ra+EKqkIbkWWMMh5oWcOkmuIkiF0HoywjZjhH4J6/l6WYfFnm
	/3soE/fjlQP2A5KI/7/lgvoigd3s0jSPZ4sx1Sr6t5ZSzHW7C7hQTixY2DiFvA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v2 0/5] drm/bridge: enforce drm_bridge_add() before
 drm_bridge_attach()
Date: Tue, 21 Oct 2025 23:00:43 +0200
Message-Id: <20251021-b4-drm-bridge-alloc-add-before-attach-v2-0-c17cc1bbff72@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHv092gC/5WNTQ6CMBBGr0K6dkxbMKAr72FY9GcqkwA106bRE
 O5u5QYu3/uS720iIRMmcWs2wVgoUVwr6FMj3GTWJwL5ykJLfVFStmA78LyAZfJ1NPMcHRjvwWK
 IXEXOxk2AoVXaSTuYwYn69WIM9D46j7HyRClH/hzZon7230JRIOGqg+2k130vu7uNMc+0nl1cx
 Ljv+xe9icrx3AAAAA==
X-Change-ID: 20251003-b4-drm-bridge-alloc-add-before-attach-ef312c0b8a8c
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

This small series enforces that DRM bridges must be added before they are
attached as discussed in [1].

This is part of the work towards removal of bridges from a still existing
DRM pipeline without use-after-free. The grand plan was discussed in [0].
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
       6. … protect encoder bridge chain with a mutex
       7. of_drm_find_bridge
       8. drm_of_find_panel_or_bridge, *_of_get_bridge
       9. ➜ enforce drm_bridge_add before drm_bridge_attach
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

Series layout:
 - patches 1-2: add missing drm_bridge_add() to the 2 drivers known for not
                calling it
 - patch 3: document that drm_bridge_add() is required before attach
 - patch 4: add a warning in drm_bridge_attach() is drm_bridge_add() was
            not called	    
 - patch 5: add a warning for bridges missing both devm_drm_bridge_alloc()
            and drm_bridge_add()

The added warning might reveal more non-compliant drivers, in that case
they will be fixed as they are found.

[0] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com/#t
[1] https://lore.kernel.org/all/20250709-sophisticated-loon-of-rain-6ccdd8@houat/

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v2:
- Added patch 5
- Added review tags to patches 1-4 (patches unchanged)
- Link to v1: https://lore.kernel.org/r/20251003-b4-drm-bridge-alloc-add-before-attach-v1-0-92fb40d27704@bootlin.com

---
Luca Ceresoli (5):
      drm/sti: hda: add bridge before attaching
      drm/sti: hdmi: add bridge before attaching
      drm/bridge: document that adding a bridge is mandatory before attach
      drm/bridge: add warning for bridges attached without being added
      drm/bridge: add warning for bridges using neither devm_drm_bridge_alloc() nor drm_bridge_add()

 drivers/gpu/drm/drm_bridge.c   | 9 +++++++++
 drivers/gpu/drm/sti/sti_hda.c  | 5 +++++
 drivers/gpu/drm/sti/sti_hdmi.c | 2 ++
 3 files changed, 16 insertions(+)
---
base-commit: c1a7cc00cd412505e070eb4e62bc0b0ca85243e0
change-id: 20251003-b4-drm-bridge-alloc-add-before-attach-ef312c0b8a8c

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


