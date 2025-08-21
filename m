Return-Path: <linux-kernel+bounces-780682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59056B30807
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4268517653C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC762D7DE2;
	Thu, 21 Aug 2025 21:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KCt+FlwH"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49662EB5C1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755810060; cv=none; b=jKIVKbVXSh2tbdaNLcf3oQuYSW1RGkfp1weMNcTZ0VILT1lSzlD8rhIADMKYJpWgyNM/FLUtz5sywrkLgzZdPN++uY6gBACycG5P/NwddsDvmCfAYNJtKm/grbLQJIx0Rmvaq8ymhswt6aairSsGLpa5QjMaQmhleQI931PJRCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755810060; c=relaxed/simple;
	bh=n2xHKJwW4GBGQxPu8+45mca9yh0HIcvMkQScT1xXiwY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iPlbsdkaHJ1RqBsYQTH1zL8MD4Y61uloFmzH4waSnueVZL6R1IocUUxWHmFb+2yvIa0qOuzGMEVUOtmmLBLygL1LMkVGXhav1RN5K99Kfc/PONAs2+jZfaG0EJOuLumctgJDonOhz3fOI7Yn7Nb1tj2JpDQCuvwg1Uc5ZACJCcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KCt+FlwH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-325228e9bedso98120a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755810058; x=1756414858; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=rIYjUyPKKDdCEejXmfDWcQPbYLUJJKvCpdBRdQ8wgkk=;
        b=KCt+FlwH6VXzt0dpgSqkbvSf/1t7MEFsfE4bf1+QBOwfMFeEkpungqKo95kdp0HgKE
         R9zU1km7MqPzvlrOJID6aWx8ufyjukPWa5OW1sBkruBuVi/oPpfn05z/MneCQ9PsoBPg
         DgEymskxfvXt8jrr7lgtWNS3jM+H+3xx8OkKPqwdc/qRfM0vRWmjCXs2wiihaAdghkLs
         oL3sINNbEmhKoXMBNxewfX3MYH55nsKbYfPgxVlN4cfMZaGUzyTqjtBjR3qgNrkRFih7
         Pd6pXw16kqbOIA5/yH9/U0/ZXH+hN9Bgcr4qAb7GFC0dFRyQVFcKFNZ/7K065EyFVNtm
         qTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755810058; x=1756414858;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rIYjUyPKKDdCEejXmfDWcQPbYLUJJKvCpdBRdQ8wgkk=;
        b=va3/grU5S38jnV5oGDXj1/Qn2aPUwy1LQnZPmjJRuV3hk+7zxX/bIo4L0Lqdnop67r
         cXH2Mnhf14aFYGks9Z8bkq4zkjenPl/g3eWxCBBgPHs3Km2MI44bFlcO6t7HXG7P9SnZ
         63FSq59UiXnubJzQmM0LzJRlzwCL8GgOk2k4nKHMS1u5XxLyoctZICEbGyolXBBFUWD/
         N8ICzOhwLdngNjCr3X491fk3nYmMce2LDwkWXcN4ogaLG86fW3E7dN11tkq1VpJ3eJuj
         jb8Pcyv0zVqG+jY5mbSioiUXcgu8Dn7VLvWEciwsQCEFZmCe8ybE1+0Ze2vZAy+eqFA+
         +AjA==
X-Forwarded-Encrypted: i=1; AJvYcCVJw9kgE3cBvqG4YpbekFCswTYA5jidJdpO0zboCaTnL/z0Hw30FWZawv8EeXyAeXH70EIA5PXTJ9blO/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3wwDirJo/itlXBDb/u8T5haiGWcrt9/3+jOpBTIi9DOnEbKT2
	lUWTPFRBwH1qf5IBstuV62cZkA1hZxcTMnMaISvI88iOaHxjy24t4VFgdOL71GswQE8jhEzsjLt
	TUQqm0A==
X-Google-Smtp-Source: AGHT+IGevG4sJg+U1oYZiyIkXuxzC5L9OjooNDxBFWaxTZvDjCA0pb211437o2pCDdf6DI+kKvb4PRBSGWk=
X-Received: from pjbrr6.prod.google.com ([2002:a17:90b:2b46:b0:323:247f:7f59])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d610:b0:31f:762c:bc40
 with SMTP id 98e67ed59e1d1-32515e54409mr1117649a91.16.1755810058080; Thu, 21
 Aug 2025 14:00:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 21 Aug 2025 14:00:33 -0700
In-Reply-To: <20250821210042.3451147-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821210042.3451147-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250821210042.3451147-8-seanjc@google.com>
Subject: [RFC PATCH 07/16] KVM: arm64: Pass @fault to fault_supports_stage2_huge_mapping()
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Pass the full kvm_page_fault object when querying if a fault supports a
hugepage mapping instead of passing the separate slot+address pair.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/mmu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 047aba00388c..c6aadd8baa18 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1287,10 +1287,10 @@ static void kvm_send_hwpoison_signal(unsigned long address, short lsb)
 	send_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb, current);
 }
 
-static bool fault_supports_stage2_huge_mapping(struct kvm_memory_slot *memslot,
-					       unsigned long hva,
+static bool fault_supports_stage2_huge_mapping(struct kvm_page_fault *fault,
 					       unsigned long map_size)
 {
+	struct kvm_memory_slot *memslot = fault->slot;
 	gpa_t gpa_start;
 	hva_t uaddr_start, uaddr_end;
 	size_t size;
@@ -1348,8 +1348,8 @@ static bool fault_supports_stage2_huge_mapping(struct kvm_memory_slot *memslot,
 	 * userspace_addr or the base_gfn, as both are equally aligned (per
 	 * the check above) and equally sized.
 	 */
-	return (hva & ~(map_size - 1)) >= uaddr_start &&
-	       (hva & ~(map_size - 1)) + map_size <= uaddr_end;
+	return (fault->hva & ~(map_size - 1)) >= uaddr_start &&
+	       (fault->hva & ~(map_size - 1)) + map_size <= uaddr_end;
 }
 
 /*
@@ -1368,7 +1368,7 @@ transparent_hugepage_adjust(struct kvm *kvm, struct kvm_page_fault *fault)
 	 * sure that the HVA and IPA are sufficiently aligned and that the
 	 * block map is contained within the memslot.
 	 */
-	if (fault_supports_stage2_huge_mapping(fault->slot, fault->hva, PMD_SIZE)) {
+	if (fault_supports_stage2_huge_mapping(fault, PMD_SIZE)) {
 		int sz = get_user_mapping_size(kvm, fault->hva);
 
 		if (sz < 0)
@@ -1547,7 +1547,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	switch (vma_shift) {
 #ifndef __PAGETABLE_PMD_FOLDED
 	case PUD_SHIFT:
-		if (fault_supports_stage2_huge_mapping(fault->slot, fault->hva, PUD_SIZE))
+		if (fault_supports_stage2_huge_mapping(fault, PUD_SIZE))
 			break;
 		fallthrough;
 #endif
@@ -1555,7 +1555,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		vma_shift = PMD_SHIFT;
 		fallthrough;
 	case PMD_SHIFT:
-		if (fault_supports_stage2_huge_mapping(fault->slot, fault->hva, PMD_SIZE))
+		if (fault_supports_stage2_huge_mapping(fault, PMD_SIZE))
 			break;
 		fallthrough;
 	case CONT_PTE_SHIFT:
-- 
2.51.0.261.g7ce5a0a67e-goog


