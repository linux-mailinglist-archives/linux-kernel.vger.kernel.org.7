Return-Path: <linux-kernel+bounces-780677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECF1B307EA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58DCD1D27CF4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946A82D7DD6;
	Thu, 21 Aug 2025 21:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lsr9lqNg"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26B32C0292
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755810051; cv=none; b=o6HmPeXCnGnu3IqjmOnu9Q0wca+1VTWGWFJ+g4DcoESNNuEpjNvjxwAN/1GVaqTYvqbWp3Tmqa9ogzbNUY392vEUWCwZeTUmOi/jA+y6q7Wvq0w0mBZZQKUyAwfxa8TZtb1Q4+X0cJNMcZh5zwSTtBOkM1GMIMmXxDZXkfzCT+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755810051; c=relaxed/simple;
	bh=cB2wU+VwA6nMuFS3kEdqkJ7/CjrceUGCWlda84QouGM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IPrT2ie2SW2MN/mE5e+D0Iyw5Ecrf6+LO4dQwFmvjBeVIlDSF/pUfMFdYYT5bLftV8qyKjFGa0JfSqlG88FpUb0gVkl2nbh6rSc5NuLuGswGB0iHJDH2+Uv9axYTbL4q3TvY+Fx4wqCYedUlEUKEMU9kAdlgc9tABXAo5B5IHTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lsr9lqNg; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2eb787f2so1601090b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755810049; x=1756414849; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8p7YeBTxxS/VBPTvK9WSiN+wfsnNOjaE+88NekfQ6+E=;
        b=lsr9lqNgEjKlvmUPopkoLBMh9W8ybx1XUxyC/3ObGwar1fo4Z6J2o6amNIfNbaGDYF
         +OukaoOJdeBWt159xUtRXkbbdCIxJECGBbUjUHgottYWjseeOU/EEtF/MMC8ZN5sqC7Z
         qoQO421MHeCaWDEpR0N+5JfGCZsqDbRpRExr3Onza8SDnXvyKB2Nhp0NuHidFrhgfuiH
         btO4p49mIxCNduBmRSbvYVYiM7QmZZ0HUFHB1myT0ByGWErgpHzrCHQ86NYjrhL6GrTo
         vJyUCyMXuBt9Kij5xF6osOjc3xSX8Bp0fHBWoZygUF1bif+roAcRalr2Y/t4TY86v5Cs
         vJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755810049; x=1756414849;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8p7YeBTxxS/VBPTvK9WSiN+wfsnNOjaE+88NekfQ6+E=;
        b=TtUxnX/+48k5QmNQ3kxvQaAm824FdPPcUN0AAHsoXFSYX0OIWzQxo8bEXebHrARWKs
         EJnEzgmUjJcnGp/+k4jH0c1d2F5MveVOxb24d8rEHw4EsL0my3eSKanl0ZyUXumNX8QU
         bOUlnBsrXMq3dbm0NgiToZaMJbiw6+6PeB63Be10X42QK7Qb+Z/m7Bvnc9pNF0VvIt+Y
         3FR531fFLaoaeGfLdPhOeyqb3DvRjAiOqQOg1cpq5iNjv4/+oeXdPxNCTrP991kp57IP
         +i6jncFzIWFJVeIyCUTvcdyv4zSfZBCvEUdep14Rsi/7JC6KCU/pM2H0jvEv/L8mVqM+
         qU6A==
X-Forwarded-Encrypted: i=1; AJvYcCXLI0wS5APErRze8OQF3mv4XlERjXlwh0K3mj4mT0ZnHTTfsZX6xuUAoNoLuvnvnwSJchZobyBHgrH7Xtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmTq6Ei7jwuS03usw9yWgKPapinA/5zV3Ip3QN/VCBlpG7RCbW
	Kchl85Ky401EXbkYIuNHqSjSaBVHKksGm7hMx1Fmy/80jwnMMzJBdD9NN/mCmAQP/sVCqnS/2uQ
	tmNPmhg==
X-Google-Smtp-Source: AGHT+IGt2jvAqXlXksEez/FBRFt8Sle4R/dEKQftz/3BlDA59KSR9+VVS2FqW+adpYm0FOfYkSzrZkam6NE=
X-Received: from pfbbq19.prod.google.com ([2002:a05:6a00:e13:b0:76c:2dcd:fdde])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a8e:b0:76c:1eae:fd30
 with SMTP id d2e1a72fcca58-7702fa02d0fmr1050269b3a.12.1755810049097; Thu, 21
 Aug 2025 14:00:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 21 Aug 2025 14:00:28 -0700
In-Reply-To: <20250821210042.3451147-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821210042.3451147-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250821210042.3451147-3-seanjc@google.com>
Subject: [RFC PATCH 02/16] KVM: arm64: Get iabt status on-demand
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Query if an abort was due to instruction execution only when necessary
in anticipation of factoring out the SRCU-protected portion of abort
handling to a separate helper.  The happy path doesn't need to check for
IAB, and eliminating the local variable will avoid having to pass a
large pile of booleans to the inner helper.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/mmu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index dc3aa58e2ea5..1e3ac283c519 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1830,7 +1830,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 	phys_addr_t ipa; /* Always the IPA in the L1 guest phys space */
 	struct kvm_memory_slot *memslot;
 	unsigned long hva;
-	bool is_iabt, write_fault, writable;
+	bool write_fault, writable;
 	gfn_t gfn;
 	int ret, idx;
 
@@ -1856,8 +1856,6 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 	if (KVM_BUG_ON(ipa == INVALID_GPA, vcpu->kvm))
 		return -EFAULT;
 
-	is_iabt = kvm_vcpu_trap_is_iabt(vcpu);
-
 	if (esr_fsc_is_translation_fault(esr)) {
 		/* Beyond sanitised PARange (which is the IPA limit) */
 		if (fault_ipa >= BIT_ULL(get_kvm_ipa_limit())) {
@@ -1869,7 +1867,8 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 		if (fault_ipa >= BIT_ULL(VTCR_EL2_IPA(vcpu->arch.hw_mmu->vtcr))) {
 			fault_ipa |= kvm_vcpu_get_hfar(vcpu) & GENMASK(11, 0);
 
-			return kvm_inject_sea(vcpu, is_iabt, fault_ipa);
+			return kvm_inject_sea(vcpu, kvm_vcpu_trap_is_iabt(vcpu),
+					      fault_ipa);
 		}
 	}
 
@@ -1931,7 +1930,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 		 * anything about this (there's no syndrome for a start), so
 		 * re-inject the abort back into the guest.
 		 */
-		if (is_iabt) {
+		if (kvm_vcpu_trap_is_iabt(vcpu)) {
 			ret = -ENOEXEC;
 			goto out;
 		}
-- 
2.51.0.261.g7ce5a0a67e-goog


