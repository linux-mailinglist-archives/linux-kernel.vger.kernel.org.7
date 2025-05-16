Return-Path: <linux-kernel+bounces-651997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C63ABA596
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 23:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537BB1C024AA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 21:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E2828002D;
	Fri, 16 May 2025 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HDCY8peW"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B338280A4F
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 21:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747432473; cv=none; b=qIm0nmEAr3ESzTQweKk9SA7zp331Bc9xS7UCyQ261SPst5mGVeF6WBARjATm5JIf791UiKeEPUOXzqiOwalCBbG3kQYzSscofY5aGNLyY7IpK8KI9NIE+mqdzDgmnfdKJ4AUOF1TDZEKGueyIO76fPF39E4CcjbnYdNo6m8oqT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747432473; c=relaxed/simple;
	bh=b8X+SZETCA+/r2QlXODqiqz30AodXiz4FkatNip2IL4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MqhQV/k5pNXKqr/VsL6DpSkjHZKx55BrzzsYqqJaQkHy1IuluDxgo2DdrlSlziFbCJmTsXVUj6kNDZD1T/RNcuyoCEWDgiXh4ndB+6Nj+1A/z311yj6428YWqqQMcibwhhx558y2rvVNnDiPNZOnehbsVOKLTxg05EftCLVHOaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HDCY8peW; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7394772635dso1832838b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 14:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747432471; x=1748037271; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=he9wiLV5uZ6/m/Ubi4LHJ7N+Onl68GiZAuqObi6fPYU=;
        b=HDCY8peWj93g5yHjAtIF5tcgJPVRrOv2O1aYUHlgcaAyxJfo9tfvg1kKgJhdNT+/el
         iOzgjlFiDVnUg5tJEYHF8hlX2jSMeptEidk7p4BBMtJixj+8OLQD1bi4mr46sJvT34+k
         4BV9ebfvDF5k9lUi/VzqwXSbd27bw3yeHVzwvIoObMtjQ/G0mlvM8RaESwg/4cFgCPES
         mpmCowv6ewqTnKVIJGM9uiCPtHrWWm6NCElVUNPyx4esluYq+K86qjmOnkiIP1WjnR4k
         FYDGU0b+Xtqgc8y7utEN6nPEOATGPUQhdy9+ylDh2xK1ReFYQLjIln569g2amGI7xvVF
         ifyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747432471; x=1748037271;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=he9wiLV5uZ6/m/Ubi4LHJ7N+Onl68GiZAuqObi6fPYU=;
        b=WzXcBjKMfmdj0+TEq7P6w5/povWv8ukuHKE9Cv2bUuFHBmoRaX5vpy1G/0/pKkzdoO
         ySXrNyl/alJPEgvVyb9pM1s4FMMMbiYCXpXtdAFhdO8+GDKxTwd9l8iP9rCMflfbWDml
         xEUhj07qV4CKSJEJyFOkFvfO72OyU0FBFl+Fjng6gi+H4wJ77IlQv/5NfKveJL9elj9p
         +VHfTl/Rd6/auRe7PtGcGNNTmiyUiV05MsKjIY/4HH6T8X6cA2eLfvAptv9le+0g/wvO
         Ap6WcE5nX9BsGpou3Do6jfIh7ZtXT08D2F0ie/Hd7yMpEzYJGP4VEFSqTE+v1bm1TqJJ
         sX7g==
X-Forwarded-Encrypted: i=1; AJvYcCU/erDGw84KlVMLoLt/1vHVlF/KvldrMT7VukRu7P2dq1sfiMJdJdutr2Oss1FN/hUnBx+Sj2VQESVfbwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ2kPEF2ILX62MrUl1YVulXqsxfcxO3+5eumQRhtHJabTM8nw4
	xz7ConqsnJwwnbkmLymzdDlR5BvSWeEMadZyDe88YNBL2BStjDR8x5YBSj4bs4BRGDieruR9Ibk
	+SjctMg==
X-Google-Smtp-Source: AGHT+IFvdwjKVnl8oB8hg8sThG1n7Y/nnlVTgBb2yxJZPjq66baQbtmAXviN6UxG+4eozQyHW/ONPWfBnpk=
X-Received: from pfbhe16.prod.google.com ([2002:a05:6a00:6610:b0:730:90b2:dab])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1591:b0:1f1:432:f4a3
 with SMTP id adf61e73a8af0-2170ccb2dccmr6280425637.23.1747432471453; Fri, 16
 May 2025 14:54:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 16 May 2025 14:54:20 -0700
