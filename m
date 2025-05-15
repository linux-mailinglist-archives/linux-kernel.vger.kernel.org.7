Return-Path: <linux-kernel+bounces-648694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922E5AB7A80
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 02:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FF574A0379
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 00:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A0D3D3B8;
	Thu, 15 May 2025 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cGpN0wsC"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F781B960
	for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 00:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747268398; cv=none; b=Q6niPHqoB597VPkgm9Ex4yrU6+0PR2wkyJivlJggU72ZvPUDGVtcMlq0BudnYV/k+2YifCTkIMZzz0cQJKIK1VCJ+BhjRBKKiQERrlAY0R0R/v+lCzvth2zauIrGbPHn2q9lLRumsDYFCm9jlw8p1wNt8UWk7V3JI4NeoKQzcms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747268398; c=relaxed/simple;
	bh=LjpMuPJLWL/kSD36VWNs6Nv8CF2pnWpxWtkNafcX8qI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hf/86/GxT3CssirNcJgzD+8GAF4PQcOsARUxbhL2W6ZVtCil07OxwXJ5Geu/9sGCkhQWMq/pXLorKiRHezXofttKK3AGAeKf15TNY/TTBF1TzjBvwMsshBq5l0LYkQ4z/OMcJXvW7sAYAKUXyrcz2zrL4c5NphlN71aW44HouBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cGpN0wsC; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30ad109bc89so400486a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 17:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747268396; x=1747873196; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NillZDQHMGkN8gsEINGl9IIKhPwgteKU+AMr08jxx80=;
        b=cGpN0wsCVFBG33lcBz1uHs+nfwzzkqv1AUTvfuyePYLl6tcU2yuHeZrzftncdn8jT4
         BZ+3ZwPjobA6iOUU1hg4ImgJyS5gruDKuu1hc7OwR48XAH4OYB/4W9xz0frZXmVQBuDH
         sgeqxSTGRh/7p+pzLbPa+D7Vb3cgia/uBpq3qfCccR7oYlvktKdtad/qdtB64E7g1X49
         J1Q3K/oIFcoax6ehIu0OzrVyPEOJ2SkkLEoqvfxrgtkYqGQ/wfzDnZWqGqNUhjzRE8J7
         B6Zd0cE40p7TJYsV+WYsCaW2dMdsX+4bU3N+QK44raVLYHT8g0fmuYvjuXZcqjgOpFh8
         HOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747268396; x=1747873196;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NillZDQHMGkN8gsEINGl9IIKhPwgteKU+AMr08jxx80=;
        b=bCIrscfNwx+wYnK3NjJzuTYUnQTYus62cY5uhns0TTMIKiolFOCU7Kw02NdPr+Ciau
         4HzberrnAVvbHcYzZW1F1oT86Te/LezaKqOfttNMzC6UGOSBb3B0FhKT7IZ/s4vxDx58
         A0QFbrcCXv3PaXNl6174qNeHs6AQ4pOXpg4Xd198QEIgiAG1KNVlpAoUXGTj6lRBz7zK
         4MI+76cK22/p0X6b/HkZFov3cp8uzVfyoKicyTQWkKKC2yd7GB74It2irbi+WHDPypAN
         X9L+epdmAYWU2mHwoVb2TvKEvHW6nTaka8HwOAEYzycOYJkIMaWM+G31kgXYK/+YKEfl
         uYNw==
X-Forwarded-Encrypted: i=1; AJvYcCXhK1AfzRe7I+qeyUezVRNAo+wyG2kKbrYbvS+Fx1lwx9ZgpTnRM+P+eeNFGEi78xoqeqMdGDetiJJjesM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLsp+/NIPA08Xkp6KWF6bxvV06i2cVGW3E5XYBpMuMxJ2t9g/i
	hVt3qHVJ+1O5O/S6xV75AWfJrnr/pa2ObKNv5CR4uE+xEB/1foNCzI8wFt5ixP1k+ufdmn4/OJW
	aGg==
