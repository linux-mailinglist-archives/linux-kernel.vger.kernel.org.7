Return-Path: <linux-kernel+bounces-756877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010D3B1BAA7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D3F720547
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769012BDC02;
	Tue,  5 Aug 2025 19:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1FZsnIT3"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083B32BD580
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 19:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754420747; cv=none; b=RGNpPfR4YvviaeSnhlDPpPQYS523GeXji2HUekhhVg4Rdn/R7JZq8DESVSJoKXILRb/ojkde/C3nQtZs2qe9zlPTLbr8h7Tm2ioWcCsFBwPWNi6TofAonvqyJq6xt/0chdPfFYml5rLApcm/1qAd3aXvEe9VCwJ5suOVD0cfUZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754420747; c=relaxed/simple;
	bh=jIspsSukkN0GcXbnX6kROdAooWTTjWRdQLcWRVvZSm8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=okSP3QrhThBlwSzQBOAJIjtxhcoCOZexJq/6pAqmLzNtmZCXefGZIxi6nXTC0f16KEj7FnXrdXokzFB3LIJsYOYuh60K+nVLYy/oEu4i4DrNX0D7RaUdY+bdz7x1s2IClyrcxla4rNoJgR+13rGU0p4LvgSARKuAK6idmAVnoS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1FZsnIT3; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31effad1358so124803a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 12:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754420745; x=1755025545; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=MHm9cX+2a6wEZOmXR7zbZQOpP1vpd9jsxwALDJhOINI=;
        b=1FZsnIT3yJ8q2jprrQl17a+wlTnvPRnswOiXvhW6M46or3ohP4Ar597wqNeGE17r+y
         acwBKMQkytbLVK2PmjG0fHvNjj+G1DOwXvhKMvIGC+minWXMNf6E7VuwDBIH8/NBUf9T
         5KQT7nakWSB1m8ln+ZXLQ+giFTKv0t/kKJc4RanJOeuluZU/euq7pU9LRIHq4MOqpErw
         KXRGlXwBfqAmsjOF57Jgb7YatO11jsj+cq6201PrWl4iztrG5Wf9SNH8tXpO8x29DBfD
         anVGYRzvPz0Ypq/o/pJ6nX0qihKYr4ax6xQAU48sx+YRD14E08sg5q7uYRz3XYkdT/dY
         34Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754420745; x=1755025545;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MHm9cX+2a6wEZOmXR7zbZQOpP1vpd9jsxwALDJhOINI=;
        b=SZxx23cG/dCkmyay5mQthAe3ImBCAm8Pk9onq8IEmwNxyy5Pvss0K7FbRc5iHL9A13
         FY61Gg3RNPA2ou14FWijkFJZz9t1kYPzcQW7PaNkmkdaY+Z9ERLfCgLU+S7I69XaC7EI
         kmqqLQfdPTjImH/wTfNPGIluAUsnGc3iT1Q5x/3Ip1bqE4Dh2ddVzRhej2yW9/MZILL9
         IsSPc+YJ59SlGI/cDQzrIoJtBxaLrTtycYuzF/mNd/kD9pZa9gq/2UPBwxKskGCRcCCE
         dtg9taH0GoIXFgTaCVtMvknuvkKWF9EMaHp1g85M8FGVXtclgBQUcZWrKlX042FO4ait
         EdJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX9FgFYQadbDS8m0Wx4CPNGIlS7aiC+idBeejzWZNDG81wYtiOZ3PKCu/VWs7Y7HN55qVs6Ykx2oXv7gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWkG6di9rkbOg0WVTXEGhJ6VslFPovL3Aff/fvGFYdEkwz/5hN
	skJGzbBd2hwcmfwT/UCdfbKUD9AA9XDOUqSOwubw143TSUacKx1fttpK0ZHr660nDnHIzvPE2Er
	dm9qt6w==
X-Google-Smtp-Source: AGHT+IGDasRXwFiMQ86DEaBEHpeUlL+2maKDx6zxVfD8zjsFQ8EmHiEcKjpKDebLzmI3pok4pfMV0qtxJc0=
X-Received: from pjbns14.prod.google.com ([2002:a17:90b:250e:b0:31e:a865:8b32])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e8c:b0:31e:f30f:6d3b
 with SMTP id 98e67ed59e1d1-3216684b05emr89332a91.2.1754420745302; Tue, 05 Aug
 2025 12:05:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  5 Aug 2025 12:05:17 -0700
In-Reply-To: <20250805190526.1453366-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250805190526.1453366-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250805190526.1453366-10-seanjc@google.com>
Subject: [PATCH 09/18] KVM: x86/pmu: Move kvm_init_pmu_capability() to pmu.c
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Xin Li <xin@zytor.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="UTF-8"

Move kvm_init_pmu_capability() to pmu.c so that future changes can access
variables that have no business being visible outside of pmu.c.
kvm_init_pmu_capability() is called once per module load, there's is zero
reason it needs to be inlined.

No functional change intended.

Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/pmu.h | 47 +---------------------------------------------
 2 files changed, 48 insertions(+), 46 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 75e9cfc689f8..eb17d90916ea 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -96,6 +96,53 @@ void kvm_pmu_ops_update(const struct kvm_pmu_ops *pmu_ops)
 #undef __KVM_X86_PMU_OP
 }
 
