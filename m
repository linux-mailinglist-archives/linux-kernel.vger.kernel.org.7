Return-Path: <linux-kernel+bounces-724784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C680EAFF6E2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 04:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D85B56679E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AF427F178;
	Thu, 10 Jul 2025 02:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Qz9PHANp"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A89226D18
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 02:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752115149; cv=none; b=n8kyfp6YMyXyjGFTgWvHw4iKDNk0Yxk5IDl/2E6DhG+DhU/n7liYFhrt1DT/8abH6eCZ2Vd77JCLIwngQ+YHBgozkEXGiTuKvNcxmkmxZN3uf/I7UIYlBLBd2CziK2FDD4i9y40+6yhkyaNpBMSMQu2q279ufpmunGOWcaF64bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752115149; c=relaxed/simple;
	bh=GF76M5E6hbbFm7aVsp0VBgRNPnxrrzDrIQh8Pm1szGU=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=l9R5cK94Mt4yO/XljYnxcq0UPnsAbtTUB/mqIwzD9RD8BUrsaIMuUXtru2dp2oqvpur+ZosQMxv2dat/QDE6xcJvu2W0c5eJoUsBD5ZgVr+dnKCAdHgQHFQbF90HtbdOa8DmaqYhgMhrsdOgrfI8L2mXqmk7sXzjGfqIWowwJ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Qz9PHANp; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752115145;
	bh=kzQmumURQa/WWjdaeL/eWLu8XO9uaBPc5m+hWTIurSU=;
	h=Subject:From:To:Cc:Date;
	b=Qz9PHANpkZmXhsQ1QpywiV3j6KHolnaUt+F88h8Uj72O0vrTQk27j0DMzsqBBHR8k
	 wrGPG+vDdxZyORnbwih1LVnTSxvztUt3omWFS1MpKZZi33fL8ulhSAl6P5hHjrOpY2
	 7dFiuliA3LUccGPHZ09dJSgef69Q56DiEOKS+XjA41+Ad27QBbvEi6hkt/NkvYu6LI
	 bWlz7agQVAfaoHFzVLFdumhta1EM4wy0bEKOHZ8rDyT4qWucB0foTh2HYd4QbiL/VA
	 LXnONg7yqdXDCYb6R/JIf/XLkXyrwdxZ9iD6gxjhgukqVgWZrgxcVRcogIbs/YFzRH
	 sT1HrpifSgZqw==
Received: from [192.168.68.112] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 632596508A;
	Thu, 10 Jul 2025 10:39:05 +0800 (AWST)
Message-ID: <36d50489cac1fbae01ec699b742f6c6c459a01cb.camel@codeconstruct.com.au>
Subject: [GIT PULL] aspeed: devicetree changes for 6.17
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: soc <soc@lists.linux.dev>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-aspeed
 <linux-aspeed@lists.ozlabs.org>, linux-kernel
 <linux-kernel@vger.kernel.org>,  Joel Stanley <joel@jms.id.au>
Date: Thu, 10 Jul 2025 12:09:04 +0930
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello SoC maintainers,

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494=
:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git tags/aspeed=
-6.17-devicetree-1

for you to fetch changes up to 1c15e359ba53b297ba5fd72bbf626ede72c3de3e:

  ARM: dts: aspeed: yosemite4: add gpio name for uart mux sel (2025-07-04 1=
3:28:25 +0930)

----------------------------------------------------------------
ASPEED devicetree updates for 6.17

Removed platforms:

- IBM's Swift BMC

New platforms:

- Meta's Santabarbara

  Santabarbara is a compute node with an accelerator module

- NVIDIA's GB200NVL BMC

  NVIDIA GB200 NVL72 connects 36 Grace CPUs and 72 Blackwell GPUs in an NVI=
DIA
  NVLink-connected, liquid-cooled, rack-scale design.

Updated BMC platforms:

- Bletchley (Meta): GPIO hog names, remove ethernet-phy node, USB PD negoti=
ation
- Catalina (Meta): Various sensors added, MCTP support for NIC management
- Harma (Meta): Various sensors added
- System1 (IBM): IPMB and various GPIO-related updates
- Yosemite4 (Meta): GPIO names for UART mux select lines

