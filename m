Return-Path: <linux-kernel+bounces-793076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC59DB3CDDE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 19:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3C456275C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 17:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF782D46B1;
	Sat, 30 Aug 2025 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQ2FDKUq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EEC2D063A;
	Sat, 30 Aug 2025 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756573760; cv=none; b=UNalbwBe16tgQDqpZgL+ssjApCYIv4EHQ4f0ugpTLnahsfBR0MIVY6XUd0LmhNTKgIXGAt3ghRXMams58cZ7U03GIcs3NIYOdIzb9GPpz3jEsVYdzeivj/ojZQu4f+Y01eprZCSFsIN1MDDUAw5kYOKr8eMI8eEgYSPJk0Sm0es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756573760; c=relaxed/simple;
	bh=Ga5zxO8ZZi+LW2SUjQleCojdx++Hf4rCOMhtGWIYz9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rC0Xhrkm44llwaZU+3aSzgHodeEX3ftSKqyYLLbMbay1+UlX9ZphFPe40DZzoVJCBGx23an8kkejIsOQAwu2YMLkexQl9O273+AvN57AV1Bs+aYbumZn7XYqPsAzFO6h8yub0AHvX1Mna4jIdxmqDUBbuvOyFTk7BPKoivG/ejk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQ2FDKUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4497C4AF09;
	Sat, 30 Aug 2025 17:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756573759;
	bh=Ga5zxO8ZZi+LW2SUjQleCojdx++Hf4rCOMhtGWIYz9Q=;
	h=From:To:Cc:Subject:Date:From;
	b=bQ2FDKUqku3BPMUozZpMqtcXYNpl952VOteqh2Kz7kyy5GaCFNg6Anu3FSIx6GLge
	 e6jMuRn0bQ9pcJnNkXi18aV+xpp/w0A+0tBPPCJao2mP1M9w2Gjyg/UoAECXoT+tuy
	 UAnfu7PHDQ3y85TXVjdTHOxw1SfEA0Iih5p9R3sYbAkl3PDBM7ppmqA5ka3AuOap64
	 kPKEuzoW2XRfhYgmQPRpN1ZyAX56gPs6N0sJDNXNk23I9o3w13JUglKufd7/PQhC2a
	 ioj0IR11U99jqDCnA3O1tBVYPszz0kHXA3r3nnCxrVs5PAffxn5a421VzhUTx1odVX
	 /WXp5e6KJslSw==
Received: by wens.tw (Postfix, from userid 1000)
	id 0C00C5FCC4; Sun, 31 Aug 2025 01:09:17 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-sunxi@lists.linux.dev,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] arm64: allwinner: a523: Enable MCU PRCM and NPU
Date: Sun, 31 Aug 2025 01:08:53 +0800
Message-Id: <20250830170901.1996227-1-wens@kernel.org>
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

This series adds support for the MCU PRCM and the NPU.

The MCU PRCM is a Power, Reset & Clock Management block that has some
clock and reset controls for the MCU, DSP and some peripherals that the
MCU could use.

The NPU is a Vivante IP block. It is clocked from the NPU PLL from the
main clock unit, but the bus clock and reset controls lie in the MCU
PRCM.

Patch 1 adds the missing NPU module clock to the main clock control
unit's binding.

Patch 2 adds the binding for the MCU PRCM clock control unit

Patch 3 fixes clock rate readback for the new dual-divider type added
with the A523 family.

Patch 4 adds the missing NPU module clock.

Patch 5 adds support for power-of-two dividers to the sunxi-ng clk
library.

Patch 6 adds a new driver for the A523 MCU PRCM CCU.

Patch 7 adds a device node for the MCU PRCM CCU.

Patch 8 adds a device node for the NPU.

The NPU was only lightly tested: the driver correctly probes and detects
a model GC9000, revision 9003.

Please have a look. All patches will be merged through the sunxi tree.


Thanks
ChenYu


Chen-Yu Tsai (8):
  dt-bindings: clock: sun55i-a523-ccu: Add missing NPU module clock
  dt-bindings: clock: sun55i-a523-ccu: Add A523 MCU CCU clock controller
  clk: sunxi-ng: mp: Fix dual-divider clock rate readback
  clk: sunxi-ng: sun55i-a523-ccu: Add missing NPU module clock
  clk: sunxi-ng: div: support power-of-two dividers
  clk: sunxi-ng: add support for the A523/T527 MCU CCU
  arm64: dts: allwinner: a523: Add MCU PRCM CCU node
  arm64: dts: allwinner: a523: Add NPU device node

 .../clock/allwinner,sun55i-a523-ccu.yaml      |  35 +-
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi |  37 ++
 drivers/clk/sunxi-ng/Kconfig                  |   5 +
 drivers/clk/sunxi-ng/Makefile                 |   2 +
 drivers/clk/sunxi-ng/ccu-sun55i-a523-mcu.c    | 447 ++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun55i-a523.c        |  21 +-
 drivers/clk/sunxi-ng/ccu-sun55i-a523.h        |  14 -
 drivers/clk/sunxi-ng/ccu_div.h                |  18 +
 drivers/clk/sunxi-ng/ccu_mp.c                 |   2 +-
 include/dt-bindings/clock/sun55i-a523-ccu.h   |   1 +
 .../dt-bindings/clock/sun55i-a523-mcu-ccu.h   |  54 +++
 .../dt-bindings/reset/sun55i-a523-mcu-ccu.h   |  30 ++
 12 files changed, 646 insertions(+), 20 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523-mcu.c
 delete mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523.h
 create mode 100644 include/dt-bindings/clock/sun55i-a523-mcu-ccu.h
 create mode 100644 include/dt-bindings/reset/sun55i-a523-mcu-ccu.h

-- 
2.39.5


