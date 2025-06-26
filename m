Return-Path: <linux-kernel+bounces-703578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90814AE9229
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 01:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA44D3A42B7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 23:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558132F49F4;
	Wed, 25 Jun 2025 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="cHJnPRZu"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF812F432F
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 23:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893526; cv=none; b=M/3604LjxZOp6+04dJdc+mWXYAGrCDqaKAW5V9FtC3juEJabcFkJPqBoVBR37KPRNe6fiYBwaIxlSYqOpHNCOxIGrfIUYkZFpMHGmIpm5ntK9gtj2ZuWyt2O2TCy3NGbizalhHT9gd8Qqk5CypVUXXgc0xuHF9OGTpwnweIJ74Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893526; c=relaxed/simple;
	bh=zatXswZYD++M3OYmAmVejWumUqP8j7hxgRnQTqm3U6g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hxU30cLjhwcTHI/FaUpHYcObN7qW1Uq92DLJs72TfftD2Zxlg8e4z0a/VEpFxAYmNR8ejH4NyG6OiypOhtDSmpL70PiMmjczihHjfAqWVIzcpWoSje/FIlVuYHpedYT56quXJjXghhhQMvTp3ez9azQSHcf2wkWb/ymULIY2NyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=cHJnPRZu; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e84207a8aa3so236619276.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 16:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1750893523; x=1751498323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VHX9EXA6F2qxSiI8OqBQ3C55jxt3DE5W2Xg0VoRe03U=;
        b=cHJnPRZumi/U8/ttLX4pzrrigwlF1LyYPwvG79r91+vSoIM5gXoxvccdk990VTw8AY
         a2MVcZXCfyg/cPcuwOuO9GIPhSntJSq6q8CcspdJKAcbsVpz9Nbmxna46qZvx+V4Q8fR
         hM+ygt45RRBdO9lEKudyy5SkvP/a4o0hehCKvWE+or1XiYrRwG5qxWciiz5yWM+ZCh33
         wrNeAWVpKBjYqBewwTpUF9h3adSiVfeNwaKke49IchaVJ1C1Cp4MzqYMvkLhoEAJf5K2
         Zo4SEk8Kh/2pQFZtHYxeykGRHRAck6kuWJ97X6s+qsJ19u7KWaZmsVsV5rKvOW0spz/C
         jZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750893523; x=1751498323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VHX9EXA6F2qxSiI8OqBQ3C55jxt3DE5W2Xg0VoRe03U=;
        b=JEB6S3Xk7P23tmdisKiGBA9wYKiK6V+Y051vER/qB8yXdYhD14YoazvwtmAPOr9pkH
         4Qyq4S3zHdgG/ePJmjQkyCLky25aG/Winwf+17e/Rf7+8k3v9xXHsovcdH2oxEQ4iwoR
         0dwIH3rQ5e96MNb5CGtlEXyQH5FaAiTLTgsFL91OIfhJ+N5cd3Yr2KkW20ROcsPC4cKj
         r4eIEZnJCluy4fe+nHGRRZucmWViTuRRv7Z+OBq3uJJ8t/NZD+WimAIK+q52jViCTsls
         GjjXvpuBf9V4UWmcGKPIJjQ2nVF/asZfvPon6xoTvTShE09lqnWgWkATR6trWfFvtYac
         b3Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUCIKb1Uk8tRe6/yZelIYnQ0oVgQtQhvy29bm01z06wvF/8mjI3QifxtiJMLQTl//6IxSyk5pcJdJMaQ1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaTYAYfetPPAnKDyJV9XHPnJOHoApWvWjmojqrwAt65BD2pEiW
	tvJ9vVzvrPpcVdMmXGKxchPOHb85G5FNmY8zRLGSlVw98bN1IAY2mhqNiPkgWEUT0jU=
