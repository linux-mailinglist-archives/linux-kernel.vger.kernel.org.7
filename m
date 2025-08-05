Return-Path: <linux-kernel+bounces-756870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE3BB1BA98
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E2562641C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA47829B22C;
	Tue,  5 Aug 2025 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ibcI1tvj"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC5829AB1C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 19:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754420735; cv=none; b=EcUctIZf7eLtBRZW1ZiwLFDFaCE6pdbObYXZnMoKae/aWEmH8e90XKjaXe+uGkG/h2hE4yZ+47TTCiLs3F3Ctbbyk28JT60i3PCQtkqkQs4czfD7whCCz1/VHqgYuN1O0uqa38ByNZd6oYexMhQyLfNq2fqd0DCC+ubWvrz76oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754420735; c=relaxed/simple;
	bh=HbVZXzciHuWe7qp7KdZ5PNobwj23hgNSTftSTqFbOGU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ummm6oDRMP06UQF+legpo2hPL31SkwdqXKqePWDSLVv/8YHhAFc4JNkRv2sjXgf9N3riErJVENnY6tZTHjeEXppofWC1cFg41uo0pAua5sqDRgvOG8Wb7pnrT8xxL4sfQvJVZMMOPQ4puXpAbzaTn8TRyzRj/7EEx8EchRHoa0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ibcI1tvj; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2403e4c82ddso45229455ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 12:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754420733; x=1755025533; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=kwv2uoNl6IM1Rm8d9mEpWGTse8EQAo0NkYkscIAw3C4=;
        b=ibcI1tvjNbqUSANSvbxo28wHlhJnfNiOzbaEHt+4P6izhIQCVKQjBXRpJI1fAzx/9m
         zvyb3JxieOrk1IBSIY2FqFsUjdBG7AqfxyU/AWK0Ffxs62phJngae1V8jvOeyOXXqLPU
         /W5/WE6d9jUItdVoc7eOaQ2+kFq3aFhRA/3jx7QfemrlYwn4LMAxDCMen9Qzlm+/IO/f
         D4MK8VVmac5msYAdA9+4vrs6UQ+57wtfePzpDsH1L8o1BX38f4+/qeulSaObOyze9C+J
         qYYROdOIT/z3edGVfsBpgocGyDceqsjSYQlXPpzrmqxST6z2JcFQ3HWtLxKFHWoecEgN
         +ECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754420733; x=1755025533;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwv2uoNl6IM1Rm8d9mEpWGTse8EQAo0NkYkscIAw3C4=;
        b=dYyiBf2CRGWdxHW7MihjrjCbPU9bt18eguTy/WaOsxOplvTARFA8Pm7lyeKkG6Ecqd
         73ODhzPsW0f2U/y9rH0RLvEmNhfNdZAC6z034BQ/Y8osl3jMS/uQqQSqy1szkjOKQaAc
         E92DwHBXYuLBXbgIh/htss5c3LD3h953UXpyhPh3HPKWaueTELp8itCrSTxOc5UJPE9G
         F9AE6wzDt/7PtIfcqmf9Bl79qqfkFC5KLh9XDeWRblbeuNpFMCTuggKYc1NgVw5EoEuU
         cDmjuTvwpTNj+7D2/ZBQdIAarCN8dpedHmoc26d97NnezXiDfvX8xZ0IuaUVqdypjoHD
         KiDw==
X-Forwarded-Encrypted: i=1; AJvYcCWHTMPk9YTgXuU2QFISLIQpZzA+LB8PYV8ncda3rVqzfX+qjY3JTdANIgVpj6i/IaZ6P4DJtj7FdeOfRhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx17jCtLH3k2ITOqn1n6QBbAIUHcHawQFM2AZaSQA1XLu399rZC
	5hgofSS7TjbqCLIyL0GFw1kRPIiRfuOPXwDIWc9Ch15h7FfnZTqOA4VjWioPeesklduyj0RRzmt
	8ofnwVg==
X-Google-Smtp-Source: AGHT+IECGQbfrhzAcpL9CeFtEuwum+PP5UpXCFSrhMP8ea/+VjUuaLEHCKh0Fq5BBGoQCFW8zYtB28FTAYc=
X-Received: from pjbnd10.prod.google.com ([2002:a17:90b:4cca:b0:311:f699:df0a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2284:b0:240:5c0e:758b
 with SMTP id d9443c01a7336-2429f671811mr2057625ad.50.1754420732956; Tue, 05
 Aug 2025 12:05:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  5 Aug 2025 12:05:10 -0700
In-Reply-To: <20250805190526.1453366-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250805190526.1453366-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250805190526.1453366-3-seanjc@google.com>
Subject: [PATCH 02/18] KVM: x86: Add kvm_icr_to_lapic_irq() helper to allow
 for fastpath IPIs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Xin Li <xin@zytor.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="UTF-8"

Extract the code for converting an ICR message into a kvm_lapic_irq
structure into a local helper so that a fast-only IPI path can share the
conversion logic.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 8172c2042dd6..9f9846980625 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1481,24 +1481,30 @@ void kvm_apic_set_eoi_accelerated(struct kvm_vcpu *vcpu, int vector)
 }
 EXPORT_SYMBOL_GPL(kvm_apic_set_eoi_accelerated);
 
-void kvm_apic_send_ipi(struct kvm_lapic *apic, u32 icr_low, u32 icr_high)
+static void kvm_icr_to_lapic_irq(struct kvm_lapic *apic, u32 icr_low,
+				 u32 icr_high, struct kvm_lapic_irq *irq)
 {
-	struct kvm_lapic_irq irq;
-
 	/* KVM has no delay and should always clear the BUSY/PENDING flag. */
 	WARN_ON_ONCE(icr_low & APIC_ICR_BUSY);
 
-	irq.vector = icr_low & APIC_VECTOR_MASK;
-	irq.delivery_mode = icr_low & APIC_MODE_MASK;
-	irq.dest_mode = icr_low & APIC_DEST_MASK;
-	irq.level = (icr_low & APIC_INT_ASSERT) != 0;
-	irq.trig_mode = icr_low & APIC_INT_LEVELTRIG;
-	irq.shorthand = icr_low & APIC_SHORT_MASK;
-	irq.msi_redir_hint = false;
+	irq->vector = icr_low & APIC_VECTOR_MASK;
+	irq->delivery_mode = icr_low & APIC_MODE_MASK;
+	irq->dest_mode = icr_low & APIC_DEST_MASK;
+	irq->level = (icr_low & APIC_INT_ASSERT) != 0;
+	irq->trig_mode = icr_low & APIC_INT_LEVELTRIG;
+	irq->shorthand = icr_low & APIC_SHORT_MASK;
+	irq->msi_redir_hint = false;
 	if (apic_x2apic_mode(apic))
-		irq.dest_id = icr_high;
+		irq->dest_id = icr_high;
 	else
-		irq.dest_id = GET_XAPIC_DEST_FIELD(icr_high);
+		irq->dest_id = GET_XAPIC_DEST_FIELD(icr_high);
+}
+
+void kvm_apic_send_ipi(struct kvm_lapic *apic, u32 icr_low, u32 icr_high)
+{
+	struct kvm_lapic_irq irq;
+
+	kvm_icr_to_lapic_irq(apic, icr_low, icr_high, &irq);
 
 	trace_kvm_apic_ipi(icr_low, irq.dest_id);
 
-- 
2.50.1.565.gc32cd1483b-goog


