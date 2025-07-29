Return-Path: <linux-kernel+bounces-749147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0643B14AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692DD188F212
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D36D28643F;
	Tue, 29 Jul 2025 09:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="VJM5AbH2"
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF2921D5BE;
	Tue, 29 Jul 2025 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753779739; cv=none; b=AB+Z1/1ZJyBqR7mjAlk4HiRc2TBlWf7dcqcoDlTmu2NPipA8Wucz/JkoL3Zjri6hJ9lOHvhL/ruZyMSLuRO3HOE2sKfEfChuRt3CwXSCgQycZRZ07KY0GePD2G7NTjo6+Fsdi/yHIE7dv/w3WbLE+U2ywVvyB4n6CgMannLrPxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753779739; c=relaxed/simple;
	bh=LL2ujkNtw6zm4XKjbyqk6virE9qxllFHx8wEUQ25xDM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=GpebK+/1L8mXeUg9M9XoEA4O0k67HaeOFN2gt+lPRXdPSDTa8OYQOjQWftr/wiFps8qTo/bJcgb4UgSs/fj+ONAutIsWTTtzF71YK9OMdSg0E/V8NGvZd4Py1QhdKe0JdKBr6yIjcdZLcW+l8xE75fwYpqLZvSsfJxouILypzuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=VJM5AbH2; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1753779647;
	bh=h5rOQQlCm3mMG1zR9ipfzak+qf4Y9/HK8RHmvv8tYyI=;
	h=From:To:Subject:Date:Message-Id;
	b=VJM5AbH2J0xHZvZYwHTopy92F6jiCL5fW5dKGIM0CvUxi9AiqC+JKGygiz5GQMi+H
	 ptqVizd++/gKlRdDH3o46cK6xU7MlmzclZ4CysalVDbJyDeK30H47YeZ3uhAwxBts9
	 sTifFrrsLLthXgqk5AQCQVkJe/3U1EuIlrcXwWtM=
X-QQ-mid: zesmtpgz1t1753779638t27222fab
X-QQ-Originating-IP: cz+4QRIh5zK5tw8iLI3ndpSJrAFLnEtHKaV7KhcHQcA=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 29 Jul 2025 17:00:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4146631262235089241
From: Chaoyi Chen <kernel@airkyi.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Yubing Zhang <yubing.zhang@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Amit Sunil Dhamne <amitsd@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Peter Robinson <pbrobinson@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v3 0/5] Add Type-C DP support for RK3399 EVB IND board
Date: Tue, 29 Jul 2025 17:00:27 +0800
Message-Id: <20250729090032.97-1-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: N2K7JO7TcIoEd+LGxKj9WA6HT38/JShDnLWg/jNWF337PQ7I5wECqCq5
	zc6w0rw6kSJTDpOqog7+5a+A+WU7Ugc732dRtZgnBEkDRNkwILw8mnXs4VNXwFEs39/Ri9E
	tqabQZEPFuGy0MaAFnIDETfaHOL5EJj0M8eCk9AKad5ZIw65P/yc5yXVki0HNtG62Y/wR7Q
	yzR+Yepp05K31vt/sAs6qLNMqwkG+m5fazoYG/b153f0EL78YzL0JZuUA9lxDJIVlLe22Bs
	68qniIDpKNHQVzJwI9BpF8mxxQhibGRva5f4q5XNitRg/VaiksXaYGhLGO95cdDas+ZWhED
	Hq9UwtDFi4LdroOVcl/orl0o952X/vSbQyvkRgvaspMFzOdrxbXE03tAi7Ml2xxevq+kKe8
	CLPnGFe/bG9sdZwTcksu+0332V+jAcrDZX2p3Y4wI52JpsmyyPMB439vna3Cbl/JL44OMXt
	eBjNFZkrYiYkwG/bNFRVR2WttaW4t2lwp+XL9RKjtZyzQnaEmp/hTHXmvgpxtKKBplkX+XV
	Ik5r4W3zex6GcnL5+MKGKKxFbJB5KWzESGn2/LUzF5G+6BUJytLPOLYvd99NF7fTsJW2UZw
	slpseos6HV3eeQzhDc9ITQiTrSE+fvXQHmtCj2tefKzUKgd6Irkq35bVjQF3T9nWg7LoacR
	1Ici7mj68sRzDd0YaTZUxOgeMMwwWymRX+jEF0bsEqx8u4InTBH9fXcVs79WfHMHEUx0qX+
	/t6QrlNoUosYWc7NGZV3yx9Azk0rKsWI5fZf4c+L0u+y+rXZfS2MGgbHjvMoUEVPvFDSrdL
	Yx5FBWd35iXjiW0pXBhmiHzjNj2N04rKsTdrJg87dJYAhIQq6dG1e0x4LkrPaKvNz5joKNq
	z1ctGEcYYuzOVz3MVKR5bI6Di/gGpIpFH6As45j1CwUpzBxQ8ERTI9sZcqospPM2od+FNjf
	1mbuDdwd+uB+jw9Yc2Ijqcr8nB0/DmmQlqawdFkDvd7ymAc8fKXdYC4jK
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