X-Gm-Gg: ASbGnct6jiLgYze9UF5YmSvPn4td5/OEm0tnHjJDMrBHoQsDGjhuFEcpkWuglrL2oTB
	FMbviq/H2tLPPvsZ37mAYk6v910L3D2/r5KpUkwab1iXy1Vmo+Y7iwwwiQueS9gzNH42yLmvB0D
	sU6aZ1bybAFxU1dThzIbPvDfgUxtAcj1Ovi9FiV+TO+FwFUnBMmwTjJQgB1c7RFjFRRDz3UCxAE
	acB9QN6i46+h9G5cFk373V0L63/wYMP3mEseaGNh5bByNh1Pc0CZGD8RzZgPN3cTTM/qcwCBWSK
	/+9XaMDKkB5RfNMhys6emmnDh/BBGhxkTonXPKDzb8Vg13mCwvilUD3byMaeX0uopkOLW23itfo
	Fabn6wxqEEo8MqPQs23ewUVkRJ+1Q4/68vymFe/7DNBpoM1rVhKGp
X-Google-Smtp-Source: AGHT+IEk36JM8FAwjTDQiH8mzNlLEvNw7Ex5deckOFxvJks1MR0+qIMLz9Zj+oPMn2p4k67rJ+5s5g==
X-Received: by 2002:a05:6902:1702:b0:e81:d7c8:1208 with SMTP id 3f1490d57ef6-e860176b5cbmr6432043276.6.1750893523270;
        Wed, 25 Jun 2025 16:18:43 -0700 (PDT)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac5c538sm3942684276.33.2025.06.25.16.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:18:42 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 00/32] Live Update Orchestrator
Date: Wed, 25 Jun 2025 23:17:47 +0000
Message-ID: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces the LUO, a kernel subsystem designed to
facilitate live kernel updates with minimal downtime,
particularly in cloud delplyoments aiming to update without fully
disrupting running virtual machines.

This series builds upon KHO framework by adding programmatic
control over KHO's lifecycle and leveraging KHO for persisting LUO's
own metadata across the kexec boundary. The git branch for this series
can be found at:

https://github.com/googleprodkernel/linux-liveupdate/tree/luo/v1

Changelog from rfc-v2:
- Addressed review comments from Mike Rapoport, Pratyush Yadav,
  David Matlack
- Moved everything under kernel/liveupdate including KHO.
- Added a number fixes to KHO that were discovered.
- luo_files is not a registred as a subsystem.
- Added sessions support to preserved files.
- Added support for memfd (Pratyush Yadav)
- Added libluo (proposed as RFC) (Pratyush Yadav)
- Removed notifiers from KHO (Mike Rapoport)

What is Live Update?
Live Update is a kexec based reboot process where selected kernel
resources (memory, file descriptors, and eventually devices) are kept
operational or their state preserved across a kernel transition. For
certain resources, DMA and interrupt activity might continue with
minimal interruption during the kernel reboot.

LUO provides a framework for coordinating live updates. It features:
State Machine: Manages the live update process through states:
NORMAL, PREPARED, FROZEN, UPDATED.

KHO Integration:

LUO programmatically drives KHO's finalization and abort sequences.
KHO's debugfs interface is now optional configured via
CONFIG_KEXEC_HANDOVER_DEBUG.

LUO preserves its own metadata via KHO's kho_add_subtree and
kho_preserve_phys() mechanisms.

Subsystem Participation: A callback API liveupdate_register_subsystem()
allows kernel subsystems (e.g., KVM, IOMMU, VFIO, PCI) to register
handlers for LUO events (PREPARE, FREEZE, FINISH, CANCEL) and persist a
u64 payload via the LUO FDT.

File Descriptor Preservation: Infrastructure
liveupdate_register_filesystem, luo_register_file, luo_retrieve_file to
allow specific types of file descriptors (e.g., memfd, vfio) to be
preserved and restored.

Handlers for specific file types can be registered to manage their
preservation and restoration, storing a u64 payload in the LUO FDT.

User-space Interface:

ioctl (/dev/liveupdate): The primary control interface for
triggering LUO state transitions (prepare, freeze, finish, cancel)
and managing the preservation/restoration of file descriptors.
Access requires CAP_SYS_ADMIN.

sysfs (/sys/kernel/liveupdate/state): A read-only interface for
monitoring the current LUO state. This allows userspace services to
track progress and coordinate actions.

Selftests: Includes kernel-side hooks and userspace selftests to
verify core LUO functionality, particularly subsystem registration and
basic state transitions.

LUO State Machine and Events:

NORMAL:   Default operational state.
PREPARED: Initial preparation complete after LIVEUPDATE_PREPARE
          event. Subsystems have saved initial state.
