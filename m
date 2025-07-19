Return-Path: <linux-kernel+bounces-737729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F125B0AFDC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 14:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92DE2566FAF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 12:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5A228725B;
	Sat, 19 Jul 2025 12:20:42 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44732285CAA;
	Sat, 19 Jul 2025 12:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752927642; cv=none; b=EC9dgyXXeaV6G8BeobeXXogiJmIVcuaY5bhMC3iinoA8OsjS+KVHa0Mh3Fn2oFNw0+Fy7VLzUM/2Ei3cTHWwus2Y7bj+k+IROe51LlNdOxGlwd/32gRQxzgfqdeDxKOc6YaBc04qYtPhRwIeqIEjLrOj9T37N0Xe0QuQJVmVok0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752927642; c=relaxed/simple;
	bh=8xHg4j6fAJxIbe7Jm9FYEWam7oyIbUHvrcC5ja2UNe8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n5a8lzMgEkGNRDCqeqw6+G7RTi3h1LEbyFPKaso74zM4tWkFj9JxBf7bkEm1dfuNrhTndJTvACKApQrv3zyUopyb+Obgar0ywl7lBNfqTms2kDT02pdLfrFeVUY3VJwH5yi3jYmuQzPbDMjmq2CMHAMJm5DhXa9tRG/V26ELSXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id DCEA91C025E;
	Sat, 19 Jul 2025 14:11:27 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdf7:4000:ceae:3606:9020:cd4f])
	by srv01.abscue.de (Postfix) with ESMTPSA id 403C31C00FF;
	Sat, 19 Jul 2025 14:11:27 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Subject: [PATCH 00/12] drm: sprd: Make the Unisoc DRM driver usable on
 UMS9230
Date: Sat, 19 Jul 2025 14:09:36 +0200
Message-Id: <20250719-ums9230-drm-v1-0-e4344a05eb3d@abscue.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAACLe2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0NL3dLcYksjYwPdlKJc3dQkI3NDIwvLpLTkFCWgjoKi1LTMCrBp0bG
 1tQApQRWKXQAAAA==
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
Otto Pflüger (12):
      dt-bindings: display: sprd: adapt for UMS9230 support
      dt-bindings: display: sprd: allow attaching a DSI panel
      drm: of: try binding port parent node instead of the port itself
      drm: sprd: remove plane and crtc destroy callbacks
      drm: sprd: register a DSI bridge and move init code to pre_enable
      drm: sprd: add support for UMS9230 DSI PLL
      drm: sprd: fix DSI rate and PLL setup code
      drm: sprd: add gate clock support
      drm: sprd: add support for newer DPU versions
      drm: sprd: always initialize DPU and DSI registers
      drm: sprd: add fbdev support
      drm: sprd: select REGMAP in Kconfig

 .../display/sprd/sprd,display-subsystem.yaml       |  11 ++
 .../bindings/display/sprd/sprd,sharkl3-dpu.yaml    |  18 +-
 .../display/sprd/sprd,sharkl3-dsi-host.yaml        |  38 +++--
 drivers/gpu/drm/drm_of.c                           |   2 +-
 drivers/gpu/drm/sprd/Kconfig                       |   3 +
 drivers/gpu/drm/sprd/megacores_pll.c               |  28 ++--
 drivers/gpu/drm/sprd/sprd_dpu.c                    |  47 ++++--
 drivers/gpu/drm/sprd/sprd_dpu.h                    |   1 +
 drivers/gpu/drm/sprd/sprd_drm.c                    |   5 +
 drivers/gpu/drm/sprd/sprd_dsi.c                    | 182 ++++++++++++++-------
 drivers/gpu/drm/sprd/sprd_dsi.h                    |  17 +-
 11 files changed, 247 insertions(+), 105 deletions(-)
---
base-commit: d086c886ceb9f59dea6c3a9dae7eb89e780a20c9
change-id: 20250719-ums9230-drm-eb271289bfcd

Best regards,
-- 
Otto Pflüger <otto.pflueger@abscue.de>

