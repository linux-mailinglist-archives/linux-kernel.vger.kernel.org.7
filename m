Return-Path: <linux-kernel+bounces-855749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D08BE22EF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BADD919A5FA8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1877A2FF14D;
	Thu, 16 Oct 2025 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IXvHAR7f"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE183301028;
	Thu, 16 Oct 2025 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760604004; cv=none; b=amYmGcEsXAp4WE3w0avzVpY2aXYScFFs8yDrF0rQHK8mK4dO7LHem8XQSOEg/PpNenMk8vlXsrHG5+Hjjnx0jYwLBI3SVejj1mnU+4jRBMfZPXPejen47AjEzTY1C7gSaBNP5fVDTCLm3p6bjCatuzwaqql7wAv8oxx71i8oTps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760604004; c=relaxed/simple;
	bh=rx01UHCPmxoC5Jtx5T79SkI8RPRyscxgiyj1ajOTjyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FTSr48Iyw1HaL2a2CBIe7fHQaVprk6ZsCmFQXsH34ATDAnTRzjV/LbzL0uvylGYmDkj/XmDUjxYfWG4fcj9Djuk1N9yCWdyBfGgmr1MKPVQDvRRxYaFJsgKbXxJiifCj4bk/+R4ncza6rNhH4Oi3U3zDjk5akc/Z+50GHaYEJ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IXvHAR7f; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=RS
	vYSPh8ZvpCq9Tn8rRo74pwoQsk+cPXDxtofOd/xlQ=; b=IXvHAR7fi2TAsfLHVn
	2fLAddoDQPJpeHz+Hc0NSWLC+xBmv3zguiE5uAvUltBapI4Q7QDPwqAvtxclmPkb
	HySd+GNCk9SREAlplFQSf1P2d3GRAx/h2mwx0FMk4yAhZlqMIDPv4A3aCVKxsnZo
	zaVlOiK6ME/Ndg+TjBzMX2h+Y=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wC3f_8Ur_BoSVKcAg--.8978S2;
	Thu, 16 Oct 2025 16:38:48 +0800 (CST)
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
Subject: [PATCH v8 0/2] Convert inno hdmi to drm bridge
Date: Thu, 16 Oct 2025 16:38:30 +0800
Message-ID: <20251016083843.76675-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3f_8Ur_BoSVKcAg--.8978S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF4fZw1rGr4xKr48KrWDCFg_yoW8uF4kpa
	yjyrW5GF47uF1jgFs2kF1fAr1Syan8Jw4S9ryxX34SvFW29F15Aws29F4Yqr9rZr47CFsF
	yrn7Ja47KFy7ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jv_M3UUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEg7oXmjwqwOGzAAAsQ

From: Andy Yan <andy.yan@rock-chips.com>


Convert it to drm bridge driver, it will be convenient for us to
migrate the connector part to the display driver later.

Patches that have already been merged in drm-misc-next are dropped.


Changes in v8:
- Rebase on latest drm-misc-next tag: drm-misc-fixes-2025-10-09
- Link to v7: https://lore.kernel.org/linux-rockchip/20250903110825.776807-1-andyshrk@163.com/

Changes in v7:
- Rebase on latest drm-misc-next
- Link to v6: https://lore.kernel.org/linux-rockchip/20250717081344.1355613-1-andyshrk@163.com/

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
 .../inno_hdmi.c => bridge/inno-hdmi.c}        | 501 +++++-------------
 drivers/gpu/drm/rockchip/Kconfig              |   1 +
 drivers/gpu/drm/rockchip/Makefile             |   2 +-
 drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c | 189 +++++++
 include/drm/bridge/inno_hdmi.h                |  33 ++
 8 files changed, 375 insertions(+), 367 deletions(-)
 rename drivers/gpu/drm/{rockchip/inno_hdmi.c => bridge/inno-hdmi.c} (69%)
 create mode 100644 drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c
 create mode 100644 include/drm/bridge/inno_hdmi.h

-- 
2.43.0

base-commit: 21f0c9e6d2835608c3b46ab47d84e341fc7749fc
branch: rk3036_hdmi_bridge_v8


