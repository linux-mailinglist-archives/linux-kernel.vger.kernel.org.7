Return-Path: <linux-kernel+bounces-696364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4329AE25EE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jun 2025 01:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED7AB7A47E5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 23:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E92241676;
	Fri, 20 Jun 2025 23:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KEXAd2A2"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A120723C505
	for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 23:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461208; cv=none; b=oZTO8SY67bxVb6Q5ifXJbZNHeUHKjqRyfUz7LCOMHAMXVcKEYlLmJGUxJ78ZthE1Z/Yk1tBmfRwxa/oSxU8A+MIvf//RkhRBlweCaRIYug8+fCXaE/wExdf8WngC+3XzqNAUhMzicupC6pJvfgKbX5uM//iterDnN1jrA7DxCQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461208; c=relaxed/simple;
	bh=ejHsLwAI1iRBNNL/r378fhaYBbN+C4pKbNfS8unnfJQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OIRgMbpfArn3KMUWBWQM/lKLtD638D7RqyXRenl67CMAa5bb52ulwtiLDLLZQDoLZ8RHSIz1s1cy0aRJPDdnvMYfc6F7ZcO34XmOc78w4fwD23P/fUQHvECBQC03D/PNJYSkrGf/T4CwkIR5UcElEJ1GH25rz/lPFrdv50aeR3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KEXAd2A2; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-235e1d66fa6so26460815ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 16:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461206; x=1751066006; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EJmLTmvvg0E7izo+/RvoiskKc3ULA4/sxq8y6FuVrPg=;
        b=KEXAd2A2sODuHx7sG9Wwy3BI+9Utmu6d63EiVGpqPcoiB2kGyvTVQkFzXqo8Xd8x9w
         yCKL/Hk3CiM4OoQFG4aofv33cgnEAAHSIkyO3KP0CpUXEvy5+550ZQ6rLVUfvAnfCtq/
         ShcAYEG/j4zWhCeKv9sS5zEdHGrrOgs78m7iuPc7nbG1vr3o69dq6rZyUe3QMpVx7W2n
         3K1i72cU/SM3LLr8WLMP/5PfnxUW6YWM69gVUeS7CsZI8Us+0HEQD+iPyRNUDW2k+Sd1
         PwiqlMDz9ARogGs4e8YALGsZQ27FCghGheWQednVVslxvBtebsR/RvwguQap8o/0KLhf
         sSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461206; x=1751066006;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJmLTmvvg0E7izo+/RvoiskKc3ULA4/sxq8y6FuVrPg=;
        b=wo3l11Y+CK2+E23boL1p8Btja3BepiWfblhVwmnUaeSpjF+bOean1Nu2OQk2OX5Epz
         nTLRwsbi9YSiHR8Q4FWOX76hMMH2COFzl74Gdkpp+O2vMHKk7qBYBU9lgH8pt+yLCgow
         /bjAt5rNrWgvTq1y4NtPFsvZ79Pv0FCzVO1/2uDV3loCyFtR0y6SQx3/3Y3DAQ70dfAk
         ljeWeOPWM+Gmpb3kaFrz4ZV1R59apZ5NqQUt2GIphmrje29pd7c36v70f4gUPRZPhHyA
         ikNZkhPptZKICOLTkgCI0Kimi8rSIkTObZrfCL/d0bnPwDjKCsVFzdxBdL/bECBmQNcG
         5G8A==
X-Forwarded-Encrypted: i=1; AJvYcCWu6HhjFgkJI6fzeFD9r5oE5ly2v/xXxzKYm0sq9mf/xIm6rp+pNlBwXP1mAUxR+aowGD3blNj7MhZZIgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp78ywmf4aOH4s6+EsI6FHNjYGp+r64Xf1DdMzXuqWLTpjYqaE
	T9D5yWxG0hnrYuPWS2lV8pXZMoHFulf7i1DlJDgKSZaNDKyIW65xBxNZjD3CGDyLp+pAf8QjCR1
	XO+ttww==
