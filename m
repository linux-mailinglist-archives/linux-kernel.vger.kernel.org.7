Return-Path: <linux-kernel+bounces-780684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2574B30805
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB974AC3F50
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72882ECD1A;
	Thu, 21 Aug 2025 21:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cwKJD32e"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316F52EB850
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755810063; cv=none; b=PMUBxATU17gtfgf26pqhz1UTc/JED/oTiACHnd+Uq3VqjRDt/vNFXZ9LF5pFNMHGIZqc9J4+B6JGSmBRtAnZL+AfMC8oDKMPFwDLhm/XfcGBaX0tcH3MoZ7+is/vo8pusuUnMZdp0omoBFcdnHwtUCIoAYHhokqNH3WFL1UXQrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755810063; c=relaxed/simple;
	bh=0R29yrVz5jzSSmRWFh2gn4ID37EkSuIqGvyigwjoDgA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aX8R4IPCfOkEDZ1T2f9+4xaM7G3AVH/aVp5/+k2rKu9EodZ446fCjg30+x00WJjoc6TLyuA5R++NwUBQCqvzCOZwfneRd5XPpjh0p2TlIA+MTMyJTywBl+yXFSX+1T3Vc/Itar3Ecckpd6DoN7eyGKISjWNKV7j2jay96YY2Hhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cwKJD32e; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2ead3b51so2634907b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755810061; x=1756414861; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=nw5kiI6YvAO2RXGdtpyjseVagbE32KnshmO9YLBiZhk=;
        b=cwKJD32eDxl4KrLcFaPwH0YY7f+s5Pel07H5WP0Hs5sf/t8VnVNw9Kcl8NZFO9Ulgg
         R1y46ltsjgQFnmIrKIyY2jOZMpnr6PcxugcHn5nLrNj2MyAtMnAx96ItTUarlgil1da4
         4JT9n/fFGrKZbmBrJ+rxMjw5uG8S/7W6J/Y1RXUUGBSDeoqAQl1rq19mQolAgPIAfHMq
         BgF65J6rRkEtITPqJlzq/pG2rXbIeUmEs7KvHvq2JY7rHSQGojauAcro8QSGvsDF4RQ7
         RuWooBVXy/NowH9aslCzyK9Xyj+sDHbJOsPHjDL0kqrEvmbAA6IBeqT1b/TcAsqOKBht
         OEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755810061; x=1756414861;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nw5kiI6YvAO2RXGdtpyjseVagbE32KnshmO9YLBiZhk=;
        b=D2ejpxujF+Comlp71nHjnj2m8/OIggjx3fnFVTWMxWEP1V1Nqg1GiuY5DuZ+AlGfoj
         eL2ytJoDe0lyWR0odeHhPqkjwUgr80o1Ohx8xjaYLCYGJQ3c0yRtILMrl9cd50tsCzey
         0RanBmJU42nTOwhKUHO1BFOds227P8bHMuB/7npOETfuywuJl57aMe+vgfL/XEX/jAkd
         RA5mRhVUBGnmjG5aEOJmjNpPLO8brZL7d5e4RYF2JvgjbOYkqOi1wuBypWsD37YdKQt9
         Vk/Kwkml0xQmFf2Uq3ChkcKVj64tY6Wq2UgrmYqK+4DoMrfPncY6IK7tYud3S3Cp1WG3
         zZvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfLAKmKmPjBU+pHqQbXBPHSpSmYY3Bq86bBipiNPKZgv+C2CmjqcPhcQnLhX0BtQiN+ofqkVYpm+PgGxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJUFnKxlLtUARPpwZYuIbok4PN3uN8KZOPMY13gFzJnqDTyCAH
	qWlvSnukPFEhBReRfi4m3nLtkYKoaePADWiXx7HdZZ81QfLr6YPbCIBlL9FmeXFRZC5I5U5lLDZ
	zUvQmKg==