In-Reply-To: <20250516215422.2550669-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250516215422.2550669-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <20250516215422.2550669-2-seanjc@google.com>
Subject: [PATCH v3 1/3] KVM: x86/mmu: Dynamically allocate shadow MMU's hashed
 page list
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Dynamically allocate the (massive) array of hashed lists used to track
shadow pages, as the array itself is 32KiB, i.e. is an order-3 allocation
all on its own, and is *exactly* an order-3 allocation.  Dynamically
allocating the array will allow allocating "struct kvm" using kvmalloc(),
and will also allow deferring allocation of the array until it's actually
needed, i.e. until the first shadow root is allocated.

Opportunistically use kvmalloc() for the hashed lists, as an order-3
allocation is (stating the obvious) less likely to fail than an order-4
allocation, and the overhead of vmalloc() is undesirable given that the
size of the allocation is fixed.

Cc: Vipin Sharma <vipinsh@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  4 ++--
 arch/x86/kvm/mmu/mmu.c          | 23 ++++++++++++++++++++++-
 arch/x86/kvm/x86.c              |  5 ++++-
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 330cdcbed1a6..9667d6b929ee 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1343,7 +1343,7 @@ struct kvm_arch {
 	bool has_private_mem;
 	bool has_protected_state;
 	bool pre_fault_allowed;
-	struct hlist_head mmu_page_hash[KVM_NUM_MMU_PAGES];
+	struct hlist_head *mmu_page_hash;
 	struct list_head active_mmu_pages;
 	/*
 	 * A list of kvm_mmu_page structs that, if zapped, could possibly be
@@ -2006,7 +2006,7 @@ void kvm_mmu_vendor_module_exit(void);
 
 void kvm_mmu_destroy(struct kvm_vcpu *vcpu);
 int kvm_mmu_create(struct kvm_vcpu *vcpu);
-void kvm_mmu_init_vm(struct kvm *kvm);
+int kvm_mmu_init_vm(struct kvm *kvm);
 void kvm_mmu_uninit_vm(struct kvm *kvm);
 
 void kvm_mmu_init_memslot_memory_attributes(struct kvm *kvm,
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index cbc84c6abc2e..41da2cb1e3f1 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3882,6 +3882,18 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 	return r;
 }
 
+static int kvm_mmu_alloc_page_hash(struct kvm *kvm)
+{
+	typeof(kvm->arch.mmu_page_hash) h;
+
+	h = kvcalloc(KVM_NUM_MMU_PAGES, sizeof(*h), GFP_KERNEL_ACCOUNT);
+	if (!h)
+		return -ENOMEM;
+
+	kvm->arch.mmu_page_hash = h;
+	return 0;
+}
+
 static int mmu_first_shadow_root_alloc(struct kvm *kvm)
 {
 	struct kvm_memslots *slots;
@@ -6675,13 +6687,19 @@ static void kvm_mmu_zap_all_fast(struct kvm *kvm)
 		kvm_tdp_mmu_zap_invalidated_roots(kvm, true);
 }
 
-void kvm_mmu_init_vm(struct kvm *kvm)
+int kvm_mmu_init_vm(struct kvm *kvm)
 {
+	int r;
+
 	kvm->arch.shadow_mmio_value = shadow_mmio_value;
 	INIT_LIST_HEAD(&kvm->arch.active_mmu_pages);
 	INIT_LIST_HEAD(&kvm->arch.possible_nx_huge_pages);
 	spin_lock_init(&kvm->arch.mmu_unsync_pages_lock);
 
+	r = kvm_mmu_alloc_page_hash(kvm);
+	if (r)
+		return r;
+
 	if (tdp_mmu_enabled)
 		kvm_mmu_init_tdp_mmu(kvm);
 
@@ -6692,6 +6710,7 @@ void kvm_mmu_init_vm(struct kvm *kvm)
 
 	kvm->arch.split_desc_cache.kmem_cache = pte_list_desc_cache;
 	kvm->arch.split_desc_cache.gfp_zero = __GFP_ZERO;
+	return 0;
 }
 
 static void mmu_free_vm_memory_caches(struct kvm *kvm)
@@ -6703,6 +6722,8 @@ static void mmu_free_vm_memory_caches(struct kvm *kvm)
 
 void kvm_mmu_uninit_vm(struct kvm *kvm)
 {
+	kvfree(kvm->arch.mmu_page_hash);
+
 	if (tdp_mmu_enabled)
 		kvm_mmu_uninit_tdp_mmu(kvm);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f9f798f286ce..d204ba9368f8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12787,7 +12787,9 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	if (ret)
 		goto out;
 
-	kvm_mmu_init_vm(kvm);
+	ret = kvm_mmu_init_vm(kvm);
+	if (ret)
+		goto out_cleanup_page_track;
 
 	ret = kvm_x86_call(vm_init)(kvm);
 	if (ret)
@@ -12840,6 +12842,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 out_uninit_mmu:
 	kvm_mmu_uninit_vm(kvm);
+out_cleanup_page_track:
 	kvm_page_track_cleanup(kvm);
 out:
 	return ret;
-- 
2.49.0.1112.g889b7c5bd8-goog


