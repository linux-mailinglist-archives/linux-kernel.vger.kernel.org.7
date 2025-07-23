Return-Path: <linux-kernel+bounces-742221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DB5B0EED9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0B71C83AFC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E91E28467D;
	Wed, 23 Jul 2025 09:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jR+rdDGi"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7248B27E7E1
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264476; cv=none; b=uGxN2W9KOPNSmRp/c92cDEtoVLHke5hbkq5IqgNVAaRSDT0qxEoOCzVCkqws4S5K/SmizLb2BVyYAskL2F5SmMFRsfHz4ulx5bTENcXsiZEXiZSz10eCzAVxYS0r0Yp3wV/wevXc6mSLDxBOfLske8wY29/v0m4YnISGx76aSpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264476; c=relaxed/simple;
	bh=ydH+Obkp/3P1ccbLhAL7B7uBaevdmyUwuJg0krkTG4k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HVZjWMy32Jzjqj1MhNLQHU9asdKTv5Gupcd7hU2BHUa9c0nS7+h0LSzcwxuo5uYVkVEkB6pZ88SeXwutJj7ij1zqPKYwH7770kMXWToRyIH58vIh9D9fTI2Jj5AsmpH4TBg+zruKTxnpuX3pQ0FfnncRHVDVc36BeMpE5VCbc9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jR+rdDGi; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8EC5443384;
	Wed, 23 Jul 2025 09:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753264472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gmVO0IQ6lgIkx0UIDC0DA82oQtxUZJ5xFddmjHi8fvQ=;
	b=jR+rdDGiooEQeuJKSDmzpG6EWJH4VOBkbF3Q3pH7GR6cn4gRpJyZZTW02kbnbKHXc70rtC
	OuSEXHDy9iaIOOYIwfzgbxYIkmqtiVIwTF3QqGjPumXNGq09bbDwDYhNKbC08FAAOSqYlN
	y3FsMia26PhFxlhPH9eWTvCC5uPKDn2VxFTgW7KZFS6EmJNQN5yf2946dS2zTJH+EFt0DO
	iUFwcV9vDw8a2UMb4bCtDAbekCKP17SGr6Km5ZLvoyg33fM6sNUxkXiw2wKT3T9avbWtsH
	ZjY4+xQ1NRWHx/vefxl9ELuJpLp78Qrh8A/FpJ6KWt1/6KwFtGhWQZjYMdO9TA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 0/9] drm/bridge: get/put the bridge when looping over the
 encoder chain
Date: Wed, 23 Jul 2025 11:54:07 +0200
Message-Id: <20250723-drm-bridge-alloc-getput-for_each_bridge-v1-0-be8f4ae006e9@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAD+xgGgC/02O22rDMBBEf8XouQpa2ZIvlNL/CCGsVutExJdUc
 kJKyL9XTUzp48wwM+cuEsfASXTFXUS+hhTmKQt4KwQdcTqwDD5roZU2qoZG+jhKF4PPCQ7DTPL
 Ay/myyH6Oe0Y67tewhwqQoXbWoMhr58h9uD2ftruXjvx1yYfLyxQOE0uaxzEsXVFZKq1tDKByG
 kzrvGtr7AlJVWw8k6JetdyI/6Bd8YeZvyQxrahJ6sr4sqx8WYPurvBbGzklXHvvz6LVSgFYsBv
 IEyBPHCcePjHE03fYZLQPsXs8fgAroQMHNAEAAA==
X-Change-ID: 20250718-drm-bridge-alloc-getput-for_each_bridge-f141ae17b65a
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtkeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptefgheetvddtteeutdeuvdefkeeifefhhedtleefkeekffeuueelteehgeduueeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpfhhrvggvuggvshhkthhophdrohhrghenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghloheplgduledvrdduieekrddujeekrdejhegnpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdehpdhrtghpthhtoheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtp
 hhtthhopehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggvpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepshhimhhonhgrsehffhiflhhlrdgthhdprhgtphhtthhopehnihgtkhdruggvshgruhhlnhhivghrshdolhhkmhhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhfohhssheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: luca.ceresoli@bootlin.com

