Return-Path: <linux-kernel+bounces-841058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E213ABB627E
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 09:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E521AE098A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 07:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F6023AE9B;
	Fri,  3 Oct 2025 07:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCjWiseW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805112F5B
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 07:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759475965; cv=none; b=ba9w/cwku/m2nmKF++oN/6FIrr4TU7Fxl6gikO0/6HmkREh4fcf2cl4sLj9O9o803Og0PCsbVpfCBQW+zYH+1I0zd95VM9sA9HUgPvVI+gBeQtghPen9Gb5UapwqKfAn2EimofoGQs67czOSSXJXdtDi5/f1AESt1HRI0WHPfBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759475965; c=relaxed/simple;
	bh=npL7ZxipwXBJqYe6tFFbbpWqtsI0lDGBpLw4bTD7F8c=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=MYai0J9+bqfKOuFhvh4Uh2nxw+6FS9boavyu/vOMznvOGbfoZp6q/nFmqpQmNvQK0/6mjl3BX4cB0l764HVbqIwwnPsUsyhej4GeUM2P3CukyRXloym7hZ7VeunmYCiTPJ8+CmiB6G791NT8OpWm5YUOlA/nHWvg97XAb0T0w1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCjWiseW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6205C4CEF5;
	Fri,  3 Oct 2025 07:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759475965;
	bh=npL7ZxipwXBJqYe6tFFbbpWqtsI0lDGBpLw4bTD7F8c=;
	h=Date:From:To:cc:Subject:From;
	b=UCjWiseWJylfmkFB2mCIzgS3u4KKG2ABboUvSZnUhpI43SLpMl08UCoTnt0ad3Ymk
	 MSV4jzOXEAhwpwotwrl1Hi+RywYNaJue23c1X8ADx/iBbXLjuVcpHZVVMJN7hsQPR8
	 Fzi7N3x58dPu6rN4Uam/9224Aa/YDjGXnnNnqeg1IMw8X2MKFN86KZtsP5daI7TUIl
	 3A8NTh0zeBzM5HxeKK2GOaQBaPcCE0a5ShaUgYf2UpnOc1vn3JiovZvTWJJd28u0rw
	 rcPenAzkhy0iVatCk0uSsHNJ+5ToTxOgDaTwzirojom7Hg1B8T/HbScm4rvhM2Old8
	 cA36qaSLNFKEw==
Date: Fri, 3 Oct 2025 01:19:20 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: torvalds@linux-foundation.org
cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RISC-V updates for the v6.18 merge window (part two)
Message-ID: <9a4eb234-b19c-8051-472b-4bd793a9e252@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Linus,

