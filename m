Return-Path: <linux-kernel+bounces-775328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADBAB2BE0C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E721B65969
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A27731AF34;
	Tue, 19 Aug 2025 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z/Q3idA+"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA0F31A050
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597035; cv=none; b=gL9bdoJ5iIKiHZi+Jnlx2VYr/Vc9KONOWmnBAO/UyiSJcrLct4UUjnfoo7CpGYBOsOeKSo7vHywqUDNmi8wgSnI/xc8Ze+GersrPGstBeynKIrBOpkDbEy+0L0CPgbQ2MGDcJ7YpaVVQH9v40IJg+p/nwVXlMUvE1H8THIYdaro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597035; c=relaxed/simple;
	bh=9G1tptpmOKeOINbkab/YaZY3bVkbVQrpj6bIL5Zp/4g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hYaxE7/MdP28QUUBF8bHRu5CH2wT/VEwYP5s1wmaksL3pdU4xl/8HS0dYoLjISsAWFNe9CXrUYQ5U5UKSSuKjnAkonGHg4j6x9nl6uX01wgzHKko6Tpw5WIc6aP6gI4TDFPON6v3UUCQsu/0pgXwEY62HUtghe7w6XzSV7ZnWCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Z/Q3idA+; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6B75EC6B390;
	Tue, 19 Aug 2025 09:42:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D94DC60697;
	Tue, 19 Aug 2025 09:42:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 34A3B1C22CE69;
	Tue, 19 Aug 2025 11:42:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755596553; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=hBqpzbi2Hbxep2bpOtuW7wxw+5uHsx1EqMbGij/dqlY=;
	b=Z/Q3idA+5YgF8Yk+dEOhSqk2M7AgHRazWxtmeOgN0JOjGzjp08Y4spxeBbmPR4zfDuZ6Ix
	xnPnafOMv1Kyop1KlWumZQoku9SeU4p/WnryCJEBDuSjthjXd6K2MSwj1baIf6W4+0+tvv
	D+2QdLlalG+Dr0lYoyevO/AtJoX+zKDvazv9YmHTB/Xzcbznizew8Oph/NO5G0WN3iXkXt
	P9gynn/rBiZZsGrG0QDUiSYK1dhffzOjxYXGHlOgFoV2ceIGlsTxsPq8W0jojtqJQevtr2
	cq1x6ps4DP4TRmCrDHUFksUFCPMqNWgUjQL2Ct0MuSBJRZujUHwGSwbivIDbgQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v7 0/3] drm/bridge: debugfs: show refcount and list removed
 bridges
Date: Tue, 19 Aug 2025 11:42:09 +0200
Message-Id: <20250819-drm-bridge-debugfs-removed-v7-0-970702579978@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPFGpGgC/1WOS4rDMBBEr2K0HoG+luOrhBBarZYjiCNHss1Ay
 N1H+Wxm+argVT1YpZKosrF7sEJ7qinfGrifjuEFbhPxFBozJZQVRgw8lJn7kkJrAvltipUXmvN
 OgSvrDnE4KDJesyZYCsX0+5YfTx8udN/axvoJmYdKHPM8p3XscEACo50kSwhaYICh7wWA91o7Z
 1wAj1aGl/p9x8l/d+B6zcgnWpdt5TGXMwFezt8ySiOBpPO9hXFX7PR8/gFee77X/AAAAA==
X-Change-ID: 20250408-drm-bridge-debugfs-removed-2579f892e4b3
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

This series shows removed bridges to the global <debugfs>/dri/bridges file,
and shows the bridge refcount.  Removed bridges are bridges after
drm_bridges_remove() but before they are eventually freed on the last
drm_bridge_put().

This is part of the work towards removal of bridges from a still existing
DRM pipeline without use-after-free. The grand plan was discussed in [1].
Here's the work breakdown (➜ marks the current series):

 1. ➜ add refcounting to DRM bridges (struct drm_bridge)
    (based on devm_drm_bridge_alloc() [0])
    A. ✔ add new alloc API and refcounting (v6.16)
    B. ✔ convert all bridge drivers to new API (v6.17-rc1)
    C. ✔ kunit tests (v6.17-rc1)
    D. ✔ add get/put to drm_bridge_add/remove() + attach/detach()
         and warn on old allocation pattern (v6.17-rc1)
    E. … add get/put on drm_bridge accessors
       1. ✔ drm_bridge_chain_get_first_bridge() + add a cleanup action
            (drm-misc-next)
       2. ✔ drm_bridge_get_prev_bridge() (drm-misc-next)
       3. … drm_bridge_get_next_bridge()
       4. … drm_for_each_bridge_in_chain()
       5. drm_bridge_connector_init
       6. of_drm_find_bridge
       7. drm_of_find_panel_or_bridge, *_of_get_bridge
    F. ➜ debugfs improvements
       1. ✔ add top-level 'bridges' file (v6.16)
       2. ➜ show refcount and list removed bridges
 2. … handle gracefully atomic updates during bridge removal
 3. … DSI host-device driver interaction
 4. finish the hotplug bridge work, removing the "always-disconnected"
    connector, moving code to the core and potentially removing the
    hotplug-bridge itself (this needs to be clarified as points 1-3 are
    developed)

To show the removed bridges we need to keep track of them, thus add a new
global list to store them between drm_bridge_remove() and the eventual
free. This is bit tricky in case a bridge is removed and then re-added
before being freed. This is handled in patch 2.

This series  depends on one other series:
 * [PATCH v2 0/9] drm/bridge: get/put the bridge when looping over the encoder chain
   Link: https://lore.kernel.org/r/20250808-drm-bridge-alloc-getput-for_each_bridge-v2-0-edb6ee81edf1@bootlin.com
   Reason: it uses drm_for_each_bridge_in_chain_scoped()

[0] https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/0cc6aadd7fc1e629b715ea3d1ba537ef2da95eec
[1] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com/t/#u

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
This series was initially part of v6 of this other series:
- Link to v6: https://lore.kernel.org/dri-devel/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com/

---
Luca Ceresoli (3):
      drm/debugfs: bridges_show: show refcount
      drm/bridge: add list of removed refcounted bridges
      drm/debugfs: show removed bridges

 drivers/gpu/drm/drm_bridge.c | 47 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 7 deletions(-)
---
base-commit: c8cea4371e5eca30cda8660aabb337747dabc51d
change-id: 20250408-drm-bridge-debugfs-removed-2579f892e4b3

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


