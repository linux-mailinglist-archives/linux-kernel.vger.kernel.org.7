Return-Path: <linux-kernel+bounces-815726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5249AB56A5B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDEDE189D76B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094CF2DCBF4;
	Sun, 14 Sep 2025 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YF42nSy7"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD252DCBEC
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757865466; cv=none; b=l7R8wBso22rJ3/4t3p4nLCLcXFmhVYK9QuayhMEHsEW/fU51PZrGB7/iQ9jE3zIJkxTsO6DeCWKuEH+e+05VQBS6aF5l4h6xKRXeWcE0Bg3yCYYCc/XGGRDhXfQjKljr5JcnfH7F4iB1YsKYfJ72VTCJvrvKlyY+mwhvc0hruOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757865466; c=relaxed/simple;
	bh=ovATHq/uskUjDJ27oWtebFVNFc+1HJG88zQ5ljax67s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gyx3OXNRKABi83yQ+BvPTmr+4sOM+xs7QFVxQ/KMeGAR98Tkfbvi3h4DcXQnHyuQ++rbCXPg8ApH34W3emJEswj5bwtqsr1OdbPnmdbf56gdd//WqVZKQegjIKRzbrKq9nvg6MYuTpriP2zRY6ToUZrJsv6AK6TGJX+sbBe+osg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YF42nSy7; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757865460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oZx0OuUKUc0dBSWHMmkZJf76LNudilRN4lNfCv6pOS0=;
	b=YF42nSy7QSo4QeKLpOwwHEiN5aSH6qGid/Xzc/YNKaTVISQYWz4E3wQ3RQtYjYf9ZxpPJQ
	mBkk1vwHeDfOvUeAd780czfDVRlFBYFqAhilna8K6GnFSBQnD7tTCjBH+A6r80yhuwINCP
	my+7HjOA+gVDnGZF8IIY8FoWJWJcgvA=
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
Subject: [PATCH v3 0/7] um: Add SMP support
Date: Sun, 14 Sep 2025 23:56:51 +0800
Message-Id: <20250914155658.1028790-1-tiwei.bie@linux.dev>
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

v3:
- Fix need_resched based idle sleep; (Johannes)
- Remove getcpu support from the vdso on UML/x86; (Johannes)
- Describe 'cpu' parameter of os_timer_disable; (lkp@intel.com)
- Misc fixes and cleanups;

v2 (https://lore.kernel.org/all/20250810055136.897712-1-tiwei.bie@linux.dev/):
- Implement IPI based on RT signal; (Johannes)
- Fix raw_smp_processor_id() for non-SMP case; (Johannes)
- Add sparse check for turnstile; (Johannes)
- Implement spinlock in $SUBARCH;
- Fix potential race on stub's siginfo;
- Rewrite AP bring-up (e.g. switch to generic idle thread);
- Misc fixes and cleanups;

v1: https://lore.kernel.org/all/20250727062937.1369050-1-tiwei.bie@linux.dev/

RFC: https://lore.kernel.org/all/20250713172536.404809-1-tiwei.bie@linux.dev/

Tiwei Bie (7):
  um: Turn signals_* into thread-local variables
  um: Determine sleep based on need_resched()
  um: Define timers on a per-CPU basis
  um: Add initial SMP support
  um: vdso: Remove getcpu support on x86
  asm-generic: percpu: Add assembly guard
  um: Enable SMP support on x86

 .../core/generic-idle-thread/arch-support.txt |   2 +-
 arch/um/Kconfig                               |  46 +++-
 arch/um/include/asm/current.h                 |   5 +-
 arch/um/include/asm/hardirq.h                 |  24 +-
 arch/um/include/asm/irqflags.h                |   4 +-
 arch/um/include/asm/mmu.h                     |  10 +
 arch/um/include/asm/pgtable.h                 |   2 +
 arch/um/include/asm/smp.h                     |  15 +-
 arch/um/include/linux/smp-internal.h          |  17 ++
 arch/um/include/linux/time-internal.h         |   3 +
 arch/um/include/shared/kern_util.h            |   2 +
 arch/um/include/shared/longjmp.h              |   3 +-
 arch/um/include/shared/os.h                   |  24 +-
 arch/um/include/shared/skas/mm_id.h           |   5 +
 arch/um/include/shared/smp.h                  |  20 ++
 arch/um/kernel/Makefile                       |   1 +
 arch/um/kernel/irq.c                          |  27 +-
 arch/um/kernel/ksyms.c                        |   2 +-
 arch/um/kernel/mem.c                          |   2 +
 arch/um/kernel/process.c                      |  17 +-
 arch/um/kernel/skas/mmu.c                     |  33 ++-
 arch/um/kernel/skas/process.c                 |   7 +-
 arch/um/kernel/smp.c                          | 241 ++++++++++++++++++
 arch/um/kernel/time.c                         |  58 +++--
 arch/um/kernel/tlb.c                          |   5 +-
 arch/um/kernel/trap.c                         |   2 +-
 arch/um/kernel/um_arch.c                      |  25 +-
 arch/um/os-Linux/Makefile                     |   4 +-
 arch/um/os-Linux/internal.h                   |  13 +
 arch/um/os-Linux/main.c                       |   5 +-
 arch/um/os-Linux/process.c                    |  20 ++
 arch/um/os-Linux/signal.c                     |  46 +++-
 arch/um/os-Linux/skas/process.c               |  22 +-
 arch/um/os-Linux/smp.c                        | 148 +++++++++++
 arch/um/os-Linux/start_up.c                   |   4 +
 arch/um/os-Linux/time.c                       |  78 ++++--
 arch/x86/um/Kconfig                           |   3 +
 arch/x86/um/asm/spinlock.h                    |   8 +
 arch/x86/um/vdso/um_vdso.c                    |  20 --
 arch/x86/um/vdso/vdso.lds.S                   |   2 -
 include/asm-generic/percpu.h                  |   3 +
 41 files changed, 870 insertions(+), 108 deletions(-)
 create mode 100644 arch/um/include/linux/smp-internal.h
 create mode 100644 arch/um/include/shared/smp.h
 create mode 100644 arch/um/kernel/smp.c
 create mode 100644 arch/um/os-Linux/smp.c
 create mode 100644 arch/x86/um/asm/spinlock.h


base-commit: e66ae377fe219c98d3d5b8a0d35da4413a5390ca
-- 
2.34.1


