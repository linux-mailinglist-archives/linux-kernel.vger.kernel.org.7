Return-Path: <linux-kernel+bounces-751362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE01CB16850
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 23:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5EE95A82D3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536BF1C68A6;
	Wed, 30 Jul 2025 21:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="swtkrXm8"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E671E1A33
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753911288; cv=none; b=i9Sgv9Yu5rHW8phVWUSlKTQlidP8uScpXKuose9KSBjW/HriSSgP8hK2/gkKOT4Lyq6D3J/7HpuLgWv4xoVncLOlGNcHu4cC1Hp+TWClCNJIAmYA+t/bhdK0vwSAXq4AVLLmXlpHanDPhyqhBPuWmRji1bhqYtZAOAzYdC+yhYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753911288; c=relaxed/simple;
	bh=sDR2G1172uhe25DxV0gYE63aiNpaRb4ud1zD/6bxAk0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cWmoj5RBEfiAXddFGQF+uxq9Hhs60huk1aJVkFu0Z9e2EIrkEmh+rg+S2sWhqbhkx7gaIn1dPJ15Sg7UITJHAU3C9oMGhPxjhVRiDjNdEjo9xaYl/js2FyqxL5a38jiEanNjJEUftQ/mq2hLHiGE/CzTYcLtOKAyQKBI0gvQWSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=swtkrXm8; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b26e33ae9d5so241761a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753911285; x=1754516085; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AZoCrmESLbLCViBEraaeQvy8SUfzt9/XLBDROzjvgL4=;
        b=swtkrXm8G9AGxbhYJVhe4bn9gN4MkX6fhwsNM19NeQTXnYNEcsyPtLoCrTfAz6eewF
         2OYOVq86sU+4XiolFUZlQuG+QL49Yzz2l8mrS9psTvIEbhmrliiroYCCDJfZ9n8DGYZd
         SL/xh+o/VCm2I3P1J69oSnd87k7Z0q+MpZm5HAA+D1ud8B4RwRv3/aY8C3deLwfn85WE
         D9uOxh/FyPkmkY79edJevcZ7KC/59AmBqwPC9KqPSJqDqyeZziiYKooWk6bu8Pjd9ES5
         TshYgycGpU7BaOUSf/Gj94YiLBopI66s0zZutJ8u6P34ih8n3igVX0Oo1oCz8q6TYZj0
         xx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753911285; x=1754516085;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZoCrmESLbLCViBEraaeQvy8SUfzt9/XLBDROzjvgL4=;
        b=bRdkNTmP1SQqUPznA9mB14CoZ8v842RG0+aeuRd69NRs2LJUh70fvph2l0Rqbsvpeu
         lEPn/+HIuDXVEsqtz5yRwhzTcgRizRkOA105nMiGCQE9REm/wkvq8hg4nbG9+2NGRujc
         RusFaIFwaLVck3+whVYZ+q8FzbHw2bONkAuK9+q5Q2GW+QVlNJxEH0+Ngu7Sa1fKVxW9
         UZ/FbuwCSeyo/9QCrZk59qF/KW/VGR8x/JheuwGrYx0m4YTJ1ZYoeXrFouZ5HPncJEAT
         31TmO9mC3v8pvSq9U+QD+TWQUDllGkyrXiNAg1w5kpBrjam9kcnL2NjsPXa5d7i3yf+K
         DkvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXppiMqOHGllrpdl4AGvLeD8M82+VPE/1Kjhr49daUd/cu7DHDRM3bvCnfkzV8rVCX7w5pJ4KxsVabJY/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YysYd5JxER5fakADOt52uXHbmUp9Ug/CTxVdL0iysylYU8Fgg49
	i1omRaJfMpEi+LKN3pngp25lSYqpTStt9YQlUOILpXJcz2kniSn0Gv3meR8SWegAYeudN7aN4ez
	O6gkKNBM1MW7Xtc97W35Ai4ZG2Q==
X-Google-Smtp-Source: AGHT+IE166c54Arspc6vUihH1B2IIMOPFqYhg0hEsHJt45VP/+caD/xvYgvBnOUC4GXLoFyR6oHwfyE2Q105ihyuUQ==
X-Received: from pgar7.prod.google.com ([2002:a05:6a02:2e87:b0:b2c:4548:13d0])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7283:b0:23d:bdb7:d9f9 with SMTP id adf61e73a8af0-23dc0ec1d54mr8719397637.31.1753911285429;
 Wed, 30 Jul 2025 14:34:45 -0700 (PDT)
