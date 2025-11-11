Return-Path: <linux-kernel+bounces-895208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33176C4D3FF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51BBC4FB5CF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC52350A2D;
	Tue, 11 Nov 2025 10:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="XtSr45r+"
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2762F5302;
	Tue, 11 Nov 2025 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858267; cv=none; b=kweUlQMWZy/U5W0bslfYuvabAUUbP0avvrt/nnHyYALWX25LKuOUd6IXtvjqNPqyZezr97KfsZnumBzHxscrKu4uYOvP0UmGY+9H0VSoiZ1Tex5+4fwdd/hZ1e3jydDgVIHj7mGQIvMRyMsNQWDNvSCGYJ11GIvzuXmaD9Zh/hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858267; c=relaxed/simple;
	bh=uGU2AVXO7ykCV/puli54M/ue42gFICSvYYSvdmQyZm8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=CB12963uoafTgf+NXAJ6U8oUB/9mfgBNyy6ZA1kALoWEWYgeTN7l9zpgQZUqkUTSu19UQQa77XGYBtXsFSNmYsVCD2C/Yb3x8IEEbuol1fny7x+HtGCK93JP0jaS6eSqlcjlOrmp5HMQDLBL4hDnC138aD8NA53kbVOuz13OYiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=XtSr45r+; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1762858253;
	bh=Qdarakoh0lu55nEwr1i4FdI827BvE1xKbD7AfhT51Uw=;
	h=From:To:Subject:Date:Message-Id;
	b=XtSr45r+fuFx59GsXGQ3fwKFsX4XbQ2KxlHziVTznNmChcZw/uFng9X4UdpNoxUWw
	 h/zNs9UXYt3aPBOYw1xtsmQd/GlkqQ2/xJTjbbNE1MZfAktN6WWoUB+mE1+tsP6dsV
	 QSBBTnYA5T3FKE6rG4rgzVqBIFAgosS+xYsx4iFI=
X-QQ-mid: zesmtpsz9t1762858247t99290bc5
X-QQ-Originating-IP: xaFyk2tAr9JVxI4G6E1rGJahsyu1PFyvRQQ/B8MzEJU=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Nov 2025 18:50:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1823713052325328249
From: Chaoyi Chen <kernel@airkyi.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Peter Chen <hzpeterchen@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Yubing Zhang <yubing.zhang@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Amit Sunil Dhamne <amitsd@google.com>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Peter Robinson <pbrobinson@gmail.com>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v9 00/10] Add Type-C DP support for RK3399 EVB IND board
Date: Tue, 11 Nov 2025 18:50:30 +0800
Message-Id: <20251111105040.94-1-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MhFAoh6gmjppNgUGjKgw7K86FI28KNCryRUtAbrmL8bmhJ9C01Ym/220
	Lar3r54tI1LpJlYoyVrFKoeWD7dvOLsMAeEIZhZ1hfw5bk//IlrBUn3elPC/ss5RW8vijE1
	RbKIeF7EX74hTo3ngx5Pcj/k09hzXq83EvgrK/ghLZRG+TCCtEdZbjqBcXRnnAE+c5GZm7C
	2xJ0XpbVtXADeR+9HC2OuUeG3dMBGkHZQS8x/Ucpyy92a6oIWAH5ac4gaaUekfEWStPCrLu
	tUF0o9UepycqyGKQMVN354RR/J62u1cmCxaOruQALwHRj4WZxle78Kij8sm97duwOcyPstG
	XtQ6fSS6hsb0Rcg/DPVHHj/wgxIBu79QBi+mMRonn4k6nS9bjofCJZJQSneUnIqEocQm2vp
	wKOxYO6rRjYw+M0RXszqmbF86bT12+Dxs7jHObYVE4rGwXUKOKqPNIi7UlWbKCHR7E65kfv
	phXN40NryYxNMPQ/YXYeMxy6RbOxrWEgV/L3M71SbzrM23sOD0FSvUxMZyDAOZajYSUfekA
	Jvk7A4VMyBW3viBX4ugmYVH8R7HaqKjZKjfZjSNscP8SUreU8KlZx0vX8ReiVh6/IRiA69W
	1K1I4gKhyi89ReV/EiwI1ndKNCuchFI6RxQG0vDAn+0r9O6YmaAIV/AEBQ9d3PWLAVTR1sh
	PgDC7xA1szhHg37hGDdMW3rU17V3gA/SxLFMy5BjL/MiEM/Ez/2+D3qv3XUmjdin5JENXUN
	IOVgBrA8b/3dNpQ6CLVUeYL7Idxt5mDXjvZku7Tb1iQxSx4VZAdrHK2PebXZ5xRtSuED6h8
	dSzs+aG5yxeIDcmFspauWRhUQ4096FASEdo7TmPy3O7/hvDjivurmnBkDVJTBgERmdU3DUq
	yZNjSMylAvoDQ/q2FsAhTJMasr9dtB5OSfjc7AayC0CmXQ39eyTdvZIInX0U5H9P3AdcFGg
	ytNrVTxbcDYBs+Nvg8W2H/7fpqGPOKFGTscQh+t67HGSLgKse5AnQuPnZxeRkaWBQBtUpRm
	FVYQKReg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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
1. DisplayPort HPD status notify

Before v7, I implemented a variety of DP HPD status notify. However,
they all had various problems and it was difficult to become a generic
solution.

Under the guidance of Heikki and Dmitry, a decoupled notification
method between the TypeC and DRM subsystems was introduced in v7.
First, a notification is sent when TypeC registers a new altmode.
Then, a generic DP AUX HPD bridge is implemented on the DRM side.

That makes it redundant for each Type-C controller driver to implement
a similar DP AUX HPD bridge in embedded scenarios.