X-Google-Smtp-Source: AGHT+IGpU0wSWZv0e+j+oZwhTfTGLz89dqX4GbiY2Zh4+crAkClvle5QmNlBgbXfUiTTYto+Kj/e9VYps/E=
X-Received: from pjboe18.prod.google.com ([2002:a17:90b:3952:b0:312:f88d:25f6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c43:b0:234:a139:1206
 with SMTP id d9443c01a7336-237d9accb06mr73650445ad.40.1750461206033; Fri, 20
 Jun 2025 16:13:26 -0700 (PDT)
Date: Fri, 20 Jun 2025 16:13:24 -0700
In-Reply-To: <20250326193619.3714986-7-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250326193619.3714986-1-yosry.ahmed@linux.dev> <20250326193619.3714986-7-yosry.ahmed@linux.dev>
Message-ID: <aFXrFKvZcJ3dN4k_@google.com>
Subject: Re: [RFC PATCH 06/24] KVM: SEV: Track ASID->vCPU instead of ASID->VMCB
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Rik van Riel <riel@surriel.com>, Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Mar 26, 2025, Yosry Ahmed wrote:
> SEV currently tracks the ASID to VMCB mapping for each physical CPU.
> This is required to flush the ASID when a new VMCB using the same ASID
> is run on the same CPU. Practically, there is a single VMCB for each
> vCPU using SEV. Furthermore, TLB flushes on nested transitions between
> VMCB01 and VMCB02 are handled separately (see
> nested_svm_transition_tlb_flush()).
> 
> In preparation for generalizing the tracking and making the tracking
> more expensive, start tracking the ASID to vCPU mapping instead. This
> will allow for the tracking to be moved to a cheaper code path when
> vCPUs are switched.
> 
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> ---
>  arch/x86/kvm/svm/sev.c | 12 ++++++------
>  arch/x86/kvm/svm/svm.c |  2 +-
>  arch/x86/kvm/svm/svm.h |  4 ++--
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index d613f81addf1c..ddb4d5b211ed7 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -240,7 +240,7 @@ static void sev_asid_free(struct kvm_sev_info *sev)
>  
>  	for_each_possible_cpu(cpu) {
>  		sd = per_cpu_ptr(&svm_data, cpu);
> -		sd->sev_vmcbs[sev->asid] = NULL;
> +		sd->sev_vcpus[sev->asid] = NULL;
>  	}
>  
>  	mutex_unlock(&sev_bitmap_lock);
> @@ -3081,8 +3081,8 @@ int sev_cpu_init(struct svm_cpu_data *sd)
>  	if (!sev_enabled)
>  		return 0;
>  
> -	sd->sev_vmcbs = kcalloc(nr_asids, sizeof(void *), GFP_KERNEL);
> -	if (!sd->sev_vmcbs)
> +	sd->sev_vcpus = kcalloc(nr_asids, sizeof(void *), GFP_KERNEL);
> +	if (!sd->sev_vcpus)
>  		return -ENOMEM;
>  
>  	return 0;
> @@ -3471,14 +3471,14 @@ int pre_sev_run(struct vcpu_svm *svm, int cpu)
>  	/*
>  	 * Flush guest TLB:
>  	 *
> -	 * 1) when different VMCB for the same ASID is to be run on the same host CPU.
> +	 * 1) when different vCPU for the same ASID is to be run on the same host CPU.

Tom, can you clarity what an ASID actually tags when NPT is in use?

The more I think about all of this, the less it makes sense.  The *entire* point
of an ASID is to tag TLB entries so that a flush isn't required when running code
for the same address space.

The main problem I'm struggling with is that, as usual, the APM doesn't properly
document anything, and just gives "suggestions" for the VMM.  *sigh*

As I read it, these snippets from the APM are saying ASIDs tag only GPA=>PA entries
when NPT is in use.

  TLB entries are tagged with Address Space Identifier (ASID) bits to distinguish
  different guest virtual address spaces when shadow page tables are used, or
  different guest physical address spaces when nested page tables are used. The
  VMM can choose a software strategy in which it keeps multiple shadow page tables,
  and/or multiple nested page tables in processors that support nested paging,
  up-to-date; the VMM can allocate a different ASID for each shadow or nested
  page table. This allows switching to a new process in a guest under shadow
  paging (changing CR3 contents), or to a new guest under nested paging (changing
  nCR3 contents), without flushing the TLBs.

  Note that because an ASID is associated with the guest's physical address
  space, it is common across all of the guest's virtual address spaces within a
  processor. This differs from shadow page tables where ASIDs tag individual
  guest virtual address spaces. Note also that the same ASID may or may not be
  associated with the same address space across all processors in a
  multiprocessor system, for either nested tables or shadow tables; this depends
  on how the VMM manages ASID assignment.

But then the "15.16.1 TLB Flush" section says this, without any qualification
whatsoever that it applies only to shadow paging.

  A MOV-to-CR3, a task switch that changes CR3, or clearing or setting CR0.PG or
  bits PGE, PAE, PSE of CR4 affects only the TLB entries belonging to the current
  ASID, regardless of whether the operation occurred in host or guest mode. The
  current ASID is 0 when the CPU is not inside a guest context.

And honestly, tagging only GPA=>PA entries doesn't make any sense, because
GVA=>GPA needs to be tagged with *something*.  And the APM doesn't say anything
about caching GPA=>PA translations, only about caching VA=>PA.

The thing that doesn't fit is that SEV+ uses ASIDs on a per-VM basis.  I suggested
per-VM ASIDs for all VM types based solely on that fact, but now I'm wondering if
it's SEV+ that crazy and broken.  Because if ASIDs also tag GVA=>GPA, then SEV has
a massive architectural security hole, e.g. a malicious hypervisor can coerce the
CPU into using a stale GVA=>GPA TLB entry by switching vCPUs and letting guest
process with CR3=x access memory for guest process with CR3=y.  But again, if
ASIDs don't tag GVA=>GPA, then what provides isolation between vCPUs!?!?!

Assuming ASIDs tag VA=>PA (i.e. the combined GVA=>GPA=>PA translation), then I
take back my suggestion to use per-VM ASIDs, and instead propose we treat ASIDs
like VPIDs, i.e. use per-vCPU ASIDs (well, technically per-VMCB, because nested).
All server SKUs I've checked (Rome, Milan, Genoa, and Turin) support 0x8000 ASIDs.
That makes the ~512 ASIDs reserved for SEV+ a drop in the bucket, i.e. still leaves
~32k ASIDs up for grabs, which means KVM can concurrently run ~16k vCPUs *with*
nested VMs without having to fallback to flushing when scheduling in a new vCPU.

That way we don't need the complexity of the xarray ASID=>vCPU tracking for common
code.  And as a bonus, the logic for VMX vs. SVM is very, very similar.

Given the SEV+ uses the ASID as the handle for the guest's encryption key,
changing that behavior isn't an option.  Though I still don't see how that isn't
a security flaw.  Regardless, I definitely don't think it's something we should
follow.

