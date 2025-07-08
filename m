Return-Path: <linux-kernel+bounces-721933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E73CAAFCFAA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524E7188AA40
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551B22E1749;
	Tue,  8 Jul 2025 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oBhuJmtJ"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B5C2E03FA
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989739; cv=none; b=gHpQ/njSaJlGKwW2+CN0TEZe031omdCfndxEF1PLIgo/Hz4twfbIVWNJzyrLIM96Il3Tqc6pxvH5LSZ9dj97axrF6tn0pf33nSCat+6ciBn0xb37h61OGoVrc/b82Aa/zlbTQNerle9po/xWBVN7BvmBrPMhtRBwNcha/4XcKW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989739; c=relaxed/simple;
	bh=dDsl200tiQznj5GD3+5C6nXH/ACtIUf0AYxS7HnS1Pk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T/polWSZwW5AL+tqrqib25toKWiaUOEKKWZ10qL2698IeMD5mFz0uAilEIz7ajCNphdYvt0HCclNMk5aU/ZSpVUaznPWMAfx148iBJj3nOYXXGoTx9xdUp4hoLbPG+jJ/w9N36vvbapMkXdVqDh9xaZ/hpUlI0mbEvDfANsDl3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oBhuJmtJ; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 70DD7443EF;
	Tue,  8 Jul 2025 15:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751989735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XWn8tkHwi2RjacXnR5yqBza6YOAwtweEnReFLSISQuQ=;
	b=oBhuJmtJ5xhEbdeIypr91qJvt2On2vgRuZwdbfCFdHX8E21NImCwasafH3Ic5sF5gUGH1M
	9MRVNV02Shm1tV6GAp67qJ20zDqLQrwxSkcrCbHdpdDFsehwH6l6Z/PqmeiSzRgeOcdeJp
	877K0ROBsJacaH/u1cgdNiou01DuEXaM44Ohp/LcB+xBJkNl8ReCosv4LIfkCQ0UE+D3HQ
	cHdmvwGhG7z5rMl2zPz97nLh9Doq+vO7PBsyUFuqg92BJ2B+XmjFurUub9V5/zCSOoMKXw
	FNwbBIfH8W/AM5my+hRwt70sFoe5V02wr+EtXlF6Z0EqavLyT2PAzf/NTT661A==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v9 0/5] drm/bridge: get/put the bridge returned by
 drm_bridge_chain_get_first_bridge()
Date: Tue, 08 Jul 2025 17:48:17 +0200
Message-Id: <20250708-drm-bridge-alloc-getput-drm_bridge_chain_get_first_bridge-v9-0-db1ba3df7f58@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAME9bWgC/62OWwqDMBBFtyL5bkoaH2i/3EeRYF46oIkkqbSIe
 +9ou4R+nnOZuXcj0QQwkdyzjQSzQgTvEJpLRtTYu8FQ0MiEM16yijOqw0xlAI1JP01e0cGk5Zk
 OL75e4CE4gV5YCDH9NJUmb1RRcK10RfD/EoyF19n96JBHiMmH9zllrQ/7j9a1poyynN/qorSqt
 7KV3qcJ3FX5mXT7vn8ASntc5AQBAAA=
X-Change-ID: 20250620-drm-bridge-alloc-getput-drm_bridge_chain_get_first_bridge-be39c442dcd6
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Liu Ying <victor.liu@nxp.com>, Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefhedtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtkeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepjeejhffgffelveehhfefudehtdeftdettdekgfekueeihedtieefudevjeffveegnecuffhomhgrihhnpehfrhgvvgguvghskhhtohhprdhorhhgpdhkvghrnhgvlhdrohhrghenucfkphepkeejrdduvddtrddvudekrddvtdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeejrdduvddtrddvudekrddvtdejpdhhvghloheplgduledvrdduieekrddurddufegnpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdehpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepughrihdquggvvhgvlheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtt
 hhopehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhfohhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgvrhhnvghjrdhskhhrrggsvggtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: luca.ceresoli@bootlin.com

This series adds drm_bridge_get/put() calls for DRM bridges returned by
drm_bridge_chain_get_first_bridge().

All patches are Reviewed-by Maxime except patch 3.

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
       1. ➜ drm_bridge_chain_get_first_bridge() + add a cleanup action (this series)
       2. drm_bridge_chain_get_last_bridge()
       3. drm_bridge_get_prev_bridge()
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

All the patches in this series have already been sent as part of the larger
"[PATCH v7 00/11] drm/bridge: add devm_drm_bridge_alloc() with bridge
refcount" series [2], hence the v9 number. They have all been Reviewed-by
Maxime too, however they could not be applied at that time, awaiting the
conversion of all bridge drivers to devm_drm_bridge_alloc(), now done (item
1.A).

I'm resending all patches to give them visibility now that they are ready
to be applied.

[0] https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/0cc6aadd7fc1e629b715ea3d1ba537ef2da95eec
[1] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com/t/#u
[2] https://lore.kernel.org/all/20250314-drm-bridge-refcount-v7-0-152571f8c694@bootlin.com/

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v9:
- Small improvement to patch 3
- Link to v8: https://lore.kernel.org/r/20250620-drm-bridge-alloc-getput-drm_bridge_chain_get_first_bridge-v8-0-0321845fcafb@bootlin.com

Changes in v8:
- rebased on current drm-misc-next
- Patch 4: reworked based on current code
- Link to v7: https://lore.kernel.org/all/20250314-drm-bridge-refcount-v7-0-152571f8c694@bootlin.com/

---
Luca Ceresoli (5):
      drm/bridge: add a cleanup action for scope-based drm_bridge_put() invocation
      drm/bridge: get the bridge returned by drm_bridge_chain_get_first_bridge()
      drm/mxsfb: put the bridge returned by drm_bridge_chain_get_first_bridge()
      drm/atomic-helper: put the bridge returned by drm_bridge_chain_get_first_bridge()
      drm/probe-helper: put the bridge returned by drm_bridge_chain_get_first_bridge()

 drivers/gpu/drm/drm_atomic_helper.c |  7 +++++++
 drivers/gpu/drm/drm_probe_helper.c  |  1 +
 drivers/gpu/drm/mxsfb/lcdif_kms.c   |  4 ++--
 include/drm/drm_bridge.h            | 11 +++++++++--
 4 files changed, 19 insertions(+), 4 deletions(-)
---
base-commit: e21354aea4b4420b53c44e36828607a7c94a994c
change-id: 20250620-drm-bridge-alloc-getput-drm_bridge_chain_get_first_bridge-be39c442dcd6

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


