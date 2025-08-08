Return-Path: <linux-kernel+bounces-760671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8919CB1EE96
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 825E64E131F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 18:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBAF276038;
	Fri,  8 Aug 2025 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="emNgH+sI"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA3E200BBC
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 18:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754679453; cv=none; b=A3DVhjOdnyR1neXEznxvrkCkc1NW2/+WByJrsNTQCsCEI9SOOZhvhk8cPYyIvZnNnq1oLd0IBp568s0wYaLemZ8uIgtt8vCPdAT7L0MG9LbN1dpP21NZCwn9nMJnyS9AdIuw/G0RWax8Jg0TbvQsA6hQQLsP/zPQ58kz0kdlc94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754679453; c=relaxed/simple;
	bh=rAgCo/rrBUq65+BJpmaxua3ak9p5t6+cqOpdgdEgf1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XahsOTEm5OYfc3EzgXw/MshmnNfu+NH0SkoQNTHuwnY6dZyA7RIgJFTPREx5lieixccHN5AW50zAckEdEYOHURlPYtxiRvrzvokbl3vNSR3W++3YiNymhVeX+VVjaA+Ne5+bQ/kuHU6V4YiOW9nO8cFhx5Jbr4Azbvgz4gtAbzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=emNgH+sI; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 8 Aug 2025 11:57:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754679439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s9gC5taMqXomgmy+wOk5yz1bjdGDKNxGCUXt71gAiH4=;
	b=emNgH+sIj0mFo5p9JAsb8YN8WYz1XkWrwxgJ3MjbFju6vfIA8kpe7Qv0hNCwlSlKo0tSj4
	1sbNZ7gDTJULykI/9IVsFYDPo75mzyEAAv6CHsishC96RmhvxW+Ap7upRPJ/ytjkXAowlr
	dpQn3U63ulOI5PR6J96U9XsK4KfzJ0I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Mingwei Zhang <mizhang@google.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: arm64: Split kvm_pgtable_stage2_destroy()
Message-ID: <aJZIiW5B3cleCxuo@linux.dev>
References: <20250724235144.2428795-1-rananta@google.com>
 <20250724235144.2428795-2-rananta@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724235144.2428795-2-rananta@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 24, 2025 at 11:51:43PM +0000, Raghavendra Rao Ananta wrote:
> Split kvm_pgtable_stage2_destroy() into two:
>   - kvm_pgtable_stage2_destroy_range(), that performs the
>     page-table walk and free the entries over a range of addresses.
>   - kvm_pgtable_stage2_destroy_pgd(), that frees the PGD.
> 
> This refactoring enables subsequent patches to free large page-tables
> in chunks, calling cond_resched() between each chunk, to yield the CPU
> as necessary.
> 
> Direct callers of kvm_pgtable_stage2_destroy() will continue to walk
> the entire range of the VM as before, ensuring no functional changes.
> 
> Also, add equivalent pkvm_pgtable_stage2_*() stubs to maintain 1:1
> mapping of the page-table functions.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>


Here's the other half of my fixups

From 7d3e948357d0d2568afc136906e1b973ed39deeb Mon Sep 17 00:00:00 2001
From: Oliver Upton <oliver.upton@linux.dev>
Date: Fri, 8 Aug 2025 11:35:43 -0700
Subject: [PATCH 2/4] fixup! KVM: arm64: Split kvm_pgtable_stage2_destroy()

---
 arch/arm64/include/asm/kvm_pgtable.h  |  4 ++--
 arch/arm64/kvm/hyp/nvhe/mem_protect.c |  2 +-
 arch/arm64/kvm/hyp/pgtable.c          |  2 +-
 arch/arm64/kvm/mmu.c                  | 12 ++++++++++--
 arch/arm64/kvm/pkvm.c                 | 12 ++++--------
 5 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 20aea58eca18..fdae4685b9ac 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -562,13 +562,13 @@ void kvm_pgtable_stage2_destroy_range(struct kvm_pgtable *pgt,
 void kvm_pgtable_stage2_destroy_pgd(struct kvm_pgtable *pgt);
 
 /**
- * kvm_pgtable_stage2_destroy() - Destroy an unused guest stage-2 page-table.
+ * __kvm_pgtable_stage2_destroy() - Destroy an unused guest stage-2 page-table.
  * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init*().
  *
  * The page-table is assumed to be unreachable by any hardware walkers prior
  * to freeing and therefore no TLB invalidation is performed.
  */
-void kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt);
+void __kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt);
 
 /**
  * kvm_pgtable_stage2_free_unlinked() - Free an unlinked stage-2 paging structure.
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 95d7534c9679..5eb8d6e29ac4 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -297,7 +297,7 @@ void reclaim_pgtable_pages(struct pkvm_hyp_vm *vm, struct kvm_hyp_memcache *mc)
 
 	/* Dump all pgtable pages in the hyp_pool */
 	guest_lock_component(vm);
