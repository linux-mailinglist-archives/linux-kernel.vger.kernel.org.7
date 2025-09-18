Return-Path: <linux-kernel+bounces-776144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BFEB2C91B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79FB518908B0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5382BF3DF;
	Tue, 19 Aug 2025 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vhMIDXjN"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37AE284883
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755619767; cv=none; b=sQXIQHkmNM//GzeONcSuFuTVC5AOeADWovgDVlf0ip1jjSSd+tDbZduuMcfxusE4mM0Vhfc6Hw+tDDlSm6kv4AkVcEZWNjXy5ryobjuQ8jjPsRr0k0eZvOKfcXIFOdHF9LQZuPjaPwJ0KElBayUi5J1qI7VslbKb1GpH80XLT7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755619767; c=relaxed/simple;
	bh=syXUDt3xavRGCWn7mDGCTpBtHJ2N/cYn+QuNd85oo0U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i5T11iw/PIS2iwJmpNfJaA+0FWXC/g+duP27G5sfMM0GnavsC0NxAe6oLaKeFIfLQzP1rJwk8S54W6sQLTLjXlPiSpNC5b6VkgiXd3KRJPFNpTOzlS1+AiddKHJMxuummPuQqFKRmcIEzAIybJwpDw19JyY32TuElgF0bQeXUPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vhMIDXjN; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24457efb475so63454265ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755619765; x=1756224565; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UYkzH86CEfLjeivDFeHRbhTbW/OMRYaK4MdX4XVBMm0=;
        b=vhMIDXjN0MyIX9U7n/AHfAp8nbuGP4XMwskdk3hmOyF1YZX+xBjeE7+yZxteLnovJV
         jBDycZC9u8JSMzSKENCUqT0oMmvroUxvhmzOJfz9CQq9XwkxYPFYxtuejqhoGPpDs8D0
         rE2YJb20FgO4hOdzRotK9p+ZGxpweENBzEun7CiIzIrerqdja3XCIF+vjoEj54rq4lTU
         3kma/4fJE2BBnPfwZxKRNu6izeYsE98jVAqB2L21Wsp8crxO1t9bmU1nSM6uqyy7b2ig
         CqqELXYp8DR2TYcIfuBFd1vyH2AXh94P1lx+tN101iLrXW0cWg90MqoX28v+Ux1puHn/
         BILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755619765; x=1756224565;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UYkzH86CEfLjeivDFeHRbhTbW/OMRYaK4MdX4XVBMm0=;
        b=NeTx5hvFbJG+NzCa9FIFaOtNXHkWG3EqGp3DaB6pYbSt91i1E9HxbkTqid/4B8UwAB
         2L6v/Xd5t4DoNmKrofXY7UaLfUXv/l+5CEY8RtDGbzf+CaE++aLVZIC0iJvRpaoHuIxS
         ow8oR01h+tCiJgMfCw+Eu4+g9z1XKdiXXeVyjX4FiY2dJSFTIfGe046wnZcqiR94FaHw
         2o2FjeXLELBLNy4Jmx3xAnY2nEHx0L3qgylJQIWgDJ5rGw5MEtzyTr2aoiauOLsqLQJB
         5qu/buo/6uer8+zwsIm0nHF+BQ0Ko+cif1YGunoPzu1lOeyHuQgCKffmFvkp/pmwq8jy
         s6ew==
X-Forwarded-Encrypted: i=1; AJvYcCU+obKzRgz0PtCe8pjYR07jSfqfzyKfDqo1rBg8XnD1A2NU9HtN/0A1IKYcuNT2T5Uk18O1VORPUQ9cHXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKSI9FnuSDb1fji6mafvwfNZiqYrOiG4v/Ep6vY+XVtgQJWk7n
	3HloEz9o7jF5/PXKiYfWwE5zLbFqZkxZJRALf5vqa6Ad1248me/vkD8FaNDQv7Ynf4oftNg22mz
	X7aYJCw==
X-Google-Smtp-Source: AGHT+IH6R2QwD1yBkzYuEBNWnVDESXH7eaf8PVAwWCpi0xr5w/otmuGJ45cfZkJ/B+gcHedXX4CM89800NA=
X-Received: from pjee5.prod.google.com ([2002:a17:90b:5785:b0:311:ef56:7694])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da8e:b0:236:9726:7264
 with SMTP id d9443c01a7336-245e045ce2amr35236595ad.5.1755619765046; Tue, 19
 Aug 2025 09:09:25 -0700 (PDT)
