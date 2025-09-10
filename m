Return-Path: <linux-kernel+bounces-811134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA97EB524D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595D8560731
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4DE279DDB;
	Wed, 10 Sep 2025 23:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e86WF6al"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B49624C676
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 23:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757548615; cv=none; b=kmxzd1XWTo9Dl6OWLJ4bu4FvobJO1qh38UL0qtgvmvSwdHvsTIXC6kVPRq0ITthBycsv5KSzfTb2NqPd4wATGQ4X2uO4n7r/54J7vfjWA1zkg1OEx10IfThVK5/Sts3kcXm5MDwQXmqask7UlOTRHIZSubuZaug1gfRHEkANGcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757548615; c=relaxed/simple;
	bh=I4PUtpcnK+pjFvMAh/vYliUEkAOrs/VHAyc9GpwO+kc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O1pxx1bfkIdapYoNnkEgPSxiuFjX23FgvsMDuuKRrhhnfJK/oT52/Ez2Nyi6L1vmVjcKc0EXzgnymulCOl5Qlrf8TAp7/EAQxc4L9N4SlAsugN0eqUzZLYTBiLw9EZnyFnYYKnouh7GwKbJT5K0dW1XZN/xu1i8IZA2vPa9ALDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e86WF6al; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24458345f5dso1108185ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757548614; x=1758153414; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C7D87/dILzQr628TOcz440KpzUbcxA2U5EJ/XvVPOfU=;
        b=e86WF6alkb6kocXv89RarEwak0S2+zTCY1DNb604gHSe9SdM3ndSf98HA93UboDTkc
         yCuNfnjRpXmRaUdKnSXDPGiLz2q0415sducZeRoy1Z0k4PDaKjKzxrLRqNY/OyLtVhYk
         cLm7NPKNJg2Q7x9hjTKtW/YtYYHPKjCW/PPxLhysCTwxzz+25fBO4Cv3io6vzmj/J9Fu
         ZYktWiWi1Pexslv5bnd728PwrNmPcDeIGW5vPN2rcAc7shMWoeKYlDcNxqPTSmVfyyRU
         YbJFtR7YtI775m5GpiioRrTZDnK1hKYQPq1XyyvILbFEW/t4moVIxus5CUsMcEdJtp5d
         T3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757548614; x=1758153414;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C7D87/dILzQr628TOcz440KpzUbcxA2U5EJ/XvVPOfU=;
        b=b3E4LQiHzTpJrZaENR5fl79y6GJRAoIvCABTVFGMkWeKHQsSOGJkgwEdFpDt8GaSVm
         m8pnhXI3ZNr0giPgXMxCX9cXApYWTsnvsJpH0hju55IYHRvqvC5Pvns4h7gKAhNVhAAD
         4d+aE6O1HaJzb3PBaZM3wJxaey+oggkwKzAL6CqwnYFeIFO3H10WB0LioJveHTvBtfZ4
         lrhZy/9xSc8aNjk9OnVfJIZknwczPPYlRnos+FB1EllpVbwMAODDo1/fLm5Xzv+r+gHj
         zb8+2pNvez4Mvvyya8I6R2qzqyQa+uU6OClmEe/oyuUWUOErehOwkofRup4sfc8AIuWd
         lXdQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5qvaiKGAIwV64t43Sk4YgdJPJwV0iRhI2IQdNAgPWAvUiAc4mWdhpIab62L5MEHB4B7UEjbUKtVS4apM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOE60Qpja3Pk73Y1zOBH5hnfmyi8M6088ZHoEwmgrFrbHqXU/S
	6vYcD7cMbYjpYjgzKsbIz0jrQOxot741rosXN6kl/o88y9DcpT0dwnvteEIXPGl4kGqRP5TOKJ3
	nMQrFYA==
