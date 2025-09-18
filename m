Return-Path: <linux-kernel+bounces-822067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4708B82F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63A472A694A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A648727380C;
	Thu, 18 Sep 2025 05:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYjJAfAS"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A7D248883
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758172585; cv=none; b=klvTXOM3mj3Xdo058LMarpG7SQOQMlpb1mZ5q9wA6zpZVKNGyiS4OMuKmluB8ktiuAMFPTpS4A2s4rUv7oFn136mCHntHk5inz1lri/0NLj4fA3uvdEtc8i7C/ncMypI/M5G2uDdbUyCFW8tKebu0pgIM0rbRXPw3mPnMCzkXbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758172585; c=relaxed/simple;
	bh=aVvFJJ9WnGnyh5VM0S2zbVc7iBktm5ex8k1wM+2sdoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hNK5ab6995oxKKN7sf23dTNHw1uQ5jEJMlK6PLFCvDd3NqydpKqKr5jr+XhVSHbLxYbZka2s2QfMFUA0ZYr0FEGB6V065FHSDL/By8Vz6Hqwf3A79pmgW78PRzRUhseD+Zmw4qmGefSVifre176dpWPi3GSalthnuEyst7KC/4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYjJAfAS; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4c29d2ea05so1227396a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758172583; x=1758777383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5V8UEUER87fn48X10+kB+MMWv7ifqYEY+xUtS9BYOU=;
        b=jYjJAfASURad+C9N/jDnktNV7Z4PhHOI/l1wFtxrvISns1C6mII6FwI58y9kv5hW+0
         rEJPvo9se2n1QHtCiZhWSk50faynDHS6SuFS3ID0Nb8IoXWQ9V9svF8ZGWLcJGtblzdw
         nWP5VCBpCSvxZptaeHGTp9tXgXlMZnC7NcMDl5JiGGxMe3uvXKLTvRKaSx3tZvtySfBW
         zdbxq2ddCOAZqa8BWd7Y77QFVlbwid1XvItn1ifN1NwnomyzSbG4O4Oc+0X/eQxe2JTx
         KRkfatliXZKwjy4Lfd/jfwbUDuncwHUFyUPHAPed10J0oe0CquiKYFkTFcXu2+PhPvS/
         N3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172583; x=1758777383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5V8UEUER87fn48X10+kB+MMWv7ifqYEY+xUtS9BYOU=;
        b=Gq9R/uV6HMszIpHdlMq1HLdw+++BaympCv3czeu33wU9oPTxYWwzUQh1woy+FpEfHC
         1Uyin/hoAXJZy6rNxMLEuspBBxJBgL7gFDqEPMtXnuiGXadBW5FVEb8xiJnsK+Et/sbD
         CKr154O7k0qLBt7y/eOPlaLciTr1WMzg1lMNBB3wUSbKwyo9bm7f0VeNWEtIYItYByVv
         7gwdNtnOkzLaaqrfgDoQZ6jjzxUl8j+e4BYs8TW0+iO2BVHzyWYXTZYEm7GP9WB+JFy9
         ZaPt/LbKTG0BZIygIz0/AahhKsvg3VgvJxSgVz0SDQ0dSINyfa6hwQ8hCZAD8OreDYNd
         Fixw==
X-Forwarded-Encrypted: i=1; AJvYcCXGtmD3UwEuVbbdBJmYC6gHqPO7KxyQNycogAtvnXxeRe3CNufvoTAJDHXuKco+qElg8nUo6WbWx1VvmjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxBAVCBqId2xk1DAS8CsT9VO31iF8Z6gtTkwgVEOPdpxygyHZc
	jm0xIlbz52OMQujmQsvlmV5xzFCIvEBsFL+EgR8v1xXDuy0pPnKnhe6c
X-Gm-Gg: ASbGncs3oXEqHhFPUaA2TQLkPBruJTNBvjhnCHgNVXp/gb6G8QiH59A8Rr+4HCWqZPj
	ALXjPzqmqV/zHH2aajOMMo+uM0xV21I+CMzj6KKjkuV12TrPuSM3N/W/pHukEt0cAb5t8A6jnP6
	CyN99K4TdC5UBJspUY32Sb+/bWffUtpbjw6/EkrZhdUu+uZxF2v5XUxVY4YGnnbxjQQNV2gRb97
	cdt8A3OIGqSCRi8HX/CTSy373ViK/ZRZ1MrBQl1lQIJYw3hq8iaS7xhVFY6hIaBb+SNyjCsalTZ
	lzmgKMWwh8FtlVeIrJw5xvuta0Meu24joSzk/IGRjX61zunnUAl9MQxR1g0zOp/LozTrfxfi6mt
	J1jicfavPwobNHVG8nEWKH6WKHFmSWuxgVUP01fw33PYDiJL/kShQIamnR85agjXrBL0NnIy05c
	RlZbN41LMhTuPP85U9gp2I5w==
