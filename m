Return-Path: <linux-kernel+bounces-749242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A792B14BE1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85139188EE4F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF50C2882AB;
	Tue, 29 Jul 2025 10:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="E8+j30Pj"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CB018C928
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753783508; cv=none; b=NNldmwVMK8ubFWZVOwtzDhExBiMT8o+WvKm6aseZn64XzmokxW7EA0qLo60WV9eyBNX1mLvaDEvgwGGRM9vLt5RdH0WTJnng4HvcQ+q6fWa4wXpV/gN3flCExcTteiR9cuJ7AYy8PYBg+85VSv2SvT1BNywbSuvkjZgLBuV1G90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753783508; c=relaxed/simple;
	bh=sNc5UgbaCQY4kyCdLAh94PLZHXNQcWqA/zpsT4dVWKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=reYnucEKyyJq9jrCH2CsjMeqIP6FtIXOYNb8zlJ5/S0qzrcK/lhwuN6tl0sO4ml1Na2j4hWkfxR0lORVjcDKf581gDfx/mSoG1Phtvpq9/eMQzpX052Jqn+MeNxwZ7cggO04VeL8MOvUHgitUU3l+iL69y2VH1+MYTbW6XGNeig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=E8+j30Pj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=egSGjMlFbH3dU8UYE7+I38neCytKIOjPn2LRtM5SThY=; t=1753783506; x=1754993106; 
	b=E8+j30PjlzZs5lE2gVou5BCmb4FoQyH7qejqnJONdxwVqV3YrIgrPCmashDn+QZFFC/xrkMYKBJ
	GPPSqNZI1QkIb/XDv3t5U09cfNwR6fMpvYgAnig9HKp0cNStT2/DF92ZT64lxOqQx8qNotRWwWbHP
	Jvwaaix3FH5fsQq9nePzlXr+R3wpBAKU6Pbrg1QGraL+P4gthmj7YLmyJTik4bCqJONNYWoA3oWQL
	swhMy8kTP4ftd4V4lGm+9jIOqPoKm9GzpdHLw+elGFiVfFFGvTI2rp7KJPV4eOInwwf3AT1FzfhgL
	kV182uTz2kt6iwb/tOCGP2ggwhBuRTZWdnaw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ughCh-0000000ENqf-0sAD;
	Tue, 29 Jul 2025 12:05:03 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [GIT PULL] uml 6.17-rc1
Date: Tue, 29 Jul 2025 12:02:03 +0200
Message-ID: <20250729100457.14550-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned

Hi Linus,

There's really not much for UML for 6.17-rc1, mostly
cleanups and two small new features as noted in the
tag message below.

We're still discussing how best to do NOMMU and SMP
(currently have a partial patchset, only kernel-space
is really doing SMP) but neither is ready yet.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af:

  Linux 6.16-rc4 (2025-06-29 13:09:04 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linux-6.17-rc1

for you to fetch changes up to fc9ed2f6589dc2c11f05883e5c323be5f39fd241:

  um: Replace __ASSEMBLY__ with __ASSEMBLER__ in the usermode headers (2025-07-22 17:12:45 +0200)

----------------------------------------------------------------
Mostly cleanups, except:
 - dynamic addition of vfio passthrough devices
 - implementation of HAVE_SYSCALL_TRACEPOINTS

----------------------------------------------------------------
Johannes Berg (1):
      um: simplify syscall header files

Nam Cao (1):
      um: virt-pci: Switch to msi_create_parent_irq_domain()

Thomas Huth (1):
      um: Replace __ASSEMBLY__ with __ASSEMBLER__ in the usermode headers

Thomas Weißschuh (3):
      um/x86: Add system call table to header file
      um/ptrace: Implement HAVE_SYSCALL_TRACEPOINTS
      um: Re-evaluate thread flags repeatedly

Tiwei Bie (9):
      um: virtio_pcidev: Rename UM_PCI_STAT_WAITING
      um: Make unscheduled_userspace_iterations static
      um: Make mm_list and mm_list_lock static
      um: Avoid redefining ARCH_HAS_CACHE_LINE_SIZE
      um: rtc: Avoid shadowing err in uml_rtc_start()
      um: vfio: Support adding devices via mconsole
      um: Use err consistently in userspace()
      um: Remove the pid parameter of handle_trap()
      um: Stop tracking stub's PID via userspace_pid[]

 arch/um/Kconfig                         |  5 ++-
 arch/um/drivers/Kconfig                 |  1 +
 arch/um/drivers/rtc_user.c              |  2 +-
 arch/um/drivers/vfio_kern.c             | 62 ++++++++++++++++++++++++++++++---
 arch/um/drivers/virt-pci.c              | 43 +++++++++++------------
 arch/um/drivers/virtio_pcidev.c         |  8 ++---
 arch/um/include/asm/cpufeature.h        |  4 +--
 arch/um/include/asm/current.h           |  4 +--
 arch/um/include/asm/mmu_context.h       |  9 +----
 arch/um/include/asm/page.h              |  4 +--
 arch/um/include/asm/ptrace-generic.h    |  2 +-
 arch/um/include/asm/thread_info.h       |  8 ++++-
 arch/um/include/shared/as-layout.h      |  2 +-
 arch/um/include/shared/skas/mm_id.h     |  2 --
 arch/um/include/shared/skas/skas.h      |  1 -
 arch/um/kernel/exec.c                   |  2 --
 arch/um/kernel/process.c                | 18 ++++++----
 arch/um/kernel/ptrace.c                 |  9 +++++
 arch/um/kernel/skas/mmu.c               |  4 +--
 arch/um/kernel/skas/process.c           |  2 --
 arch/um/kernel/skas/syscall.c           | 11 ++++--
 arch/um/os-Linux/skas/process.c         | 35 ++++++++-----------
 arch/x86/um/asm/syscall.h               |  2 ++
 arch/x86/um/shared/sysdep/ptrace.h      | 12 -------
 arch/x86/um/shared/sysdep/syscalls.h    |  6 ----
 arch/x86/um/shared/sysdep/syscalls_32.h | 14 --------
 arch/x86/um/shared/sysdep/syscalls_64.h | 28 ---------------
 arch/x86/um/tls_32.c                    |  2 +-
 28 files changed, 151 insertions(+), 151 deletions(-)
 delete mode 100644 arch/x86/um/shared/sysdep/syscalls.h
 delete mode 100644 arch/x86/um/shared/sysdep/syscalls_32.h
 delete mode 100644 arch/x86/um/shared/sysdep/syscalls_64.h

