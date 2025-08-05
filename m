Return-Path: <linux-kernel+bounces-756943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C47B1BB5A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 22:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7DDB18A6539
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CCA29A9FE;
	Tue,  5 Aug 2025 20:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LNgajVf8"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB0728136B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 20:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754425354; cv=none; b=guyS+bBNsrBLd3KDxcQLomEARkFjs1pGbbVSCtrHNuWJ2CG8qn8rFuyayqCfT92crOzThyFbUnGRTmh82YDkQdEgYsSANMP5nB4YJykv4RTPKa8HPAnn7qb6lpajENS9hNk4TNNfWq1I0BreqmIv/xeGyBe9r3qvQMM3bHbJsc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754425354; c=relaxed/simple;
	bh=UJgmB/Ob4AoVZGt7xKkirFQmgZBvEN8yyFQqgRG07jE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AUQwGjpnlpmTYGaEzjQ/5T6QCV8pgc1/WZu/eHwt2iHwAh7KvYG9OhE+3BG9e1ag7ZaQvvh/ZjCfubk4a1g6GIMqAlzOK2xom61HiSXbq8IuJrI8gh69Gebybr8w1HX6WSTqf5e/IjVKboe2QcTS12hdEv8s5T1nYnelGcdV7E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LNgajVf8; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31f74a64da9so6764110a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 13:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754425352; x=1755030152; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hVdzLN8sL24VDPUeSwih1MH9qTKCVxqUydN6MJPX8eQ=;
        b=LNgajVf8hR7ARBuOTlmqFhBla9uUS5uUsCbqxl1m/TYdQxDR4eoqAtnm75EwT4IwrN
         ioGivrmBUyY2DhmQcf55FPrBt/Klitl/XqramIiLwdYq2BkpZiyYbPJIw5VObT311cPC
         ssb8FTwZ53WCbzvvYYov4TnB9lbzJytbPZr9SZFF2ksNHmZS46nv0n1v65qViCzUiJdP
         hWJdCeebmZc0xFGfJKolHUhWWJS1qE1EV9NUz3ZB/nR8ezExt/gPysSwOaK4pUaHUGil
         2nZNuadHvCrsMRqh4BGhsFc2VHlFZWBH3FzOkmd8sRuZreOiBejP4oB00+wbUdlm7bu7
         84vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754425352; x=1755030152;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hVdzLN8sL24VDPUeSwih1MH9qTKCVxqUydN6MJPX8eQ=;
        b=gNK+jwt3YkTqpzI6iwK5iRJ5FrO0F46/iIYXQNyHy81+t2dLKepKNmvvfyCUloE+hg
         /sAssMYt+K6WkIoYyAurOZFmMFkUNW6lIMuhgtowdTt2Avt8rR6X2Z1JhTtJ+WF9B7AS
         fuW7YY1HZGWSxuOoEeZoFz1V3oWetWYg1byEQyldxkzhOLocbL/C1PjSI7+1nNWlujkM
         j+Z6jZ8QAPW6FJzde1nbaCtnYyEZBB6GsE82SyR81H8Am3xWxJlXr3tgx3he3nwvMr15
         JSkzuwG+5YtPWjeCheJidtjO0cV7ZXTZxPimB3hcos2J0UIjJqE55fCXnUKp1Dsa7Bt2
         PGLA==
X-Forwarded-Encrypted: i=1; AJvYcCXLZtmTGNTuP9NQuiEC9HfU6a/dV5GkEvhqBmLH/hAANu3UzzSJPttk5m6yCwFJIVHEBv6d+2Um7wRwW+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRK1ZjRGHL97UfPtMxRXQD5ZCaWaVvcV33OJsJnBMrBIrtBxeU
	/n5v+iAtet5mooXzBHIPOkpdwHX8N75Mwb4kALLY/oOtoreztglx6V7iwa7ylSETYPB2+Uo/lIz
	Iv0658g==
