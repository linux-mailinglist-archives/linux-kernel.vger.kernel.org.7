Return-Path: <linux-kernel+bounces-748714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7736B14537
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 02:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDBD918A0061
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 00:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BE62E36F7;
	Tue, 29 Jul 2025 00:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWQmZubb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467E0382
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 00:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753747294; cv=none; b=lS/jYjfkUoOwD5ciFTL0u6YWWk5JUVbdkGg1q6rXpyuLimi//ZOEuvEnS+6V2doFvuyjqs7EtRm3NpCbbB/NtSqct/IZ7dfj17hcakd9SjcvJGAymsg4fubHhM4yrYDaAx1cLjnZh9iFmm+qrLin08wWuGmjBCDLXWUy9C2rkOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753747294; c=relaxed/simple;
	bh=iJo7tCRxnWaLfNskip7EZO9ocX7lRotT7Q9vgaTtDBs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HapallCwPVWBeZsHbY5kFk1kE0Wbs7lFpH+Ky9+Dn9vxNTm9shExdcV12sGMCX2grCMdGAKwLWaLn37WVCaMCWGEKhq6kLz8nI2M7hjoSdWq1l+QVtPeAa/LHlY8Oh76rlmhquMFbcde4hsUKXk6AJ5GWaZHJWkusy62W2BQgRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWQmZubb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5469C4CEE7;
	Tue, 29 Jul 2025 00:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753747293;
	bh=iJo7tCRxnWaLfNskip7EZO9ocX7lRotT7Q9vgaTtDBs=;
	h=Date:From:To:Cc:Subject:From;
	b=jWQmZubbPHyK5gcaPg+vkTelqWT0UTBR+pN366sw9oMccMKpJ8wNkPjFjveNvE9h2
	 SpQDCOc+CxC+Vb86Tz6SZQ6sv8z6Lg5HsL3uCDNddPC7iuls5HbIQhwm+hZI/GlgYz
	 5qBr1xMYRB6orfQ0O4fSLo9fMoI1YGEXTmDSn8VhYesdYWgndpWIwnn7Nmr2x071MY
	 5YLB+kCr/P6ViY6xwZbUD1gwaaZdYgHfzzUDHGUWvmr4I3uusJbbuKaQbDiaM7OfbG
	 8aXmBtIidusEglO8cDp6tWrevOkTmrRhTvpwOWvziTbLlYe1EQJoibZxvFWsc6LHll
	 1fIMl7Xu3pPCA==
Date: Mon, 28 Jul 2025 17:01:33 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Gow <davidgow@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ingo Molnar <mingo@kernel.org>,
	Jannik =?iso-8859-1?Q?Gl=FCckert?= <jannik.glueckert@gmail.com>,
	Kees Cook <kees@kernel.org>, kernel test robot <lkp@intel.com>,
	Lee Jones <lee@kernel.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Marco Elver <elver@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <n.schier@avm.de>, Nishanth Menon <nm@ti.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [GIT PULL] hardening updates for v6.17-rc1
Message-ID: <202507281251.8989493D@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these hardening updates for v6.17-rc1. Some notable things
that stand out diffstat: there are many scattered changes across arch code
to clean up __init vs KCOV instrumentation. Most are landing here via
the hardening tree but 2 landed separately in their respective trees:
loongarch in v6.16 already, and platform-drivers-x86 that is queued
for merging:
https://lore.kernel.org/all/pdx86-pr-20250728141420-2408727195@linux.intel.com/
Also the stackleak feature has gained native Clang support, and got
renamed as part of the refactoring work, which ends up touching all the
arch Kconfig and Makefile files.

Thanks!

-Kees

The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.17-rc1

for you to fetch changes up to 32e42ab9fc88a884435c27527a433f61c4d2b61b:

  sched/task_stack: Add missing const qualifier to end_of_stack() (2025-07-26 14:28:35 -0700)

----------------------------------------------------------------
hardening updates for v6.17-rc1

- Introduce and start using TRAILING_OVERLAP() helper for fixing
  embedded flex array instances (Gustavo A. R. Silva)

- mux: Convert mux_control_ops to a flex array member in mux_chip
  (Thorsten Blum)

- string: Group str_has_prefix() and strstarts() (Andy Shevchenko)

- Remove KCOV instrumentation from __init and __head (Ritesh Harjani,
  Kees Cook)

- Refactor and rename stackleak feature to support Clang

- Add KUnit test for seq_buf API

- Fix KUnit fortify test under LTO

----------------------------------------------------------------
Andy Shevchenko (1):
      string: Group str_has_prefix() and strstarts()

Gustavo A. R. Silva (2):
      stddef: Introduce TRAILING_OVERLAP() helper macro
      acpi: nfit: intel: avoid multiple -Wflex-array-member-not-at-end warnings

Kees Cook (17):
      kunit/fortify: Add back "volatile" for sizeof() constants
      seq_buf: Introduce KUnit tests
      stackleak: Rename STACKLEAK to KSTACK_ERASE
      stackleak: Rename stackleak_track_stack to __sanitizer_cov_stack_depth
      stackleak: Split KSTACK_ERASE_CFLAGS from GCC_PLUGINS_CFLAGS
      configs/hardening: Enable CONFIG_KSTACK_ERASE
      configs/hardening: Enable CONFIG_INIT_ON_FREE_DEFAULT_ON
      mips: Handle KCOV __init vs inline mismatch
      arm: Handle KCOV __init vs inline mismatches
      s390: Handle KCOV __init vs inline mismatches
      arm64: Handle KCOV __init vs inline mismatches
      x86: Handle KCOV __init vs inline mismatches
      kstack_erase: Disable kstack_erase for all of arm compressed boot code
      init.h: Disable sanitizer coverage for __init and __head
      kstack_erase: Add -mgeneral-regs-only to silence Clang warnings
      kstack_erase: Support Clang stack depth tracking
      sched/task_stack: Add missing const qualifier to end_of_stack()

