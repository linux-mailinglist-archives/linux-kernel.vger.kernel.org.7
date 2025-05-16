Return-Path: <linux-kernel+bounces-651639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C03ABA104
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 18:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38BD13A62BD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 16:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAD71D63FC;
	Fri, 16 May 2025 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="p6mv6D9G"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1982CCC1
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747414125; cv=none; b=XRubk4J9xw2Tczt20Rly06xLod55tufhy0yLaeM13VUB3T8b5/upV+lWqYCTG5StLt8R4sjrce8nZrrjLNGEX/SdXc6ygaNu3aUnjMoH75Sdg4dyBeIvu0ZChVL5TzEjQfVqihq/DLpHpM/w0mfUuAsvadd8z86yULhOtaM77XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747414125; c=relaxed/simple;
	bh=1zqbrZGpx4267oH+VbULHqmi+QRRaZj0YbEMM5o2fIo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eT3Zpoka4h6DCVwMVoTWgnTfmI5oeJhnqP8E9IxGGUKPjg2O5nwDlpF6o4r8vJXsS20E7yX0kpbrba0wm6044ZVIPDPC8G5R8rCIv6sCk1F4XosAQ/cQjxos3ejKmtMsdzRkbenW+haBt8pcpaG8HWc+sx8PGvcvLrXqJRg5JNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=p6mv6D9G; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 427F6439B2;
	Fri, 16 May 2025 16:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747414120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u67y+PxjqNGnhDEAS0aXR4UPt8Hc/le9hjcGHqYdEHU=;
	b=p6mv6D9GJeRLeZED5h3yANz4ZPQLeix8vhRp1vxligLK4ImCq07Ci8X3eap0IMVpypq6Td
	ZiR84hhLwi83tKGUaMKTqbdCVboLErpoliz4difn2vqIHdACf3kIGlAzm42YkQlHpZ7SNU
	m4qp6q+b2hDVdQrwx8fMIYuPDzxKKas//d9DEOytowPTvJeDJRaPDLLgm+h5Aq7n9AMq5y
	Dcp1a/jQaRfKt/t5cSKFy1kruQjl4pe9OfBEBsL0H15KvH0jHPryWsy9kgdXheJnuK3dpe
	qbsczp1/UHJgzXKV9oFnywZwDSETs1qHD9guOotjZnIKeFayAq73rbWzPf6y4A==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v8 0/3] drm/bridge: add kunit tests for
 devm_drm_bridge_alloc()
Date: Fri, 16 May 2025 18:48:36 +0200
Message-Id: <20250516-drm-bridge-alloc-doc-test-v8-0-7e356fd58ba5@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGRsJ2gC/32NQQ6CMBBFr0Jm7ZgGwRZX3sOwKO1UJgFK2qbRE
 O5uJXHrYhbv//w3G0QKTBFu1QaBMkf2SwF1qsCMenkSsi0Mtahb0QiFNsw4BLal0dPkDdpyiWL
 C+iqtE5acUgLKfg3k+HW4H33hkWPy4X28yvKb/qzdH2uWKFBfjG6GTraddPfB+zTxcjZ+hn7f9
 w/8ZL2BxAAAAA==
X-Change-ID: 20250408-drm-bridge-alloc-doc-test-267df0def880
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Anusha Srivatsa <asrivats@redhat.com>, 
 Paul Kocialkowski <paulk@sys-base.io>, Dmitry Baryshkov <lumag@kernel.org>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudefvdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthekredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejjefhgfffleevhefhfeduhedtfedttedtkefgkeeuieehtdeifeduveejffevgeenucffohhmrghinhepfhhrvggvuggvshhkthhophdrohhrghdpkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegludelvddrudeikedrudejkedrjeehngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepughrihdquggvvhgvlheslhhis
 hhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopehluhhmrghgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghilhdrrghrmhhsthhrohhngheslhhinhgrrhhordhorhhgpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughriigvjhdrhhgrjhgurgesihhnthgvlhdrtghomhdprhgtphhtthhopehprghulhhksehshihsqdgsrghsvgdrihhopdhrtghpthhtohephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhm
X-GND-Sasl: luca.ceresoli@bootlin.com

This small series adds a few kunit tests for the new DRM bridge allocation
flow, based on the recently introduced devm_drm_bridge_alloc() [0].

It is part of the work towards removal of bridges from a still existing DRM
pipeline without use-after-free.

The steps in the grand plan [1] are:

 1. ➜ add refcounting to DRM bridges (struct drm_bridge)
 2. handle gracefully atomic updates during bridge removal
 3. avoid DSI host drivers to have dangling pointers to DSI devices
 4. finish the hotplug bridge work, removing the "always-disconnected"
    connector, moving code to the core and potentially removing the
    hotplug-bridge itself (this needs to be clarified as points 1-3 are
    developed)

This series is part of step 1 of the grand plan.

Current tasks in step 1 of the grand plan:

 A. ✔ add new alloc API and refcounting -> (now in drm-misc-next)
 B. … convert all bridge drivers to new API (in progress)
 C. ➜ kunit tests (this series)
 D. after (B), add get/put to drm_bridge_add/remove() + attach/detech()
 E. after (B), convert accessors; this is a large work and can be done
    in chunks
 F. debugfs improvements

[0] https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/0cc6aadd7fc1e629b715ea3d1ba537ef2da95eec
[1] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com/t/#u

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v8:
- Remove documentation patch
- Add patch to convert existing kunit tests to use devm_drm_bridge_alloc()
- Add tests for bridge deallocation (based on adding a .destroy callback)
- Link to v7: https://lore.kernel.org/r/20250409-drm-bridge-alloc-doc-test-v7-0-a3ca4b97597f@bootlin.com

---
Luca Ceresoli (3):
      drm/tests: bridge: convert to devm_drm_bridge_alloc() API
      dmr/bridge: add a .destroy func
      drm/tests: bridge: add KUnit tests for devm_drm_bridge_alloc()

 drivers/gpu/drm/drm_bridge.c            |   2 +
 drivers/gpu/drm/tests/drm_bridge_test.c | 179 +++++++++++++++++++++++++-------
 include/drm/drm_bridge.h                |  10 ++
 3 files changed, 151 insertions(+), 40 deletions(-)
---
base-commit: aec8a40228acb385d60feec59b54573d307e60f3
change-id: 20250408-drm-bridge-alloc-doc-test-267df0def880

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


