Return-Path: <linux-kernel+bounces-881706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF044C28CA9
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 10:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F41E3ACD50
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 09:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BFD1F4617;
	Sun,  2 Nov 2025 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrwTANdO"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00764A02
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762076991; cv=none; b=ZAEZdSAX9Rsltfd6CFxBXIgjSZ/4zCY/fewSEgAaW4cPM80PpPSXrCfW6g8SVO8cfz3l1qfWQsWNeXOfxkSN5+1RjAe3ZI1Y8U5VbqSTwC8s1psFFuanSCRKyVbls9QMT4zdqpGHe6XN/V+ZGZNWZ2luw3udqnagFSoz6vYo8vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762076991; c=relaxed/simple;
	bh=uDhFaZn/7RLLiPI6WQyfElG0+z+PheaKLEArbrCc+iU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V9H9fwMz7Ky3uj98E4v24MyBHg1l70Lm9T/IR1ONDpax4LU/5rK6rbQ0GWZXSmyN5Q9DbLAF6vMPTAvRbe0/oK6z5/R+rPAH8pdqRuzyQLhBTaHiIEhP9J/aiITM9AMoI1IRsQHgQRVC0SdA0WGbn7GxibXJYJoC1yDba+qvOEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrwTANdO; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so2211948a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 01:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762076989; x=1762681789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CTo/fO8AwTUlnERfKnS0Hq9g4pzw1jJNDet5wuDWHQk=;
        b=TrwTANdOOSO15q0RLyW+zaZbgl6XTHH5zBaOnCWIrD5biPG3L6gZe0aBysKITu8Zej
         iVuJDBa6ldazaOrgtliUGxjrUxKH1u4LM8nuMN4sFsWXT+nHC4+SNkkArnE/DmQ1X2vN
         +a10CT70PpIVyVdVewT0h8yjoxn4Doc+804YQWDGzV12zUnp+8PDimu5JhHhI5wuBArv
         zBXr1ft0c56YT9G4Q4LeO4J/OMwGYrEVv2T0IOii59gSPc7COpIxRVDL6cAHD7njebUi
         EWNylh87Dm2/X/oGxuN90CQ273RQOmH33D5/jFljDlufZ9z1Vnhw2AlWIhsBd2N2CXLn
         C/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762076989; x=1762681789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTo/fO8AwTUlnERfKnS0Hq9g4pzw1jJNDet5wuDWHQk=;
        b=aWUbwI6D+zhiBneH0jvkbr+GG8xHGU+d9lMrapfbUw+9PlEQaaqCWVyyJWVhX/qMUf
         fEEfhNESgWipux7wdZ97Ylw+uGnyx6HODS8+TnlqL1L3fL85tPoaOt7Ggk/L8NEiwoVX
         zec6f1bPn3gOZGFV+1nfInGpz7sWgGiUMceLueZgSUQnB9zgOpdFLnYTedGR4p+mz2b7
         /dWKB8/zKeUD8OmfOGld54PP/oRCXCRKfjA7qmPnESzDAz4bfqDk6FgEm/8qQEgBOLrT
         m2mkGYkRE1MECEcPdaFdBSmTn5ifelu29mzESTyOioaeUi6kC/5Fwq4Gkew06XzVvSoI
         3zug==
X-Forwarded-Encrypted: i=1; AJvYcCVxkkt9c+ljuK7C9IOtSe/1LSLgpzLvksiAeGR6W3VGMDG1k7XQZt8PncbTbm/pw9Ehdr7tJ80T0bWctpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK2Isj2HzyVPuDMuFZrd3Ci3duUA/dPKHk9+WhEQiAtmoeT8oE
	6voLElFYLhzTgRP4crezEHYPxxxjDMKMtCaZBKz09m5MQEbBLzpfY8Hp
X-Gm-Gg: ASbGncv2Mf720PA14w/EStldSkq3CyC2bV2gcQmvYA6ZqFx3kcVzj4ncJ80PDcCvA+H
	TM4KVSitSi2WJnaWfcZBlFcTYpGD1NR7Z79Nwi3CrAbnWHENZaQhKs7zupNF8LYgDYkIRejQQZF
	G3FXiR9PJsl+rJ+RaeoAvOEeCzh3v6wKvA53i4qIOJheKD2hLMB19QuPZdgy5pkznB26r42ofpP
	bjIGWsm8KgBmn/6kSOI0hAOv8JMsp3MyKFJzWnsumSDkm5FKPJqstq0vsSgGkVkrchs1rcZP66O
	C3T5oG22CnJ45Tp+yqOr8fjhNDKvxTdeatFL1Mvp982qqx7Ulft3PbqDNTTYtcSY93dlKeELYkQ
	iVycOnTj26S2TCbPVSd5cGPf16ETQeXJQ8yDOrzGbv2iijLzQUTRpDbZxmJyU3GyHlrrEfGmiFn
	LGkxhDRX4oKF5DwzaJ7nZk8pllJA1is5ec+9rcN3X3EM+Lhg==
X-Google-Smtp-Source: AGHT+IG5uEZuIhw9XthpVR/gauM2QFGD0azbjoJ+g93MQt9Wwqr6xtlh/sIZ+JQcm6X627sSMbAf5A==
X-Received: by 2002:a17:903:41c7:b0:295:62d:4ffa with SMTP id d9443c01a7336-2951a3b12dfmr134893555ad.21.1762076988895;
        Sun, 02 Nov 2025 01:49:48 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b9b8f2b5403sm812430a12.17.2025.11.02.01.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 01:49:48 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 0F85011237FC; Sun,  2 Nov 2025 18:49:41 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 00/13] nommu UML
Date: Sun,  2 Nov 2025 18:49:25 +0900
Message-ID: <cover.1762075876.git.thehajime@gmail.com>
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

v12:
- rebase with the latest uml/next branch
- disable SMP and tls as those doesn't work with host_fs handling ([11/13])

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


base-commit: 8e03c195cc4d82100291500f772f85c686653748
-- 
2.43.0