X-Google-Smtp-Source: AGHT+IExqSlvopxdnNEELLzMkxZ5Iirbo+6+7otHyx0171ZVf2y29k669aNGN8l6ZT7IPTg8xoTibg==
X-Received: by 2002:a17:903:3d10:b0:24b:1585:6350 with SMTP id d9443c01a7336-2697c82d7e6mr28125565ad.11.1758172583013;
        Wed, 17 Sep 2025 22:16:23 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698019821dsm12852045ad.64.2025.09.17.22.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:16:22 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 525141061EE0; Thu, 18 Sep 2025 14:16:15 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 00/14] nommu UML
Date: Thu, 18 Sep 2025 14:15:53 +0900
Message-ID: <cover.1758171893.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset is another spin of nommu mode addition to UML.  It would
be nice to hear about your opinions on that.

There are still several limitations/issues which we already found;
here is the list of those issues.

- memory mapped by loadable modules are not distinguished from
  userspace memory.

-- Hajime

v11:
- clean up userspace return routine and integrate to userspace() ([04/13])
- fix direction flag issue on using nolibc memcpy ([04/13])
- fix a crash issue when using usermode helper ([06/13])
- test with out-of-tree kunit-uapi patches (which uses umh)
 - https://lore.kernel.org/all/20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de/
 - https://lore.kernel.org/all/20250626195714.2123694-3-benjamin@sipsolutions.net/

v10:
- fix wrong comment on gs register handling ([09/13])
- remove unnecessary code of early syscall implementation ([04/13])
- https://lore.kernel.org/all/cover.1750594487.git.thehajime@gmail.com/

v9:
- rebase with the latest uml/next branch
- add performance numbers of new SECCOMP mode, and update results ([12/13])
- add a workaround for upstream change on MMU depedency to PCI drivers ([10/13])
- https://lore.kernel.org/all/cover.1750294482.git.thehajime@gmail.com/

v8:
- rebase with the latest uml/next branch
- clean up segv_handler to align with the latest uml ([9/12])
- https://lore.kernel.org/all/cover.1745980082.git.thehajime@gmail.com/

v7:
- properly handle FP register upon signal delivery [10/13]
- update benchmark result with new FP register handling [12/13]
- fix arch_has_single_step() for !MMU case [07/13]
- revert stack alignment as it is in uml/fixes tree [10/13]
- https://lore.kernel.org/all/cover.1737348399.git.thehajime@gmail.com/

v6:
- rebase to the latest uml/next tree
- more clean up on mmu/nommu for signal handling [10/13]
- rename functions of mcontext routines [06,10/13]
- added Acked-by tag for binfmt_elf_fdpic [02/13]
- https://lore.kernel.org/linux-um/cover.1736853925.git.thehajime@gmail.com/

v5:
- clean up stack manipulation code [05,06,07,10/13]
- https://lore.kernel.org/linux-um/cover.1733998168.git.thehajime@gmail.com/

v4:
- add arch/um/nommu, arch/x86/um/nommu to contain !MMU specific codes
- remove zpoline patch
- drop binfmt_elf_fdpic patch
- reduce ifndef CONFIG_MMU if possible
- split to elf header cleanup patch [01/13]
- fix kernel test robot warnings [06/13]
- fix coding styles [07/13]
- move task_top_of_stack definition [05/13]
- https://lore.kernel.org/linux-um/cover.1733652929.git.thehajime@gmail.com/

v3:
- https://lore.kernel.org/linux-um/cover.1733199769.git.thehajime@gmail.com/
- add seccomp-based syscall hook in addition to zpoline [06/13]
- remove RFC, add a line to MAINTAINERS file
- fix kernel test robot warnings [02/13,08/13,10/13]
- add base-commit tag to cover letter
- pull the latest uml/next
- clean up SIGSEGV handling [10/13]
- detect fsgsbase availability with elf aux vector [08/13]
- simplify vdso code with macros [09/13]

RFC v2:
- https://lore.kernel.org/linux-um/cover.1731290567.git.thehajime@gmail.com/
- base branch is now uml/linux.git instead of torvalds/linux.git.
- reorganize the patch series to clean up
- fixed various coding styles issues
- clean up exec code path [07/13]
- fixed the crash/SIGSEGV case on userspace programs [10/13]
- add seccomp filter to limit syscall caller address [06/13]
- detect fsgsbase availability with sigsetjmp/siglongjmp [08/13]
- removes unrelated changes
- removes unneeded ifndef CONFIG_MMU
- convert UML_CONFIG_MMU to CONFIG_MMU as using uml/linux.git
- proposed a patch of maple-tree issue (resolving a limitation in RFC v1)
  https://lore.kernel.org/linux-mm/20241108222834.3625217-1-thehajime@gmail.com/

RFC:
- https://lore.kernel.org/linux-um/cover.1729770373.git.thehajime@gmail.com/

