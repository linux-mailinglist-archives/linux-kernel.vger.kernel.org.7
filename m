Return-Path: <linux-kernel+bounces-752356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C75B17492
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8761C2168D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25C7239E94;
	Thu, 31 Jul 2025 16:02:57 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD964225A31;
	Thu, 31 Jul 2025 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977777; cv=none; b=Rl9myMeCKyobmW51wTmgIujl7gtZqwTUspmOslZICDmJBM4DOY7F7A5BViWXj1QwqDF+47c4n43JPPiNSBVZYS9EcCak4vd0QqFrSsStb2CbyKtNiGzgVDD1tX+6We9JqfV+eRl+ReP5ZFUC8ukvZFZ9tUm9R04Jn9YovKlYgbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977777; c=relaxed/simple;
	bh=bOPrwtBTpQZLmmiel5xVbSk4yYoExcAAVrJns2Gto2c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qYysBJpqZUIBow8Cl+jvftEKw7EMHi/L+geD2bPCko61NP+kit9l2Js2H4+wDEgOhgsbpdq5rqx70NoG7rSbciMwKQ6I0XKo1NCTxEUOc8pfVNxmYgpXryyII2piR+wlwn6IfSXZUECSm4w5Zh0XPlazU63Ykz0avRDTJgVCP5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 2DB5D1C270D;
	Thu, 31 Jul 2025 17:52:51 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdc9:0:1347:874c:9851:58c6])
	by srv01.abscue.de (Postfix) with ESMTPSA id E36DF1C26E9;
	Thu, 31 Jul 2025 17:52:49 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Subject: [PATCH v3 00/16] drm: sprd: Make the Unisoc DRM driver usable on
 UMS9230
Date: Thu, 31 Jul 2025 17:51:13 +0200
Message-Id: <20250731-ums9230-drm-v3-0-06d4f57c4b08@abscue.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPGQi2gC/22PQQ6CMBBFr0JmbU07LSKuvIdxQdtBugC0hUZDu
 LsFXUji8k3yXv5MEMg7CnDKJvAUXXB9l0DuMjBN1d2IOZsYkGPOC1GysQ0lSs6sbxlpLAQeS10
 bC8m4e6rdc61drokbF4bev9Z4FMv1fycKxhkpqVTFc9LSnisdzEh7S7B0Iv64iFsXk8tzhcWBD
 IqtO39GeXqM6bPhu2ye36h+Orv3AAAA
X-Change-ID: 20250719-ums9230-drm-eb271289bfcd
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Kevin Tang <kevin.tang@unisoc.com>, 
 Liviu Dudau <Liviu.Dudau@arm.com>, 
 Russell King <rmk+kernel@arm.linux.org.uk>, Eric Anholt <eric@anholt.net>, 
 Kevin Tang <kevin3.tang@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2

Fix some existing bugs that prevent the driver from working properly
and adapt the platform-specific code to support the UMS9230 SoC.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
Changes in v3:
- Split the device tree clock name change into a separate patch
- Add Fixes tags for all patches that fix something
- Open-code drm_simple_encoder_init()
- Use devm_drm_bridge_alloc for bridge allocation
- To account for the new atomic commit order, do not rely on the DPU
  being initialized during pre_enable
- Correct remaining uses of drm_gem_dma/drm_fb_dma to use the custom
  buffer object type
- Return the sgtable instead of 0 in sprd_gem_object_get_sgtable when
  the IOMMU is not in use
- Reword some commit messages
- Link to v2: https://lore.kernel.org/r/20250722-ums9230-drm-v2-0-054276ec213d@abscue.de

Changes in v2:
- Fix device tree binding syntax
- Use more descriptive clock names
- Keep IOMMU handle in DPU node and make the driver handle this instead
  (otherwise the binding turns out to be incorrect for newer hardware)
- Remove all accesses to IOMMU registers from the DPU driver (after
  observing that sharkl3 can also use sprd_iommu, I concluded that they
  should not be needed at all)
- Fix container_of macros in sprd_dsi.h
- Link to v1: https://lore.kernel.org/r/20250719-ums9230-drm-v1-0-e4344a05eb3d@abscue.de

---
Otto Pflüger (16):
      dt-bindings: display: sprd: adapt for UMS9230 support
      dt-bindings: display: sprd: use more descriptive clock names
      dt-bindings: display: sprd: add memory-region property
      dt-bindings: display: sprd: allow attaching a DSI panel
      drm: of: try binding port parent node instead of the port itself
      drm: sprd: remove plane and CRTC destroy callbacks
      drm: sprd: register a DSI bridge and initialize in pre_enable
      drm: sprd: add support for UMS9230 DSI PLL
      drm: sprd: fix DSI rate and PLL setup code
      drm: sprd: select REGMAP in Kconfig
      drm: sprd: add clock gating support
      drm: sprd: add support for newer DPU versions
      drm: sprd: always initialize DPU registers
      drm: sprd: do not access IOMMU registers
      drm: sprd: implement IOMMU-based buffer management
      drm: sprd: add fbdev support

 .../bindings/display/sprd/sprd,sharkl3-dpu.yaml    |  32 +-
 .../display/sprd/sprd,sharkl3-dsi-host.yaml        |  42 ++-
 drivers/gpu/drm/drm_of.c                           |   2 +-
 drivers/gpu/drm/sprd/Kconfig                       |   3 +
 drivers/gpu/drm/sprd/Makefile                      |   3 +-
 drivers/gpu/drm/sprd/megacores_pll.c               |  28 +-
 drivers/gpu/drm/sprd/sprd_dpu.c                    |  72 +++--
 drivers/gpu/drm/sprd/sprd_dpu.h                    |   1 +
 drivers/gpu/drm/sprd/sprd_drm.c                    |  57 +++-
 drivers/gpu/drm/sprd/sprd_drm.h                    |  10 +
 drivers/gpu/drm/sprd/sprd_dsi.c                    | 221 ++++++++-----
 drivers/gpu/drm/sprd/sprd_dsi.h                    |  20 +-
 drivers/gpu/drm/sprd/sprd_gem.c                    | 343 +++++++++++++++++++++
 drivers/gpu/drm/sprd/sprd_gem.h                    |  34 ++
 14 files changed, 727 insertions(+), 141 deletions(-)
---
base-commit: 84b92a499e7eca54ba1df6f6c6e01766025943f1
change-id: 20250719-ums9230-drm-eb271289bfcd

Best regards,
-- 
Otto Pflüger <otto.pflueger@abscue.de>

