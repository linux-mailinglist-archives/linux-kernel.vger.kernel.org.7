Return-Path: <linux-kernel+bounces-879076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CD6C2231B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE1B560DFF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B88A34D38C;
	Thu, 30 Oct 2025 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZTi4/1Mu"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AC8346FC7
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761855068; cv=none; b=Ba13dP6Yz+6+6qh1Q5M3WQ0veaU5iyJJc9Fq+L+AWOlvE8n/ZzFrv+Qvqo9Rd/HPwq/Z5h06GIVSgh3tOeNdgytn/lVJOFtXLlmSBiaWZl4q6KSWtnVmIwp2fV+gHlIRvaBL+E31WX1jlMSq+gazDSFJ1A5GePcOoeS9lpZCxFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761855068; c=relaxed/simple;
	bh=BNSOEKa28oWXqKHW7RuSRcfta2Y9XobgHdriosWTdaA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RmLmG1ZT5jliKMMz5I1/Y5hkOLGViE/np4GZipEGsPfCk7Ieq5gTU3JKnogokUMTaF5LhAYNgv36Dxq7SOPF5/pd2+MW1WIQIz2uEgCgHOINMIrYmj6YKutzWn1SBu62vO4JKU4zJqSaGyYjDriAG9pETov5RyqXf6KW+DY79mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZTi4/1Mu; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32ee4998c50so1121914a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761855065; x=1762459865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=gJtCncfCK9X54oXx991KGpYhmmpTyjjcLT5mmtOhZeY=;
        b=ZTi4/1Muxx6qDWUNt3cEFU7xcCSnSIePEwQ12PKIX2DNkRxj11o/CA9NZGc+1A9oFc
         fbBdQ9CCAJPNFfeiL5zGcJJWuH4W6RV47jTfs2v5Jr9vqUON+AABZGbBBSB7p9BQJNML
         HCPvgc3wP+fbm6Jcx6u6gFSY5y9ii/+6J+mTXq1m2yLt6Zuoi0cDJjxXWUXTzhsiPZ5U
         4wLaLYO3gTtqdK0JmhgbF6PvqLC0BKLqvvFjfE1aqG0cj/Sm1fCeNXkCAnh3eHCT9HnM
         rpclILEZG+aQyQcBwfW41LWYyz8ZSt2AhOvSe2Q1b/UVoX0kF73HE7bwtZclofIi6lW0
         SZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761855065; x=1762459865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJtCncfCK9X54oXx991KGpYhmmpTyjjcLT5mmtOhZeY=;
        b=PVo3xpuawOl8RRBcNpmz68WsdA/ob8hkgL5CkILHVriW0S1q18oI+fMXbXmkwDW7cH
         OmArAqptmEorIFYqHRUnTb6jwcjrgaZNj+Z1D9J12tV90SGJe4vGC4MB4Sk3Mmqb6SRn
         Y3RLrzqOtdidevet500p1yl811SDaWr5mIXfIldAguTH59KTvAUIswmVPTRLyFtTT3ba
         +HNpibsIjg2CW99GI6keauLnPOW1b95KOlBh/y/5H0WHSRCTkCQWd0kEGcU1BpuC3HVn
         jX0zvl7V89dURPaRkndN22Vh0Cb94+tFG+0RFG3aZ3rwQWqV0FRKnoeqr/hztV+2XZ7A
         v3Og==
X-Forwarded-Encrypted: i=1; AJvYcCVmII1xNI2BrOTbfncqfbUugt2PeZ0fHlA/BPOmtpgU2lVfJRCOCbGm72B+9Nio6dKGm4q2RNsu52ljv+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6TC8h3W8II00LqoqtGE8GumuRcQ54G5Kwiw93ojD3rtV7APak
	xWtfdljgRZ3wrpweQlSCQQ9OJBHp/xnvhtCEpoKZ6XYlzu3Am6a7TpUV8aEuQBjnVD0gUcSwGwP
	/hgRteQ==