X-Google-Smtp-Source: AGHT+IH0XQo1zLITOe9EVVYOR/5Jg2MlPpOUyUidGEkfJnmXJJXm2l3ZSr7nsfm4iWK8X236NMnN0j0lQA8=
X-Received: from pjbee5.prod.google.com ([2002:a17:90a:fc45:b0:329:e84e:1c50])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d48e:b0:24e:e5c9:ed0c
 with SMTP id d9443c01a7336-25173308a06mr228352665ad.43.1757548613607; Wed, 10
 Sep 2025 16:56:53 -0700 (PDT)
Date: Wed, 10 Sep 2025 16:56:52 -0700
In-Reply-To: <20250718001905.196989-5-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250718001905.196989-1-dapeng1.mi@linux.intel.com> <20250718001905.196989-5-dapeng1.mi@linux.intel.com>
Message-ID: <aMIQRGRg59dvcHaP@google.com>
Subject: Re: [PATCH v2 4/5] KVM: selftests: Relax precise event count
 validation as overcount issue
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Zide Chen <zide.chen@intel.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Yi Lai <yi1.lai@intel.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>, dongsheng <dongsheng.x.zhang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 18, 2025, Dapeng Mi wrote:
> From: dongsheng <dongsheng.x.zhang@intel.com>
> 
> For Intel Atom CPUs, the PMU events "Instruction Retired" or
> "Branch Instruction Retired" may be overcounted for some certain
> instructions, like FAR CALL/JMP, RETF, IRET, VMENTRY/VMEXIT/VMPTRLD
> and complex SGX/SMX/CSTATE instructions/flows.
> 
> The detailed information can be found in the errata (section SRF7):
> https://edc.intel.com/content/www/us/en/design/products-and-solutions/processors-and-chipsets/sierra-forest/xeon-6700-series-processor-with-e-cores-specification-update/errata-details/
> 
> For the Atom platforms before Sierra Forest (including Sierra Forest),
> Both 2 events "Instruction Retired" and "Branch Instruction Retired" would
> be overcounted on these certain instructions, but for Clearwater Forest
> only "Instruction Retired" event is overcounted on these instructions.
> 
> As the overcount issue on VM-Exit/VM-Entry, it has no way to validate
> the precise count for these 2 events on these affected Atom platforms,
> so just relax the precise event count check for these 2 events on these
> Atom platforms.
> 
> Signed-off-by: dongsheng <dongsheng.x.zhang@intel.com>
> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Tested-by: Yi Lai <yi1.lai@intel.com>
> ---

...

> diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
> index 342a72420177..074cdf323406 100644
> --- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
> +++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
> @@ -52,6 +52,9 @@ struct kvm_intel_pmu_event {
>  	struct kvm_x86_pmu_feature fixed_event;
>  };
>  
> +
> +static uint8_t inst_overcount_flags;
> +
>  /*
>   * Wrap the array to appease the compiler, as the macros used to construct each
>   * kvm_x86_pmu_feature use syntax that's only valid in function scope, and the
> @@ -163,10 +166,18 @@ static void guest_assert_event_count(uint8_t idx, uint32_t pmc, uint32_t pmc_msr
>  
>  	switch (idx) {
>  	case INTEL_ARCH_INSTRUCTIONS_RETIRED_INDEX:
> -		GUEST_ASSERT_EQ(count, NUM_INSNS_RETIRED);
> +		/* Relax precise count check due to VM-EXIT/VM-ENTRY overcount issue */
> +		if (inst_overcount_flags & INST_RETIRED_OVERCOUNT)
> +			GUEST_ASSERT(count >= NUM_INSNS_RETIRED);
> +		else
> +			GUEST_ASSERT_EQ(count, NUM_INSNS_RETIRED);
>  		break;
>  	case INTEL_ARCH_BRANCHES_RETIRED_INDEX:
> -		GUEST_ASSERT_EQ(count, NUM_BRANCH_INSNS_RETIRED);
> +		/* Relax precise count check due to VM-EXIT/VM-ENTRY overcount issue */
> +		if (inst_overcount_flags & BR_RETIRED_OVERCOUNT)
> +			GUEST_ASSERT(count >= NUM_BRANCH_INSNS_RETIRED);
> +		else
> +			GUEST_ASSERT_EQ(count, NUM_BRANCH_INSNS_RETIRED);
>  		break;
>  	case INTEL_ARCH_LLC_REFERENCES_INDEX:
>  	case INTEL_ARCH_LLC_MISSES_INDEX:
> @@ -335,6 +346,7 @@ static void test_arch_events(uint8_t pmu_version, uint64_t perf_capabilities,
>  				length);
>  	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_EVENTS_MASK,
>  				unavailable_mask);
> +	sync_global_to_guest(vm, inst_overcount_flags);

