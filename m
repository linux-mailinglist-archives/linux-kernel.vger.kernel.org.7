Return-Path: <linux-kernel+bounces-822230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F7FB835C8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33284A5455
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE542ECD13;
	Thu, 18 Sep 2025 07:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfNyndSK"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4D22E7186
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181161; cv=none; b=BWKiTSptE6oe9F3WGJngwb9khIHKA/uuHmv2LJzodeip2FMnJSx/eVsM8tCBwJgulQs61EQ0nW+HR26rOd3rWpcGyakxD3mKg/AwJUvIF7XKbaTfhp5wsENRc5PtC/2uH/OCy0Kw6ojXwA95FtM+VGJ0Fylk3qyy10jhsk+j8lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181161; c=relaxed/simple;
	bh=imEyi75evQ6OfrNHkeY+v3Zc7nyghltSsLM9WFYlDis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u+AJawl2P1MC9E7kImms8/0JKdSTb0j2bjhW4Hf88M9A73hR5J3XNbsg/y7WmzDlQYKWL+RWkXuijZIjlQkTDqIgS/v0fSWEIyJFOQGe2VeYaNPWkDtU9lgmH7QQ+b0Dh0JGgryAJ0FcphPFHVIAT1T2QAidJ8TPYgl0peOxMvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfNyndSK; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77db1bcf4d3so82266b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758181158; x=1758785958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jStWRzRNYsxk+X2bNGHho3RfC0kIE4UPvb/cKZ6ftGc=;
        b=kfNyndSKXmX0Eb0zrEzLLxY7hKS2/R9kRywGVTtalMuw+qS4ExOoxNtundrHxgwdms
         BuitxWsZfLGwCwwFu9AHQR6xb/7IiKUw/JkCeFk3FBvs1qGaHK1oQU273VVv5XCqf2Db
         XiywOXqYh+YihigSWOWJorXqJlCYf3WmIFrXEQ9yGO4Yn6Oku3Z3ZNPpqBJRidhqwqKg
         t80htmPW7hJl4OSs/I+obyxuUKne7GpKwMWd+n0kOEClMQd8BZdbnOZwN+NUANO0JRXw
         DRnnyfYjbkvuEAQBugkcas9AD7jKWq1ubQthTajHlVpix/uF2A3nWa8YruMho4wTN7tW
         8K3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758181158; x=1758785958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jStWRzRNYsxk+X2bNGHho3RfC0kIE4UPvb/cKZ6ftGc=;
        b=CVpkq7+ckxuALv9v4Za8BaWLCiGiWcZ11566fJBB3oPMiwHjy+KmTLhKnKwsSX3EM+
         vhuf6LLuENJbn9x9kQeIjxeRfA3hRo3WJxGnZUAN9CybSAyXVKkr7LyUoFhxEabhAbfS
         Zh5SSotmSOhDIjsJjB6bq1TEMMawTzhZ2lcJa8R02wCB+KsovjyrdP+Ak5OFafXy67YP
         hT8UbEsyL5gKncHyCOxW8Sst+ZGjFfXXbsOU0th/1HVnAJk8kQrK02BuQg8G/bxQkyBp
         0pA3UlM2z4olSk5U3CdoHVSr3RmwASjPd4CfaDbvDavP+05dLdpd9OfYHe/nB6XOnUpC
         vp8w==
X-Forwarded-Encrypted: i=1; AJvYcCVd+68XWljc1cwr5IytiC5m9TX4DbiOLQZOWsv0V+Kh3bjJAg3FYc7inOqD4xcq26E+Ad4kJxHnTpmNplA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAwvibgT88rJygLSASCJUhsTEizYnzYcSahP61L1pfR57mpFrr
	0avjxNjJWMSQlIMPUh9gktrOvMEyjVA3uxiyNLymdZN5fX+ybd0xlIpL
X-Gm-Gg: ASbGncskDcf8PMN8VhuUqyp7H9XmqBLAtfz+8zHdyY937c2eyXilrfZNaDMMmWSyNru
	sETKMY1L/WmK1JXZjzwDKh74sq3vgLvfenc1aNVbVR7qgmfgIHtaStEJNMUNEfKTFOZNNezvtM5
	Hle/tXSFZit8geqkwIyTYo8scQWTIXQuGWQ9IDdzzG7or2UwNj7BCN/OGhXkvc7EliOfudAguQ1
	M3TY5dFqtJxcvQ0Heana6p1Ctv4btr5C5RAaH08l88dM2SD9wg/cxMWix/Ju3lse//LA687jpfk
	270OSmta/pG58/YYZElob+Dz3mQQZ18w/zu2czEM2V9u0j+C7KIG31cpBBr3CimQXNQcjefFmUg
	eza2KkDurPwLHS509zKBWhxy3wvmybv+baeQUGFc900nJS7WE6eJ4yfZ1fKUepIXo553Gnqbz72
	cDt5cc1qS3o5PlFWyzljrAgw==
X-Google-Smtp-Source: AGHT+IHQmiPxhPbN9GzliabZxstIkW3EABHZh4MIlCfOq+gcLYwzlRp75BZsSfEKT1g65JzPC200gQ==
X-Received: by 2002:a05:6a00:1f10:b0:77d:7b79:a622 with SMTP id d2e1a72fcca58-77d7b79aa0emr922983b3a.14.1758181157945;
        Thu, 18 Sep 2025 00:39:17 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc245e29sm1493766b3a.24.2025.09.18.00.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 00:39:17 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 0B91310620FA; Thu, 18 Sep 2025 16:39:15 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v11 00/13] nommu UML
Date: Thu, 18 Sep 2025 16:38:55 +0900
Message-ID: <cover.1758181109.git.thehajime@gmail.com>
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

Hajime Tazaki (13):
  x86/um: nommu: elf loader for fdpic
  um: decouple MMU specific code from the common part
  um: nommu: memory handling
  x86/um: nommu: syscall handling
  um: nommu: seccomp syscalls hook
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


