Return-Path: <linux-kernel+bounces-891378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281A0C4290C
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 09:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821A83B36F7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 08:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2ACD23BD05;
	Sat,  8 Nov 2025 08:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6DY5HiW"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A39D450FE
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762589156; cv=none; b=mKhrcNv/X8br2lTn8GXFdv47XI7eSe9BcgK8/GOyQpPvilEy0qMaye5zU1394xivUYiDvTDpCgGcPBOXDA93iad9wRO398zCX/wUVc9e/hXGI9eU5wecAdGOINmdClh6x2A/s/8VpJl90dgi5U9jbdMxpHlaK0UWwl6CVKtnyo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762589156; c=relaxed/simple;
	bh=dVYf/269DmdPe7890rx3ge3QvLVGRanA5Bpl3zyZnrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FvYJqy3h83sq+poGgpyMotNesdcUt+snxcp0eVGk9aIum4l1oxwqckqwcTF9rxmO4ZYR/XqZkJBL+AqKeDsINNa4DlZ5cxB62jDIx/wj2eBbv4q8jljWLDg6zfikXjZg3WzwCnGKDCjpzQrRwcUjl6WGnEN8bIQy8kLfEor6XG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6DY5HiW; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3437af8444cso11231a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 00:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762589154; x=1763193954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bVrmTToxfLVUJdta9yLS+cfGmvlWhwp6IxQjV7bDryo=;
        b=Q6DY5HiWbsnZyYUFstraZoFL/ZjINoLllFzffbS/vU1cBGaAmWqZ+OD0i4XeN2S0eG
         V+FRSw9z1Q5CYr1BM+KrsYnEUOHimkCqMOrtgSVWl/4niR8HgmPsIlk1TR7vC7sFswMg
         F9n4e++o8EQ0b2csBHF5qt+ASOu6hodmUskWWw0bpaw9juzc19pujdQv2RnH/JLRGnpf
         jrscgynPKCsRez0Kx3j7oswdPZ0ifMDb2A+2mmm5MsUgJzdWhGKgI0iltkAUXXhlmdY+
         gGx8Z8jMm+P4oigUFQw0gEp9HNhADbZThyPs3TYoC7F5L8RxMaVVp6lQeKfv466u998l
         XVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589154; x=1763193954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVrmTToxfLVUJdta9yLS+cfGmvlWhwp6IxQjV7bDryo=;
        b=fvM6e0JcT1gRM5rJ07UX4GKoQN+llbX41GpSrpJvKTADeXKzOAIsXW1OXLfv0LyGoL
         5gI5nCVLMhkEXGyVE1PQ79Ho1J/ILJBpRXHkgorvFqvNNH1Gl8GplhqIQ8M6ZuXtQ9PU
         IczuzZcsv/P6yOzK58fZkivt2tyTA6nUL8w2scuWnuyZ+Zqjdamt8MCO+H3TeMHHTpmn
         VZRcZGyBOvYDECR6POJ5lKxfye0FjdQgImZJ3uBYRgXCXb6+BnploiM0Alfcq3rZHG+q
         OilSGTRtev/m/oelLSJWbNP7+NTsZxmqAmvThIqQswZz3n0GSL1WaxQR/MpSsft5CNqA
         wGQg==
X-Forwarded-Encrypted: i=1; AJvYcCWrp1YiBnwKeU3VfN/JoSQpW1Cg9WTakCCcJj/OUrrF98kzB+0HMktvbPk5OcyPW+bZVyLAO5Kx5Zp3Quo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE2PHH/FpBFKskA37YQLl/+3eh1DsFPniXzusEtrWUYjhZ2Wd9
	7f7dq9441m6kiNaimb355MCcAltXy71ikJqP6p3dmAKgtscqmjiGwJwR
