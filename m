Return-Path: <linux-kernel+bounces-758269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D9FB1CD12
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6863A6F13
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB63D2E0921;
	Wed,  6 Aug 2025 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F4R2l5U3"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B48E2E03E0
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510320; cv=none; b=nyZjWN10rJEycpXsF62H1Su49x1VA4PQTQDbEYC5oKLpSGfSZyZKg1tXV83PCHzzzGWkuE7FEr0gUXLMIlKEnHZTfhftY1QRlIz9rb1MqQX5sAROlDl/8BKiNyFUzhldWjVx91G1HyNBbbUe5TGtG64lVxq/FREY9XvSsSDt2cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510320; c=relaxed/simple;
	bh=Wpc8Jd9c5FTviX8Nxdqz9AYHAb0HsNCDdNNI+vxMlVA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TWif7FIGHcnWgSTLJSnKupvsw6wpHxVPfDL93LbMK8JJmy7G/6cTASa26dSpvlrFlWzK+L8Z2orXIoxVXwa+j1d4RmHfZACVBvuhrE6Vqgyr9HhzGfalHjCk9wzvDAIAEvDtyl3sJKWbBIIaELiT4PLwQwEgibY6WL/3Q88JFxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F4R2l5U3; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31ea430d543so311223a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 12:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510318; x=1755115118; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=mbLaYrBpG9GN/ccdjbZmNVq0IkY2pKSaCp1hoLzaUb8=;
        b=F4R2l5U3Zs/Tt1JRAvtsqAzEd9cVdolHZvuVEYwjvFHDj7e9UdVCbAuSpfKH7fOeI2
         Hnkd8wM4df8l+1paSBz7Jv/A5LdbxsF6fkl7ih7TaROhtUTeOFneZ09iMLuMc1+kDCIP
         GV8qQtFBIgk2JaLdE6nqRu50lWIO/bGxwknzIMFDsw8/xluZYWkop2VVjYSkCX+KwrYv
         YvRQ26PqRgUTxXHETnTovhgmAgZZPBaFs8ckBBcIpvsck9VZfkPNTGlPndKHOk2fhGuh
         LZOzBM+tNBiUlGXGB++gMaAIlRYKE6JPjFJDiDgDxnbhb6by7KOVj2eFzkUcFpr/1CGH
         lX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510318; x=1755115118;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mbLaYrBpG9GN/ccdjbZmNVq0IkY2pKSaCp1hoLzaUb8=;
        b=qHKsMG1UQTCNmxhNaTeJKhYy6KyQOLoFq0K3c3GtliG9FYsS+5MDIn/DpCHIOzVxN0
         2GwjpzsEdJGndJvm8hTF+j+NgRxw+l83wTSGNlDumZMp6vFc7lOjNVTCnbDIiXXYoTDz
         cQ7RT6WqFMTTQHM1MM5TH+C4QiOSOJvs7ue8GSA+uIfIHS5Y/6YN54PtV7zPev9ARvw1
         J33RvTRLOzZAejJi7pfMQMzbLYWn8bS5UfApdYwomq2gcwdZ2sxU8Kz3Q0Ii1vPX5Td4
         Et9b57odhxGyftVFOfV1n9z8UCJ62mCKzSmLCLnURFJkytIC1toX+U7c9A6ysE+K9/Ik
         6IvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWun354g3iM4UnlYPJJXbWfcqNW3gvyIne52x47OT0n5NGOe2q8TkU2619iDchTQu6RqHGaqNP8a4x6Tcs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqy7FnSskHt6it5bFab8KrLGM/e/JvXZ4zn5wwMvrY/A/BTU4Z
	IdKTcgO7mG3ZblKB4pqPFA8CmcU5yuJPV3bQQwGgzskzbL9RZbST6emRN38OFzngBrtVMSDWRUC
	UHpxUpA==
X-Google-Smtp-Source: AGHT+IG1RDTXadNPV+CIxuchWnyR7MvCJdJx9iRkBiPVNpyV8SP3VNbt+vP90Pa+IEkbzbifDn/Htni5q5g=
X-Received: from pjzd15.prod.google.com ([2002:a17:90a:e28f:b0:312:151d:c818])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a04:b0:31e:6f0a:6a1a
 with SMTP id 98e67ed59e1d1-32166dfac71mr5462707a91.3.1754510317778; Wed, 06
 Aug 2025 12:58:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:57:00 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-39-seanjc@google.com>
Subject: [PATCH v5 38/44] KVM: x86/pmu: Disallow emulation in the fastpath if
 mediated PMCs are active
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, 
	Yongwei Ma <yongwei.ma@intel.com>, Mingwei Zhang <mizhang@google.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Don't handle exits in the fastpath if emulation is required, i.e. if an
instruction needs to be skipped, the mediated PMU is enabled, and one or
more PMCs is counting instructions.  With the mediated PMU, KVM's cache of
PMU state is inconsistent with respect to hardware until KVM exits the
inner run loop (when the mediated PMU is "put").

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.h | 10 ++++++++++
 arch/x86/kvm/x86.c |  9 +++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index e2e2d8476a3f..a0cd42cbea9d 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -234,6 +234,16 @@ static inline bool pmc_is_globally_enabled(struct kvm_pmc *pmc)
 	return test_bit(pmc->idx, (unsigned long *)&pmu->global_ctrl);
 }
 
+static inline bool kvm_pmu_is_fastpath_emulation_allowed(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+
+	return !kvm_vcpu_has_mediated_pmu(vcpu) ||
+	       !bitmap_intersects(pmu->pmc_counting_instructions,
+				  (unsigned long *)&pmu->global_ctrl,
+				  X86_PMC_IDX_MAX);
+}
+
 void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu);
 void kvm_pmu_handle_event(struct kvm_vcpu *vcpu);
 int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned pmc, u64 *data);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7fb94ef64e18..6bdf7ef0b535 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2092,6 +2092,9 @@ EXPORT_SYMBOL_GPL(kvm_emulate_invd);
 
 fastpath_t handle_fastpath_invd(struct kvm_vcpu *vcpu)
 {
+	if (!kvm_pmu_is_fastpath_emulation_allowed(vcpu))
+		return EXIT_FASTPATH_NONE;
+
 	if (!kvm_emulate_invd(vcpu))
 		return EXIT_FASTPATH_EXIT_USERSPACE;
 
@@ -2151,6 +2154,9 @@ fastpath_t handle_fastpath_set_msr_irqoff(struct kvm_vcpu *vcpu)
 	u64 data = kvm_read_edx_eax(vcpu);
 	u32 msr = kvm_rcx_read(vcpu);
 
+	if (!kvm_pmu_is_fastpath_emulation_allowed(vcpu))
+		return EXIT_FASTPATH_NONE;
+
 	switch (msr) {
 	case APIC_BASE_MSR + (APIC_ICR >> 4):
 		if (!lapic_in_kernel(vcpu) || !apic_x2apic_mode(vcpu->arch.apic) ||
@@ -11267,6 +11273,9 @@ EXPORT_SYMBOL_GPL(kvm_emulate_halt);
 
 fastpath_t handle_fastpath_hlt(struct kvm_vcpu *vcpu)
 {
+	if (!kvm_pmu_is_fastpath_emulation_allowed(vcpu))
+		return EXIT_FASTPATH_NONE;
+
 	if (!kvm_emulate_halt(vcpu))
 		return EXIT_FASTPATH_EXIT_USERSPACE;
 
-- 
2.50.1.565.gc32cd1483b-goog