FROZEN:   Final "blackout window" state after LIVEUPDATE_FREEZE
          event, just before kexec. Workloads must be suspended.
UPDATED:  Next kernel has booted via live update. Awaiting restoration
          and LIVEUPDATE_FINISH.

Events:
LIVEUPDATE_PREPARE: Prepare for reboot, serialize state.
LIVEUPDATE_FREEZE:  Final opportunity to save state before kexec.
LIVEUPDATE_FINISH:  Post-reboot cleanup in the next kernel.
LIVEUPDATE_CANCEL:  Abort prepare or freeze, revert changes.

RFC v1: https://lore.kernel.org/all/20250320024011.2995837-1-pasha.tatashin@soleen.com
RFC v2: https://lore.kernel.org/all/20250515182322.117840-1-pasha.tatashin@soleen.com/

Changyuan Lyu (1):
  kho: add interfaces to unpreserve folios and physical memory ranges

Mike Rapoport (Microsoft) (1):
  kho: drop notifiers

Pasha Tatashin (22):
  kho: init new_physxa->phys_bits to fix lockdep
  kho: mm: Don't allow deferred struct page with KHO
  kho: warn if KHO is disabled due to an error
  kho: allow to drive kho from within kernel
  kho: make debugfs interface optional
  kho: don't unpreserve memory during abort
  liveupdate: kho: move to kernel/liveupdate
  liveupdate: luo_core: Live Update Orchestrator
  liveupdate: luo_core: integrate with KHO
  liveupdate: luo_subsystems: add subsystem registration
  liveupdate: luo_subsystems: implement subsystem callbacks
  liveupdate: luo_files: add infrastructure for FDs
  liveupdate: luo_files: implement file systems callbacks
  liveupdate: luo_ioctl: add ioctl interface
  liveupdate: luo_sysfs: add sysfs state monitoring
  reboot: call liveupdate_reboot() before kexec
  liveupdate: luo_files: luo_ioctl: session-based file descriptor
    tracking
  kho: move kho debugfs directory to liveupdate
  liveupdate: add selftests for subsystems un/registration
  selftests/liveupdate: add subsystem/state tests
  docs: add luo documentation
  MAINTAINERS: add liveupdate entry

