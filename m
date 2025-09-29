Return-Path: <linux-kernel+bounces-836709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F982BAA66A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 21:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD2117AAEE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C147F244684;
	Mon, 29 Sep 2025 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHoWv5/Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13422241679
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759172566; cv=none; b=sDprgwRMbwYpSgnJbkoBixyOhaW2N5NaYfUOBM0xM8UrMj7yMnZxw8beaPbN1ItZ1H1kwCqs+YNMlj/hY3wYEmAfXpG7gA1vV+X1rUD0bdBY9PFqgvtA8PasW+fnEYEc/eR9awPF7Eu2jSxc6GIzLsPpwVoFeaT+wBojrGjEDN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759172566; c=relaxed/simple;
	bh=ai+mZqLI9ktRAJthfMIM/+h/k/K1iip4oB8EhNaXyYw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WgHWyKLLNrjlMXn3pY0Q4F1JXYXWhRcYXAZNUmp55hS0SrkAarNwT0l4LmHuf1ScF9yPnNsqNuNvg6LHnEVNvy+EjJSGdjsVP7llupwLpcspdaAq6LbCZxlRqH7BLSQr8RgZlX++PUdxmtYIkai669YZyuRNxNFkWIqcFDeozC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHoWv5/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C30C4CEF5;
	Mon, 29 Sep 2025 19:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759172565;
	bh=ai+mZqLI9ktRAJthfMIM/+h/k/K1iip4oB8EhNaXyYw=;
	h=Date:From:To:Cc:Subject:From;
	b=gHoWv5/QaKi92rgxQhUI8kH8+K5aXFb+gtKiy2WF0OcvqDeSY2OaD3MRG2+u1Zs1q
	 sHJUy3gZvIIEAQfUlItcIctVqbhT+5T9aRMjZ76RmBuG+4O/0oIAeqsy8ZE0xuGoBS
	 urSd/ryNX3qKRlgEZh48YErYFNpcNNvCSOYg7Tny6hrfNXkF1ds9O25KoU1oUAdAeN
	 AyIcqEC6qPyCK/G9eO7+j3yNcq1SFDOuxoP+yE4D4ilKUEk2IRpAAxmQjSEZWRDHC/
	 caJBUBVC3f7MsFxuAr2rK02GJu7q2VS6KlBGpN66ePTTmzZ48cUrqVVZsK8Hc2TymC
	 cmJZ2/ITtgEug==
Date: Mon, 29 Sep 2025 12:02:45 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexandre Ghiti <alexghiti@rivosinc.com>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
	Kees Cook <kees@kernel.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [GIT PULL] ffs-const update for v6.18-rc1
Message-ID: <202509291157.2B1EA74A21@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull this ffs() attribute-const update for v6.18-rc1. While
working on various hardening refactoring a while back we encountered
inconsistencies in the application of __attribute_const__ on the ffs()
family of functions. This series fixes this across all archs and adds
KUnit tests. Notably, this found a theoretical underflow in PCI (also
fixed here) and uncovered an inefficiency in ARC (fixed in the ARC
arch PR). I kept the series separate from the general hardening PR since
it is a stand-alone "topic".

Thanks!

-Kees

The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/ffs-const-v6.18-rc1

for you to fetch changes up to 95719dfa323709c06ec34cc96e73e0788e19934f:

  KUnit: ffs: Validate all the __attribute_const__ annotations (2025-09-08 14:58:52 -0700)

----------------------------------------------------------------
ffs-const update for v6.18-rc1

- PCI: Fix theoretical underflow in use of ffs().

- Universally apply __attribute_const__ to all architecture's ffs()-family
  of functions.

- Add KUnit tests for ffs() behavior and const-ness.

----------------------------------------------------------------
Kees Cook (18):
      PCI: Test for bit underflow in pcie_set_readrq()
      KUnit: Introduce ffs()-family tests
      bitops: Add __attribute_const__ to generic ffs()-family implementations
      csky: Add __attribute_const__ to ffs()-family implementations
      x86: Add __attribute_const__ to ffs()-family implementations
      powerpc: Add __attribute_const__ to ffs()-family implementations
      sh: Add __attribute_const__ to ffs()-family implementations
      alpha: Add __attribute_const__ to ffs()-family implementations
      hexagon: Add __attribute_const__ to ffs()-family implementations
      riscv: Add __attribute_const__ to ffs()-family implementations
      openrisc: Add __attribute_const__ to ffs()-family implementations
      m68k: Add __attribute_const__ to ffs()-family implementations
      mips: Add __attribute_const__ to ffs()-family implementations
      parisc: Add __attribute_const__ to ffs()-family implementations
      s390: Add __attribute_const__ to ffs()-family implementations
      xtensa: Add __attribute_const__ to ffs()-family implementations
      sparc: Add __attribute_const__ to ffs()-family implementations
      KUnit: ffs: Validate all the __attribute_const__ annotations

 lib/Kconfig.debug                          |  14 +
 lib/tests/Makefile                         |   1 +
 arch/alpha/include/asm/bitops.h            |  14 +-
 arch/csky/include/asm/bitops.h             |   8 +-
 arch/hexagon/include/asm/bitops.h          |  10 +-
 arch/m68k/include/asm/bitops.h             |  14 +-
 arch/mips/include/asm/bitops.h             |   8 +-
 arch/openrisc/include/asm/bitops/__ffs.h   |   2 +-
 arch/openrisc/include/asm/bitops/__fls.h   |   2 +-
 arch/openrisc/include/asm/bitops/ffs.h     |   2 +-
 arch/openrisc/include/asm/bitops/fls.h     |   2 +-
 arch/parisc/include/asm/bitops.h           |   6 +-
 arch/powerpc/include/asm/bitops.h          |   4 +-
 arch/riscv/include/asm/bitops.h            |   6 +-
 arch/s390/include/asm/bitops.h             |  10 +-
 arch/sh/include/asm/bitops.h               |   4 +-
 arch/sparc/include/asm/bitops_64.h         |   8 +-
 arch/x86/include/asm/bitops.h              |  12 +-
 arch/xtensa/include/asm/bitops.h           |  10 +-
 include/asm-generic/bitops/__ffs.h         |   2 +-
 include/asm-generic/bitops/__fls.h         |   2 +-
 include/asm-generic/bitops/builtin-__ffs.h |   2 +-
 include/asm-generic/bitops/builtin-__fls.h |   2 +-
 include/asm-generic/bitops/builtin-fls.h   |   2 +-
 include/asm-generic/bitops/ffs.h           |   2 +-
 include/asm-generic/bitops/fls.h           |   2 +-
 include/asm-generic/bitops/fls64.h         |   4 +-
 include/linux/bitops.h                     |   2 +-
 drivers/pci/pci.c                          |   6 +-
 lib/clz_ctz.c                              |   8 +-
 lib/tests/ffs_kunit.c                      | 566 +++++++++++++++++++++++++++++
 31 files changed, 661 insertions(+), 76 deletions(-)
 create mode 100644 lib/tests/ffs_kunit.c

-- 
Kees Cook

