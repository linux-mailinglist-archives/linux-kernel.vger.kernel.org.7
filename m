Return-Path: <linux-kernel+bounces-855442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C62BE13EA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 04:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76BB74E6E25
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 02:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A774C21A420;
	Thu, 16 Oct 2025 02:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="bQsi1Hqh"
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921E41CAA85;
	Thu, 16 Oct 2025 02:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760581711; cv=none; b=LCvKfoj1NENvvc5vBvKIEsYNxYT7s0ZlBNK0wBrEDgtWnEDb1LLgNld4KwSuk0eE/8OkT1/2SRpjBaAZVv6Apcz/kNzGdRujZe+iAVDGhZgTprVR5t7z+hF3wIzRr1u/3LaBC6zb688tFLoSb1XaH3rCHnrA/ePBufGSTY4EWiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760581711; c=relaxed/simple;
	bh=NkeTJDryfQCo5IPz1Noh2rimKfDF75VBalB/tNgWr8k=;
	h=From:To:Cc:Subject:Date:Message-Id; b=jx4q/Wx52SNBQrm1vNglWPVM7ic2VP7yNM5GbGRGRNhpzsIOBLilkVxYzEQNKOFTWJX7ywx8bbM2Q0iOj6FpTZe2FHvD7y6I0wLFpuYKbzLjeHDQxasUrHAb1bZRIy0/t7jCNiPoq2v7mhg5RZBpzQqvxaHKBagTRAhbc/oHFEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=bQsi1Hqh; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1760581681;
	bh=BEBhnIFYQE1pkIVJ1uy2FZ5QokSZYpQQ/FLfYRbFosQ=;
	h=From:To:Subject:Date:Message-Id;
	b=bQsi1HqhedQTJhaaOWuFC3vwdMD0D2QwFUXiLIkmkueBWmZF+kMa/9XMyGaGBgg8l
	 JQhdJ2Isl64YFvdbHbRFoKy6A3fZtz7PnP4s7U1/Im779OZDX4RuC32VsfGr0INttA
	 wEFdn6ZBjSR8MJ+IiM/+jiPM1O+yYwe9z+9UGSqg=
X-QQ-mid: zesmtpgz1t1760581678t7a5fc67b
X-QQ-Originating-IP: OdSgz/RY05V2laSRNQnpB7+nE2yChLO2QesvXncio9c=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Oct 2025 10:27:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16860135895729998045
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
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Peter Robinson <pbrobinson@gmail.com>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v6 0/8] Add Type-C DP support for RK3399 EVB IND board
Date: Thu, 16 Oct 2025 10:27:33 +0800
Message-Id: <20251016022741.91-1-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NiJgP/70eYXdDQvMNqheQ2meXD5xfojFhrpiyg5vuFOIQyjUFQlh/Mgs
	L1lJCSpnNpXWhPRhFEyj/Eocwa2iZCs8C8pCfIiqRpnmzMD5Edby/aj+/XXNfu5klWvVtlN
	ttnogGDFujE9OGU20mQn2No1tghQF6dGArCGW0MfQnrFK63ywOWczNZQBK+Lh4fwIdQB256
	2zK4Rv1cHXmbNUHsRkJE1hJU+JxxRMrQNvSt2ugSsnRSKCLjqUuSYOq3LhSZVftZd/GXfPs
	/pGEvhSdZH+IaZnzCvpeGx62sFVV2A4Hs2xbS4ON/jUK6QvwMmPhdAru+zUgPWuy174ZRAW
	uHSU1vkUS+lQe2z+XO9GmFJgjOalaWCox1cbiBEE7QJ+1HX2/lF+b55QVW+o0RJh0WxKJcB
	J025ogk6c8NMujFNkpIjQV8+jUAMJfPrkOpV5afHhKRqthvplOHvmq7wNaUr5zFnP3pCrKT
	vFTj6afb7/Tb71VmAGLtRVPYiRYyOGsfiNYQ7yVoFzDplRCvPBdyghJWmwKA/zjCaw20a2g
	vp+Q8o8tMpS+7eqec8hH2BJfVZHVzKnUQmeQaC0ZG52yjfjjgWnLhiA0wSrdKWqZcwJf269
	8FL1jJCNJBc78HEoI0WVSIHYn9kDuYKEYdYYTfE3br+7QtSbmZ4nQ+i9RaImaJVwQLxQDwX
	Ma9XhuQomIa/ODgpCJ8Qtx29+O1o3V+S1WOdAQhxWhETqLotc9Id77mGbmZgox1G6oy86zN
	hbNUOze0ZdOXXAsZWejMaI3vr+P84scvWw4mHhMEATL+YN7qoxnBwR6tIFlDNgjlXKepXsY
	AFvD8nTBZOenhdqAFZadBl6onb98Km7eJBN/sGJMDxiEbVtS2z0DPBpg6olRoCwJSr1k4im
	2z34bw/0/M7MM2CTHgall5OuZPFVpBrlsbCwsuv82O7ly8nLLHJccyNnIqjVhGxQcsExR5J
	TLQumaqN7rpkHVVOllfe447+Is5lmEqV0WGeay5rDtj3O4TlNLfa+z8Ea4hatr7BwLnDH3f
	9zN6UoHg==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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

Before v4, I implemented a variety of DP HPD status notify. However,
they all had various problems and it was difficult to become a common
solution.

Under Dmitry's guidance, I try to add default DRM AUX HPD device when
register DisplayPort altmode in patch 1. That makes it redundant for
each Type-C chip driver to implement a similar registration process
in embedded scenarios.

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
Patch1 add default HPD device when register Displayport altmode.
Patch2 add new Type-C mode switch for RK3399 USBDP phy binding.
Patch3 add typec_mux and typec_switch for RK3399 USBDP PHY.
Patch4 add DRM AUX bridge support for RK3399 USBDP PHY.
Patch5 drops CDN-DP's extcon dependency when Type-C is present.
Patch6 add multiple bridges to support PHY port selection. 
Patch7 add missing dp_out port for RK3399 CDN-DP.
Patch8 add Type-C DP support for RK3399 EVB IND board.

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

Chaoyi Chen (8):
  usb: typec: Add default HPD device when register DisplayPort altmode
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
 .../boot/dts/rockchip/rk3399-evb-ind.dts      | 146 ++++++
 drivers/gpu/drm/rockchip/cdn-dp-core.c        | 354 ++++++++++++---
 drivers/gpu/drm/rockchip/cdn-dp-core.h        |  24 +-
 drivers/phy/rockchip/Kconfig                  |   3 +
 drivers/phy/rockchip/phy-rockchip-typec.c     | 420 +++++++++++++++++-
 drivers/usb/typec/Kconfig                     |   2 +
 drivers/usb/typec/class.c                     |  26 ++
 include/linux/usb/typec_altmode.h             |   2 +
 10 files changed, 911 insertions(+), 82 deletions(-)

-- 
2.49.0


