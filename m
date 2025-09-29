Return-Path: <linux-kernel+bounces-836733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0FDBAA70A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 21:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366C21C067D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B16E23C4F3;
	Mon, 29 Sep 2025 19:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VixRNF+o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD381F7586
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759173351; cv=none; b=BERWwJwWaG12X3kL8wG09FDqfzgInML5hCQUYC7UQgyDgW3UJMNiakGnSbYdLcCrRWpn3Y1lOof8AQIkTkexZ8KQIsWLGGN59s5kdweqFkWq4sR1rThGTKn8gu+HJpVLgP6PpXU9S2jDGBAcCPxj8Ro9HIt2GhC1JbDrbIWvmQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759173351; c=relaxed/simple;
	bh=Y0wqNStuPRA7p+nx9RqfTaGGas2E1zLuGIYfCAIyod8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KkyOM+s+qXsE/s51qeUzzyGSTRqQ/4+yEUkAshSDHMXWop45mbiegxhGBiXJm2JHtZMwS/AXTznJM67Z8WkdK3FJb2UVUC+jtavy6Hcb63rp3W0COO0Adn/ieo+nXI2x0mU/g+Q6inJ5t5eX47XKC9u+DktBZgo1rNP4DeRwg2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VixRNF+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E1FC4CEF4;
	Mon, 29 Sep 2025 19:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759173350;
	bh=Y0wqNStuPRA7p+nx9RqfTaGGas2E1zLuGIYfCAIyod8=;
	h=Date:From:To:Cc:Subject:From;
	b=VixRNF+oMc/tilIB9ELuDeJsn+iAML60U3AL6b4qPVIFYS+DfkCcvTF0ym8ya1OYj
	 d8POJGG42I9x1Jy8DZj6I04X4JMusJYDD/Q1FegERL083Wxe5i3KHxvsBAQaM5CtZd
	 4Nx1odyu/pQWvwAVKHfMr6H7PQ8dR/P3eheEb0XCC65NI4Gq5WugrpCoXHUros7DEc
	 X7vCOG3EA2M6ADpxyiwS8espw8T9yogJjFb1n/DE0eoxj4TtJHI9meG2SQW2lI2Dtt
	 pzHyJWXxtaoYUlOw3Ac6GjDAtbZ6hYeaRoqhoyk3RVpbLsMTQM7a3YMAYvA6Duxa+z
	 meTbOLS1Y7+Xw==
Date: Mon, 29 Sep 2025 12:15:50 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Christopher Fore <csfore@posteo.net>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Junjie Cao <junjie.cao@intel.com>, Kees Cook <kees@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: [GIT PULL] hardening updates for v6.18-rc1
Message-ID: <202509291213.E313986EE@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these hardening updates for v6.18-rc1. One notable addition
is the creation of the "transitional" keyword for kconfig so CONFIG
renaming can go more smoothly. This has been a long-standing deficiency,
and with the renaming of CONFIG_CFI_CLANG to CONFIG_CFI (since GCC will
soon have KCFI support), this came up again. The breadth of the diffstat
is mainly this renaming.

Thanks!

-Kees

The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.18-rc1

for you to fetch changes up to c8a935a31bc787db52296944890f300ba9479088:

  lib/string_choices: Add str_assert_deassert() helper (2025-09-28 20:42:29 -0700)

----------------------------------------------------------------
hardening updates for v6.18-rc1

- Clean up usage of TRAILING_OVERLAP() (Gustavo A. R. Silva)

- lkdtm: fortify: Fix potential NULL dereference on kmalloc failure
  (Junjie Cao)

- Add str_assert_deassert() helper (Lad Prabhakar)

- gcc-plugins: Remove TODO_verify_il for GCC >= 16

- kconfig: Fix BrokenPipeError warnings in selftests

- kconfig: Add transitional symbol attribute for migration support

- kcfi: Rename CONFIG_CFI_CLANG to CONFIG_CFI

----------------------------------------------------------------
Gustavo A. R. Silva (2):
      stddef: Remove token-pasting in TRAILING_OVERLAP()
      stddef: Introduce __TRAILING_OVERLAP()

Junjie Cao (1):
      lkdtm: fortify: Fix potential NULL dereference on kmalloc failure

Kees Cook (4):
      gcc-plugins: Remove TODO_verify_il for GCC >= 16
      kconfig: Fix BrokenPipeError warnings in selftests
      kconfig: Add transitional symbol attribute for migration support
      kcfi: Rename CONFIG_CFI_CLANG to CONFIG_CFI

