Return-Path: <linux-kernel+bounces-756876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D089B1BAA4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD1F18A6C2F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1DB29DB65;
	Tue,  5 Aug 2025 19:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A5qUfrX9"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3367929A9ED
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754420745; cv=none; b=b+h/sKPTMJyMO7fnhv9DCw7S4pfr83wPpJwp2hP1DfBaoVpq8DhXgyFBoRN1oIqS/YNxMTcv97pFMa0ehQ8zq1NL6wpJhcfh1VlneZyRcyeZLv34AvxBoUl18dPfcBn03Liaun6zx7fMJCU0vF+gxfSWPgTM4LOE1MmEPp7iOOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754420745; c=relaxed/simple;
	bh=ATOJWurILJ+pXvAy7vgZb2du/uRW5OngKfJEtQ9MjgE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s46v3VOBvz3to7K06Z2XxR/Vu/9RKDmIn95YCSu9wKO4k5ZDY3cGL+QMsdx98bjJNsUdVfAUAP0sKSOHJQ4BKdv6jcSnZiUWMrwexK91skETVM0T33UjRxZSrXsE3fbSwoGqe2ljul6h4Sa4Jpag4+APx17G9V0k3uF1DWCD8no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A5qUfrX9; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b3f38d3cabeso4054915a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 12:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754420743; x=1755025543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=fXcZGtwr18gSNfbGq/ApRRZ2cGpCSejOkegwkd2RB7g=;
        b=A5qUfrX9p8W5M2MMDCKietvNz9pH4MYXTCrKsz3zFzXI2DeY3E0wnplRn7A3LM8VP8
         XYF7Wr/HBKbgYr6LOaSarsjoP8BkbjIK9ZplauyILn4ZGmZrP0lcdnaE7fVnqkL3EkG+
         PC1yc8x6EX3fYKkKQwSIQGTsHAJ22oy8+cGJHEWxTm05Hn/F+J8NhA7+Hi9nHCMWq+IR
         e+/5/hSC0KVXlq5U0Wkajan1p9vU+HI5okyPrV6PYzhqyIT08XHhnkBE947jidGTCDV5
         iILU6z4VVEDvgoophv7olhAK1gkzNlziC7hJpmawAbmjVubFjF7aICe0ZiptQIZONAVN
         QEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754420743; x=1755025543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXcZGtwr18gSNfbGq/ApRRZ2cGpCSejOkegwkd2RB7g=;
        b=OsVZp4nw0IALhfan7KZHXqPBbWJSfJM196GlZoZ0kT/uZ0AJzKuY/xLPWrdm7PZrPd
         i+4g9zpFmfLgcUBoBXihlQMxbI8XE8doYohhwaVK7jri0o9zzng7n24NSfRFpbsnUew2
         93FgYyD8UOXxVMyDh0ARmF8BcycK13P+3RGcUbpXXkqYI+1QAS3dcHqrLVNAdNADSChs
         +3uPskbUk95lF30H3xvSwuz7HR1On7BjC9YqLKSr8/SILRbpLROvsPEA8koIzTDpuKfU
         ry8JIm0KIcAuP+6BfhAIdbWylnT+t4WLp0lHCFCNo2vtSyxQlXirk51VsKiiiQX7ZAbK
         FHOg==
X-Forwarded-Encrypted: i=1; AJvYcCVM9ZOEVi31P9X6z1Ww/pLVaAAOxa+9IdlZSnZSrtlMrIMaTwoDkCFqYFx8FVRvHrRMHrarivrqWUpY844=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Cg+D6uHmK/KQxSTycSztUg9AscVXxgomr9zBwZC9T7zwXeWQ
	MUUGWTZPgSbb+leNjzt0cX1tvq5xQto+aS/2RS9R9mTW49yimhk5QYUcA8uOXjw19N1U9OGxlAf
	Gqd7jHg==
