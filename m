Return-Path: <linux-kernel+bounces-815361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1674B56342
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 23:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2DC11790D9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAD4281366;
	Sat, 13 Sep 2025 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6UTUvix"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AA41400C;
	Sat, 13 Sep 2025 21:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757799063; cv=none; b=pljJe/EOwzx8EOC8n1GQCqnIEzJsUQhS4PrR6XMfM6MFwHGrd4X8kWSeCMjxX8vXeR0qsuNWt9+hS1MnvQYV9llyUBowNajeTvgkInPF+/l4Q0jm6nJVoiW30cxyBjZ2NDEe+DLcpE4C8Cp1opQ59Ro0wlSSOjofaP+86jmYdTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757799063; c=relaxed/simple;
	bh=yUB0oiV+jJoMJE08L8bBpTc+q1SYI6i7A8rySQva7O0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DN861zdWnYCfoIcvKuOxaoW7CWAiSsNn8kN+IaJGmOrxKKIdJNPOgcGtLWqiaQvzup0PbpUzgVNMAp2JaaWF9FuhNFuSCyR90ZeLYLSn3QoP4BnU2RHCzohiyI+PipcaPZUluXw1hrqcckecKT1Y+qpNa1aq5MkYvRn5izMRaag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6UTUvix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8639BC4CEEB;
	Sat, 13 Sep 2025 21:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757799063;
	bh=yUB0oiV+jJoMJE08L8bBpTc+q1SYI6i7A8rySQva7O0=;
	h=From:Subject:Date:To:Cc:From;
	b=e6UTUvixqFYIx3PHG7oc40893xzdel8KZkNh+FEfkvTW8VYf94VFUb2Wvc+vzAzD7
	 NJRTBw5Iht42v8LtwpddLYLibKRvaMDy3WrX+duKLJ6SX/VX/83GwAiK7UKTycmXal
	 T77kMffyyVCaXs+yMJhAiPpSCqlz8fIkvHkhROrmggTB9x1XDe1VKrU2u6X8TpBBG1
	 usfXQEMBmcCNTfhJdzP90FWXJtPj7Nf+737wiOS52pnRhjQkuw89WQQWJJwvar+8UN
	 x2KNSjDIonNcraqKz02PFiJQzNyDxk1QsN0vBpp7vSbIMW1RnLviRq7Zofq6PVVA0s
	 JVTKxxqon3dLg==
From: Drew Fustini <fustini@kernel.org>
Subject: [PATCH 0/7] RISC-V: Add support for Tenstorrent Blackhole SoC
Date: Sat, 13 Sep 2025 14:30:59 -0700
Message-Id: <20250913-tt-bh-dts-v1-0-ddb0d6860fe5@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJPixWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0Mj3ZIS3aQM3ZSSYt0U86TkZFMD80RTUzMloPqCotS0zAqwWdGxtbU
 ABTUqKlsAAAA=
X-Change-ID: 20250912-tt-bh-dts-d7bcc507a556
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>, 
 Arnd Bergmann <arnd@arndb.de>, Joel Stanley <jms@tenstorrent.com>, 
 Joel Stanley <joel@jms.id.au>, Michael Neuling <mikey@neuling.org>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>, 
 Andy Gross <agross@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Conor Dooley <conor@kernel.org>, 
 Drew Fustini <dfustini@tenstorrent.com>
X-Mailer: b4 0.14.2

Enable support for the Tenstorrent Blackhole A0 SoC in the Blackhole
P100 and P150 PCIe cards [1]. The Blackhole SoC contains four RISC-V
CPU tiles consisting of 4x SiFive X280 cores. Each tile is capable of
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

Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
Drew Fustini (7):
      dt-bindings: vendor-prefixes: Add Tenstorrent AI ULC
      dt-bindings: riscv: Add Tenstorrent Blackhole compatible
      dt-bindings: riscv: cpus: Add SiFive X280 compatible
      dt-bindings: timers: Add Tenstorrent Blackhole compatible
      dt-bindings: interrupt-controller: Add Tenstorrent Blackhole compatible
      riscv: dts: Add Tenstorrent Blackhole A0 SoC PCIe cards
      riscv: Kconfig.socs: Add ARCH_TENSTORRENT for Tenstorrent SoCs

 .../interrupt-controller/sifive,plic-1.0.0.yaml    |   1 +
 Documentation/devicetree/bindings/riscv/cpus.yaml  |   1 +
 .../devicetree/bindings/riscv/tenstorrent.yaml     |  28 ++++++
 .../devicetree/bindings/timer/sifive,clint.yaml    |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |   9 ++
 arch/riscv/Kconfig.socs                            |   8 ++
 arch/riscv/boot/dts/Makefile                       |   1 +
 arch/riscv/boot/dts/tenstorrent/Makefile           |   2 +
 .../boot/dts/tenstorrent/blackhole-a0-card.dts     |  14 +++
 arch/riscv/boot/dts/tenstorrent/blackhole-a0.dtsi  | 112 +++++++++++++++++++++
 11 files changed, 179 insertions(+)
---
base-commit: 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c
change-id: 20250912-tt-bh-dts-d7bcc507a556

Best regards,
-- 
Drew Fustini <dfustini@tenstorrent.com>


