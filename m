Return-Path: <linux-kernel+bounces-825685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D228EB8C841
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 14:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5BA3B91DE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 12:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB671A0BF3;
	Sat, 20 Sep 2025 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdhGKz7i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381B918DB1F;
	Sat, 20 Sep 2025 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758371436; cv=none; b=lHnEpVjthv/4S4PVdTQIshvf1r0Ed+q35Gn57hLTgji+l53v8mYMgLaiaDbm1qiNwohtxoEg+U3Qz9XrrK8frYEHhCOIFT47cMXEJFw0O7J8Fp3qXBpnuHsBlR066S2YtimDTMpkYoseaEtTjdhYpKO1uurk9BT8oE7PSCFLspk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758371436; c=relaxed/simple;
	bh=azjtBgg9o8jYuuDI1h5t3q803QLZoJl/KPkMwExin3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cRkeMeCh5ZcoTbI87CI3yHzsqRMXAeuCg+rE0dTUqNJ3I2OgZmZhpISK1SCT9zvWypJNMfYjMkrSiuPfeosb53ZFgpz+6krx9CEsp6vOaiOHqTgWNas+3p4GgZMTGNwk82HFcHLthSyo4C+Suuv2A0Qy7shxy8RIxgPpXeTLxeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdhGKz7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCFDC4CEF7;
	Sat, 20 Sep 2025 12:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758371435;
	bh=azjtBgg9o8jYuuDI1h5t3q803QLZoJl/KPkMwExin3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WdhGKz7iOT5/i+kSqRcvVLN0ApfKvwUHjabdMZZkluxpQS4s8a5ZO5IfGeeWreasd
	 XBBCb6SM3dB/AJGmxHS4IqWdcO7RqRHwnAJnq9zoiuL9qlsMmFIaA8QOJgYx+3v3KD
	 bNu6qek6IRu5gikpFrHfZSA1WlU5Lnqa2AtqBgrRZRqvhivoPc183l++Q32VkAqGif
	 0tiVu8KV+8f+DuvrTBQASDuWqmcFmGf5SUj6xBPou5Ev+COuKRQxaC8us+3dtxEcDc
	 vC37tUxMrNomi4UT/dK5Ya2SF3REei3TlNDUS1VoCYBHlmjR2BKGSuhhy445I8kRrK
	 khr2nSvs2EmMg==