Lad Prabhakar (1):
      lib/string_choices: Add str_assert_deassert() helper

 arch/Kconfig                                       |  36 +++++---
 arch/arm/Kconfig                                   |   2 +-
 arch/arm64/Kconfig                                 |   4 +-
 arch/riscv/Kconfig                                 |   6 +-
 arch/x86/Kconfig                                   |  12 +--
 init/Kconfig                                       |   4 +-
 kernel/module/Kconfig                              |   2 +-
 scripts/kconfig/tests/err_transitional/Kconfig     |  52 +++++++++++
 scripts/kconfig/tests/transitional/Kconfig         | 100 +++++++++++++++++++++
 lib/Kconfig.debug                                  |   2 +-
 Makefile                                           |   2 +-
 arch/arm/mm/Makefile                               |   2 +-
 arch/riscv/kernel/Makefile                         |   2 +-
 arch/riscv/purgatory/Makefile                      |   2 +-
 arch/x86/kernel/Makefile                           |   2 +-
 arch/x86/purgatory/Makefile                        |   2 +-
 kernel/Makefile                                    |   2 +-
 scripts/gcc-plugins/gcc-common.h                   |   7 ++
 scripts/kconfig/expr.h                             |   1 +
 scripts/kconfig/lexer.l                            |   1 +
 scripts/kconfig/parser.y                           |  47 ++++++++++
 scripts/kconfig/symbol.c                           |   7 +-
 scripts/kconfig/tests/conftest.py                  |  17 +++-
 scripts/kconfig/tests/err_transitional/__init__.py |  14 +++
 .../kconfig/tests/err_transitional/expected_stderr |   7 ++
 scripts/kconfig/tests/transitional/__init__.py     |  18 ++++
 scripts/kconfig/tests/transitional/expected_config |  12 +++
 scripts/kconfig/tests/transitional/initial_config  |  16 ++++
 Documentation/kbuild/kconfig-language.rst          |  32 +++++++
 arch/riscv/include/asm/cfi.h                       |   4 +-
 arch/x86/include/asm/cfi.h                         |   4 +-
 include/asm-generic/vmlinux.lds.h                  |   2 +-
 include/linux/cfi.h                                |   6 +-
 include/linux/cfi_types.h                          |   8 +-
 include/linux/compiler.h                           |   2 +-
 include/linux/stddef.h                             |  24 ++++-
 include/linux/string_choices.h                     |   6 ++
 tools/include/linux/cfi_types.h                    |   6 +-
 tools/perf/util/include/linux/linkage.h            |   2 +-
 arch/arm/mm/cache-fa.S                             |   2 +-
 arch/arm/mm/cache-v4.S                             |   2 +-
 arch/arm/mm/cache-v4wb.S                           |   4 +-
 arch/arm/mm/cache-v4wt.S                           |   2 +-
 arch/arm/mm/cache-v6.S                             |   2 +-
 arch/arm/mm/cache-v7.S                             |   2 +-
 arch/arm/mm/cache-v7m.S                            |   2 +-
 arch/arm/mm/proc-arm1020.S                         |   2 +-
 arch/arm/mm/proc-arm1020e.S                        |   2 +-
 arch/arm/mm/proc-arm1022.S                         |   2 +-
 arch/arm/mm/proc-arm1026.S                         |   2 +-
 arch/arm/mm/proc-arm920.S                          |   2 +-
 arch/arm/mm/proc-arm922.S                          |   2 +-
 arch/arm/mm/proc-arm925.S                          |   2 +-
 arch/arm/mm/proc-arm926.S                          |   2 +-
 arch/arm/mm/proc-arm940.S                          |   2 +-
 arch/arm/mm/proc-arm946.S                          |   2 +-
 arch/arm/mm/proc-feroceon.S                        |   2 +-
 arch/arm/mm/proc-mohawk.S                          |   2 +-
 arch/arm/mm/proc-xsc3.S                            |   2 +-
 arch/arm/mm/tlb-v4.S                               |   2 +-
 arch/arm/kernel/hw_breakpoint.c                    |   2 +-
 arch/arm64/kernel/debug-monitors.c                 |   2 +-
 arch/arm64/kernel/traps.c                          |   4 +-
 arch/arm64/kvm/handle_exit.c                       |   2 +-
 arch/arm64/net/bpf_jit_comp.c                      |   2 +-
 arch/riscv/net/bpf_jit_comp64.c                    |   4 +-
 arch/x86/kernel/alternative.c                      |   4 +-
 arch/x86/kernel/kprobes/core.c                     |   2 +-
 drivers/misc/lkdtm/cfi.c                           |   2 +-
 drivers/misc/lkdtm/fortify.c                       |   6 ++
 kernel/module/tree_lookup.c                        |   2 +-
 kernel/configs/hardening.config                    |   4 +-
 72 files changed, 461 insertions(+), 96 deletions(-)
 create mode 100644 scripts/kconfig/tests/err_transitional/Kconfig
 create mode 100644 scripts/kconfig/tests/transitional/Kconfig
 create mode 100644 scripts/kconfig/tests/err_transitional/__init__.py
 create mode 100644 scripts/kconfig/tests/err_transitional/expected_stderr
 create mode 100644 scripts/kconfig/tests/transitional/__init__.py
 create mode 100644 scripts/kconfig/tests/transitional/expected_config
 create mode 100644 scripts/kconfig/tests/transitional/initial_config

-- 
Kees Cook

