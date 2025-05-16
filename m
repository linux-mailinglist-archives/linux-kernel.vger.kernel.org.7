Return-Path: <linux-kernel+bounces-651344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CC9AB9D95
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 15:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B713D17ED9F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 13:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C7F76C61;
	Fri, 16 May 2025 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FncOLA1C"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E9C200A3
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402416; cv=none; b=DL2r+hW+JDmemB/erubX/iNAD3gXxkyql4BsGBo5h+7R6cvbn/XACrGO6M0BLCtJqJ7yDn/tcChQJ5M2KZzqIkhIOQ5hzjNzrLujPoLNmwXEBmvSt9tSi8Use3nRlcFMif0aofSRLsqwQY3ELz5D1PmJeGO7ptJuW3r3sYfsPDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402416; c=relaxed/simple;
	bh=FRhZIy8C0eW0eRV1rO4kuguYk5yijvbkKsK/cWBDRgs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BOXbsIN++Ifilr4o3s5JRzDniqB5qaOpYIWiAKym3EowKYUGLvKa5GjnF+L6/BJcyqOKib4Qq2wHV0rX7xsoawoWp+pDgB5IQyOFh+KyxgL/5XerdgUWy3Tp985Nxsx4EHWTukEy3oC43dohJtnyrp9boDsiClwe0g56Ery0jU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FncOLA1C; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30abb33d1d2so4016882a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 06:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747402413; x=1748007213; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KDGUVX2RwhNLT5NPXxVSV0DdRBsVZS86wObxxPPsbk8=;
        b=FncOLA1Ci+PPI8KkrI4MVo2B1SzWYk4GQH5SBxaCnhOV/Jl/JikxORZrdmn2KLl4Is
         NHiOJZpi8akdmXOxXG8zUf7mTNTwnCkeGFriZydIOEBn3kj2HVXzSy9QTK40ncVXowFE
         hq6mqs9bLx7MUMhxtmYyL/yFJluuI+E5fKnmF3rko5LP0+YrpD5IdCTqZJm+QlTxpTrq
         qnwdLZC3uiMvzA0aL4sdWrrHYkp0RapQ2oHxAUL/66ZGPBmT926BSPZ/EtkiiBnS7aTA
         1KIRlIkmZq9pys74X/vdh6H3wQLV6zZ0MTx44IIBTkbn++g2pmPIXk2tMA/5I0rNwGoI
         Y4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747402413; x=1748007213;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KDGUVX2RwhNLT5NPXxVSV0DdRBsVZS86wObxxPPsbk8=;
        b=JmenS2q37NrJPAEklU1qnbvNYMdccPjp36CIs+2K0q1NPNTev54f7zJMQW5dRi1qkP
         L+Tj5Kb3we7eaNRpsUNR5Z7yJY5mJHTa2gH/tEpo1tRLy3lRqTGAa4fZAoRFOGg2kd7E
         2XAlHxsDylf8jqmJlx+HM8qsSA82Rhz/bSMvBSqVuwOjL97LL6VL9Zw3j71UFMzqt/7Y
         z+Dcz1endiiULMKo+zDBKTbmHvOrmBKm95nHFLYhR9KKSbtxSvZV6Tm9NKGb/ugH+cj1
         VoSjj0EY0ou6PhdDNzvQJAO5qUusxxBkUBXNVOKbKw9TKR96DN2Zya+dm6Fuelts3uFz
         bmiA==
X-Forwarded-Encrypted: i=1; AJvYcCXkXMoJee0T3lZxWlcB3iKxn4aauPPIKPgM8LC9vIS2U1xP0TPBBiXkLlmELBq2O2t0tUb3NuWkzvgLcWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8CXFFF4u7DfsYGa474F6A7zRVgp3+Y3nRgNZb3jl4BdjAmQQ9
	HXhydaec5NHJRpDBeDV0HA/tXXGgHf8Hl4ZdPYy/cdijDl/i10HluKbs6XHxcmdXM5TpKYWse4Q
	HH97ytw==
