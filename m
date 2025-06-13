Return-Path: <linux-kernel+bounces-686346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7D9AD9630
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 22:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2441798CD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 20:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0341E25A354;
	Fri, 13 Jun 2025 20:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OMfOfMlC"
Received: from mail-vs1-f74.google.com (mail-vs1-f74.google.com [209.85.217.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C01C24BD0C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 20:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749846202; cv=none; b=Tu9yKHOe0hLuqFvoIXpZA92ndVeYoZPBZr1hZLVW5uPFa7t+U9VqXb44jIUiX2cRJXpR3LQ+soUaJ5N4/ceAoFwLjGxbvo/cnh+U1pYSEUvDP5ku1etfgG2Jq0NpcraHpU85MJuNRIrOl5YQ5+hYdcYGzx4CkNgDxEa6Cl0JiuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749846202; c=relaxed/simple;
	bh=BnLBLGPZ5akrHhWCS9gd81mDb3TrOYirXW5DylKpyAo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jzyBChAy8qgD1paf2IlVhOIxD14Bwu6RSTjvdarnrNE4rWsE9HSioU6+aoRWje1oHenUX4RjWy0X0v7D0QIWpVXD2Ni6E/XbAao2+PMkmP88u3Sn3M+Wwsf/neqi2W/LgloRppyTtSMqpJ15XRMI8J9XRnHW9obvQfWRaGvgXwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OMfOfMlC; arc=none smtp.client-ip=209.85.217.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-vs1-f74.google.com with SMTP id ada2fe7eead31-4e7f4deda5fso99050137.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 13:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749846200; x=1750451000; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2yL+YQchLj5oy1IYa3Wr99RKP+YmoRlKg8opW3z4ork=;
        b=OMfOfMlCQRzD7tacfpU0hEOWbGCglD6daKSDYeSA8PIAKyx8Q6HG6IaX24AMXIZMJ3
         T/r5iEu4uPQKLfV9UgteUnydHJPxoxl3m1GM1wdyeuGmETi7EKD/Sylzh57EUldqFC0P
         yo2xT6oSefF1yHlLJzXA0VjVgG4Hkt9dlLNuFmsuMov2P8GbjYiAL9kVuqVcnqLhw3zI
         JC+IPa/oZhaDja/pB7luqTluri5EboCdfsjk8Ks6VTKCfawRa5MylJsag8dQiWw1hV+2
         e5WILDfpZCi1fNFX2YNVse48KQcOfVQYRugbjL72LbUu1oleE5+bzoeVecvOAsj7C/z9
         g0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749846200; x=1750451000;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2yL+YQchLj5oy1IYa3Wr99RKP+YmoRlKg8opW3z4ork=;
        b=QE84mSyte6NxcvjKvVQurefQZS8at7wNvcfvRBTyAdNaDeP61i/jo1OC3Cg12JBylW
         Mu0i1y1gx1csMSjPk+C1hOlCeZlfSfYNJ9Fiib3t1jIRk3GgQMGsSIevZC+ApWGfx89R
         m9IU6PQ2dEIPsNXjxxO6G7GLW8K53zqT/S6SE7FoKjOzgn4ENJPBE9MhTD5luTmWfaXQ
         hKJ0bA7+d/oDcvSZ+UmQE7Nun6Atbz3UDrD9G8oHjEkTku7VVKeDrEC0TANgq2r7lcVe
         cp16b4ED2P4IU9F3CpHqrhJwL85ZPTOGwd0vme88o47Ww8RPdPA9B/hcc/OvyogcKdnY
         9B7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUI7EGg7dq+cYmwrYCk9/MC6OSDdrk7fX4zVLE8GnoiiC4/htuVUJWzRg+fQYBnedGtSiC+ub2gWRFcdsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9L6klkNcJMc4zXcls5TIULE4Z5H1MTC0wDaekyafzrshMdHpC
	nBFJ1I/v48HcIsTsdSQEQiAgYpGMgr1EpYvE2/K6MBJkGPIcUNatFiLjXhIkHyKu43iMnlMkJHJ
	WpVJJqF7c3muZdMWGOwGzIA==
X-Google-Smtp-Source: AGHT+IGjZm7nhmNpeEEhEcgmJwVT8JZRDftczL1aI79QMarKX5vZ2z6gEYMFjgFXvpiDSjKrDPHH7UIbISXDeGz+
X-Received: from vsbdn3.prod.google.com ([2002:a05:6102:5983:b0:4da:f617:c6aa])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:6a91:b0:4e5:59ce:471b with SMTP id ada2fe7eead31-4e7f63eacdbmr1353507137.23.1749846200001;
 Fri, 13 Jun 2025 13:23:20 -0700 (PDT)
Date: Fri, 13 Jun 2025 20:23:10 +0000
In-Reply-To: <20250613202315.2790592-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250613202315.2790592-1-jthoughton@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250613202315.2790592-4-jthoughton@google.com>
Subject: [PATCH v4 3/7] KVM: x86/mmu: Recover TDP MMU NX huge pages using MMU
 read lock
From: James Houghton <jthoughton@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, David Matlack <dmatlack@google.com>, 
	James Houghton <jthoughton@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Vipin Sharma <vipinsh@google.com>

Use MMU read lock to recover TDP MMU NX huge pages. Iterate
over the huge pages list under tdp_mmu_pages_lock protection and
unaccount the page before dropping the lock.

We must not zap an SPTE if:
- The SPTE is a root page.
- The SPTE does not point at the SP's page table.

If the SPTE does not point at the SP's page table, then something else
has changed the SPTE, so we cannot safely zap it.

Warn if zapping SPTE fails and current SPTE is still pointing to same
page table. This should never happen.

There is always a race between dirty logging, vCPU faults, and NX huge
page recovery for backing a gfn by an NX huge page or an executable
small page. Unaccounting sooner during the list traversal is increasing
the window of that race. Functionally, it is okay, because accounting
doesn't protect against iTLB multi-hit bug, it is there purely to
prevent KVM from bouncing a gfn between two page sizes. The only
downside is that a vCPU will end up doing more work in tearing down all
the child SPTEs. This should be a very rare race.

Zapping under MMU read lock unblocks vCPUs which are waiting for MMU
read lock. This optimizaion is done to solve a guest jitter issue on
Windows VM which was observing an increase in network latency.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
Co-developed-by: James Houghton <jthoughton@google.com>
Signed-off-by: James Houghton <jthoughton@google.com>
---
 arch/x86/kvm/mmu/mmu.c     | 99 ++++++++++++++++++++++++--------------
 arch/x86/kvm/mmu/tdp_mmu.c | 42 +++++++++++++---
 2 files changed, 98 insertions(+), 43 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b074f7bb5cc58..10ba328b664d7 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7535,12 +7535,40 @@ static unsigned long nx_huge_pages_to_zap(struct kvm *kvm,
 	return ratio ? DIV_ROUND_UP(pages, ratio) : 0;
 }
 
+static bool kvm_mmu_sp_dirty_logging_enabled(struct kvm *kvm,
+					     struct kvm_mmu_page *sp)
+{
+	struct kvm_memory_slot *slot = NULL;
+
+	/*
+	 * Since gfn_to_memslot() is relatively expensive, it helps to skip it if
+	 * it the test cannot possibly return true.  On the other hand, if any
+	 * memslot has logging enabled, chances are good that all of them do, in
+	 * which case unaccount_nx_huge_page() is much cheaper than zapping the
+	 * page.
+	 *
+	 * If a memslot update is in progress, reading an incorrect value of
+	 * kvm->nr_memslots_dirty_logging is not a problem: if it is becoming
+	 * zero, gfn_to_memslot() will be done unnecessarily; if it is becoming
+	 * nonzero, the page will be zapped unnecessarily.  Either way, this only
+	 * affects efficiency in racy situations, and not correctness.
+	 */
+	if (atomic_read(&kvm->nr_memslots_dirty_logging)) {
+		struct kvm_memslots *slots;
+
+		slots = kvm_memslots_for_spte_role(kvm, sp->role);
+		slot = __gfn_to_memslot(slots, sp->gfn);
+		WARN_ON_ONCE(!slot);
+	}
+	return slot && kvm_slot_dirty_track_enabled(slot);
+}
+
 static void kvm_recover_nx_huge_pages(struct kvm *kvm,
 				      enum kvm_mmu_type mmu_type)
 {
 	unsigned long to_zap = nx_huge_pages_to_zap(kvm, mmu_type);
+	bool is_tdp = mmu_type == KVM_TDP_MMU;
 	struct list_head *nx_huge_pages;
-	struct kvm_memory_slot *slot;
 	struct kvm_mmu_page *sp;
 	LIST_HEAD(invalid_list);
 	bool flush = false;
@@ -7549,7 +7577,10 @@ static void kvm_recover_nx_huge_pages(struct kvm *kvm,
 	nx_huge_pages = &kvm->arch.possible_nx_huge_pages[mmu_type].pages;
 
 	rcu_idx = srcu_read_lock(&kvm->srcu);
-	write_lock(&kvm->mmu_lock);
+	if (is_tdp)
+		read_lock(&kvm->mmu_lock);
+	else
+		write_lock(&kvm->mmu_lock);
 
 	/*
 	 * Zapping TDP MMU shadow pages, including the remote TLB flush, must
@@ -7559,8 +7590,13 @@ static void kvm_recover_nx_huge_pages(struct kvm *kvm,
 	rcu_read_lock();
 
 	for ( ; to_zap; --to_zap) {
-		if (list_empty(nx_huge_pages))
+		if (is_tdp)
+			spin_lock(&kvm->arch.tdp_mmu_pages_lock);
+		if (list_empty(nx_huge_pages)) {
+			if (is_tdp)
+				spin_unlock(&kvm->arch.tdp_mmu_pages_lock);
 			break;
+		}
 
 		/*
 		 * We use a separate list instead of just using active_mmu_pages
@@ -7575,50 +7611,38 @@ static void kvm_recover_nx_huge_pages(struct kvm *kvm,
 		WARN_ON_ONCE(!sp->nx_huge_page_disallowed);
 		WARN_ON_ONCE(!sp->role.direct);
 
+		unaccount_nx_huge_page(kvm, sp);
+
+		if (is_tdp)
+			spin_unlock(&kvm->arch.tdp_mmu_pages_lock);
+
 		/*
-		 * Unaccount and do not attempt to recover any NX Huge Pages
-		 * that are being dirty tracked, as they would just be faulted
-		 * back in as 4KiB pages. The NX Huge Pages in this slot will be
-		 * recovered, along with all the other huge pages in the slot,
-		 * when dirty logging is disabled.
-		 *
-		 * Since gfn_to_memslot() is relatively expensive, it helps to
-		 * skip it if it the test cannot possibly return true.  On the
-		 * other hand, if any memslot has logging enabled, chances are
-		 * good that all of them do, in which case unaccount_nx_huge_page()
-		 * is much cheaper than zapping the page.
-		 *
-		 * If a memslot update is in progress, reading an incorrect value
-		 * of kvm->nr_memslots_dirty_logging is not a problem: if it is
-		 * becoming zero, gfn_to_memslot() will be done unnecessarily; if
-		 * it is becoming nonzero, the page will be zapped unnecessarily.
-		 * Either way, this only affects efficiency in racy situations,
-		 * and not correctness.
+		 * Do not attempt to recover any NX Huge Pages that are being
+		 * dirty tracked, as they would just be faulted back in as 4KiB
+		 * pages. The NX Huge Pages in this slot will be recovered,
+		 * along with all the other huge pages in the slot, when dirty
+		 * logging is disabled.
 		 */
-		slot = NULL;
-		if (atomic_read(&kvm->nr_memslots_dirty_logging)) {
-			struct kvm_memslots *slots;
+		if (!kvm_mmu_sp_dirty_logging_enabled(kvm, sp)) {
+			if (is_tdp)
+				flush |= kvm_tdp_mmu_zap_possible_nx_huge_page(kvm, sp);
+			else
+				kvm_mmu_prepare_zap_page(kvm, sp, &invalid_list);
 
-			slots = kvm_memslots_for_spte_role(kvm, sp->role);
-			slot = __gfn_to_memslot(slots, sp->gfn);
-			WARN_ON_ONCE(!slot);
 		}
 
-		if (slot && kvm_slot_dirty_track_enabled(slot))
-			unaccount_nx_huge_page(kvm, sp);
-		else if (mmu_type == KVM_TDP_MMU)
-			flush |= kvm_tdp_mmu_zap_possible_nx_huge_page(kvm, sp);
-		else
-			kvm_mmu_prepare_zap_page(kvm, sp, &invalid_list);
 		WARN_ON_ONCE(sp->nx_huge_page_disallowed);
 
 		if (need_resched() || rwlock_needbreak(&kvm->mmu_lock)) {
 			kvm_mmu_remote_flush_or_zap(kvm, &invalid_list, flush);
 			rcu_read_unlock();
 
-			cond_resched_rwlock_write(&kvm->mmu_lock);
-			flush = false;
+			if (is_tdp)
+				cond_resched_rwlock_read(&kvm->mmu_lock);
+			else
+				cond_resched_rwlock_write(&kvm->mmu_lock);
 
+			flush = false;
 			rcu_read_lock();
 		}
 	}
@@ -7626,7 +7650,10 @@ static void kvm_recover_nx_huge_pages(struct kvm *kvm,
 
 	rcu_read_unlock();
 
-	write_unlock(&kvm->mmu_lock);
+	if (is_tdp)
+		read_unlock(&kvm->mmu_lock);
+	else
+		write_unlock(&kvm->mmu_lock);
 	srcu_read_unlock(&kvm->srcu, rcu_idx);
 }
 
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 19907eb04a9c4..31d921705dee7 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -928,21 +928,49 @@ static void tdp_mmu_zap_root(struct kvm *kvm, struct kvm_mmu_page *root,
 bool kvm_tdp_mmu_zap_possible_nx_huge_page(struct kvm *kvm,
 					   struct kvm_mmu_page *sp)
 {
-	u64 old_spte;
+	struct tdp_iter iter = {
+		.old_spte = sp->ptep ? kvm_tdp_mmu_read_spte(sp->ptep) : 0,
+		.sptep = sp->ptep,
+		.level = sp->role.level + 1,
+		.gfn = sp->gfn,
+		.as_id = kvm_mmu_page_as_id(sp),
+	};
+
+	lockdep_assert_held_read(&kvm->mmu_lock);
+
+	if (WARN_ON_ONCE(!is_tdp_mmu_page(sp)))
+		return false;
 
 	/*
-	 * This helper intentionally doesn't allow zapping a root shadow page,
-	 * which doesn't have a parent page table and thus no associated entry.
+	 * Root shadow pages don't have a parent page table and thus no
+	 * associated entry, but they can never be possible NX huge pages.
 	 */
 	if (WARN_ON_ONCE(!sp->ptep))
 		return false;
 
-	old_spte = kvm_tdp_mmu_read_spte(sp->ptep);
-	if (WARN_ON_ONCE(!is_shadow_present_pte(old_spte)))
+	/*
+	 * Since mmu_lock is held in read mode, it's possible another task has
+	 * already modified the SPTE. Zap the SPTE if and only if the SPTE
+	 * points at the SP's page table, as checking shadow-present isn't
+	 * sufficient, e.g. the SPTE could be replaced by a leaf SPTE, or even
+	 * another SP. Note, spte_to_child_pt() also checks that the SPTE is
+	 * shadow-present, i.e. guards against zapping a frozen SPTE.
+	 */
+	if ((tdp_ptep_t)sp->spt != spte_to_child_pt(iter.old_spte, iter.level))
 		return false;
 
-	tdp_mmu_set_spte(kvm, kvm_mmu_page_as_id(sp), sp->ptep, old_spte,
-			 SHADOW_NONPRESENT_VALUE, sp->gfn, sp->role.level + 1);
+	/*
+	 * If a different task modified the SPTE, then it should be impossible
+	 * for the SPTE to still be used for the to-be-zapped SP. Non-leaf
+	 * SPTEs don't have Dirty bits, KVM always sets the Accessed bit when
+	 * creating non-leaf SPTEs, and all other bits are immutable for non-
+	 * leaf SPTEs, i.e. the only legal operations for non-leaf SPTEs are
+	 * zapping and replacement.
+	 */
+	if (tdp_mmu_set_spte_atomic(kvm, &iter, SHADOW_NONPRESENT_VALUE)) {
+		WARN_ON_ONCE((tdp_ptep_t)sp->spt == spte_to_child_pt(iter.old_spte, iter.level));
+		return false;
+	}
 
 	return true;
 }
-- 
2.50.0.rc2.692.g299adb8693-goog


