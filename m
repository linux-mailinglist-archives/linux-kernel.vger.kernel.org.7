Return-Path: <linux-kernel+bounces-756875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0C7B1BAA1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88EAB18A6B96
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F982BD000;
	Tue,  5 Aug 2025 19:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XM8k8oCP"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6327729A32D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 19:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754420743; cv=none; b=KwrQ3FNECeRl1K/ScGfPlgDqVtNO0tRxa9N7Df6OUK7tcf4wTfEl/HNShAo0J62QFQbZ5gUv7ShxtKznCWi5DUGJMJokhP0O6Pa9Cd2P5NcP/m6PRrmB7HEEGR7cvoOdWz3RRn+1l9mk1CJU93CWizz1KtDMmURLa8opOi8+HuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754420743; c=relaxed/simple;
	bh=FjHicGFKJBMj6eqQRJA4zeVHrXkQNDh3WomaZ2JWU6w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gLFXHnXjCk1GL41LrAfX6fWRqEVPRwiJHZmQUHZD6k5Pf4mD0qTe82F0Kj2eARFiHQyCKx2v+Ql1uqP3Nh6Jf2cl89o5CnxjG1VgMBnNDv7hJGGyQFtR5fhnkdNcEHeh5DQNKJniSnzIQkI+LISsIRqY9aeaEYfLvYcpYnlmiQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XM8k8oCP; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31eac278794so6046148a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 12:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754420742; x=1755025542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=sD1yq2ng+3s/RvhfKS4rEdaP5yHsiyn1WT57oqE0wt8=;
        b=XM8k8oCPxx282wuw+6dbhLacCNonDw2E2pjSZ3pyz8/khplEZIRjLuyHRUmVqgkqRZ
         x7a7iV69Ct7tkoBpbg2GDL9zsrvxkr+LrXZgKhahWf6ugn2NKhmdOYlHle1wP56/iKNP
         0E1ilzdfu5XK7M5snBMpxSMefp1xFpCHmzOVcCziES6nKXKmx3xorI/ju8Re9pJnf0ay
         +y7+Mwpg90eU1wSpGoJl8gAsnT1BNhf8QjBD9qf3TLACvnG2oeGPcCTlgVisoExf561p
         sCttityu0MYtAcXiGj/ZNDNGzpKwB/hCJZiss5u7hVpWIdWNnhXGBaWKLa7CCa839u6O
         KsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754420742; x=1755025542;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sD1yq2ng+3s/RvhfKS4rEdaP5yHsiyn1WT57oqE0wt8=;
        b=ocfyv4vDS7jqZ5epWR3t/eBDfaUBwDWh0nEKu8tK9TlCCGwRGbtweW8YxKOxK/BDQs
         RdYYmH/SJRer2EQIcuc5Bz5Ctc6XqR8u3e2EGgUJ+VsHCUDk7h7oxpnvTLjSt9/UE0j8
         opl5sBczggLlZ+uplaXUvkqGZseG5AO1mNjONY30RiRZdoDM6LGLQBwDBLfD4bKoDmHC
         6pPVrrdViyOyJL/jgc2DWKOvLhMSATD6l4uzYZ2XM2LKlcI4UeLsYD3wa03DJughr9F4
         oAqcPeJa4ZHY8jTcyo0Tlh+0W1d6pqyp/DjDdQw21f3Ks0vCqBwYqYYVf1bPmTsKKUZw
         /C5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmFbURUtI3vMBiJ1TguaGHVo/+pr9pmvmWNryGgrKAGcZ9xiT/FpSgHPo8hLJR7aQVR4qChTZ/1wnQdkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd+9+hzxQxA7sV5mSK4WLYkAp9tEff/fgRqMX8ieDF2LHB+he8
	Wj8TBHjsDykxMAYRTWtnl+SHiLaUiDogZkoKv5r+vpUHUOSzQGgJt+Uxl80jidZoGjGSphUtLv2
	38tLTFw==
X-Google-Smtp-Source: AGHT+IFJUuShphCDKjpbJ4bBJ29lWr9wj20brYqPy6fH3C0e3fDw9eD2bFKuavKmEfXY9vwq/YetKdwwOJQ=
X-Received: from pjrz21.prod.google.com ([2002:a17:90a:bd95:b0:312:fb53:41c0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e84:b0:321:1df6:97d3
 with SMTP id 98e67ed59e1d1-3211df698c4mr15042572a91.4.1754420741580; Tue, 05
 Aug 2025 12:05:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  5 Aug 2025 12:05:15 -0700
In-Reply-To: <20250805190526.1453366-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250805190526.1453366-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250805190526.1453366-8-seanjc@google.com>
Subject: [PATCH 07/18] KVM: x86: Unconditionally grab data from EDX:EAX in
 WRMSR fastpath
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Xin Li <xin@zytor.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="UTF-8"

Always grab EDX:EAX in the WRMSR fastpath to deduplicate and simplify the
case statements, and to prepare for handling immediate variants of WRMSRNS
in the fastpath (the data register is explicitly provided in that case).
There's no harm in reading the registers, as their values are always
available, i.e. don't require VMREADs (or similarly slow operations).

No real functional change intended.

Cc: Xin Li <xin@zytor.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 69c668f4d2b6..e6c221f9b92e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2156,18 +2156,16 @@ static int handle_fastpath_set_tscdeadline(struct kvm_vcpu *vcpu, u64 data)
 
 fastpath_t handle_fastpath_set_msr_irqoff(struct kvm_vcpu *vcpu)
 {
+	u64 data = kvm_read_edx_eax(vcpu);
 	u32 msr = kvm_rcx_read(vcpu);
-	u64 data;
 	bool handled;
 	int r;
 
 	switch (msr) {
 	case APIC_BASE_MSR + (APIC_ICR >> 4):
-		data = kvm_read_edx_eax(vcpu);
 		handled = !handle_fastpath_set_x2apic_icr_irqoff(vcpu, data);
 		break;
 	case MSR_IA32_TSC_DEADLINE:
-		data = kvm_read_edx_eax(vcpu);
 		handled = !handle_fastpath_set_tscdeadline(vcpu, data);
 		break;
 	default:
-- 
2.50.1.565.gc32cd1483b-goog


