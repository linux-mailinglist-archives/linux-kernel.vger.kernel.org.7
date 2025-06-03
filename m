Return-Path: <linux-kernel+bounces-671178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B42ACBDC5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 01:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023993A2EE8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 23:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713AC1991DD;
	Mon,  2 Jun 2025 23:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VTLstTQm"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FE22AE6C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Jun 2025 23:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748908136; cv=none; b=IjDbgQ8lkcS+S/Yq+IcB+AuzncDokUqHkm6Nnu34oVuaWlpyQN3ZzdgnEBtT+1U1N8ZB6/KDwpnxePgOE86XyDkKOZe0lAVJ5DM3K/XZfpNpIy9bYFXyQCgSlquMSiIZggcKVBv4MrkSsaq2AqCfECPF6XHsd/0J0SQ4OAdywm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748908136; c=relaxed/simple;
	bh=gsy3eEjSnbYMBE0wUJXrbHDurn+rASnYkoRk/QpGGew=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kB776yOPY+K+/LIUjlL+eYKtq4lPgrLnTajXoUVrByOXMI/y91U/qjYQD6UXNKUECs/ho2A/cwaydeJtV6n0QHBfUtjU15owSJquvYJ//7NQTdLLzCvWtN9PVIHsC1EUw+C4kbUG/R1a0j97tH2kifcLyyfcdvbC93jRvTED0Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VTLstTQm; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b090c7c2c6aso3164224a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jun 2025 16:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748908135; x=1749512935; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3aXcom7K3AYa+uBZzM5ecHbi/BcH+kyA4Qs4DNsym0=;
        b=VTLstTQmmrY8u5H2pqRt6125jQdrj2VfgmSBpNCUHnHtEKBiQyQ+nhge42EI6oEmq2
         hx9pL+U2dsf6xjqKbXVL2uFEdSzZQY28q4u+IMbrtbBRaDS7BFuxiIOOKUI7rC8G9aRH
         EfLQ83iFrzcoZNv3tr7CZBwyQz7G94yXJl15rhg3I0YB1wuD8L0iZDEjqTGKvxc11wot
         LjFarISx+3LaUA/6XATPHizIFJfVn7MIU49ArC9QtXmFVvLq6T072T/Oa1YmqYKtPZ0H
         fPN6o4EgHySvPaKF8q9GYx4wFoayM4UlcdrZne6g8KhSoVM64mdQbyFmtpL7xmPe0odc
         z1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748908135; x=1749512935;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L3aXcom7K3AYa+uBZzM5ecHbi/BcH+kyA4Qs4DNsym0=;
        b=r7m7626M0jgOTWuoa/eWfyFhy70CanaUTIsDa6ScnTdnS0rj7a/bIEfbQTxn3YjdvB
         59fREjpFejs+HdPDT8x/KiqR5MhhmIKwxa9F9AFO6bPLgHQ2GplyyCV4bB7j/w6vITsC
         VjrCVc9SyxU4CUcgexJK1+mTzbSPfzhYtU1rXXAGQkZ0XrD7dQg2dYfA5LzSNwqN5GYM
         mzheG8C0qlpZ2LyjcmVH3NyrveB4ShQ5tNUKjtogkleYZlmSA/QAsH4qild5yRAX42nF
         lWknREnYOf2aAAhL+Ts9s+iAQafihVt5lSmbtYZo5kRYVcu64gr4huyNgNlYil9Feaj4
         T0dw==
X-Forwarded-Encrypted: i=1; AJvYcCWlw9W/6TEZobBZ3qanANlb5X0Ak9wvuIlC3h2YfBBc92+lx6NEwxTJW3POl5O6oaEjfqigJJrUEKofL38=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhSKlYgbx2eCVkxE9/njoyaS3MHkXcLgOsb70OCbHNSP0Wkfa2
	kRos/EZZJX8SCnJYkZeNKDS4lYE+fMBqx3YXxt8hghktaISd4SzPTFnBX+JhHOTpX26U63fK6Le
	yHuLLzg==
X-Google-Smtp-Source: AGHT+IHrW8lgam5hMs+q8Q41nDdQP7VjrdcQXqaqPJtcR+BjM+THP2Toplhq44lorb8g4sT9CHMEgvpWbMs=
X-Received: from plgo5.prod.google.com ([2002:a17:902:d4c5:b0:223:225b:3d83])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41c6:b0:235:225d:30a2
 with SMTP id d9443c01a7336-23539715c69mr214408135ad.48.1748908134726; Mon, 02
 Jun 2025 16:48:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon,  2 Jun 2025 16:48:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250602234851.54573-1-seanjc@google.com>
Subject: [PATCH] KVM: x86/mmu: Exempt nested EPT page tables from !USER,
 CR0.WP=0 logic
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jon Kohler <jon@nutanix.com>, Sergey Dyasli <sergey.dyasli@nutanix.com>
Content-Type: text/plain; charset="UTF-8"

Exempt nested EPT shadow pages tables from the CR0.WP=0 handling of
supervisor writes, as EPT doesn't have a U/S bit and isn't affected by
CR0.WP (or CR4.SMEP in the exception to the exception).

Opportunistically refresh the comment to explain what KVM is doing, as
the only record of why KVM shoves in WRITE and drops USER is buried in
years-old changelogs.

Cc: Jon Kohler <jon@nutanix.com>
Cc: Sergey Dyasli <sergey.dyasli@nutanix.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 68e323568e95..ed762bb4b007 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -804,9 +804,12 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	if (r != RET_PF_CONTINUE)
 		return r;
 
+#if PTTYPE != PTTYPE_EPT
 	/*
-	 * Do not change pte_access if the pfn is a mmio page, otherwise
-	 * we will cache the incorrect access into mmio spte.
+	 * Treat the guest PTE protections as writable, supervisor-only if this
+	 * is a supervisor write fault and CR0.WP=0 (supervisor accesses ignore
+	 * PTE.W if CR0.WP=0).  Don't change the access type for emulated MMIO,
+	 * otherwise KVM will cache incorrect access information in the SPTE.
 	 */
 	if (fault->write && !(walker.pte_access & ACC_WRITE_MASK) &&
 	    !is_cr0_wp(vcpu->arch.mmu) && !fault->user && fault->slot) {
@@ -822,6 +825,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 		if (is_cr4_smep(vcpu->arch.mmu))
 			walker.pte_access &= ~ACC_EXEC_MASK;
 	}
+#endif
 
 	r = RET_PF_RETRY;
 	write_lock(&vcpu->kvm->mmu_lock);

base-commit: 3f7b307757ecffc1c18ede9ee3cf9ce8101f3cc9
-- 
2.49.0.1204.g71687c7c1d-goog


