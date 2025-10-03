Return-Path: <linux-kernel+bounces-841844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B740DBB8610
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 01:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5ACE34E51B1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 23:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EE4263C8E;
	Fri,  3 Oct 2025 23:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CHQYf0Tq"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7FC27B330
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 23:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759533977; cv=none; b=PKO7xLQ9kLUvzdf+E8rcYjkKK/ISIMRlIupNxPZuFDdV3RfbgGr/bP8XUSPJLijTwjhVixeZ6DnbpLYxMp/y9j/yMZbF2zoRSWBpz+kOjidD9SGnjq/ym+F/6PnsRqFJhLNls/MLFV+FZ/Vcc5l1pTOCpEOlkD7VsRsqrvbny2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759533977; c=relaxed/simple;
	bh=cBSCbLGuyu0i+pnnFJtW9XyUg/AWI2CO30mF/qWuptw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FaU1vSwzSxhABh7viB+qw+KstGB39OxOEFbHPRj43x6lSr31x0oTMMOT5YX3CnFfjgJb5ghIMM7cUhWLQZ++8fTLyH8KT7uMXM35T+orrIxFK5+TqOvy0WYsKHdrIMI+jDP7Z7gg9EThkQgdlwj5Nt/tnklz+anYLFfuNQpaBqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CHQYf0Tq; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2699ebc0319so28791565ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 16:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759533975; x=1760138775; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=a+1Sii0G7hC5FMVOBHLi5jl/sMVLEnhBfdq+sbGC028=;
        b=CHQYf0TqTZQI5I5kXp73C2fng2vjg6GDQWfALKXP3ep2AQFKRw2kyzO/NHnd3B4m09
         DlOye0CDH5hs/q2W17YvzWiWhChvjdU0JCxXOxIhMKVxO9afzmribIgthk4+5P1L3wiY
         7ifN7TctI6y+IfV5/25DarjHo24bi+CuGkgsG4lb7w35ZlZQf0ima8Ls0al0U1fjqVYt
         2Y+kBO1Bu1PpAu3Vv4AOKLnrHe03SeSoo+TZjU5pZ0JzoYqyPQRsAEdF56q9AglFD16A
         s/jTJXZrpFSur5GgmNWjQxQPPmq+xKO1Ws+3RICoky7g/eMExOIxC84ydURmOZ4z2eU6
         gOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759533975; x=1760138775;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a+1Sii0G7hC5FMVOBHLi5jl/sMVLEnhBfdq+sbGC028=;
        b=mtzD661e5euJwMUxO1Oxa0/CAV9Ilk/K+9Dzd8o6JZXBehiOh+boNQ8gfCUH71SbmC
         ZhQWBCsEsLnjUysAe6IxPDT3j3yDXbora45p9NCnfg7PfgmMNu4HW+3ncJji6SLezPT+
         unKpWpYy+USITwrQIufXHO82sV8yC3BC1JO2zWhmLOGKhpq5jnh2J/fckOL1y3w6RGFa
         /MrZwggm5GGoXfoETi6oaaevzfgbZWufu0hdez73KRs6/EWzCGtusePdOO+IhRihy1JB
         3C4so5hEz/xK9aEM5+2yzhy1f0tItAptiUldLT+sMD5lB52HqJm6qaA0gOf4TnwztgPp
         6tJw==
X-Forwarded-Encrypted: i=1; AJvYcCXVtW/2EzJKl0mgeqLx59BVE48GarqV0e7Wh+mxbkk0Xa2QhquKzWvDaDRgP+DTqCSXMfUyo1wdrrnaHMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzniFqBZSs+u/bjjDq7CL81a2BENP59+BHH1zgLW6V+BlnXR/M
	8DpkCA4VArDi8ZhTiREPnjwyov8lsuLGcxJXE4no+rw37QJ7gHNjhNERFe8gpYrDbYOfyXqIjas
	aClPeSg==