This series focuses on adding Type-C DP support for USBDP PHY and DP
driver. The USBDP PHY and DP will perceive the changes in cable status
based on the USB PD and Type-C state machines provided by TCPM. Before
this, the USBDP PHY and DP controller of RK3399 sensed cable state
changes through extcon, and devices such as the RK3399 Gru-Chromebook
rely on them. This series should not break them.

====
1. Altmode switching and orientation switching for USBDP PHY

For USB Type-C interfaces, an external Type-C controller chip assists
by detecting cable attachment, determining plug orientation, and
reporting USB PD message. The USB/DP combo PHY supports software
configurable pin mapping and DisplayPort lane assignment. Based on
these message, the combo PHY can perform both altmode switching and
orientation switching via software.

The RK3399 EVB IND board has a Type-C interface DisplayPort. It use
fusb302 chip as Type-C controller. The connection diagram is shown below:

fusb302 chip +---> USB2.0 PHY ----> DWC3 USB controller
             |
             +---> USB/DP PHY0 +--> CDN-DP controller
                               |
                               +--> DWC3 USB controller
====
2. DP HPD event notify

The RK3399 has two USB/DP combo PHY and one CDN-DP controller. And
the CDN-DP can be switched to output to one of the PHYs.

USB/DP PHY0 ---+
               | <----> CDN-DP controller
USB/DP PHY1 ---+

BTW, one of the important things to do is to implement extcon-like
notifications. I found include/drm/bridge/aux-bridge.h , but if the
aux-bridge is used, the bridge chain would look like this:

PHY0 aux-bridge ---+
                   | ----> CDN-DP bridge
PHY1 aux-bridge ---+

Oh, CDN-DP bridge has two previous aux-bridge!

Now, I try to use drm_connector_oob_hotplug_event() to notify HPD
state between PHY and CDN-DP controller.

Patch1 add new Type-C mode switch for RK3399 USBDP phy binding.
Patch2 add typec_mux and typec_switch for RK3399 USBDP PHY.
Patch3 drops CDN-DP's extcon dependency when Type-C is present.
Patch4 add missing dp_out port for RK3399 CDN-DP.
Patch5 add Type-C DP support for RK3399 EVB IND board.

Changes in v3:
- Link to V2: https://lore.kernel.org/all/20250718062619.99-1-kernel@airkyi.com/
- Add more descriptions to clarify the role of the PHY in switching.
- Fix wrong vdo value.
- Fix port node in usb-c-connector.

Changes in v2:
- Link to V1: https://lore.kernel.org/all/20250715112456.101-1-kernel@airkyi.com/
- Reuse dp-port/usb3-port in rk3399-typec-phy binding.
- Fix compile error when CONFIG_TYPEC is not enabled.
- Notify DP HPD state by USB/DP PHY.
- Ignore duplicate HPD events.
- Add endpoint to link DP PHY and DP controller.
- Fix devicetree coding style.

Chaoyi Chen (5):
  dt-bindings: phy: rockchip: rk3399-typec-phy: Support mode-switch
  phy: rockchip: phy-rockchip-typec: Add typec_mux/typec_switch support
  drm/rockchip: cdn-dp: Support handle lane info and HPD without extcon
  arm64: dts: rockchip: Add missing dp_out port for RK3399 CDN-DP
  arm64: dts: rockchip: rk3399-evb-ind: Add support for DisplayPort

 .../phy/rockchip,rk3399-typec-phy.yaml        |   6 +
 arch/arm64/boot/dts/rockchip/rk3399-base.dtsi |  12 +-
 .../boot/dts/rockchip/rk3399-evb-ind.dts      | 146 +++++++
 drivers/gpu/drm/rockchip/cdn-dp-core.c        |  37 +-
 drivers/phy/rockchip/phy-rockchip-typec.c     | 403 +++++++++++++++++-
 5 files changed, 579 insertions(+), 25 deletions(-)

-- 
2.49.0


