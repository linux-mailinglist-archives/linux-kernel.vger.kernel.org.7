Return-Path: <linux-kernel+bounces-769765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA114B2736D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41AA5E86A0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C371CAA92;
	Fri, 15 Aug 2025 00:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZXQDQea9"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CA21B040B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 00:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755216746; cv=none; b=WY6/c7FRYc7QjGMZOa/z3UP4a0P2QCPlMB4u0wT487/7uZXT2hqw2cpaJ/CPCdOIWvVxU/dSVbjIFTz5wK/Yz6KhLginRP9m99zQVu2J8Hbz7zCZquvJXNMpql7mvPfUhi3xI40GjyiE7Yqk1TMZQeHsscu4+vt1+2RFDwOcEZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755216746; c=relaxed/simple;
	bh=BtM8dFTmM/9dZyw4RXoSLIMVKXsY5bNsgrn1HhBtzJo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pyJEWl5aGdxevLGgmrBWVFawIYnpVc2c2PC57PfBJMos77/ufezL7HAGfM/1p6hjYVq8ufG4oIMzl2U+0lBiHWu8MtlzRhKDldDWeRXsEvn1N6qMxcuTPcmAOzNf6mk9AlhVeA3vHHb0UVwPEGSi8OdXikd/PckaHc4EZC8FBFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZXQDQea9; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b47174c667aso1077212a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755216744; x=1755821544; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BXUEX1H6LyLUJSMPiSF5Cl3sy6zgRvsqwEwkPUOpCvs=;
        b=ZXQDQea9fO2ch2wBlP47qxH3lBvsXLDT8Q0Z8cHAYvXRkqN/An+nXX+R8jQoftaGCD
         1PP6S5w56GQXE9L/UoZb3RtGQNDVrM9i/+RHFXs5E/u9xUkKFyi6m5smhkTOdnzKx3V4
         s0baNyKWiiW11R2eK7yzs/XpwTNIbEWX3JwhVBlfBK1ku2uJvMaDIjvROfjAOhccYSo6
         59smYawOQe6h9LNTe0aGqESVeGU5ulg00wkqAgma/IHV9a8LK+YvNzf1V61OxX5LfZK8
         DI9Vu2xZ4+mZ2ZhTtJt6qw/udEgvq+de297huT0oKmdNq8aex24DfVsinnL/1dJ13+Hd
         yQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755216744; x=1755821544;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BXUEX1H6LyLUJSMPiSF5Cl3sy6zgRvsqwEwkPUOpCvs=;
        b=Q8mGpnVk0uVJ2g8b1uYmIBssObH5wh8oDm9bHozKfanIlSSw7qC/15iZmojoGOpOIG
         a5yY0c2XdMgMBdtAYpTOGwKrLEqBUPZ4LJc71CXNDUCrYkmEAvBGUBnkWahC9XfljtQa
         3nXBFfrGDFtQzPoWs4I3dIeJBPqK+rODx/ijMMCZt8sfXm3/1UZePeyRZESvHtDIVAV8
         lbCuz7tVrobBmBd/RqWkLSBaKlh2bRfR6i+soA1He4y21EHS7JukgvjleJ/S8S7OCfaL
         ryWDm2HHzGTwtcLhyeRNr4q35ouU2EVjdMnj3NDyl39ljcMdHjRxO245C9dAXqsQrhb+
         5S6A==
X-Forwarded-Encrypted: i=1; AJvYcCU30vxRg0F0TbTlRe6VLM1TtQgcs0GU13mZF54uiOGsgKgFDE0aNl788iEYtRFq4RvVDmUmK15QCn/X6f0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7BSFiEpfE4hWnraF9eb7S5ltojOvJhNvx3W7JYNgLRm87JDCQ
	y70enzdafN/vR1b3QlbsVjY50JGrv43NKZh7FnvzNf33n1GgYjdFi0SRsaeGqSfv9syi3sN3pRr
	0EOzLLA==
X-Google-Smtp-Source: AGHT+IEL5helDYMbTg+EjsCxZbXQyOUBux72Tc/5TNXET/7xtgbFbL1AxnUElCcBkw/pIUt2U1qDn9Z+2G0=
X-Received: from pgg2.prod.google.com ([2002:a05:6a02:4d82:b0:b47:16f7:2be5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9392:b0:240:252a:158e
 with SMTP id adf61e73a8af0-240d2d913d0mr350688637.3.1755216744472; Thu, 14
 Aug 2025 17:12:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:11:51 -0700
In-Reply-To: <20250815001205.2370711-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815001205.2370711-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815001205.2370711-8-seanjc@google.com>
Subject: [PATCH 6.1.y 07/21] KVM: x86: Snapshot the host's DEBUGCTL after
 disabling IRQs
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit 189ecdb3e112da703ac0699f4ec76aa78122f911 ]

Snapshot the host's DEBUGCTL after disabling IRQs, as perf can toggle
debugctl bits from IRQ context, e.g. when enabling/disabling events via
smp_call_function_single().  Taking the snapshot (long) before IRQs are
disabled could result in KVM effectively clobbering DEBUGCTL due to using
a stale snapshot.

Cc: stable@vger.kernel.org
Reviewed-and-tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lore.kernel.org/r/20250227222411.3490595-6-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2178f6bb8e90..0c3908544205 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4742,7 +4742,6 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	/* Save host pkru register if supported */
 	vcpu->arch.host_pkru = read_pkru();
-	vcpu->arch.host_debugctl = get_debugctlmsr();
 
 	/* Apply any externally detected TSC adjustments (due to suspend) */
 	if (unlikely(vcpu->arch.tsc_offset_adjustment)) {
@@ -10851,6 +10850,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		set_debugreg(0, 7);
 	}
 
+	vcpu->arch.host_debugctl = get_debugctlmsr();
+
 	guest_timing_enter_irqoff();
 
 	for (;;) {
-- 
2.51.0.rc1.163.g2494970778-goog


