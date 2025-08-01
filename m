Return-Path: <linux-kernel+bounces-753732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29005B18712
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 20:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A99586207
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 18:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A980F28CF5E;
	Fri,  1 Aug 2025 18:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZttj5bq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102F728FFCB;
	Fri,  1 Aug 2025 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754071232; cv=none; b=aSIVS03kRLpAONW0CPuybcspeRPwA/6DBYKhtPPWkuZaEB7o1dVzq2LqO5eYz9TXtkVDNJ1BawIOHvFJzBmAZLST0IkLRe24BNtrP5ZQCk3ADhpggEjzC53RqyDm7SNQiuxoAWPXLVt+2r8MT+UDC5DHFNtVhpyhQi1ItMek3kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754071232; c=relaxed/simple;
	bh=khY5pqjLeMJ3YMLgf5VI/ElArN4jLegPUyQbJdoSu6s=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JZ6tsdWXzBvyrhzz77/9w5yaUqSxoPT5iCx8hlFxJ1bphiQqCriUq3eEoqFgyX1+MsjfqMQ9yxhvJYB20n0P+3w+G+E4uFfhJE9s4AC+8izs0QXctVFvzxrCIl1pVfMXymRYBl5NdUwczwp67V2j1HO4OFm6uwng0sTHChY3FuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZttj5bq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477F8C4CEF6;
	Fri,  1 Aug 2025 18:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754071231;
	bh=khY5pqjLeMJ3YMLgf5VI/ElArN4jLegPUyQbJdoSu6s=;
	h=Date:From:To:Subject:From;
	b=qZttj5bqmnc9n34wln5ZbJXccM1Ve53OYExr9k8F+Ac0M6/74HolvYslSZ+g1lyMB
	 w1MumyeWguhmDcRzN+qMUm/pio1txj0sCSCtiUqeeRj0lkcDwyWeU3+3UlN8nToD4G
	 j5wphf3Bx6aUNakBa1EWwdRgp5lsHtpyGl0NvmrpBUuXX3bGGMBTtLPAE07etfyzaH
	 vuLHX3ca85hOV/mhq96w+qSvHbx1P6V1d6nA+xqEkjaNZph1d/stFguukU0KkUghM6
	 Tjnfqg7W+czNszHn3jSMxE12T1g7xGHZ83sSmb1TfevBnu9aM5QcwidZxwq1lG4vFV
	 GMVwj7Vgm0HrQ==
Date: Fri, 1 Aug 2025 20:00:27 +0200
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
	John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes and updates for v6.17-rc1
Message-ID: <aI0Aux1I1xTWtp2r@p100>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 89be9a83ccf1f88522317ce02f854f30d6115c41:

  Linux 6.16-rc7 (2025-07-20 15:18:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.17-rc1

for you to fetch changes up to 89f686a0fb6e473a876a9a60a13aec67a62b9a7e:

  parisc: Revise __get_user() to probe user read access (2025-07-25 22:45:24 +0200)

----------------------------------------------------------------
parisc architecture fixes for kernel v6.17-rc1:

The parisc kernel wrongly allows reading from read-protected userspace
memory without faulting, e.g. when userspace uses mprotect() to
read-protect a memory area and then uses a pointer to this memory in a
write(2, addr, 1) syscall.  To fix this issue, Dave Anglin developed a
set of patches which use the proberi assembler instruction to
additionally check read access permissions at runtime.

Randy Dunlap contributed two patches to fix a minor typo and to explain
why a 32-bit compiler is needed although a 64-bit kernel is built.

----------------------------------------------------------------
John David Anglin (8):
      parisc: Update comments in make_insert_tlb
      parisc: Check region is readable by user in raw_copy_from_user()
      parisc: Rename pte_needs_flush() to pte_needs_cache_flush() in cache.c
      parisc: Define and use set_pte_at()
      parisc: Try to fixup kernel exception in bad_area_nosemaphore path of do_page_fault()
      parisc: Drop WARN_ON_ONCE() from flush_cache_vmap
      parisc: Revise gateway LWS calls to probe user read access
      parisc: Revise __get_user() to probe user read access

Randy Dunlap (2):
      parisc: Makefile: fix a typo in palo.conf
      parisc: Makefile: explain that 64BIT requires both 32-bit and 64-bit compilers

 arch/parisc/Makefile                    |  6 ++++--
 arch/parisc/include/asm/pgtable.h       |  7 ++++---
 arch/parisc/include/asm/special_insns.h | 28 ++++++++++++++++++++++++++++
 arch/parisc/include/asm/uaccess.h       | 21 ++++++++++++++++++---
 arch/parisc/kernel/cache.c              |  6 +++---
 arch/parisc/kernel/entry.S              | 17 ++++++++++++-----
 arch/parisc/kernel/syscall.S            | 30 +++++++++++++++++++++---------
 arch/parisc/lib/memcpy.c                | 19 ++++++++++++++++++-
 arch/parisc/mm/fault.c                  |  4 ++++
 9 files changed, 112 insertions(+), 26 deletions(-)

