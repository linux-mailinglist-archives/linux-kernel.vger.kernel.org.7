Return-Path: <linux-kernel+bounces-780681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7CDB307F1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A70D1D4092B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982392EB841;
	Thu, 21 Aug 2025 21:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CKuJLkJw"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFB128315A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755810058; cv=none; b=WmEdATBU73/DonHFyhCTuvrSl2UBo935ATqYv3Ji0Chx3Ffz7WEGoIjL3skDE4cqO2TWRPCUXjS4Av9qJlndbguVLP8UTlQtKZ8pp9yFBbgNcEgB0fh/7w4mkVkMJyWFwTtwZUawCQysOHhQkjlsuIvmxSJMvJnCrwWPokVWGpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755810058; c=relaxed/simple;
	bh=O97tgp5t9/0u9T/cM2oyRaSjhATuyjcKvcGSgt6Pzfo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HUz7fzWZK1UNQs0biMHc2rBK0incGCHGsR33DOAfSybouZQxu48JkanrCgRb1mH6NXpOjxOBM7g0pIOaEpVZgPJDwJm2rNR/bxcrV+qA7HRiy5AkUWLpGTPKc7GCI14xuenEdB5djka2/Vk7eCTsi5/EbDqDtiarhye3qgugdOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CKuJLkJw; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b474d5ff588so1094945a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755810056; x=1756414856; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=vioVXt2ZZgg7NeYPZVOuYjJyML9DfewAFD4Lo8ICLyI=;
        b=CKuJLkJwxzQnFYwcRtGNVXmrptdLEW+6CL0hBpmFML1mFvcSs4b8rcsgFGMRRZwhmN
         lxrY0n4EfDi9LhO8QPrG0F/jN+J5wOOHvhV6pU5w6o64vsuYXzWhE0oFVOhslHnYcf8i
         Na5JxWdJSUp8QzmfLboCDTScDLgWgjXTLQ+LRlJR1wnisEwgZ7njhZtOZyIxoAXxt+JK
         ZwsUtRYG69ccEADYoZF508eAD5FL5ZbEFzSQLRdlI5rCNBwOLyW9JcWpVn7HVE2kvsOM
         d6y4D8f+Zn3yiS5RCCE9mZrRwvPOevAjcwij5Oo2tyDFSkvhdqI98LV3MMdmNPIVvgpn
         6S9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755810056; x=1756414856;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vioVXt2ZZgg7NeYPZVOuYjJyML9DfewAFD4Lo8ICLyI=;
        b=A3iDHt7AQw/Z3qxrd18YtXp/i8VNnAE1FAcRusVMbgCeHg5esHwQfCN1byYYpLLsNm
         p9ch6lP4TscPfNPLHyBjqvJmnXUvlc4RZq1gF4V0VMgMlLHty8MOcwTjCbH4yw8Jrorr
         aI6Az+t/VeIxzQdHOPXb4Lee5sgn/bY9yr7o2vou+JicrOuxm9vkHLwAeFm3r5YPAWfQ
         p/OJPRCEPyh65CnsSpS60sECs6ikeEorzDuzBjRsF68G7SmQInENowYNPUfDz0OnDHJy
         qeDh1bY+pFHKQpcVhFoxHnFK3FXGIvb0UsAP6PiEPrMvpyhzD4tM9wqF7nDIKBf+bwh9
         TZCg==
X-Forwarded-Encrypted: i=1; AJvYcCWKjsPA6lO9h/Jf774HXKrt8jMYz2adu88sU75ln2N341Si4NV7JTXgXcz5DRZzhfnr2emBXPMl1IQBADU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI312X3PwE+UZjNnX6zlWy+n/prZdzs+KVdCZnJoovykKmM/Q3
	Cvxm9CMuc8yqNSA2vcm1qzpBZVnjVQCoZMLG730Uyqn6fIf8L2VfVkKy0ZHz1MeHirDPYS+76bX
	Cvw0lrQ==
X-Google-Smtp-Source: AGHT+IFMAoySLGWaBGxxLE7EGe5/JK70vfGurcQkwXtR0YxVIkKbRYcB3XHf65NsmmZ5Hb+78WjJ0WrD9XU=
X-Received: from pjbee15.prod.google.com ([2002:a17:90a:fc4f:b0:321:c3cc:2574])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c45:b0:324:e96a:2ada
 with SMTP id 98e67ed59e1d1-3251774ac2emr940105a91.21.1755810055944; Thu, 21
 Aug 2025 14:00:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 21 Aug 2025 14:00:32 -0700
In-Reply-To: <20250821210042.3451147-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821210042.3451147-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250821210042.3451147-7-seanjc@google.com>
Subject: [RFC PATCH 06/16] KVM: arm64: Pass kvm_page_fault pointer to transparent_hugepage_adjust()
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Use the local kvm_page_fault structure to adjust for transparent hugepages
when resolving guest aborts, to reduce the number of parameters from 5=>2,
and to eliminate the less-than-pleasant pointer dereferences.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/mmu.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index ca98778989b2..047aba00388c 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1361,19 +1361,15 @@ static bool fault_supports_stage2_huge_mapping(struct kvm_memory_slot *memslot,
  * Returns the size of the mapping.
  */
 static long
-transparent_hugepage_adjust(struct kvm *kvm, struct kvm_memory_slot *memslot,
-			    unsigned long hva, kvm_pfn_t *pfnp,
-			    phys_addr_t *ipap)
+transparent_hugepage_adjust(struct kvm *kvm, struct kvm_page_fault *fault)
 {
-	kvm_pfn_t pfn = *pfnp;
-
 	/*
 	 * Make sure the adjustment is done only for THP pages. Also make
 	 * sure that the HVA and IPA are sufficiently aligned and that the
 	 * block map is contained within the memslot.
 	 */
-	if (fault_supports_stage2_huge_mapping(memslot, hva, PMD_SIZE)) {
-		int sz = get_user_mapping_size(kvm, hva);
+	if (fault_supports_stage2_huge_mapping(fault->slot, fault->hva, PMD_SIZE)) {
+		int sz = get_user_mapping_size(kvm, fault->hva);
 
 		if (sz < 0)
 			return sz;
@@ -1381,10 +1377,8 @@ transparent_hugepage_adjust(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		if (sz < PMD_SIZE)
 			return PAGE_SIZE;
 
-		*ipap &= PMD_MASK;
-		pfn &= ~(PTRS_PER_PMD - 1);
-		*pfnp = pfn;
-
+		fault->ipa &= PMD_MASK;
+		fault->pfn &= ~(PTRS_PER_PMD - 1);
 		return PMD_SIZE;
 	}
 
@@ -1724,9 +1718,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		if (fault->is_perm && fault_granule > PAGE_SIZE)
 			vma_pagesize = fault_granule;
 		else
-			vma_pagesize = transparent_hugepage_adjust(kvm, fault->slot,
-								   fault->hva, &fault->pfn,
-								   &fault->fault_ipa);
+			vma_pagesize = transparent_hugepage_adjust(kvm, fault);
 
 		if (vma_pagesize < 0) {
 			ret = vma_pagesize;
-- 
2.51.0.261.g7ce5a0a67e-goog


