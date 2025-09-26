Return-Path: <linux-kernel+bounces-834469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B75BA4C1E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 19:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279061BC8572
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B2930C375;
	Fri, 26 Sep 2025 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLnt0fvu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8F430C113
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758906838; cv=none; b=ptZHEs+V+vc03KUI7NmUZZez9xnYWJVROdsBr/LpSLKN1qHIZfsBqSTpYF66M10xWr+PdiCvk1oaMICt576hE/cecgf1G22XSkCpvcH/aJTCgreW0EEhUkqWinSrMrllkpn5XS8eniEAY6gWm0yy1+e1Xv8hkcFPbGyadWtlWDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758906838; c=relaxed/simple;
	bh=RMV2RaedvC5Y0gRIU0vdfl0S8pQOsbtyYE4sgejaprM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=klNkE7Mu+/3tK4oRigRKysS98hlQ1022k2ynUkdLKKcmwC9j4NpZoMXaM+HnNFdm9wyAscJCfVien9zQeDewE58K/O1XdlMDdlf0rSPfQ1ajvzYgqHGOyfz/vRI5546kKtOA/BgwDp/5YXeiMwxtLzU2PD30WkKO4abYRNy6aw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLnt0fvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55A2C4CEF4;
	Fri, 26 Sep 2025 17:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758906838;
	bh=RMV2RaedvC5Y0gRIU0vdfl0S8pQOsbtyYE4sgejaprM=;
	h=Date:From:To:Cc:Subject:From;
	b=eLnt0fvuSKQjK17kLekpuFNKLNyMYAVGa5QvksEugIVI6Nl5a56Q8TvZOnfzVhYHH
	 LHmp8wNLp5oVCQtREhnckL5O0CHlBZthbGqCWNT8sXNqtB1zWgXZC0swv4gZNzWojG
	 Ci9tQGtmGF+GzSbZaLlUkZxW0FR/829V2svMAmVy9GY7B8ae6+2jPiTUTSapj6PxAa
	 ZlcTFIciHTrqVEI5UPi5Ay6STJYdf3MG7eSxpxIdgDzprg4lWV+kCUvBUZGhf7/VtG
	 XGh3gpUFHR4lOP2yPdFkbAMXTBXt9Fj3a7MhzZn9N0i1ZNDguBrNeZCKp3LTLYrk+M
	 6VVm2RnzvvpSg==
Date: Fri, 26 Sep 2025 18:13:53 +0100
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	brauner@kernel.org
Subject: [GIT PULL] arm64 updates for 6.18
Message-ID: <aNbJ0YiL7Us_eicz@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

