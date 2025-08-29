Return-Path: <linux-kernel+bounces-790879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A522B3AECD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832401C805EF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC2117A30A;
	Fri, 29 Aug 2025 00:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lH9rkEbs"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55787404E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 00:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756425989; cv=none; b=jB/4O68513qDQGfSU4IDjG53fftAC3H4q3sovCyRR+3B1GBc6KEJvm+ZfFFi49O1KnlyKejoZmKdBb0SVFElzTr3CWYOBqrrpbQxFXCmQTHBhYUmwY3DfNbLTw/4JZFVKmR+oWtTl6wOLd/BuEdbNAkWR98OwdE6ljAtpGLR+3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756425989; c=relaxed/simple;
	bh=+SN/7jwzsBSGX3ZaBL+TtK4mD4SxZwJY0/a1k70+r9I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nBv5zqoxcQyKjZYtvD8Z4Y2cWd4YCGB83v9bKD7d3x8fii8nphclUCxSlYT6BmqpEnGqhIwwhPa/8m5QxZelLdkohkF5FwCI3+8YHW7yDS+gt8VJSV6KaWUcL/ytY8v0ewllvR6kkwcwm7tXryzUhsTyNrZ2HmsxCU/wFy7xVL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lH9rkEbs; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b49de53348aso936638a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756425987; x=1757030787; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=IfvFc9viaP2S1pT15SAkIYCawAjZc30p7N/9YScLJsM=;
        b=lH9rkEbsFPOJjPknjc4SXPjeCmsVlbafN6X3/n6Zoc+w0d1ZhuXEHxmvlf8esEfLuM
         GoREXU3DszMGLQ9w7KUkBRAKrtujbYg3LYuqU7c+qlYZSGCcUbSURmfrPUWajgk2tBZ3
         0ZMtBmDDk6YSNYGIt0hT3R5B5TGdk+ivy6iNtKRytDkq7NYaKR9EVcO0Z4chxytXD0Ma
         soQt2cY0z6KOutwLAX9LZjB40+xWCQxtEup95hXGwza1q+AEa097pt81BdnGaGBub6FV
         W2zjPu0sUitLwjELpMzBs30AcyOoWzBzhuu/Jh2iVpLFyec6dHheKC4n2/2YxgA+hw2Z
         o5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756425987; x=1757030787;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IfvFc9viaP2S1pT15SAkIYCawAjZc30p7N/9YScLJsM=;
        b=YWfmboWUrJMeEzu9Km+FxJW6H8hd3mTlga//jqp33xoM76EfNFXP1HkKnQWCloehZP
         WuWft0RwZ96SpGOhT5KhvfGZShZdPAdi0sROMBSEdk+acJ7hmgoSX5M1xd9kETzSk0eP
         Fyfa4fVR3Mlz57cTcBGhAzjt0cBIwjDnAX7RM2Or5FRU40qbdXZ4Jj7EKmtuL0ptNcnc
         PGSxhCuRlsDk0j0lQ0apo8PoVuEJ1e2Ucl/DaJqs0cR/s+qVkrpOSrDFiavOI5muXyza
         NSkuE2Q7tCX0XnyuktTA8FBDaS7Kj3QNRs2vVHIEBA4B+JjnD5k8wfJP2pzKWuyWbiq0
         WHrg==
X-Forwarded-Encrypted: i=1; AJvYcCUy/ThrI30n1XBG1s5jEd4JM0fKcHsc61SXjkCeUg2L3pERNiyU6p2t5JSIuNbChXmwU0qMkuBwcImwjRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHrWU3D9/PlPdwcMEjAdxqYx2s/dZEj833u4V+2hiAiiENfDUH
	fH3LHxoDOwvnI1yFpHs+pSiHPVnIzYfnnCsHVi30+dXFpfVvWTxCcCMgwto8PVBPPrt8VqjWJnO
	cLcnJfQ==
X-Google-Smtp-Source: AGHT+IFQQpXTh6rHGsE3ofmt/dZ3Md25hDKkJ4b99R0cEkcoLYtIyYzC64YgEZMJ6vkZUCO2UTc7vcpF+CE=
X-Received: from pjvf13.prod.google.com ([2002:a17:90a:da8d:b0:31c:4a51:8b75])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f96:b0:240:792:e87a
 with SMTP id adf61e73a8af0-2438facc65cmr15373768637.3.1756425986990; Thu, 28
 Aug 2025 17:06:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 28 Aug 2025 17:06:03 -0700
In-Reply-To: <20250829000618.351013-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829000618.351013-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829000618.351013-4-seanjc@google.com>
Subject: [RFC PATCH v2 03/18] Revert "KVM: x86/tdp_mmu: Add a helper function
 to walk down the TDP MMU"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ira Weiny <ira.weiny@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Remove the helper and exports that were added to allow TDX code to reuse
kvm_tdp_map_page() for its gmem post-populate flow now that a dedicated
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
index 65300e43d6a1..f808c437d738 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4904,7 +4904,8 @@ int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	return direct_page_fault(vcpu, fault);
 }
 
-int kvm_tdp_map_page(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code, u8 *level)
+static int kvm_tdp_map_page(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code,
+			    u8 *level)
 {
 	int r;
 
@@ -4946,7 +4947,6 @@ int kvm_tdp_map_page(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code, u8 *level
 		return -EIO;
 	}
 }
-EXPORT_SYMBOL_GPL(kvm_tdp_map_page);
 
 long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
 				    struct kvm_pre_fault_memory *range)
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 31d921705dee..3ea2dd64ce72 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1939,13 +1939,16 @@ bool kvm_tdp_mmu_write_protect_gfn(struct kvm *kvm,
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
@@ -1954,36 +1957,6 @@ static int __kvm_tdp_mmu_get_walk(struct kvm_vcpu *vcpu, u64 addr, u64 *sptes,
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
2.51.0.318.gd7df087d1a-goog