Date: Wed, 30 Jul 2025 14:34:44 -0700
In-Reply-To: <20250729225455.670324-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729225455.670324-1-seanjc@google.com>
Message-ID: <diqzwm7pjrbf.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [PATCH v17 00/24] KVM: Enable mmap() for guest_memfd
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Ira Weiny <ira.weiny@intel.com>, Gavin Shan <gshan@redhat.com>, Shivank Garg <shivankg@amd.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, Tao Chan <chentao@kylinos.cn>, 
	James Houghton <jthoughton@google.com>, Jiaqi Yan <jiaqiyan@google.com>, vannapurve@google.com
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Paolo,
>
> The arm64 patches have been Reviewed-by Marc, and AFAICT the x86 side of
> things is a go.  Barring a screwup on my end, this just needs your approval.
>
> Assuming everything looks good, it'd be helpful to get this into kvm/next
> shortly after rc1.  The x86 Kconfig changes in particular create semantic
> conflicts with in-flight series.
>
>
> Add support for host userspace mapping of guest_memfd-backed memory for VM
> types that do NOT use support KVM_MEMORY_ATTRIBUTE_PRIVATE (which isn't
> precisely the same thing as CoCo VMs, since x86's SEV-MEM and SEV-ES have
> no way to detect private vs. shared).
>
> mmap() support paves the way for several evolving KVM use cases:
>
>  * Allows VMMs like Firecracker to run guests entirely backed by
>    guest_memfd [1]. This provides a unified memory management model for
>    both confidential and non-confidential guests, simplifying VMM design.
>
>  * Enhanced Security via direct map removal: When combined with Patrick's
>    series for direct map removal [2], this provides additional hardening
>    against Spectre-like transient execution attacks by eliminating the
>    need for host kernel direct maps of guest memory.
>
>  * Lays the groundwork for *restricted* mmap() support for guest_memfd-backed
>    memory on CoCo platforms [3] that permit in-place
>    sharing of guest memory with the host.
>
> Based on kvm/queue.
>
> [1] https://github.com/firecracker-microvm/firecracker/tree/feature/secret-hiding
> [2] https://lore.kernel.org/all/20250221160728.1584559-1-roypat@amazon.co.uk
> [3] https://lore.kernel.org/all/20250328153133.3504118-1-tabba@google.com
>
> [...snip...]

With this version, when guest_memfd memory is mmap-ed() and faulted to
userspace, when there's a memory failure, the process does not get a
SIGBUS. Specifically, this selftest fails with "MADV_HWPOISON should
have triggered SIGBUS."

diff --git i/tools/testing/selftests/kvm/guest_memfd_test.c w/tools/testing/selftests/kvm/guest_memfd_test.c
index b86bf89a71e04..70ef75a23bb60 100644
--- i/tools/testing/selftests/kvm/guest_memfd_test.c
+++ w/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -70,6 +70,10 @@ static void test_mmap_supported(int fd, size_t page_size, size_t total_size)
 
 	ret = munmap(mem, total_size);
 	TEST_ASSERT(!ret, "munmap() should succeed.");
+
+	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0,
+			total_size);
+	TEST_ASSERT(!ret, "Truncate the entire file (cleanup) should succeed.");
 }
 
 static sigjmp_buf jmpbuf;
@@ -104,6 +108,47 @@ static void test_fault_overflow(int fd, size_t page_size, size_t total_size)
 
 	ret = munmap(mem, map_size);
 	TEST_ASSERT(!ret, "munmap() should succeed.");
+
+	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0,
+			total_size);
+	TEST_ASSERT(!ret, "Truncate the entire file (cleanup) should succeed.");
+}
+
+static void test_memory_failure(int fd, size_t page_size, size_t total_size)
+{
+	struct sigaction sa_old, sa_new = {
+		.sa_handler = fault_sigbus_handler,
+	};
+	void *memory_failure_addr;
+	char *mem;
+	int ret;
+
+	mem = mmap(NULL, total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	TEST_ASSERT(mem != MAP_FAILED, "mmap() for guest_memfd should succeed.");
+
+	memset(mem, 0xaa, page_size);
+
+	memory_failure_addr = mem + page_size;
+	sigaction(SIGBUS, &sa_new, &sa_old);
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		madvise(memory_failure_addr, page_size, MADV_HWPOISON);
+		TEST_ASSERT(false, "MADV_HWPOISON should have triggered SIGBUS.");
+	}
+	sigaction(SIGBUS, &sa_old, NULL);
+
+	ret = munmap(mem, total_size);
+	TEST_ASSERT(!ret, "munmap() should succeed.");
+
+	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0,
+			total_size);
+	TEST_ASSERT(!ret, "Truncate the entire file (cleanup) should succeed.");
 }
 
 static void test_mmap_not_supported(int fd, size_t page_size, size_t total_size)
@@ -286,6 +331,7 @@ static void test_guest_memfd(unsigned long vm_type)
 	if (flags & GUEST_MEMFD_FLAG_MMAP) {
 		test_mmap_supported(fd, page_size, total_size);
 		test_fault_overflow(fd, page_size, total_size);
+		test_memory_failure(fd, page_size, total_size);
 	} else {
 		test_mmap_not_supported(fd, page_size, total_size);
 	}

Is this by design or should some new memory_failure handling be added?

