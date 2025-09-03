Return-Path: <linux-kernel+bounces-798349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D80B41CC2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA764682015
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EF22F5493;
	Wed,  3 Sep 2025 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ayNngg9L"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7831F2F4A0B;
	Wed,  3 Sep 2025 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756897783; cv=none; b=cwYm9qT3wLInpgzAJzi2ZaX3gGHcS88aQ9zEkgE5k75jRjMWaeM2otODLMT7ZcIRXPF81RiOV6wtmhqvYQ4uiTFZr62OAkrvoPyi2/1aL43PwXfgv4qmrp/IamuqRXdrVEGYBxoCqvpy6iG3UtyfM1zq58xiFaKB6hyqi7Ts2G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756897783; c=relaxed/simple;
	bh=aVowwG1ZBVwA0aLrNVMbHmdp7kYOcQTCuE9qbXA0IhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cJXi/PwQ+O23vKR/f6jHnDzPkrWmeoxbZ7D5bJJBl3EcWVWdxAVzB8DZXOIEK6j/lCG95lCMhwDbCm8EXQVBVHHY4EwGgON2Zhft4A3CxTccwnRqwWj1jfZKdoSFloXbsRVj+vYLj6caI3FHCAseKt0gYmhy0JzEjxsLjC7z/04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ayNngg9L; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=8M
	OUPpxvBzRqyAiJo7hZF/8jlxk1AL8PcT2GXnQjst8=; b=ayNngg9LBaRM4vEZ7p
	Y0SroSRdLTxuXYo4rfV0S/kZgHUSRdIBxPsaWZSItpjp7yn199vazYxL0Jv8/fHT
	tNZSLUJjMMNjO+Tr0UUCy0k0snpG64jJei4XDblwNedAYb7VOX66k1kYVlNzJ41+
	Ey9SHtOCPS2gC6pt/IeN0A94M=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wC3ZLuqIbhoXAZsFw--.3268S2;
	Wed, 03 Sep 2025 19:08:32 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: dmitry.baryshkov@oss.qualcomm.com,
	heiko@sntech.de
Cc: mripard@kernel.org,
	neil.armstrong@linaro.org,
	andrzej.hajda@intel.com,
	jernej.skrabec@gmail.com,
	jonas@kwiboo.se,
	Laurent.pinchart@ideasonboard.com,
	maarten.lankhorst@linux.intel.com,
	rfoss@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	knaerzche@gmail.com,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v7 0/2] Convert inno hdmi to drm bridge
Date: Wed,  3 Sep 2025 19:07:37 +0800
Message-ID: <20250903110825.776807-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3ZLuqIbhoXAZsFw--.3268S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF4fZw1rGr1fWF4xCF4DArb_yoW8Zr1Upa
	yjkFW5CF47u3W2gFs7CF4fAr1Sya1DJw4S9ry7X34SvFW29F15Awna9F4aqrnrZr47CF42
	yrZ7Ja47KFy7ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jf3kZUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEBe9Xmi4H7lERwABsQ

From: Andy Yan <andy.yan@rock-chips.com>


Convert it to drm bridge driver, it will be convenient for us to
migrate the connector part to the display driver later.

Patches that have already been merged in drm-misc-next are dropped.


Changes in v7:
- Rebase on latest drm-misc-next
- Link to V6: https://lore.kernel.org/linux-rockchip/20250717081344.1355613-1-andyshrk@163.com/

Changes in v6:
- Rebase on latest drm-misc-next
- Link to V5: https://lore.kernel.org/linux-rockchip/20250512124615.2848731-1-andyshrk@163.com/

Changes in v5:
- Split cleanup code to seperate patch
- Switch to devm_drm_bridge_alloc() API
- Link to V4: https://lore.kernel.org/linux-rockchip/20250422070455.432666-1-andyshrk@163.com/

Changes in v4:
- Do not store colorimetry within inno_hdmi struct
- Link to V3: https://lore.kernel.org/linux-rockchip/20250402123150.238234-1-andyshrk@163.com/

Changes in v3:
- First included in v3
- Link to V2: https://lore.kernel.org/dri-devel/20250325132944.171111-1-andyshrk@163.com/

Andy Yan (2):
  drm/rockchip: inno-hdmi: Convert to drm bridge
  MAINTAINERS: Add entry for Innosilicon hdmi bridge library

 MAINTAINERS                                   |   8 +
 drivers/gpu/drm/bridge/Kconfig                |   7 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 .../inno_hdmi.c => bridge/inno-hdmi.c}        | 502 +++++-------------
 drivers/gpu/drm/rockchip/Kconfig              |   1 +
 drivers/gpu/drm/rockchip/Makefile             |   2 +-
 drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c | 188 +++++++
 include/drm/bridge/inno_hdmi.h                |  33 ++
 8 files changed, 374 insertions(+), 368 deletions(-)
 rename drivers/gpu/drm/{rockchip/inno_hdmi.c => bridge/inno-hdmi.c} (69%)
 create mode 100644 drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c
 create mode 100644 include/drm/bridge/inno_hdmi.h

-- 
2.43.0

base-commit: 021ec46a5795eaf39f80c116704861cacf04c8b2
branch: rk3036_hdmi_bridge_v7


