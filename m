Return-Path: <linux-kernel+bounces-731726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4045BB058AF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EEC2189E54C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651BA2D948B;
	Tue, 15 Jul 2025 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="ohz5vHQN"
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2D52D837D;
	Tue, 15 Jul 2025 11:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578717; cv=none; b=CQnB2jM8waWZ1c7NqS4eUMqIErW7+i3+Mq1nNXKKHp4sh4EblEKI/aWzzFfp5WVpX+/3ADYXdpF8ShazCdJgHGqx1y94/70zJcQZSHMgQNQO1dUuAsrKG71vQJ8J6ZEkVNmPKuCzsKgH/fc6eOPcNxrx/TG0WuHmm6LqcwyF37Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578717; c=relaxed/simple;
	bh=L2ffgtKXpg+Nv11QO3SKqtDZ2YKhKpnFToAgxVBip+Y=;
	h=From:To:Cc:Subject:Date:Message-Id; b=MjIu6FbiFTcFBK5hhu6URys271AEa7k4fRZe7YZ3x2tm+oTaUdn2DtDleNKtNlVgJ3RDF+JQv53y3PyLb/OAI4K0wNhbIIhzKHppG/nauISNLvVc7VUMu3FecRklyuCF6ux+FjXvaAi41R0KUMQeK2RFKM2wnskVFZD/K6nynSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=ohz5vHQN; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1752578708;
	bh=sGnlcbGkTpVe+jRIfMZ3RjpXeqeQnWzdixj31SR4Fb0=;
	h=From:To:Subject:Date:Message-Id;
	b=ohz5vHQNeaWVGitl4wajmbUOXO1EGBf8dcp4UQumGTUMvJ2EZg3k7W7y1YRYox/Dq
	 GNl6wUIkh8jYuzPobHtCZ1mWKbe68v4YjBIkUOajdshDLLg8QBofbjLNAAvtBW8rlB
	 6l1NdaPkXSH4x+eb6pNJGb4at/0vPZ72UfGjg24g=
X-QQ-mid: zesmtpsz3t1752578706tf14436e8
X-QQ-Originating-IP: uovcXhhJiGiAlXUvswW9NV/gOyyyF7ZPgZz7Ciqcoww=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Jul 2025 19:25:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10341645025017690004
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
	Diederik de Haas <didi.debian@cknow.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 0/5] Add Type-C DP support for RK3399 EVB IND board
Date: Tue, 15 Jul 2025 19:24:51 +0800
Message-Id: <20250715112456.101-1-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: N3IC8um5pMyYiUTB++F8KmFd6SLMvtze+pswzs8ff3wf8WaWQTeiI7M2
	q1o5thlP6tuQ6vizlUxODVlMMXCTKNYJkF/mvbyp8w7YlJoSvVF0orfYaCHr//6cfeU5CVp
	g/M0W5XUcNm60f94IaOhSSOCQzzS1DwXu8RqprVvWzbTo15IMKcHQfMUIoMXLGCJc1BXWAL
	wC2+VNcsaVqPYyfIfUDqVCspw5HOPv0nD3RskbyYhYEqajpO82J3gdmiXBAoaX9wpNvOzhh
	Lq8LB9AOb2p69MVTPUFG+glz5y/hPfmIvvA+IpD9Cw6N6Bs3CZR1KSo2ElsKdu0douwu/ju
	f4f0aZbW1pPxinIq0W5cSbDxULsaLjZbOtcrjRZUP6zU/Dc+KOAyazqdNAOZbnfUzmGoJlB
	BAtrsu+RvXT1pblb4p3liuLQotEiS5p0uENtA0leoMBi7JtlQ5hQNaIRdMwdyRc7ZI1LRiD
	5kp6uKJSMgYp3hXDel13eKPSQztZ2sMFfL0UDUAg5vILCWtbIL27P6I2uBvn36FtPdqMhhx
	1oxfwj/kOkDNU90nQJRV3Wzp+hCk/WSRzFm0tTHCTFpNytEjmJdIJsBlzzx8eaZM6cbXvBK
	/K41ryhu2GdmMDd6Q2fCvAYW9E2znPx46wOghIS/bMQPbtnXhV1yIzJid61uxBntabBoI8h
	wZ6FUkbapx0gvIsrWWX67wTh9DvQaeKP3hufDq8//HTlxLK50Ga6x2whKM1Rj8tNxKPlHEi
	uO7Dhg1Hqc65cKSoWfnyuACdB4O+bRc+nbx04Z531yOTDL+ZhDmDQ3lW425GLTsnfRKeCtO
	cAKd0pZP3qI9r6exTLvK5P0vD0E3nk5kTw63JFLON5PNnFD/0gCNbRS9V8bxvlVvbOqp6yd
	Ist46symXh6OuW+KWEokfaDoo6tQ1rC2R0yfyz3KHDnU24LlSFH6P1qMBw+8OOtab+JOaRm
	cteVUxoDLqYv7q/QcHsazrxbTHv8lLlAEvqiJNjk2J+cIug==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

The RK3399 EVB IND board has a Type-C interface DisplayPort. It use
fusb302 chip as Type-C controller.

This series focuses on adding TCPM support for USBDP PHY and DP driver.
Before this, the USBDP PHY and DP controller of RK3399 sensed state
changes through extcon, and devices such as the RK3399 Gru-Chromebook
rely on them. This series should not break them.

Patch1 add missing "displayport" prop for USB connector binding.
Patch2 add new Type-C mode/orientation switch for RK3399 USBDP phy
binding.
Patch3 add TCPM support for RK3399 USBDP PHY.
Patch4 add TCPM support for CDN-DP.
Patch5 add Type-C DP support for RK3399 EVB IND board.

Chaoyi Chen (5):
  dt-bindings: connector: Add displayport connector for hotplug notify
  dt-bindings: phy: rockchip: rk3399-typec-phy: Support mode/orientation
    switch
  phy: rockchip: phy-rockchip-typec: Add support for Type-C TCPM
  drm/rockchip: cdn-dp: Add support for Type-C TCPM
  arm64: dts: rockchip: rk3399-evb-ind: Add support for DisplayPort

 .../bindings/connector/usb-connector.yaml     |   4 +
 .../phy/rockchip,rk3399-typec-phy.yaml        |  14 +
 .../boot/dts/rockchip/rk3399-evb-ind.dts      | 119 +++++++
 drivers/gpu/drm/rockchip/cdn-dp-core.c        |  37 +-
 drivers/phy/rockchip/phy-rockchip-typec.c     | 335 +++++++++++++++++-
 5 files changed, 482 insertions(+), 27 deletions(-)

-- 
2.49.0