X-Google-Smtp-Source: AGHT+IFN/daddyCjGSfBUXDE3umrKXqLhMKLGZOT2guDNhYn6MZXS/lzN74VrFw4eL7k99H8xccG0Nf0VGI=
X-Received: from pjro15.prod.google.com ([2002:a17:90a:b88f:b0:31f:1dad:d0a4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:524f:b0:312:e8ed:758
 with SMTP id 98e67ed59e1d1-32166c20054mr214109a91.13.1754425352370; Tue, 05
 Aug 2025 13:22:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  5 Aug 2025 13:22:20 -0700
In-Reply-To: <20250805202224.1475590-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250805202224.1475590-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250805202224.1475590-3-seanjc@google.com>
Subject: [PATCH v3 2/6] KVM: x86: Rename local "ecx" variables to "msr" and
 "pmc" as appropriate
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, Xin Li <xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"

Rename "ecx" variables in {RD,WR}MSR and RDPMC helpers to "msr" and "pmc"
respectively, in anticipation of adding support for the immediate variants
of RDMSR and WRMSRNS, and to better document what the variables hold
(versus where the data originated).

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5af2c5aed0f2..d3afb875133e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1572,10 +1572,10 @@ EXPORT_SYMBOL_GPL(kvm_get_dr);
 
 int kvm_emulate_rdpmc(struct kvm_vcpu *vcpu)
 {
-	u32 ecx = kvm_rcx_read(vcpu);
+	u32 pmc = kvm_rcx_read(vcpu);
 	u64 data;
 
-	if (kvm_pmu_rdpmc(vcpu, ecx, &data)) {
+	if (kvm_pmu_rdpmc(vcpu, pmc, &data)) {
 		kvm_inject_gp(vcpu, 0);
 		return 1;
 	}
@@ -2026,23 +2026,23 @@ static int kvm_msr_user_space(struct kvm_vcpu *vcpu, u32 index,
 
 int kvm_emulate_rdmsr(struct kvm_vcpu *vcpu)
 {
-	u32 ecx = kvm_rcx_read(vcpu);
+	u32 msr = kvm_rcx_read(vcpu);
 	u64 data;
 	int r;
 
-	r = kvm_get_msr_with_filter(vcpu, ecx, &data);
+	r = kvm_get_msr_with_filter(vcpu, msr, &data);
 
 	if (!r) {
-		trace_kvm_msr_read(ecx, data);
+		trace_kvm_msr_read(msr, data);
 
 		kvm_rax_write(vcpu, data & -1u);
 		kvm_rdx_write(vcpu, (data >> 32) & -1u);
 	} else {
 		/* MSR read failed? See if we should ask user space */
-		if (kvm_msr_user_space(vcpu, ecx, KVM_EXIT_X86_RDMSR, 0,
+		if (kvm_msr_user_space(vcpu, msr, KVM_EXIT_X86_RDMSR, 0,
 				       complete_fast_rdmsr, r))
 			return 0;
-		trace_kvm_msr_read_ex(ecx);
+		trace_kvm_msr_read_ex(msr);
 	}
 
 	return kvm_x86_call(complete_emulated_msr)(vcpu, r);
@@ -2051,23 +2051,23 @@ EXPORT_SYMBOL_GPL(kvm_emulate_rdmsr);
 
 int kvm_emulate_wrmsr(struct kvm_vcpu *vcpu)
 {
-	u32 ecx = kvm_rcx_read(vcpu);
+	u32 msr = kvm_rcx_read(vcpu);
 	u64 data = kvm_read_edx_eax(vcpu);
 	int r;
 
-	r = kvm_set_msr_with_filter(vcpu, ecx, data);
+	r = kvm_set_msr_with_filter(vcpu, msr, data);
 
 	if (!r) {
-		trace_kvm_msr_write(ecx, data);
+		trace_kvm_msr_write(msr, data);
 	} else {
 		/* MSR write failed? See if we should ask user space */
-		if (kvm_msr_user_space(vcpu, ecx, KVM_EXIT_X86_WRMSR, data,
+		if (kvm_msr_user_space(vcpu, msr, KVM_EXIT_X86_WRMSR, data,
 				       complete_fast_msr_access, r))
 			return 0;
 		/* Signal all other negative errors to userspace */
 		if (r < 0)
 			return r;
-		trace_kvm_msr_write_ex(ecx, data);
+		trace_kvm_msr_write_ex(msr, data);
 	}
 
 	return kvm_x86_call(complete_emulated_msr)(vcpu, r);
-- 
2.50.1.565.gc32cd1483b-goog


