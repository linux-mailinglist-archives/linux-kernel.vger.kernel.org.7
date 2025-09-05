Return-Path: <linux-kernel+bounces-801921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 267F4B44BA3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8513486C4D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C099225761;
	Fri,  5 Sep 2025 02:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3PJ6H8y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDF221D3D2;
	Fri,  5 Sep 2025 02:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757039567; cv=none; b=ajzf3GnUfWtQuS5c8rSuTM6Y50s10lzFcEQ2ZJhX/+3p+tzT2BdNacJvkArlrQ/VAtFYYSgkkYIO3FMlGCXAZGRPIQxXb4PVhHQRCDndiMM5y/v8kI3dkwFOJx7/NKdzqh3NCLfj+8XkEWDhaR4A/fXej0mt15XzSIjVTu/KaCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757039567; c=relaxed/simple;
	bh=GPaD+K1HwBec1AzBnycvX5KKxlacm+uHk4fgWkMm9ak=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=jl0yJH+n/mlJznGZJyNKICQrzPrn++zPBByABoBB/LkR6q2rQZ8838qndxu+3xuJU/mUCiQ4obMIAZw6PS+rAV4+Hd2fYAdHQTP3lD8Os4Z9NgyTv09ucjrL3jyZQD0o4v8VAhAhco5dHhGhPUKYdoBeJihKtg5Esk7mZ8PIdWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3PJ6H8y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A026C4CEF5;
	Fri,  5 Sep 2025 02:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757039567;
	bh=GPaD+K1HwBec1AzBnycvX5KKxlacm+uHk4fgWkMm9ak=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=V3PJ6H8yna7ghufxtWVbzbsZYOFev3/I9T48P6ykKzw9xhLIdq9ThxyOJ1Ud+Z4Zk
	 tDwixER9hZNANWU4G8F12wY7aFU60ZZH0kNxmiGp+KqmnKd8syD8lShiV1LIhdZHwW
	 pVXrEAqM15OYPrqffl8MaDA2fIsGhgsp1ijRR4ry6cwop7AgcxCkqhZj4jVb/jdYBO
	 5qqpZkUsi5zBemLcl8dTqJmY4uJjwScp/Kyd8iMOw1ttmzH/NzrkNhQzsWfJCf7LtE
	 dkto+S4r4q+Ul/p5YFhMsbFIayNHIs3oPFnwWSvQQWBB9XOayRJ9wfuAqWqSbAwq6s
	 pFGVYpre8tj5Q==
Date: Thu, 04 Sep 2025 21:32:46 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: vishalm@ti.com, kristo@kernel.org, conor+dt@kernel.org, 
 linux-arm-kernel@lists.infradead.org, khilman@baylibre.com, d-gole@ti.com, 
 vigneshr@ti.com, a-kaur@ti.com, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, msp@baylibre.com, sebin.francis@ti.com, 
 krzk+dt@kernel.org, nm@ti.com
To: Kendall Willis <k-willis@ti.com>
In-Reply-To: <20250904212827.3730314-1-k-willis@ti.com>
References: <20250904212827.3730314-1-k-willis@ti.com>
Message-Id: <175703941947.745257.14151418968229633072.robh@kernel.org>
Subject: Re: [PATCH 0/3] arm64: dts: ti: k3-am62: Support Main UART wakeup


