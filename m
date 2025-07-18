Return-Path: <linux-kernel+bounces-736305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D34B09B51
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C3A77B4A5D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C231F584C;
	Fri, 18 Jul 2025 06:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="i+cLUfaw"
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC5A19E97C;
	Fri, 18 Jul 2025 06:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752820009; cv=none; b=bjRNDe4TDZsnqSm9Kd/WOyZ/S6c+4lcwDkhB/2RqjjdQpoZHtrGOSpe2+p8SNpTS0x30L5PHrx3lyO4H6cK+bAwjRHfNC+hWGjU9eZTJNYL4uM2hNcu1KYeaWr653vcKgeUvc1kyBRI5HAMpcfs7Nj4Lgl1S+c1DFGjv+B1BDJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752820009; c=relaxed/simple;
	bh=oDZ4nZfHpKZrr1P30dS3nV/jUXwQn6SsAS2ejueJNJs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=mSas/axxlh3Z0jy3QGQJTZc46Ko75h/fBPpogU3VOvGR7oLJJgoxBWAqcbrHQO4w77pA6aYg3LR31xGNw9QvcnuCtCzmp50WoengAAU8eZC30df4GN/8HORcgPcX10Xkee0+KO2oe6Va1PZenbPw9rMTSIJ2hT6w5tcS4SmEApM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=i+cLUfaw; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1752819991;
	bh=67zBKAFFwPEqpjYU6DUQenOYYuvrA+r8ErnMRmV64A0=;
	h=From:To:Subject:Date:Message-Id;
	b=i+cLUfawxyKW4EgreRiNrFMlKI7lrjrMj2HqoRoAJ5BVI5bGQkyTiICCIeXy+6qCi
	 SSobq3BydXYrYLc5lz/nshsWzDN/ZeMNjK+vZNMD/qqvaqeP3m1OLlDL6Xfoy91yfi
	 vJ86XLKIgZHO0mQR1V7g5Re9hDcm0SisCTbsl9Bw=
X-QQ-mid: zesmtpgz7t1752819986td7cbe615
X-QQ-Originating-IP: r5wfY5yuY9UU3ArV/GPId12LkrXTc5e4liuG9amroX4=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 18 Jul 2025 14:26:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13786534937215164042
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
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/5] Add Type-C DP support for RK3399 EVB IND board
Date: Fri, 18 Jul 2025 14:26:14 +0800
Message-Id: <20250718062619.99-1-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: N3IC8um5pMyYiUTB++F8KmHZrI2wWXDYqLNNmo7rCkck4LqYUNitGz+G
	AHxh+tq/Bv/ZSx19rTpQE+gndSIF6Fvrd+EekOQclJYqxu4AodaDFjxv1ytk/XSFYtCwPtY
	Vls172mIKh+6LQw7D0hlNFA6BEko2yf+JS60X+NcBcoSG2p56NhDS1Ij5Z511kIL6Jl8ECx
	SmmUbmTQMeo3IexOyMO6i+neVRqTZ6l8fDrbIZhvtr5OvSstRV9SMKWtMCBDC0AUq1jViQx
	qkz6lYn9sIcIdEDx9guE0Civo8cPyuOD6SLMHpkRXu/axnTlaMRX/jMbkcjk1eKizKihkUy
	3n3kR2rwKZiUtTCkoZ0sq+g/wTqTwgnx1YdDuM2gehIKOsoIeDVB1qrcSp/nnyqaGEJD2Lh
	caeLFgq74TPBFPAd89nmWUVX/chHzxmV9mvlQ1zmCRaan8RGruVkNKBm1g4bMgOm++wghhw
	79p+o2ukpPYQJdRFBOqlb/4w87+WQSPxQe10Gu88mNGejQJBYiQ7abxAcrWIgOzz82ZR+ZQ
	UZiT4SwuTU9t2nm3N6M1QZHZQCj+O1tygysx73vLUnTyP43iIv9Q7IXuEVqx1FVi9ZLaC1T
	tHMXA9ZPg7LjG5VKtva5Pn6uF5FaM6a4S4KfBYMv6y+KowBSy6tcfksmPf141oM9WqpWhXw
	xC+VioHykYRsTfcqXohnPpXeySo3hZXme1xnqszP3gWsL8tRBBe7elbx0xp9d8i/wmzwiRE
	GNImNshWAXzg9q+erRHh4h9gPTRfCPKycTVEaSzaimEK4ps1z5cK4+avWtVNZ+F2UY2PEqN
	Fh3EG7osZqeiv4YO4EDGNzg5nJY/5ZEExX9KzV8tej1nqdfOFPcUov6k/6f5UUNHr5PbIVd
	GdYLnrK/5mMEdh/pG4DhlHb84deTvfeBbfarlL0VXMJlmr7nk1GnfdcXQysF/Vc/GyR8FUw
	rUfEBTGBYXgkfBsqFmHKMO0YpxYMWsN3z3LfHSYqa+0zZUoEjA23Yr5VD
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

The RK3399 has two USB/DP combo PHY and one CDN-DP controller. And
the CDN-DP can be switched to output to one of the PHYs. For USB
Type-C interfaces, an external chip assists the PHY in handling
altmode switching and orientation switching.

Their connection diagram is shown below:

external Type-C Chip0 ---> USB/DP PHY0 ---+
                                          | <----> CDN-DP controller
external Type-C Chip1 ---> USB/DP PHY1 ---+

The RK3399 EVB IND board has a Type-C interface DisplayPort. It use
fusb302 chip as Type-C controller. The connection diagram is shown below:

fusb302 chip ---> USB/DP PHY0 <----> CDN-DP controller

This series focuses on adding TCPM support for USBDP PHY and DP driver.
Before this, the USBDP PHY and DP controller of RK3399 sensed state
changes through extcon, and devices such as the RK3399 Gru-Chromebook
rely on them. This series should not break them.

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

 .../phy/rockchip,rk3399-typec-phy.yaml        |   4 +
 arch/arm64/boot/dts/rockchip/rk3399-base.dtsi |  12 +-
 .../boot/dts/rockchip/rk3399-evb-ind.dts      | 133 ++++++
 drivers/gpu/drm/rockchip/cdn-dp-core.c        |  37 +-
 drivers/phy/rockchip/phy-rockchip-typec.c     | 403 +++++++++++++++++-
 5 files changed, 564 insertions(+), 25 deletions(-)

-- 
2.49.0



