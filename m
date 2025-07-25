Return-Path: <linux-kernel+bounces-746406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D6CB12665
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B918D1C80DF6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C612367B7;
	Fri, 25 Jul 2025 22:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="kSYbprUw"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6A51DE892
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 22:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753480875; cv=none; b=k3TCXvPA/47gKcInuKO7SATBO22rP/ivdmiMS5aYbhdJiKQlIlHRka1YnLD/70R9vVtHWz9HNifZHodbuKTicnrFc06GQy3BtFU/igPRZsEy4vQQbl6wYv6v3hZJrMo7S3AaOGDWNYoJTXSDHLD6Tts7j4MHKHyxjSgy0D0Xlac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753480875; c=relaxed/simple;
	bh=BOdXUOboicNWwXzZrO9q7pcPzDDUZsAhNofahfeQcp0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=om1P/GkK9k4uoVnwtVcoEZIY38K5fh3CUh2N/k1i0tXHJ0c9C9OqwaJ9gVmzQz6bxoAqTyRJofdma7FDn/URBcqjpE5dGJqZwYnxAiRqk5EVs6u8dqCnyyTHZSRDdexTf+nEvLbG6zVCMUNIxNinBmR/7UNOQuTNvkexTou0CuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=kSYbprUw; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1753480864;
	bh=BOdXUOboicNWwXzZrO9q7pcPzDDUZsAhNofahfeQcp0=;
	h=Date:From:To:Cc:Subject:From;
	b=kSYbprUwTe2XZxvOSmrs2nw/oYOQ9J8k5mEUpdvojtbUI92pycQZwdMGCwiWh1RcK
	 NgvhXxAocF0HZLnn2DC9s1mQ+B146QHKtulX3jx+keQjRAO3vm3VFmV7K1XfmN9Qft
	 1RNQ87a0HjVf5/eHlv//l9V4uHi//wT80xxfGlrU=
Date: Sat, 26 Jul 2025 00:01:04 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] nolibc changes for 6.17
Message-ID: <bfffee49-850a-447b-9c22-b08ad6f885f7@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

please find below the nolibc pull request for 6.17.
All changes have been in linux-next for at least two weeks.

----------------------------------------------------------------

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git/ tags/nolibc-20250724-for-6.17-1

for you to fetch changes up to b9e50363178a40c76bebaf2f00faa2b0b6baf8d1:

  selftests/nolibc: add x32 test configuration (2025-07-13 16:58:41 +0200)

----------------------------------------------------------------
nolibc changes for v6.17

Highlights:

* New supported architectures: SuperH, x32, MIPS n32/n64
* Adopt general kernel architectures names
* Integrate the nolibc selftests into the kselftests framework
* Various fixes and new syscall wrappers

Two non-nolibc changes:

* New arm64 selftest which depends on nolibc changes
* General tools/ cross-compilation bugfix for s390 clang

----------------------------------------------------------------
Benjamin Berg (1):
      selftests/nolibc: show failed run if test process crashes

Mark Brown (4):
      tools/nolibc: Replace ifdef with if defined() in sys.h
      tools/nolibc: Provide vfork()
      selftests/nolibc: Add coverage of vfork()
      kselftest/arm64: Add a test for vfork() with GCS

Thomas Weißschuh (23):
      selftests/nolibc: make stackprotector probing more robust
      selftests/nolibc: drop implicit defconfig executions
      selftests/nolibc: split out CFLAGS logic
      selftests/nolibc: rename Makefile
      selftests/nolibc: integrate with kselftests
      selftests/nolibc: avoid GCC 15 -Wunterminated-string-initialization
      tools/nolibc: hide headers_check command by default
      tools/nolibc: use arm64 name over aarch64
      tools/nolibc: MIPS: drop $gp setup
      tools/nolibc: MIPS: drop manual stack pointer alignment
      tools/nolibc: MIPS: drop noreorder option
      tools/nolibc: MIPS: add support for N64 and N32 ABIs
      selftests/nolibc: fix EXTRACONFIG variables ordering
      selftests/nolibc: use file driver for QEMU serial
      tools/nolibc: add support for SuperH
      tools/nolibc: add support for clock_nanosleep() and nanosleep()
      selftests/nolibc: create /dev/full when running as PID 1
      selftests/nolibc: correctly report errors from printf() and friends
      tools/nolibc: avoid false-positive -Wmaybe-uninitialized through waitpid()
      tools/build: Fix s390(x) cross-compilation with clang
      tools/nolibc: drop s390 clang target override
      tools/nolibc: define time_t in terms of __kernel_old_time_t
      selftests/nolibc: add x32 test configuration

Willy Tarreau (2):
      tools/nolibc: fix spelling of FD_SETBITMASK in FD_* macros
      tools/nolibc: merge i386 and x86_64 into a single x86 arch

 tools/include/nolibc/Makefile                      |  18 +-
 .../nolibc/{arch-aarch64.h => arch-arm64.h}        |  10 +-
 tools/include/nolibc/arch-i386.h                   | 178 ----------
 tools/include/nolibc/arch-mips.h                   | 117 +++++--
 tools/include/nolibc/arch-sh.h                     | 162 +++++++++
 tools/include/nolibc/arch-sparc.h                  |  16 +
 tools/include/nolibc/{arch-x86_64.h => arch-x86.h} | 180 +++++++++-
 tools/include/nolibc/arch.h                        |  10 +-
 tools/include/nolibc/std.h                         |   4 +-
 tools/include/nolibc/stdio.h                       |   4 +-
 tools/include/nolibc/sys.h                         |  59 +++-
 tools/include/nolibc/sys/wait.h                    |   2 +-
 tools/include/nolibc/time.h                        |  34 ++
 tools/include/nolibc/types.h                       |   4 +-
 tools/scripts/Makefile.include                     |   4 +-
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/arm64/gcs/basic-gcs.c      |  63 ++++
 tools/testing/selftests/nolibc/Makefile            | 343 +-----------------
 tools/testing/selftests/nolibc/Makefile.include    |  10 +
 tools/testing/selftests/nolibc/Makefile.nolibc     | 383 +++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c       |  53 ++-
 tools/testing/selftests/nolibc/run-tests.sh        |  14 +-
 22 files changed, 1074 insertions(+), 595 deletions(-)
 rename tools/include/nolibc/{arch-aarch64.h => arch-arm64.h} (97%)
 delete mode 100644 tools/include/nolibc/arch-i386.h
 create mode 100644 tools/include/nolibc/arch-sh.h
 rename tools/include/nolibc/{arch-x86_64.h => arch-x86.h} (53%)
 create mode 100644 tools/testing/selftests/nolibc/Makefile.include
 create mode 100644 tools/testing/selftests/nolibc/Makefile.nolibc