On Thu, 04 Sep 2025 16:28:24 -0500, Kendall Willis wrote:
> This series adds wakeup support for the Main UART in the device tree of
> the TI AM62 family of devices. It defines the specific pins and pinctrl
> states needed to wakeup the system from the Main UART via I/O
> daisy-chaining. The wakeup-source property is configured to describe the
> low power modes the system can wakeup from using the Main UART.
> 
> Dependencies
> ------------
> This series is dependent on the following series [1] to be merged into
> the kernel. The series adds the system idle states that are available on
> the SoCs. The system idle states are used when configuring the
> wakeup-source property.
> 
> This series is also dependent on the following patch [2] to be merged
> into the kernel. The patch integrates the PIN_WKUP_EN macro which
> enables the WKUP_EN bit.
> 
> Implementation
> --------------
> This series is intended to be implemented along with the following
> series:
> 
> 1. "pmdomain: ti_sci: Handle wakeup constraint if device has pinctrl
>    wakeup state": Patch which skips setting constraints for wakeup sources
>    that use pinctrl state 'wakeup'.
> 
> 2. "serial: 8250: omap: Add wakeup support": Implements
>    wakeup from the UARTs for TI K3 SoCs
> 
> 3. "arm64: dts: ti: k3-am62: Support Main UART wakeup": (this series)
>    implements the functionality to wakeup the system from the Main UART
> 
> Testing
> -------
> Tested on a SK-AM62B-P1 board with all series and dependencies
> implemented. Suspend/resume verified with the Main UART wakeup source
> by entering a keypress on the console.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20250812-topic-am62-dt-partialio-v6-15-v2-2-25352364a0ac@baylibre.com/
> [2] https://lore.kernel.org/all/20250904112538.529857-4-a-kaur@ti.com/
> 
> Kendall Willis (3):
>   arm64: dts: ti: k3-am62x-sk-common: Enable Main UART wakeup
>   arm64: dts: ti: k3-am62a7-sk: Enable Main UART wakeup
>   arm64: dts: ti: k3-am62p5-sk: Enable Main UART wakeup
> 
>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts       | 24 +++++++++++++++----
>  arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       | 24 +++++++++++++++----
>  .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 24 +++++++++++++++----
>  3 files changed, 60 insertions(+), 12 deletions(-)
> 
> 
> base-commit: 4ac65880ebca1b68495bd8704263b26c050ac010
> --
> 2.34.1
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: using specified base-commit 4ac65880ebca1b68495bd8704263b26c050ac010

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/ti/' for 20250904212827.3730314-1-k-willis@ti.com:

