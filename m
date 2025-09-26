Return-Path: <linux-kernel+bounces-834356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFFABA485D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC64256172F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A1923507B;
	Fri, 26 Sep 2025 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0utCTG48"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D426A8287E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758902448; cv=none; b=GozSZkboXf5x35tmWDe0HXy8fcpn+Ht1J38Q/7DHeBiZ3Cfoic9SvvPaBAXmxntsLYw3SDahn06r6oaEPT5uyWrGlwyqT4wdOLL3YnUa9sn0sY8Qo/xb+/eceny/Sp8tG6ES73ch1cC1gnntBB6pf6LGCtYaEtFxUCkARywQzds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758902448; c=relaxed/simple;
	bh=dUaAor8TmMkYeiZvCo/c8KxahB00xi2GRDJQbRjjmeg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AoDcMTvJP2A04waxNjWY2d5QKpjEINn/q23RX5k8ZGYdGgA5MRMp7fktUD33Cyfr+pZb37v2nRas+hLOC+EmIy9feXtfb3qrCUKYAfUaKYEGoA3cNO0/o3wQ6ko4nTw5gKvB+V/qbDnpKUxs5zPE8CAxGbRXtXxDELEs1swPDgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0utCTG48; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7235CC00D96;
	Fri, 26 Sep 2025 16:00:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AB430606B5;
	Fri, 26 Sep 2025 16:00:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 31CFA102F1829;
	Fri, 26 Sep 2025 18:00:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758902441; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=7lVvWz+xLuGFIdL0VxzHhfYYoNfzXxKTU8wq7zWUGmY=;
	b=0utCTG48sbi6K1hDn808DEudRFN9K6qZsiiMBLcZndFfq0i/emL8E0+1zISt8qpwTGXyGj
	tvH3tfEfmNKV06hKIgVfcIbji9s7W0w92KnZODVYKv3PYRZnkMy5s3kdqjkTSiDvpoC0CF
	iHhq9e9s16LQqdsAH05rXIa/qDPZtFWB3gq3Il6Ow8ck/SSBXJ6sZe71ipCHFhcU2dEsT0
	Ze+6Xs2kP03XHUVIlWfVplP48vpDQYA/06jpvZQLLrpSCZvDzv0SbuxQ/cP/8KutB/tDvU
	OTezU/arlsrfcXDMu+vcA/DMSCVRc9xL2Km6Sn74CqIdhX6AvZ3j9vVpKI3s4g==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 0/7] drm/bridge: protect encoder bridge chain with a mutex
Date: Fri, 26 Sep 2025 17:59:41 +0200
Message-Id: <20250926-drm-bridge-alloc-encoder-chain-mutex-v1-0-23b62c47356a@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAG241mgC/x2N0QrCMBAEf6XcswcxEK3+ivjQ5lY9aBO5VCmU/
 ruHj8MOOxs1mKLRtdvI8NWmtTgcDx3l11CeYBVniiGmcImJxWYeTcWXYZpqZpRcBcaua+H5s2D
 l8dzLKYY+AYn86m146PrP3O77/gOo8h9GdgAAAA==
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
modified while some other code flows are iterating over it.

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
    E. … add get/put on drm_bridge accessors
       1. ✔ drm_bridge_chain_get_first_bridge() + add a cleanup action
            (drm-misc-next)
       2. ✔ drm_bridge_get_prev_bridge() (drm-misc-next)
       3. ✔ drm_bridge_get_next_bridge() (drm-misc-next)
       4. ✔ drm_for_each_bridge_in_chain() (drm-misc-next)
       5. … drm_bridge_connector_init
       6. ➜  protect encoder bridge chain with a mutex
       7. of_drm_find_bridge
       8. drm_of_find_panel_or_bridge, *_of_get_bridge
    F. ➜ debugfs improvements
       1. ✔ add top-level 'bridges' file (v6.16)
       2. ✔ show refcount and list removed bridges (drm-misc-next)
 2. … handle gracefully atomic updates during bridge removal
 3. … DSI host-device driver interaction
 4. removing the need for the "always-disconnected" connector
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
chain. Avoid it by introducing a mutex to make list insertion, removal and
iterations mutually exclusive.

[1] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com/#t

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (7):
      drm/encoder: add mutex to protect the bridge chain
      drm/encoder: drm_encoder_cleanup: take chain mutex while tearing down
      drm/bridge: lock the encoder bridge chain mutex during insertion
      drm/bridge: lock the encoder chain in scoped for_each loops
      drm/bridge: prevent encoder chain changes while iterating with list_for_each_entry_from()
      drm/bridge: prevent encoder chain changes while iterating with list_for_each_entry_reverse()
      drm/bridge: prevent encoder chain changes while iterating in drm_atomic_bridge_chain_post_disable/pre_enable()

 drivers/gpu/drm/drm_bridge.c  | 56 +++++++++++++++++++++-----------------
 drivers/gpu/drm/drm_encoder.c |  4 +++
 include/drm/drm_bridge.h      | 62 +++++++++++++++++++++++--------------------
 include/drm/drm_encoder.h     | 18 +++++++++++++
 4 files changed, 87 insertions(+), 53 deletions(-)
---
base-commit: a7493ff9ad96868f4c1c16813b205ba812a7573c
change-id: 20250925-drm-bridge-alloc-encoder-chain-mutex-b78d62085ee5

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


