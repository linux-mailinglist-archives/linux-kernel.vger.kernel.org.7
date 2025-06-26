Return-Path: <linux-kernel+bounces-703629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C807AE92E9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 01:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCCF17A580A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 23:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238FB2D3EF2;
	Wed, 25 Jun 2025 23:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="lGaQVf+M"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F8B287266
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 23:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750895095; cv=none; b=uPjfILXSeOqiGWaWc2w5mGOOwAvVJAHHN8pWdnSxiwlOhALsE9rcYexg6dnIj5uREAbUGDbH5xFLmJ8pga8E5nH/YAMDZFsNeAtlT92ZnZuOCtLV8T69PuK7IiLC9nsYTWeqgELt8fQRW0pJObNQ/4E7AeDDYIADbx+ghinbBNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750895095; c=relaxed/simple;
	bh=bg3Ch3oaeSTn0gw9pOu0G8fmMZicuhfiYO3wgc/W9g4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSqn/tR7Ditzx0W7XgTlHRg3dh9VMkmWw3FCoYUab13qU4WZhXjHiFE7p7T7J4os0dUsU7F5micCshcXEhidzdXrIaA78Huu+4XbKfkSDxw9m7puvvSdXmg7NP5/1fRRcCiWWI8qTAkSsFhb3tZgjZ8vDn7/lGAam+tGSl1FxVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=lGaQVf+M; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a6f3f88613so6334451cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 16:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1750895092; x=1751499892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FK7GsFF88lqGjvQm8ZMWAKGf8qGndWj9zjttanlA1xU=;
        b=lGaQVf+MWTUO6Prrql7qBABPKF7bQhXoUPoZMOtU40/XioQy4/hGdqA7dFgcybjzxb
         KqqAe2RhYb/Vf2+oapsaza/a2XmXKUUHdJCnu1PSOejoKGmi7tNCi4TfhOmndap8RDSy
         A0jWv7IdCDJvEtV+oYyLC8W/J23oSfTLCQwSZPQze2frfpzSz1i2kuFTmPRmJ4QLqwxM
         kKPiWflEZYwCwgvQpFJGojlekwKGcZtkAT45E+lJieMJn7RXwVj3iufuBxRURwdqm2ww
         GfDLnxv1zqG9673BfdZ1+smjU1r6P0TzSgbxbk8hViHCvuAlBPpngkbMyWT2QWTm5ekw
         q/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750895092; x=1751499892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FK7GsFF88lqGjvQm8ZMWAKGf8qGndWj9zjttanlA1xU=;
        b=s/l4agdcMfyJE7jjhfwjtIf1ZBv6SS+xtImTszOQ/5J7EYCS8k6VReZOlVMUv/w9J/
         RlIs5PY9s+L0IrokPCujAV6UNNgQMdHIe9EGgNOnczigYXRp6Mmc2C9HpK9qleD2qQuk
         sXRoaWDfpu9r4Wy0FkZcwUWflHUlc4M0PIX2XMZy3qrRh7HPzB/xfvtpzj06T2Un+ETA
         i/Fq8kGK6ruPYW7q8xuPNeBl7MligWamgTNu3X1v57/Dfokc9nkKAp1U0UbQSJB7e1Tb
         hLw0GC2Z797ZyoMtQlfkkcjCUEBElkcDRdsHPO5qduF/sT1zhVmQiYYoc5v7YygWWSAD
         ZYRA==
X-Forwarded-Encrypted: i=1; AJvYcCUsvJlOdA4U9jAe5GRgers/We9RThrDYC89opfAJBHaah9dhbU1UY4kC4GvP3kjCkeXHJp2dmg0FyeqwaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeZf/nQdr/6KyOTRJLnCZFeeeDOTvUnw/poXi5qGIdpNq3gaUL
	RjrIdWENQdLNS4HRUOApv43rKxkKbugdz/GHbnnk0PxTMX0DMOzC6Xe/kRfOLyqn2QklkoBsE2t
	j6EXhw8C2dnwEpMacoYlAeAW71XKaybJFX+OhccX41g==
X-Gm-Gg: ASbGncvYe1WxS9nHocyt9IEYT7QLT70Tp4CaWgK4f66+Yt7Mvj4FMm3j+Borr84fqtz
	i/CkexhpinMoVdmJSnzvRRP5qDm4bhb3d8VcT1Vk9n8ObTEVwvC/6lujrcGqyYSp2h+v2mkozyD
	LBIFnN1vMWQdUj150oQa74TjIQjYOFRslIlYt7PQRE9Q==
