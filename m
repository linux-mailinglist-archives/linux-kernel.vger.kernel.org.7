Return-Path: <linux-kernel+bounces-724091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1378BAFEE80
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455491C85863
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3051F3BA4;
	Wed,  9 Jul 2025 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Yt0hL0A5"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9066C1F76A8
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076816; cv=none; b=WK2b1DI+8XshsAXtjnEN0Y/jL7D5sVI2/kV3jGie/x6Oe3DNAtqnpzRSoK05pPTqtaOBCSE0pSLBjpe2A9Zrpekv/wcvAtjHakY0i3rkkCy9QZ7PUwHZ0Yjys2o5UyAGo3dQCb+etHACG0mCfM+JIjpQUfSZMmziS+UXZnBD+DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076816; c=relaxed/simple;
	bh=NgNEw8TVMyNfp4gSApAbNc+4R2Fudn/LIINQV/Z2bak=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LfjgPyY7pzV56S2FPTifJkV9aDpziMLJgVbYDm2a7QiRh0CnbLkPOvcoFmiS9BNndEoQSwhOP0XMqGpcjdVqYhbESRBDAfOKY8jEvm9RioBY4vab74WjUBHamLGhBXLXpL0uA0JMaxx6YOsQhgj/o+Ub5pQu48NtCeAlEwcq4PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Yt0hL0A5; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 07039442B3;
	Wed,  9 Jul 2025 16:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752076806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ssBjI9tL4zH8w0i7uvVdHfRAJbny2996+v1we4JsojM=;
	b=Yt0hL0A5JCbxElp+aK4twDKbv5rBzOAvDBr5sieeI2l0ZIKjiGySmBmrbrHgW03AAeOC/F
	y78N1zm0gziAlnNQLZUId+TUUTJkqzscZSFAXlmyQxdf97SY7Hh70fivn7cMewtJL1CFTv
	PWcXMPRFyiFmQDBsehNMUifjBVQ6L825AYSZZZL768FitOgxy/CKW6sY/qUOThxwYiY3c+
	VsrUvM4CEW6ra3OJe9C0ovYh/eglxaUGvaIg7pyGYc3wQnVpPwWIKsGF7DXYlq/z+CAUH2
	DDp9IVN+Dq9mQqplZ6JgGSblMaSCaM+SCwlYuxU6f/Ylhs2FxGL4gQIXX4dSmQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 0/3] drm/bridge: get/put the bridge returned by
 drm_bridge_get_prev_bridge()
Date: Wed, 09 Jul 2025 17:59:36 +0200
Message-Id: <20250709-drm-bridge-alloc-getput-drm_bridge_get_prev_bridge-v1-0-34ba6f395aaa@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOiRbmgC/y2NWQqDQBAFryL9nYZRI0avEmSYpTUNbsyoCOLd0
 5p8Vj2od0CkwBShTg4ItHHkaRRIHwm4jxk7QvbCkKmsUKWq0IcBbWAvi+n7yWFHy7wul9c/r8X
 oWWJ/xupZKu/MK7U2BwnL1vJ+n76b8/wCDLWiIIQAAAA=
X-Change-ID: 20250709-drm-bridge-alloc-getput-drm_bridge_get_prev_bridge-9470dca81bb3
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeelkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtkeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepjeejhffgffelveehhfefudehtdeftdettdekgfekueeihedtieefudevjeffveegnecuffhomhgrihhnpehfrhgvvgguvghskhhtohhprdhorhhgpdhkvghrnhgvlhdrohhrghenucfkphepkeejrdduvddtrddvudekrddvtdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeejrdduvddtrddvudekrddvtdejpdhhvghloheplgduledvrdduieekrddurddufegnpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudeipdhrtghpthhtohepjhhonhgrsheskhifihgsohhordhsvgdprhgtphhtthhopefnrghurhgvnhhtrdhpihhntghhrghrthesihguvggrshhonhgsohgrrhgurdgtohhmpdhrtghpthhtohepughrihdquggvvhgvlheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhop
 ehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: luca.ceresoli@bootlin.com

This series adds drm_bridge_get/put() calls for DRM bridges returned by
drm_bridge_get_prev_bridge().

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
       1. … drm_bridge_chain_get_first_bridge() + add a cleanup action
       2. drm_bridge_chain_get_last_bridge()
       3. ➜ drm_bridge_get_prev_bridge()
       4. drm_bridge_get_next_bridge()
       5. drm_for_each_bridge_in_chain()
       6. drm_bridge_connector_init
       7. of_drm_find_bridge
       8. drm_of_find_panel_or_bridge, *_of_get_bridge
    F. debugfs improvements
 2. handle gracefully atomic updates during bridge removal
 3. … avoid DSI host drivers to have dangling pointers to DSI devices
 4. finish the hotplug bridge work, removing the "always-disconnected"
    connector, moving code to the core and potentially removing the
    hotplug-bridge itself (this needs to be clarified as points 1-3 are
    developed)

[0] https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/0cc6aadd7fc1e629b715ea3d1ba537ef2da95eec
[1] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com/t/#u

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (3):
      drm/bridge: get the bridge returned by drm_bridge_get_prev_bridge()
      drm/bridge: select_bus_fmt_recursive(): put the bridge obtained by drm_bridge_get_prev_bridge()
      drm/bridge: display-connector: put the bridge obtained by drm_bridge_get_prev_bridge()

 drivers/gpu/drm/bridge/display-connector.c | 4 ++--
 drivers/gpu/drm/drm_bridge.c               | 4 ++--
 include/drm/drm_bridge.h                   | 9 ++++++++-
 3 files changed, 12 insertions(+), 5 deletions(-)
---
base-commit: 0f168e7be696a17487e83d1d47e5a408a181080f
change-id: 20250709-drm-bridge-alloc-getput-drm_bridge_get_prev_bridge-9470dca81bb3

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