X-Gm-Gg: ASbGnctqJbLNW3k9OcA+hNDMUlNNQUV5QxLRsw0DJ14szZcKHRP4Z/mlX8xn1iAQA5z
	Vw092/2FB9/Jk2ccVvfMb9q/E+2Ol55aOoJwk/oj0DbamUAkEqYNKDL54f+5uscOTjXj3C+zIQa
	ZdvLDwyYAYf3gooQKW0aFBmT7V0JfskE+MA2IfDJsx+DW83SnkRnyDpV1tDuMFaLIltmoBxtEgS
	s0DTURMMAT7wuXgp3ct2V1k7LxL6dNUh9XgBKRzTealSU59I7+TASV4RyMzkKZcwABg8vF6D54D
	4xljRfcOFftUOvp90913dmlpLmyGZ8vJ8T5iOpLVvl7nnzzFsOni1t31SmPm0oljJEM3Oe54vW/
	SY3VRawXBmFHUJI1lOWNgHi21526++aS4uPCYesAE7YIR8bXLUfAp6nSq4bQqpNY015FJb4Xwel
	sIRRqjTz3757480SSPYwByTBRY+wCNYo7Jt3diEZfMUx2fcA==
X-Google-Smtp-Source: AGHT+IGXnolar7zmjl8A40jhYHOAiihHc85hfdRPHtpFpd3YevpTqY89YO9BiLV/lCPDKV1hb6Ppvw==
X-Received: by 2002:a17:90b:350d:b0:340:c261:f9f3 with SMTP id 98e67ed59e1d1-3436cb8a0bdmr2291860a91.14.1762589153717;
        Sat, 08 Nov 2025 00:05:53 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343727dcf3dsm993051a91.19.2025.11.08.00.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 00:05:52 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 310AE11388C4; Sat,  8 Nov 2025 17:05:51 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 00/13] nommu UML
Date: Sat,  8 Nov 2025 17:05:35 +0900
Message-ID: <cover.1762588860.git.thehajime@gmail.com>
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
- CONFIG_SMP is disabled as host_fs handling doesn't work with thread
  local storage.

-- Hajime

v13:
- rebase with the latest uml/next branch, fixing a conflict ([06/13])

v12:
- rebase with the latest uml/next branch
- disable SMP and tls as those doesn't work with host_fs handling ([11/13])
- https://lore.kernel.org/all/cover.1762075876.git.thehajime@gmail.com/

v11:
- clean up userspace return routine and integrate to userspace() ([04/13])
- fix direction flag issue on using nolibc memcpy ([04/13])
- fix a crash issue when using usermode helper ([06/13])
- test with out-of-tree kunit-uapi patches (which uses umh)
 - https://lore.kernel.org/all/20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de/
 - https://lore.kernel.org/all/20250626195714.2123694-3-benjamin@sipsolutions.net/
- https://lore.kernel.org/all/cover.1758181109.git.thehajime@gmail.com/

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
  um: change machine name for uname output
  um: nommu: disable SMP on nommu UML
  um: nommu: add documentation of nommu UML
  um: nommu: plug nommu code into build system

 Documentation/virt/uml/nommu-uml.rst   | 180 ++++++++++++++++++++++
 MAINTAINERS                            |   1 +
 arch/um/Kconfig                        |  14 +-
 arch/um/Makefile                       |  10 ++
 arch/um/configs/x86_64_nommu_defconfig |  54 +++++++
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
 arch/um/kernel/process.c               |  38 +++++
 arch/um/kernel/skas/process.c          |  37 -----
 arch/um/kernel/um_arch.c               |   3 +
 arch/um/nommu/Makefile                 |   3 +
 arch/um/nommu/os-Linux/Makefile        |   7 +
 arch/um/nommu/os-Linux/seccomp.c       |  87 +++++++++++
 arch/um/nommu/os-Linux/signal.c        |  24 +++
 arch/um/nommu/trap.c                   | 201 +++++++++++++++++++++++++
 arch/um/os-Linux/Makefile              |   3 +-
 arch/um/os-Linux/internal.h            |   8 +
 arch/um/os-Linux/mem.c                 |   4 +
 arch/um/os-Linux/process.c             | 139 ++++++++++++++++-
 arch/um/os-Linux/signal.c              |  11 +-
 arch/um/os-Linux/skas/process.c        | 127 ----------------
 arch/um/os-Linux/start_up.c            |  25 ++-
 arch/um/os-Linux/util.c                |   3 +-
 arch/x86/um/Kconfig                    |   2 +-
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
 46 files changed, 1322 insertions(+), 223 deletions(-)
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


base-commit: 293f71435d14f5b5c46fc3398695fa265c69363d
-- 
2.43.0


