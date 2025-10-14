Return-Path: <linux-kernel+bounces-851726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE16BBD7255
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0A0188B4B8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C233074BC;
	Tue, 14 Oct 2025 03:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1BPA/3g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0BC2AD2C;
	Tue, 14 Oct 2025 03:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411539; cv=none; b=Z+1ohdsrchBAFZY7cCL4A0ClfrhjntEued9erahG/5jgsyQ6RLerfTNDfjuFZBSAbqJw7b2gdhkiv8EHguJ49s40MdIs8F92/ynpkf9dSiLywMukXcwaek74nwwb1h/0Ld9FwR98deHSMyaWht2yTKPmyq5bnK1oRQd1BGXUVYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411539; c=relaxed/simple;
	bh=htQXNEJpyPT71ySOsA/9aztCBJVdemKlfxtoz019xMI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a88OWKBeDn8ngypitU2qkpVxnDIyfWllbYodGGJFQvyw/nFvCSPBKSRz3PjAkthS4HuAw0NeTTasF/9foeezu81ermY6dVKi5sRCTHEjWJT3IdnW8eQYTgO4QzeMK4rn8GNNNp9JSliXPMUiCjpL/jO9d5daCBDPfY4iCaRS4FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1BPA/3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13A6C4CEE7;
	Tue, 14 Oct 2025 03:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760411538;
	bh=htQXNEJpyPT71ySOsA/9aztCBJVdemKlfxtoz019xMI=;
	h=From:Subject:Date:To:Cc:From;
	b=h1BPA/3gYGcwL3DLBL3R97cn8qUKgm6ajuGEnInh3IFdX4XnOak+q2DPLKOx+/QZ6
	 Ydy569xCh7r0lzTaw1h8dyZ0wYGP6tsyMR7WoxlIVREgY2wxOJO4ydZHqCwxRIhdo/
	 VnOXv4Uye9yFXxyyXBK3gLsSG9rdKibVEWr/qNQSscWu0l8SgmiwQrMKqHsblNRIbS
	 rDiQd1pWUfHk1KHHd9yceeN+e8A+EL+3ewNIWQ4Sw8oyXPFyG6snkyRFLmopx4ATke
	 JP/Yo6pix9X8yRCVgNo18gfxx5pL7dzUK39C7de0/iJc0WyehAiBuO8rty1mFZ+4Dm
	 87B+LCzGFVFbg==
From: Drew Fustini <fustini@kernel.org>
Subject: [PATCH v3 0/8] RISC-V: Add support for Tenstorrent Blackhole SoC
Date: Mon, 13 Oct 2025 20:11:52 -0700
Message-Id: <20251013-tt-bh-dts-v3-0-9f058d4bbbda@oss.tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHi/7WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0Nj3ZIS3aQM3ZSSYt2UxKTUtDSDtGSDRHMloPqCotS0zAqwWdGxtbU
 Ag2SlrVsAAAA=
X-Change-ID: 20251013-tt-bh-dts-dabeff0fc0a7
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>, 
 Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>, 
 Joel Stanley <jms@oss.tenstorrent.com>, 
 Nicholas Piggin <npiggin@oss.tenstorrent.com>, 
 Michael Neuling <mikey@neuling.org>, Michael Ellerman <mpe@kernel.org>, 
 Andy Gross <agross@kernel.org>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Drew Fustini <dfustini@oss.tenstorrent.com>, Paul Walmsley <pjw@kernel.org>, 
 Albert Ou <aou@eecs.berkeley.edu>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>
X-Mailer: b4 0.14.2

Enable support for the Tenstorrent Blackhole SoC in the Blackhole P100
and P150 PCIe cards [1]. The Blackhole SoC contains four RISC-V CPU
tiles consisting of 4x SiFive X280 cores. Each tile is capable of
running an instance of Linux.

There is a public Linux-on-Blackhole project [2] that enables users to
boot Linux on Blackhole PCIe cards. A boot script on the PCIe host
loads the kernel image and the rootfs into DDR memory and then takes
the X280 cores out of reset.

All the low-level SoC initialization is handled by firmware [3] running
on a separate management core in the Blackhole SoC. Linux on the X280
cores does not need to deal with any clocks, reset, etc. The management
core firmware also controls the PCIe EP functionality. The tt-kmd Linux
kernel driver [4] on the PCIe host allows the host to interact with the
DDR memory on the Blackhole PCIe card along with other tiles in the SoC
accessible from the NoC [5].