X-Google-Smtp-Source: AGHT+IFA1dw/Tbh1ngrhBlKF8dPXkDASOz9bRitH3ybBqQXjF3c1snI3GefczU+R9hvfnnbVRHa47Akh8WxSx3KKBaU=
X-Received: by 2002:a05:622a:1aa3:b0:4a4:3449:2b82 with SMTP id
 d75a77b69052e-4a7c0675de3mr94942221cf.13.1750895091918; Wed, 25 Jun 2025
 16:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com> <20250625232653.GJ369@kvack.org>
In-Reply-To: <20250625232653.GJ369@kvack.org>
From: "pasha.tatashin" <pasha.tatashin@soleen.com>
Date: Wed, 25 Jun 2025 19:44:12 -0400
X-Gm-Features: Ac12FXw9JQy4g0DzAGeQjJ73rJNx0LH5nXFC6RmoGr5lfqNnNC58y1Z2DsYDqVc
Message-ID: <CA+CK2bAsz4Zz2_Kp8QMKxG5taY52ykhhykROd0di85ax5eeOrw@mail.gmail.com>
Subject: Re: [PATCH v1 00/32] Live Update Orchestrator
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 7:26=E2=80=AFPM Benjamin LaHaise <bcrl@kvack.org> w=
rote:
>
> FYI: Every one of your emails to the list for this series was bounced by
> all the recipients using @gmail.com email addresses.
>
>                 -ben (owner-linux-mm)

This is extremely annoying, I will need to figure out why this is
happening. soleen.com uses google workspace.

Pasha

