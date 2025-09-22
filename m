Return-Path: <linux-kernel+bounces-826497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1D2B8EABD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 03:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E570189ADB8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 01:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFDB19258E;
	Mon, 22 Sep 2025 01:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="AAR26LKo"
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B159B18E20;
	Mon, 22 Sep 2025 01:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758504094; cv=none; b=HC3xPxY2U1uz/nMvMS3+CTHwYeA1eQNu6oz3BHnk1icJsROoeniEae6izUx1WfpKB9C4gs9U+yYdQGqLDqCY6lO4EdqNYmMk5x4W/iIX0lXUACa+ov/7H6VE9nmNfhh7Fn8+pTnv3ubJY0IOy/L/kjoPhPebIJgGNxXvO7WXF9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758504094; c=relaxed/simple;
	bh=CD1SQmOAhRrBECdX80K+TmGesTLRxNBkJ4iHSKGNXyI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Tv2Mhk79mlvjWSCGENQgxzSFRzqeQEdrKAL2h2LKjVOpkqubHCS7Xv+Y3AuJyEOFFz3G8MAt4h0/nX4YWDFAoO1zZ8iB1NlUJOWL3nBsW/P3i721960LZpCo3LQpdADAw94IaaGBi67mGBluUYD/xzn12q3XFs7uAnYz3XdYNxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=AAR26LKo; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1758504051;
	bh=nXCBtUA+m9scr2xmpRaIuBuOlGHEVWl3gOWkOzJl1I0=;
	h=From:To:Subject:Date:Message-Id;
	b=AAR26LKomQpmT5YIMQOt5i2lHyowL02UnA8HPo3J9JH12ndwQeMd6kEyB1NOr9OsJ
	 mV+br2L3CVhFAfGGSsAyd8rLj6Vrr0XQNSbVohfPOuVtUyZgJIUuo0SsoLA39l+m9Z
	 hBvft8Q03ZQQHmJjM19H4VvxDgxj6CV2Oswzc7OM=
X-QQ-mid: zesmtpgz1t1758504048tb13996bb
X-QQ-Originating-IP: zyZxvz1kW6DoY+Ykz8VGYNjxDxOh/OBcK7J8ECz/sP0=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Sep 2025 09:20:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2099483455769991136
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
Subject: [PATCH v4 0/7] Add Type-C DP support for RK3399 EVB IND board
Date: Mon, 22 Sep 2025 09:20:32 +0800
Message-Id: <20250922012039.323-1-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MZ9X7MyfBLblIoi9hIZLojGLP7mu+oTAFeAnrHaB7NPYiAOxISXZwHrg
	HHcphF0ZBGLXWLESKaW2RL8AO2oGl7H4bAsTaXUKcmZnDC3Bc7BEJS+2YUxUMf1o8D5HAmw
	fdtDUr0a9ebiblf8xekQft+3ox3JrkkHBgBzCy2DmZ7TN8wUkK4BLIKmymCnw5LICJSITZy
	H0j4ryhzrNdZG9VT0v6J/8of22aRc+fiVYl+6meVHl8qqOq7vEoP2QhitgxsneUd/89UQ6k
	5PaIiA+TpfdmMyJL8NLJkg+zvnubYGrgfspYJCrQ5d/OOrFhs2q6+AB/B9MjU4ueTAkXdNB
	p2TE3HfwG5aD/zRuGxV77HHMOLh7DFdBLDefITCFkecc9q8voQApgvWfKALCx4l6GoQ/+lu
	HTEQWaWqotntEww5j85VywTEBS9qJ0BSjlZX/oJkbJXcsQKs9iSrxszVRiREa9JwZiOrkbk
	TdNEiUk66HON9kX0XORwJt6ZlBg1oc6uPhfasDJ/ZDvRfF7+Hn359v+oHcVJgcFUj+z84F7
	8RqLKLsWtpCNMDpTZiXqAVwiT8Y6CKl8oQ4F3U1PQvJmQSMRkBrdPGSf3/hSt7yTrVopbMh
	wnmo2cItcUETg3VihF0LGyl8w2IjJEwqzX/2SBmitWz/TZ6wIlTBKkR+vMV7l0b2hRfNV0p
	SOo8+pdgvyXQq63h6kds2fRVNaP7RuYmhD5lmF9GDrHd6y/uMF8AYWmpIl1Bq5SFRBfStNf
	JeuYRYOPKU/v9kE/zLEwClTiG7KHhMduD4KSfTfRZORGZw95pUd0K3mLkXskxm10/4eTjYl
	7y/KiurR10iuPg9mjWPTb8Wq6rSd7n9cnMiarjgx8gsz3B3nO1R6BldToA6k+IgVc41hS6h
	IT+nF2EUpd+Vv4bFScOEHdbmNxz+1f+skjKoysysEaFQlRFwgpGaz8jyE6J8LUrt/x5jj0x
	9QouUhnDFGNywBdXeUrwYDOskl0c7UuvPiK1gV7LfzYfI1TQQHDQ+kFYaOreMf+CsUmA=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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

I'm not certain if the current implementation is appropriate.
Please let me know if there's a better way.
 
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
connections between the PHY, USB connector, and DP controller.
And cdn_dp_parse_hpd_bridge_dt() will parses it and determines
whether to register one or two bridges.

====
Patch1 add default HPD device when register Displayport altmode.
Patch2 add new Type-C mode switch for RK3399 USBDP phy binding.
Patch3 add typec_mux and typec_switch for RK3399 USBDP PHY.
Patch4 drops CDN-DP's extcon dependency when Type-C is present.
Patch5 add multiple bridges to support PHY port selection. 
Patch6 add missing dp_out port for RK3399 CDN-DP.
Patch7 add Type-C DP support for RK3399 EVB IND board.

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

Chaoyi Chen (7):
  usb: typec: Add default HPD device when register DisplayPort altmode
  dt-bindings: phy: rockchip: rk3399-typec-phy: Support mode-switch
  phy: rockchip: phy-rockchip-typec: Add typec_mux/typec_switch support
  drm/rockchip: cdn-dp: Support handle lane info without extcon
  drm/rockchip: cdn-dp: Add multiple bridges to support PHY port
    selection
  arm64: dts: rockchip: Add missing dp_out port for RK3399 CDN-DP
  arm64: dts: rockchip: rk3399-evb-ind: Add support for DisplayPort

 .../phy/rockchip,rk3399-typec-phy.yaml        |   6 +
 arch/arm64/boot/dts/rockchip/rk3399-base.dtsi |  10 +-
 .../boot/dts/rockchip/rk3399-evb-ind.dts      | 146 ++++++
 drivers/gpu/drm/rockchip/Kconfig              |   1 +
 drivers/gpu/drm/rockchip/cdn-dp-core.c        | 423 +++++++++++++++---
 drivers/gpu/drm/rockchip/cdn-dp-core.h        |  23 +-
 drivers/phy/rockchip/phy-rockchip-typec.c     | 365 ++++++++++++++-
 drivers/usb/typec/altmodes/displayport.c      |  27 ++
 drivers/usb/typec/altmodes/displayport.h      |   2 +
 drivers/usb/typec/class.c                     |   8 +
 include/linux/usb/typec_altmode.h             |   2 +
 11 files changed, 932 insertions(+), 81 deletions(-)

-- 
2.49.0


