Return-Path: <linux-kernel+bounces-780689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA6FB30817
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2961F624FB8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83182FC01B;
	Thu, 21 Aug 2025 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nJo7NxJ/"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A85C2C026D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755810072; cv=none; b=UY93mBaXyWXIm5E8yn4D32JiHN2pDKCNWD+Ocb5ESaID49ItvQfMj7z14w9tUZmsTGUApO0OAQhv1inv9vdvyfWS5qu7ygSYvEuAf8tNRKmOfbsrl8X6+pO3HlSjV/6CLpK2tQ/ba+6VU21PNHoGfpBRGpBJjQzh2xLJPjhjW2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755810072; c=relaxed/simple;
	bh=AoW4m6UY7aQpJgkdXNQBDrHg3vmPuYVWlkUo96wIdqA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HBudtytopkt3Aa5TTeg+9Tz6KJD2MFEArn2IIgoX+m2A/fpJR6DJYp5CXXRV0RF1E5qgS7O8TRqjuwbOPnKLvidJKnYcrmobfP6QA206L3QQ9YkqALo6KAUOdpWrJLH6ueXQP7Aw8w4c1BFIyGHSTG1R3lwAWugHC8Q7aQaCrBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nJo7NxJ/; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2e614889so1444369b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755810070; x=1756414870; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=fxt6rTMqHrWA9f8ahxcPmdPJmqaCbIUP8K6s+gPHJdY=;
        b=nJo7NxJ/bsOTzL5lzquvb6MWEF1YuFVvCgvSItY//GWwt0d7apAHT46qD70qaDMBQY
         7bi3VIfMzfNPfX69qZtlwgUc8hlTMOtWyeYf5dtqebg4Yh0s0EvDkp8rl6rDYXudhVMK
         i3q5NAwK0NbliM/gPzuoeznHeIIydZ7iF0ktmoLTx0G882NbIyWP5aloDCt1+W/jkYSq
         G+Dp9EHUUnzctbO3IMJSUdvQtlC8CfT4819kc101qAvEYPAmE4pnTyuCtNzUUZ4u4/16
         t+WQGupAcHNjDkACcktbqgO/WxNjte5rkJ37m3q590ly7609Mla8Dmf2ZsDRlen18U9K
         02kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755810070; x=1756414870;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fxt6rTMqHrWA9f8ahxcPmdPJmqaCbIUP8K6s+gPHJdY=;
        b=iFIecWWSSZf/1uiRV9lHVWppC39S6bLkin7NoZBlqbJxTAgxOsUWBR8Mmvhol/AyAM
         8pPJaa62w5qU7p1SZ9pOAv/GA9p3/5PfHOeoc5CKdpYBvv4gfvsC9Ke6QF6Jv55gNRsN
         4a1CcAG6jqo9fy9qjxIlLVRXk9XqjQ+D+1OI40rhTNqo1HpVtCc9dlGzppSWFxjysQw4
         E55AILD/UUmJsmjYkcJozkqEpUX5QaHX5/FBY84ZovI1+o9g931XVOJjquId7VUbxLko
         L1CfzPOyHu6nA4FlI23oTo8Kjl73VBkP5mHrpVNYA06tc2wL+XPoFenPL4vigaD9zRrB
         5Y4w==
X-Forwarded-Encrypted: i=1; AJvYcCXY4X0KCV4Mfh4L/0F6Rb3CmoNFkZFIlb7mpvoCgBU0JyvEf5c5fDfYiOl4pDkEvOZkiYEOn6vQRnQsP6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ZslReGy2xKQteJ/C0i9xd9A98BcY3Fn4YJ+a0ybVUlgXV0JK
	uiiNK8R1YzfrJt+aVYpv+sWpZdZQkpv2uCs84IyWgJevzlnWl3y8hxpeppD/oyW4fUyDCKuFSQY
	f44ilaA==