Date: Tue, 19 Aug 2025 09:09:23 -0700
In-Reply-To: <20250812025606.74625-16-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812025606.74625-1-chao.gao@intel.com> <20250812025606.74625-16-chao.gao@intel.com>
Message-ID: <aKShs0btGwLtYlVc@google.com>
Subject: Re: [PATCH v12 15/24] KVM: VMX: Emulate read and write to CET MSRs
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mlevitsk@redhat.com, 
	rick.p.edgecombe@intel.com, weijiang.yang@intel.com, xin@zytor.com, 
	Mathias Krause <minipli@grsecurity.net>, John Allen <john.allen@amd.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 11, 2025, Chao Gao wrote:
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index b5c4db4b7e04..cc39ace47262 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1885,6 +1885,27 @@ static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
>  
>  		data = (u32)data;
>  		break;
> +	case MSR_IA32_U_CET:
> +	case MSR_IA32_S_CET:
> +		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) &&
> +		    !guest_cpu_cap_has(vcpu, X86_FEATURE_IBT))
> +			return KVM_MSR_RET_UNSUPPORTED;
> +		if (!is_cet_msr_valid(vcpu, data))
> +			return 1;
> +		break;
> +	case MSR_KVM_INTERNAL_GUEST_SSP:
> +		if (!host_initiated)
> +			return 1;
> +		fallthrough;
> +	case MSR_IA32_PL0_SSP ... MSR_IA32_INT_SSP_TAB:
> +		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK))
> +			return KVM_MSR_RET_UNSUPPORTED;
> +		if (is_noncanonical_msr_address(data, vcpu))

This emulation is wrong (in no small part because the architecture sucks).  From
the SDM:

  If the processor does not support Intel 64 architecture, these fields have only
  32 bits; bits 63:32 of the MSRs are reserved.

  On processors that support Intel 64 architecture this value cannot represent a
  non-canonical address.

  In protected mode, only 31:0 are loaded.

That means KVM needs to drop bits 63:32 if the vCPU doesn't have LM or if the vCPU
isn't in 64-bit mode.  The last one is especially frustrating, because software
can still get a 64-bit value into the MSRs while running in protected, e.g. by
switching to 64-bit mode, doing WRMSRs, then switching back to 32-bit mode.

But, there's probably no point in actually trying to correctly emulate/virtualize
the Protected Mode behavior, because the MSRs can be written via XRSTOR, and to
close that hole KVM would need to trap-and-emulate XRSTOR.  No thanks.

Unless someone has a better idea, I'm inclined to take an erratum for this, i.e.
just sweep it under the rug.

> +			return 1;
> +		/* All SSP MSRs except MSR_IA32_INT_SSP_TAB must be 4-byte aligned */
> +		if (index != MSR_IA32_INT_SSP_TAB && !IS_ALIGNED(data, 4))
> +			return 1;
> +		break;
>  	}
>  
>  	msr.data = data;

...

> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index f8fbd33db067..d5b039addd11 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -733,4 +733,27 @@ static inline void kvm_set_xstate_msr(struct kvm_vcpu *vcpu,
>  	kvm_fpu_put();
>  }
>  
> +#define CET_US_RESERVED_BITS		GENMASK(9, 6)
> +#define CET_US_SHSTK_MASK_BITS		GENMASK(1, 0)
> +#define CET_US_IBT_MASK_BITS		(GENMASK_ULL(5, 2) | GENMASK_ULL(63, 10))
> +#define CET_US_LEGACY_BITMAP_BASE(data)	((data) >> 12)
> +
> +static inline bool is_cet_msr_valid(struct kvm_vcpu *vcpu, u64 data)

This name is misleading, e.g. it reads "is this CET MSR valid", whereas the helper
is checking "is this value for U_CET or S_CET valid".  Maybe kvm_is_valid_u_s_cet()?

> +{
> +	if (data & CET_US_RESERVED_BITS)
> +		return false;
> +	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) &&
> +	    (data & CET_US_SHSTK_MASK_BITS))
> +		return false;
> +	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_IBT) &&
> +	    (data & CET_US_IBT_MASK_BITS))
> +		return false;
> +	if (!IS_ALIGNED(CET_US_LEGACY_BITMAP_BASE(data), 4))
> +		return false;
> +	/* IBT can be suppressed iff the TRACKER isn't WAIT_ENDBR. */
> +	if ((data & CET_SUPPRESS) && (data & CET_WAIT_ENDBR))
> +		return false;
> +
> +	return true;
> +}
>  #endif
> -- 
> 2.47.1
> 

