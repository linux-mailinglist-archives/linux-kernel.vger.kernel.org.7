Return-Path: <linux-kernel+bounces-764315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C186B2216F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82AF81B65F82
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06952E54A1;
	Tue, 12 Aug 2025 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="KeB6nkkx"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714342E2853;
	Tue, 12 Aug 2025 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987555; cv=none; b=eeGfd6j72noqe68odspOEp+MYn6/ut45kAgHTSZ5hlyYzCl/85RMElc7AunhjW50C5rhWyvlidQ3x7/kffcg7lqBJDLaHJubgugnNbK8vrSOKh+pRB6zbl4wE+IiajzIMDGhl68eT4DuD2xL99UZHxyl082Uif2tMzY38cbfw00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987555; c=relaxed/simple;
	bh=6BSHWnUCmKK761l0Jf8Sz/mVRy22H4iNNlajbyBDS/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e2hVzNkejLKX84VWqcminNyljWB9/PckvGh0HLINDgwAR1cuSlXjjYW7vfvApt4gOhDYDCyHDolt9gGq+DDNbYfQOghpX6K8ovlrPizP7QdPI25sSL+pJ1orJpE6YgjloHV1HcP0xKC1AE9NouskrwrF5qWOJPMHpKeSzwHVgzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=KeB6nkkx; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=iQpTDZH7lXr4FoO7KJPIkTJ/j35kWz/ImE22PyEPmP8=; b=KeB6nkkxVQZcgot7no6Ky4uaBg
	9fqcPV0af4CxhF5cseNcv1gzT3uMp/XF3D2hkwKqpZtwIMkgyc6DE0S5oRhWrpkxswYDQf/3qLSrG
	GIn6REpbTezPkUdE9niV3T3rjQO8NZWnBXePAnjfurX48QacpszCt+9pyvln+FYvtW8513lEFKEzR
	fqhPdjyVoZOrlxi+qL0AWefVTaT37vKfcabQ8+KsJ1esDakSAarOoI9qeVoPOFEoPCArZ3cojpdhq
	nN9A89qt80+ZoZsHyBpiCZyv3d/vG0hN9EMgoohtfykIEfgQeX24nYQqPVT/fKMIuRk7HrJbCeJhO
	5cGqrhqg==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ulkQc-0001tw-Hq; Tue, 12 Aug 2025 10:32:18 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	quentin.schulz@cherry.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	damon.ding@rock-chips.com
Subject: [PATCH v3 0/2] Add RK3588 Tiger DisplayPort carrier
Date: Tue, 12 Aug 2025 10:32:15 +0200
Message-ID: <20250812083217.1064185-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A board that allows easy testing of the Analogix eDP controller on the
RK3588. Requires Damon's recent work on allowing bridges in the
Rockchip variant of the controller driver [0].

Concerning displays, my current setup is

  DP-carrier -> DP-port -> DP-to-eDP converter from Aliexpress -> eDP panel

which produces a nice 1080p image, but it seems Quentin's experience was
not as nice, as he reported in v2 [1] that his two test monitors produced
dfferent tints, but not real output with:

green tint on a Iiyama ProLite XU2294HSU and purple tint on a Dell P2319H


changes in v3:
- rebase on top of 6.17-rc1
- still should wait on the analogix bridge support

changes in v2:
- collect Ack/Review for binding
- address Quentin's comments
  - sorting in Makefile and dp-connector properties
  - ethernet alias
  - drop data-lanes comment

[0] https://lore.kernel.org/dri-devel/20250709070139.3130635-1-damon.ding@rock-chips.com/
[0] https://lore.kernel.org/linux-rockchip/0582b7bc-e5b2-4b5e-821e-8d2c4301579f@cherry.de
Heiko Stuebner (2):
  dt-bindings: arm: rockchip: add RK3588 DP carrier from Theobroma
    Systems
  arm64: dts: rockchip: add RK3588 DP carrier from Theobroma Systems

 .../devicetree/bindings/arm/rockchip.yaml     |   6 +-
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../rk3588-tiger-displayport-carrier.dts      | 109 ++++++++++++++++++
 3 files changed, 114 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-tiger-displayport-carrier.dts

-- 
2.47.2


