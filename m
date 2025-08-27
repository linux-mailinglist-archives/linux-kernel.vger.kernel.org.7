Return-Path: <linux-kernel+bounces-787410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846E6B375D7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83FBE7B610B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 00:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196361F582A;
	Wed, 27 Aug 2025 00:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xr/c0kwy"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB48D18DF9D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 00:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756253137; cv=none; b=azq+rS0idfVYWGryeXsO+WPvZ4bQr7Q3IcRrqn+tREnIi5a33YxHbkqTL9e3yU6TXCbu1/8Zj58BcWSrFMgY96107c3FgzSsUXAhx3eNKxnGs5FIVCBgR7fCW5TM2ozPNj4aaitncf+9zf9zRxn3Bmzdw5sWA0Kh36zOZXyZZlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756253137; c=relaxed/simple;
	bh=I+EU4QhA5nIsOiRwCkJlZRTgDkQkuqLiyShRzJ28eU8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JxXKi7TaBHQuZNTQM+3OuhWaV6fBFaXRz12kkMbr7tVDX+mEF+95O0uVPNfZjvwLwZaxSGKOYAIIV2f6J0pRAodC3fr48oOoJSdYHJdIJDobrkiJmIbjsrceXflOC+bAzdwjXUCXunG5KkNY56gx0goyHyzlZHV3n69jTxFrsIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xr/c0kwy; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32326e72dfbso9045010a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 17:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756253133; x=1756857933; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=aoRBu2fbhQAp9J0WDcFWzITHzuyqeUhe62P9ND1eteE=;
        b=Xr/c0kwy9RzpNh/pIQ89xOgeIUo0Mphha3vzH6N62GT/z2JBioxPs8iuqGWU2TaAxc
         a1UgoyVJ0ESAVvNSINXvn+x+gsMMRwHkS1jU3nK4Y0YH4bxBFurzgs0R32Cjwlfe+Iny
         6RO6omzSnyNVaAYdLaBC2s4qMWa4pplWo2dDFCNlq0CwEkWQEO2s8O4SoTNfphyifo8K
         StgCftN5jSjS3szA444Puh16R8l+iKzIo+1WOhXA/lxHP+tltHeAH5rVm017bmiVBQKE
         TYX/7HUPxnNCc+zAwti6f8lAHArPVYbi5sUyJpvT/0r6e5EeJi9xeDKBPjhPmdMbBLd9
         0rxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756253133; x=1756857933;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aoRBu2fbhQAp9J0WDcFWzITHzuyqeUhe62P9ND1eteE=;
        b=kfv9M3s0Hj7YrGJ1sNJJkOP2UtNCRszvuEY4pXpWP5MPKdvpsJOYNjqfRRRNxaCtTz
         cUaqaFkEYzL7/NzjE+r0pn/55G9EtMJPA8JJeanzQaOmhUCTVu2cCh/1gtr/bvzDfVY7
         ptxyxYFNd2P8GLOzD75z2qS9KtFliNTH4p2IvUyXTUHVM1UgAW/jsGp9r9Av2wZ77c60
         tG7lT2sJIYYXnkD5qw0eIsbAHx8LUhnCzFD6PJW5fSB30DZk3qTXr4JHP2kYxDLrXgK8
         1wjNn7DQq9hQXRW1EAITQN/WKEoWQqi2MIe3gChzoEBX7fC2EMLJOZsdSEn5Zvp/alJg
         RVHg==
X-Forwarded-Encrypted: i=1; AJvYcCXOOXHi/bCwoh2hkS+3zpaDHg1Gge/+2IXJCOIiSnucDftx+pz4vSVI2T808To9EsFaXJYI3uKXBfCG4uQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQyPUuHEAw8+bF6PPGz+fQXdyebPvqtDxHq+wyxsAy7VjNzg5f
	ldwnhVj5fdTDA7GUdWPGeZlz/1RgPEgYdVFoLXjEDez/lzIAV2cJ2gz+Hyrb9tNKSapuMyW2ikT
	L2iZ6SQ==