X-Google-Smtp-Source: AGHT+IGqXXBKxkrM7eRDYiPnM7bRnqmiBwCU1lHICfCxR4zzeniMzTPy5RM6XoGiiUxm0AtX4CbnBEq/OEA=
X-Received: from plgm8.prod.google.com ([2002:a17:902:f648:b0:223:f7b1:99cc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c949:b0:224:5a8:ba29
 with SMTP id d9443c01a7336-231de3ba251mr35699265ad.43.1747402413061; Fri, 16
 May 2025 06:33:33 -0700 (PDT)
Date: Fri, 16 May 2025 06:33:31 -0700
In-Reply-To: <20250324173121.1275209-33-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-33-mizhang@google.com>
Message-ID: <aCc-q_udsn8o1vBT@google.com>
Subject: Re: [PATCH v4 32/38] KVM: nVMX: Add nested virtualization support for
 mediated PMU
From: Sean Christopherson <seanjc@google.com>
To: Mingwei Zhang <mizhang@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Jim Mattson <jmattson@google.com>, 
	Sandipan Das <sandipan.das@amd.com>, Zide Chen <zide.chen@intel.com>, 
	Eranian Stephane <eranian@google.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="us-ascii"

This shortlog is unnecessarily confusing.  It reads as if supported for running
L2 in a vCPU with a mediated PMU is somehow lacking.

On Mon, Mar 24, 2025, Mingwei Zhang wrote:
> Add nested virtualization support for mediated PMU by combining the MSR
> interception bitmaps of vmcs01 and vmcs12.

Do not phrase changelogs related to nested virtualization in terms of enabling a
_KVM_ feature.  KVM has no control over what hypervisor runs in L1.  It's a-ok to
provide example use cases, but they need to be just that, examples.

> Readers may argue even without this patch, nested virtualization works for
> mediated PMU because L1 will see Perfmon v2 and will have to use legacy vPMU
> implementation if it is Linux. However, any assumption made on L1 may be
> invalid, e.g., L1 may not even be Linux.
> 
> If both L0 and L1 pass through PMU MSRs, the correct behavior is to allow
> MSR access from L2 directly touch HW MSRs, since both L0 and L1 passthrough
> the access.
> 
> However, in current implementation, if without adding anything for nested,
> KVM always set MSR interception bits in vmcs02. This leads to the fact that
> L0 will emulate all MSR read/writes for L2, leading to errors, since the
> current mediated vPMU never implements set_msr() and get_msr() for any
> counter access except counter accesses from the VMM side.
> 
> So fix the issue by setting up the correct MSR interception for PMU MSRs.

This is not a fix.  

    KVM: nVMX: Disable PMU MSR interception as appropriate while running L2
    
    Merge KVM's PMU MSR interception bitmaps with those of L1, i.e. merge the
    bitmaps of vmcs01 and vmcs12, e.g. so that KVM doesn't interpose on MSR
    accesses unnecessarily if L1 exposes a mediated PMU (or equivalent) to L2.

> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index cf557acf91f8..dbec40cb55bc 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -626,6 +626,36 @@ static inline void nested_vmx_set_intercept_for_msr(struct vcpu_vmx *vmx,
>  #define nested_vmx_merge_msr_bitmaps_rw(msr) \
>  	nested_vmx_merge_msr_bitmaps(msr, MSR_TYPE_RW)
>  
> +/*
> + * Disable PMU MSRs interception for nested VM if L0 and L1 are
> + * both mediated vPMU.
> + */

Again, KVM has no idea what is running in L1.  Drop this.

> +static void nested_vmx_merge_pmu_msr_bitmaps(struct kvm_vcpu *vcpu,
> +					     unsigned long *msr_bitmap_l1,
> +					     unsigned long *msr_bitmap_l0)
> +{
> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +	int i;
> +
> +	if (!kvm_mediated_pmu_enabled(vcpu))

This is a worthwhile check, but a comment would be helpful:

	/*
	 * Skip the merges if the vCPU doesn't have a mediated PMU MSR, i.e. if
	 * none of the MSRs can possibly be passed through to L1.
	 */
	if (!kvm_vcpu_has_mediated_pmu(vcpu))
		return;

> +		return;
> +
> +	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
> +		nested_vmx_merge_msr_bitmaps_rw(MSR_ARCH_PERFMON_EVENTSEL0 + i);

This is unnecessary, KVM always intercepts event selectors.

> +		nested_vmx_merge_msr_bitmaps_rw(MSR_IA32_PERFCTR0 + i);
> +		nested_vmx_merge_msr_bitmaps_rw(MSR_IA32_PMC0 + i);
> +	}
> +
> +	for (i = 0; i < pmu->nr_arch_fixed_counters; i++)
> +		nested_vmx_merge_msr_bitmaps_rw(MSR_CORE_PERF_FIXED_CTR0 + i);
> +
> +	nested_vmx_merge_msr_bitmaps_rw(MSR_CORE_PERF_FIXED_CTR_CTRL);

Same thing here.

> +	nested_vmx_merge_msr_bitmaps_rw(MSR_CORE_PERF_GLOBAL_CTRL);
> +	nested_vmx_merge_msr_bitmaps_read(MSR_CORE_PERF_GLOBAL_STATUS);
> +	nested_vmx_merge_msr_bitmaps_write(MSR_CORE_PERF_GLOBAL_OVF_CTRL);
> +}

