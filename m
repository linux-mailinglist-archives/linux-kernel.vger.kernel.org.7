Return-Path: <linux-kernel+bounces-787406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2028B375CF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B49E7C03FB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 00:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D68A4C98;
	Wed, 27 Aug 2025 00:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oT5qhpGY"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5312F145A1F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 00:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756253131; cv=none; b=HGxg3P+vuzwOPXFuUUBMT4xzJu4rlfXekx+H7jrv+trhdlQTA2DdGxX1XtXJ/1FSM3lOPu6q5SKu9uFm3ny6EpIEaLJdJFstiKPP2ljAez/+vOs2zvnJzE0finfgcSJ8wRDulyLmVqnaAAfqbanXpionDqYzjss7GszpT9eaitQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756253131; c=relaxed/simple;
	bh=vW84dOFfUkjEHn44SZ0Zsvc92V4JoabZ6ttehFhlzKs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dwe42rtDFLY+A+zt9+/YzpKxf3CIRfpyIC75BaHxrWddq/KcgppjfGZhPv14g2ASfgMLCZ1xh1xHqbyVCYEYGirJIORAnYX0VqkP6m8YnH13pFrySzEMIP4NixdEXBjhm+o92O9vFBQkH0noQtlWZC/RWbG4ks/eGWCQ91yLiCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oT5qhpGY; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e55665b05so5240444b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 17:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756253130; x=1756857930; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=x3mPFKRukU7NkaqqKkWEa4ZeQRYoB8uqLaKYEwqn56o=;
        b=oT5qhpGYKHDQGvTmVV5sf5dfMg3Vo+9Y9jI7EeC/yl8glgsGX0qf21tGaysEjoOd02
         OcoRXgWVTeNH8V08lnDgKuriXCXYWdTJEq55XgxN+aZ9QcMHebc0ahyh/xtK5wDslWiI
         ujY3XTrRLzDXUYCodR/5/1lP6Btc7pdVPcevOvYtf5YoRU34jwZQbmr1P+n6A/DPF/Ha
         kJY1bOzBb2D8dB0VA50nzWJvYWUTPInrqAZ9osmj1OTWf2wMXi6MMQvnL0OMvy2bWfWH
         nAD8HeY2Q8dNMij/+hTkim72NbUQJLSns2t5wQvOyZ3zX+koJUSms0EI7epGYw2E8hj7
         c4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756253130; x=1756857930;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x3mPFKRukU7NkaqqKkWEa4ZeQRYoB8uqLaKYEwqn56o=;
        b=GZZmMB00SPL9jn86fDJHUSA6UzsN/5SnsvUDmUT/cHWOymSjKPb0tTul9DQSrjLnPw
         hITTxl9qOzhzLnC2UI2vHdptHdleuhZ7aE4jVenOk/N/GK2rkSAeoU+CbR0ZZ5Y+iqxi
         zC0MzI0YuIyWivBfybSxOg/vRKBpHOQAHgdsHcE9pbJlmYIZIvoKYt3i5Q7w61sB6y/L
         gMywt67orPDHhtExMlQi0aCWJ8YiX0AEkUPx0tyCgqos3jPts7d9SST2u2Y6SVHE3YPR
         FTDy6iy22J/36m71Ds9yJfGaobXQhv9/YGkkgeG3+y98Pa+QOXGyZKO35WC5Zr2D6WXt
         3z1A==
X-Forwarded-Encrypted: i=1; AJvYcCU4CLK7Ip/hiWvDaGDb5+nVdUHK0H8e0ugjc2Y6JvzmK8ik+1WEDEGlfXGz3sqwwTU8sDgFngbKLSMGjDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+ZfNYOvJQ0DKiTnnxtKOksafazEyTK8ryJcX2vNSp6MzRJf1q
	quYown1HDxFaOd5GXhhvinb7BlVvFLj98U+4t8BDJlcJapsNlP2yHE+y9jfKwzXWOA8haqJjqux
	1M5iW5Q==
X-Google-Smtp-Source: AGHT+IHEnG3r0INUCs08n2KPXNY2BR+GnyTW8KVIP4RVEtBYEh4Xbo/b2ZM7vY3lAv7QzfEs08AdgYGVyfc=
X-Received: from pfx26.prod.google.com ([2002:a05:6a00:a45a:b0:771:fbc3:2406])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b4e:b0:771:ed83:557c
 with SMTP id d2e1a72fcca58-771ed835a5dmr8443892b3a.2.1756253129565; Tue, 26
 Aug 2025 17:05:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 26 Aug 2025 17:05:13 -0700
In-Reply-To: <20250827000522.4022426-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827000522.4022426-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250827000522.4022426-4-seanjc@google.com>
Subject: [RFC PATCH 03/12] Revert "KVM: x86/tdp_mmu: Add a helper function to
 walk down the TDP MMU"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"

Remove the helper and exports that were added to allow TDX code to reuse
kvm_tdp_map_page() for its gmem post-populated flow now that a dedicated
TDP MMU API is provided to install a mapping given a gfn+pfn pair.

This reverts commit 2608f105760115e94a03efd9f12f8fbfd1f9af4b.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu.h         |  2 --
 arch/x86/kvm/mmu/mmu.c     |  4 ++--
 arch/x86/kvm/mmu/tdp_mmu.c | 37 +++++--------------------------------
 3 files changed, 7 insertions(+), 36 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 697b90a97f43..dc6b965cea4f 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -257,8 +257,6 @@ extern bool tdp_mmu_enabled;
 #define tdp_mmu_enabled false
 #endif
 
-bool kvm_tdp_mmu_gpa_is_mapped(struct kvm_vcpu *vcpu, u64 gpa);
-int kvm_tdp_map_page(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code, u8 *level);
 int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn);
 
 static inline bool kvm_memslots_have_rmaps(struct kvm *kvm)
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d3625e00baf9..f532beed9029 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4900,7 +4900,8 @@ int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	return direct_page_fault(vcpu, fault);
 }
 
-int kvm_tdp_map_page(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code, u8 *level)
+static int kvm_tdp_map_page(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code,
+			    u8 *level)
 {
 	int r;
 
@@ -4942,7 +4943,6 @@ int kvm_tdp_map_page(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code, u8 *level
 		return -EIO;
 	}
 }
-EXPORT_SYMBOL_GPL(kvm_tdp_map_page);
 
 long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
 				    struct kvm_pre_fault_memory *range)
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 7f3d7229b2c1..1b559a50db51 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1910,13 +1910,16 @@ bool kvm_tdp_mmu_write_protect_gfn(struct kvm *kvm,
  *
  * Must be called between kvm_tdp_mmu_walk_lockless_{begin,end}.
  */
-static int __kvm_tdp_mmu_get_walk(struct kvm_vcpu *vcpu, u64 addr, u64 *sptes,
-				  struct kvm_mmu_page *root)
+int kvm_tdp_mmu_get_walk(struct kvm_vcpu *vcpu, u64 addr, u64 *sptes,
+			 int *root_level)
 {
+	struct kvm_mmu_page *root = root_to_sp(vcpu->arch.mmu->root.hpa);
 	struct tdp_iter iter;
 	gfn_t gfn = addr >> PAGE_SHIFT;
 	int leaf = -1;
 
+	*root_level = vcpu->arch.mmu->root_role.level;
+
 	for_each_tdp_pte(iter, vcpu->kvm, root, gfn, gfn + 1) {
 		leaf = iter.level;
 		sptes[leaf] = iter.old_spte;
@@ -1925,36 +1928,6 @@ static int __kvm_tdp_mmu_get_walk(struct kvm_vcpu *vcpu, u64 addr, u64 *sptes,
 	return leaf;
 }
 
-int kvm_tdp_mmu_get_walk(struct kvm_vcpu *vcpu, u64 addr, u64 *sptes,
-			 int *root_level)
-{
-	struct kvm_mmu_page *root = root_to_sp(vcpu->arch.mmu->root.hpa);
-	*root_level = vcpu->arch.mmu->root_role.level;
-
-	return __kvm_tdp_mmu_get_walk(vcpu, addr, sptes, root);
-}
-
-bool kvm_tdp_mmu_gpa_is_mapped(struct kvm_vcpu *vcpu, u64 gpa)
-{
-	struct kvm *kvm = vcpu->kvm;
-	bool is_direct = kvm_is_addr_direct(kvm, gpa);
-	hpa_t root = is_direct ? vcpu->arch.mmu->root.hpa :
-				 vcpu->arch.mmu->mirror_root_hpa;
-	u64 sptes[PT64_ROOT_MAX_LEVEL + 1], spte;
-	int leaf;
-
-	lockdep_assert_held(&kvm->mmu_lock);
-	rcu_read_lock();
-	leaf = __kvm_tdp_mmu_get_walk(vcpu, gpa, sptes, root_to_sp(root));
-	rcu_read_unlock();
-	if (leaf < 0)
-		return false;
-
-	spte = sptes[leaf];
-	return is_shadow_present_pte(spte) && is_last_spte(spte, leaf);
-}
-EXPORT_SYMBOL_GPL(kvm_tdp_mmu_gpa_is_mapped);
-
 /*
  * Returns the last level spte pointer of the shadow page walk for the given
  * gpa, and sets *spte to the spte value. This spte may be non-preset. If no
-- 
2.51.0.268.g9569e192d0-goog


