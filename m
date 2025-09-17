Return-Path: <linux-kernel+bounces-821690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AD7B81F73
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3CF24A806B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7787330BF71;
	Wed, 17 Sep 2025 21:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="INGlmMM/"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63555302159
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 21:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758144329; cv=none; b=ee6QLFXxC2TdljyVrMPkDGeBfUPoApgoYREJkWs/9V8qAAQlPo83+qg0VD5L0O2PrYd4Z1HomqLkdxTFg9k2oonseSbBFwXiw+oJr184uMbBpQxHCNgNTeNYSdObh+vC9zmqCeDI4918QJ1CxhsRZ825o1f+g2G+CG1Ars7luZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758144329; c=relaxed/simple;
	bh=JP39cW2hbi9m89rYjm6fMmNO44J29P7MpA5dKQARQX4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RXgmipe2nW54+Efa1n1Jo1sp5amlhUgm/mkxnzKlgLL5D2gCWA4DCbIHc3JIYXbfgUjxzoxz0yFcqTiYNQgq091OUfk9j/U0GGTy6q3OfsU8Itj/b/Cfsxg/9dJX1yKJh84O341AaAxXymayDJd2IAZSN9RoVhKfXr75qUDyZ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=INGlmMM/; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7760b6b7235so217882b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758144327; x=1758749127; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VzmS6vlS4aGQUGCsqqVnjAUV5zRiihlDMEI25Ee0wp4=;
        b=INGlmMM/fqruNYqloxjtoLDdXmsbN7nWADs1/4SeUNXJRvVHjC8lsbfRkTWAgw7HT7
         xDowFf32dY96D0DdPNfjyPfbkzwr58k/fzR+MeX9uMgzUahnP5Z4k17cSvbpPYZmN576
         uy64LcKcWKGty50+qmaDXCulk3Ul033fm/fHDAhzGrp97mHiLURjOhZTgXiF7vzRe5N8
         BDYXjRdaYCKBi8UMGWnp802D3zHk23GY4efh1JqejAapaxLS9OUcj8Mb+ZI96XvJXk4+
         yTErfPpe08i5OF3iipcNLq70jQBFfvDQ+cOgYPHkmuiPcJ7FtNp3XBmYqHSnH6yiFlRy
         ZXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758144327; x=1758749127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VzmS6vlS4aGQUGCsqqVnjAUV5zRiihlDMEI25Ee0wp4=;
        b=TYo8BaalKixMxBwG6ebIJCYcwXkrDyi3L4KSig0dU/N2GyoeBXiOIkx2WOQVwCpZ+D
         Z8bvuGArf8VlnNNqVGvt6Yim/IDhCh/P9lMVb+cNlFgdgED78rJQismsQ/xql4hooprU
         +sVf5f4P8+tS3dHQcfVluF1xBTsXXJ5wUYrIoXjsKBuFs2dR78E5bLrO5wfhQac2+gYu
         LUtyrKaOXvF5wi4m/VWba7NupdFrd4gnM00r9ao4g6dcE5y6oR/xxvRPepGUU4DkcpDp
         WCJwh1GGW+uZUPQ+3IfieLJUNi2x+Qzfd9MLEJOQ3QcAOeHgUzqn+7KOSOrl6jJXgULp
         eDcw==
X-Forwarded-Encrypted: i=1; AJvYcCUXDEVaipUH80oPvZnCC1gI/PYvRt9EAbtWvrCUysvPapAe9xC8iMG2saDvXbt/C195csZi6OJVSUtk0ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbgCcwzhUpwK0Gs2zA1/iaRGD+FeJU9HebyjDHFxUl8NVN3zDs
	+66uR1TWgR/hbfn47G0Cr7SiOSlT3cR6icH0JetebDGYgcmy5yBI2h2g9ylYMGW3UB25h7IPFKp
	tT7VYeQ==
X-Google-Smtp-Source: AGHT+IEt9OdbWxtc6AYige90fBSwtnNPY6nA9lHy3V8mdb8lVXQEswni2xr/2m7RjmFhT4E+7RMjQTSbWpw=
X-Received: from pjbhl16.prod.google.com ([2002:a17:90b:1350:b0:32d:a0b1:2b03])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3947:b0:243:c274:1a7f
 with SMTP id adf61e73a8af0-27aac993578mr5089210637.46.1758144326668; Wed, 17
 Sep 2025 14:25:26 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:25:25 -0700
In-Reply-To: <65465d1e-a7bd-4eac-a0ba-8c6cce85e3ed@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com> <20250912232319.429659-18-seanjc@google.com>
 <65465d1e-a7bd-4eac-a0ba-8c6cce85e3ed@intel.com>
Message-ID: <aMsnRY9PG6UeTzGY@google.com>
Subject: Re: [PATCH v15 17/41] KVM: VMX: Set host constant supervisor states
 to VMCS fields
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 17, 2025, Xiaoyao Li wrote:
> On 9/13/2025 7:22 AM, Sean Christopherson wrote:
> ...
> > +static inline bool cpu_has_load_cet_ctrl(void)
> > +{
> > +	return (vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_CET_STATE);
> > +}
> 
> When looking at the patch 19, I realize that
> 
>   { VM_ENTRY_LOAD_CET_STATE,		VM_EXIT_LOAD_CET_STATE }
> 
> is added into vmcs_entry_exit_pairs[] there.
> 
> So ...
> 
> >   static inline bool cpu_has_vmx_mpx(void)
> >   {
> >   	return vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_BNDCFGS;
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index adf5af30e537..e8155635cb42 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -4320,6 +4320,21 @@ void vmx_set_constant_host_state(struct vcpu_vmx *vmx)
> >   	if (cpu_has_load_ia32_efer())
> >   		vmcs_write64(HOST_IA32_EFER, kvm_host.efer);
> > +
> > +	/*
> > +	 * Supervisor shadow stack is not enabled on host side, i.e.,
> > +	 * host IA32_S_CET.SHSTK_EN bit is guaranteed to 0 now, per SDM
> > +	 * description(RDSSP instruction), SSP is not readable in CPL0,
> > +	 * so resetting the two registers to 0s at VM-Exit does no harm
> > +	 * to kernel execution. When execution flow exits to userspace,
> > +	 * SSP is reloaded from IA32_PL3_SSP. Check SDM Vol.2A/B Chapter
> > +	 * 3 and 4 for details.
> > +	 */
> > +	if (cpu_has_load_cet_ctrl()) {
> 
> ... cpu_has_load_cet_ctrl() cannot ensure the existence of host CET fields,
> unless we change it to check vmcs_config.vmexit_ctrl or add CET entry_exit
> pair into the vmcs_entry_exit_pairs[] in this patch.

I *love* the attention to detail, but I think we're actually good, technically.

cpu_has_load_cet_ctrl() will always return %false until patch 19, because
VM_ENTRY_LOAD_CET_STATE isn't added to the set of OPTIONAL controls until then,
i.e. VM_ENTRY_LOAD_CET_STATE won't be set in vmcs_config.vmentry_ctrl until
the exit control is as well (and the sanity check is in place).

> > +		vmcs_writel(HOST_S_CET, kvm_host.s_cet);
> > +		vmcs_writel(HOST_SSP, 0);
> > +		vmcs_writel(HOST_INTR_SSP_TABLE, 0);
> > +	}
> >   }

