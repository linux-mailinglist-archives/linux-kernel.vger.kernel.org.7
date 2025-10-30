Return-Path: <linux-kernel+bounces-879259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A717DC22A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830124612B2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEB133BBBC;
	Thu, 30 Oct 2025 23:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="DyVQKM9A"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDAF33B6E4
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761865831; cv=none; b=IEBmrIJRmIkq/EUpaoJhQs8CLSkqGvp1VYvS43AHN1YDmQkB9UzMCxpsF2Hmy4mncUv5jlKGAyQKhNtOk9N0d//UjSeE446lN4WXZh44lKDeepvg4yd1Ve0aKoWt6K3xh0ZZfBDSUgO/3+XaJ5/tlJ9q3/IfaJaNyzNyMg7KpwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761865831; c=relaxed/simple;
	bh=cZhuNO7QWzS4+SMkxGfliO0rBMVSjnGz40sl2s/wftM=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=UxZ3ut83NUrZZrTFyw/JrOS+dpfA0ZrSVWqRVDCzYfej+ZMqOvAJnpqEzyK3ogX0GxswM+Vpz+3/lguRlc1Wo9KrXvk4oyAaWMd9914iu7SR9LNJyHRCxY0ftVMzvAzhXDjPQei91xC3JIXn8hamVmYQFpjy1UrkrC7CouM1OuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=DyVQKM9A; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1761865827;
	bh=88KBlL4xUTV7siG+o+5Td6u+tNx+n4ecg/FuEBRQIzg=;
	h=Subject:From:To:Cc:Date;
	b=DyVQKM9AN351thCoS8lCuUYSZbGE3zHkEb1My2e1PTyKyUc4BKNLPTaBen5Uj9+Zx
	 Tf61VjJJH8VUfWMAmIG+MzBqGRvacQmjxpE3QmZh/OV8GIvjLBnqrJiTaOTaEN9I0x
	 xnZEdWwRfuF4rHGF9wzEWsGXHdplY/6rh1B/5k+m7Zy6Uw1Rz6zwqFEUArJgWaBGkm
	 bjY0cjy1YqQcrtQ/C70eCsbvIy7Ddis84NYNxM9VzbWfn1/rsuKvZ+dA1kSiaSrF9O
	 +MyzJjRDTnDG8HSHgtBAWcK5qSZz02oVJTDU7i/Bu6vhMK3g/m3qjpft6yLlNHpRgS
	 yomLHRmC3I/gw==
Received: from [IPv6:2405:6e00:2421:7372:17cf:8b2f:ac7e:ac4d] (unknown [120.20.6.198])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9C2D278C99;
	Fri, 31 Oct 2025 07:10:26 +0800 (AWST)
Message-ID: <d2bd7e3e6045ac68875fd220e528c76f4fb2faac.camel@codeconstruct.com.au>
Subject: [GIT PULL] aspeed: First batch of devicetree changes for 6.19
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: soc <soc@lists.linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Date: Fri, 31 Oct 2025 09:40:25 +1030
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello SoC maintainers,

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787=
:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git tags/aspeed=
-6.19-devicetree-0

for you to fetch changes up to 6953afcd81a2cc73784e3dd23faa0a1aaf97441a:

  ARM: dts: aspeed: santabarbara: Add eeprom device node for PRoT module (2=
025-10-17 16:44:13 +1030)

----------------------------------------------------------------
First batch of ASPEED Arm devicetree changes for 6.19

Significant changes:

- The IBM Power11 FSI DTSIs have been rearranged to accommodate new systems

New platforms:

- IBM Balcones

  The Balcones system is similar to Bonnell but with a POWER11 processor.
  Like POWER10, the POWER11 is a dual-chip module, so a dual chip FSI
  tree is needed.

- Meta Yosemite5

  The Yosemite5 platform provides monitoring of voltages, power,
  temperatures, and other critical parameters across the motherboard,
  CXL board, E1.S expansion board, and NIC components.

Updated platforms:

- clemente (Meta): LEDs, shunt resistor configuration
- santabarbara (Meta): AMD APML, EEPROMs, LEDs, GPIO line names, MCTP for N=
ICs

There are a scattering of one-off changes and devicetree cleanups for other
platforms as well.

----------------------------------------------------------------
Daniel Hsu (1):
      ARM: dts: aspeed: harma: Add MCTP I2C controller node

Eddie James (4):
      dt-bindings: arm: aspeed: add IBM Balcones board
      dt-bindings: arm: aspeed: add IBM Bonnell board
      ARM: dts: aspeed: Add Balcones system
      ARM: dts: aspeed: Fix max31785 fan properties

Fred Chen (7):
      ARM: dts: aspeed: santabarbara: Add blank lines between nodes for rea=
dability
      ARM: dts: aspeed: santabarbara: Add sensor support for extension boar=
ds
      ARM: dts: aspeed: santabarbara: Enable MCTP for frontend NIC
      ARM: dts: aspeed: santabarbara: Add bmc_ready_noled Led
      ARM: dts: aspeed: santabarbara: Add gpio line name
      ARM: dts: aspeed: santabarbara: Add AMD APML interface support
      ARM: dts: aspeed: santabarbara: Add eeprom device node for PRoT modul=
e

Kevin Tung (2):
      dt-bindings: arm: aspeed: add Meta Yosemite5 board
      ARM: dts: aspeed: yosemite5: Add Meta Yosemite5 BMC

Leo Wang (2):
      ARM: dts: aspeed: clemente: add shunt-resistor-micro-ohms for LM5066i
      ARM: dts: aspeed: clemente: Add HDD LED GPIO

Zane Li (1):
      ARM: dts: aspeed: yosemite4: allocate ramoops for kernel panic

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml      |    3 +
 arch/arm/boot/dts/aspeed/Makefile                             |    2 +
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts     |    9 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts        |    8 +
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts |  919 +++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts    |   14 ++
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts    | 1067 +++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dts          |  609 +++++=
+++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts           |    4 -
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts           |    8 -
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts           |   12 -
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts            |   36 ---
 arch/arm/boot/dts/aspeed/ibm-power11-dual.dtsi                |  779 +++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi                |  769 +----=
----------------------------------------------------------
 14 files changed, 3405 insertions(+), 834 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.=
dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dts
 create mode 100644 arch/arm/boot/dts/aspeed/ibm-power11-dual.dtsi