Ritesh Harjani (IBM) (1):
      powerpc/mm/book3s64: Move kfence and debug_pagealloc related calls to __init section

Thorsten Blum (1):
      mux: Convert mux_control_ops to a flex array member in mux_chip

 arch/Kconfig                                       |   4 +-
 arch/arm/Kconfig                                   |   2 +-
 arch/arm64/Kconfig                                 |   2 +-
 arch/loongarch/Kconfig                             |   2 +-
 arch/riscv/Kconfig                                 |   2 +-
 arch/s390/Kconfig                                  |   2 +-
 arch/x86/Kconfig                                   |   2 +-
 lib/Kconfig.debug                                  |   9 +
 security/Kconfig.hardening                         |  45 +++--
 Makefile                                           |   1 +
 arch/arm/boot/compressed/Makefile                  |   2 +-
 arch/arm/vdso/Makefile                             |   2 +-
 arch/arm64/kernel/pi/Makefile                      |   2 +-
 arch/arm64/kernel/vdso/Makefile                    |   3 +-
 arch/arm64/kvm/hyp/nvhe/Makefile                   |   2 +-
 arch/riscv/kernel/pi/Makefile                      |   2 +-
 arch/riscv/purgatory/Makefile                      |   2 +-
 arch/sparc/vdso/Makefile                           |   3 +-
 arch/x86/entry/vdso/Makefile                       |   3 +-
 arch/x86/purgatory/Makefile                        |   2 +-
 drivers/firmware/efi/libstub/Makefile              |   8 +-
 drivers/misc/lkdtm/Makefile                        |   2 +-
 kernel/Makefile                                    |  11 +-
 lib/Makefile                                       |   2 +-
 lib/tests/Makefile                                 |   1 +
 scripts/Makefile.gcc-plugins                       |  16 +-
 scripts/Makefile.kstack_erase                      |  21 +++
 scripts/gcc-plugins/stackleak_plugin.c             |  52 +++---
 Documentation/admin-guide/sysctl/kernel.rst        |   4 +-
 Documentation/arch/x86/x86_64/mm.rst               |   2 +-
 Documentation/security/self-protection.rst         |   2 +-
 .../zh_CN/security/self-protection.rst             |   2 +-
 arch/arm64/include/asm/acpi.h                      |   2 +-
 arch/mips/include/asm/time.h                       |   2 +-
 arch/s390/hypfs/hypfs.h                            |   2 +-
 arch/s390/hypfs/hypfs_diag.h                       |   2 +-
 arch/x86/entry/calling.h                           |   4 +-
 arch/x86/include/asm/acpi.h                        |   4 +-
 arch/x86/include/asm/init.h                        |   2 +-
 arch/x86/include/asm/realmode.h                    |   2 +-
 include/linux/acpi.h                               |   4 +-
 include/linux/bootconfig.h                         |   2 +-
 include/linux/efi.h                                |   2 +-
 include/linux/init.h                               |   4 +-
 include/linux/{stackleak.h => kstack_erase.h}      |  20 +-
 include/linux/memblock.h                           |   2 +-
 include/linux/mfd/dbx500-prcmu.h                   |   2 +-
 include/linux/mux/driver.h                         |   4 +-
 include/linux/sched.h                              |   4 +-
 include/linux/sched/task_stack.h                   |   2 +-
 include/linux/smp.h                                |   2 +-
 include/linux/stddef.h                             |  20 ++
 include/linux/string.h                             |  20 +-
 arch/arm/kernel/entry-common.S                     |   2 +-
 arch/arm64/kernel/entry.S                          |   2 +-
 arch/riscv/kernel/entry.S                          |   2 +-
 arch/s390/kernel/entry.S                           |   2 +-
 arch/arm/mm/cache-feroceon-l2.c                    |   2 +-
 arch/arm/mm/cache-tauros2.c                        |   2 +-
 arch/powerpc/mm/book3s64/hash_utils.c              |   6 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c           |   4 +-
 arch/s390/mm/init.c                                |   2 +-
 arch/x86/kernel/kvm.c                              |   2 +-
 arch/x86/mm/init_64.c                              |   2 +-
 drivers/acpi/nfit/intel.c                          | 119 ++++++------
 drivers/clocksource/timer-orion.c                  |   2 +-
 drivers/misc/lkdtm/{stackleak.c => kstack_erase.c} |  26 +--
 drivers/mux/core.c                                 |   7 +-
 drivers/soc/ti/pm33xx.c                            |   2 +-
 fs/proc/base.c                                     |   6 +-
 kernel/fork.c                                      |   2 +-
 kernel/kexec_handover.c                            |   4 +-
 kernel/{stackleak.c => kstack_erase.c}             |  22 +--
 lib/tests/fortify_kunit.c                          |   4 +-
 lib/tests/seq_buf_kunit.c                          | 208 +++++++++++++++++++++
 tools/objtool/check.c                              |   4 +-
 tools/testing/selftests/lkdtm/config               |   2 +-
 MAINTAINERS                                        |   6 +-
 kernel/configs/hardening.config                    |   6 +
 79 files changed, 514 insertions(+), 259 deletions(-)
 create mode 100644 scripts/Makefile.kstack_erase
 rename include/linux/{stackleak.h => kstack_erase.h} (81%)
 rename drivers/misc/lkdtm/{stackleak.c => kstack_erase.c} (89%)
 rename kernel/{stackleak.c => kstack_erase.c} (87%)
 create mode 100644 lib/tests/seq_buf_kunit.c

-- 
Kees Cook