X-Google-Smtp-Source: AGHT+IG79/9POvgYVBzEf8BKcEg3XVerQtIRac7iIPaoy9Au32zTuew6jnYHjJjthe8oCk/nymcslvQyqis=
X-Received: from plpj14.prod.google.com ([2002:a17:903:3d8e:b0:269:7d7a:40c4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c0c:b0:269:8edf:67f8
 with SMTP id d9443c01a7336-28e9a6646dbmr53564545ad.52.1759533974981; Fri, 03
 Oct 2025 16:26:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  3 Oct 2025 16:25:54 -0700
In-Reply-To: <20251003232606.4070510-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003232606.4070510-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003232606.4070510-2-seanjc@google.com>
Subject: [PATCH v2 01/13] KVM: Rework KVM_CAP_GUEST_MEMFD_MMAP into KVM_CAP_GUEST_MEMFD_FLAGS
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Rework the not-yet-released KVM_CAP_GUEST_MEMFD_MMAP into a more generic
KVM_CAP_GUEST_MEMFD_FLAGS capability so that adding new flags doesn't
require a new capability, and so that developers aren't tempted to bundle
multiple flags into a single capability.

Note, kvm_vm_ioctl_check_extension_generic() can only return a 32-bit
value, but that limitation can be easily circumvented by adding e.g.
KVM_CAP_GUEST_MEMFD_FLAGS2 in the unlikely event guest_memfd supports more
than 32 flags.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 Documentation/virt/kvm/api.rst                 | 10 +++++++---
 include/uapi/linux/kvm.h                       |  2 +-
 tools/testing/selftests/kvm/guest_memfd_test.c | 13 ++++++-------
 virt/kvm/kvm_main.c                            |  7 +++++--
 4 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 6ae24c5ca559..7ba92f2ced38 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6432,9 +6432,13 @@ most one mapping per page, i.e. binding multiple memory regions to a single
 guest_memfd range is not allowed (any number of memory regions can be bound to
 a single guest_memfd file, but the bound ranges must not overlap).
 
-When the capability KVM_CAP_GUEST_MEMFD_MMAP is supported, the 'flags' field
-supports GUEST_MEMFD_FLAG_MMAP.  Setting this flag on guest_memfd creation
-enables mmap() and faulting of guest_memfd memory to host userspace.
+The capability KVM_CAP_GUEST_MEMFD_FLAGS enumerates the `flags` that can be
+specified via KVM_CREATE_GUEST_MEMFD.  Currently defined flags:
+
+  ============================ ================================================
+  GUEST_MEMFD_FLAG_MMAP        Enable using mmap() on the guest_memfd file
+                               descriptor.
+  ============================ ================================================
 
 When the KVM MMU performs a PFN lookup to service a guest fault and the backing
 guest_memfd has the GUEST_MEMFD_FLAG_MMAP set, then the fault will always be
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 6efa98a57ec1..b1d52d0c56ec 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -962,7 +962,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_ARM_EL2_E2H0 241
 #define KVM_CAP_RISCV_MP_STATE_RESET 242
 #define KVM_CAP_ARM_CACHEABLE_PFNMAP_SUPPORTED 243
-#define KVM_CAP_GUEST_MEMFD_MMAP 244
+#define KVM_CAP_GUEST_MEMFD_FLAGS 244
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index b3ca6737f304..3e58bd496104 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -262,19 +262,17 @@ static void test_guest_memfd_flags(struct kvm_vm *vm, uint64_t valid_flags)
 
 static void test_guest_memfd(unsigned long vm_type)
 {
-	uint64_t flags = 0;
 	struct kvm_vm *vm;
 	size_t total_size;
 	size_t page_size;
+	uint64_t flags;
 	int fd;
 
 	page_size = getpagesize();
 	total_size = page_size * 4;
 
 	vm = vm_create_barebones_type(vm_type);
-
-	if (vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_MMAP))
-		flags |= GUEST_MEMFD_FLAG_MMAP;
+	flags = vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS);
 
 	test_create_guest_memfd_multiple(vm);
 	test_create_guest_memfd_invalid_sizes(vm, flags, page_size);
@@ -328,13 +326,14 @@ static void test_guest_memfd_guest(void)
 	size_t size;
 	int fd, i;
 
-	if (!kvm_has_cap(KVM_CAP_GUEST_MEMFD_MMAP))
+	if (!kvm_check_cap(KVM_CAP_GUEST_MEMFD_FLAGS))
 		return;
 
 	vm = __vm_create_shape_with_one_vcpu(VM_SHAPE_DEFAULT, &vcpu, 1, guest_code);
 
-	TEST_ASSERT(vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_MMAP),
-		    "Default VM type should always support guest_memfd mmap()");
+	TEST_ASSERT(vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS) & GUEST_MEMFD_FLAG_MMAP,
+		    "Default VM type should support MMAP, supported flags = 0x%x",
+		    vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS));
 
 	size = vm->page_size;
 	fd = vm_create_guest_memfd(vm, size, GUEST_MEMFD_FLAG_MMAP);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 226faeaa8e56..e3a268757621 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4928,8 +4928,11 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 #ifdef CONFIG_KVM_GUEST_MEMFD
 	case KVM_CAP_GUEST_MEMFD:
 		return 1;
-	case KVM_CAP_GUEST_MEMFD_MMAP:
-		return !kvm || kvm_arch_supports_gmem_mmap(kvm);
+	case KVM_CAP_GUEST_MEMFD_FLAGS:
+		if (!kvm || kvm_arch_supports_gmem_mmap(kvm))
+			return GUEST_MEMFD_FLAG_MMAP;
+
+		return 0;
 #endif
 	default:
 		break;
-- 
2.51.0.618.g983fd99d29-goog