X-Google-Smtp-Source: AGHT+IGle6xFEs66cx8IStkT7ygYTzBQ/CVc9BMQ/qOuDjmd3FaQf765ZcadOYjVlZz3dCJkQZna0ErFQAI=
X-Received: from pgww17.prod.google.com ([2002:a05:6a02:2c91:b0:b42:189a:ccf8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1582:b0:240:9126:2bde
 with SMTP id adf61e73a8af0-24340d5e4cemr792496637.46.1755810061454; Thu, 21
 Aug 2025 14:01:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 21 Aug 2025 14:00:35 -0700
In-Reply-To: <20250821210042.3451147-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821210042.3451147-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250821210042.3451147-10-seanjc@google.com>
Subject: [RFC PATCH 09/16] KVM: arm64: Track perm fault granule in "struct kvm_page_fault"
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Add permission fault granule information to "struct kvm_page_fault", to
help capture that the granule is a property of the fault, and to make the
information readily available, e.g. without needing to be explicitly
passed if it's needed by a helper.

Opportunistically drop kvm_vcpu_trap_get_perm_fault_granule() and simply
grab the granule from the passed-in ESR.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/include/asm/kvm_emulate.h |  9 ---------
 arch/arm64/include/asm/kvm_host.h    |  1 +
 arch/arm64/kvm/mmu.c                 | 13 ++++++-------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 8065f54927cb..93e7a0bad0fb 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -449,15 +449,6 @@ bool kvm_vcpu_trap_is_translation_fault(const struct kvm_vcpu *vcpu)
 	return esr_fsc_is_translation_fault(kvm_vcpu_get_esr(vcpu));
 }
 
-static inline
-u64 kvm_vcpu_trap_get_perm_fault_granule(const struct kvm_vcpu *vcpu)
-{
-	unsigned long esr = kvm_vcpu_get_esr(vcpu);
-
-	BUG_ON(!esr_fsc_is_permission_fault(esr));
-	return esr_fsc_perm_fault_granule(esr);
-}
-
 static __always_inline bool kvm_vcpu_abt_issea(const struct kvm_vcpu *vcpu)
 {
 	switch (kvm_vcpu_trap_get_fault(vcpu)) {
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 4623cbc1edf4..ec6473007fb9 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -418,6 +418,7 @@ struct kvm_page_fault {
 	const bool exec;
 	const bool write;
 	const bool is_perm;
+	const u64  granule;
 
 	phys_addr_t fault_ipa; /* The address we faulted on */
 	phys_addr_t ipa; /* Always the IPA in the L1 guest phys space */
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index c6aadd8baa18..10c73494d505 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1483,14 +1483,12 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	short vma_shift;
 	void *memcache;
 	bool logging_active = memslot_is_logging(fault->slot);
-	long vma_pagesize, fault_granule;
+	long vma_pagesize;
 	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R;
 	struct kvm_pgtable *pgt;
 	vm_flags_t vm_flags;
 	enum kvm_pgtable_walk_flags flags = KVM_PGTABLE_WALK_HANDLE_FAULT | KVM_PGTABLE_WALK_SHARED;
 
-	if (fault->is_perm)
-		fault_granule = kvm_vcpu_trap_get_perm_fault_granule(vcpu);
 	VM_BUG_ON(fault->write && fault->exec);
 
 	if (fault->is_perm && !fault->write && !fault->exec) {
@@ -1715,8 +1713,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	 * backed by a THP and thus use block mapping if possible.
 	 */
 	if (vma_pagesize == PAGE_SIZE && !(force_pte || s2_force_noncacheable)) {
-		if (fault->is_perm && fault_granule > PAGE_SIZE)
-			vma_pagesize = fault_granule;
+		if (fault->is_perm && fault->granule > PAGE_SIZE)
+			vma_pagesize = fault->granule;
 		else
 			vma_pagesize = transparent_hugepage_adjust(kvm, fault);
 
@@ -1754,10 +1752,10 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 
 	/*
 	 * Under the premise of getting a FSC_PERM fault, we just need to relax
-	 * permissions only if vma_pagesize equals fault_granule. Otherwise,
+	 * permissions only if vma_pagesize equals fault->granule. Otherwise,
 	 * kvm_pgtable_stage2_map() should be called to change block size.
 	 */
-	if (fault->is_perm && vma_pagesize == fault_granule) {
+	if (fault->is_perm && vma_pagesize == fault->granule) {
 		/*
 		 * Drop the SW bits in favour of those stored in the
 		 * PTE, which will be preserved.
@@ -1806,6 +1804,7 @@ static int __kvm_handle_guest_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa
 		.write = kvm_is_write_fault(vcpu),
 		.exec  = kvm_vcpu_trap_is_exec_fault(vcpu),
 		.is_perm = esr_fsc_is_permission_fault(esr),
+		.granule = esr_fsc_is_permission_fault(esr) ? esr_fsc_perm_fault_granule(esr) : 0,
 	};
 	struct kvm_s2_trans nested_trans;
 	bool writable;
-- 
2.51.0.261.g7ce5a0a67e-goog