X-Google-Smtp-Source: AGHT+IHqGAWofh3cMmtYDoc0/YkBsAddd/V2EhhMJBSlpua+zE04DRKyx6kTbjr+RaWkz4HT9l2FGYKmhJE=
X-Received: from pjbqb1.prod.google.com ([2002:a17:90b:2801:b0:321:abeb:1d8a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5445:b0:327:5360:5b1a
 with SMTP id 98e67ed59e1d1-3275360623bmr3748060a91.37.1756253133098; Tue, 26
 Aug 2025 17:05:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 26 Aug 2025 17:05:15 -0700
In-Reply-To: <20250827000522.4022426-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827000522.4022426-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250827000522.4022426-6-seanjc@google.com>
Subject: [RFC PATCH 05/12] KVM: TDX: Drop superfluous page pinning in S-EPT management
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"

Don't explicitly pin pages when mapping pages into the S-EPT, guest_memfd
doesn't support page migration in any capacity, i.e. there are no migrate
callbacks because guest_memfd pages *can't* be migrated.  See the WARN in
kvm_gmem_migrate_folio().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 1724d82c8512..9fb6e5f02cc9 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1586,29 +1586,22 @@ void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int pgd_level)
 	td_vmcs_write64(to_tdx(vcpu), SHARED_EPT_POINTER, root_hpa);
 }
 
-static void tdx_unpin(struct kvm *kvm, struct page *page)
-{
-	put_page(page);
-}
-
 static int tdx_mem_page_aug(struct kvm *kvm, gfn_t gfn,
-			    enum pg_level level, struct page *page)
+			    enum pg_level level, kvm_pfn_t pfn)
 {
 	int tdx_level = pg_level_to_tdx_sept_level(level);
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
+	struct page *page = pfn_to_page(pfn);
 	gpa_t gpa = gfn_to_gpa(gfn);
 	u64 entry, level_state;
 	u64 err;
 
 	err = tdh_mem_page_aug(&kvm_tdx->td, gpa, tdx_level, page, &entry, &level_state);
-	if (unlikely(tdx_operand_busy(err))) {
-		tdx_unpin(kvm, page);
+	if (unlikely(tdx_operand_busy(err)))
 		return -EBUSY;
-	}
 
 	if (KVM_BUG_ON(err, kvm)) {
 		pr_tdx_error_2(TDH_MEM_PAGE_AUG, err, entry, level_state);
-		tdx_unpin(kvm, page);
 		return -EIO;
 	}
 
@@ -1642,29 +1635,18 @@ static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn,
 				     enum pg_level level, kvm_pfn_t pfn)
 {
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
-	struct page *page = pfn_to_page(pfn);
 
 	/* TODO: handle large pages. */
 	if (KVM_BUG_ON(level != PG_LEVEL_4K, kvm))
 		return -EINVAL;
 
-	/*
-	 * Because guest_memfd doesn't support page migration with
-	 * a_ops->migrate_folio (yet), no callback is triggered for KVM on page
-	 * migration.  Until guest_memfd supports page migration, prevent page
-	 * migration.
-	 * TODO: Once guest_memfd introduces callback on page migration,
-	 * implement it and remove get_page/put_page().
-	 */
-	get_page(page);
-
 	/*
 	 * Read 'pre_fault_allowed' before 'kvm_tdx->state'; see matching
 	 * barrier in tdx_td_finalize().
 	 */
 	smp_rmb();
 	if (likely(kvm_tdx->state == TD_STATE_RUNNABLE))
-		return tdx_mem_page_aug(kvm, gfn, level, page);
+		return tdx_mem_page_aug(kvm, gfn, level, pfn);
 
 	return tdx_mem_page_record_premap_cnt(kvm, gfn, level, pfn);
 }
@@ -1715,7 +1697,6 @@ static int tdx_sept_drop_private_spte(struct kvm *kvm, gfn_t gfn,
 		return -EIO;
 	}
 	tdx_clear_page(page);
-	tdx_unpin(kvm, page);
 	return 0;
 }
 
@@ -1795,7 +1776,6 @@ static int tdx_sept_zap_private_spte(struct kvm *kvm, gfn_t gfn,
 	if (tdx_is_sept_zap_err_due_to_premap(kvm_tdx, err, entry, level) &&
 	    !KVM_BUG_ON(!atomic64_read(&kvm_tdx->nr_premapped), kvm)) {
 		atomic64_dec(&kvm_tdx->nr_premapped);
-		tdx_unpin(kvm, page);
 		return 0;
 	}
 
-- 
2.51.0.268.g9569e192d0-goog


