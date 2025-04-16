Return-Path: <linux-kernel+bounces-605373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03638A8A053
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 15:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9654459A5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 13:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC46A2918F1;
	Tue, 15 Apr 2025 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kX8Ch05Z"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39D419F47E;
	Tue, 15 Apr 2025 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744725348; cv=none; b=rgH2SXIHQYFFMAqgtKeKPVjVnvMq7Rkukup5hxzBaeqcx5qL/LwKle73ZwZUNG1sFZR3ZGck0YShRZKVUkFEW+ngny89JWiCCkuNxSKOMXKqm/krLHhkFsJTwRgFaQ+N4/rC/yqb1qASf4SZgzvUXvxZaN7vX3vX7eKeankdiWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744725348; c=relaxed/simple;
	bh=Cca7E3l30b7Vj1oZWrk8xX21a6wsjicWXd9StviIAdE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LSZIxkMFlFNOjUQnXDjoFo90v/ELXmTD41ZaMRt7UvI39piamhUJPr7gUNuYpxAVNi3GPnRy6wAoeUt9xsD75HM7Oh4nZZfuPxS+EKWc1bnagu42HFTegMg5CEmftmCoysgn017xcv/r/YX+Mpt6HW+4n7vs7y2eitXwEdPzjwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kX8Ch05Z; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5906843AD1;
	Tue, 15 Apr 2025 13:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744725339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cu9EMJfO9vfdZP93I3947Z+rnvq4H7D9JgRMmuafxvI=;
	b=kX8Ch05Z6lTZ6OHie+GrhSHws9SUNPDU7pQBiNuZSN1cVbk2IvvpMDJZdXyk1CBzke5oDD
	OfjAkkAU/78dvR7elO4v6luKExSF6EKUs8RjZ0Rz/FqQbyh7Mz4AjT8BFam6LMWgUAfXCT
	s5JNgzkYJPIs7Pyo14g9YlpRn6Oss5crzR4HAqHH/NbPkZoG7anQ8+I5labm7gm4eQka/+
	0SI3qvjbZy/zT3ZkiDW5KCSups8oPh4259VULNS8mwnG8RCqeROzXS+WvW0Lz/v4n2J3KV
	CXTbZ9XIP3XTLv9nLeGM4y1FkQCwJ0P0G4XDBKnfALn2zJ7YZwRH/L/WxblNgw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Subject: [PATCH v18 0/8] drm/vkms: Add support for YUV and DRM_FORMAT_R*
Date: Tue, 15 Apr 2025 15:55:31 +0200
Message-Id: <20250415-yuv-v18-0-f2918f71ec4b@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFNl/mcC/23US5KbMBAG4Ku4WIekuyW1pFnlHqks9IypsnECN
 jVTU3P3iIcDE9iB6I8W+iXeqz51Teqrl9N71aWh6ZtbW27QfDlV4ezaX6luYhmoCEgCAdZvj6F
 GIXS0EK3SXJVK7/pU+8614Vxq28flUgZ/dyk3r9O7f/ws9+emv9+6t6nVgOPo55cOWEMtghOaM
 2kW9N3fbvdL034Nt+vYZapWyHO1KdUhm8jZsBSQPlWP/Qba9CAxKyrKOfaJDGnv9V6JrVp6iaJ
 yZqYM1sro90quSoCclSxKl1YumGS1FXulNgqXGaqiEiMEH0FkRXvFq5JgZ8VFxYRBaTI5atgrv
 Sr17KXHFTeQbM4pKDjoZVdlgGZliwLjNDCzTch7hbBlyxSxqBqdDpolMueDtcfNtrACFjfuC+n
 REfuQgz3qt0aNAHpxY9aAAV10XL7PHLg1bEQ0ixvTdgFilEhWHSWAcuNoWRaUU3IcjYhkIoQDt
 waOJJ7bfkq8zNF7AWTS0ff9i1wB0tONmTvGbJUru1IczVOvjp7bEsfUbWASxkAE9988P+aj26U
 /j/I3uM/ndz7h5fm1ub+cYnetr00fvj0v6ja93gv9+AukUNRoUAQAAA==
