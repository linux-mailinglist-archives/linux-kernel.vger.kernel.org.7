Return-Path: <linux-kernel+bounces-848973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5111CBCEEEF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 05:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2A042341A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 03:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8741EA7DD;
	Sat, 11 Oct 2025 03:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="gwQzGzJE"
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6964E55A;
	Sat, 11 Oct 2025 03:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760153603; cv=none; b=pVONQjDwSgcGdJBzNFgxmuOyYngXgI442nsfu2d++/41FKLXDouyhUT51FxM6ogobqXIZly6d/wvwwwLP1P+6hlN7Quub/t4ivzh7lxfZbsyCsOFT51kreddUcFFrP/tGfoG3EkQc6ep/HLMPzrOjaIrnjqsL8BMlYRcPZtfOnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760153603; c=relaxed/simple;
	bh=yIbOPtOniuos31Snhfx+Jjp0+fXNwFJW8sHpScwj6co=;
	h=From:To:Cc:Subject:Date:Message-Id; b=UP7TsaVycp0N56NdrtdcAX4/O0oeSQsBmSU6L//fi1lI/yt+2THZjZif5ii5MM3ho6+4cvEpaRI9MKgnn9Zrqpt8tMo8JvO/kqhkvKoZ1O9Patyu+JhKfCTjbeIXauZ+ClHEWTgUv3gJ6e8QJjto4tQC14Jdw4xcBXpkVqUTVwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=gwQzGzJE; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1760153565;
	bh=1ifJLk8873eX1hlHsp6hKpNT8S+IOtOqXiAmk6qv8rw=;
	h=From:To:Subject:Date:Message-Id;
	b=gwQzGzJElv9n13dSGm81EeFnVpmt79sq5F87NYO2I1RQ44QH3Gn/FsyYwkDFOMOf6
	 XwGPMwDvVipKs4TdfV5glysOBy7ypfcdrAn5JqaBE35UuAa6+KGl4//XKeXv1cCIb6
	 5hxIa1eNVkfDlNWl29TrbA/h6tLgqKnI1vu7x+Js=
X-QQ-mid: zesmtpgz4t1760153563t46dff691
X-QQ-Originating-IP: vSCtcccqW2noE7PwTMsxNxd6jA273YQLY2Nnsk4ppuI=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 11 Oct 2025 11:32:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11891270749055428238
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
Subject: [PATCH v5 0/8] Add Type-C DP support for RK3399 EVB IND board
Date: Sat, 11 Oct 2025 11:32:25 +0800
Message-Id: <20251011033233.97-1-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: N7bzzhFwp0G2IjNaNNnMorEVxSO5mAJrlX5564ixStqNIePI9UEP4Rsx
	c1p5h3zx5XRq3Q6b1ZslrccuUrCKY9cb6w+jOwybGO5kxi/lckrpxzE/PI6gc5hKjWP9d95
	GJQAlNw6O58O3boobYhf4WfdPHMDkptx2kv0t7PKmK36E35qfTpxH0R/56XCHKVNlDVM4YQ
	iwDNE6LInvT/VtiSiC6wRgRjgvJr7wxeMcwKCcOewYjElFMNuQoM5YMkvtrvEnw/wWy1ECx
	v2Pl0V9RcG/5yZBZlRoXBuUS0sSs87SMHcF8BhOZgPjUbtFJIaxZ3F1Qo7U6iYXZWXvcIsE
	Sk8BgeEOVih/3DNxMeo+lawd7z/+PZsQE9XOUmqpqHvcTnhucBJV7znTnfYuOUggojTPKwC
	Ws7gQaYi5jAbjOeIlMHESdy9uIr3eo0VLlFi3Zh3YHNMNsa+8fJ3i2Qqi/hR/VbylzNumaV
	omTMoY/ABctxseduqA/QVCD0iS/TJRPSy+TKojsbxb/r4vVGYZRgu3938TFFcASYT3OcpSb
	LK+Knz2cwRBNjyprLkLbNKAKanO8o6LTclpUnJFqwmb4n9ZbbPH7HKa5HBvCzhqMraeiObO
	sOBxDwxthj0C5qiNl0Bqjm4FJk74J++C3ivjG5sxK4l/blv/mmZovSMEdD44HyO3I8QMu/w
	OVy9p45R5MloZxR7bzW/D0LUbbSKWVKvkfC4xe8917PZ2e0PoNKyQrMzeHGeCBqqcwWqqWk
	ZnkbX6O/Pf4g7t5feeAJvCep3YVhGikiHhcaS0vt/S9PSmlw7ONM0bWpp3rbKrPusblmmb5
	HZRsN3/DmYJKZ+JFHF8xnaOA1VPXkuhX3Y08GEgzDgo9+OSyXI7M3uJwOd38psjKywlZEZe
	Ddsc6nUf9L3YNrQosGNILsBYvVwTYX2cyst8zzr7MDY9BXx5gA9yTlOHjgYmlU4F831y9uE
	LVCJ95kMKF199VTzQBAGcCWIfs53/jz9jxs+jKfJh1Z8vN/IJqTrMSXi0Xl0RMkRxBf3SX4
	A8fzY1yQ==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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
 drivers/gpu/drm/rockchip/Kconfig              |   2 +
 drivers/gpu/drm/rockchip/cdn-dp-core.c        | 380 +++++++++++++---
 drivers/gpu/drm/rockchip/cdn-dp-core.h        |  24 +-
 drivers/phy/rockchip/phy-rockchip-typec.c     | 417 +++++++++++++++++-
 drivers/usb/typec/class.c                     |  26 ++
 include/linux/usb/typec_altmode.h             |   2 +
 9 files changed, 931 insertions(+), 82 deletions(-)

-- 
2.49.0


