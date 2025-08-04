Return-Path: <linux-kernel+bounces-754614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448C8B19A1A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 04:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF6D63B392E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 02:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48E61FE47C;
	Mon,  4 Aug 2025 02:14:10 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0027BA3D;
	Mon,  4 Aug 2025 02:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754273650; cv=none; b=O976AF024ONKXdhedQO52AJr+4rlULqjjMb7DsYp3Os1Cixbozos0cgZEeLjrfpnNLAg6LBdGYPjd3K2QFIY50PLmVG38HjwT5aatvFsQubXXaGiPIYOU5BYMKCyykLADofMlc5p3KY8tcXAbOor8OX1WtrOcOog3EHlOzWa468=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754273650; c=relaxed/simple;
	bh=WZG/25/2PwRokdOdDSxWnIPRrCKihV0abcBOwtEpyLs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cb5/YtVaVt0DByPVdZzkXy4UhsjTvcWEwvm8EGklTfm2vnr3oZZlYYFMJe65VZNcDQCa64+Uvw9PlojszLC5YfoDQyJk6u5XNqp9XoX3iqPkR4GDTVBg7pCyDWME1B+9YOrcSVkdPet3qcHXwZlBYoyJbOPpGUlmntD6+VPkuy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 707AE2001E6;
	Mon,  4 Aug 2025 04:08:00 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 28448200352;
	Mon,  4 Aug 2025 04:08:00 +0200 (CEST)
Received: from lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com (lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com [10.52.9.99])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5C22818000AB;
	Mon,  4 Aug 2025 10:07:57 +0800 (+08)
From: Joseph Guo <qijian.guo@nxp.com>
Subject: [PATCH v2 0/3] Add support for Waveshare DSI2DPI unit
Date: Mon, 04 Aug 2025 11:07:39 +0900
Message-Id: <20250804-waveshare-v2-0-0a1b3ce92a95@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOsVkGgC/03MSw7CIBSF4a00dyyGR9DiyH2YDihchIHQgMGah
 r2LTUwc/icn3wYFc8ACl2GDjDWUkGIPfhjAeB3vSILtDZxySc9MkpeuWLzOSKy2SqBWaqQO+n/
 J6MK6W7eptw/lmfJ7pyv7rj/l9KdURigZmZmpcDOXWlzjuhxNesDUWvsAgow9yaAAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754273277; l=1009;
 i=qijian.guo@nxp.com; s=20250519; h=from:subject:message-id;
 bh=WZG/25/2PwRokdOdDSxWnIPRrCKihV0abcBOwtEpyLs=;
 b=euJjIK7soNMUx2lCG9yR+87sYQ9cweH6+IJQhd5b8aLCVZwhI9mf3yHB78YflsBtrowQ3ioRC
 96bhFj/M3DEDfzMVbgEizqhQ00dB/CD+2xmaClo5NbHilgxiDNhrkdA
X-Developer-Key: i=qijian.guo@nxp.com; a=ed25519;
 pk=VRjOOFhVecTRwBzK4mt/k3JBnHoYfuXKCm9FM+hHQhs=
X-Virus-Scanned: ClamAV using ClamSMTP

This patchset add support for waveshare DSI2DPI unit.

Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
---
Changes in v2:
- /s/i2c0/i2c/ in patch 1
- Add Review tags
- Link to v1: https://lore.kernel.org/r/20250716-waveshare-v1-0-81cb03fb25a3@nxp.com

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


