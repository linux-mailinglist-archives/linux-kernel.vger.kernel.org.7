Return-Path: <linux-kernel+bounces-780685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F122FB307FC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 445EB1CE3C2A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183392ECE81;
	Thu, 21 Aug 2025 21:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R5XsgzO9"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84AE2EBDE3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755810065; cv=none; b=Q9sZduKDWj8IbaySwIYIovd9ah5BtC+SYfFM9Sgdis6Yz9nNlMK/QhTj899+OlWsfeBVMkoEvB63sU+i1vs+XMrhstesBKokpMYuEzETrWUrjhvvnW6J2gMlyvfOk1cQSKrqERG26WByeY7BQjb9OCCiCqLF5APBfrhj0j59G2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755810065; c=relaxed/simple;
	bh=+61MIfhB12OoqxvOVjd5E5G1e4moY0EeyCZxMuVXI2c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M7VaJvdQ5l6qWbq0U14OvBS9ZFmlbws+LvstM0JgLOBKIFhYBTLz0srfpsslvY3Po38PbYyBVHYwAZHqS6mtLcs3JQrS9eFMTvPZh9//ZkSeqwtgiyKmn8yOwCE2TOhHVPlENML6Eb0ZqdktrYlylxPIANVOY1rrXJFuizzI7DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R5XsgzO9; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323267915ebso2927568a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755810063; x=1756414863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=AynODOx7TIbccej4ZjLdZ9RTKEuSncfsehCPn6XLS1g=;
        b=R5XsgzO9H4uNNwkJ8wrNoLeMkTtiRX93cbSF67qMrObobIlWvZ42vo8e6REG5IqW2O
         fO2RDue0jUL0+oNZMjS0JD0PhBO4ZPGLlFv6H2OP1lO62oSrIo+qEPuwdIBpK0klsRX5
         6KC0Ghn+YZ2TAYJHsWe0VFq2yE2yLdun2xZPEInA6E+F5cZDYCz7amWm6LiWc870lm9a
         27xOM/HX5nb2i9popNJnyjwoeI8yyUACLmrn4VLDxiKeHLSUl5jmboazZm3gYl8IBiOA
         TnQGFLaDVCnOnPfxmgPUk5l5EbO2irwKD5ogFB2dc3EyS6sbUJqAyd0INX5ojDTW5QRT
         fohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755810063; x=1756414863;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AynODOx7TIbccej4ZjLdZ9RTKEuSncfsehCPn6XLS1g=;
        b=xUoHa50RUNx9qQN+MITyorLAKLnSUYqDsl96oLyZ3aTFoMR9yIhBaEMi8em8S/JVQI
         PSPfrdmPE+bT3OkCqOjSOxy4ibxuHU8FLLstFODCMvWNwC3NorkqCo7TDdd/aIFelrDe
         arjZZKZx5xzCjp9tEakZZDeBRJCyQuOYPVI8jsiW7XwunRkR5XBk3kOWFEom0BzTfOVs
         lGx2OmQVUVZNkdr037U5sFbsffkFPQanZSRTolPPS+IhrNh7goBwvcg9Kk0IhEegL1I7
         o6dxcsRYH33rzO80Pkooo1bc1bx1QuUeJUOjkURBLZGgZEYHUzpsojLGE0rw0uT9oLJ0
         5PQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm7vuKfk7wcyhXMtmJeQA/7Wr4rxNeXDKpkIVnIbpuGDcSUngU11F006vojGFPfyfTYnE+Dz7/Uhi9IMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIm7vbltT00TrPFcu95VVes7wzog7FfE56NYRWHWTQjhizHLjS
	NaOadCtO58GP7xBPvBvCQxrJfA9CeTV+X7NpCNTb7jWnNy99+8y3jPV33y5ONqt1HQkXGCWjxIl
	1J/Md+A==
X-Google-Smtp-Source: AGHT+IEVYwl5YEkw1vqENiDixKFNtOSSF5og6sdGONTLhDTmarsazTWsy/GXacXJvdeMD+BKnVg4vh8e0tk=
X-Received: from pjbsd14.prod.google.com ([2002:a17:90b:514e:b0:321:78e7:57fb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b4c:b0:31e:d929:5ca5
 with SMTP id 98e67ed59e1d1-32515e2230emr1041388a91.1.1755810063041; Thu, 21
 Aug 2025 14:01:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 21 Aug 2025 14:00:36 -0700
In-Reply-To: <20250821210042.3451147-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821210042.3451147-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250821210042.3451147-11-seanjc@google.com>
Subject: [RFC PATCH 10/16] KVM: arm64: Drop local vfio_allow_any_uc, use
 vm_flags snapshot
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop user_mem_abort()'s local vfio_allow_any_uc variable and instead use
the vm_flags snapshot.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/mmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 10c73494d505..e1375296940b 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1476,7 +1476,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	int ret = 0;
 	bool writable, force_pte = false;
 	bool mte_allowed, is_vma_cacheable;
-	bool s2_force_noncacheable = false, vfio_allow_any_uc = false;
+	bool s2_force_noncacheable = false;
 	unsigned long mmu_seq;
 	struct kvm *kvm = vcpu->kvm;
 	struct vm_area_struct *vma;
@@ -1608,8 +1608,6 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	fault->gfn = fault->ipa >> PAGE_SHIFT;
 	mte_allowed = kvm_vma_mte_allowed(vma);
 
-	vfio_allow_any_uc = vma->vm_flags & VM_ALLOW_ANY_UNCACHED;
-
 	vm_flags = vma->vm_flags;
 
 	is_vma_cacheable = kvm_vma_is_cacheable(vma);
@@ -1741,7 +1739,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		prot |= KVM_PGTABLE_PROT_X;
 
 	if (s2_force_noncacheable) {
-		if (vfio_allow_any_uc)
+		if (vm_flags & VM_ALLOW_ANY_UNCACHED)
 			prot |= KVM_PGTABLE_PROT_NORMAL_NC;
 		else
 			prot |= KVM_PGTABLE_PROT_DEVICE;
-- 
2.51.0.261.g7ce5a0a67e-goog