====
2. Altmode switching and orientation switching for USBDP PHY

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
3. Multiple bridge model for RK3399 CDN-DP

The RK3399 has two USB/DP combo PHY and one CDN-DP controller. And
the CDN-DP can be switched to output to one of the PHYs.

USB/DP PHY0 ---+
               | <----> CDN-DP controller
USB/DP PHY1 ---+

In previous versions, if both PHY ports were connected to DP,
the CDN-DP driver would select the first PHY port for output.

On Dmitry's suggestion, we introduced a multi-bridge model to support
flexible selection of the output PHY port. For each PHY port, a
separate encoder and bridge are registered.

The change is based on the DRM AUX HPD bridge, rather than the
extcon approach. This requires the DT to correctly describe the
connections between the first bridge in bridge chain and DP
controller. And Once the first bridge is obtained, we can get the
last bridge corresponding to the USB-C connector, and then set the
DRM connector's fwnode to the corresponding one to enable HPD
notification.

====
Patch1 add notifier functions for Type-C core.
Patch2 export all Type-C device types for identification.
Patch3 add generic USB Type-C DP HPD bridge.
Patch4 add new Type-C mode switch for RK3399 USBDP phy binding.
Patch5 add typec_mux and typec_switch for RK3399 USBDP PHY.
Patch6 add DRM AUX bridge support for RK3399 USBDP PHY.
Patch7 drops CDN-DP's extcon dependency when Type-C is present.
Patch8 add multiple bridges to support PHY port selection.
Patch9 add missing dp_out port for RK3399 CDN-DP.
Patch10 add Type-C DP support for RK3399 EVB IND board.

Changes in v9:
- Link to V8: https://lore.kernel.org/all/20251029071435.88-1-kernel@airkyi.com/
- Remove the exposed DRM_AUX_HPD_BRIDGE option, and select
DRM_AUX_HPD_TYPEC_BRIDGE when it is available.
- Add usb role switch for Type-C.
- Remove USB2 PHY in Type-C connection.
- ...

Changes in v8:
- Link to V7: https://lore.kernel.org/all/20251023033009.90-1-kernel@airkyi.com/
- Export all typec device types for identification.
- Merge generic DP HPD bridge into one module.
- Fix coding style.

Changes in v7:
- Link to V6: https://lore.kernel.org/all/20251016022741.91-1-kernel@airkyi.com/
- Add notifier functions for Type-C core.
- Add generic USB Type-C DP HPD bridge.

Changes in v6:
- Link to V5: https://lore.kernel.org/all/20251011033233.97-1-kernel@airkyi.com/
- Fix depend in Kconfig.
- Check DP svid in tcphy_typec_mux_set().
- Remove mode setting in tcphy_orien_sw_set().
- Rename some variable names.
- Attach the DP bridge to the next bridge.

Changes in v5:
- Link to V4: https://lore.kernel.org/all/20250922012039.323-1-kernel@airkyi.com/
- Remove the calls related to `drm_aux_hpd_bridge_notify()`.
- Place the helper functions in the same compilation unit.
- Add more comments about parent device.
- Add DRM AUX bridge support for RK3399 USBDP PHY
- By parsing the HPD bridge chain, set the connector's of_node to the
of_node corresponding to the USB-C connector.
- Return EDID cache when other port is already enabled.

Changes in v4:
- Link to V3: https://lore.kernel.org/all/20250729090032.97-1-kernel@airkyi.com/
- Add default HPD device for DisplayPort altmode.
- Introduce multiple bridges for CDN-DP.
- ...

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

Chaoyi Chen (10):
  usb: typec: Add notifier functions
  usb: typec: Export all typec device types
  drm/bridge: Implement generic USB Type-C DP HPD bridge
  dt-bindings: phy: rockchip: rk3399-typec-phy: Support mode-switch
  phy: rockchip: phy-rockchip-typec: Add typec_mux/typec_switch support
  phy: rockchip: phy-rockchip-typec: Add DRM AUX bridge
  drm/rockchip: cdn-dp: Support handle lane info without extcon
  drm/rockchip: cdn-dp: Add multiple bridges to support PHY port
    selection
  arm64: dts: rockchip: Add missing dp_out port for RK3399 CDN-DP
  arm64: dts: rockchip: rk3399-evb-ind: Add support for DisplayPort

 .../phy/rockchip,rk3399-typec-phy.yaml        |   6 +
 arch/arm64/boot/dts/rockchip/rk3399-base.dtsi |  10 +-
 .../boot/dts/rockchip/rk3399-evb-ind.dts      | 147 ++++++
 drivers/gpu/drm/bridge/Kconfig                |  10 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 .../gpu/drm/bridge/aux-hpd-typec-dp-bridge.c  |  50 +++
 drivers/gpu/drm/rockchip/Kconfig              |   1 +
 drivers/gpu/drm/rockchip/cdn-dp-core.c        | 354 ++++++++++++---
 drivers/gpu/drm/rockchip/cdn-dp-core.h        |  24 +-
 drivers/phy/rockchip/Kconfig                  |   3 +
 drivers/phy/rockchip/phy-rockchip-typec.c     | 420 +++++++++++++++++-
 drivers/usb/typec/Makefile                    |   2 +-
 drivers/usb/typec/bus.h                       |   2 +
 drivers/usb/typec/class.c                     |   6 +
 drivers/usb/typec/class.h                     |  10 -
 drivers/usb/typec/notify.c                    |  23 +
 include/linux/usb/typec.h                     |  10 +
 include/linux/usb/typec_altmode.h             |   9 +
 18 files changed, 995 insertions(+), 93 deletions(-)
 create mode 100644 drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
 create mode 100644 drivers/usb/typec/notify.c

-- 
2.51.1


