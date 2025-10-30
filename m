Return-Path: <linux-kernel+bounces-877332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A93C1DE20
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 393723ADDA6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 00:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59861C84DF;
	Thu, 30 Oct 2025 00:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U1tQa/lU"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5852BAF7
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783503; cv=none; b=SrmkszD29Uph96MLZbyGC+L+sazf5fy9KngTAkp1TVxDzWJlaXoKTKKF2D+adpmAF6N1pPqr3GIC7xTduPnZYQlXCLcF4AuX8jND8MvGRBHhv7wzTVV7sMOrc2oM4g8TbL8K8AWSpWUH8pyw4pPyAYxXD1cVP4s23gmn+YbtfWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783503; c=relaxed/simple;
	bh=JB2LEI4A5f74efQFX9e5urcPJQDPxTpuN3kVdrHIaT0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G53nObXuyCOnl7UTMo1WV5kcRGgnIw3gNeXadwRlOGoOSNOyVvTTeCdSoISAwDop2vqqdL94Sl4TKiSA5jyffIeVqPPr9ZLGGnbChuo8hieskGwgh9d662HnfaiuKnVCDz7mvn/SlQ1Dtk9ZcOh+6EO6+8Ih1xlkvsYsTzStS0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U1tQa/lU; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33da21394adso453003a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761783501; x=1762388301; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/APfDoAjvMMG72cPIAEX8+eFsFzG2tjZbjY4ARPdXLk=;
        b=U1tQa/lUxRET/55TrDwLmrrNvr9F3S3XMubLthBkpb2ZVAYLBQOCwH42i+swheWPsn
         K+9IM79yaiW1SshvqUOj3Gv7CSszZphZ5rtr3urSrTUZrDuMjhKTrZkIN/KrWKzVXVm2
         BdvJK8q/D0unbnJQu82djqqZmMr8JzIbctJogNwm6Rj8xWfOk/Sfe04XA7/4CLxVcqce
         N3r+DBdQaX4YI/vdjzMwl2q5uSi9ef+SpQAfV6PSga6RXpYutCR32U3g7V5TNzMF0zgY
         i5+FZxJNd0VCzXjMrhwFtwz/9R1QYWeDlqbbb6ZNOGpwOa6wZzVt59lNdqSk074d7FCi
         rRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761783501; x=1762388301;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/APfDoAjvMMG72cPIAEX8+eFsFzG2tjZbjY4ARPdXLk=;
        b=o/ql7XNZ686uM+Z5HkPc5koJHOTQTmh3U8gK72mV3JZNirujOZtkCG5JhOkz23zKv5
         x20Kt/Ke7W//Zeb+rL1PMDLijaa/ncP2ZOlb4O06mo9NYk+yuF0PKmEXIezL449Avc0+
         Uy8sSQY3KFn9nBi98GPfsGC+C6Z9VM8kA/l0UjB9/NFZji2+hQBJ3NevvJMFCzw9vb+h
         qCpxV+vIePTevyx18p0XKGUqk2kh/8cInDwy8RS5CeFH401k1wJnW4KiRyMc/2m9/B0k
         omgbPpiWj/PbFExmKFJtWPiDI1Nnt+yry17NLvwhbq/LRSRVosz+G7T8QYvuj/kGENkV
         2dWw==
X-Forwarded-Encrypted: i=1; AJvYcCU1porbUKOZwxLLWNkbNMaktigdioKs1Bktm9380b7lxzfIDBsr+yaO5lkfh61il+XKkP24xW923K/vLSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWEm9FrVlc7KMGCPhtzT2+kKYm3BDzTV3v60xi3hoaes1YcJPh
	Dfl3JVvWPANtMMdwRA6+3F1/WQGkWc9+bmPJw42e/NcG3eYyN2Ll4uZPsW5kqihhj1k6/OcH1RG
	Kj80+6g==
X-Google-Smtp-Source: AGHT+IGgocyQQIi5AG23kjZirIFz98FRrrSK1VO35VHRCnkojOzL21/TedfvF0EX8P2/KGVYsS95rTUFxFY=
X-Received: from pjsj7.prod.google.com ([2002:a17:90a:7347:b0:33d:61e3:893])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3912:b0:340:299f:e244
 with SMTP id 98e67ed59e1d1-3404c41b811mr1502709a91.12.1761783500906; Wed, 29
 Oct 2025 17:18:20 -0700 (PDT)
Date: Wed, 29 Oct 2025 17:18:19 -0700
In-Reply-To: <20251029-verw-vm-v1-2-babf9b961519@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029-verw-vm-v1-0-babf9b961519@linux.intel.com> <20251029-verw-vm-v1-2-babf9b961519@linux.intel.com>
Message-ID: <aQKuy34wmCWvXcMS@google.com>
Subject: Re: [PATCH 2/3] x86/mmio: Rename cpu_buf_vm_clear to cpu_buf_vm_clear_mmio_only
From: Sean Christopherson <seanjc@google.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Tao Zhang <tao1.zhang@intel.com>, 
	Jim Mattson <jmattson@google.com>, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Oct 29, 2025, Pawan Gupta wrote:
> cpu_buf_vm_clear static key is only used by the MMIO Stale Data mitigation.
> Rename it to avoid mixing it up with X86_FEATURE_CLEAR_CPU_BUF_VM.
> 
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---

...

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index f87c216d976d7d344c924aa4cc18fe1bf8f9b731..451be757b3d1b2fec6b2b79157f26dd43bc368b8 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -903,7 +903,7 @@ unsigned int __vmx_vcpu_run_flags(struct vcpu_vmx *vmx)
>  	if (!msr_write_intercepted(vmx, MSR_IA32_SPEC_CTRL))
>  		flags |= VMX_RUN_SAVE_SPEC_CTRL;
>  
> -	if (static_branch_unlikely(&cpu_buf_vm_clear) &&
> +	if (static_branch_unlikely(&cpu_buf_vm_clear_mmio_only) &&
>  	    kvm_vcpu_can_access_host_mmio(&vmx->vcpu))
>  		flags |= VMX_RUN_CLEAR_CPU_BUFFERS_FOR_MMIO;

The use in vmx_vcpu_enter_exit() needs to be renamed as well.  The code gets
dropped in patch 3, but intermediate builds will fail.