X-Google-Smtp-Source: AGHT+IFn+EYj/FE0ePzblUKFMdEC+BFGAdYI0PBx7I9mvhQoZZjMBZ5mHJyHtUrO2Tk/q3sQHu7NuwUXWEg=
X-Received: from pfbbd13.prod.google.com ([2002:a05:6a00:278d:b0:76e:8abf:185a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7489:b0:240:130e:d781
 with SMTP id adf61e73a8af0-24340c10ac7mr756815637.17.1755810069751; Thu, 21
 Aug 2025 14:01:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 21 Aug 2025 14:00:40 -0700
In-Reply-To: <20250821210042.3451147-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821210042.3451147-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250821210042.3451147-15-seanjc@google.com>
Subject: [RFC PATCH 14/16] KVM: arm64: Track "forced" information in "struct kvm_page_fault"
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Move the abort handler's local "force_pte" and "s2_force_noncacheable"
variables into "struct kvm_page_fault" in anticipation of moving the
mmap_lock-protected code to a separate helper.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/include/asm/kvm_host.h |  3 +++
 arch/arm64/kvm/mmu.c              | 22 +++++++++++-----------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 6a99f7fa065d..fa52546bf870 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -440,6 +440,9 @@ struct kvm_page_fault {
 	} vma;
 
 	long pagesize;
+
+	bool force_pte;
+	bool s2_force_noncacheable;
 };
 
 /*
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 575a4f9f2583..fec3a6aeabd0 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1469,8 +1469,7 @@ static bool kvm_vma_is_cacheable(struct vm_area_struct *vma)
 static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
 	int ret = 0;
-	bool writable, force_pte = false;
-	bool s2_force_noncacheable = false;
+	bool writable;
 	struct kvm *kvm = vcpu->kvm;
 	struct vm_area_struct *vma;
 	void *memcache;
@@ -1526,7 +1525,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	 * memslots.
 	 */
 	if (logging_active) {
-		force_pte = true;
+		fault->force_pte = true;
 		fault->vma.pageshift = PAGE_SHIFT;
 	} else {
 		fault->vma.pageshift = get_vma_page_shift(vma, fault->hva);
@@ -1548,7 +1547,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		fallthrough;
 	case CONT_PTE_SHIFT:
 		fault->vma.pageshift = PAGE_SHIFT;
-		force_pte = true;
+		fault->force_pte = true;
 		fallthrough;
 	case PAGE_SHIFT:
 		break;
@@ -1561,7 +1560,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	if (fault->nested) {
 		unsigned long max_map_size;
 
-		max_map_size = force_pte ? PAGE_SIZE : PUD_SIZE;
+		max_map_size = fault->force_pte ? PAGE_SIZE : PUD_SIZE;
 
 		WARN_ON_ONCE(fault->ipa != kvm_s2_trans_output(fault->nested));
 
@@ -1581,7 +1580,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		else if (max_map_size >= PAGE_SIZE && max_map_size < PMD_SIZE)
 			max_map_size = PAGE_SIZE;
 
-		force_pte = (max_map_size == PAGE_SIZE);
+		fault->force_pte = (max_map_size == PAGE_SIZE);
 		fault->pagesize = min(fault->pagesize, (long)max_map_size);
 	}
 
@@ -1656,7 +1655,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 			 * In both cases, we don't let transparent_hugepage_adjust()
 			 * change things at the last minute.
 			 */
-			s2_force_noncacheable = true;
+			fault->s2_force_noncacheable = true;
 		}
 	} else if (logging_active && !fault->write) {
 		/*
@@ -1666,7 +1665,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		writable = false;
 	}
 
-	if (fault->exec && s2_force_noncacheable)
+	if (fault->exec && fault->s2_force_noncacheable)
 		return -ENOEXEC;
 
 	/*
@@ -1699,7 +1698,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	 * If we are not forced to use page mapping, check if we are
 	 * backed by a THP and thus use block mapping if possible.
 	 */
-	if (fault->pagesize == PAGE_SIZE && !(force_pte || s2_force_noncacheable)) {
+	if (fault->pagesize == PAGE_SIZE &&
+	    !(fault->force_pte || fault->s2_force_noncacheable)) {
 		if (fault->is_perm && fault->granule > PAGE_SIZE)
 			fault->pagesize = fault->granule;
 		else
@@ -1711,7 +1711,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		}
 	}
 
-	if (!fault->is_perm && !s2_force_noncacheable && kvm_has_mte(kvm)) {
+	if (!fault->is_perm && !fault->s2_force_noncacheable && kvm_has_mte(kvm)) {
 		/* Check the VMM hasn't introduced a new disallowed VMA */
 		if (fault->vma.vm_flags & VM_MTE_ALLOWED) {
 			sanitise_mte_tags(kvm, fault->pfn, fault->pagesize);
@@ -1727,7 +1727,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	if (fault->exec)
 		prot |= KVM_PGTABLE_PROT_X;
 
-	if (s2_force_noncacheable) {
+	if (fault->s2_force_noncacheable) {
 		if (fault->vma.vm_flags & VM_ALLOW_ANY_UNCACHED)
 			prot |= KVM_PGTABLE_PROT_NORMAL_NC;
 		else
-- 
2.51.0.261.g7ce5a0a67e-goog


