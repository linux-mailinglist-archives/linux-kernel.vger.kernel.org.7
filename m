Return-Path: <linux-kernel+bounces-667352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0FBAC83FB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 00:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A4463B99CF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 22:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348C221D5A9;
	Thu, 29 May 2025 22:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g2HJI3+e"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0925B2192F4
	for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 22:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748557166; cv=none; b=roOU80iNJ+0FuMxqLjdF4wwOB1jLCWstNvHFFtWhnrC+mMr4YJnnfnMrEThWBL7ilE6Qtxb9nAOD23nV4B9rld69TvrldKJ2/vRimD4Kk6SjzPOvkj9ZjI1MUtEmOnBnOgHt5gmlNw7wwHAq4hIGmmR7LdWTenP5bAt8By/PcRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748557166; c=relaxed/simple;
	bh=/axPWx9pFiZ88xSg3GvujPUpn0OIAQd+muRjqg6LQbU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rRDO4XT/eVzYYEVVAfBLGvEj4CLUUEst8bjhF5ui95UpRJTAN+bqX/CUSnENMDE1gzvz9wWzz10A0oDEJvhED6XICRjnXM+66pzLR9EG81LjJFJVNlvVDEnSHq93C1CJufoCXEFCjsDXaCOs3aF7KiItw6ZqOG2qqOO58kuiVAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g2HJI3+e; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311e7337f26so1080811a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 15:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748557164; x=1749161964; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n+PW3r+/BVI5LEotwQK4/wqYAkrq0SQ+HqmcFVNfHnQ=;
        b=g2HJI3+e+JIxJkSFNERGzufhNxVOpPsLEY+ftZZGlBONpCD3VXCq+Hy58niPMbMAg9
         7xR4or5WQeJuxHiMCEoUetJMGcf4eE9zRX73aRPoYrZh25KPLAYdxnI+Ie0qDscUce9c
         x6Rr8hr8N+m1Jvu4MiEJwI9tovcJ7RrF98m20j0U+g30DOS9ymeHtNpRKSq8001SFCbl
         GPnmXY81nd+P+gdIIv5UKuSXXuBADNKgdHRGLOtreo08OmQfLFc+Lb3iHmLvoJsHxDAm
         Eb0HQ3IA8tDRVg4JN6rfIoj+HOxfNQ/QRZeFnmQA7FcknKlx3scUfmMZ7M5gZZXTrwxc
         sMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748557164; x=1749161964;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n+PW3r+/BVI5LEotwQK4/wqYAkrq0SQ+HqmcFVNfHnQ=;
        b=Wdp0JepD5xXsCprtAlkZ1L9y4YriJROj8QDLWqAU4BToj+xIktbFb5QcK+NOHe8Cq9
         ErdOxHeblqZdKg27g/qTH4xs4jOMISBgMlwbl8LTZjsC4Ua7sgyWA6SBecH1iy5pzgwM
         QEaI64emvd3KR4ofQrEtwUScR/4zENX6o/hn0C7gyauwtR0RrUdwRxbu+p6OxtLt9hGC
         E0OvIHjOg8kIWQNpgxqE3NHvq0la3ONITjhQusLYmXvr6O90OugMCeROJcd0mUtOF/F3
         kROCBx3u7IwCH/SAgwK5GDAptH90lcmY9ZPcRJDGV/+JANqCRm+VbUzjHg0ChFxpb1Rp
         c8xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWrWTLd7anGtgfBWSJ+sI3DCrRJxU/cXvcpGgUQPfBKzyuEE4KAxmCVDSoj70uyKwk4jhSN+jmq8/uMYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJWnHVOb0/+c5OXy/fjA43O+Tm3QWVIW0iSvl54pwS3fgPIenN
	i2lsV1vhIEmTuQKSeSFGAPPBhVTvAAXk9c2OapEJmaMCJtWsvZ4ZCyvJj9+6/fcvE/nTRnZhaF5
	W3l8A8A==
X-Google-Smtp-Source: AGHT+IEUE7BQQdmGE1MoMD1DBcEUe9iBvKfMPZydDvm6S7w80UfsVuDxXmeHBia3lTenxO64ia7iv33wXmA=
X-Received: from pjbse6.prod.google.com ([2002:a17:90b:5186:b0:30a:7da4:f075])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b90:b0:311:eb85:96df
 with SMTP id 98e67ed59e1d1-31241531935mr1811010a91.17.1748557164266; Thu, 29
 May 2025 15:19:24 -0700 (PDT)
Date: Thu, 29 May 2025 15:19:22 -0700
In-Reply-To: <20250529042710.crjcc76dqpiak4pn@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523011756.3243624-1-seanjc@google.com> <20250523011756.3243624-4-seanjc@google.com>
 <20250529042710.crjcc76dqpiak4pn@desk>
Message-ID: <aDjdagbqcesTcnhc@google.com>
Subject: Re: [PATCH 3/5] KVM: VMX: Apply MMIO Stale Data mitigation if KVM
 maps MMIO into the guest
From: Sean Christopherson <seanjc@google.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 28, 2025, Pawan Gupta wrote:
> On Thu, May 22, 2025 at 06:17:54PM -0700, Sean Christopherson wrote:
> > @@ -7282,7 +7288,7 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
> >  	if (static_branch_unlikely(&vmx_l1d_should_flush))
> >  		vmx_l1d_flush(vcpu);
> >  	else if (static_branch_unlikely(&mmio_stale_data_clear) &&
> > -		 kvm_arch_has_assigned_device(vcpu->kvm))
> > +		 (flags & VMX_RUN_CLEAR_CPU_BUFFERS_FOR_MMIO))
> >  		mds_clear_cpu_buffers();
> 
> I think this also paves way for buffer clear for MDS and MMIO to be done at
> a single place. Please let me know if below is feasible:

It's definitely feasible (this thought crossed my mind as well), but because
CLEAR_CPU_BUFFERS emits VERW iff X86_FEATURE_CLEAR_CPU_BUF is enabled, the below
would do nothing for the MMIO case (either that, or I'm missing something).

We could obviously rework CLEAR_CPU_BUFFERS, I'm just not sure that's worth the
effort at this point.  I'm definitely not opposed to it though.

> diff --git a/arch/x86/kvm/vmx/run_flags.h b/arch/x86/kvm/vmx/run_flags.h
> index 2f20fb170def..004fe1ca89f0 100644
> --- a/arch/x86/kvm/vmx/run_flags.h
> +++ b/arch/x86/kvm/vmx/run_flags.h
> @@ -2,12 +2,12 @@
>  #ifndef __KVM_X86_VMX_RUN_FLAGS_H
>  #define __KVM_X86_VMX_RUN_FLAGS_H
>  
> -#define VMX_RUN_VMRESUME_SHIFT				0
> -#define VMX_RUN_SAVE_SPEC_CTRL_SHIFT			1
> -#define VMX_RUN_CLEAR_CPU_BUFFERS_FOR_MMIO_SHIFT	2
> +#define VMX_RUN_VMRESUME_SHIFT			0
> +#define VMX_RUN_SAVE_SPEC_CTRL_SHIFT		1
> +#define VMX_RUN_CLEAR_CPU_BUFFERS_SHIFT		2
>  
> -#define VMX_RUN_VMRESUME			BIT(VMX_RUN_VMRESUME_SHIFT)
> -#define VMX_RUN_SAVE_SPEC_CTRL			BIT(VMX_RUN_SAVE_SPEC_CTRL_SHIFT)
> -#define VMX_RUN_CLEAR_CPU_BUFFERS_FOR_MMIO	BIT(VMX_RUN_CLEAR_CPU_BUFFERS_FOR_MMIO_SHIFT)
> +#define VMX_RUN_VMRESUME		BIT(VMX_RUN_VMRESUME_SHIFT)
> +#define VMX_RUN_SAVE_SPEC_CTRL		BIT(VMX_RUN_SAVE_SPEC_CTRL_SHIFT)
> +#define VMX_RUN_CLEAR_CPU_BUFFERS	BIT(VMX_RUN_CLEAR_CPU_BUFFERS_SHIFT)
>  
>  #endif /* __KVM_X86_VMX_RUN_FLAGS_H */
> diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
> index f6986dee6f8c..ab602ce4967e 100644
> --- a/arch/x86/kvm/vmx/vmenter.S
> +++ b/arch/x86/kvm/vmx/vmenter.S
> @@ -141,6 +141,8 @@ SYM_FUNC_START(__vmx_vcpu_run)
>  	/* Check if vmlaunch or vmresume is needed */
>  	bt   $VMX_RUN_VMRESUME_SHIFT, %ebx
>  
> +	test $VMX_RUN_CLEAR_CPU_BUFFERS, %ebx
> +
>  	/* Load guest registers.  Don't clobber flags. */
>  	mov VCPU_RCX(%_ASM_AX), %_ASM_CX
>  	mov VCPU_RDX(%_ASM_AX), %_ASM_DX
> @@ -161,8 +163,11 @@ SYM_FUNC_START(__vmx_vcpu_run)
>  	/* Load guest RAX.  This kills the @regs pointer! */
>  	mov VCPU_RAX(%_ASM_AX), %_ASM_AX
>  
> +	/* Check EFLAGS.ZF from the VMX_RUN_CLEAR_CPU_BUFFERS bit test above */
> +	jz .Lskip_clear_cpu_buffers
>  	/* Clobbers EFLAGS.ZF */
>  	CLEAR_CPU_BUFFERS
> +.Lskip_clear_cpu_buffers:
>  
>  	/* Check EFLAGS.CF from the VMX_RUN_VMRESUME bit test above. */
>  	jnc .Lvmlaunch
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 1e4790c8993a..1415aeea35f7 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -958,9 +958,10 @@ unsigned int __vmx_vcpu_run_flags(struct vcpu_vmx *vmx)
>  	if (!msr_write_intercepted(vmx, MSR_IA32_SPEC_CTRL))
>  		flags |= VMX_RUN_SAVE_SPEC_CTRL;
>  
> -	if (static_branch_unlikely(&mmio_stale_data_clear) &&
> -	    kvm_vcpu_can_access_host_mmio(&vmx->vcpu))
> -		flags |= VMX_RUN_CLEAR_CPU_BUFFERS_FOR_MMIO;
> +	if (cpu_feature_enabled(X86_FEATURE_CLEAR_CPU_BUF) ||
> +	    (static_branch_unlikely(&mmio_stale_data_clear) &&
> +	     kvm_vcpu_can_access_host_mmio(&vmx->vcpu)))
> +		flags |= VMX_RUN_CLEAR_CPU_BUFFERS;
>  
>  	return flags;
>  }
> @@ -7296,9 +7297,6 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
>  	 */
>  	if (static_branch_unlikely(&vmx_l1d_should_flush))
>  		vmx_l1d_flush(vcpu);
> -	else if (static_branch_unlikely(&mmio_stale_data_clear) &&
> -		 (flags & VMX_RUN_CLEAR_CPU_BUFFERS_FOR_MMIO))
> -		mds_clear_cpu_buffers();
>  
>  	vmx_disable_fb_clear(vmx);
>  

