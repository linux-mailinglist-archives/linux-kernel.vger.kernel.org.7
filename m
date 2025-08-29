Return-Path: <linux-kernel+bounces-790887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 061BBB3AEDD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5874A00B48
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44B7219ED;
	Fri, 29 Aug 2025 00:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qPyb8w9o"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616F3220F38
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 00:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756426002; cv=none; b=uatOARwlK8a0Y3lOe88ANXAVDkKp0Vtnsso/Lrf+RXlHMffax55Kn+Vae4C0q41c/LaE4hdIYhg6YSWpk84qND1D+4GpdtF29/hF5MiHz+xR9V9xtgggfYYYqBprze+J4nsBp1KTcGwo+ysVXwVD1cyGFZ5L1n3zrvFJD5fTzNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756426002; c=relaxed/simple;
	bh=+ii6r4N6rkBoNCWhPTC+aQwPcbsLf6WTE0C1KJpqLtM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RE3AUP1+MxPKOFKocr50uC8neLST/clHPAVJD7CZ6deakfRJdsWAOlEz58B4TLX1eDUpK3FTncKw8Er4NRH1vMkNrvC4kyH8Kn2IJjaZBOQYVvy93ubi614lH2NsgFXOdy9POO6XRbuJIzj/y2S1JLJap2O2v27Xqp401U1rD2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qPyb8w9o; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-327594fd627so1489863a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756426001; x=1757030801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=1YmgvG2RcaVdULnIb8Wec5M7oDs3P0onCjyYEMew5Ns=;
        b=qPyb8w9oWmCXYr15dtSP4y5Ym3U+tKxk9ExRv/uNuve/ywT4vsZkY30nQjUUv37JX0
         i3BJ2fdtVLXy/Lq6vgmKuqwkVzDyWqCozmlgGrB7AgQ+VvY2vLiIYmymBU95Iw7GO54t
         a5XmwxX2qSftIXRJI9XECd4CHaZlbZWZYQplK00ZpWAly+gap8W7+FSO+YfKiWAsdoK3
         uWpOZd8ZQgyi71uilknbSFVeS6K0wc75sb+G9Hg0KdfQstZixQIcyGSOXO49rpfMQJF/
         l+ODr18EQaUDmUMw8BR6KWBUU+33Jpp/szgisUGg13dnfqr/o2bNU14z+jjdF9wowTZh
         j8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756426001; x=1757030801;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1YmgvG2RcaVdULnIb8Wec5M7oDs3P0onCjyYEMew5Ns=;
        b=si/9wc4ajwEDXUwQf6v2BEBxwdjVtZkqh6XZ6oTedw0Q+GzlbliPRnxRv2QEqn7V2X
         A+7M8kdkVbQbEI5OqWMZZLsRqEvg8CZPsP5iMdnpHV3Mw7/OU0/hWAgUSKmy4MizQxbD
         Zg5tK5+vQUMJBmJvu1rb1WaugetwBy2txx9MfukQ8NJO4ErrNm2jJt3shzBpV2f9xSb/
         5arSxa1BjmfBjFJS+VKoMCmOMkboC6CEZwJy34AivkY90cYZahEOpsZBr1QgjXdRuaH7
         RJP76IZ9c7FBBfC2/rbivYpa5JMUxpE+T1M/E/dtFUsqEWQOhLjSX7D6WqwYNQ6H9PQb
         RB0w==
X-Forwarded-Encrypted: i=1; AJvYcCX0iQR0KecUQtO8+TIpzjz3r6BI9AmPYJs24c6OwWBppaBzeLWmORtWsT2aroiqcTh3zbyFLmC0B1BcLrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjybTj9qYEUsOgUw1a5S3NRa0oXf0lpNI1NxzjuOG7cdge9l30
	QhPrukzU5Vf5Xlr/efWxSjh//brqk2/P1o+Nb5U9HNfLikDu+3AvuLr58L2lIpwqSFsol3gys74
	8tFinzA==