There is a virtual UART implemented in OpenSBI [6] that allows a console
program on the PCIe host to communicate through shared memory with Linux
running on the Blackhole. This does require CONFIG_HVC_RISCV_SBI which
is currently hidden behind CONFIG_NONPORTABLE. I would like Blackhole to
work with defconfig, so I'm looking into possible ways of solving the
issue that caused HVC SBI to be guarded by NONPORTABLE [7].

The public Linux-on-Blackhole project does also make use of virtio to
provide networking and storage. However, this relies on changes in our
downstream kernel branch [8], so I've removed those dt nodes from this
upstream dts series. We hope to eventually leverage the virtio-msg spec
to upstream the virtio functionality, too.

The boot script [9] on the host adds 'console=hvc0' to bootargs which is
needed to ensure the full boot output appears in the console program on
the host. It also adds initrd for the rootfs.

TL;DR:
The goal for upstreaming this rather minimal device tree in this series
is to make it possible to boot mainline kernel builds. I attended the
recent KernelCI workshop, and there are not currently many RISC-V boards
doing boot tests. I think the Blackhole cards could help improve the
situation once Blackhole is able to boot important trees like mainline
and next. The HVC SBI console is sufficient for boot testing.

[1] https://tenstorrent.com/hardware/blackhole
[2] https://github.com/tenstorrent/tt-bh-linux
[3] https://github.com/tenstorrent/tt-zephyr-platforms
[4] https://github.com/tenstorrent/tt-kmd
[5] https://github.com/tenstorrent/tt-isa-documentation/blob/main/BlackholeA0/
[6] https://github.com/tenstorrent/opensbi/
[7] https://lore.kernel.org/all/20240214153429.16484-2-palmer@rivosinc.com/
[8] https://github.com/tenstorrent/linux/
[9] https://github.com/tenstorrent/tt-bh-linux/blob/main/boot.py

Changes in v3:
 - Update dts patch commit message to describe how HVC SBI is used for
   the console output and thus no uart node is in the dts
 - Change address-cells and size-cells to be in decimel instead of hex
 - Add new line before interrupt-controller node inside of cpu nodes
 - Simplify the 'model' property in blackhole-card.dts
 - Add Rob's Acked-by: for clint and plic yaml patches
 - Add Rb tags from Joel Stanley
 - Rebase on v6.18-rc1
 - Link to v2: https://lore.kernel.org/linux-riscv/20251006-tt-bh-dts-v2-0-ed90dc4b3e22@oss.tenstorrent.com/

Changes in v2:
 - Remove '-a0' from compatible strings as Rob advised silicon revisions
   are not normally included in compatibles
 - Add ARCH_TENSTORRENT to defconfig per Conor's suggestion
 - Fix unit address for memory device tree node
 - Remove legacy 'riscv,isa' property from cpu dt nodes
 - Remove 'riscv,cboz-block-size' as the cores do not support Zicboz
 - Link to v1: https://lore.kernel.org/linux-riscv/20250913-tt-bh-dts-v1-0-ddb0d6860fe5@tenstorrent.com/

---
Drew Fustini (8):
      dt-bindings: vendor-prefixes: Add Tenstorrent AI ULC
      dt-bindings: riscv: Add Tenstorrent Blackhole compatible
      dt-bindings: riscv: cpus: Add SiFive X280 compatible
      dt-bindings: timers: Add Tenstorrent Blackhole compatible
      dt-bindings: interrupt-controller: Add Tenstorrent Blackhole compatible
      riscv: dts: Add Tenstorrent Blackhole SoC PCIe cards
      riscv: Kconfig.socs: Add ARCH_TENSTORRENT for Tenstorrent SoCs
      riscv: defconfig: Enable Tenstorrent SoCs

 .../interrupt-controller/sifive,plic-1.0.0.yaml    |   1 +
 Documentation/devicetree/bindings/riscv/cpus.yaml  |   1 +
 .../devicetree/bindings/riscv/tenstorrent.yaml     |  28 ++++++
 .../devicetree/bindings/timer/sifive,clint.yaml    |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |   9 ++
 arch/riscv/Kconfig.socs                            |   8 ++
 arch/riscv/boot/dts/Makefile                       |   1 +
 arch/riscv/boot/dts/tenstorrent/Makefile           |   2 +
 arch/riscv/boot/dts/tenstorrent/blackhole-card.dts |  14 +++
 arch/riscv/boot/dts/tenstorrent/blackhole.dtsi     | 108 +++++++++++++++++++++
 arch/riscv/configs/defconfig                       |   1 +
 12 files changed, 176 insertions(+)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251013-tt-bh-dts-dabeff0fc0a7

Best regards,
-- 
Drew Fustini <dfustini@oss.tenstorrent.com>


