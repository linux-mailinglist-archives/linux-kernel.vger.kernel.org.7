Return-Path: <linux-kernel+bounces-780686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED07B307DA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E69A7B62C35
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06DC2ED17B;
	Thu, 21 Aug 2025 21:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ReqCBufE"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FB62ECD2E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755810067; cv=none; b=k+50tU3s1WiLzYZogMXNeHXsZcXz6PmG5mfmoKUhh4A73AwYtKgEudQcVUdLyg6ulR86cnGtUudS01b64NVU//GHzHmYTct/6oMyXcVAgYoULb9Tbux1NVt+k214srCpxQqU9d62f7HNlzUBbiHNGrpepZkgug2e7grY8/HEOfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755810067; c=relaxed/simple;
	bh=6TQp1XTfTlSOYUWOIWGmda/8IL4quEzAyAn5KTiu3gY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W6AMA/qOHx5BIYA6orFEegzky/04sWze35Xbs/lgxitiDK+6P9z4YtN3LiKCChkLrj84STzdrdNNBPYKkdzdl0r03ZciTDmzbvTDbOPe0o/P4sFd3YU+SsLmaXxEeUzGc2NtLyVic7x/FSQ9dNuh7Vf552lU6IYpcqDrem4PVMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ReqCBufE; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-324e349ef5fso1576930a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755810065; x=1756414865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=l3aBAqBLvvziXAff3l7qHBrH3ii9s2uHCbYHv1XlpUE=;
        b=ReqCBufEBL+WAS3niF0MGbH5VOX7BmmiO2G2jtbbk2aWb594Y7a0AosIGfQ+f8D9ZC
         aMQs1VflvZ7fgDgf62xs0h9sPz8DvmXJ9AHQ5GW5R7LzKFAWUjVZs8wN5cHqHTgaPuiW
         nFM08jBBbDBNIwXwhQ9wz7g34PUIQ8kB6VL7pHZbZQe6WaU+c/AdIolcIi9DZSZ9cH+w
         aCof68ZJTTKk0jTyxiQV/x+eeiWa5Iub3Z1eucH96MxUxvjPpeEcjpPv+p8s4elil2ht
         6wVIY5HARim2kDas9E1+H2Uw6wd5+uVxI4hE//Xc2WefZCWYO+L0zh81X2N4Eh4GVg81
         P+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755810065; x=1756414865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3aBAqBLvvziXAff3l7qHBrH3ii9s2uHCbYHv1XlpUE=;
        b=WLpjU9AnHKuG/xpd4FFUJ4X87Q1A6j0iSDh87VNs2msSF+yEXrypgWG25NM9FNaI86
         MhC6hBTnRp4ooP0nsHS298WD6DOB5/uQtlke66FeGlyGUfdunzuwyDO6aNPRP2EQzyhU
         Mon/Wtpxdk4FtS5c0FPQ/k7p54+2FHDCdnFvm2JqGb7mNKoBp9uYNV/vk+DUUHeHhmj5
         Bhv9AVADLQ5Bv+aYqfkRHP7knXGM0hLCvpiYhjyQ+xPmiVg5Hi6MYV7t0qG08dGhor24
         9npNF1kcgndwfmGnJjfZ5DcnElnMQa/q3jlNNvF5Oxg4jlmtoulrl3ooiyShjoFRFFpo
         j4PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgr7FThhXud9Ja4588hWcD7jTPXNE6bu8IeClQTUUxVFk1tzsNt3BDTtVZsNRndy92CnuAt0IKLoPDg3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+9rsWM484LqHGtmfIOCq6IzWZd3bPSDlU/Le2tdmduS935Im9
	wyi+ncQTNftq9OgDaZLBLqXmOEB4w8RLeKbiDQddta63QTc5Xdj+5eYeEU0j14RmUuHI2YsqyKY
	I0WaF3w==
X-Google-Smtp-Source: AGHT+IHyv2vSy5H3gPx/CMXMIii4nN/TDg0JEF0C1pJibiyBy90Nx8cGqdPBlytbuWHgL7DJUzJnyJ3Kweo=
X-Received: from pjbee11.prod.google.com ([2002:a17:90a:fc4b:b0:312:187d:382d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2c87:b0:324:ec53:1385
 with SMTP id 98e67ed59e1d1-32515e36b2emr1212430a91.10.1755810064638; Thu, 21
 Aug 2025 14:01:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 21 Aug 2025 14:00:37 -0700
In-Reply-To: <20250821210042.3451147-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821210042.3451147-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250821210042.3451147-12-seanjc@google.com>
Subject: [RFC PATCH 11/16] KVM: arm64: Drop local mte_allowed, use vm_flags snapshot
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop user_mem_abort()'s local mte_allowed and instead use the vm_flags
snapshot.  The redundant variables aren't problematic per se, but will be
quite awkward when a future change moves the vm_flags snapshot into
"struct kvm_page_fault".

Opportunistically drop kvm_vma_mte_allowed() and open code the vm_flags
check in the memslot preparation code, as there's little value in hiding
VM_MTE_ALLOWED (arguably negative "value), and the fault path can't use
the VMA-based helper (because looking at the VMA outside of mmap_lock is
unsafe).

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/mmu.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index e1375296940b..b85968019dd4 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1454,11 +1454,6 @@ static void sanitise_mte_tags(struct kvm *kvm, kvm_pfn_t pfn,
 	}
 }
 
-static bool kvm_vma_mte_allowed(struct vm_area_struct *vma)
-{
-	return vma->vm_flags & VM_MTE_ALLOWED;
-}
-
 static bool kvm_vma_is_cacheable(struct vm_area_struct *vma)
 {
 	switch (FIELD_GET(PTE_ATTRINDX_MASK, pgprot_val(vma->vm_page_prot))) {
@@ -1475,7 +1470,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
 	int ret = 0;
 	bool writable, force_pte = false;
-	bool mte_allowed, is_vma_cacheable;
+	bool is_vma_cacheable;
 	bool s2_force_noncacheable = false;
 	unsigned long mmu_seq;
 	struct kvm *kvm = vcpu->kvm;
@@ -1606,7 +1601,6 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	}
 
 	fault->gfn = fault->ipa >> PAGE_SHIFT;
-	mte_allowed = kvm_vma_mte_allowed(vma);
 
 	vm_flags = vma->vm_flags;
 
@@ -1724,7 +1718,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 
 	if (!fault->is_perm && !s2_force_noncacheable && kvm_has_mte(kvm)) {
 		/* Check the VMM hasn't introduced a new disallowed VMA */
-		if (mte_allowed) {
+		if (vm_flags & VM_MTE_ALLOWED) {
 			sanitise_mte_tags(kvm, fault->pfn, vma_pagesize);
 		} else {
 			ret = -EFAULT;
@@ -2215,7 +2209,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 		if (!vma)
 			break;
 
-		if (kvm_has_mte(kvm) && !kvm_vma_mte_allowed(vma)) {
+		if (kvm_has_mte(kvm) && !(vma->vm_flags & VM_MTE_ALLOWED)) {
 			ret = -EINVAL;
 			break;
 		}
-- 
2.51.0.261.g7ce5a0a67e-goog