X-Google-Smtp-Source: AGHT+IEf2CEnlJGHZtsmzrHqeOd1ndTjoACnl8CdMuKToTrbMjiAb+CrTNoHK0d+D+dNU6wwE2PLQDR3nAM=
X-Received: from pjbsk5.prod.google.com ([2002:a17:90b:2dc5:b0:325:9cb3:419e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c45:b0:327:b824:2257
 with SMTP id 98e67ed59e1d1-327b8242bbemr4417101a91.32.1756426000789; Thu, 28
 Aug 2025 17:06:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 28 Aug 2025 17:06:11 -0700
In-Reply-To: <20250829000618.351013-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829000618.351013-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829000618.351013-12-seanjc@google.com>
Subject: [RFC PATCH v2 11/18] KVM: TDX: Fold tdx_mem_page_record_premap_cnt()
 into its sole caller
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ira Weiny <ira.weiny@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Fold tdx_mem_page_record_premap_cnt() into tdx_sept_set_private_spte() as
providing a one-off helper for effectively three lines of code is at best a
wash, and splitting the code makes the comment for smp_rmb()  _extremely_
confusing as the comment talks about reading kvm->arch.pre_fault_allowed
before kvm_tdx->state, but the immediately visible code does the exact
opposite.

Opportunistically rewrite the comments to more explicitly explain who is
checking what, as well as _why_ the ordering matters.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 49 ++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index fe0815d542e3..06dd2861eba7 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1608,29 +1608,6 @@ static int tdx_mem_page_aug(struct kvm *kvm, gfn_t gfn,
 	return 0;
 }
 
-/*
- * KVM_TDX_INIT_MEM_REGION calls kvm_gmem_populate() to map guest pages; the
- * callback tdx_gmem_post_populate() then maps pages into private memory.
- * through the a seamcall TDH.MEM.PAGE.ADD().  The SEAMCALL also requires the
- * private EPT structures for the page to have been built before, which is
- * done via kvm_tdp_map_page(). nr_premapped counts the number of pages that
- * were added to the EPT structures but not added with TDH.MEM.PAGE.ADD().
- * The counter has to be zero on KVM_TDX_FINALIZE_VM, to ensure that there
- * are no half-initialized shared EPT pages.
- */
-static int tdx_mem_page_record_premap_cnt(struct kvm *kvm, gfn_t gfn,
-					  enum pg_level level, kvm_pfn_t pfn)
-{
-	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
-
-	if (KVM_BUG_ON(kvm->arch.pre_fault_allowed, kvm))
-		return -EIO;
-
-	/* nr_premapped will be decreased when tdh_mem_page_add() is called. */
-	atomic64_inc(&kvm_tdx->nr_premapped);
-	return 0;
-}
-
 static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn,
 				     enum pg_level level, kvm_pfn_t pfn)
 {
@@ -1641,14 +1618,30 @@ static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn,
 		return -EIO;
 
 	/*
-	 * Read 'pre_fault_allowed' before 'kvm_tdx->state'; see matching
-	 * barrier in tdx_td_finalize().
+	 * Ensure pre_fault_allowed is read by kvm_arch_vcpu_pre_fault_memory()
+	 * before kvm_tdx->state.  Userspace must not be allowed to pre-fault
+	 * arbitrary memory until the initial memory image is finalized.  Pairs
+	 * with the smp_wmb() in tdx_td_finalize().
 	 */
 	smp_rmb();
-	if (likely(kvm_tdx->state == TD_STATE_RUNNABLE))
-		return tdx_mem_page_aug(kvm, gfn, level, pfn);
 
-	return tdx_mem_page_record_premap_cnt(kvm, gfn, level, pfn);
+	/*
+	 * If the TD isn't finalized/runnable, then userspace is initializing
+	 * the VM image via KVM_TDX_INIT_MEM_REGION.  Increment the number of
+	 * pages that need to be mapped and initialized via TDH.MEM.PAGE.ADD.
+	 * KVM_TDX_FINALIZE_VM checks the counter to ensure all mapped pages
+	 * have been added to the image, to prevent running the TD with a
+	 * valid mapping in the mirror EPT, but not in the S-EPT.
+	 */
+	if (unlikely(kvm_tdx->state != TD_STATE_RUNNABLE)) {
+		if (KVM_BUG_ON(kvm->arch.pre_fault_allowed, kvm))
+			return -EIO;
+
+		atomic64_inc(&kvm_tdx->nr_premapped);
+		return 0;
+	}
+
+	return tdx_mem_page_aug(kvm, gfn, level, pfn);
 }
 
 static int tdx_sept_link_private_spt(struct kvm *kvm, gfn_t gfn,
-- 
2.51.0.318.gd7df087d1a-goog


