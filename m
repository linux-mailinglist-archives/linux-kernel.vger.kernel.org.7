Return-Path: <linux-kernel+bounces-835921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A26DBA8589
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738421892656
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E53A223DC0;
	Mon, 29 Sep 2025 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzRrrp4s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B95B266B40
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759132823; cv=none; b=TyX4MTD3AC3gHt1aobJ2x84I66cQmfRtCFue3CEbfObdhXQ+yodoK4zzHpnO7OIwjhCgh4/aKF8QEyMpmX4m4UUml+VtDLeN/Hl7ZipsJrgKipphFkn+zJf4j53zpevtvntBLTz/8zUCFtPbcxDQu12a2rYVPRipwL+zCojf+OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759132823; c=relaxed/simple;
	bh=hLAJjzNvQilZVylWxy0T+k4pdrp5LKeTtVQ40jPQ4yc=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=M9/QP+afy2frYk0wWBOGAMudmGSnX8fn0C+jCOss/ee5JJJNjiM2NRSQXAv40qfcEZHUKzPDD83w1q/o4W1YXcSY7Egl6lenB42mBODlVfeLvV5DfHPuewzqhC998cxFb3F3OIsdh9m5SDS1k1UZcDzFxSjKVJMcTIZQGcav/gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzRrrp4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7840DC4CEF4;
	Mon, 29 Sep 2025 08:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759132822;
	bh=hLAJjzNvQilZVylWxy0T+k4pdrp5LKeTtVQ40jPQ4yc=;
	h=Date:From:To:cc:Subject:From;
	b=KzRrrp4sajeRrw2dhI35JOhhLaHgja0zJM6dMS/fRwwA9FgrROdw53nBqyLgnkau0
	 4jEKRin5jLZ7xduPSKDIiPX1K/KbzlSEldaqITqetR/AEDzNKC9JaM4nswjLqAQZtT
	 GPcaHvlJza4N/h0VpvOFV5wlB6DUsC6GUZpohQomUTSnChchqkJNYIZquDWMIo7ph6
	 KyHhNyTMtXzDWynDkvdhU/VhUmesocvt0luO/fpswcO+KdSbEny1ISFVS3VLEHOphq
	 JIxWce/Hr/0RMmoU/S4GCP/ELdUnOAspCKAvuiYah6SnXTNCBK/OrUGEQdvIJ4LNDy
	 FAjx/drkUFWGw==
Date: Mon, 29 Sep 2025 02:00:17 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: torvalds@linux-foundation.org
cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RISC-V updates for v6.18-rc1
Message-ID: <2c804359-3d43-0fba-7173-a87f9aec4bd2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-438314659-1759132822=:285450"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-438314659-1759132822=:285450
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Linus,

