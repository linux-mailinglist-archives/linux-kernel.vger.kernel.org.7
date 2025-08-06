Return-Path: <linux-kernel+bounces-757148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5A3B1BE54
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB2A6249E1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F3915B135;
	Wed,  6 Aug 2025 01:34:23 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9096C1FB3;
	Wed,  6 Aug 2025 01:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754444063; cv=none; b=Vud3/iorAyRc+d4Qgi4lNZlqdkE47ksSuSeo4XWjhqQpgZRIZLMgbfmwKr8a5Y4GiLRz2vn/KkjwEI9eZxDq97Ms9OQjY+wEPWBbRyeB01L/yToBFnmuOQ+Gqgoyqf6y5b+WEkdKT9PIw5XWdKwZFP/1kBlSVTeSB9OiYT3qUXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754444063; c=relaxed/simple;
	bh=YiLp2g3Wa/xrL2vYDPflDhU9boHoOXBX+CUNTEMf9UE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jLSqPY1oG98wlAup+1PMxJCzqFQs2Lej1veNwRrU5ryB4cAJJLeNmQPo7x3QNJUGSA8Eoqctmy1Op2eOqBwBiB2iwvNUAqi4R6iwThZMG0JQRebDwq6kdrnrIgiY4vnahECBmdEN5zPajY1j8J6OCMDyZdyWxXP7oER3QwhC48E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 823CB200CEF;
	Wed,  6 Aug 2025 03:34:11 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4593A200D09;
	Wed,  6 Aug 2025 03:34:11 +0200 (CEST)
Received: from lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com (lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com [10.52.9.99])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 44CEA18000AB;
	Wed,  6 Aug 2025 09:34:08 +0800 (+08)
From: Joseph Guo <qijian.guo@nxp.com>
Subject: [PATCH v3 0/3] Add support for Waveshare DSI2DPI unit
Date: Wed, 06 Aug 2025 10:33:31 +0900
Message-Id: <20250806-waveshare-v3-0-fd28e01f064f@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOuwkmgC/02MQQ6CMBBFr0Jmbc20tUpdeQ/jYiiDdCGQ1lQM4
 e4WEgPL9/PfmyBy8BzhWkwQOPno+y6DPhTgWuqeLHydGRQqgxdpxIcSx5YCi5pqq5msLbGB/B8
 CN35cW/dH5tbHdx++azrJZf1XzrtKkgJFKV2FuqmUIX3rxuHo+hcsjaQ2r8TT3lPZQ5KVdmwVW
 bN58zz/AAs8UmfYAAAA
X-Change-ID: 20250715-waveshare-dad93ea9980f
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, victor.liu@nxp.com, 
 Joseph Guo <qijian.guo@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754444047; l=1438;
 i=qijian.guo@nxp.com; s=20250519; h=from:subject:message-id;
 bh=YiLp2g3Wa/xrL2vYDPflDhU9boHoOXBX+CUNTEMf9UE=;
 b=GuJAmmlezhXETdfS2jzloyK6ffuEcmafcCpp3RbfeenpS4+ne4iOpKYlnlehU/j7VH00w7PAE
 AP5VO7mR06lCIAeRNXQ207zGDXruFXQU2WyvaI2wJaJS/+sH0JF5Zdu
X-Developer-Key: i=qijian.guo@nxp.com; a=ed25519;
 pk=VRjOOFhVecTRwBzK4mt/k3JBnHoYfuXKCm9FM+hHQhs=
X-Virus-Scanned: ClamAV using ClamSMTP

This patchset add support for waveshare DSI2DPI unit.

Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
---
Changes in v3:
- Add Suggested-by tags
- s/R-b/A-b/ in patch 2
- Sort the config names alphabetically
- Add depends on BACKLIGHT_CLASS_DEVICE
- Drop disable_debugfs in regmap_config
- Sort the variables in reverse Christmas tree
- Drop inappropriate blank line
- Drop duplicate backlight variable
- Change API to upstream version
- Link to v2: https://lore.kernel.org/r/20250804-waveshare-v2-0-0a1b3ce92a95@nxp.com

Changes in v2:
- /s/i2c0/i2c/ in patch 1
- Add Review tags
- Link to v1: https://lore.kernel.org/r/20250716-waveshare-v1-0-81cb03fb25a3@nxp.com

---
Joseph Guo (3):
      dt-bindings: display: bridge: Add waveshare DSI2DPI unit support
      dt-bindings: display: panel: Add waveshare DPI panel support
      drm: bridge: Add waveshare DSI2DPI unit driver

 .../bindings/display/bridge/waveshare,dsi2dpi.yaml | 103 +++++++++++
 .../bindings/display/panel/panel-simple.yaml       |   4 +
 drivers/gpu/drm/bridge/Kconfig                     |  12 ++
 drivers/gpu/drm/bridge/Makefile                    |   1 +
 drivers/gpu/drm/bridge/waveshare-dsi.c             | 203 +++++++++++++++++++++
 5 files changed, 323 insertions(+)
---
base-commit: ade011daf9e9e0d0180d8bc85b9abc8a67a8d489
change-id: 20250715-waveshare-dad93ea9980f

Best regards,
-- 
Joseph Guo <qijian.guo@nxp.com>


