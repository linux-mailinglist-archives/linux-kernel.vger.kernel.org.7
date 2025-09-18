Return-Path: <linux-kernel+bounces-756880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B194B1BAAB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6DB171C21
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786CD2BE637;
	Tue,  5 Aug 2025 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ey9SPOyK"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4546F2BE633
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754420752; cv=none; b=EgmmKS6uW0bSbFZawF7vJNGZ0b6Xzthcty67UeLRHZeMfA03ft0o/CUp6Ni+TRu7hG26z/MphxgzsacnLbDm8O44NkXjvzIyD6TsE6ynNLO2TmzYgDC1yCwYQqX2gRqg3yxi7Dlb71NvXuctk9WHZm62qclSl+bfxx05FCsIpOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754420752; c=relaxed/simple;
	bh=pnz5GPHbUL1uVz2QV1RJMlpLJa1Rveb6gZH923+QTvs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UoI8F+2KZan/Og12V5eW+z2VVuePEBWfyIU4vEEV0Xiwpl24z//xZvrxnRvoLuSRvn4CPBVPejzMbGbhX/H/huKhvBQtO69MsMV8QDFod3qulMF+7nqXMSuYmUDeUd3EpO72ljXp5kRkf/eSlxPndjERdAkFxp6HM4i7rUd4058=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ey9SPOyK; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4227538a47so4044239a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 12:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754420751; x=1755025551; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=9grQ6DM7PkSOUdH/ZZWeVtWjpj5Tz/lOK2rUIx4UhFM=;
        b=ey9SPOyK0DebtnjLsryGCz1TvdIw5UIwB5fE6d99dVCB5RiXqblBkEgM7qe9C8TbJl
         nHHlloN8CsS49565roKY7E5EjCQFBpN7OWM80AMcezJj562cckopijXfKuTKOHu9muG7
         Ih+Rs7+86qSLpMiJeEnMf4V1aqpjb/EY2Nnw0FCgZ0MvYMdW4NqiSqrAh3Kyy5CUWhFR
         hKMrStfgoGr6lSGrcCDQyvEZmh6QaW4j9PZyyJfPSY36xBLspglO6zy3CJYYif2yXdzP
         yNAYEcRive4GQqPHoEIb37q7vCrycKhLmoKIrG5auVOBaf+y9geO3NXzlDU/CrDQWtSQ
         DpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754420751; x=1755025551;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9grQ6DM7PkSOUdH/ZZWeVtWjpj5Tz/lOK2rUIx4UhFM=;
        b=M/W16THb5ljgsVKO0bw5ZtuiSYQz4lVaIX+iTktVFAAQOaajYkhvZckBU+VNAQnhoF
         W1rOwglY90+j+NQ0g7uAhG+fwYS+rmZ0D820HTpQRNrL2vpqlDPFR0QNmTx0hFmGfrKE
         hwbL6wqL3APtDbeECRmxROfwDQaWtESHi7kpwHFxtWLfFhl6van8wmsr0J8c6l5rt47R
         4AxnTmYVkhSGOPFRUKV112dPJ26gnE4M2CYeHBwTj49GTi01rdss7BDl4yHZWaatjNvA
         bvbh/HWe7aLvJXen0ZMq+b/g9aZgV2iPqAAOBBDrTfC7e3MuQByrGMLAmNFcyv615K+h
         UyWw==
X-Forwarded-Encrypted: i=1; AJvYcCVRlpJ53mvki9RyNe1YPG6r7Uql4in1z4P9S2hF1awueL3v6qXjdXuJtnHZ1ISeDR6Aj5iN8Ss7BQ4+i7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/LOl6y6SEeD7hvdSj8TK0lEXh3rpzwFeCy1Ocfdk+p9aMQBJY
	Vb/9BRml3M0GPNKRrv/61dTm3F3CaoDdGI1u8Kn4BG7/pQCkI0ghzDuoYF9ao/qzwequjZcTs8G
	wfL5how==
