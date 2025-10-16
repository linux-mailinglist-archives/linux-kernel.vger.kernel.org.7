Return-Path: <linux-kernel+bounces-856701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B908BE4D85
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007D6586891
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC26221DB4;
	Thu, 16 Oct 2025 17:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bFH8XP4d"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298922045B5
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760635810; cv=none; b=VdU6YFaWjhHYb1CSOCJr0pzSKd6ur8bDsEiYYimCVFlNf1lAvZUziIFsfle1yxfHTVZ55xXmiyxyrKAnBLs5BFtLU+hp94lv3fenFgO4WzXMQlIdpr09DKnQI6qBUTLBYuYZum2c4xVho/s4M6tbT+DUg4jId7aqQTkC5p92lqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760635810; c=relaxed/simple;
	bh=4xC7NbtAYk7ZTEIvkayJzWq9oLb+GOKeL8BAa/1843A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=boqdITDmAXvIF0OtZ3aBdxcqxFQCvYYbBktq0dzMSUBvFC6cw5egkzu4PiZOmx9FM2kbYqqc7YeVKOaSiy7Ghfs3iF9GNmY/GOTLRRM/OO7O6g04ct5pm92oe7NHwSilV4oqU8Ds8QeOQT/okVQG2XvcyVWztCV8KJcBY99sca0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bFH8XP4d; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33ba9047881so1480097a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760635808; x=1761240608; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fw6xiHjKYy4zBKVTH7gEKmT2HMgfZtlJ6SEn7/JK9n0=;
        b=bFH8XP4d1dNAnrNKwcdlgYndsoRd90tdTcPrF8HPuZhxlWn2JrRwLXhSrv2XS+0W03
         0rdx9enYzhZwsKIpABqStjrDSlwDJMmGF3aIePaCOgYCGjVmAchZj+CBt6Thv5qelvYL
         GKsXCwCjWA/co1QmVXhNbQuTtOnwXKL92d0FoQHHZ+g2DW8CoV+N2xvaQB2Fw8/oDZKe
         3IRwq6XBhplbyZPCDkoWosXITUQKKxPKVDeSFhq6zyPSp3sHFCw3MOaUTTAuwfnQVkAt
         QpbfTmc3YSa27zMYcbcDqjClejGH9QnAG//NYk5kvtqkB42sNpK62EieLZLo7VedxZaO
         GyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760635808; x=1761240608;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fw6xiHjKYy4zBKVTH7gEKmT2HMgfZtlJ6SEn7/JK9n0=;
        b=g13c3D/aAUDrNbLP08vqWrf8TpVl3ilExYaILaNa6RRwRfCXzSJBZjLnUXCqsoGHrG
         ozm2aDt4EDvupmik8x0GgACXu3opSErsSc1W0MtcGwcY1QR1R7Iv8M1E1Tud54iMO2VM
         IlTQz5ihSqn5AlePrftPlGD5mYNSPynrR4rDWW+FHUSnlfhLftUahneFN3/GmYJUMpVG
         8cCWDv2mY9p1MdD5nvO1AxGTpMutmY0lwTmTFh+sHioFzOg9j6SJqCQtGB+9b0kKkcqZ
         oPym7Ph5vNkkMDJKVF2NNnvj5zL/Skd7h1rQLuTRmAAx5RObdUk9CSKt5VUHj895/fFc
         e8pg==
X-Forwarded-Encrypted: i=1; AJvYcCUEalHdbsGDaPT5V3Gg6XQdNLh2PTOKclr8dBBGuLm9/dOlZ2hb4KqhSYEYH/jWWBBSX2eP8CyZVjB1JrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbGSi6AbbzSQpU+rJjrvUpBdKvifbxdxEHRFrXsXyBGlxNNEUF
	fQtoS7GSwL2GLAQVV6CNUir5B8rSGkecBTAxXiTcbJ69ndWx7kJhxOWC0eazlUD5bj+BT/utP4H
	KZj5vew==
