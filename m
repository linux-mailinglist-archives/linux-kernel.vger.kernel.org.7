Return-Path: <linux-kernel+bounces-741034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C40D8B0DF3C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EDDF1898A1F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A2E2EAD1A;
	Tue, 22 Jul 2025 14:41:52 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879BB2EAB6B;
	Tue, 22 Jul 2025 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195311; cv=none; b=OKjA5AzbBnq68qkDmBmhah1zpjV91Wd5riyHBaY8mGqB1hOc8K73rHN8deEuIy01Q+dEjIQZBmxurrXO+kX+6u4CDVps4LPntIhPygFtNjfzWHo/rasV7/yYVAfsJCfirdx5EdjjCC5cP9jgERLA+qCxOhSmLS60qqTtn9crY20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195311; c=relaxed/simple;
	bh=lLCQ9DN5jxx8xkYkL6TPkCAQmSunVMyrNLMrh9FZD7I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rKyaZOaTNMVqPqFJzZZb19IGe4f16d4Mm3N+BSYdEvOVTJ+O/OfPUOp5VKmvuTqDv/jbOPbVufI/qyJSvyUD0J1uuIJG5PMFk4W5T+ZrgYiFouYXPjQScGxb5w6N/e4V/xSvSnRg4Eidqlq6S+VqyU9B/MwRBzhxgzGQrGNUsbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 8ECF41C025F;
	Tue, 22 Jul 2025 16:41:36 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdcb:3c00:ce39:8bff:5db4:1ef8])
	by srv01.abscue.de (Postfix) with ESMTPSA id 6CA261C00FF;
	Tue, 22 Jul 2025 16:41:35 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Subject: [PATCH v2 00/15] drm: sprd: Make the Unisoc DRM driver usable on
 UMS9230
Date: Tue, 22 Jul 2025 16:41:02 +0200
Message-Id: <20250722-ums9230-drm-v2-0-054276ec213d@abscue.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAP+if2gC/23Oy26DMBCF4VdBXtdoxsbhoqrKe1RZ+DIkVgJub
 aANUd69Dmy7PCPNp//BEkVPiXXFg0VafPJhzEO8Fcxe9Hgm7l3eTIBQUGPL5yG1QgJ3ceBkRI2
 iaU1vHcsfX5F6/7tpn6e8Lz5NId43fMHX9X9nQQ6cKllVGhQZ6Y7aJDtT6Yidnjsc6XvOddOus
 4FS0ltdV7zvqADMIMhS1oeD4JJf43pP6xT68hrWW/hJV3+8+VHHUIZ4/ngVG52I2zAMfuoKUNo
 ZIqmdEg0CaAOiURaVbTFPwpYQUDa56fkHQQ7JczkBAAA=
X-Change-ID: 20250719-ums9230-drm-eb271289bfcd
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Kevin Tang <kevin.tang@unisoc.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
X-Mailer: b4 0.14.2

Fix some existing bugs that prevent the driver from working properly
and adapt the platform-specific code to support the UMS9230 SoC.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
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
Otto Pflüger (15):
      dt-bindings: display: sprd: adapt for UMS9230 support
      dt-bindings: display: sprd: add memory-region property
      dt-bindings: display: sprd: allow attaching a DSI panel
      drm: of: try binding port parent node instead of the port itself
      drm: sprd: remove plane and crtc destroy callbacks
      drm: sprd: register a DSI bridge and move init code to pre_enable
      drm: sprd: add support for UMS9230 DSI PLL
      drm: sprd: fix DSI rate and PLL setup code
      drm: sprd: select REGMAP in Kconfig
      drm: sprd: add clock gating support
      drm: sprd: add support for newer DPU versions
      drm: sprd: always initialize DPU and DSI registers
      drm: sprd: do not access IOMMU registers
      drm: sprd: implement IOMMU-based buffer management
      drm: sprd: add fbdev support

 .../bindings/display/sprd/sprd,sharkl3-dpu.yaml    |  32 +-
 .../display/sprd/sprd,sharkl3-dsi-host.yaml        |  42 ++-
 drivers/gpu/drm/drm_of.c                           |   2 +-
 drivers/gpu/drm/sprd/Kconfig                       |   3 +
 drivers/gpu/drm/sprd/Makefile                      |   3 +-
 drivers/gpu/drm/sprd/megacores_pll.c               |  28 +-
 drivers/gpu/drm/sprd/sprd_dpu.c                    |  62 ++--
 drivers/gpu/drm/sprd/sprd_dpu.h                    |   1 +
 drivers/gpu/drm/sprd/sprd_drm.c                    |  57 +++-
 drivers/gpu/drm/sprd/sprd_drm.h                    |  10 +
 drivers/gpu/drm/sprd/sprd_dsi.c                    | 181 +++++++----
 drivers/gpu/drm/sprd/sprd_dsi.h                    |  19 +-
 drivers/gpu/drm/sprd/sprd_gem.c                    | 343 +++++++++++++++++++++
 drivers/gpu/drm/sprd/sprd_gem.h                    |  34 ++
 14 files changed, 697 insertions(+), 120 deletions(-)
---
base-commit: 05adbee3ad528100ab0285c15c91100e19e10138
change-id: 20250719-ums9230-drm-eb271289bfcd
prerequisite-message-id: <20250720123003.37662-3-krzysztof.kozlowski@linaro.org>
prerequisite-patch-id: da2f2d2034f4b3fd5ffea122a6d0df20cb68fb88
prerequisite-patch-id: 2ccbc6b30bb53f303470b2a8376df4356e8785a3

Best regards,
-- 
Otto Pflüger <otto.pflueger@abscue.de>