>
> On Wed, Jun 25, 2025 at 11:17:47PM +0000, Pasha Tatashin wrote:
> > This series introduces the LUO, a kernel subsystem designed to
> > facilitate live kernel updates with minimal downtime,
> > particularly in cloud delplyoments aiming to update without fully
> > disrupting running virtual machines.
> >
> > This series builds upon KHO framework by adding programmatic
> > control over KHO's lifecycle and leveraging KHO for persisting LUO's
> > own metadata across the kexec boundary. The git branch for this series
> > can be found at:
> >
> > https://github.com/googleprodkernel/linux-liveupdate/tree/luo/v1
> >
> > Changelog from rfc-v2:
> > - Addressed review comments from Mike Rapoport, Pratyush Yadav,
> >   David Matlack
> > - Moved everything under kernel/liveupdate including KHO.
> > - Added a number fixes to KHO that were discovered.
> > - luo_files is not a registred as a subsystem.
> > - Added sessions support to preserved files.
> > - Added support for memfd (Pratyush Yadav)
> > - Added libluo (proposed as RFC) (Pratyush Yadav)
> > - Removed notifiers from KHO (Mike Rapoport)
> >
> > What is Live Update?
> > Live Update is a kexec based reboot process where selected kernel
> > resources (memory, file descriptors, and eventually devices) are kept
> > operational or their state preserved across a kernel transition. For
> > certain resources, DMA and interrupt activity might continue with
> > minimal interruption during the kernel reboot.
> >
> > LUO provides a framework for coordinating live updates. It features:
> > State Machine: Manages the live update process through states:
> > NORMAL, PREPARED, FROZEN, UPDATED.
> >
> > KHO Integration:
> >
> > LUO programmatically drives KHO's finalization and abort sequences.
> > KHO's debugfs interface is now optional configured via
> > CONFIG_KEXEC_HANDOVER_DEBUG.
> >
> > LUO preserves its own metadata via KHO's kho_add_subtree and
> > kho_preserve_phys() mechanisms.
> >
> > Subsystem Participation: A callback API liveupdate_register_subsystem()
> > allows kernel subsystems (e.g., KVM, IOMMU, VFIO, PCI) to register
> > handlers for LUO events (PREPARE, FREEZE, FINISH, CANCEL) and persist a
> > u64 payload via the LUO FDT.
> >
> > File Descriptor Preservation: Infrastructure
> > liveupdate_register_filesystem, luo_register_file, luo_retrieve_file to
> > allow specific types of file descriptors (e.g., memfd, vfio) to be
> > preserved and restored.
> >
> > Handlers for specific file types can be registered to manage their
> > preservation and restoration, storing a u64 payload in the LUO FDT.
> >
> > User-space Interface:
> >
> > ioctl (/dev/liveupdate): The primary control interface for
> > triggering LUO state transitions (prepare, freeze, finish, cancel)
> > and managing the preservation/restoration of file descriptors.
> > Access requires CAP_SYS_ADMIN.
> >
> > sysfs (/sys/kernel/liveupdate/state): A read-only interface for
> > monitoring the current LUO state. This allows userspace services to
> > track progress and coordinate actions.
> >
> > Selftests: Includes kernel-side hooks and userspace selftests to
> > verify core LUO functionality, particularly subsystem registration and
> > basic state transitions.
> >
> > LUO State Machine and Events:
> >
> > NORMAL:   Default operational state.
> > PREPARED: Initial preparation complete after LIVEUPDATE_PREPARE
> >           event. Subsystems have saved initial state.
> > FROZEN:   Final "blackout window" state after LIVEUPDATE_FREEZE
> >           event, just before kexec. Workloads must be suspended.
> > UPDATED:  Next kernel has booted via live update. Awaiting restoration
> >           and LIVEUPDATE_FINISH.
> >
> > Events:
> > LIVEUPDATE_PREPARE: Prepare for reboot, serialize state.
> > LIVEUPDATE_FREEZE:  Final opportunity to save state before kexec.
> > LIVEUPDATE_FINISH:  Post-reboot cleanup in the next kernel.
> > LIVEUPDATE_CANCEL:  Abort prepare or freeze, revert changes.
> >
> > RFC v1: https://lore.kernel.org/all/20250320024011.2995837-1-pasha.tata=
shin@soleen.com
> > RFC v2: https://lore.kernel.org/all/20250515182322.117840-1-pasha.tatas=
hin@soleen.com/
> >
> > Changyuan Lyu (1):
> >   kho: add interfaces to unpreserve folios and physical memory ranges
> >
> > Mike Rapoport (Microsoft) (1):
> >   kho: drop notifiers
> >
> > Pasha Tatashin (22):
> >   kho: init new_physxa->phys_bits to fix lockdep
> >   kho: mm: Don't allow deferred struct page with KHO
> >   kho: warn if KHO is disabled due to an error
> >   kho: allow to drive kho from within kernel
> >   kho: make debugfs interface optional
> >   kho: don't unpreserve memory during abort
> >   liveupdate: kho: move to kernel/liveupdate
> >   liveupdate: luo_core: Live Update Orchestrator
> >   liveupdate: luo_core: integrate with KHO
> >   liveupdate: luo_subsystems: add subsystem registration
> >   liveupdate: luo_subsystems: implement subsystem callbacks
> >   liveupdate: luo_files: add infrastructure for FDs
> >   liveupdate: luo_files: implement file systems callbacks
> >   liveupdate: luo_ioctl: add ioctl interface
> >   liveupdate: luo_sysfs: add sysfs state monitoring
> >   reboot: call liveupdate_reboot() before kexec
> >   liveupdate: luo_files: luo_ioctl: session-based file descriptor
> >     tracking
> >   kho: move kho debugfs directory to liveupdate
> >   liveupdate: add selftests for subsystems un/registration
> >   selftests/liveupdate: add subsystem/state tests
> >   docs: add luo documentation
> >   MAINTAINERS: add liveupdate entry
> >
> > Pratyush Yadav (8):
> >   mm: shmem: use SHMEM_F_* flags instead of VM_* flags
> >   mm: shmem: allow freezing inode mapping
> >   mm: shmem: export some functions to internal.h
> >   luo: allow preserving memfd
> >   docs: add documentation for memfd preservation via LUO
> >   tools: introduce libluo
> >   libluo: introduce luoctl
> >   libluo: add tests
> >
> >  .../ABI/testing/sysfs-kernel-liveupdate       |  51 +
> >  Documentation/admin-guide/index.rst           |   1 +
> >  Documentation/admin-guide/liveupdate.rst      |  16 +
> >  Documentation/core-api/index.rst              |   1 +
> >  Documentation/core-api/kho/concepts.rst       |   2 +-
> >  Documentation/core-api/liveupdate.rst         |  57 ++
> >  Documentation/mm/index.rst                    |   1 +
> >  Documentation/mm/memfd_preservation.rst       | 138 +++
> >  Documentation/userspace-api/index.rst         |   1 +
> >  .../userspace-api/ioctl/ioctl-number.rst      |   2 +
> >  Documentation/userspace-api/liveupdate.rst    |  25 +
> >  MAINTAINERS                                   |  20 +-
> >  include/linux/kexec_handover.h                |  53 +-
> >  include/linux/liveupdate.h                    | 235 +++++
> >  include/linux/shmem_fs.h                      |  23 +
> >  include/uapi/linux/liveupdate.h               | 265 +++++
> >  init/Kconfig                                  |   2 +
> >  kernel/Kconfig.kexec                          |  14 -
> >  kernel/Makefile                               |   2 +-
> >  kernel/liveupdate/Kconfig                     |  90 ++
> >  kernel/liveupdate/Makefile                    |  13 +
> >  kernel/{ =3D> liveupdate}/kexec_handover.c      | 556 +++++-----
> >  kernel/liveupdate/kexec_handover_debug.c      | 222 ++++
> >  kernel/liveupdate/kexec_handover_internal.h   |  45 +
> >  kernel/liveupdate/luo_core.c                  | 525 ++++++++++
> >  kernel/liveupdate/luo_files.c                 | 946 ++++++++++++++++++
> >  kernel/liveupdate/luo_internal.h              |  47 +
> >  kernel/liveupdate/luo_ioctl.c                 | 192 ++++
> >  kernel/liveupdate/luo_selftests.c             | 344 +++++++
> >  kernel/liveupdate/luo_selftests.h             |  84 ++
> >  kernel/liveupdate/luo_subsystems.c            | 420 ++++++++
> >  kernel/liveupdate/luo_sysfs.c                 |  92 ++
> >  kernel/reboot.c                               |   4 +
> >  mm/Makefile                                   |   1 +
> >  mm/internal.h                                 |   6 +
> >  mm/memblock.c                                 |  56 +-
> >  mm/memfd_luo.c                                | 501 ++++++++++
> >  mm/shmem.c                                    |  46 +-
> >  tools/lib/luo/LICENSE                         | 165 +++
> >  tools/lib/luo/Makefile                        |  45 +
> >  tools/lib/luo/README.md                       | 166 +++
> >  tools/lib/luo/cli/.gitignore                  |   1 +
> >  tools/lib/luo/cli/Makefile                    |  18 +
> >  tools/lib/luo/cli/luoctl.c                    | 178 ++++
> >  tools/lib/luo/include/libluo.h                | 128 +++
> >  tools/lib/luo/include/liveupdate.h            | 265 +++++
> >  tools/lib/luo/libluo.c                        | 203 ++++
> >  tools/lib/luo/tests/.gitignore                |   1 +
> >  tools/lib/luo/tests/Makefile                  |  18 +
> >  tools/lib/luo/tests/test.c                    | 848 ++++++++++++++++
> >  tools/testing/selftests/Makefile              |   1 +
> >  tools/testing/selftests/liveupdate/.gitignore |   1 +
> >  tools/testing/selftests/liveupdate/Makefile   |   7 +
> >  tools/testing/selftests/liveupdate/config     |   6 +
> >  .../testing/selftests/liveupdate/liveupdate.c | 356 +++++++
> >  55 files changed, 7091 insertions(+), 415 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-kernel-liveupdate
> >  create mode 100644 Documentation/admin-guide/liveupdate.rst
> >  create mode 100644 Documentation/core-api/liveupdate.rst
> >  create mode 100644 Documentation/mm/memfd_preservation.rst
> >  create mode 100644 Documentation/userspace-api/liveupdate.rst
> >  create mode 100644 include/linux/liveupdate.h
> >  create mode 100644 include/uapi/linux/liveupdate.h
> >  create mode 100644 kernel/liveupdate/Kconfig
> >  create mode 100644 kernel/liveupdate/Makefile
> >  rename kernel/{ =3D> liveupdate}/kexec_handover.c (74%)
> >  create mode 100644 kernel/liveupdate/kexec_handover_debug.c
> >  create mode 100644 kernel/liveupdate/kexec_handover_internal.h
> >  create mode 100644 kernel/liveupdate/luo_core.c
> >  create mode 100644 kernel/liveupdate/luo_files.c
> >  create mode 100644 kernel/liveupdate/luo_internal.h
> >  create mode 100644 kernel/liveupdate/luo_ioctl.c
> >  create mode 100644 kernel/liveupdate/luo_selftests.c
> >  create mode 100644 kernel/liveupdate/luo_selftests.h
> >  create mode 100644 kernel/liveupdate/luo_subsystems.c
> >  create mode 100644 kernel/liveupdate/luo_sysfs.c
> >  create mode 100644 mm/memfd_luo.c
> >  create mode 100644 tools/lib/luo/LICENSE
> >  create mode 100644 tools/lib/luo/Makefile
> >  create mode 100644 tools/lib/luo/README.md
> >  create mode 100644 tools/lib/luo/cli/.gitignore
> >  create mode 100644 tools/lib/luo/cli/Makefile
> >  create mode 100644 tools/lib/luo/cli/luoctl.c
> >  create mode 100644 tools/lib/luo/include/libluo.h
> >  create mode 100644 tools/lib/luo/include/liveupdate.h
> >  create mode 100644 tools/lib/luo/libluo.c
> >  create mode 100644 tools/lib/luo/tests/.gitignore
> >  create mode 100644 tools/lib/luo/tests/Makefile
> >  create mode 100644 tools/lib/luo/tests/test.c
> >  create mode 100644 tools/testing/selftests/liveupdate/.gitignore
> >  create mode 100644 tools/testing/selftests/liveupdate/Makefile
> >  create mode 100644 tools/testing/selftests/liveupdate/config
> >  create mode 100644 tools/testing/selftests/liveupdate/liveupdate.c
> >
> > --
> > 2.50.0.727.gbf7dc18ff4-goog
> >
>
> --
> "Thought is the essence of where you are now."