Pratyush Yadav (8):
  mm: shmem: use SHMEM_F_* flags instead of VM_* flags
  mm: shmem: allow freezing inode mapping
  mm: shmem: export some functions to internal.h
  luo: allow preserving memfd
  docs: add documentation for memfd preservation via LUO
  tools: introduce libluo
  libluo: introduce luoctl
  libluo: add tests

 .../ABI/testing/sysfs-kernel-liveupdate       |  51 +
 Documentation/admin-guide/index.rst           |   1 +
 Documentation/admin-guide/liveupdate.rst      |  16 +
 Documentation/core-api/index.rst              |   1 +
 Documentation/core-api/kho/concepts.rst       |   2 +-
 Documentation/core-api/liveupdate.rst         |  57 ++
 Documentation/mm/index.rst                    |   1 +
 Documentation/mm/memfd_preservation.rst       | 138 +++
 Documentation/userspace-api/index.rst         |   1 +
 .../userspace-api/ioctl/ioctl-number.rst      |   2 +
 Documentation/userspace-api/liveupdate.rst    |  25 +
 MAINTAINERS                                   |  20 +-
 include/linux/kexec_handover.h                |  53 +-
 include/linux/liveupdate.h                    | 235 +++++
 include/linux/shmem_fs.h                      |  23 +
 include/uapi/linux/liveupdate.h               | 265 +++++
 init/Kconfig                                  |   2 +
 kernel/Kconfig.kexec                          |  14 -
 kernel/Makefile                               |   2 +-
 kernel/liveupdate/Kconfig                     |  90 ++
 kernel/liveupdate/Makefile                    |  13 +
 kernel/{ => liveupdate}/kexec_handover.c      | 556 +++++-----
 kernel/liveupdate/kexec_handover_debug.c      | 222 ++++
 kernel/liveupdate/kexec_handover_internal.h   |  45 +
 kernel/liveupdate/luo_core.c                  | 525 ++++++++++
 kernel/liveupdate/luo_files.c                 | 946 ++++++++++++++++++
 kernel/liveupdate/luo_internal.h              |  47 +
 kernel/liveupdate/luo_ioctl.c                 | 192 ++++
 kernel/liveupdate/luo_selftests.c             | 344 +++++++
 kernel/liveupdate/luo_selftests.h             |  84 ++
 kernel/liveupdate/luo_subsystems.c            | 420 ++++++++
 kernel/liveupdate/luo_sysfs.c                 |  92 ++
 kernel/reboot.c                               |   4 +
 mm/Makefile                                   |   1 +
 mm/internal.h                                 |   6 +
 mm/memblock.c                                 |  56 +-
 mm/memfd_luo.c                                | 501 ++++++++++
 mm/shmem.c                                    |  46 +-
 tools/lib/luo/LICENSE                         | 165 +++
 tools/lib/luo/Makefile                        |  45 +
 tools/lib/luo/README.md                       | 166 +++
 tools/lib/luo/cli/.gitignore                  |   1 +
 tools/lib/luo/cli/Makefile                    |  18 +
 tools/lib/luo/cli/luoctl.c                    | 178 ++++
 tools/lib/luo/include/libluo.h                | 128 +++
 tools/lib/luo/include/liveupdate.h            | 265 +++++
 tools/lib/luo/libluo.c                        | 203 ++++
 tools/lib/luo/tests/.gitignore                |   1 +
 tools/lib/luo/tests/Makefile                  |  18 +
 tools/lib/luo/tests/test.c                    | 848 ++++++++++++++++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/liveupdate/.gitignore |   1 +
 tools/testing/selftests/liveupdate/Makefile   |   7 +
 tools/testing/selftests/liveupdate/config     |   6 +
 .../testing/selftests/liveupdate/liveupdate.c | 356 +++++++
 55 files changed, 7091 insertions(+), 415 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-liveupdate
 create mode 100644 Documentation/admin-guide/liveupdate.rst
 create mode 100644 Documentation/core-api/liveupdate.rst
 create mode 100644 Documentation/mm/memfd_preservation.rst
 create mode 100644 Documentation/userspace-api/liveupdate.rst
 create mode 100644 include/linux/liveupdate.h
 create mode 100644 include/uapi/linux/liveupdate.h
 create mode 100644 kernel/liveupdate/Kconfig
 create mode 100644 kernel/liveupdate/Makefile
 rename kernel/{ => liveupdate}/kexec_handover.c (74%)
 create mode 100644 kernel/liveupdate/kexec_handover_debug.c
 create mode 100644 kernel/liveupdate/kexec_handover_internal.h
 create mode 100644 kernel/liveupdate/luo_core.c
 create mode 100644 kernel/liveupdate/luo_files.c
 create mode 100644 kernel/liveupdate/luo_internal.h
 create mode 100644 kernel/liveupdate/luo_ioctl.c
 create mode 100644 kernel/liveupdate/luo_selftests.c
 create mode 100644 kernel/liveupdate/luo_selftests.h
 create mode 100644 kernel/liveupdate/luo_subsystems.c
 create mode 100644 kernel/liveupdate/luo_sysfs.c
 create mode 100644 mm/memfd_luo.c
 create mode 100644 tools/lib/luo/LICENSE
 create mode 100644 tools/lib/luo/Makefile
 create mode 100644 tools/lib/luo/README.md
 create mode 100644 tools/lib/luo/cli/.gitignore
 create mode 100644 tools/lib/luo/cli/Makefile
 create mode 100644 tools/lib/luo/cli/luoctl.c
 create mode 100644 tools/lib/luo/include/libluo.h
 create mode 100644 tools/lib/luo/include/liveupdate.h
 create mode 100644 tools/lib/luo/libluo.c
 create mode 100644 tools/lib/luo/tests/.gitignore
 create mode 100644 tools/lib/luo/tests/Makefile
 create mode 100644 tools/lib/luo/tests/test.c
 create mode 100644 tools/testing/selftests/liveupdate/.gitignore
 create mode 100644 tools/testing/selftests/liveupdate/Makefile
 create mode 100644 tools/testing/selftests/liveupdate/config
 create mode 100644 tools/testing/selftests/liveupdate/liveupdate.c

-- 
2.50.0.727.gbf7dc18ff4-goog