Rather than force individual tests to sync_global_to_guest(), and to cache the
value, I think it makes sense to handle this automatically in kvm_arch_vm_post_create(),
similar to things like host_cpu_is_intel and host_cpu_is_amd.

And explicitly call these out as errata, so that it's super clear that we're
working around PMU/CPU flaws, not KVM bugs.  With some shenanigans, we can even
reuse the this_pmu_has()/this_cpu_has(0 terminology as this_pmu_has_errata(), and
hide the use of a bitmask too.

diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
index d4f90f5ec5b8..046d992c5940 100644
--- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
@@ -163,10 +163,18 @@ static void guest_assert_event_count(uint8_t idx, uint32_t pmc, uint32_t pmc_msr
 
        switch (idx) {
        case INTEL_ARCH_INSTRUCTIONS_RETIRED_INDEX:
-               GUEST_ASSERT_EQ(count, NUM_INSNS_RETIRED);
+               /* Relax precise count check due to VM-EXIT/VM-ENTRY overcount issue */
+               if (this_pmu_has_errata(INSTRUCTIONS_RETIRED_OVERCOUNT))
+                       GUEST_ASSERT(count >= NUM_INSNS_RETIRED);
+               else
+                       GUEST_ASSERT_EQ(count, NUM_INSNS_RETIRED);
                break;
        case INTEL_ARCH_BRANCHES_RETIRED_INDEX:
-               GUEST_ASSERT_EQ(count, NUM_BRANCH_INSNS_RETIRED);
+               /* Relax precise count check due to VM-EXIT/VM-ENTRY overcount issue */
+               if (this_pmu_has_errata(BRANCHES_RETIRED_OVERCOUNT))
+                       GUEST_ASSERT(count >= NUM_BRANCH_INSNS_RETIRED);
+               else
+                       GUEST_ASSERT_EQ(count, NUM_BRANCH_INSNS_RETIRED);
                break;
        case INTEL_ARCH_LLC_REFERENCES_INDEX:
        case INTEL_ARCH_LLC_MISSES_INDEX:
diff --git a/tools/testing/selftests/kvm/x86/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86/pmu_event_filter_test.c
index c15513cd74d1..1c5b7611db24 100644
--- a/tools/testing/selftests/kvm/x86/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86/pmu_event_filter_test.c
@@ -214,8 +214,10 @@ static void remove_event(struct __kvm_pmu_event_filter *f, uint64_t event)
 do {                                                                                   \
        uint64_t br = pmc_results.branches_retired;                                     \
        uint64_t ir = pmc_results.instructions_retired;                                 \
+       bool br_matched = this_pmu_has_errata(BRANCHES_RETIRED_OVERCOUNT) ?             \
+                         br >= NUM_BRANCHES : br == NUM_BRANCHES;                      \
                                                                                        \
-       if (br && br != NUM_BRANCHES)                                                   \
+       if (br && !br_matched)                                                          \
                pr_info("%s: Branch instructions retired = %lu (expected %u)\n",        \
                        __func__, br, NUM_BRANCHES);                                    \
        TEST_ASSERT(br, "%s: Branch instructions retired = %lu (expected > 0)",         \

