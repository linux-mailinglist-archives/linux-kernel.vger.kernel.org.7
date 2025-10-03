Return-Path: <linux-kernel+bounces-841104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C74BB6460
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5BAB3AE2E9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F6427B340;
	Fri,  3 Oct 2025 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YymIYJaE"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5628033F6
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482047; cv=none; b=mBkmCaarMETmXVsMLF2vB0vO3727D9ZRpctLvDWkFpUhX5g3l9nQ/0tgAbCUZ+NZS7g4Jrbt3yc7oWMvFhWtUQUJOZHGycEWSO+s+4ZFYzUwoy6po3VfCVb5HL0ZnjxcUV2n8EvDJ1PAu0bZRKkhGg5z/TDz35Yi3yLCDR9+cc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482047; c=relaxed/simple;
	bh=NbAaPYZrppMAs8ZuMrfKU+8LcY5bRMhyujbIEj5X4wI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bh8noGbK726Ol7zEN6+LKUT0sscsOm4lBmKwQNkuSzGlbrYk0sEs3IVZ+UcL74PBGGYRgLMophlDP/klIXzpqY7uMhQOiRhx3tfge0jIWotq7C/rPI9PzqM6kgiN375E0Zh4TUp+fFnJy0ElIierJrOSMFsGApNc+zCe/Nf/+s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YymIYJaE; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 629CFC00D93;
	Fri,  3 Oct 2025 09:00:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4F7BF60683;
	Fri,  3 Oct 2025 09:00:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A57F7102F1C39;
	Fri,  3 Oct 2025 11:00:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759482041; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ydVaQXOs3El6RgjJFLU2RI0S1jr8ahmEJkfZ2n2xcVw=;
	b=YymIYJaE0nPg/qfX9fcdUI9vphYazKAB1w6MwQzABk9gmm9+zRKAFB/6ki2ohQ91P/XnCa
	uxkQclcOdFk2ojxQVeskT7HZsFXa8nLtWBXbRk7oQKYmJdfzKwiNYjkV3fRXo+xogE1Ty9
	ZYEQHJLMrntPCm5i5O+bKp4Xvb7IW2MgwV1jKI9J+9QCQlbeT3JHkaYNxyOgi6KwRtSisc
	LaE5XVKIJkRIRGuIpLsCl64Hmd3Td4ZLwK1aA9ushm+ubyTXT5YNIKMdVDr306b6JSZUEj
	RIqUgPY2ucRrkgH21/vWb3wCxKk+CrSBvBwRBT1AhxjAAEzUHRSrvWbjDrIaEQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 0/4] drm/bridge: enforce drm_bridge_add() before
 drm_bridge_attach()
Date: Fri, 03 Oct 2025 10:59:54 +0200
Message-Id: <20251003-b4-drm-bridge-alloc-add-before-attach-v1-0-92fb40d27704@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIqQ32gC/x2N0QrCMAxFf2Xk2UDbKQx/RXxok9QF5irpGMLYv
 xt8PPfAPQd0MZUO9+EAk127ttUhXgagOa8vQWVnSCHdYggjliuyvbGYssu8LI0wM2OR2syHbcs
 0o9QxJgplyhOBf31Mqn7/ncfzPH8kF4pndwAAAA==
X-Change-ID: 20251003-b4-drm-bridge-alloc-add-before-attach-ef312c0b8a8c
To: Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
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
       1. ✔ drm_bridge_chain_get_first_bridge() + add a cleanup action
            (drm-misc-next)
       2. ✔ drm_bridge_get_prev_bridge() (drm-misc-next)
       3. ✔ drm_bridge_get_next_bridge() (drm-misc-next)
       4. ✔ drm_for_each_bridge_in_chain() (drm-misc-next)
       5. ✔ drm_bridge_connector_init (drm-misc-next)
       6. … protect encoder bridge chain with a mutex
       7. of_drm_find_bridge
       8. drm_of_find_panel_or_bridge, *_of_get_bridge
       9. ➜ enforce drm_bridge_add before drm_bridge_attach
    F. ✔ debugfs improvements
       1. ✔ add top-level 'bridges' file (v6.16)
       2. ✔ show refcount and list removed bridges (drm-misc-next)
 2. … handle gracefully atomic updates during bridge removal
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

The added warning might reveal more non-compliant drivers, in that case
they will be fixed as they are found.

[0] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com/#t
[1] https://lore.kernel.org/all/20250709-sophisticated-loon-of-rain-6ccdd8@houat/

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (4):
      drm/sti: hda: add bridge before attaching
      drm/sti: hdmi: add bridge before attaching
      drm/bridge: document that adding a bridge is mandatory before attach
      drm/bridge: add warning for bridges attached without being added

 drivers/gpu/drm/drm_bridge.c   | 6 ++++++
 drivers/gpu/drm/sti/sti_hda.c  | 5 +++++
 drivers/gpu/drm/sti/sti_hdmi.c | 2 ++
 3 files changed, 13 insertions(+)
---
base-commit: 0f2efbe6d8305b91c9b2c92ebaf8c24a614bc305
change-id: 20251003-b4-drm-bridge-alloc-add-before-attach-ef312c0b8a8c

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