-	kvm_pgtable_stage2_destroy(&vm->pgt);
+	__kvm_pgtable_stage2_destroy(&vm->pgt);
 	vm->kvm.arch.mmu.pgd_phys = 0ULL;
 	guest_unlock_component(vm);
 
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 7fad791cf40b..aa735ffe8d49 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1577,7 +1577,7 @@ void kvm_pgtable_stage2_destroy_pgd(struct kvm_pgtable *pgt)
 	pgt->pgd = NULL;
 }
 
-void kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt)
+void __kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt)
 {
 	kvm_pgtable_stage2_destroy_range(pgt, 0, BIT(pgt->ia_bits));
 	kvm_pgtable_stage2_destroy_pgd(pgt);
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 9a45daf817bf..6330a02c8418 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -904,6 +904,14 @@ static int kvm_init_ipa_range(struct kvm_s2_mmu *mmu, unsigned long type)
 	return 0;
 }
 
+static void kvm_stage2_destroy(struct kvm_pgtable *pgt)
+{
+	unsigned int ia_bits = VTCR_EL2_IPA(pgt->mmu->vtcr);
+
+	KVM_PGT_FN(kvm_pgtable_stage2_destroy_range)(pgt, 0, BIT(ia_bits));
+	KVM_PGT_FN(kvm_pgtable_stage2_destroy_pgd)(pgt);
+}
+
 /**
  * kvm_init_stage2_mmu - Initialise a S2 MMU structure
  * @kvm:	The pointer to the KVM structure
@@ -980,7 +988,7 @@ int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu, unsigned long t
 	return 0;
 
 out_destroy_pgtable:
-	KVM_PGT_FN(kvm_pgtable_stage2_destroy)(pgt);
+	kvm_stage2_destroy(pgt);
 out_free_pgtable:
 	kfree(pgt);
 	return err;
@@ -1077,7 +1085,7 @@ void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu)
 	write_unlock(&kvm->mmu_lock);
 
 	if (pgt) {
-		KVM_PGT_FN(kvm_pgtable_stage2_destroy)(pgt);
+		kvm_stage2_destroy(pgt);
 		kfree(pgt);
 	}
 }
diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
index bf737717ccb4..3be208449bd7 100644
--- a/arch/arm64/kvm/pkvm.c
+++ b/arch/arm64/kvm/pkvm.c
@@ -316,11 +316,6 @@ static int __pkvm_pgtable_stage2_unmap(struct kvm_pgtable *pgt, u64 start, u64 e
 	return 0;
 }
 
-void pkvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt)
-{
-	__pkvm_pgtable_stage2_unmap(pgt, 0, ~(0ULL));
-}
-
 int pkvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
 			   u64 phys, enum kvm_pgtable_prot prot,
 			   void *mc, enum kvm_pgtable_walk_flags flags)
@@ -452,12 +447,13 @@ int pkvm_pgtable_stage2_split(struct kvm_pgtable *pgt, u64 addr, u64 size,
 }
 
 void pkvm_pgtable_stage2_destroy_range(struct kvm_pgtable *pgt,
-					u64 addr, u64 size)
+				       u64 addr, u64 size)
 {
-	WARN_ON_ONCE(1);
+	__pkvm_pgtable_stage2_unmap(pgt, addr, size);
 }
 
 void pkvm_pgtable_stage2_destroy_pgd(struct kvm_pgtable *pgt)
 {
-	WARN_ON_ONCE(1);
+	/* Expected to be called after all pKVM mappings have been released. */
+	WARN_ON_ONCE(!RB_EMPTY_ROOT(&pgt->pkvm_mappings.rb_root));
 }
-- 
2.39.5