X-Google-Smtp-Source: AGHT+IEE+9lWsoGbrE1FsDpaiwGYQEz8y5mwph7bonrhgYb3kvgC58w2qMMIJ/4cUT39VkATDSw/u6xjb6I=
X-Received: from pjbpa17.prod.google.com ([2002:a17:90b:2651:b0:33b:51fe:1a8c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f4c:b0:32e:11cc:d17a
 with SMTP id 98e67ed59e1d1-33b9e08ff85mr5705111a91.4.1760635808296; Thu, 16
 Oct 2025 10:30:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 16 Oct 2025 10:28:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251016172853.52451-1-seanjc@google.com>
Subject: [PATCH v13 00/12] KVM: guest_memfd: Add NUMA mempolicy support
From: Sean Christopherson <seanjc@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Shivank Garg <shivankg@amd.com>, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"

Miguel, you got pulled in due to a one-line change to add a new iterator
macros in .clang-format.

Shivank's series to add support for NUMA-aware memory placement in
guest_memfd.  Based on kvm-x86/next.

Note, Ackerley pointed out that we should probably have testing for the
cpuset_do_page_mem_spread() behavior.  I 100% agree, but I'm also a-ok
merging without those tests.

v13:
 - Collect reviews.
 - Add kvm_gmem_for_each_file to .clang-format. [Ackerley]
 - Fix typos. [Ackerley]
 - Don't use get_task_policy() if the guest_memfd doesn't have its own
   policy, so that cpuset_do_page_mem_spread() works. [Ackerley]
 - Fix goofs in the changelogs related to numaif.h. [Ackerley]

v12:
 - https://lore.kernel.org/all/20251007221420.344669-1-seanjc@google.com
 - Add missing functionality to KVM selftests' existing numaif.h instead of
   linking to libnuma (which appears to have caveats with -static).
 - Add KVM_SYSCALL_DEFINE() infrastructure to reduce the boilerplate needed
   to wrap syscalls and/or to assert that a syscall succeeds.
 - Rename kvm_gmem to gmem_file, and use gmem_inode for the inode structure.
 - Track flags in a gmem_inode field instead of using i_private.
 - Add comments to call out subtleties in the mempolicy code (e.g. that
   returning NULL for vm_operations_struct.get_policy() is important for ABI
   reasons).
 - Improve debugability of guest_memfd_test (I kept generating SIGBUS when
   tweaking the tests).
 - Test mbind() with private memory (sadly, verifying placement with
   move_pages() doesn't work due to the dependency on valid page tables).

- V11: Rebase on kvm-next, remove RFC tag, use Ackerley's latest patch
       and fix a rcu race bug during kvm module unload.
- V10: Rebase on top of Fuad's V17. Use latest guest_memfd inode patch
       from Ackerley (with David's review comments). Use newer kmem_cache_create()
       API variant with arg parameter (Vlastimil)
- v9: Rebase on top of Fuad's V13 and incorporate review comments
- v8: Rebase on top of Fuad's V12: Host mmaping for guest_memfd memory.
- v7: Use inodes to store NUMA policy instead of file [0].
- v4-v6: Current approach using shared_policy support and vm_ops (based on
         suggestions from David [1] and guest_memfd bi-weekly upstream
         call discussion [2]).
- v3: Introduced fbind() syscall for VMM memory-placement configuration.
- v1,v2: Extended the KVM_CREATE_GUEST_MEMFD IOCTL to pass mempolicy.

[0] https://lore.kernel.org/all/diqzbjumm167.fsf@ackerleytng-ctop.c.googlers.com
[1] https://lore.kernel.org/all/6fbef654-36e2-4be5-906e-2a648a845278@redhat.com
[2] https://lore.kernel.org/all/2b77e055-98ac-43a1-a7ad-9f9065d7f38f@amd.com

Ackerley Tng (1):
  KVM: guest_memfd: Use guest mem inodes instead of anonymous inodes

Sean Christopherson (7):
  KVM: guest_memfd: Rename "struct kvm_gmem" to "struct gmem_file"
  KVM: guest_memfd: Add macro to iterate over gmem_files for a
    mapping/inode
  KVM: selftests: Define wrappers for common syscalls to assert success
  KVM: selftests: Report stacktraces SIGBUS, SIGSEGV, SIGILL, and SIGFPE
    by default
  KVM: selftests: Add additional equivalents to libnuma APIs in KVM's
    numaif.h
  KVM: selftests: Use proper uAPI headers to pick up mempolicy.h
    definitions
  KVM: guest_memfd: Add gmem_inode.flags field instead of using
    i_private

Shivank Garg (4):
  KVM: guest_memfd: Add slab-allocated inode cache
  KVM: guest_memfd: Enforce NUMA mempolicy using shared policy
  KVM: selftests: Add helpers to probe for NUMA support, and multi-node
    systems
  KVM: selftests: Add guest_memfd tests for mmap and NUMA policy support

 .clang-format                                 |   1 +
 include/uapi/linux/magic.h                    |   1 +
 tools/testing/selftests/kvm/arm64/vgic_irq.c  |   2 +-
 .../testing/selftests/kvm/guest_memfd_test.c  |  98 ++++++
 .../selftests/kvm/include/kvm_syscalls.h      |  81 +++++
 .../testing/selftests/kvm/include/kvm_util.h  |  29 +-
 tools/testing/selftests/kvm/include/numaif.h  | 110 +++---
 .../selftests/kvm/kvm_binary_stats_test.c     |   4 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |  55 +--
 .../kvm/x86/private_mem_conversions_test.c    |   9 +-
 .../selftests/kvm/x86/xapic_ipi_test.c        |   5 +-
 virt/kvm/guest_memfd.c                        | 331 ++++++++++++++----
 virt/kvm/kvm_main.c                           |   7 +-
 virt/kvm/kvm_mm.h                             |   9 +-
 14 files changed, 565 insertions(+), 177 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/kvm_syscalls.h


base-commit: f222788458c8a7753d43befef2769cd282dc008e
-- 
2.51.0.858.gf9c4a03a3a-goog


