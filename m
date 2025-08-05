Return-Path: <linux-kernel+bounces-756874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A5CB1BAA2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41CA3180AF4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13922BCF4B;
	Tue,  5 Aug 2025 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bopbRLrb"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA6129DB65
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 19:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754420743; cv=none; b=GXV+JJySZiDvd4TP5sFWdZ9bmmutwRvfBscZj4qsOw454uC0nK0G8e/zNfI3fiSy7y+++RFVNpqS55kxjXRIDlp5sd3oK05p3DAGJHtbaWj3MEHnudX/OgSHkYTwdw+n2dIvSVM1zz2Z37FBN4Q0RvNfN1Taik96+jtgeNUeM6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754420743; c=relaxed/simple;
	bh=J3s/+HhO0F/23Anh4HAPKQwoROmPWYLeSlo9ij8W49k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nEYWMu7fXIFxk0qKOE/uL7jP0U6nNKRnTpjcNfDf7jyPwyQCXi3riorxznLdVwCMvZ5kMnGv5ihdqP+tOt6znn8HfMlbMtzO8Fv4fuhLyggcj9VhQ8YXE28fERdZjtx1/jUaJqvtX+XRCoTCKwn6Mvy9r5jvRWJi338mVFl/qas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bopbRLrb; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31332dc2b59so6201115a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 12:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754420740; x=1755025540; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=YozS3xn+VACq0+w8nwexO84fpxAPR1pw7uiWTT6tQo0=;
        b=bopbRLrbATJsDSF+5lYLguL8c8CmxJt/VQ/HEmlpupSzTlWWeNkU9kgoeXuekeQwfO
         S22at6wVdzLfonQlBb+gGP1N9nBnxlSMn246rNaBq+sazuP6nbrZapRoAH2g7N8gZdVC
         XUWoW3oZaa3Utn1lwGpARjrM31+rxrhbFYtg9dcKUUP888lzLKi3Ztk030aGdO8wiB3b
         4ERFyLJ2o8PYK2zHmv4cvPlVWy91cWtUk7AlKkwJN3TDbuVCLEKGfFfaVW8289pyILVk
         gRYkSC9DyXkAv57ZyOKPkLmNJOzzB5ePPfT85oVNQpwE2pbpB0D532CBj7dV9nUp3431
         2LOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754420740; x=1755025540;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YozS3xn+VACq0+w8nwexO84fpxAPR1pw7uiWTT6tQo0=;
        b=RhuibAn1kErhQ7qTdJ3dNLpkbLKUPrg0QrrBk6tecvADkLoDhRqd/tZ+t9+amo+4Oq
         p6g1tWIJU4DfR9VEgYJRdAInznROuDvM88BNcWEoArrLr6zAJD2UY+Ts9wf2677tMOH3
         VYIRuxA2nv9SAFluR0/bOOPeF7MtTBVO6eE+Gfl28lxTRfNLGB0w7HrF83DXE33G9QVW
         59P3LO+dB9Fq8P+hcC4/sW+JEAtdrN/kQ9ib73NM4Wo7VVRG/vyyGi+MYj2hI8jaHhqs
         n4ZCABAckdS19ja8kemCcUetRr2NaICtd+RAAMPe1A/0dT5o+2xuRp/Swgc+3e4vrD6A
         z2mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvMt3l6wPaDhdjABIB8bUEAdQhuL5F5+i+Oxa+T3BaM/cHko5A4Uf0pZ/8h9eCDRMx7kqHeBLfcvyvXZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaB93OA2AkyqDrWdyudYn864Ey/7zbFiZUbRkSN5M+aiwc2gmC
	YjyOGC5NBiiSqnxjFFPiLUVke3v4xb40y4/GptQ0lbvQwpBzwRKrh3LpIwUvdtZGx2cT84cNCvz
	0Ujuamg==
X-Google-Smtp-Source: AGHT+IHQCIBBLF4UPzRODvXLUW1O4/zaAQuZxCWjMgyqDmJ4I9AAEjiuFfAHOHrKIvXYXsSDfb0p1J6tmDo=
X-Received: from pjro3.prod.google.com ([2002:a17:90a:b883:b0:320:e3b2:68de])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17c2:b0:321:59e7:c5c2
 with SMTP id 98e67ed59e1d1-32159e7c6d8mr3836032a91.9.1754420739953; Tue, 05
 Aug 2025 12:05:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  5 Aug 2025 12:05:14 -0700
In-Reply-To: <20250805190526.1453366-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250805190526.1453366-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250805190526.1453366-7-seanjc@google.com>
Subject: [PATCH 06/18] KVM: x86: Acquire SRCU in WRMSR fastpath iff
 instruction needs to be skipped
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Xin Li <xin@zytor.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="UTF-8"

Acquire SRCU in the WRMSR fastpath if and only if an instruction needs to
be skipped, i.e. only if the fastpath succeeds.  The reasoning in commit
3f2739bd1e0b ("KVM: x86: Acquire SRCU read lock when handling fastpath MSR
writes") about "avoid having to play whack-a-mole" seems sound, but in
hindsight unconditionally acquiring SRCU does more harm than good.

While acquiring/releasing SRCU isn't slow per se, the things that are
_protected_ by kvm->srcu are generally safe to access only in the "slow"
VM-Exit path.  E.g. accessing memslots in generic helpers is never safe,
because accessing guest memory with IRQs disabled is unless unsafe (except
when kvm_vcpu_read_guest_atomic() is used, but that API should never be
used in emulation helpers).

In other words, playing whack-a-mole is actually desirable in this case,
because every access to an asset protected by kvm->srcu warrants further
scrutiny.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 63ca9185d133..69c668f4d2b6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2158,10 +2158,8 @@ fastpath_t handle_fastpath_set_msr_irqoff(struct kvm_vcpu *vcpu)
 {
 	u32 msr = kvm_rcx_read(vcpu);
 	u64 data;
-	fastpath_t ret;
 	bool handled;
-
-	kvm_vcpu_srcu_read_lock(vcpu);
+	int r;
 
 	switch (msr) {
 	case APIC_BASE_MSR + (APIC_ICR >> 4):
@@ -2177,19 +2175,16 @@ fastpath_t handle_fastpath_set_msr_irqoff(struct kvm_vcpu *vcpu)
 		break;
 	}
 
-	if (handled) {
-		if (!kvm_skip_emulated_instruction(vcpu))
-			ret = EXIT_FASTPATH_EXIT_USERSPACE;
-		else
-			ret = EXIT_FASTPATH_REENTER_GUEST;
-		trace_kvm_msr_write(msr, data);
-	} else {
-		ret = EXIT_FASTPATH_NONE;
-	}
+	if (!handled)
+		return EXIT_FASTPATH_NONE;
 
+	kvm_vcpu_srcu_read_lock(vcpu);
+	r = kvm_skip_emulated_instruction(vcpu);
 	kvm_vcpu_srcu_read_unlock(vcpu);
 
-	return ret;
+	trace_kvm_msr_write(msr, data);
+
+	return r ? EXIT_FASTPATH_REENTER_GUEST : EXIT_FASTPATH_EXIT_USERSPACE;
 }
 EXPORT_SYMBOL_GPL(handle_fastpath_set_msr_irqoff);
 
-- 
2.50.1.565.gc32cd1483b-goog


