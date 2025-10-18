Return-Path: <linux-kernel+bounces-859245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CD9BED1D3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 16:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D795C4033BD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 14:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E662D661E;
	Sat, 18 Oct 2025 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sc40sQdv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193FE155C87
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760799342; cv=none; b=MHpuxRxFvnHaddCx9qOfIpsdcc+XtMFV982pELofqvtUpgsBcqU+ugWPRNXZaI7JkuN9kXuG6sESUcnDJf4w5bT1LvdceVjwHAr46IbazqKbSIoKHB4h6MNHp9/ryYIPuARyUYdU7eQY53705nkXonR1HIkxF6TKhjOI0TYYiAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760799342; c=relaxed/simple;
	bh=mLT2lbG3kXFkLie+we3VKqkPSWvx88i/kwFOpGyYazw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TAz/6Vk0KU/P6AkGVDaIb+0bFPErl0LItOKh0JO3oPIb296AeZ1eI3ghs/w3ovMORqefvJib6xoT9/zjElTTSYr+RmNOJ6+roH1B7si84ed3HhiBbqLhDukB2dT42SnllxYDaBuNteMu2fjPQU8rgGYB2KmG85APArLPvxc6Wj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sc40sQdv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760799338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r3aMuDzlSq6Jt3ItJ/z+zpBUl7GppMDUpf+VOUN8H78=;
	b=Sc40sQdvQ+sx6kEzLd+aAXkHikn2hWN0BruR1MGcY/ZiYAD6aIktU7xveAefCOv+wCzZ7o
	3XIfa23ohRq4TC6EREge8QuDxIUX3e/TP0vVJxoOVqWrVtuvTRNNdoBreIoFx0c3jT061P
	rHcPR9VZAwIvL26EF33aqngrdP4tztM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-4Lt0ueX7MaGr2NkhE92rWg-1; Sat, 18 Oct 2025 10:55:36 -0400
X-MC-Unique: 4Lt0ueX7MaGr2NkhE92rWg-1
X-Mimecast-MFC-AGG-ID: 4Lt0ueX7MaGr2NkhE92rWg_1760799336
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47105bfcf15so17085275e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 07:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760799335; x=1761404135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r3aMuDzlSq6Jt3ItJ/z+zpBUl7GppMDUpf+VOUN8H78=;
        b=QP6snMuo9+Qce+JMdNRqmQzAzZxTLaWwcERfe4Wh32/QNzTCSxrJGgP4eE5mvAMKEU
         3EQxXTCI4iDKblx9PxuyUSJiZy6WXroZxnXyBsCrcHxO2kKvH6n8VpdT5BUogxJt/7yY
         vj29JAJf6oC0m5g9R8Us5PEWa+J7jiGDE2+5impbG8ryokpnAABsjzqM+EJowiJxqruX
         N2znRXgZPzcIZHIeQFcLebD31yJDtmg+NMT1iMXbcSYe8kztQDCST4RJxJmHYMvgZnec
         9HRHW1aXEIqUzXW5c1RfyLm6SOqJg/z7MUPz/fNbsb72T39U2n23ufjSq5Mpef9jwea6
         wdFg==
X-Gm-Message-State: AOJu0YwEF/AgJOI0YEpZwpNsLz/v2oZTbjO7df2i02piGlEtEQ61pUht
	54d+4gdk0QZ+rb38+uEF9GtPqXs4BfE6AQl4ia1oJBW8nd0z5qm7aHM9bHQDkgSTHYxKK8H5pp+
	CSJj+iWsFK26sAXhdoK/5Jj1cY5vegWVGqaMJF5tCzPxyfuAN8yfP1fs2RpnyHVAh+YE5s99VTg
	==
