Return-Path: <linux-kernel+bounces-810862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8C8B520C9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C863A11B7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178B82D7D27;
	Wed, 10 Sep 2025 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RfNgrym+"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301322D7388
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757531988; cv=none; b=IJvBi/CRLOgG3wtHIu/fIghtjgX6xqx9zRFN+b8ProaK+w38yA1a+VAPfwgVxf0q4JItu2lc07LQkcHcZxmZzFnf+dq19A1CN8gHt2HGjP+PPcbO4ad1bRTvMUJEjBSq9g9glzZZufum6tXM+6RwTELdUbT54UfwHb/KqYYtJxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757531988; c=relaxed/simple;
	bh=qWueF42qwhO9/d4nulib23wqx9pkPXKoj4m8Enmbuag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tETwZVai2H4LRBUqYm/p08XS49duYghus+mj6DuzRLQ0Fl2Tdh2tgy3vIEs3WDp8aiBM62ktrU4X98tcCL6QJ5su8di8ntwijmEHFsqR3DxuE1DngVVBSopwjp7beYLn7yfhsLUcnxpHGT5ETXC/Pptw43MKAUEiwZmBGxXdFZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RfNgrym+; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4c928089fdso10567302a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757531985; x=1758136785; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VN/rggrH4digs9qBWZB1KbUoy16EnGUVMJIJH5xmr7E=;
        b=RfNgrym+tYbAWnYqtJTcZU17SPyOHkyDR4Q5WilKy+MgLEmjCxARjXZRNEeDw+nTOf
         XiRqj5L1LiJ6rHiYlXRxQfeo8paRSrLdnZWx848T7JO1535Dct1jL/7p6+jX+XpFmbxt
         pGgHzWt1iMMUOq/j5hSyN689xrDHYz/vMzvnnEhJZ7Dsu82dCCiVrGidifWSBC25Vr+O
         TBqUqz36L1+1uP9nRnWVP34biDAZdDmV27rEoWKOpRc1jNArTsL6X4FgriH3ZMDTuS1E
         pZnl3LOgiLhyIqFIOf+7OaSnvnVCvcPEVM7JS4LBoU/mvKWpgvgwJCR349lplWoE2/q9
         /WvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757531985; x=1758136785;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VN/rggrH4digs9qBWZB1KbUoy16EnGUVMJIJH5xmr7E=;
        b=YKkPJdrhrDya9M+X/dXCwn3BimUf2bW0Whgi3J9xuaNxPUE7DvqlNKt8fgJKICa0Ck
         dgx+Pyar18ggabvFZT5C1XMGKXCD0vOd9bdfDjMpax5IIQ7cvsf836NVAe5zyfZxnCcp
         n9UySY/Z+LjEnveFUfonxACcN2QcrdocX+f5vK9BZe4l5CROZgbpnyocWm6lZOPqOdf9
         gn9upoM4WwDFzplRw4yKU62XVtdEjPWZLvrGimOVfAtLHPDgQm4lnYdd2vSUfG5lx2gP
         5aD7lX4WEEDj3To8vH9bgnkxsES7ImdBbqI0SXWqeIFimy+c7CpH3ABDGhbBdye+rmVg
         Sg1g==
X-Forwarded-Encrypted: i=1; AJvYcCUJlWaIqNSfm/Z0YNfJhn2cNTOyUV5a23oJonPlfPXgcQH/UJSFiHC6kGgPTD6tH5Db9cTXEmn2kKTahQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjgJJVv1BQi2PKUKVqtmYSX9JB0oCT5BHKtmhNMmbMw9jB0AF2
	KNBg1h408cbbSA50GOr/jA7QX1TrsiZKNwjsg9YIzz8UtZwVt77uSPtoqAG9YGZPZ3zUm/XBBAl
	SKJX0qg==
X-Google-Smtp-Source: AGHT+IHX7UynOVRpi3If/F9N5K/tO9bGneP/KTRE0HxApIqGpBDwKgUOwjvsvvWc3ktK/GVAM4OFjpZif2s=
X-Received: from pfqr14.prod.google.com ([2002:aa7:9ece:0:b0:772:750f:4e23])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d9c:b0:245:fdeb:d264
 with SMTP id adf61e73a8af0-2533e576707mr26771465637.12.1757531985441; Wed, 10
 Sep 2025 12:19:45 -0700 (PDT)
Date: Wed, 10 Sep 2025 12:19:43 -0700
In-Reply-To: <ad3dfe758bdd63256a32d9c626b8fbcb2390f26e.1755897933.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1755897933.git.thomas.lendacky@amd.com> <ad3dfe758bdd63256a32d9c626b8fbcb2390f26e.1755897933.git.thomas.lendacky@amd.com>
Message-ID: <aMHPT4AbJrGRNv05@google.com>
Subject: Re: [RFC PATCH 1/4] KVM: SEV: Publish supported SEV-SNP policy bits
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-crypto@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 22, 2025, Tom Lendacky wrote:
> Define the set of policy bits that KVM currently knows as not requiring
> any implementation support within KVM. Provide this value to userspace
> via the KVM_GET_DEVICE_ATTR ioctl.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/include/uapi/asm/kvm.h |  1 +
>  arch/x86/kvm/svm/sev.c          | 11 ++++++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
> index 0f15d683817d..90e9c4551fa6 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -468,6 +468,7 @@ struct kvm_sync_regs {
>  /* vendor-specific groups and attributes for system fd */
>  #define KVM_X86_GRP_SEV			1
>  #  define KVM_X86_SEV_VMSA_FEATURES	0
> +#  define KVM_X86_SNP_POLICY_BITS	1
>  
>  struct kvm_vmx_nested_state_data {
>  	__u8 vmcs12[KVM_STATE_NESTED_VMX_VMCS_SIZE];
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 2fbdebf79fbb..7e6ce092628a 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -78,6 +78,8 @@ static u64 sev_supported_vmsa_features;
>  					 SNP_POLICY_MASK_DEBUG		| \
>  					 SNP_POLICY_MASK_SINGLE_SOCKET)
>  
> +static u64 snp_supported_policy_bits;

This can be __ro_after_init.  Hmm, off topic, but I bet we can give most of the
variables confifugred by sev_hardware_setup() the same treatment.  And really
off topic, I have a patch somewhere to convert a bunch of KVM variables from
__read_mostly to __ro_after_init...