X-Change-ID: 20240201-yuv-1337d90d9576
To: Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, rdunlap@infradead.org, 
 arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>, 
 pekka.paalanen@haloniitty.fi, Simona Vetter <simona@ffwll.ch>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com, 
 nicolejadeyee@google.com, linux-doc@vger.kernel.org, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2835;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=Cca7E3l30b7Vj1oZWrk8xX21a6wsjicWXd9StviIAdE=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBn/mVWpH/Ab0PBccxHCAljOGT2Cotvfrf8um9Ku
 57oeo/9vkiJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ/5lVgAKCRAgrS7GWxAs
 4qYDD/wPgbMcg0OrOqnKaYvugT4Qf3Y3vWm4qVOqihduHRw2uSfxDwdWyYaYOVw5a4WedtgER1a
 dlcYoPmMgGFrZ0TPvcc4Fqvy62hP9YmDPin+4i7xdv5ZtBgESvYuWBDMhFFsC6btlmjgMQNfeEJ
 6OTxqaVRarIiDjIBdlVvTkbg0B/AjHpStHtKAuuhSvX3aIE2/xp6FE7roiy03BbfQnSsG7c1UfM
 T3KVegFePXAzk29YSpEu38SU2vV/Mq3uC+1C8WnsJNvk0Hu6xWn6awUiLX/hjddCyrtAI9SUvHg
 1tM3Kd0baUIEiyxIlqeobyPSCDGGCtLw3KklPaBRpCLdN9I4sRCaafZtxKVKZRNRqVGO2FEilRr
 OAKUmgFWuZuJewGXX0aeZaWLBno8Xi8tbHaUdLk0fGqVoGSfxhCrFymufzCNjFmDU5yhsghHIHG
 ldz8i1/nCN2fMJzEHRqACUR3GKU9DyB5z6UY5jP3U/Uy06UTLMb1rmlEh3mjFxS8AexqzEHUOrV
 tkFz9eAX7ICPot0rhnu2FNzoRk0oBae2kxW/U+hD3aFaJMm5rgg34WYsRcif20rhsfx+7RBqIE1
 vRPuW2G8vM4Y6Hq0915MZtrixOBpSJQWHLujdUOkSPgteSGdtkjrIiR/FnmUAOwEJFpa3vZjNYf
 fmh4Hn94XLM05Cw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefieejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomhepnfhouhhishcuvehhrghuvhgvthcuoehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejleduffeikeefkeejvdejffffueevfeeigefhiefhudegkefhjeejvefhvdefjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludejvddrudekrddtrddungdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedviedprhgtphhtthhopehsihhmohhnrgdrvhgvthhtvghrsehffhiflhhlrdgthhdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepmhgrihhrrggtrghnrghlsehrihhsvghup
 hdrnhgvthdprhgtphhtthhopehnihgtohhlvghjrgguvgihvggvsehgohhoghhlvgdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepmhgrrhgthhgvuhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhoshgvrdgvgihpohhsihhtohekleesghhmrghilhdrtghomh
X-GND-Sasl: louis.chauvet@bootlin.com

This patchset is extracted from [1]. The goal is to introduce the YUV
support, thanks to Arthur's work.

- PATCH 2: Document pixel_arbg_u16
- PATCH 3: Add the support of YUV formats
- PATCH 4: Add some drm properties to expose more YUV features
- PATCH 5: Cleanup the todo
- PATCH 6..7: Add some kunit tests
- PATCH 8: Add the support of DRM_FORMAT_R1/2/4/8

[1]: https://lore.kernel.org/r/20241007-yuv-v12-0-01c1ada6fec8@bootlin.com

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
Changes in v18:
- Add PATCH 1
- Add documentation around pixel_yuv_u8
- Link to v17: https://lore.kernel.org/r/20250204-yuv-v17-0-9c623880d0ac@bootlin.com

Changes in v17:
- Rebased on drm-msic-next
- Updated comment in kunit test
- Updated test count in kunit test
- Link to v16: https://lore.kernel.org/r/20250121-yuv-v16-0-a61f95a99432@bootlin.com

Changes in v16:
- Rebased on drm-misc-next
- Updated comment and changed fail thresholds. 
- Link to v15: https://lore.kernel.org/r/20241231-yuv-v15-0-eda6bb3028e6@bootlin.com

Changes in v15:
- Export drm_get_color_encoding_name only for kunit tests
- Link to v14: https://lore.kernel.org/r/20241122-yuv-v14-0-e66d83d28d0c@bootlin.com

Changes in v14:
- Rebased on drm-misc-next
- Link to v13: https://lore.kernel.org/r/20241118-yuv-v13-0-ac0dd4129552@bootlin.com

Changes since previous series:
 - Fix build test as modules issue: https://lore.kernel.org/all/202410110407.EHvadSaF-lkp@intel.com/
 - Export required symbols in DRM core to use them in kunit
 - Update the kunit comments according to Maxime's feedback
 - Link to original series: https://lore.kernel.org/r/20241007-yuv-v12-0-01c1ada6fec8@bootlin.com

---
Arthur Grillo (5):
      drm/vkms: Add YUV support
      drm/vkms: Add range and encoding properties to the plane
      drm/vkms: Drop YUV formats TODO
      drm/vkms: Create KUnit tests for YUV conversions
      drm/vkms: Add how to run the Kunit tests

Louis Chauvet (3):
      drm/vkms: Document pixel_argb_u16
      drm: Export symbols to use in tests
      drm/vkms: Add support for DRM_FORMAT_R*

 Documentation/gpu/vkms.rst                    |  15 +-
 drivers/gpu/drm/drm_color_mgmt.c              |   3 +
 drivers/gpu/drm/vkms/tests/Makefile           |   1 +
 drivers/gpu/drm/vkms/tests/vkms_format_test.c | 280 +++++++++++++++
 drivers/gpu/drm/vkms/vkms_drv.h               |  35 ++
 drivers/gpu/drm/vkms/vkms_formats.c           | 467 +++++++++++++++++++++++++-
 drivers/gpu/drm/vkms/vkms_formats.h           |   9 +
 drivers/gpu/drm/vkms/vkms_plane.c             |  29 +-
 8 files changed, 835 insertions(+), 4 deletions(-)
---
base-commit: 81f6e0e0f3505809dd78eab129106f1c0cf2baf1
change-id: 20240201-yuv-1337d90d9576

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