X-Google-Smtp-Source: AGHT+IFzn/biQe1Qxm6XvedDBvzagTRf5b39R3idgrE1MR4qbj1/mKxMhU5L7MOTzCIbn6eqqm8/r77blPw=
X-Received: from pjbli2.prod.google.com ([2002:a17:90b:48c2:b0:2ff:6132:8710])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1346:b0:31f:9114:ead8
 with SMTP id 98e67ed59e1d1-321161dd744mr21743989a91.6.1754420743452; Tue, 05
 Aug 2025 12:05:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  5 Aug 2025 12:05:16 -0700
In-Reply-To: <20250805190526.1453366-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250805190526.1453366-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250805190526.1453366-9-seanjc@google.com>
Subject: [PATCH 08/18] KVM: x86: Fold WRMSR fastpath helpers into the main handler
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Xin Li <xin@zytor.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="UTF-8"

Fold the per-MSR WRMSR fastpath helpers into the main handler now that the
IPI path in particular is relatively tiny.  In addition to eliminating a
decent amount of boilerplate, this removes the ugly -errno/1/0 => bool
conversion (which is "necessitated" by kvm_x2apic_icr_write_fast()).

Opportunistically drop the comment about IPIs, as the purpose of the
fastpath is hopefully self-evident, and _if_ it needs more documentation,
the documentation (and rules!) should be placed in a more central location.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 34 +++++-----------------------------
 1 file changed, 5 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e6c221f9b92e..a4441f036929 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2133,48 +2133,24 @@ static inline bool kvm_vcpu_exit_request(struct kvm_vcpu *vcpu)
 	       kvm_request_pending(vcpu) || xfer_to_guest_mode_work_pending();
 }
 
-/*
- * The fast path for frequent and performance sensitive wrmsr emulation,
- * i.e. the sending of IPI, sending IPI early in the VM-Exit flow reduces
- * the latency of virtual IPI by avoiding the expensive bits of transitioning
- * from guest to host, e.g. reacquiring KVM's SRCU lock. In contrast to the
- * other cases which must be called after interrupts are enabled on the host.
- */
-static int handle_fastpath_set_x2apic_icr_irqoff(struct kvm_vcpu *vcpu, u64 data)
-{
-	if (!lapic_in_kernel(vcpu) || !apic_x2apic_mode(vcpu->arch.apic))
-		return 1;
-
-	return kvm_x2apic_icr_write_fast(vcpu->arch.apic, data);
-}
-
-static int handle_fastpath_set_tscdeadline(struct kvm_vcpu *vcpu, u64 data)
-{
-	kvm_set_lapic_tscdeadline_msr(vcpu, data);
-	return 0;
-}
-
 fastpath_t handle_fastpath_set_msr_irqoff(struct kvm_vcpu *vcpu)
 {
 	u64 data = kvm_read_edx_eax(vcpu);
 	u32 msr = kvm_rcx_read(vcpu);
-	bool handled;
 	int r;
 
 	switch (msr) {
 	case APIC_BASE_MSR + (APIC_ICR >> 4):
-		handled = !handle_fastpath_set_x2apic_icr_irqoff(vcpu, data);
+		if (!lapic_in_kernel(vcpu) || !apic_x2apic_mode(vcpu->arch.apic) ||
+		    kvm_x2apic_icr_write_fast(vcpu->arch.apic, data))
+			return EXIT_FASTPATH_NONE;
 		break;
 	case MSR_IA32_TSC_DEADLINE:
-		handled = !handle_fastpath_set_tscdeadline(vcpu, data);
+		kvm_set_lapic_tscdeadline_msr(vcpu, data);
 		break;
 	default:
-		handled = false;
-		break;
-	}
-
-	if (!handled)
 		return EXIT_FASTPATH_NONE;
+	}
 
 	kvm_vcpu_srcu_read_lock(vcpu);
 	r = kvm_skip_emulated_instruction(vcpu);
-- 
2.50.1.565.gc32cd1483b-goog