Lexical error: arch/arm64/boot/dts/ti/k3-am62a7-sk.dts:313.71-82 Unexpected 'PIN_WKUP_EN'
FATAL ERROR: Syntax error parsing input tree
make[3]: *** [scripts/Makefile.dtbs:132: arch/arm64/boot/dts/ti/k3-am62a7-sk.dtb] Error 1
make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/ti] Error 2
make[2]: Target 'arch/arm64/boot/dts/ti/k3-am62a7-sk.dtb' not remade because of errors.
Lexical error: arch/arm64/boot/dts/ti/k3-am62p5-sk.dts:359.71-82 Unexpected 'PIN_WKUP_EN'
FATAL ERROR: Syntax error parsing input tree
make[3]: *** [scripts/Makefile.dtbs:132: arch/arm64/boot/dts/ti/k3-am62p5-sk.dtb] Error 1
make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/ti] Error 2
make[2]: Target 'arch/arm64/boot/dts/ti/k3-am62p5-sk.dtb' not remade because of errors.
make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1478: ti/k3-am62p5-sk.dtb] Error 2
make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1478: ti/k3-am62a7-sk.dtb] Error 2
Lexical error: arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi:182.71-82 Unexpected 'PIN_WKUP_EN'
FATAL ERROR: Syntax error parsing input tree
make[3]: *** [scripts/Makefile.dtbs:132: arch/arm64/boot/dts/ti/k3-am62-lp-sk.dtb] Error 1
make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/ti] Error 2
make[2]: Target 'arch/arm64/boot/dts/ti/k3-am62-lp-sk.dtb' not remade because of errors.
make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1478: ti/k3-am62-lp-sk.dtb] Error 2
Lexical error: arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi:182.71-82 Unexpected 'PIN_WKUP_EN'
FATAL ERROR: Syntax error parsing input tree
make[3]: *** [scripts/Makefile.dtbs:132: arch/arm64/boot/dts/ti/k3-am625-sk.dtb] Error 1
make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/ti] Error 2
make[2]: Target 'arch/arm64/boot/dts/ti/k3-am625-sk.dtb' not remade because of errors.
make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1478: ti/k3-am625-sk.dtb] Error 2
make: *** [Makefile:248: __sub-make] Error 2
make: Target 'ti/k3-am625-verdin-wifi-ivy.dtb' not remade because of errors.
make: Target 'ti/k3-am62p5-verdin-wifi-ivy.dtb' not remade because of errors.
make: Target 'ti/k3-am625-verdin-wifi-dahlia.dtb' not remade because of errors.
make: Target 'ti/k3-j721e-common-proc-board.dtb' not remade because of errors.
make: Target 'ti/k3-am625-verdin-wifi-dev.dtb' not remade because of errors.
make: Target 'ti/k3-am642-evm.dtb' not remade because of errors.
make: Target 'ti/k3-am625-verdin-wifi-mallow.dtb' not remade because of errors.
make: Target 'ti/k3-am625-verdin-nonwifi-dahlia.dtb' not remade because of errors.
make: Target 'ti/k3-am62d2-evm.dtb' not remade because of errors.
make: Target 'ti/k3-j742s2-evm.dtb' not remade because of errors.
make: Target 'ti/k3-am642-hummingboard-t.dtb' not remade because of errors.
make: Target 'ti/k3-am625-beagleplay.dtb' not remade because of errors.
make: Target 'ti/k3-am625-verdin-nonwifi-yavia.dtb' not remade because of errors.
make: Target 'ti/k3-am6528-iot2050-basic-pg2.dtb' not remade because of errors.
make: Target 'ti/k3-am62p5-verdin-wifi-mallow.dtb' not remade because of errors.
make: Target 'ti/k3-am68-sk-base-board.dtb' not remade because of errors.
make: Target 'ti/k3-am62p5-sk.dtb' not remade because of errors.
make: Target 'ti/k3-am6528-iot2050-basic.dtb' not remade because of errors.
make: Target 'ti/k3-am62-pocketbeagle2.dtb' not remade because of errors.
make: Target 'ti/k3-am6548-iot2050-advanced-m2.dtb' not remade because of errors.
make: Target 'ti/k3-am654-base-board.dtb' not remade because of errors.
make: Target 'ti/k3-am6548-iot2050-advanced.dtb' not remade because of errors.
make: Target 'ti/k3-am62a7-phyboard-lyra-rdk.dtb' not remade because of errors.
make: Target 'ti/k3-am62a7-sk.dtb' not remade because of errors.
make: Target 'ti/k3-am625-verdin-nonwifi-dev.dtb' not remade because of errors.
make: Target 'ti/k3-am62p5-verdin-nonwifi-mallow.dtb' not remade because of errors.
make: Target 'ti/k3-j722s-evm.dtb' not remade because of errors.
make: Target 'ti/k3-am62p5-verdin-nonwifi-dahlia.dtb' not remade because of errors.
make: Target 'ti/k3-am62p5-verdin-nonwifi-ivy.dtb' not remade because of errors.
make: Target 'ti/k3-j721e-beagleboneai64.dtb' not remade because of errors.
make: Target 'ti/k3-am62p5-verdin-nonwifi-dev.dtb' not remade because of errors.
make: Target 'ti/k3-am642-phyboard-electra-rdk.dtb' not remade because of errors.
make: Target 'ti/k3-am69-sk.dtb' not remade because of errors.
make: Target 'ti/k3-am62p5-verdin-wifi-dahlia.dtb' not remade because of errors.
make: Target 'ti/k3-am6548-iot2050-advanced-pg2.dtb' not remade because of errors.
make: Target 'ti/k3-am68-phyboard-izar.dtb' not remade because of errors.
make: Target 'ti/k3-am642-hummingboard-t-pcie.dtb' not remade because of errors.
make: Target 'ti/k3-j7200-common-proc-board.dtb' not remade because of errors.
make: Target 'ti/k3-am62-lp-sk.dtb' not remade because of errors.
make: Target 'ti/k3-am625-verdin-wifi-yavia.dtb' not remade because of errors.
make: Target 'ti/k3-j721s2-common-proc-board.dtb' not remade because of errors.
make: Target 'ti/k3-am642-tqma64xxl-mbax4xxl.dtb' not remade because of errors.
make: Target 'ti/k3-am67a-beagley-ai.dtb' not remade because of errors.
make: Target 'ti/k3-am62p5-verdin-nonwifi-yavia.dtb' not remade because of errors.
make: Target 'ti/k3-am642-hummingboard-t-usb3.dtb' not remade because of errors.
make: Target 'ti/k3-am642-sk.dtb' not remade because of errors.
make: Target 'ti/k3-am6548-iot2050-advanced-sm.dtb' not remade because of errors.
make: Target 'ti/k3-am625-verdin-nonwifi-mallow.dtb' not remade because of errors.
make: Target 'ti/k3-am625-phyboard-lyra-rdk.dtb' not remade because of errors.
make: Target 'ti/k3-am62p5-verdin-wifi-yavia.dtb' not remade because of errors.
make: Target 'ti/k3-am625-verdin-nonwifi-ivy.dtb' not remade because of errors.
make: Target 'ti/k3-j784s4-evm.dtb' not remade because of errors.
make: Target 'ti/k3-am625-sk.dtb' not remade because of errors.
make: Target 'ti/k3-am62p5-verdin-wifi-dev.dtb' not remade because of errors.
make: Target 'ti/k3-j721e-sk.dtb' not remade because of errors.






