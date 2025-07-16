Return-Path: <linux-kernel+bounces-733000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBDCB06E9D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7341AA0330
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D35D28B3EF;
	Wed, 16 Jul 2025 07:14:10 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFFC2AE8E;
	Wed, 16 Jul 2025 07:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752650049; cv=none; b=d9z4/G8fYRrez5B3tfPAFuQIv4B9Qf3mjIqpq2n2FSolgrFUcVwCLhh1fcathDtUKF/B6FlniJ5qdaDDOAfGne2SlwSE1XzEDivrSfpi/r62OVLxHy0YZBJILIcdEL09DhOzM9W5lOcZDJAIUzSBcAje3tsY/xkaVxj0KElaRNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752650049; c=relaxed/simple;
	bh=OdjFV4Da49UyANDx5Zs6+ny76E7tQ6udO5ABaWWRO1c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t3t/ZGgXGEv5ITKOGOlmGItVFoqyFQsy+pMo8DzZbVn54wbza/VBKA8IPC8Dl81Rnt4pHjL+njp+j+yo4vok9JjQ7zd8ZPfnrLKHH0HGsqF8XP+djtfUd3gxigJnYIB1z26trdTM335O9W6nItc3bY4knqfoHTixAqJagamm9Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DB39F2001E1;
	Wed, 16 Jul 2025 09:08:36 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9D5C9200B37;
	Wed, 16 Jul 2025 09:08:36 +0200 (CEST)
Received: from lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com (lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com [10.52.9.99])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E71561800079;
	Wed, 16 Jul 2025 15:08:33 +0800 (+08)
From: Joseph Guo <qijian.guo@nxp.com>
Subject: [PATCH 0/3] Add support for Waveshare DSI2DPI unit
Date: Wed, 16 Jul 2025 16:08:28 +0900
Message-Id: <20250716-waveshare-v1-0-81cb03fb25a3@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOxPd2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0NT3fLEstTijMSiVN2UxBRL49RES0sLgzQloPqCotS0zAqwWdGxtbU
 Aq7B8l1sAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752649713; l=854;
 i=qijian.guo@nxp.com; s=20250519; h=from:subject:message-id;
 bh=OdjFV4Da49UyANDx5Zs6+ny76E7tQ6udO5ABaWWRO1c=;
 b=dFmTX6CnIiz0H4eUaP42VVOKSrAUs4SnC2eUjskbX6n4/VzZbowRDx2cRRF8thT9VCRS3Bs1Y
 lpyt2+uIa4QAcWt2Bo3Uv6kp4ErEz6+B14xgSFvjBF1ISGUf8RevTe/
X-Developer-Key: i=qijian.guo@nxp.com; a=ed25519;
 pk=VRjOOFhVecTRwBzK4mt/k3JBnHoYfuXKCm9FM+hHQhs=
X-Virus-Scanned: ClamAV using ClamSMTP

This patchset add support for waveshare DSI2DPI unit.

Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
---
Joseph Guo (3):
      dt-bindings: display: bridge: Add waveshare DSI2DPI unit support
      dt-bindings: display: panel: Add waveshare DPI panel support
      drm: bridge: Add waveshare DSI2DPI unit driver

 .../bindings/display/bridge/waveshare,dsi2dpi.yaml | 103 ++++++++++
 .../bindings/display/panel/panel-simple.yaml       |   4 +
 drivers/gpu/drm/bridge/Kconfig                     |  11 ++
 drivers/gpu/drm/bridge/Makefile                    |   1 +
 drivers/gpu/drm/bridge/waveshare-dsi.c             | 210 +++++++++++++++++++++
 5 files changed, 329 insertions(+)
---
base-commit: 0952d89c3acf6590b89bcfb8505595d7c0e6f367
change-id: 20250715-waveshare-dad93ea9980f

Best regards,
-- 
Joseph Guo <qijian.guo@nxp.com>


