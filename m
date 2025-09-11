Return-Path: <linux-kernel+bounces-812625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4F0B53AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B99E3AF9E0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D0B3629AA;
	Thu, 11 Sep 2025 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQLC+z74"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3976541A8F;
	Thu, 11 Sep 2025 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757612834; cv=none; b=D8siiczNkIO7u/rVbp5mbAbzRtnYacBjF08W8dX7Nq85gqBlERUo7l4ajMzOFugNeuE5I2INVp6LA/y+07N5GKo3RxtRyjvkNMHuw0O4U6A3F9PwlGYSgderRrbYPGWxSC0qE009qb/1GO4Gv3Z6uMN2AKsGcBdl3/wfpbYWCrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757612834; c=relaxed/simple;
	bh=oaKCNu1HF5irjj2VLGgmBQ3NkJiDvAYpfZnXM+otFg8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ja124Pxt8AxPF45eKGz2jojNCI1m5ubrDH9MDvcwpmunzdnUXoVFkCHzlTedDNYZnmF/2JUlLhQ4u/HWDDAzrXkYKMHHNnpR6fLw+TBfQw/cUch8ZHDDaIwzwI1v2GM/6bhXQ+iEM/egkI8E9NgCVbshIzTQ1BUoPlCAP8z2S0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQLC+z74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF892C4CEF0;
	Thu, 11 Sep 2025 17:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757612833;
	bh=oaKCNu1HF5irjj2VLGgmBQ3NkJiDvAYpfZnXM+otFg8=;
	h=From:To:Cc:Subject:Date:From;
	b=OQLC+z74ZpongU6i4YQkD1W9RX24SDvIFBQAKIdz/HxDI1QMPjybvcLk4KeH0t0rF
	 W1Pd6wwVHr4wceqiIh/SL9uYMN/X6onHspCCvNJ7PjuLF9vaRaL22pvrB4pbq5yIL9
	 h1F2OqacHBUp5e2KYggoukjTY1W6VzHJO3tagaSIX5GkSmPjoNDZrqZ89AkONcnQwM
	 8GxShsOwSG1AiR0cMK5K19chv9po/GkW2nW93ksaSWJMp01Dc1C1V/HDLoCuiXE4jz
	 eEtXpcQW1uag5zwwTdJlZKJnJiLhNFVJ6l24Dk3/Ii8bEsMj3DCDxzPGXPkZSKqxgS
	 xC29Pw4Rknu5Q==
Received: by wens.tw (Postfix, from userid 1000)
	id BD1D25FBFA; Fri, 12 Sep 2025 01:47:11 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-sunxi@lists.linux.dev,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] arm64: allwinner: a523: Enable MCU PRCM and NPU
Date: Fri, 12 Sep 2025 01:47:03 +0800
Message-Id: <20250911174710.3149589-1-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

Hi folks,

This is v2 of my A523 MCU PRCM and NPU support series.

Changes since v1:
- Dropped dual divider clock rate read-back fix that is already merged
- DT binding
  - Moved "r-ahb" clock to the end of the list and added "r-apb0" clock
- Add NPU clk
  - Move .num to after list of clks
- MCU CCU clk driver
  - Added comment for "fixed" dividers in audio PLL clock
  - Corrected variable names for audio PLL divider clocks
  - Added comment for the reversed order of some of the DSP clock's
    parents when compared to the manual
  - Added comments for clocks and resets only found in the BSP driver
  - Corrected register offset for i2s3-asrc and bus-mcu-pwm0 clocks
  - Made "r-ahb" and new "r-apb0" external bus clocks the parents of the
    bus gate clocks, with comments if guessed which one applies
  - Moved .num_clks to after the list of clocks, making it obvious that
    the value needs to be added if more clocks are added to the list
- MCU CCU DT node
  - Enlarged MCU PRCM register range to 0x200
  - Moved "r-ahb" clock to the end of the list and added "r-apb0" clock
- Link to v1
  https://lore.kernel.org/all/20250830170901.1996227-1-wens@kernel.org/


The MCU PRCM is a Power, Reset & Clock Management block that has some
clock and reset controls for the MCU, DSP and some peripherals that the
MCU could use.

The NPU is a Vivante IP block. It is clocked from the NPU PLL from the
main clock unit, but the bus clock and reset controls lie in the MCU
PRCM.

Patch 1 adds the missing NPU module clock to the main clock control
unit's binding.

Patch 2 adds the binding for the MCU PRCM clock control unit

Patch 3 adds the missing NPU module clock.

Patch 4 adds support for power-of-two dividers to the sunxi-ng clk
library.

Patch 5 adds a new driver for the A523 MCU PRCM CCU.

Patch 6 adds a device node for the MCU PRCM CCU.

Patch 7 adds a device node for the NPU.

The NPU was only lightly tested: the driver correctly probes and detects
a model GC9000, revision 9003.

Please have a look. All patches will be merged through the sunxi tree.


Thanks
ChenYu


Chen-Yu Tsai (7):
  dt-bindings: clock: sun55i-a523-ccu: Add missing NPU module clock
  dt-bindings: clock: sun55i-a523-ccu: Add A523 MCU CCU clock controller
  clk: sunxi-ng: sun55i-a523-ccu: Add missing NPU module clock
  clk: sunxi-ng: div: support power-of-two dividers
  clk: sunxi-ng: add support for the A523/T527 MCU CCU
  arm64: dts: allwinner: a523: Add MCU PRCM CCU node
  arm64: dts: allwinner: a523: Add NPU device node

 .../clock/allwinner,sun55i-a523-ccu.yaml      |  37 +-
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi |  39 ++
 drivers/clk/sunxi-ng/Kconfig                  |   5 +
 drivers/clk/sunxi-ng/Makefile                 |   2 +
 drivers/clk/sunxi-ng/ccu-sun55i-a523-mcu.c    | 469 ++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun55i-a523.c        |  21 +-
 drivers/clk/sunxi-ng/ccu-sun55i-a523.h        |  14 -
 drivers/clk/sunxi-ng/ccu_div.h                |  18 +
 include/dt-bindings/clock/sun55i-a523-ccu.h   |   1 +
 .../dt-bindings/clock/sun55i-a523-mcu-ccu.h   |  54 ++
 .../dt-bindings/reset/sun55i-a523-mcu-ccu.h   |  30 ++
 11 files changed, 671 insertions(+), 19 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523-mcu.c
 delete mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523.h
 create mode 100644 include/dt-bindings/clock/sun55i-a523-mcu-ccu.h
 create mode 100644 include/dt-bindings/reset/sun55i-a523-mcu-ccu.h

-- 
2.39.5