The following changes since commit 0b0ca959d20689fece038954bbf1d7b14c0b11c3:

  riscv: errata: Fix the PAUSE Opcode for MIPS P8700 (2025-09-19 10:33:56 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux tags/riscv-for-linus-6.18-mw2

for you to fetch changes up to 68247d45c045bb7dda923cf2c8d0937ce0e16394:

  clk: COMMON_CLK_RPMI should depend on RISCV (2025-10-01 19:07:43 -0600)

----------------------------------------------------------------
RISC-V updates for the v6.18 merge window (part two)

Second set of RISC-V updates for the v6.18 merge window, consisting
of:

- Support for the RISC-V-standardized RPMI interface.

  RPMI is a platform management communication mechanism between OSes
  running on application processors, and a remote platform management
  processor.  Similar to ARM SCMI, TI SCI, etc.  This includes irqchip,
  mailbox, and clk changes.

- Support for the RISC-V-standardized MPXY SBI extension.

  MPXY is a RISC-V-specific standard implementing a shared memory
  mailbox between S-mode operating systems (e.g., Linux) and M-mode
  firmware (e.g., OpenSBI).  It is part of this PR since one of its
  use cases is to enable M-mode firmware to act as a single RPMI client
  for all RPMI activity on a core (including S-mode RPMI activity).
  Includes a mailbox driver.

- Some ACPI-related updates to enable the use of RPMI and MPXY.

- The addition of Linux-wide memcpy_{from,to}_le32() static inline
  functions, for RPMI use.

- An ACPI Kconfig change to enable boot logos on any ACPI-using
  architecture (including RISC-V)

- A RISC-V defconfig change to add GPIO keyboard and event device
  support, for front panel shutdown or reboot buttons

This PR also includes a recent, one-line Kconfig patch from Geert to
keep non-RISC-V users from being asked about building the RPMI virtual
clock driver when !COMPILE_TEST.  THere's nothing preventing
non-RISC-V SoCs from implementing RPMI, but until some users show up,
let's not annoy others with it.

----------------------------------------------------------------
Anup Patel (14):
      dt-bindings: mailbox: Add bindings for RPMI shared memory transport
      dt-bindings: mailbox: Add bindings for RISC-V SBI MPXY extension
      RISC-V: Add defines for the SBI message proxy extension
      mailbox: Add common header for RPMI messages sent via mailbox
      mailbox: Allow controller specific mapping using fwnode
      byteorder: Add memcpy_to_le32() and memcpy_from_le32()
      mailbox: Add RISC-V SBI message proxy (MPXY) based mailbox driver
      dt-bindings: clock: Add RPMI clock service message proxy bindings
      dt-bindings: clock: Add RPMI clock service controller bindings
      dt-bindings: Add RPMI system MSI message proxy bindings
      dt-bindings: Add RPMI system MSI interrupt controller bindings
      irqchip: Add driver for the RPMI system MSI service group
      RISC-V: Enable GPIO keyboard and event device in RV64 defconfig
      MAINTAINERS: Add entry for RISC-V RPMI and MPXY drivers

Geert Uytterhoeven (1):
      clk: COMMON_CLK_RPMI should depend on RISCV

Heinrich Schuchardt (1):
      ACPI: support BGRT table on RISC-V

Rahul Pathak (1):
      clk: Add clock driver for the RISC-V RPMI clock service group

Sunil V L (9):
      ACPI: property: Refactor acpi_fwnode_get_reference_args() to support nargs_prop
      ACPI: Add support for nargs_prop in acpi_fwnode_get_reference_args()
      ACPI: scan: Update honor list for RPMI System MSI
      ACPI: RISC-V: Create interrupt controller list in sorted order
      ACPI: RISC-V: Add support to update gsi range
      ACPI: RISC-V: Add RPMI System MSI to GSI mapping
      irqchip/irq-riscv-imsic-early: Export imsic_acpi_get_fwnode()
      mailbox/riscv-sbi-mpxy: Add ACPI support
      irqchip/riscv-rpmi-sysmsi: Add ACPI support

 .../bindings/clock/riscv,rpmi-clock.yaml           |   64 ++
 .../bindings/clock/riscv,rpmi-mpxy-clock.yaml      |   64 ++
 .../riscv,rpmi-mpxy-system-msi.yaml                |   67 ++
 .../riscv,rpmi-system-msi.yaml                     |   74 ++
 .../bindings/mailbox/riscv,rpmi-shmem-mbox.yaml    |  124 +++
 .../bindings/mailbox/riscv,sbi-mpxy-mbox.yaml      |   51 +
 MAINTAINERS                                        |   15 +
 arch/riscv/configs/defconfig                       |    2 +
 arch/riscv/include/asm/irq.h                       |    6 +
 arch/riscv/include/asm/sbi.h                       |   62 ++
 drivers/acpi/Kconfig                               |    2 +-
 drivers/acpi/property.c                            |  128 +--
 drivers/acpi/riscv/irq.c                           |   75 +-
 drivers/acpi/scan.c                                |    2 +
 drivers/base/property.c                            |    2 +-
 drivers/clk/Kconfig                                |    9 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-rpmi.c                             |  620 ++++++++++++
 drivers/irqchip/Kconfig                            |    7 +
 drivers/irqchip/Makefile                           |    1 +
 drivers/irqchip/irq-riscv-imsic-early.c            |    2 +
 drivers/irqchip/irq-riscv-rpmi-sysmsi.c            |  328 +++++++
 drivers/mailbox/Kconfig                            |   11 +
 drivers/mailbox/Makefile                           |    2 +
 drivers/mailbox/mailbox.c                          |   65 +-
 drivers/mailbox/riscv-sbi-mpxy-mbox.c              | 1019 ++++++++++++++++++++
 include/linux/byteorder/generic.h                  |   16 +
 include/linux/mailbox/riscv-rpmi-message.h         |  243 +++++
 include/linux/mailbox_controller.h                 |    3 +
 29 files changed, 2981 insertions(+), 84 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/riscv,rpmi-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/riscv,rpmi-mpxy-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-mpxy-system-msi.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-system-msi.yaml
 create mode 100644 Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml
 create mode 100644 Documentation/devicetree/bindings/mailbox/riscv,sbi-mpxy-mbox.yaml
 create mode 100644 drivers/clk/clk-rpmi.c
 create mode 100644 drivers/irqchip/irq-riscv-rpmi-sysmsi.c
 create mode 100644 drivers/mailbox/riscv-sbi-mpxy-mbox.c
 create mode 100644 include/linux/mailbox/riscv-rpmi-message.h

    text	   data	    bss	     dec	    hex	filename
12839941	6181502	 419253	19440696	128a438	vmlinux.rv64.orig
12866875	6191482	 419269	19477626	129347a	vmlinux.rv64
11788867	6000158	 404229	18193254	1159b66	vmlinux.rv64_nosmp.orig
11800609	6005634	 404245	18210488	115deb8	vmlinux.rv64_nosmp
11771062	4703702	 309629	16784393	1001c09	vmlinux.rv32.orig
11794258	4711898	 309637	16815793	10096b1	vmlinux.rv32
 2615066	 758584	 119048	 3492698	 354b5a	vmlinux.nommu_virt.orig
 2615066	 758584	 119048	3 492698	 354b5a	vmlinux.nommu_virt

