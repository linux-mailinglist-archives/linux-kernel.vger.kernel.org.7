Return-Path: <linux-kernel+bounces-747748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B44EDB13797
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B104A7A394E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A032522A8;
	Mon, 28 Jul 2025 09:35:00 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED121231858
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695300; cv=none; b=X2QBNfh+CnUz/92M6UWDh3MDw36/O/BCWsSCnyfhrLYo6EEmenzFCg7lA7v8WRA588RaTRSErfz9zKNmoTwFik5N9VH4eGoXzTLAsYLAufCYcSNJSkFDpgmTMYhbkXTMx2wFRmfyRpJqGzJVO3wU4p9BRAtzlDaKS2AYjJZP6is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695300; c=relaxed/simple;
	bh=nTv/krKUq1pAf23k38ECr9b6F14induhosI1RFjnmPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G8Q+4Q5cIFFzws0lwEEvR1qQoWeoZtorgPWz09Eie8J8+RjGmqExUy98hB6oVdDJeRWFXCd1O8zrNvRQ0oy3AGPqpxML1d3FfQ+SZ+4cZt4BLXC9yywgV68QvqxQWtDY5OE5LSt9apKvltDdJBzfSd3f9tLeMLagCcDCWclL72Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22144C4CEF4;
	Mon, 28 Jul 2025 09:34:57 +0000 (UTC)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for v6.17
Date: Mon, 28 Jul 2025 11:34:37 +0200
Message-ID: <20250728093437.223500-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi Linus,

The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.17-tag1

for you to fetch changes up to c8995932db2bad6fa093ac64dbaf7a3e8870eafa:

  m68k: mac: Improve clocksource driver commentary (2025-07-06 12:53:21 +0200)

----------------------------------------------------------------
m68k updates for v6.17

  - Ptdescs conversions,
  - Fix lost column on the graphical debug console,
  - Replace __ASSEMBLY__ with __ASSEMBLER__ in headers,
  - Miscellaneous fixes and improvements,
  - Defconfig updates.

Thanks for pulling!

----------------------------------------------------------------
Daniel Palmer (1):
      m68k: Enable dead code elimination

Finn Thain (5):
      m68k: Fix lost column on framebuffer debug console
      m68k: Avoid pointless recursion in debug console rendering
      m68k: Remove unused "cursor home" code from debug console
      m68k: Don't unregister boot console needlessly
      m68k: mac: Improve clocksource driver commentary

Geert Uytterhoeven (1):
      m68k: defconfig: Update defconfigs for v6.16-rc2

Thomas Huth (2):
      m68k: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
      m68k: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers

Vishal Moola (Oracle) (4):
      m68k: mm: Convert get_pointer_table() to use ptdescs
      m68k: mm: Convert free_pointer_table() to use ptdescs
      m68k: mm: Convert init_pointer_table() to use ptdescs
      m68k: mm: Convert pointer table macros to use ptdescs

 arch/m68k/Kconfig                         |  1 +
 arch/m68k/Kconfig.debug                   |  2 +-
 arch/m68k/configs/amiga_defconfig         |  9 +++-
 arch/m68k/configs/apollo_defconfig        |  9 +++-
 arch/m68k/configs/atari_defconfig         |  9 +++-
 arch/m68k/configs/bvme6000_defconfig      |  9 +++-
 arch/m68k/configs/hp300_defconfig         |  9 +++-
 arch/m68k/configs/mac_defconfig           |  9 +++-
 arch/m68k/configs/multi_defconfig         |  9 +++-
 arch/m68k/configs/mvme147_defconfig       |  9 +++-
 arch/m68k/configs/mvme16x_defconfig       |  9 +++-
 arch/m68k/configs/q40_defconfig           |  9 +++-
 arch/m68k/configs/sun3_defconfig          |  9 +++-
 arch/m68k/configs/sun3x_defconfig         |  9 +++-
 arch/m68k/include/asm/adb_iop.h           |  4 +-
 arch/m68k/include/asm/bootinfo.h          |  4 +-
 arch/m68k/include/asm/entry.h             |  4 +-
 arch/m68k/include/asm/kexec.h             |  4 +-
 arch/m68k/include/asm/mac_baboon.h        |  4 +-
 arch/m68k/include/asm/mac_iop.h           |  4 +-
 arch/m68k/include/asm/mac_oss.h           |  4 +-
 arch/m68k/include/asm/mac_psc.h           |  4 +-
 arch/m68k/include/asm/mac_via.h           |  4 +-
 arch/m68k/include/asm/math-emu.h          |  6 +--
 arch/m68k/include/asm/mcf_pgtable.h       |  4 +-
 arch/m68k/include/asm/mcfmmu.h            |  2 +-
 arch/m68k/include/asm/motorola_pgtable.h  |  4 +-
 arch/m68k/include/asm/nettel.h            |  4 +-
 arch/m68k/include/asm/openprom.h          |  4 +-
 arch/m68k/include/asm/page.h              |  4 +-
 arch/m68k/include/asm/page_mm.h           |  4 +-
 arch/m68k/include/asm/page_no.h           |  4 +-
 arch/m68k/include/asm/pgtable.h           |  2 +-
 arch/m68k/include/asm/pgtable_mm.h        |  8 +--
 arch/m68k/include/asm/ptrace.h            |  4 +-
 arch/m68k/include/asm/setup.h             | 10 ++--
 arch/m68k/include/asm/sun3_pgtable.h      |  8 +--
 arch/m68k/include/asm/sun3mmu.h           |  4 +-
 arch/m68k/include/asm/thread_info.h       |  6 +--
 arch/m68k/include/asm/traps.h             |  6 +--
 arch/m68k/include/uapi/asm/bootinfo-vme.h |  4 +-
 arch/m68k/include/uapi/asm/bootinfo.h     |  8 +--
 arch/m68k/include/uapi/asm/ptrace.h       |  4 +-
 arch/m68k/kernel/early_printk.c           | 42 ++++++----------
 arch/m68k/kernel/head.S                   | 81 ++++++++++++++++---------------
 arch/m68k/mac/via.c                       | 16 ++++++
 arch/m68k/math-emu/fp_emu.h               |  8 +--
 arch/m68k/mm/motorola.c                   | 56 ++++++++++-----------
 48 files changed, 270 insertions(+), 180 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