X-Google-Smtp-Source: AGHT+IHWOk3hCecdCHsM4icWj0tVZamc2jPv94x5aLLpqfrfCuf/TvnX0Djxp+K6yNBHPlMk/y1/Xi9Nx8A=
X-Received: from pjyt9.prod.google.com ([2002:a17:90a:e509:b0:31c:2fe4:33b7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c92:b0:321:265a:e0b6
 with SMTP id 98e67ed59e1d1-321265ae50emr14628340a91.20.1754420750687; Tue, 05
 Aug 2025 12:05:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  5 Aug 2025 12:05:20 -0700
In-Reply-To: <20250805190526.1453366-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250805190526.1453366-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250805190526.1453366-13-seanjc@google.com>
Subject: [PATCH 12/18] KVM: x86/pmu: Rename pmc_speculative_in_use() to pmc_is_locally_enabled()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Xin Li <xin@zytor.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="UTF-8"

Rename pmc_speculative_in_use() to pmc_is_locally_enabled() to better
capture what it actually tracks, and to show its relationship to
pmc_is_globally_enabled().  While neither AMD nor Intel refer to event
selectors or the fixed counter control MSR as "local", it's the obvious
name to pair with "global".

As for "speculative", there's absolutely nothing speculative about the
checks.  E.g. for PMUs without PERF_GLOBAL_CTRL, from the guest's
perspective, the counters are "in use" without any qualifications.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c           | 6 +++---
 arch/x86/kvm/pmu.h           | 2 +-
 arch/x86/kvm/vmx/pmu_intel.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index b0f0275a2c2e..e73c2a44028b 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -493,7 +493,7 @@ static bool check_pmu_event_filter(struct kvm_pmc *pmc)
 
 static bool pmc_event_is_allowed(struct kvm_pmc *pmc)
 {
-	return pmc_is_globally_enabled(pmc) && pmc_speculative_in_use(pmc) &&
+	return pmc_is_globally_enabled(pmc) && pmc_is_locally_enabled(pmc) &&
 	       check_pmu_event_filter(pmc);
 }
 
@@ -572,7 +572,7 @@ void kvm_pmu_recalc_pmc_emulation(struct kvm_pmu *pmu, struct kvm_pmc *pmc)
 	 * omitting a PMC from a bitmap could result in a missed event if the
 	 * filter is changed to allow counting the event.
 	 */
-	if (!pmc_speculative_in_use(pmc))
+	if (!pmc_is_locally_enabled(pmc))
 		return;
 
 	if (pmc_is_event_match(pmc, kvm_pmu_eventsel.INSTRUCTIONS_RETIRED))
@@ -907,7 +907,7 @@ void kvm_pmu_cleanup(struct kvm_vcpu *vcpu)
 		      pmu->pmc_in_use, X86_PMC_IDX_MAX);
 
 	kvm_for_each_pmc(pmu, pmc, i, bitmask) {
-		if (pmc->perf_event && !pmc_speculative_in_use(pmc))
+		if (pmc->perf_event && !pmc_is_locally_enabled(pmc))
 			pmc_stop_counter(pmc);
 	}
 
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index cb93a936a177..08ae644db00e 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -160,7 +160,7 @@ static inline struct kvm_pmc *get_fixed_pmc(struct kvm_pmu *pmu, u32 msr)
 	return NULL;
 }
 
-static inline bool pmc_speculative_in_use(struct kvm_pmc *pmc)
+static inline bool pmc_is_locally_enabled(struct kvm_pmc *pmc)
 {
 	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
 
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 0b173602821b..07baff96300f 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -762,7 +762,7 @@ void intel_pmu_cross_mapped_check(struct kvm_pmu *pmu)
 	int bit, hw_idx;
 
 	kvm_for_each_pmc(pmu, pmc, bit, (unsigned long *)&pmu->global_ctrl) {
-		if (!pmc_speculative_in_use(pmc) ||
+		if (!pmc_is_locally_enabled(pmc) ||
 		    !pmc_is_globally_enabled(pmc) || !pmc->perf_event)
 			continue;
 
-- 
2.50.1.565.gc32cd1483b-goog