From: Sven Peter <sven@kernel.org>
To: soc@lists.linux.dev
Cc: asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 2/2] Apple SoC DTS changes for v6.18
Date: Sat, 20 Sep 2025 14:30:28 +0200
Message-Id: <20250920123028.49973-2-sven@kernel.org>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250920123028.49973-1-sven@kernel.org>
References: <20250920123028.49973-1-sven@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 4379305ffbc2eebe3de673fc965145d441c89b8f:

  arm64: dts: apple: t600x: Add SMC node (2025-08-10 20:21:57 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sven/linux.git tags/apple-soc-dt-6.18-part2

for you to fetch changes up to 70fa521f4d55127c85d7c2defe8c20be75e29efd:

  arm64: dts: apple: t8015: Add SPMI node (2025-09-18 21:13:45 +0200)

----------------------------------------------------------------
Apple SoC DTS updates for 6.18, part 2

- New device trees for all M2 Pro, Max and Ultra models are added.
  This is responsible for most of the changed lines since we already
  need 2000+ lines just to describe all the power domains inside
  t602x-pmgr.dtsi for these SoCs.
- Missing WiFi properties for t600x are added.
- Bluetooth nodes are added for all t600x machines.
- The PCIe ethernet iommu-map was fixed for the Apple M1 iMac
  to account for a disabled PCIe port.
- SPMI, NVMe, SART and mailbox nodes for Apple's T2 and A11.

----------------------------------------------------------------
Hector Martin (5):
      arm64: dts: apple: t600x: Add missing WiFi properties
      arm64: dts: apple: t600x: Add bluetooth device nodes
      arm64: dts: apple: Add initial t6020/t6021/t6022 DTs
      arm64: dts: apple: Add J414 and J416 Macbook Pro device trees
      arm64: dts: apple: Add J180d (Mac Pro, M2 Ultra, 2023) device tree

Janne Grunau (6):
      arm64: dts: apple: t8103-j457: Fix PCIe ethernet iommu-map
      dt-bindings: arm: apple: Add t8112 j415 compatible
      arm64: dts: apple: Add devicetreee for t8112-j415
      dt-bindings: arm: apple: Add t6020x compatibles
      arm64: dts: apple: Add ethernet0 alias for J375 template
      arm64: dts: apple: Add J474s, J475c and J475d device trees

Nick Chan (4):
      arm64: dts: apple: t8015: Fix PCIE power domains dependencies
      arm64: dts: apple: t8015: Add NVMe nodes
      arm64: dts: apple: t8012: Add SPMI node
      arm64: dts: apple: t8015: Add SPMI node

 Documentation/devicetree/bindings/arm/apple.yaml |   41 +-
 arch/arm64/boot/dts/apple/Makefile               |    9 +
 arch/arm64/boot/dts/apple/t6000-j314s.dts        |    8 +
 arch/arm64/boot/dts/apple/t6000-j316s.dts        |    8 +
 arch/arm64/boot/dts/apple/t6001-j314c.dts        |    8 +
 arch/arm64/boot/dts/apple/t6001-j316c.dts        |    8 +
 arch/arm64/boot/dts/apple/t6001-j375c.dts        |    8 +
 arch/arm64/boot/dts/apple/t6002-j375d.dts        |    8 +
 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi   |   10 +
 arch/arm64/boot/dts/apple/t600x-j375.dtsi        |   11 +
 arch/arm64/boot/dts/apple/t6020-j414s.dts        |   26 +
 arch/arm64/boot/dts/apple/t6020-j416s.dts        |   26 +
 arch/arm64/boot/dts/apple/t6020-j474s.dts        |   47 +
 arch/arm64/boot/dts/apple/t6020.dtsi             |   22 +
 arch/arm64/boot/dts/apple/t6021-j414c.dts        |   26 +
 arch/arm64/boot/dts/apple/t6021-j416c.dts        |   26 +
 arch/arm64/boot/dts/apple/t6021-j475c.dts        |   37 +
 arch/arm64/boot/dts/apple/t6021.dtsi             |   69 +
 arch/arm64/boot/dts/apple/t6022-j180d.dts        |  121 ++
 arch/arm64/boot/dts/apple/t6022-j475d.dts        |   42 +
 arch/arm64/boot/dts/apple/t6022-jxxxd.dtsi       |   38 +
 arch/arm64/boot/dts/apple/t6022.dtsi             |  349 ++++
 arch/arm64/boot/dts/apple/t602x-common.dtsi      |  465 +++++
 arch/arm64/boot/dts/apple/t602x-die0.dtsi        |  575 ++++++
 arch/arm64/boot/dts/apple/t602x-dieX.dtsi        |  128 ++
 arch/arm64/boot/dts/apple/t602x-gpio-pins.dtsi   |   81 +
 arch/arm64/boot/dts/apple/t602x-j414-j416.dtsi   |   45 +
 arch/arm64/boot/dts/apple/t602x-j474-j475.dtsi   |   38 +
 arch/arm64/boot/dts/apple/t602x-nvme.dtsi        |   42 +
 arch/arm64/boot/dts/apple/t602x-pmgr.dtsi        | 2265 ++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8012.dtsi             |    8 +
 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi        |    1 +
 arch/arm64/boot/dts/apple/t8015.dtsi             |   42 +
 arch/arm64/boot/dts/apple/t8103-j457.dts         |   12 +-
 arch/arm64/boot/dts/apple/t8112-j415.dts         |   80 +
 35 files changed, 4727 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/boot/dts/apple/t6020-j414s.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6020-j416s.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6020-j474s.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6020.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t6021-j414c.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6021-j416c.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6021-j475c.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6021.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t6022-j180d.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6022-j475d.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6022-jxxxd.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t6022.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t602x-common.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t602x-die0.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t602x-dieX.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t602x-gpio-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t602x-j414-j416.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t602x-j474-j475.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t602x-nvme.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t602x-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8112-j415.dts

