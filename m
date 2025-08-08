Return-Path: <linux-kernel+bounces-760326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC0FB1E994
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5871C240BE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B5514F125;
	Fri,  8 Aug 2025 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NN1jo9Bm"
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04A512CDA5
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661183; cv=none; b=sTnX6n+L1PQx+0MbFRu7n1x51HCNDqjOAO37yYWqezyC9G9wTS9HsQABEW/Ce/u1xpQNXOTk7wUqCyJRX0Je2YYdXLy5ZvhpOOUtitC+xTUjcVu/vt3NRKIjygGY0Uvteof7ZywyjlJ5eZMEjTdTQIQIrv/YijHZkaMC15BwDZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661183; c=relaxed/simple;
	bh=21sYltfoyF3nb5kjyrj2feR59jo87Y6vaMX4RFHxd8I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D+h4LBn1aUCV12XpsVggPLWsH8oyDFXwUd3WftqAL+a0cvH4BPgfHoERn3ZhE/9sPX2DiZtNVFkORK/CWH6coggVHCWBFQUMZNAT3hqpsvre1sKgci1MdtWwKHDO/J/t/lyC5/+vrZ0xAdW3CtkTynTePSjnRy2c1UcM5dsP5OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NN1jo9Bm; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id EC866583CD0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 13:24:43 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 151D343A0E;
	Fri,  8 Aug 2025 13:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754659476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jpltjrzBkIbtVl37N24OosMyazu7AKz2Ez4giXXbdgE=;
	b=NN1jo9Bm64tqwTp255eXkPKj73eEKM8faZwFltnNaICRFSaQTXKLauolxGW99vz+lXtIlc
	Vlh6Y0b5xfUKKoDHiAdzV2DVlv0/5t8PH1NcEJVRZ0NjIC6TVVKFCArILUQxXcnOGreeqK
	Iy/ZnPC8PAnqE68Giolj4apX3gCTVyzo0iiM72VmzbBzA4k8KCH+qTBuRSgSSZdY/jIZ7Z
	Lzws7unJAQYPSp4j8P9MjVcPLHFiQH2+mGYSj845dTzRb57Y4K9J2Pcvi33zEi5Q3M+kt9
	8kxGKdOM/Wammqzh2+ul+hYUDMXi/1T9lM7EeLyDUGoiBGvgZp9HFkvt8ak5dQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 0/2] drm/bridge: handle gracefully atomic updates during
 bridge removal
Date: Fri, 08 Aug 2025 15:24:27 +0200
Message-Id: <20250808-drm-bridge-atomic-vs-remove-v1-0-a52e933b08a8@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIv6lWgC/x2MQQqAMAzAviI9W5iCOPyKeHBb1R7mpJMhyP5u8
 RgS8kImYcowNS8IFc6cToWubcAf67kTclCG3vSDscZikIhOOKhZ7xTZY8koFFMh7MLonJbe0gZ
 6uIQ2fv77vNT6AS1ZyhNtAAAA
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdefleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthekredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelueduleduteehieeigeegffdtheeigefffffggfeuheejgfehtdfgleegieehveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeejkedrvdduvddrvdejrdduudehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepjeekrddvuddvrddvjedrudduhedphhgvlhhopegludejvddrudeirddtrddungdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopegrnhgurhiivghjrdhhrghjuggrsehinhhtvghlrdgtohhmpdhrtghpthhtohepnfgruhhrvghnthdrphhinhgthhgrrhhtsehiuggvrghsohhnsghorghrugdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhnrghssehkfihisghoohdrs
 hgvpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopehjvghrnhgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggv
X-GND-Sasl: luca.ceresoli@bootlin.com

This is a first attempt at gracefully handling the case of atomic updates
happening concurrently to physical removal of DRM bridges.

This is part of the work towards removal of bridges from a still existing
DRM pipeline without use-after-free. The grand plan was discussed in [1].
Here's the work breakdown (➜ marks the current series):

 1. ➜ add refcounting to DRM bridges (struct drm_bridge)
    (based on devm_drm_bridge_alloc() [0])
    A. ✔ add new alloc API and refcounting (in v6.16-rc1)
    B. ✔ convert all bridge drivers to new API (now in drm-misc-next)
    C. ✔ kunit tests (now in drm-misc-next)
    D. ✔ add get/put to drm_bridge_add/remove() + attach/detach()
         and warn on old allocation pattern (now in drm-misc-next)
    E. ➜ add get/put on drm_bridge accessors
       1. ✔ drm_bridge_chain_get_first_bridge() + add a cleanup action
       2. ✔ drm_bridge_get_prev_bridge()
       3. … drm_bridge_get_next_bridge()
       4. … drm_for_each_bridge_in_chain()
       5. drm_bridge_connector_init
       6. of_drm_find_bridge
       7. drm_of_find_panel_or_bridge, *_of_get_bridge
    F. debugfs improvements
 2. ➜ handle gracefully atomic updates during bridge removal
 3. … DSI host-device driver interaction
 4. finish the hotplug bridge work, removing the "always-disconnected"
    connector, moving code to the core and potentially removing the
    hotplug-bridge itself (this needs to be clarified as points 1-3 are
    developed)

The idea was proposed by Maxime [0] and is based on the existing
drm_dev_enter/exit() already existing for the DRM device.

This small series implements the core mechanism in drm_bridge.c and uses it
in the ti-sn65dsi83 driver. This prevents usage of device resources by
various code paths that can happen concurrently to unplug of the SN65DSI8x
bridge.

[0] https://lore.kernel.org/all/20250106-vigorous-talented-viper-fa49d9@houat/

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (2):
      drm/bridge: add drm_bridge_unplug() and drm_bridge_enter/exit()
      drm/bridge: ti-sn65dsi83: protect device resources on unplug

 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 53 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_bridge.c          | 58 +++++++++++++++++++++++++++++++++++
 include/drm/drm_bridge.h              | 12 ++++++++
 3 files changed, 123 insertions(+)
---
base-commit: d2b48f2b30f25997a1ae1ad0cefac68c25f8c330
change-id: 20250808-drm-bridge-atomic-vs-remove-1d7bb202c8ef

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