[sending this early as I'm fishing on Monday]

Please pull this wad of arm64 changes for 6.18. There's good stuff
across the board, including some nice mm improvements for CPUs with
the "noabort" BBML2 feature and a clever patch to allow ptdump to play
nicely with block mappings in the vmalloc area.

We've only had a couple of trivial conflicts show up in -next:

  * The fs-next tree has taken clone3() support for shadow stacks and
    this gives rise to a simple context conflict in our asm/gcs.h.
    There's been some late ABI feedback from the glibc community,
    however, so maybe Christian will end up dropping the patches [1].

  * The kbuild tree has removed the tautological dependency that
    CONFIG_CPU_BIG_ENDIAN has on the assembler version. However, we've
    extended that to make it depend on BROKEN in anticipation of
    dropping support altogether.

I've already got a handful of minor fixes to go on top but I'll send
those separately once they've had a chance to sit in -next.

Summary in the tag.

Cheers,

Will

[1] https://lore.kernel.org/r/20250919-unredlich-lohnkampf-d3d0836baeec@brauner

--->8

The following changes since commit a7ed7b9d0ebb038db9963d574da0311cab0b666a:

  arm64: ftrace: fix unreachable PLT for ftrace_caller in init_module with CONFIG_DYNAMIC_FTRACE (2025-09-05 16:56:20 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to ea0b39168d3a2313eabd145fb3440c946ccff4d1:

  arm64: cpufeature: Remove duplicate asm/mmu.h header (2025-09-24 16:44:44 +0100)

----------------------------------------------------------------
arm64 updates for 6.18

Confidential computing:
 - Add support for accepting secrets from firmware (e.g. ACPI CCEL)
   and mapping them with appropriate attributes.

CPU features:
 - Advertise atomic floating-point instructions to userspace.

 - Extend Spectre workarounds to cover additional Arm CPU variants.

 - Extend list of CPUs that support break-before-make level 2 and
   guarantee not to generate TLB conflict aborts for changes of mapping
   granularity (BBML2_NOABORT).

 - Add GCS support to our uprobes implementation.

Documentation:
 - Remove bogus SME documentation concerning register state when
   entering/exiting streaming mode.

Entry code:
 - Switch over to the generic IRQ entry code (GENERIC_IRQ_ENTRY).

 - Micro-optimise syscall entry path with a compiler branch hint.

Memory management:
 - Enable huge mappings in vmalloc space even when kernel page-table
   dumping is enabled.

 - Tidy up the types used in our early MMU setup code.

 - Rework rodata= for closer parity with the behaviour on x86.

 - For CPUs implementing BBML2_NOABORT, utilise block mappings in the
   linear map even when rodata= applies to virtual aliases.

 - Don't re-allocate the virtual region between '_text' and '_stext',
   as doing so confused tools parsing /proc/vmcore.

Miscellaneous:
 - Clean-up Kconfig menuconfig text for architecture features.

 - Avoid redundant bitmap_empty() during determination of supported
   SME vector lengths.

 - Re-enable warnings when building the 32-bit vDSO object.

 - Avoid breaking our eggs at the wrong end.

Perf and PMUs:
 - Support for v3 of the Hisilicon L3C PMU.

 - Support for Hisilicon's MN and NoC PMUs.

 - Support for Fujitsu's Uncore PMU.

 - Support for SPE's extended event filtering feature.

 - Preparatory work to enable data source filtering in SPE.

 - Support for multiple lanes in the DWC PCIe PMU.

 - Support for i.MX94 in the IMX DDR PMU driver.

 - MAINTAINERS update (Thank you, Yicong).

 - Minor driver fixes (PERF_IDX2OFF() overflow, CMN register offsets).

Selftests:
 - Add basic LSFE check to the existing hwcaps test.

 - Support nolibc in GCS tests.

 - Extend SVE ptrace test to pass unsupported regsets and invalid vector
   lengths.

 - Minor cleanups (typos, cosmetic changes).

System registers:
 - Fix ID_PFR1_EL1 definition.

 - Fix incorrect signedness of some fields in ID_AA64MMFR4_EL1.

 - Sync TCR_EL1 definition with the latest Arm ARM (L.b).

 - Be stricter about the input fed into our AWK sysreg generator script.

 - Typo fixes and removal of redundant definitions.

ACPI, EFI and PSCI:
 - Decouple Arm's "Software Delegated Exception Interface" (SDEI)
   support from the ACPI GHES code so that it can be used by platforms
   booted with device-tree.

 - Remove unnecessary per-CPU tracking of the FPSIMD state across EFI
   runtime calls.

 - Fix a node refcount imbalance in the PSCI device-tree code.

CPU Features:
 - Ensure register sanitisation is applied to fields in ID_AA64MMFR4.

 - Expose AIDR_EL1 to userspace via sysfs, primarily so that KVM guests
   can reliably query the underlying CPU types from the VMM.

 - Re-enabling of SME support (CONFIG_ARM64_SME) as a result of fixes
   to our context-switching, signal handling and ptrace code.

----------------------------------------------------------------
Anshuman Khandual (1):
      arm64/sysreg: Update TCR_EL1 register

Bala-Vignesh-Reddy (2):
      selftests: arm64: Check fread return value in exec_target
      selftests: arm64: Fix -Waddress warning in tpidr2 test

Can Peng (1):
      arm/syscalls: mark syscall invocation as likely in invoke_syscall

Dev Jain (2):
      arm64: Enable permission change on arm64 kernel block mappings
      arm64: Enable vmalloc-huge with ptdump

Fuad Tabba (3):
      arm64: sysreg: Fix and tidy up sysreg field definitions
      arm64: sysreg: Correct sign definitions for EIESB and DoubleLock
      arm64: sysreg: Add validation checks to sysreg header generation script

Huang Shijie (2):
      arm64: mm: Rework the 'rodata=' options
      arm64/Kconfig: Remove CONFIG_RODATA_FULL_DEFAULT_ENABLED

Ilkka Koskinen (2):
      perf/dwc_pcie: Support counting multiple lane events in parallel
      perf/dwc_pcie: Fix use of uninitialized variable

James Clark (5):
      arm64: sysreg: Add new PMSFCR_EL1 fields and PMSDSFR_EL1 register
      perf: arm_spe: Support FEAT_SPEv1p4 filters
      perf: arm_spe: Add support for FEAT_SPE_EFT extended filtering
      arm64/boot: Factor out a macro to check SPE version
      arm64/boot: Enable EL2 requirements for SPE_FEAT_FDS

Jeremy Linton (8):
      arm64: probes: Break ret out from bl/blr
      arm64: uaccess: Move existing GCS accessors definitions to gcs.h
      arm64: uaccess: Add additional userspace GCS accessors
      arm64: probes: Add GCS support to bl/blr/ret
      arm64: uprobes: Add GCS support to uretprobes
      arm64: Kconfig: Remove GCS restrictions on UPROBES
      uprobes: uprobe_warn should use passed task
      arm64: probes: Fix incorrect bl/blr address and register usage

Jiapeng Chong (1):
      arm64: cpufeature: Remove duplicate asm/mmu.h header

Jinjie Ruan (8):
      arm64: ptrace: Replace interrupts_enabled() with regs_irqs_disabled()
      arm64: entry: Refactor the entry and exit for exceptions from EL1
      arm64: entry: Rework arm64_preempt_schedule_irq()
      arm64: entry: Use preempt_count() and need_resched() helper
      entry: Add arch_irqentry_exit_need_resched() for arm64
      arm64: entry: Refactor preempt_schedule_irq() check code
      arm64: entry: Move arm64_preempt_schedule_irq() into __exit_to_kernel_mode()
      arm64: entry: Switch to generic IRQ entry

Junhao He (1):
      drivers/perf: hisi: Add support for HiSilicon MN PMU driver

Koichi Okuno (1):
      perf: Fujitsu: Add the Uncore PMU driver

Kuninori Morimoto (2):
      arm64: cputype: Add Cortex-A720AE definitions
      arm64: errata: Expand speculative SSBS workaround for Cortex-A720AE

Leo Yan (3):
      perf: arm_spe: Expose event filter
      coresight: trbe: Prevent overflow in PERF_IDX2OFF()
      perf: arm_spe: Prevent overflow in PERF_IDX2OFF()

Mark Brown (6):
      arm64/sme: Drop inaccurate documentation of streaming mode switches
      kselftest/arm64: Log error codes in sve-ptrace
      arm64/hwcap: Add hwcap for FEAT_LSFE
      kselftest/arm64: Verify that we reject out of bounds VLs in sve-ptrace
      kselftest/arm64: Check that unsupported regsets fail in sve-ptrace
      kselftest/arm64: Add lsfe to the hwcaps test

Mark Rutland (3):
      arm64: cputype: Remove duplicate Cortex-X1C definitions
      arm64: cputype: Add Neoverse-V3AE definitions
      arm64: errata: Apply workarounds for Neoverse-V3AE

Nikola Z. Ivanov (1):
      selftests/arm64: Fix grammatical error in string literals

Omar Sandoval (1):
      arm64: map [_text, _stext) virtual address range non-executable+read-only

Robin Murphy (1):
      perf/arm-cmn: Fix CMN S3 DTM offset

Ryan Roberts (2):
      arm64: mm: split linear mapping if BBML2 unsupported on secondary CPUs
      arm64: cpufeature: add Neoverse-V3AE to BBML2 allow list

Sam Edwards (3):
      arm64: mm: Cast start/end markers to char *, not u64
      arm64: mm: Make map_fdt() return mapped pointer
      arm64: mm: Represent physical memory with phys_addr_t and resource_size_t

Shanker Donthineni (2):
      arm64: cputype: Add NVIDIA Olympus definitions
      arm64: cpufeature: Add Olympus MIDR to BBML2 allow list

Suzuki K Poulose (3):
      arm64: realm: ioremap: Allow mapping memory as encrypted
      arm64: Enable EFI secret area Securityfs support
      arm64: acpi: Enable ACPI CCEL support

Thomas Weiﬂschuh (5):
      kselftest/arm64/gcs: Correctly check return value when disabling GCS
      kselftest/arm64/gcs: Use nolibc's getauxval()
      arm64: vdso32: Stop suppressing warnings
      arm64: vdso32: Respect -Werror from kbuild
      kselftest/arm64/gcs/basic-gcs: Respect parent directory CFLAGS

Vivek Yadav (3):
      kselftest/arm64: Remove extra blank line
      kselftest/arm64: Supress warning and improve readability
      kselftest/arm64: Add parentheses around sizeof for clarity

Will Deacon (14):
      arm64: Kconfig: Spell out "ARMv9.4" in menuconfig text
      arm64: Kconfig: Make CPU_BIG_ENDIAN depend on BROKEN
      Merge branch 'for-next/fixes' into for-next/core
      Merge branch 'for-next/cca' into for-next/core
      Merge branch 'for-next/cpufeature' into for-next/core
      Merge branch 'for-next/docs' into for-next/core
      Merge branch 'for-next/entry' into for-next/core
      Merge branch 'for-next/misc' into for-next/core
      Merge branch 'for-next/mm' into for-next/core
      Merge branch 'for-next/perf' into for-next/core
      Merge branch 'for-next/selftests' into for-next/core
      Merge branch 'for-next/sysregs' into for-next/core
      Merge branch 'for-next/uprobes' into for-next/core
      Merge branch 'for-next/vdso' into for-next/core

Xichao Zhao (1):
      drivers: perf: use us_to_ktime() where appropriate

Xu Yang (3):
      dt-bindings: perf: fsl-imx-ddr: Add a compatible string fsl,imx94-ddr-pmu for i.MX94
      perf: imx_perf: add support for i.MX94 platform
      MAINTAINERS: include fsl_imx9_ddr_perf.c and some perf metric files

Yang Shi (2):
      arm64: cpufeature: add AmpereOne to BBML2 allow list
      arm64: mm: support large block mapping when rodata=full

Yicong Yang (10):
      perf: arm_pmuv3: Factor out PMCCNTR_EL0 use conditions
      drivers/perf: hisi: Add support for HiSilicon NoC PMU
      MAINTAINERS: Remove myself from HiSilicon PMU maintainers
      drivers/perf: hisi: Relax the event ID check in the framework
      drivers/perf: hisi: Export hisi_uncore_pmu_isr()
      drivers/perf: hisi: Simplify the probe process of each L3C PMU version
      drivers/perf: hisi: Extract the event filter check of L3C PMU
      drivers/perf: hisi: Extend the field of tt_core
      drivers/perf: hisi: Refactor the event configuration of L3C PMU
      drivers/perf: hisi: Add support for L3C PMU v3

Yury Norov (NVIDIA) (1):
      arm64/fpsimd: simplify sme_setup()

Yushan Wang (2):
      Documentation: hisi-pmu: Fix of minor format error
      Documentation: hisi-pmu: Add introduction to HiSilicon V3 PMU

 Documentation/admin-guide/kernel-parameters.txt    |   5 +-
 Documentation/admin-guide/perf/dwc_pcie_pmu.rst    |   4 +-
 .../admin-guide/perf/fujitsu_uncore_pmu.rst        | 110 ++++
 Documentation/admin-guide/perf/hisi-pmu.rst        |  49 +-
 Documentation/admin-guide/perf/index.rst           |   1 +
 Documentation/arch/arm64/booting.rst               |  11 +
 Documentation/arch/arm64/elf_hwcaps.rst            |   4 +
 Documentation/arch/arm64/silicon-errata.rst        |   2 +
 Documentation/arch/arm64/sme.rst                   |  14 +-
 .../devicetree/bindings/perf/fsl-imx-ddr.yaml      |   1 +
 MAINTAINERS                                        |   4 +-
 arch/arm64/Kconfig                                 |  23 +-
 arch/arm64/include/asm/cpufeature.h                |   2 +
 arch/arm64/include/asm/cputype.h                   |   8 +-
 arch/arm64/include/asm/daifflags.h                 |   2 +-
 arch/arm64/include/asm/el2_setup.h                 |  28 +-
 arch/arm64/include/asm/entry-common.h              |  57 ++
 arch/arm64/include/asm/exception.h                 |   1 -
 arch/arm64/include/asm/gcs.h                       |  91 ++-
 arch/arm64/include/asm/hwcap.h                     |   1 +
 arch/arm64/include/asm/io.h                        |   6 +-
 arch/arm64/include/asm/mmu.h                       |   3 +
 arch/arm64/include/asm/pgtable.h                   |   5 +
 arch/arm64/include/asm/preempt.h                   |   2 -
 arch/arm64/include/asm/ptdump.h                    |   2 +
 arch/arm64/include/asm/ptrace.h                    |  13 +-
 arch/arm64/include/asm/rsi.h                       |   2 +-
 arch/arm64/include/asm/setup.h                     |   4 +-
 arch/arm64/include/asm/sysreg.h                    |  11 -
 arch/arm64/include/asm/uaccess.h                   |  40 --
 arch/arm64/include/asm/vmalloc.h                   |   9 +-
 arch/arm64/include/asm/xen/events.h                |   2 +-
 arch/arm64/include/uapi/asm/hwcap.h                |   1 +
 arch/arm64/kernel/acpi.c                           |  12 +-
 arch/arm64/kernel/cpu_errata.c                     |   2 +
 arch/arm64/kernel/cpufeature.c                     |  15 +-
 arch/arm64/kernel/cpuinfo.c                        |   1 +
 arch/arm64/kernel/debug-monitors.c                 |   2 +-
 arch/arm64/kernel/entry-common.c                   | 423 +++++---------
 arch/arm64/kernel/fpsimd.c                         |   5 +-
 arch/arm64/kernel/pi/map_kernel.c                  |  47 +-
 arch/arm64/kernel/pi/map_range.c                   |  20 +-
 arch/arm64/kernel/pi/pi.h                          |   9 +-
 arch/arm64/kernel/probes/decode-insn.c             |   7 +-
 arch/arm64/kernel/probes/simulate-insn.c           |  50 +-
 arch/arm64/kernel/probes/simulate-insn.h           |   3 +-
 arch/arm64/kernel/probes/uprobes.c                 |  33 ++
 arch/arm64/kernel/proton-pack.c                    |   1 +
 arch/arm64/kernel/rsi.c                            |  26 +-
 arch/arm64/kernel/sdei.c                           |   2 +-
 arch/arm64/kernel/setup.c                          |   4 +-
 arch/arm64/kernel/signal.c                         |   3 +-
 arch/arm64/kernel/syscall.c                        |   2 +-
 arch/arm64/kernel/vdso32/Makefile                  |  13 +-
 arch/arm64/mm/init.c                               |   8 +-
 arch/arm64/mm/mmu.c                                | 494 ++++++++++++++++-
 arch/arm64/mm/pageattr.c                           | 129 +++--
 arch/arm64/mm/proc.S                               |  27 +-
 arch/arm64/mm/ptdump.c                             |  11 +-
 arch/arm64/tools/gen-sysreg.awk                    |  20 +
 arch/arm64/tools/sysreg                            |  83 ++-
 drivers/hwtracing/coresight/coresight-trbe.c       |   3 +-
 drivers/perf/Kconfig                               |   9 +
 drivers/perf/Makefile                              |   1 +
 drivers/perf/arm-ccn.c                             |   2 +-
 drivers/perf/arm-cmn.c                             |   9 +-
 drivers/perf/arm_pmuv3.c                           |  29 +-
 drivers/perf/arm_spe_pmu.c                         | 114 +++-
 drivers/perf/dwc_pcie_pmu.c                        | 161 ++++--
 drivers/perf/fsl_imx9_ddr_perf.c                   |   6 +
 drivers/perf/fujitsu_uncore_pmu.c                  | 613 +++++++++++++++++++++
 drivers/perf/hisilicon/Makefile                    |   3 +-
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c       | 528 +++++++++++++++---
 drivers/perf/hisilicon/hisi_uncore_mn_pmu.c        | 411 ++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_noc_pmu.c       | 443 +++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_pmu.c           |   5 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.h           |   6 +-
 drivers/virt/coco/efi_secret/Kconfig               |   2 +-
 include/linux/pagewalk.h                           |   3 +
 kernel/entry/common.c                              |  16 +-
 kernel/events/uprobes.c                            |   2 +-
 mm/pagewalk.c                                      |  36 +-
 tools/testing/selftests/arm64/abi/hwcap.c          |  22 +-
 tools/testing/selftests/arm64/abi/tpidr2.c         |   8 +-
 tools/testing/selftests/arm64/bti/assembler.h      |   1 -
 tools/testing/selftests/arm64/fp/fp-ptrace.c       |   1 -
 tools/testing/selftests/arm64/fp/fp-stress.c       |   6 +-
 tools/testing/selftests/arm64/fp/kernel-test.c     |   4 +-
 tools/testing/selftests/arm64/fp/sve-ptrace.c      | 104 +++-
 tools/testing/selftests/arm64/fp/vec-syscfg.c      |   1 -
 tools/testing/selftests/arm64/fp/zt-ptrace.c       |   1 -
 tools/testing/selftests/arm64/gcs/Makefile         |   6 +-
 tools/testing/selftests/arm64/gcs/basic-gcs.c      |  12 +-
 tools/testing/selftests/arm64/gcs/gcs-locking.c    |   1 -
 tools/testing/selftests/arm64/gcs/gcs-stress.c     |   2 +-
 tools/testing/selftests/arm64/pauth/exec_target.c  |   7 +-
 96 files changed, 3781 insertions(+), 767 deletions(-)
 create mode 100644 Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst
 create mode 100644 arch/arm64/include/asm/entry-common.h
 create mode 100644 drivers/perf/fujitsu_uncore_pmu.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_mn_pmu.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_noc_pmu.c