X-Gm-Gg: ASbGncuq+mtO4zXIQkYU6fSyrKDCaor0hNxbFbeupHwKTBOm/6ExwDKD4R7eNg7bzK9
	UmbuacjcCaJvDag5RK2rVHam9Ns5T6LP1P/T1SbuFsHMIZuGimqJrYig4yl2z9KMswQqpVZ+eq0
	h0jBnEG4GdRBPXvIfw4md3xD11d8RkpqmzhlLwK62CPe222H2pUQZbbS8d8yUi2I+mCBSk4IEOF
	u/du4XZiCrbnTDo3mgFiQxWPX6XxfpE9x9a1gpRLxTYjo5gv0JBSA/csqnXI/6gTfWx+HkaIMNy
	m51L5PBQ6Dc4xN0pavbl+2gqIlGIg1iEvfdsKuvMSCXg8m4dwe6j97GNE9KipAB0XZkMg/x5lSl
	a6SgnsAy2d74VunH4RDw9NtjY2pxIs2rfW1AYtw7OYfG9ocMVttYF31Y6oP1bCeSNhHWOWb458T
	/ATQ==
X-Received: by 2002:a05:600c:3b8d:b0:45d:f81d:eae7 with SMTP id 5b1f17b1804b1-471179176b9mr64820565e9.28.1760799335130;
        Sat, 18 Oct 2025 07:55:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH47C36StXNWXNVVjTZAihBvDIuXxzpw7R06UIDl2EkcoUsBSekmigElF3XqcAT20jxeHWlDQ==
X-Received: by 2002:a05:600c:3b8d:b0:45d:f81d:eae7 with SMTP id 5b1f17b1804b1-471179176b9mr64820425e9.28.1760799334644;
        Sat, 18 Oct 2025 07:55:34 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471556e17afsm48295675e9.17.2025.10.18.07.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 07:55:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	maz@kernel.org,
	seanjc@google.com
Subject: [GIT PULL] KVM fixes for Linux 6.18-rc2
Date: Sat, 18 Oct 2025 16:55:32 +0200
Message-ID: <20251018145533.2072927-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 4361f5aa8bfcecbab3fc8db987482b9e08115a6a:

  Merge tag 'kvm-x86-fixes-6.18-rc2' of https://github.com/kvm-x86/linux into HEAD (2025-10-18 10:25:43 +0200)

For the most part, these are fixes and tests for either Arm or guest_memfd.

----------------------------------------------------------------
ARM:

- Fix the handling of ZCR_EL2 in NV VMs

- Pick the correct translation regime when doing a PTW on
  the back of a SEA

- Prevent userspace from injecting an event into a vcpu that isn't
  initialised yet

- Move timer save/restore to the sysreg handling code, fixing EL2 timer
  access in the process

- Add FGT-based trapping of MDSCR_EL1 to reduce the overhead of debug

- Fix trapping configuration when the host isn't GICv3

- Improve the detection of HCR_EL2.E2H being RES1

- Drop a spurious 'break' statement in the S1 PTW

- Don't try to access SPE when owned by EL3

Documentation updates:

- Document the failure modes of event injection

- Document that a GICv3 guest can be created on a GICv5 host
  with FEAT_GCIE_LEGACY

Selftest improvements:

- Add a selftest for the effective value of HCR_EL2.AMO

- Address build warning in the timer selftest when building with clang

- Teach irqfd selftests about non-x86 architectures

- Add missing sysregs to the set_id_regs selftest

- Fix vcpu allocation in the vgic_lpi_stress selftest

- Correctly enable interrupts in the vgic_lpi_stress selftest

x86:

- Expand the KVM_PRE_FAULT_MEMORY selftest to add a regression test for the
  bug fixed by commit 3ccbf6f47098 ("KVM: x86/mmu: Return -EAGAIN if userspace
  deletes/moves memslot during prefault")

- Don't try to get PMU capabilities from perf when running a CPU with hybrid
  CPUs/PMUs, as perf will rightly WARN.

guest_memfd:

- Rework KVM_CAP_GUEST_MEMFD_MMAP (newly introduced in 6.18) into a more
  generic KVM_CAP_GUEST_MEMFD_FLAGS

- Add a guest_memfd INIT_SHARED flag and require userspace to explicitly set
  said flag to initialize memory as SHARED, irrespective of MMAP.  The
  behavior merged in 6.18 is that enabling mmap() implicitly initializes
  memory as SHARED, which would result in an ABI collision for x86 CoCo VMs
  as their memory is currently always initialized PRIVATE.

- Allow mmap() on guest_memfd for x86 CoCo VMs, i.e. on VMs with private
  memory, to enable testing such setups, i.e. to hopefully flush out any
  other lurking ABI issues before 6.18 is officially released.

- Add testcases to the guest_memfd selftest to cover guest_memfd without MMAP,
  and host userspace accesses to mmap()'d private memory.

----------------------------------------------------------------
Ackerley Tng (1):
      KVM: selftests: Add test coverage for guest_memfd without GUEST_MEMFD_FLAG_MMAP

Dapeng Mi (1):
      KVM: x86/pmu: Don't try to get perf capabilities for hybrid CPUs

Marc Zyngier (15):
      KVM: arm64: nv: Don't advance PC when pending an SVE exception
      KVM: arm64: Hide CNTHV_*_EL2 from userspace for nVHE guests
      KVM: arm64: Introduce timer_context_to_vcpu() helper
      KVM: arm64: Replace timer context vcpu pointer with timer_id
      KVM: arm64: Make timer_set_offset() generally accessible
      KVM: arm64: Add timer UAPI workaround to sysreg infrastructure
      KVM: arm64: Move CNT*_CTL_EL0 userspace accessors to generic infrastructure
      KVM: arm64: Move CNT*_CVAL_EL0 userspace accessors to generic infrastructure
      KVM: arm64: Move CNT*CT_EL0 userspace accessors to generic infrastructure
      KVM: arm64: Fix WFxT handling of nested virt
      KVM: arm64: Kill leftovers of ad-hoc timer userspace access
      KVM: arm64: selftests: Make dependencies on VHE-specific registers explicit
      KVM: arm64: selftests: Add an E2H=0-specific configuration to get_reg_list
      KVM: arm64: selftests: Fix misleading comment about virtual timer encoding
      arm64: Revamp HCR_EL2.E2H RES1 detection

Mukesh Ojha (1):
      KVM: arm64: Guard PMSCR_EL1 initialization with SPE presence check

Oliver Upton (9):
      KVM: arm64: nv: Don't treat ZCR_EL2 as a 'mapped' register
      KVM: arm64: Use the in-context stage-1 in __kvm_find_s1_desc_level()
      KVM: arm64: selftests: Test effective value of HCR_EL2.AMO
      KVM: arm64: Prevent access to vCPU events before init
      KVM: arm64: Document vCPU event ioctls as requiring init'ed vCPU
      KVM: selftests: Fix irqfd_test for non-x86 architectures
      KVM: arm64: selftests: Actually enable IRQs in vgic_lpi_stress
      KVM: arm64: Compute per-vCPU FGTs at vcpu_load()
      KVM: arm64: nv: Use FGT write trap of MDSCR_EL1 when available

Osama Abdelkader (1):
      KVM: arm64: Remove unreachable break after return

Paolo Bonzini (2):
      Merge tag 'kvmarm-fixes-6.18-1' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD
      Merge tag 'kvm-x86-fixes-6.18-rc2' of https://github.com/kvm-x86/linux into HEAD

Sascha Bischoff (2):
      KVM: arm64: gic-v3: Only set ICH_HCR traps for v2-on-v3 or v3 guests
      Documentation: KVM: Update GICv3 docs for GICv5 hosts

Sean Christopherson (13):
      KVM: Rework KVM_CAP_GUEST_MEMFD_MMAP into KVM_CAP_GUEST_MEMFD_FLAGS
      KVM: guest_memfd: Add INIT_SHARED flag, reject user page faults if not set
      KVM: guest_memfd: Invalidate SHARED GPAs if gmem supports INIT_SHARED
      KVM: Explicitly mark KVM_GUEST_MEMFD as depending on KVM_GENERIC_MMU_NOTIFIER
      KVM: guest_memfd: Allow mmap() on guest_memfd for x86 VMs with private memory
      KVM: selftests: Stash the host page size in a global in the guest_memfd test
      KVM: selftests: Create a new guest_memfd for each testcase
      KVM: selftests: Add wrappers for mmap() and munmap() to assert success
      KVM: selftests: Isolate the guest_memfd Copy-on-Write negative testcase
      KVM: selftests: Add wrapper macro to handle and assert on expected SIGBUS
      KVM: selftests: Verify that faulting in private guest_memfd memory fails
      KVM: selftests: Verify that reads to inaccessible guest_memfd VMAs SIGBUS
      KVM: arm64: selftests: Track width of timer counter as "int", not "uint64_t"

Yan Zhao (1):
      KVM: selftests: Test prefault memory during concurrent memslot removal

Zenghui Yu (2):
      KVM: arm64: selftests: Sync ID_AA64PFR1, MPIDR, CLIDR in guest
      KVM: arm64: selftests: Allocate vcpus with correct size

 Documentation/virt/kvm/api.rst                     |  20 ++-
 Documentation/virt/kvm/devices/arm-vgic-v3.rst     |   3 +-
 arch/arm64/include/asm/el2_setup.h                 |  38 ++++-
 arch/arm64/include/asm/kvm_host.h                  |  50 ++++++
 arch/arm64/kvm/arch_timer.c                        | 105 ++-----------
 arch/arm64/kvm/arm.c                               |   7 +
 arch/arm64/kvm/at.c                                |   7 +-
 arch/arm64/kvm/config.c                            |  90 +++++++++++
 arch/arm64/kvm/debug.c                             |  15 +-
 arch/arm64/kvm/guest.c                             |  70 ---------
 arch/arm64/kvm/handle_exit.c                       |   7 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h            | 148 ++----------------
 arch/arm64/kvm/hyp/nvhe/pkvm.c                     |   1 +
 arch/arm64/kvm/nested.c                            |   9 +-
 arch/arm64/kvm/sys_regs.c                          | 131 ++++++++++++----
 arch/arm64/kvm/sys_regs.h                          |   6 +
 arch/arm64/kvm/vgic/vgic-v3.c                      |   5 +-
 arch/x86/kvm/pmu.c                                 |   8 +-
 arch/x86/kvm/x86.c                                 |   7 +-
 include/kvm/arm_arch_timer.h                       |  24 ++-
 include/linux/kvm_host.h                           |  12 +-
 include/uapi/linux/kvm.h                           |   5 +-
 .../selftests/kvm/arm64/arch_timer_edge_cases.c    |   2 +-
 .../testing/selftests/kvm/arm64/external_aborts.c  |  43 ++++++
 tools/testing/selftests/kvm/arm64/get-reg-list.c   |  99 +++++++++++-
 tools/testing/selftests/kvm/arm64/set_id_regs.c    |   3 +
 .../testing/selftests/kvm/arm64/vgic_lpi_stress.c  |   3 +-
 tools/testing/selftests/kvm/guest_memfd_test.c     | 171 +++++++++++----------
 .../selftests/kvm/include/arm64/processor.h        |  12 +-
 tools/testing/selftests/kvm/include/kvm_util.h     |  27 ++++
 tools/testing/selftests/kvm/include/test_util.h    |  19 +++
 tools/testing/selftests/kvm/irqfd_test.c           |  14 +-
 tools/testing/selftests/kvm/lib/arm64/processor.c  |   5 +
 tools/testing/selftests/kvm/lib/kvm_util.c         |  49 +++---
 tools/testing/selftests/kvm/lib/s390/processor.c   |   5 +
 tools/testing/selftests/kvm/lib/test_util.c        |   7 +
 tools/testing/selftests/kvm/lib/x86/processor.c    |   5 +
 tools/testing/selftests/kvm/mmu_stress_test.c      |   5 +-
 .../testing/selftests/kvm/pre_fault_memory_test.c  | 131 ++++++++++++++--
 tools/testing/selftests/kvm/s390/ucontrol_test.c   |  16 +-
 .../testing/selftests/kvm/set_memory_region_test.c |  17 +-
 virt/kvm/Kconfig                                   |   1 +
 virt/kvm/guest_memfd.c                             |  75 +++++----
 virt/kvm/kvm_main.c                                |   4 +-
 44 files changed, 941 insertions(+), 540 deletions(-)