Hajime Tazaki (14):
  x86/um: nommu: elf loader for fdpic
  um: decouple MMU specific code from the common part
  um: nommu: memory handling
  x86/um: nommu: syscall handling
  um: nommu: seccomp syscalls hook
  fixup seccomp
  x86/um: nommu: process/thread handling
  um: nommu: configure fs register on host syscall invocation
  x86/um/vdso: nommu: vdso memory update
  x86/um: nommu: signal handling
  um: nommu: a work around for MMU dependency to PCI driver
  um: change machine name for uname output
  um: nommu: add documentation of nommu UML
  um: nommu: plug nommu code into build system

 Documentation/virt/uml/nommu-uml.rst   | 180 ++++++++++++++++++++++
 MAINTAINERS                            |   1 +
 arch/um/Kconfig                        |  14 +-
 arch/um/Makefile                       |  10 ++
 arch/um/configs/x86_64_nommu_defconfig |  54 +++++++
 arch/um/include/asm/dma.h              |  13 ++
 arch/um/include/asm/futex.h            |   4 +
 arch/um/include/asm/mmu.h              |   8 +
 arch/um/include/asm/mmu_context.h      |   2 +
 arch/um/include/asm/ptrace-generic.h   |   8 +-
 arch/um/include/asm/uaccess.h          |   7 +-
 arch/um/include/shared/kern_util.h     |   6 +
 arch/um/include/shared/os.h            |  16 ++
 arch/um/kernel/Makefile                |   5 +-
 arch/um/kernel/mem-pgtable.c           |  55 +++++++
 arch/um/kernel/mem.c                   |  38 +----
 arch/um/kernel/process.c               |  25 +++
 arch/um/kernel/skas/process.c          |  25 ---
 arch/um/kernel/um_arch.c               |   3 +
 arch/um/nommu/Makefile                 |   3 +
 arch/um/nommu/os-Linux/Makefile        |   7 +
 arch/um/nommu/os-Linux/seccomp.c       |  87 +++++++++++
 arch/um/nommu/os-Linux/signal.c        |  24 +++
 arch/um/nommu/trap.c                   | 201 +++++++++++++++++++++++++
 arch/um/os-Linux/Makefile              |   3 +-
 arch/um/os-Linux/mem.c                 |   4 +
 arch/um/os-Linux/process.c             | 138 ++++++++++++++++-
 arch/um/os-Linux/signal.c              |  11 +-
 arch/um/os-Linux/skas/process.c        | 126 ----------------
 arch/um/os-Linux/start_up.c            |  25 ++-
 arch/um/os-Linux/util.c                |   3 +-
 arch/x86/um/Makefile                   |   7 +-
 arch/x86/um/asm/elf.h                  |   8 +-
 arch/x86/um/asm/syscall.h              |   6 +
 arch/x86/um/nommu/Makefile             |   8 +
 arch/x86/um/nommu/do_syscall_64.c      |  75 +++++++++
 arch/x86/um/nommu/entry_64.S           | 114 ++++++++++++++
 arch/x86/um/nommu/os-Linux/Makefile    |   6 +
 arch/x86/um/nommu/os-Linux/mcontext.c  |  26 ++++
 arch/x86/um/nommu/syscalls.h           |  18 +++
 arch/x86/um/nommu/syscalls_64.c        | 121 +++++++++++++++
 arch/x86/um/shared/sysdep/mcontext.h   |   5 +
 arch/x86/um/shared/sysdep/ptrace.h     |   2 +-
 arch/x86/um/vdso/vma.c                 |  17 ++-
 fs/Kconfig.binfmt                      |   2 +-
 45 files changed, 1312 insertions(+), 209 deletions(-)
 create mode 100644 Documentation/virt/uml/nommu-uml.rst
 create mode 100644 arch/um/configs/x86_64_nommu_defconfig
 create mode 100644 arch/um/kernel/mem-pgtable.c
 create mode 100644 arch/um/nommu/Makefile
 create mode 100644 arch/um/nommu/os-Linux/Makefile
 create mode 100644 arch/um/nommu/os-Linux/seccomp.c
 create mode 100644 arch/um/nommu/os-Linux/signal.c
 create mode 100644 arch/um/nommu/trap.c
 create mode 100644 arch/x86/um/nommu/Makefile
 create mode 100644 arch/x86/um/nommu/do_syscall_64.c
 create mode 100644 arch/x86/um/nommu/entry_64.S
 create mode 100644 arch/x86/um/nommu/os-Linux/Makefile
 create mode 100644 arch/x86/um/nommu/os-Linux/mcontext.c
 create mode 100644 arch/x86/um/nommu/syscalls.h
 create mode 100644 arch/x86/um/nommu/syscalls_64.c


base-commit: e66ae377fe219c98d3d5b8a0d35da4413a5390ca
-- 
2.43.0