The System1 series includes a devicetree binding patch for IPMI IPMB device=
s.

----------------------------------------------------------------
Ankit Chauhan (1):
      ARM: dts: aspeed: lanyang: Fix 'lable' typo in LED nodes

Cosmo Chou (1):
      ARM: dts: aspeed: bletchley: enable USB PD negotiation

Fred Chen (2):
      dt-bindings: arm: aspeed: add Meta Santabarbara board
      ARM: dts: aspeed: santabarbara: Add Meta Santabarbara BMC

Joel Stanley (1):
      ARM: dts: aspeed: Remove swift machine

Krzysztof Kozlowski (1):
      ARM: dts: aspeed: Align GPIO hog name with bindings

Marshall Zhan (1):
      ARM: dts: aspeed: yosemite4: add gpio name for uart mux sel

Ninad Palsule (8):
      dt-bindings: ipmi: Add binding for IPMB device
      ARM: dts: aspeed: system1: Add IPMB device
      ARM: dts: aspeed: system1: Add GPIO line name
      ARM: dts: aspeed: system1: Reduce sgpio speed
      ARM: dts: aspeed: system1: Update LED gpio name
      ARM: dts: aspeed: system1: Remove VRs max8952
      ARM: dts: aspeed: system1: Mark GPIO line high/low
      ARM: dts: aspeed: system1: Disable gpio pull down

Peter Yin (5):
      ARM: dts: aspeed: harma: add E1.S power monitor
      ARM: dts: aspeed: harma: add fan board I/O expander
      ARM: dts: aspeed: harma: add ADC128D818 for voltage monitoring
      ARM: dts: aspeed: Harma: revise gpio bride pin for battery
      ARM: dts: aspeed: harma: add mmc health

Potin Lai (12):
      ARM: dts: aspeed: bletchley: remove unused ethernet-phy node
      ARM: dts: aspeed: catalina: Add IO Mezz board thermal sensor nodes
      ARM: dts: aspeed: catalina: Add Front IO board remote thermal sensor
      ARM: dts: aspeed: catalina: Add MP5990 power sensor node
      ARM: dts: aspeed: catalina: Add fan controller support
      ARM: dts: aspeed: catalina: Add second source fan controller support
      ARM: dts: aspeed: catalina: Add second source HSC node support
      ARM: dts: aspeed: catalina: Remove INA238 and INA230 nodes
      ARM: dts: aspeed: catalina: Enable multi-master on additional I2C bus=
es
      ARM: dts: aspeed: catalina: Update CBC FRU EEPROM I2C bus and address
      ARM: dts: aspeed: catalina: Enable MCTP support for NIC management
      ARM: dts: aspeed: catalina: Enable MCTP for frontend NIC management

Willie Thai (2):
      dt-bindings: arm: aspeed: add Nvidia's GB200NVL BMC
      ARM: dts: aspeed: Add device tree for Nvidia's GB200NVL BMC

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml        |    2 +
 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml            |   56 +++=
++
 arch/arm/boot/dts/aspeed/Makefile                               |    3 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts           |    2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-arm-stardragon4800-rep2.dts |    4 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts        |    2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-bytedance-g220a.dts         |    4 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts           |    2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts      |   71 +++=
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts       |  209 +++=
+++++++++----
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts          |   85 +++=
+++-
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts   |  982 +++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts      |   40 +++=
+
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts             |    2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts             |    2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts             |    4 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts             |  139 +++=
+++-----
 arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr630.dts            |   46 ++-=
-
 arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts         |   68 +++=
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts     | 1128 +++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts             |   18 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts              |   10 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts            |   40 ++-=
-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts             |    6 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts               |  974 ---=
-----------------------------------------------------------------------
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts               |    8 +-
 26 files changed, 2685 insertions(+), 1222 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarba=
ra.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc=
.dts
 delete mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts



