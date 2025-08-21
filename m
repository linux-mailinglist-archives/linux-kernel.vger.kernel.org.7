Return-Path: <linux-kernel+bounces-780688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA9EB3080D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F030AC5553
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAC92FC037;
	Thu, 21 Aug 2025 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C8kRdhxr"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CAC2FC019
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755810070; cv=none; b=dhIwCV0FBrZ3tsWhuZKUQPUcoxVPCF7sWW6Z3pRYPjih7Tjr0mhee8+14eP7WTeFfll2Dk4gj4ZeEZa/jgxgMcDrw4InJxzXUHZa1MOiM7A+CjaNlzuwuB50rjTK3uTqu3YCQQNpsALTMAXUHjBZgVo+nrKcohBg1CWkjyUzywc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755810070; c=relaxed/simple;
	bh=/rGauErIcEbTihd1kj9EqXKbfxEybfai2HJzASnlsiA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XsNqPojaDLsDa3fRWG3fXtFSqV+vI10+iJY4LFnFOYWumPm/LLcH6ZphywE0IMOZ5cupwdX+nqqTsawFsh9GJ2pRTxeeOtAvGPRgD0HIxQJ/raTMal/EVb6EqUDfnMtJSBCp6gc4mHQ43GIeSvZ/WlXEMCJ95f54kznn28iPvpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C8kRdhxr; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2430c5d4d73so30800355ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755810068; x=1756414868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=icfTHb8SQC6RmkA9MWOb7kih1+f1PvZwwwoiEq7I/xQ=;
        b=C8kRdhxr1I3j6M52akPXOoBvk5YsSCvMpvVl6rEz78vkoi7O0Q/dkK/9ovnumw3D8j
         sADmJjjaOO7emsvod2l6ax91NqFTns3L0NWBHCw66dy8GDgWtKWfHrfBa8XqTv40aoug
         dPrf3K3ZZAAR3AjIoW/1joHY9tvAqzxtLbWfoRjqkrMplw0vO1LT3J0D9ZzCNDmo9rBq
         UBjZpVqC/KlNe5ez5DUssmksons4BO+GJI2aoXcBKUOFRLTwschi8MoTt/DPu/S0e92l
         2WGvNbHDdZXc986Uird38U6sfwkizHHeRVsKag28vkTimhPVMmmIzAO9YQcnpmWQxcQx
         l8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755810068; x=1756414868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=icfTHb8SQC6RmkA9MWOb7kih1+f1PvZwwwoiEq7I/xQ=;
        b=bmeIkQrVNKJ08Hs5YK7ORwsqGrUJAx+g0+hRZNGcbPd/NXxYtyydHAtOfq1A4tJc41
         AvvAEwwwJLvwD6wFeX00GrbxY7jXgkwEWDIlOiuv6pN0ReHINMGEUf/WgJiSkrA+rBFw
         d6gz6tm+QqToIpye5bRajuF1LB4U0en2JpIdLAHil6KHB4oDMwQ03X6HfcZ5cidy9G98
         sFnjta02h1gi1U/8yopp8wSqnlq4uUVRwhCmQXxVPaG10vm/QA8fae/2R7PW5GO6bYq3
         j2xwluSCz+HA4guSU+waCl6zRGH44/b1kF5i32FlwezAUl1l28mFLrmJJ3akC1J052vF
         oJAA==
X-Forwarded-Encrypted: i=1; AJvYcCVL4PFPFpWOEewznKamb8qxeIJA3BFiQ80DHTCZcjD3jLqwPGxxzaU2ZM5hLArtHgLwDZ0bWzdHvn6WA6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9wKy5h5B2URetMTju95d5A1YJrj+yFlnG3rJ7Zi8qiOjc57QX
	LX+CqZpWnqokMHJhnYE6USU/mh5LHGhqZe5tQbNaWyt2NaLTvDu3rPimrXeJhK8FvmBxix8Qwq/
	6DEkb6A==
X-Google-Smtp-Source: AGHT+IGG1PqwX+83Kz6lqMiL38vZquJagXjtigRLo1tbtN6yx1WhHPa1mZrTLmDFk+AuwMqOxdw4+SZNGP8=
X-Received: from pjx7.prod.google.com ([2002:a17:90b:5687:b0:311:ef56:7694])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a68:b0:233:d3e7:6fd6
 with SMTP id d9443c01a7336-2460248450emr47706545ad.19.1755810068184; Thu, 21
 Aug 2025 14:01:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 21 Aug 2025 14:00:39 -0700
In-Reply-To: <20250821210042.3451147-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821210042.3451147-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250821210042.3451147-14-seanjc@google.com>
Subject: [RFC PATCH 13/16] KVM: arm64: Stash "mmu_seq" in "struct kvm_page_fault"
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Track the MMU notifier sequence count snapshot in "struct kvm_page_fault"
in anticipation of moving the mmap_lock-protected code to a separate
helper.  Attaching mmu_seq to the fault could also prove useful in the
future, e.g. for additional refactorings.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/include/asm/kvm_host.h | 1 +
 arch/arm64/kvm/mmu.c              | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 4d131be08d8d..6a99f7fa065d 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -430,6 +430,7 @@ struct kvm_page_fault {
 	unsigned long hva;
 	kvm_pfn_t pfn;
 	struct page *page;
+	unsigned long mmu_seq;
 
 	struct {
 		vm_flags_t vm_flags;
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index aa6ee72bef51..575a4f9f2583 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1471,7 +1471,6 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	int ret = 0;
 	bool writable, force_pte = false;
 	bool s2_force_noncacheable = false;
-	unsigned long mmu_seq;
 	struct kvm *kvm = vcpu->kvm;
 	struct vm_area_struct *vma;
 	void *memcache;
@@ -1612,7 +1611,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	 * Rely on mmap_read_unlock() for an implicit smp_rmb(), which pairs
 	 * with the smp_wmb() in kvm_mmu_invalidate_end().
 	 */
-	mmu_seq = vcpu->kvm->mmu_invalidate_seq;
+	fault->mmu_seq = vcpu->kvm->mmu_invalidate_seq;
 	mmap_read_unlock(current->mm);
 
 	fault->pfn = __kvm_faultin_pfn(fault->slot, fault->gfn,
@@ -1691,7 +1690,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 
 	kvm_fault_lock(kvm);
 	pgt = vcpu->arch.hw_mmu->pgt;
-	if (mmu_invalidate_retry(kvm, mmu_seq)) {
+	if (mmu_invalidate_retry(kvm, fault->mmu_seq)) {
 		ret = -EAGAIN;
 		goto out_unlock;
 	}
-- 
2.51.0.261.g7ce5a0a67e-goog


