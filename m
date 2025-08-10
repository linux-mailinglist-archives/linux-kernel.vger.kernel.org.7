Return-Path: <linux-kernel+bounces-761324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D1FB1F87C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 07:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9115B4E1047
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 05:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB32A1E0DD8;
	Sun, 10 Aug 2025 05:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TB1SUbnL"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06A92E36FF
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 05:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754805125; cv=none; b=leHyINbINddzyosyR3qYZ5NX5RIXBLnLKOqXFJqnwvJA6uHgWnUJZBMopHDqOL8j2gbpJefFMJjy62ONjNfbbSdi1l/tVby+rMvJO/nK0N6KLPXauLD7x14Eng+doR+S0kLpgQ1htd6aiKRc7iX5oZY4tnnsX3IscFCy/OnoXXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754805125; c=relaxed/simple;
	bh=bU2xF1mqjb1NX1WqMrWvxs9qwGO73l1E1ncUCgXDKUc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j642USOVm9NFK6WCYWKRk2gg40vql+OOHbo2bCqSAQVp9NR6RMLFD37gVNWEykc1RqkgSctw5oAWTuotmyGxOxJKBbUJv0/dcCXrtcmvkC5YBp7MLLMwWoAsqnDAKaQr2QO/qQmldscliCi2N4irnNcbgdKLY4hoaoIWS9J/VcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TB1SUbnL; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754805118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OY9LQOI81twPnsUMH9vJVddG4XSsD5uF/LCYVEwzvNk=;
	b=TB1SUbnL/IDYIAB5IEH0QhIw/5VLJmHFbATKiv8XQCWef2T5fdHif5CAb1UfQR1PiP3kil
	0C2/sDx0Gy+dPXU2kF/J+zpmTA5KHL4lkul9sy9MuKt1fyR31XF2WX+5dJ1naxR7fONTdj
	oo/pptdVhlVMH9PUBsXeV+yZ1BOyd7Q=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	benjamin@sipsolutions.net,
	arnd@arndb.de,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH v2 00/10] um: Add SMP support
Date: Sun, 10 Aug 2025 13:51:26 +0800
Message-Id: <20250810055136.897712-1-tiwei.bie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tiwei Bie <tiwei.btw@antgroup.com>

This series adds initial symmetric multi-processing (SMP) support
to UML. With this support, it is now possible for users to tell
UML to start multiple virtual CPUs, each represented as a separate
host thread.

In UML, kthreads and normal threads (when running in kernel mode)
can be scheduled and executed simultaneously on different virtual
CPUs. However, the userspace code of normal threads currently still
runs within their respective single-threaded stubs.

So SMP within the kernel is supported. SMP across different processes
in userspace is also supported. Currently, the limitation is that
multi-threading within the same process does not yet support true SMP
in userspace, because it would require converting the stub into a
multi-threaded implementation, which is not covered in this series.

Extending the stub to support true SMP in userspace within the same
process could be done later and requires careful design. It may be
better to handle it in a follow-up series.

Here are some steps to try out SMP support in UML:

1. Build UML with CONFIG_SMP=y and, for example, CONFIG_NR_CPUS=8.

2. Launch a UML instance with, for example, 8 virtual CPUs.

 $ ./linux mem=16G ncpus=8 seccomp=on init=/bin/sh ubd0=$your_rootfs_image

v2:
- Implement IPI based on RT signal; (Johannes)
- Fix raw_smp_processor_id() for non-SMP case; (Johannes)
- Add sparse check for turnstile; (Johannes)
- Implement spinlock in $SUBARCH;
- Fix potential race on stub's siginfo;
- Rewrite AP bring-up (e.g. switch to generic idle thread);
- Misc fixes and cleanups;

v1: https://lore.kernel.org/linux-um/20250727062937.1369050-1-tiwei.bie@linux.dev/

RFC: https://lore.kernel.org/linux-um/20250713172536.404809-1-tiwei.bie@linux.dev/

Tiwei Bie (10):
  um: Stop tracking virtual CPUs via mm_cpumask()
  um: Remove unused cpu_data and current_cpu_data macros
  um: vdso: Implement __vdso_getcpu() via syscall
  um: Turn signals_* into thread-local variables
  um: Determine sleep based on need_resched()
  um: Define timers on a per-CPU basis
  um: Remove unused ipi_pipe field from cpuinfo_um
  um: Add initial SMP support
  asm-generic: percpu: Add assembly guard
  um: Enable SMP support on x86

 .../core/generic-idle-thread/arch-support.txt |   2 +-
 arch/um/Kconfig                               |  46 +++-
 arch/um/include/asm/current.h                 |   5 +-
 arch/um/include/asm/hardirq.h                 |  24 +-
 arch/um/include/asm/irqflags.h                |   4 +-
 arch/um/include/asm/mmu.h                     |  10 +
 arch/um/include/asm/mmu_context.h             |  11 -
 arch/um/include/asm/pgtable.h                 |   2 +
 arch/um/include/asm/processor-generic.h       |   3 -
 arch/um/include/asm/smp.h                     |  15 +-
 arch/um/include/linux/smp-internal.h          |  17 ++
 arch/um/include/linux/time-internal.h         |   3 +
 arch/um/include/shared/kern_util.h            |   2 +
 arch/um/include/shared/longjmp.h              |   3 +-
 arch/um/include/shared/os.h                   |  23 +-
 arch/um/include/shared/skas/mm_id.h           |   5 +
 arch/um/include/shared/smp.h                  |  20 ++
 arch/um/kernel/Makefile                       |   1 +
 arch/um/kernel/irq.c                          |  27 +-
 arch/um/kernel/ksyms.c                        |   2 +-
 arch/um/kernel/mem.c                          |   2 +
 arch/um/kernel/process.c                      |  19 +-
 arch/um/kernel/skas/mmu.c                     |  32 ++-
 arch/um/kernel/skas/process.c                 |   7 +-
 arch/um/kernel/smp.c                          | 239 ++++++++++++++++++
 arch/um/kernel/time.c                         |  58 +++--
 arch/um/kernel/tlb.c                          |   5 +-
 arch/um/kernel/trap.c                         |   2 +-
 arch/um/kernel/um_arch.c                      |  28 +-
 arch/um/os-Linux/Makefile                     |   4 +-
 arch/um/os-Linux/internal.h                   |   7 +
 arch/um/os-Linux/main.c                       |   5 +-
 arch/um/os-Linux/process.c                    |  20 ++
 arch/um/os-Linux/signal.c                     |  40 ++-
 arch/um/os-Linux/skas/process.c               |  22 +-
 arch/um/os-Linux/smp.c                        | 142 +++++++++++
 arch/um/os-Linux/start_up.c                   |   4 +
 arch/um/os-Linux/time.c                       |  46 ++--
 arch/x86/um/Kconfig                           |   3 +
 arch/x86/um/asm/spinlock.h                    |   8 +
 arch/x86/um/vdso/um_vdso.c                    |  18 +-
 include/asm-generic/percpu.h                  |   3 +
 42 files changed, 827 insertions(+), 112 deletions(-)
 create mode 100644 arch/um/include/linux/smp-internal.h
 create mode 100644 arch/um/include/shared/smp.h
 create mode 100644 arch/um/kernel/smp.c
 create mode 100644 arch/um/os-Linux/smp.c
 create mode 100644 arch/x86/um/asm/spinlock.h

-- 
2.34.1