+void kvm_init_pmu_capability(const struct kvm_pmu_ops *pmu_ops)
+{
+	bool is_intel = boot_cpu_data.x86_vendor == X86_VENDOR_INTEL;
+	int min_nr_gp_ctrs = pmu_ops->MIN_NR_GP_COUNTERS;
+
+	/*
+	 * Hybrid PMUs don't play nice with virtualization without careful
+	 * configuration by userspace, and KVM's APIs for reporting supported
+	 * vPMU features do not account for hybrid PMUs.  Disable vPMU support
+	 * for hybrid PMUs until KVM gains a way to let userspace opt-in.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
+		enable_pmu = false;
+
+	if (enable_pmu) {
+		perf_get_x86_pmu_capability(&kvm_pmu_cap);
+
+		/*
+		 * WARN if perf did NOT disable hardware PMU if the number of
+		 * architecturally required GP counters aren't present, i.e. if
+		 * there are a non-zero number of counters, but fewer than what
+		 * is architecturally required.
+		 */
+		if (!kvm_pmu_cap.num_counters_gp ||
+		    WARN_ON_ONCE(kvm_pmu_cap.num_counters_gp < min_nr_gp_ctrs))
+			enable_pmu = false;
+		else if (is_intel && !kvm_pmu_cap.version)
+			enable_pmu = false;
+	}
+
+	if (!enable_pmu) {
+		memset(&kvm_pmu_cap, 0, sizeof(kvm_pmu_cap));
+		return;
+	}
+
+	kvm_pmu_cap.version = min(kvm_pmu_cap.version, 2);
+	kvm_pmu_cap.num_counters_gp = min(kvm_pmu_cap.num_counters_gp,
+					  pmu_ops->MAX_NR_GP_COUNTERS);
+	kvm_pmu_cap.num_counters_fixed = min(kvm_pmu_cap.num_counters_fixed,
+					     KVM_MAX_NR_FIXED_COUNTERS);
+
+	kvm_pmu_eventsel.INSTRUCTIONS_RETIRED =
+		perf_get_hw_event_config(PERF_COUNT_HW_INSTRUCTIONS);
+	kvm_pmu_eventsel.BRANCH_INSTRUCTIONS_RETIRED =
+		perf_get_hw_event_config(PERF_COUNT_HW_BRANCH_INSTRUCTIONS);
+}
+
 static inline void __kvm_perf_overflow(struct kvm_pmc *pmc, bool in_pmi)
 {
 	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index ad89d0bd6005..13477066eb40 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -180,52 +180,7 @@ static inline bool pmc_speculative_in_use(struct kvm_pmc *pmc)
 extern struct x86_pmu_capability kvm_pmu_cap;
 extern struct kvm_pmu_emulated_event_selectors kvm_pmu_eventsel;
 
-static inline void kvm_init_pmu_capability(const struct kvm_pmu_ops *pmu_ops)
-{
-	bool is_intel = boot_cpu_data.x86_vendor == X86_VENDOR_INTEL;
-	int min_nr_gp_ctrs = pmu_ops->MIN_NR_GP_COUNTERS;
-
-	/*
-	 * Hybrid PMUs don't play nice with virtualization without careful
-	 * configuration by userspace, and KVM's APIs for reporting supported
-	 * vPMU features do not account for hybrid PMUs.  Disable vPMU support
-	 * for hybrid PMUs until KVM gains a way to let userspace opt-in.
-	 */
-	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
-		enable_pmu = false;
-
-	if (enable_pmu) {
-		perf_get_x86_pmu_capability(&kvm_pmu_cap);
-
-		/*
-		 * WARN if perf did NOT disable hardware PMU if the number of
-		 * architecturally required GP counters aren't present, i.e. if
-		 * there are a non-zero number of counters, but fewer than what
-		 * is architecturally required.
-		 */
-		if (!kvm_pmu_cap.num_counters_gp ||
-		    WARN_ON_ONCE(kvm_pmu_cap.num_counters_gp < min_nr_gp_ctrs))
-			enable_pmu = false;
-		else if (is_intel && !kvm_pmu_cap.version)
-			enable_pmu = false;
-	}
-
-	if (!enable_pmu) {
-		memset(&kvm_pmu_cap, 0, sizeof(kvm_pmu_cap));
-		return;
-	}
-
-	kvm_pmu_cap.version = min(kvm_pmu_cap.version, 2);
-	kvm_pmu_cap.num_counters_gp = min(kvm_pmu_cap.num_counters_gp,
-					  pmu_ops->MAX_NR_GP_COUNTERS);
-	kvm_pmu_cap.num_counters_fixed = min(kvm_pmu_cap.num_counters_fixed,
-					     KVM_MAX_NR_FIXED_COUNTERS);
-
-	kvm_pmu_eventsel.INSTRUCTIONS_RETIRED =
-		perf_get_hw_event_config(PERF_COUNT_HW_INSTRUCTIONS);
-	kvm_pmu_eventsel.BRANCH_INSTRUCTIONS_RETIRED =
-		perf_get_hw_event_config(PERF_COUNT_HW_BRANCH_INSTRUCTIONS);
-}
+void kvm_init_pmu_capability(const struct kvm_pmu_ops *pmu_ops);
 
 static inline void kvm_pmu_request_counter_reprogram(struct kvm_pmc *pmc)
 {
-- 
2.50.1.565.gc32cd1483b-goog