X-Google-Smtp-Source: AGHT+IFQjq1PCKOnQWifSwkYyIBpWTwDXTf5nA7iDlW/f85riVF6j0D/YJzRcqSnGliIoEN7myQuTor4ttY=
X-Received: from pjn12.prod.google.com ([2002:a17:90b:570c:b0:2ef:8055:93d9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35c4:b0:30a:4700:ca91
 with SMTP id 98e67ed59e1d1-30e5156e9e0mr777959a91.1.1747268395729; Wed, 14
 May 2025 17:19:55 -0700 (PDT)
Date: Wed, 14 May 2025 17:19:54 -0700
In-Reply-To: <20250324173121.1275209-21-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-21-mizhang@google.com>
Message-ID: <aCUzKp1uhMsn-g_u@google.com>
Subject: Re: [PATCH v4 20/38] KVM: x86/pmu: Check if mediated vPMU can
 intercept rdpmc
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

The shortlog is wildly inaccurate.  KVM is not simply checking, KVM is actively
disabling RDPMC interception.  *That* needs to be the focus of the shortlog and
changelog.

> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 92c742ead663..6ad71752be4b 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -604,6 +604,40 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
>  	return 0;
>  }
>  
> +inline bool kvm_rdpmc_in_guest(struct kvm_vcpu *vcpu)

Strongly prefer kvm_need_rdpmc_intercept(), e.g. to follow vmx_need_pf_intercept(),
and because it makes the users more obviously correct.  The "in_guest" terminology
from kvm_{hlt,mwait,pause,cstate}_in_guest() isn't great, but at least in those
flows it's not awful because they are very direct reflections of knobs that control
interception, whereas this helper is making a variety of runtime checks.

> +{
> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +
> +	if (!kvm_mediated_pmu_enabled(vcpu))
> +		return false;
> +
> +	/*
> +	 * VMware allows access to these Pseduo-PMCs even when read via RDPMC
> +	 * in Ring3 when CR4.PCE=0.
> +	 */
> +	if (enable_vmware_backdoor)
> +		return false;
> +
> +	/*
> +	 * FIXME: In theory, perf metrics is always combined with fixed
> +	 *	  counter 3. it's fair enough to compare the guest and host
> +	 *	  fixed counter number and don't need to check perf metrics
> +	 *	  explicitly. However kvm_pmu_cap.num_counters_fixed is limited
> +	 *	  KVM_MAX_NR_FIXED_COUNTERS (3) as fixed counter 3 is not
> +	 *	  supported now. perf metrics is still needed to be checked
> +	 *	  explicitly here. Once fixed counter 3 is supported, the perf
> +	 *	  metrics checking can be removed.
> +	 */

And then what happens when hardware supported fixed counter #4?  KVM has the same
problem, and we can't check for features that KVM doesn't know about.

The entire problem is that this code is checking for *KVM* support, but what the
guest can see and access needs to be checked against *hardware* support.  Handling
that is simple, just take a snapshot of the host PMU capabilities before KVM
generates kvm_pmu_cap, and use the unadulterated snapshot here (and everywhere
else with similar checks).

> +	return pmu->nr_arch_gp_counters == kvm_pmu_cap.num_counters_gp &&
> +	       pmu->nr_arch_fixed_counters == kvm_pmu_cap.num_counters_fixed &&
> +	       vcpu_has_perf_metrics(vcpu) == kvm_host_has_perf_metrics() &&
> +	       pmu->counter_bitmask[KVM_PMC_GP] ==
> +				(BIT_ULL(kvm_pmu_cap.bit_width_gp) - 1) &&
> +	       pmu->counter_bitmask[KVM_PMC_FIXED] ==
> +				(BIT_ULL(kvm_pmu_cap.bit_width_fixed) - 1);
> +}
> @@ -212,6 +212,18 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
>  	bitmap_set(pmu->all_valid_pmc_idx, 0, pmu->nr_arch_gp_counters);
>  }
>  
> +static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
> +{
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +
> +	__amd_pmu_refresh(vcpu);

To better communicate the roles of the two paths to refresh():

	amd_pmu_refresh_capabilities(vcpu);

	amd_pmu_refresh_controls(vcpu);

Ditto for Intel.

