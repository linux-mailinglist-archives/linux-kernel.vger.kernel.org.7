Return-Path: <linux-kernel+bounces-887648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B09EC38CCB
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7E3C4E59D7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB78A225A3B;
	Thu,  6 Nov 2025 02:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="Jz/mSUG8"
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9FEDF6C;
	Thu,  6 Nov 2025 02:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394870; cv=none; b=CENLxSh3NojiKr4EWY1FCyFG7bVddKkbiy+h72o4mw+4zsSt8XNaXtv33GxOYtUVtqBBLGgi4xb5LbOdUAYqtpnbN7JfKcxGLR0HNi5zWZ18mwdSFcchjd9Xa3GmNukIKPehhOVm0ySeEeu1MRBDGnEz3jdQ12vW0Yv2S0uFMRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394870; c=relaxed/simple;
	bh=8zF/BjHFJ1cgMuaYtAWliYOySD8GNNoeZhiCV/po144=;
	h=From:To:Cc:Subject:Date:Message-Id; b=CS5sk7KiwzTnxu4S9yBBEAXJLqqoXW1n/2BBjszOjD9PBMgjySFhCMkRuyIfrtx+dcDzXLyvWr6xIDXUH7n1Gr4c9A6mg847A4xrMAZgkk0NYbBWSGfaUHwBarOBTKDrrEQiOGOa4xXfxqU3Izzn4iZCS8gtxQUfqk2fo8MGz70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=Jz/mSUG8; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1762394802;
	bh=VVl1Qjus8u0aUj8+6Bj8jBGW/g0TFXzsB/9E8b+TxZM=;
	h=From:To:Subject:Date:Message-Id;
	b=Jz/mSUG81JzjgYqtmrsoGxedEs9qCq/TV7Sc5FRXH49aYam1s9LeQZBgIZnnOflhh
	 qPseJK8+qg1raZmWNV14RTkp5WXetzfinEneBxA7fTGOmK/nbrehIaVYAcDeSaWF5p
	 PibFmGR/Ox+jwiA71qcpDSQ6Gjemx2ntXzwcJ+Eo=
X-QQ-mid: esmtpgz15t1762394799t86ae74a2
X-QQ-Originating-IP: yhNbobLVwNbY5V1jr9iOK5ifgRi7NiwMV1ECYKdCN10=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Nov 2025 10:06:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10766765311845532809
From: Chaoyi Chen <kernel@airkyi.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-phy@lists.infradead.org,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: [PATCH 0/9] drm/rockchip: Introduce Rockchip RK3506 VOP
Date: Thu,  6 Nov 2025 10:06:23 +0800
Message-Id: <20251106020632.92-1-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MaVe9I53f0M32r5fsRWj//W6nWaUspkMSaTtRW4c2N6Mdvr0+1ipAgD5
	JUlOS2AFXv2TT5iyKkQofrVkr4B6nVpxXL6F80oenAcFfNT6ZYS9VfFPbTdzHbAPbxlLTFr
	u3pn3DnIXAQoG4ecnn0xqL8Eh6kEScNs48pmFXkPacrGEJDKHpi+yv6oU/F8yyzEEWzdHNy
	rUySAbLVGX2lD3J0qtmrKEVQOUKGgisz6cKeY0iB1erxFWa4hODg3J337bFzjADIJX6RiqL
	IkssFhteJj/+JSxld1aapay3kY40f47vb0fRxFpqi3pYxrtg0wVEodRlDsNihgCmcYJKvDA
	IiYCt1v6RpYoQOUB5q9j/A7Xkn+LrNzQQ1KcflGdcH1xIXZ8bAdkxXuJFR90SAGUGvcNBAD
	2nbQf6qZtfHKSbEzEaj4wCg0QlTTm42p5wBkyjgYS6LMolsYav3Q6MYQ8LE/co0LVlFAuL4
	nMVz4KyQwBPKb+dyswWvp/GHlbdYXKo/lwMUvMmjEYbppktIBc6r3UDUW2qh87xsRWzvVmZ
	yrc0RIuEl6MP3dW9bjbSqcRrE4h/u/rOZRFDHEVxAWA2xioLfemSHgun52czZWwv+uKnFzx
	r41bHUFf7TXnn9HsZqNd7C+9n8wtZNa90DhWZpYUOYwCt9L9KTlzg5nzHFxf48tI0oHn3S6
	1K3P0HnVJeCZbZU2aAkEO6GNqUNjXIfvZ2bbkbpvC4qY773Ev1nh680PRo6ktxJ7sZ9s+w7
	Dak34WJKt3Pa7zrKnNozVPoF8dqH7TqtgopT7Y8/mKkd3w9n3uTcDl587GR1yorc1+KF1p5
	cVwFulLw8bk3SRXT2UktX9IVEeM6WLnWx9pAeS1Y1h0h+KDMaEpHiSQ1MspzojlC80Rkhxe
	MAnG3q57lQjueLxu/ciFBE7zyVkCiM6Cu1pY2NoKvPtQnkUhuMW8VdzmsDi6bfB+7Trm0h9
	R1rNpsQQ7Z51SMEVk8NCXUlrnT2Ylt9ZA5lQCCflYxPW4mg==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

The VOP on rk3506:
- Support 2 lane MIPI DSI interface, 1.5Gbps/lane.
- Support RGB interface.
- Max output resolution is 1280x1280@60fps.
- WIN1 layer support RGB888/ARGB8888/RGB565.
- Support Gamma LUT.

This series adds basic support for rk3506 VOP. And tested on the
rk3506g-evb1-v10 board with a Wanchanglong W552946AAA DSI panel.

Chaoyi Chen (9):
  dt-bindings: ili9881c: Add compatible string for Wanchanglong
    w552946aaa
  dt-bindings: phy: rockchip-inno-dsidphy: Add compatible for rk3506
  dt-bindings: display: rockchip,dw-mipi-dsi: Add compatible for rk3506
  dt-bindings: display: rockchip,vop: Add compatible for rk3506
  drm/panel: ilitek-ili9881d: Add support for Wanchanglong W552946AAA
    panel
  phy: rockchip: inno-dsidphy: Add support for rk3506
  drm/rockchip: dsi: Add support for rk3506
  drm/rockchip: Drop ROCKCHIP_IOMMU depend for DRM_ROCKCHIP
  drm/rockchip: vop: Add support for rk3506

 .../display/panel/ilitek,ili9881c.yaml        |   1 +
 .../rockchip/rockchip,dw-mipi-dsi.yaml        |   1 +
 .../display/rockchip/rockchip-vop.yaml        |   1 +
 .../bindings/phy/rockchip,px30-dsi-dphy.yaml  |   1 +
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 225 ++++++++++++++++++
 drivers/gpu/drm/rockchip/Kconfig              |   3 +-
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   |  20 ++
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c   |  57 +++++
 drivers/gpu/drm/rockchip/rockchip_vop_reg.h   |  14 ++
 .../phy/rockchip/phy-rockchip-inno-dsidphy.c  |  91 ++++++-
 10 files changed, 410 insertions(+), 4 deletions(-)

-- 
2.51.1


