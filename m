Return-Path: <linux-kernel+bounces-844808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C74DBC2D3A
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 00:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F41284E6954
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 22:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157AC258EE9;
	Tue,  7 Oct 2025 22:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F53AmsX8"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1D623AE62
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 22:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759875279; cv=none; b=uJosGLECC/xL3r2dQAsjE3DXRu0wjCQZp13Y+la8etZ0ZFlsA3mClaqMSDUqgmUslu8RscsokWASsgTce8W96GiG81pPgk1pSs6SBHlKBwItpl533oYACcmz3Jn9Dak1oC8KDVrJ9F/KXMmbgh5aj2gTjz0HsLEtcX6ScfNaQ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759875279; c=relaxed/simple;
	bh=CdKM1gl6kIjyxS8EkDKIGKQsLnoRGhN4OqsunPcs93Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=n48xb22WOLDUnQ+JGchyQ6CQkRzmAWX6eqCzf8QMl88z9wf+h4yPwaD9Tib7NeU+8hv35DKbkIFX2nvHTRwMdkeN3oe2TLGY1W2mewde6BklQ/TUmwgC4Isqog0Rrzd6Q3hvNA/NylrDbG9GCFUhzHvJEKMZEK17A9KOQBZttdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F53AmsX8; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2698b5fbe5bso81561085ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 15:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759875277; x=1760480077; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmMr+35oqSfmP0HZIXQIA/YFMO4f30/qn0vmxY19vhg=;
        b=F53AmsX8BmbnykYzoL170PZULIMTfP3oStr3Y+6eZ18h3gallRSDnizxQ0EVFlgNnP
         uA3/+vwGc6OrQEVayzohPOicBsriHIhrc8g2r5oVp8Pu5rcvFzyASVfNE84guZKUwAsS
         UAfSA3veSihSL/sicviP7pu8QLu6jK4G9bslGDcW6GgsAX+ADdkjUEU6MWPdk+9YViJ4
         xv8nX/J6j7dxT1B/ag6RvIbrnDY9QZn9bEFYh3sGIB0mnhHOwMV2AO2wZ83noR9JZtJJ
         0aL8XohCTOwDw32m1I1EIzWBoZx4Eg7xRBLBqB8qcHMWpUw1DPfeCGtnF4ZWb4qm3+Cw
         Hz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759875277; x=1760480077;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TmMr+35oqSfmP0HZIXQIA/YFMO4f30/qn0vmxY19vhg=;
        b=udL42kIbepIkB8zkb7kIFkrl27FwCu1BHsw0DmE//aGxqxwEbULin4Nk9xk4DV0QNO
         0lJnEPob8KgHczNoUWJ9H0X+QwhSuQ7xjSu5+rxFJtluC2sEFqrXUB30LGF5HBgk8lhF
         KCJHuoloCIJAsoqvlLFety63n/ppeGbatd3/E7vNV9VJqzXRcnW/rvdramtpVHiI0jK0
         ciQCpmjaM7cwPI64s3CzcMFt1qXXomkJUHStSbqsHtDMA7RY8aL3r/NKlxoyW8l+Cvy4
         oYdZqdh8GgxKBjvP8re+qfDtfmDQFBVkVItMYZj/mSsLbQivXqnxOe3bZHd+IDRLGlo8
         0+uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZxQfYwWDXlynviJ97DRk+4uw8vVOjIb935iGDvbj1JR5Hx5XfUxf8lzWLKJax1shWT78mX1q/3BW3L6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkAv6l8EiGZMFoDp1Ex49X5QHKqvrxNk0V/KOJvYx+0ylfjlPR
	URK2Ai+80Iov4+JaJ+TPAjIBoxJmaMrLj2lV4SRSs+EMCvTZ3KQ1YNkO+KO1ZyxVJ18QeFKkXVz
	GcC29Sw==
X-Google-Smtp-Source: AGHT+IH40/3oJtT6BLYIY8yrwnu2Bd+0rWeu7YkPyebNcu0Zon9xu4JQyWq3gycTlYxIm/ZLLZj531D/TW0=
X-Received: from pldb2.prod.google.com ([2002:a17:902:ed02:b0:24c:cd65:485c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2350:b0:274:aab9:4ed4
 with SMTP id d9443c01a7336-29027312ffamr15750085ad.57.1759875277026; Tue, 07
 Oct 2025 15:14:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  7 Oct 2025 15:14:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251007221420.344669-1-seanjc@google.com>
Subject: [PATCH v12 00/12] KVM: guest_memfd: Add NUMA mempolicy support
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"

Shivank's series to add support for NUMA-aware memory placement in
guest_memfd.  This is based on:

  https://github.com/kvm-x86/linux.git gmem

which is an unstable topic branch that contains the guest_memfd MMAP fixes
destined for 6.18 (to avoid conflicts), and three non-KVM changes related to
mempolicy that were in previous versions of this series (I want to keep this
version KVM focused, and AFAICT there is nothing left to discuss in the prep
paches).

Once 6.18-rc1 is cut I'll turn "gmem" into a proper topic branch, rebase it,
and freeze the hashes.

v12:
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

 include/uapi/linux/magic.h                    |   1 +
 tools/testing/selftests/kvm/arm64/vgic_irq.c  |   2 +-
 .../testing/selftests/kvm/guest_memfd_test.c  |  98 +++++
 .../selftests/kvm/include/kvm_syscalls.h      |  81 +++++
 .../testing/selftests/kvm/include/kvm_util.h  |  29 +-
 tools/testing/selftests/kvm/include/numaif.h  | 110 +++---
 .../selftests/kvm/kvm_binary_stats_test.c     |   4 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |  55 +--
 .../kvm/x86/private_mem_conversions_test.c    |   9 +-
 .../selftests/kvm/x86/xapic_ipi_test.c        |   5 +-
 virt/kvm/guest_memfd.c                        | 344 ++++++++++++++----
 virt/kvm/kvm_main.c                           |   7 +-
 virt/kvm/kvm_mm.h                             |   9 +-
 13 files changed, 576 insertions(+), 178 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/kvm_syscalls.h


base-commit: 67033eaa5ea2cb67b6cdaa91d7f5c42bfafb36f7
-- 
2.51.0.710.ga91ca5db03-goog