X-Google-Smtp-Source: AGHT+IGHOQLpfyFznvDWNUH7H5RRwumwXl+ad4M1fU9LKzyWdjNf4lBkOJxqkb3vWAdXWhUIZ0D4LKjuEDo=
X-Received: from pjd14.prod.google.com ([2002:a17:90b:54ce:b0:339:ee20:f620])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e4d:b0:32e:528c:60ee
 with SMTP id 98e67ed59e1d1-34083055b02mr1449393a91.24.1761855065570; Thu, 30
 Oct 2025 13:11:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 30 Oct 2025 13:09:50 -0700
In-Reply-To: <20251030200951.3402865-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030200951.3402865-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030200951.3402865-28-seanjc@google.com>
Subject: [PATCH v4 27/28] KVM: TDX: Bug the VM if extending the initial
 measurement fails
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
	Kai Huang <kai.huang@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

WARN and terminate the VM if TDH_MR_EXTEND fails, as extending the
measurement should fail if and only if there is a KVM bug, or if the S-EPT
mapping is invalid.  Now that KVM makes all state transitions mutually
exclusive via tdx_vm_state_guard, it should be impossible for S-EPT
mappings to be removed between kvm_tdp_mmu_map_private_pfn() and
tdh_mr_extend().

Holding slots_lock prevents zaps due to memslot updates,
filemap_invalidate_lock() prevents zaps due to guest_memfd PUNCH_HOLE,
vcpu->mutex locks prevents updates from other vCPUs, kvm->lock prevents
VM-scoped ioctls from creating havoc (e.g. by creating new vCPUs), and all
usage of kvm_zap_gfn_range() is mutually exclusive with S-EPT entries that
can be used for the initial image.

For kvm_zap_gfn_range(), the call from sev.c is obviously mutually
exclusive, TDX disallows KVM_X86_QUIRK_IGNORE_GUEST_PAT so the same goes
for kvm_noncoherent_dma_assignment_start_or_stop(), and
__kvm_set_or_clear_apicv_inhibit() is blocked by virtue of holding all
VM and vCPU mutexes (and the APIC page has its own non-guest_memfd memslot
and so can't be used for the initial image, which means that too is
mutually exclusive irrespective of locking).

Opportunistically return early if the region doesn't need to be measured
in order to reduce line lengths and avoid wraps.  Similarly, immediately
and explicitly return if TDH_MR_EXTEND fails to make it clear that KVM
needs to bail entirely if extending the measurement fails.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 8bcdec049ac6..762f2896547f 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -3123,21 +3123,23 @@ static int tdx_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 
 	put_page(src_page);
 
-	if (ret)
+	if (ret || !(arg->flags & KVM_TDX_MEASURE_MEMORY_REGION))
 		return ret;
 
-	if (arg->flags & KVM_TDX_MEASURE_MEMORY_REGION) {
-		for (i = 0; i < PAGE_SIZE; i += TDX_EXTENDMR_CHUNKSIZE) {
-			err = tdh_mr_extend(&kvm_tdx->td, gpa + i, &entry,
-					    &level_state);
-			if (err) {
-				ret = -EIO;
-				break;
-			}
-		}
+	/*
+	 * Note, MR.EXTEND can fail if the S-EPT mapping is somehow removed
+	 * between mapping the pfn and now, but slots_lock prevents memslot
+	 * updates, filemap_invalidate_lock() prevents guest_memfd updates,
+	 * mmu_notifier events can't reach S-EPT entries, and KVM's internal
+	 * zapping flows are mutually exclusive with S-EPT mappings.
+	 */
+	for (i = 0; i < PAGE_SIZE; i += TDX_EXTENDMR_CHUNKSIZE) {
+		err = tdh_mr_extend(&kvm_tdx->td, gpa + i, &entry, &level_state);
+		if (TDX_BUG_ON_2(err, TDH_MR_EXTEND, entry, level_state, kvm))
+			return -EIO;
 	}
 
-	return ret;
+	return 0;
 }
 
 static int tdx_vcpu_init_mem_region(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *cmd)
-- 
2.51.1.930.gacf6e81ea2-goog