This series adds drm_bridge_get/put() calls for DRM bridges used when
looping over bridges in an encoder chain.

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
       2. … drm_bridge_get_prev_bridge()
       3. … drm_bridge_get_next_bridge()
       4. ➜ drm_for_each_bridge_in_chain()
       5. drm_bridge_connector_init
       6. of_drm_find_bridge
       7. drm_of_find_panel_or_bridge, *_of_get_bridge
    F. debugfs improvements
 2. handle gracefully atomic updates during bridge removal
 3. … avoid DSI host drivers to have dangling pointers to DSI devices
 4. finish the hotplug bridge work, removing the "always-disconnected"
    connector, moving code to the core and potentially removing the
    hotplug-bridge itself (this needs to be clarified as points 1-3 are
    developed)

Most loops are based on drm_for_each_bridge_in_chain(), so add a scoped
variant that does not use an externally-declared iterator variable and
ensures that a reference to the bridge pointed to by the iterator is
taken/released before/after every iteration (and when breaking out of the
loop).

All conversions are trivial except for drm_bridge_connector_init() which
needs some preliminary cleanups (patches 1-2).

omapdrm/omap_encoder.c is the only driver iterating over the encoder bridge
chain starting from a specific bridge, instead of iterating over the whole
list. For this use case, add a drm_for_each_bridge_in_chain_from() variant.

This series depends on two fixes to bridge-connector:

 * commit 103578241512 ("drm/bridge-connector: Fix bridge in
   drm_connector_hdmi_audio_init()"), currently in drm/drm-fixes, not yet
   on drm-misc*

 * "drm/display: bridge-connector: correct CEC bridge pointers in
   drm_bridge_connector_init"
   (https://lore.kernel.org/lkml/20250719-fix-cec-bridges-v1-1-a60b1333c87d@oss.qualcomm.com/),
   not yet applied

[0] https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/0cc6aadd7fc1e629b715ea3d1ba537ef2da95eec
[1] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com/t/#u

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (9):
      drm/display: bridge-connector: use scope-specific variable for the bridge pointer
      drm/display: bridge-connector: remove unused variable assignment
      drm/bridge: add drm_for_each_bridge_in_chain_scoped()
      drm/display: bridge-connector: use drm_for_each_bridge_in_chain_scoped()
      drm/atomic: use drm_for_each_bridge_in_chain_scoped()
      drm/bridge: use drm_for_each_bridge_in_chain_scoped()
      drm/bridge: remove drm_for_each_bridge_in_chain()
      drm/bridge: add drm_for_each_bridge_in_chain_from()
      drm/omap: use drm_for_each_bridge_in_chain_from()

 .clang-format                                  |  2 +-
 drivers/gpu/drm/display/drm_bridge_connector.c | 13 +++----
 drivers/gpu/drm/drm_atomic.c                   |  3 +-
 drivers/gpu/drm/drm_bridge.c                   |  3 +-
 drivers/gpu/drm/omapdrm/omap_encoder.c         |  4 +-
 include/drm/drm_bridge.h                       | 52 ++++++++++++++++++++++++--
 6 files changed, 58 insertions(+), 19 deletions(-)
---
base-commit: 46c366851a0b2159bdb97afcac04e5dec0cf09e8
change-id: 20250718-drm-bridge-alloc-getput-for_each_bridge-f141ae17b65a
prerequisite-change-id: 20250718-fix-cec-bridges-245d334d3712:v1
prerequisite-patch-id: df6d3d4a62c942703fab374bee85c49e4ac259cc
prerequisite-message-id: <20250620011616.118-1-kernel@airkyi.com>
prerequisite-patch-id: ba5a6a15ea02bcee387db0e92ffb4cd0e1fbf816

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


