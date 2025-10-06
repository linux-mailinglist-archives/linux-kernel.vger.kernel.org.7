Return-Path: <linux-kernel+bounces-843475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3205BBF8E2
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 23:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A59F34BBD5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 21:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA56F25B1D2;
	Mon,  6 Oct 2025 21:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a51IRUo+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABA51C84C0;
	Mon,  6 Oct 2025 21:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759785711; cv=none; b=K1DBUFl3frORvuZopWMO/zJ26kTRUpocZScUryIuRBuxW33jgoRrM1mcX5/mw6LH7Lhoqukm1OUhtrTbFnNiYhXTxMBuuXWVxT+ogYhzzEdjTchIn1DVy/D2nF2pUxCQRqcD4EVTjTdns4vmZAyC1kMsDwphb0AREyP2xh4p0IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759785711; c=relaxed/simple;
	bh=7iJ32YGIikjrp2pA/xgAb9df77t5CNdRAnigY3veHVs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ESg0U5Pcps2tQxcSA1faCXoG7Sb71z1n49KBO3Ej2LXtk+kdLajj0es8lwQqqLAy3Wno293UeduwBOZErt7h+zaqP1mjMSGyYltciSLm/XqkbP5MIjsWMzakETRTqBQ/1nzhlyrVbxtO0tD8cnDBJL8LvVLO7I9pOa7pU/WKyvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a51IRUo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB735C4CEF5;
	Mon,  6 Oct 2025 21:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759785710;
	bh=7iJ32YGIikjrp2pA/xgAb9df77t5CNdRAnigY3veHVs=;
	h=From:Subject:Date:To:Cc:From;
	b=a51IRUo+m3fzUtlIqyu7hTsuI0Kotsc4avj1QeyZpLfi8el1ganISGiFgKnzlB5nh
	 CagOQrcM+9xfVqCjukG9xSh8Y1GjtuJKxjRNpXJ7+jOKbs7kzg6qA3/Vfx4beQVRVU
	 AuMQWhVYDp/uCQcs06JR20kYcLS8Nkqv2acD/Gx93gwE7853q8odmuhV8NKC26n0pu
	 hnBExmqVdHC7DZfTo3wA7fNiBWBoxwHZ5ISVq2DbhDTBbSjfuAR8wJlFbyOaeXLE8/
	 Ui0rXaBIrOU58Ib7R1+F3dsStYCyQTucV+FBhVAB19fCbtkFUmitkpBygT1R6/EiMo
	 1hucKPNv2hjzg==
From: Drew Fustini <fustini@kernel.org>
Subject: [PATCH v2 0/8] RISC-V: Add support for Tenstorrent Blackhole SoC
Date: Mon, 06 Oct 2025 14:21:40 -0700
Message-Id: <20251006-tt-bh-dts-v2-0-ed90dc4b3e22@oss.tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOUy5GgC/x3MQQqAIBBA0avIrBuwARd2lWhROuZsLFQiEO+et
 Hzw+Q0KZ+ECi2qQ+ZEiVxqgSYGLezoZxQ8DaTLaksVa8Yjoa8HAZLzTs3E+wOjvzEHe/7VuvX+
 MKOzZWwAAAA==
X-Change-ID: 20250929-tt-bh-dts-fe25dc015cdf
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>, 
 Arnd Bergmann <arnd@arndb.de>, Joel Stanley <jms@oss.tenstorrent.com>, 
 Joel Stanley <joel@jms.id.au>, Michael Neuling <mikey@neuling.org>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>, 
 Andy Gross <agross@kernel.org>, 
 Anirudh Srinivasan <asrinivasan@tenstorrent.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, 
 Drew Fustini <dfustini@oss.tenstorrent.com>
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

I have also dropped the bootargs from this series. Instead, I will add
the ability to fixup the dtb to the boot script on the host [9]. It does
need 'console=hvc0' to ensure the full boot output appears in the
console program on the host. I also dropped the pmem node from this
series as I don't see any upstream users of pmem. I have been using pmem
for the rootfs, so I'll update the boot script to add the pmem node and
amend 'root=/dev/pmem0' in bootargs.

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
[9] https://github.com/tenstorrent/tt-bh-linux/blob/dfustini/kernelci/boot.py

Changes in v2:
 - Remove '-a0' from compatible strings as Rob advised silicon revisions
   are not normally included in compatibles
 - Add ARCH_TENSTORRENT to defconfig per Conor's suggestion
 - Fix unit address for memory device tree node
 - Remove legacy 'riscv,isa' property from cpu dt nodes
 - Remove 'riscv,cboz-block-size' as the cores do not support Zicboz
 - Link to v1: https://lore.kernel.org/linux-riscv/20250913-tt-bh-dts-v1-0-ddb0d6860fe5@tenstorrent.com/

To: Paul Walmsley <paul.walmsley@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
To: Alexandre Ghiti <alex@ghiti.fr>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>
To: Anup Patel <anup@brainfault.org>
To: Arnd Bergmann <arnd@arndb.de>
To: Joel Stanley <jms@oss.tenstorrent.com>
To: Joel Stanley <joel@jms.id.au>
To: Michael Neuling <mikey@neuling.org>
To: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@kernel.org>
To: Andy Gross <agross@kernel.org>
To: Anirudh Srinivasan <asrinivasan@tenstorrent.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-riscv@lists.infradead.org

Signed-off-by: Drew Fustini <dfustini@oss.tenstorrent.com>
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
 arch/riscv/boot/dts/tenstorrent/blackhole.dtsi     | 104 +++++++++++++++++++++
 arch/riscv/configs/defconfig                       |   1 +
 12 files changed, 172 insertions(+)
---
base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
change-id: 20250929-tt-bh-dts-fe25dc015cdf

Best regards,
-- 
Drew Fustini <dfustini@oss.tenstorrent.com>