The following changes since commit a03ee11b8f850bd008226c6d392da24163dfb56e:

  riscv: Fix sparse warning about different address spaces (2025-09-05 15:33:52 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux tags/riscv-for-linus-6.18-mw1

for you to fetch changes up to 0b0ca959d20689fece038954bbf1d7b14c0b11c3:

  riscv: errata: Fix the PAUSE Opcode for MIPS P8700 (2025-09-19 10:33:56 -0600)

----------------------------------------------------------------
RISC-V updates for the v6.18 merge window (part one)

First set of RISC-V updates for the v6.18 merge window, including:

- Replacement of __ASSEMBLY__ with __ASSEMBLER__ in header files (other
  architectures have already merged this type of cleanup)

- The introduction of ioremap_wc() for RISC-V

- Cleanup of the RISC-V kprobes code to use mostly-extant macros rather than
  open code

- A RISC-V kprobes unit test

- An architecture-specific endianness swap macro set implementation,
  leveraging some dedicated RISC-V instructions for this purpose if they
  are available

- The ability to identity and communicate to userspace the presence of a
  MIPS P8700-specific ISA extension, and to leverage its MIPS-specific PAUSE
  implementation in cpu_relax()

- Several other miscellaneous cleanups

----------------------------------------------------------------
Aleksa Paunovic (5):
      dt-bindings: riscv: Add xmipsexectl ISA extension description
      riscv: Add xmipsexectl as a vendor extension
      riscv: Add xmipsexectl instructions
      riscv: hwprobe: Add MIPS vendor extension probing
      riscv: hwprobe: Document MIPS xmipsexectl vendor extension

Alexandre Ghiti (3):
      riscv: Fix typo EXRACT -> EXTRACT
      riscv: Strengthen duplicate and inconsistent definition of RV_X()
      riscv: Move all duplicate insn parsing macros into asm/insn.h

Andrew Davis (1):
      riscv: sbi: Switch to new sys-off handler API

Bala-Vignesh-Reddy (1):
      selftests: riscv: Add README for RISC-V KSelfTest

Chunyan Zhang (2):
      raid6: riscv: Clean up unused header file inclusion
      raid6: riscv: replace one load with a move to speed up the caculation

Clément Léger (1):
      riscv: cpufeature: add validation for zfa, zfh and zfhmin

Djordje Todorovic (1):
      riscv: errata: Fix the PAUSE Opcode for MIPS P8700

Guo Ren (Alibaba DAMO Academy) (1):
      riscv: Move vendor errata definitions to new header

Heinrich Schuchardt (1):
      RISC-V: ACPI: enable parsing the BGRT table

Ignacio Encinas (1):
      riscv: introduce asm/swab.h

Jessica Liu (1):
      riscv: mmap(): use unsigned offset type in riscv_sys_mmap

Junhui Liu (2):
      riscv: mm: Return intended SATP mode for noXlvl options
      riscv: mm: Use mmu-type from FDT to limit SATP mode

Liao Yuanhong (1):
      drivers/perf: riscv: Remove redundant ternary operators

Masahiro Yamada (1):
      riscv: pi: use 'targets' instead of extra-y in Makefile

Nam Cao (12):
      riscv: Add kprobes KUnit test
      riscv: kprobes: Move branch_rs2_idx to insn.h
      riscv: kprobes: Move branch_funct3 to insn.h
      riscv: kprobes: Remove duplication of RV_EXTRACT_JTYPE_IMM
      riscv: kprobes: Remove duplication of RV_EXTRACT_RS1_REG
      riscv: kprobes: Remove duplication of RV_EXTRACT_BTYPE_IMM
      riscv: kprobes: Remove duplication of RVC_EXTRACT_JTYPE_IMM
      riscv: kprobes: Remove duplication of RVC_EXTRACT_C2_RS1_REG
      riscv: kprobes: Remove duplication of RVC_EXTRACT_BTYPE_IMM
      riscv: kprobes: Remove duplication of RV_EXTRACT_RD_REG
      riscv: kprobes: Remove duplication of RV_EXTRACT_UTYPE_IMM
      riscv: kprobes: Remove duplication of RV_EXTRACT_ITYPE_IMM

Pu Lehui (1):
      riscv: Enable ARCH_HAVE_NMI_SAFE_CMPXCHG

Thomas Huth (2):
      riscv: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
      riscv: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers

Yunhui Cui (2):
      riscv: introduce ioremap_wc()
      perf: riscv: skip empty batches in counter start

 Documentation/arch/riscv/hwprobe.rst               |   9 +
 .../devicetree/bindings/riscv/extensions.yaml      |   6 +
 arch/riscv/Kconfig                                 |   1 +
 arch/riscv/Kconfig.errata                          |  23 +++
 arch/riscv/Kconfig.vendor                          |  13 ++
 arch/riscv/errata/Makefile                         |   1 +
 arch/riscv/errata/mips/Makefile                    |   5 +
 arch/riscv/errata/mips/errata.c                    |  67 ++++++
 arch/riscv/include/asm/alternative-macros.h        |  12 +-
 arch/riscv/include/asm/alternative.h               |   5 +-
 arch/riscv/include/asm/asm-extable.h               |   6 +-
 arch/riscv/include/asm/asm.h                       |  10 +-
 arch/riscv/include/asm/assembler.h                 |   2 +-
 arch/riscv/include/asm/barrier.h                   |   4 +-
 arch/riscv/include/asm/cache.h                     |   4 +-
 arch/riscv/include/asm/cmpxchg.h                   |   3 +-
 arch/riscv/include/asm/cpu_ops_sbi.h               |   2 +-
 arch/riscv/include/asm/csr.h                       |   4 +-
 arch/riscv/include/asm/current.h                   |   4 +-
 arch/riscv/include/asm/errata_list.h               |  38 ++--
 arch/riscv/include/asm/errata_list_vendors.h       |  29 +++
 arch/riscv/include/asm/ftrace.h                    |   6 +-
 arch/riscv/include/asm/gpr-num.h                   |   6 +-
 arch/riscv/include/asm/hwprobe.h                   |   3 +-
 arch/riscv/include/asm/image.h                     |   4 +-
 arch/riscv/include/asm/insn-def.h                  |   8 +-
 arch/riscv/include/asm/insn.h                      | 216 +++++++++++++++++--
 arch/riscv/include/asm/io.h                        |   4 +
 arch/riscv/include/asm/jump_label.h                |   4 +-
 arch/riscv/include/asm/kasan.h                     |   2 +-
 arch/riscv/include/asm/kgdb.h                      |   4 +-
 arch/riscv/include/asm/mmu.h                       |   4 +-
 arch/riscv/include/asm/page.h                      |   4 +-
 arch/riscv/include/asm/pgtable.h                   |   5 +-
 arch/riscv/include/asm/processor.h                 |   4 +-
 arch/riscv/include/asm/ptrace.h                    |   4 +-
 arch/riscv/include/asm/scs.h                       |   4 +-
 arch/riscv/include/asm/set_memory.h                |   4 +-
 arch/riscv/include/asm/swab.h                      |  87 ++++++++
 arch/riscv/include/asm/thread_info.h               |   4 +-
 arch/riscv/include/asm/vdso.h                      |   4 +-
 arch/riscv/include/asm/vdso/getrandom.h            |   4 +-
 arch/riscv/include/asm/vdso/gettimeofday.h         |   4 +-
 arch/riscv/include/asm/vdso/processor.h            |   7 +-
 arch/riscv/include/asm/vdso/vsyscall.h             |   4 +-
 arch/riscv/include/asm/vendor_extensions/mips.h    |  37 ++++
 .../include/asm/vendor_extensions/mips_hwprobe.h   |  22 ++
 arch/riscv/include/asm/vendorid_list.h             |   1 +
 arch/riscv/include/uapi/asm/hwprobe.h              |   1 +
 arch/riscv/include/uapi/asm/kvm.h                  |   2 +-
 arch/riscv/include/uapi/asm/ptrace.h               |   4 +-
 arch/riscv/include/uapi/asm/sigcontext.h           |   4 +-
 arch/riscv/include/uapi/asm/vendor/mips.h          |   3 +
 arch/riscv/kernel/acpi.c                           |   3 +
 arch/riscv/kernel/alternative.c                    |   5 +
 arch/riscv/kernel/cpufeature.c                     |   6 +-
 arch/riscv/kernel/entry.S                          |   1 +
 arch/riscv/kernel/machine_kexec_file.c             |   2 +-
 arch/riscv/kernel/pi/Makefile                      |   2 +-
 arch/riscv/kernel/pi/cmdline_early.c               |   4 +-
 arch/riscv/kernel/pi/fdt_early.c                   |  40 ++++
 arch/riscv/kernel/pi/pi.h                          |   1 +
 arch/riscv/kernel/probes/simulate-insn.c           |  94 ++-------
 arch/riscv/kernel/sbi.c                            |   4 +-
 arch/riscv/kernel/sys_hwprobe.c                    |  18 +-
 arch/riscv/kernel/sys_riscv.c                      |   2 +-
 arch/riscv/kernel/tests/Kconfig.debug              |  12 ++
 arch/riscv/kernel/tests/Makefile                   |   1 +
 arch/riscv/kernel/tests/kprobes/Makefile           |   1 +
 arch/riscv/kernel/tests/kprobes/test-kprobes-asm.S | 229 +++++++++++++++++++++
 arch/riscv/kernel/tests/kprobes/test-kprobes.c     |  56 +++++
 arch/riscv/kernel/tests/kprobes/test-kprobes.h     |  24 +++
 arch/riscv/kernel/traps_misaligned.c               | 144 +------------
 arch/riscv/kernel/vector.c                         |   2 +-
 arch/riscv/kernel/vendor_extensions.c              |  10 +
 arch/riscv/kernel/vendor_extensions/Makefile       |   2 +
 arch/riscv/kernel/vendor_extensions/mips.c         |  22 ++
 arch/riscv/kernel/vendor_extensions/mips_hwprobe.c |  23 +++
 arch/riscv/kvm/vcpu_insn.c                         | 128 +-----------
 arch/riscv/mm/init.c                               |  12 +-
 drivers/perf/riscv_pmu_sbi.c                       |   8 +-
 lib/raid6/recov_rvv.c                              |   2 -
 lib/raid6/rvv.c                                    |  63 +++---
 tools/arch/riscv/include/asm/csr.h                 |   6 +-
 tools/arch/riscv/include/asm/vdso/processor.h      |   4 +-
 tools/testing/selftests/riscv/README               |  24 +++
 86 files changed, 1147 insertions(+), 530 deletions(-)
 create mode 100644 arch/riscv/errata/mips/Makefile
 create mode 100644 arch/riscv/errata/mips/errata.c
 create mode 100644 arch/riscv/include/asm/errata_list_vendors.h
 create mode 100644 arch/riscv/include/asm/swab.h
 create mode 100644 arch/riscv/include/asm/vendor_extensions/mips.h
 create mode 100644 arch/riscv/include/asm/vendor_extensions/mips_hwprobe.h
 create mode 100644 arch/riscv/include/uapi/asm/vendor/mips.h
 create mode 100644 arch/riscv/kernel/tests/kprobes/Makefile
 create mode 100644 arch/riscv/kernel/tests/kprobes/test-kprobes-asm.S
 create mode 100644 arch/riscv/kernel/tests/kprobes/test-kprobes.c
 create mode 100644 arch/riscv/kernel/tests/kprobes/test-kprobes.h
 create mode 100644 arch/riscv/kernel/vendor_extensions/mips.c
 create mode 100644 arch/riscv/kernel/vendor_extensions/mips_hwprobe.c
 create mode 100644 tools/testing/selftests/riscv/README

    text	   data	    bss	    dec		    hex	filename
12772113	6174082	 419253	19365448	1277e48	vmlinux.rv64.orig
12839941	6181502	 419253	19440696	128a438	vmlinux.rv64
11725507	5994510	 404229	18124246	1148dd6	vmlinux.rv64_nosmp.orig
11788867	6000158	 404229	18193254	1159b66	vmlinux.rv64_nosmp
11723502	4702818	 309629	16735949	 ff5ecd	vmlinux.rv32.orig
11771062	4703702	 309629	16784393	1001c09	vmlinux.rv32
 2612497	 761072	 119048	 3492617	 354b09	vmlinux.nommu_virt.orig
 2615066	 758584	 119048	 3492698	 354b5a	vmlinux.nommu_virt
--8323329-438314659-1759132822=:285450--

