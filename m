Return-Path: <linux-kernel+bounces-788524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E4BB385C6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644CF3AC06E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6464271468;
	Wed, 27 Aug 2025 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BjkqBsVN"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDB726F2A2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307356; cv=none; b=BuBnZzmBQqa3kcvxkoJvDcfULT+8UCvh0c8bb+VuE/g/+f5N1tUn5HsbDV5tw9JOkODLxNEO5BIgeCuoTHRoCFLfwwQz21X55OJlaxWyfcwFyLtUMEiZf7byPkCW3yUXCFfROOikiFNANJozVcrQWCBlKuFKzjA8QW3VbGpyUWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307356; c=relaxed/simple;
	bh=DpCJEIfwQQGl2PQO5j/mO2MScWyLFDJU13NPV8HrF00=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TSci91UOsIo4T9x7auXEweWWIzwWF7YDcTcqCsOg+40Rmbge82vAMZXX44ryuBMGPOzeJDq8TfymEwfBJ92Kvfyoj37taZCiKvsBL0noIXHsxZSLlXEOp1ez88jKOoR/F/Bi0Qxfc9o+D2ohQxWa40S4Skpj7FsCF5HtaY4DrKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BjkqBsVN; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-246f49067bdso34080425ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756307354; x=1756912154; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cGukJNryZsxnvP4t0ed2eFtZxN1ggIA3k+je7ANvR9U=;
        b=BjkqBsVN70DlSzInhmoYOBVf/N6nxteSjO+iNnu5cHi7bwta4wXuUMICxIJy5nLbVi
         W0+N9gVgb2aMjgL/FYyK8zcPyd++cJYmGDkN316LPfkz20BA6eoKvFQaPJXQWlJqICRQ
         zPqWtOqO218cQGNDtdDz1i0M9n+9E5zBe6fOc/qdnTIMcfFKXITCOxz8R+tSAjz5LOWd
         4nZuvvZin3NRPb2GyxEb3KrhLxfhgYz+BfJJif2jW806Q8VEUX/4pcwSTXiUN9pmsloP
         /2yhwt0AojT0ZZYh6m6G/3dhCLpnf13bnjoFV4baKNtw3L1ygtahkB81u2qZFKGRKN1J
         P0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756307354; x=1756912154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cGukJNryZsxnvP4t0ed2eFtZxN1ggIA3k+je7ANvR9U=;
        b=wF5Ao8yola2zAEfh+1JL/b/I8fKGWErYOdt+a2P9g6U1/omfQtuDrnE054pA25NvEx
         YkGg3rLvRHNYCl4NFdWskT5LAirfwwNtNBLmMjrIgb1LiqjFt/9xSycoF0rbN9jOrwSk
         t6h9CubEywsIlzS9NADD31pWKYlIZ1A1eRzjVME8FmOAbmEaOm8DMC4uaZ7EFvuzHe1x
         Jfw18n+09iK5v3ZQT+Czs9vtmTmTfO970nCieVtpsU6anior47KntWNjYgHRLFY7mVAm
         ao+/XVLmmhuFLU9FXw6xjIskIqCdemQTUHf2o3xibyJ/1gl17q8jdkUMrI227s8x80mX
         +IhA==
X-Forwarded-Encrypted: i=1; AJvYcCWVRyLFmr31AcIpDnLEdeG84XV7MQgSU2zI2uh/u+FjtVHnhBeqKvPpDsUmzykQQ68kb1sBwFZpU02PxSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL+PW1JpQiq74T0rjL0bDKWg3CECZjEuEgnNHCUSTslsr95Exi
	zGqJsCkBCmD4emGIKRcfAwBONosgHmhsZdCUxL2Lb7WT/z/rQPqyf7nK5ShT3jCNnBIroM697Tv
	dbLFsQg==
X-Google-Smtp-Source: AGHT+IF5KFARexvwm/25NO3qrVpMzrxQ7U+d6fK+0Kta/gTZ9/eFHTNO/iB4Ran3E9PIhtNjR3PKhzpId3I=
X-Received: from pjur11.prod.google.com ([2002:a17:90a:d40b:b0:325:9404:7ff3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5c7:b0:240:640a:c576
 with SMTP id d9443c01a7336-2462ee02b9bmr261770115ad.15.1756307353868; Wed, 27
 Aug 2025 08:09:13 -0700 (PDT)
Date: Wed, 27 Aug 2025 08:09:12 -0700
In-Reply-To: <ae363ab5-8985-4c4e-910e-969d442cd7ed@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821133132.72322-1-chao.gao@intel.com> <20250821133132.72322-6-chao.gao@intel.com>
 <ae363ab5-8985-4c4e-910e-969d442cd7ed@zytor.com>
Message-ID: <aK8fmMGH0rB2LuA9@google.com>
Subject: Re: [PATCH v13 05/21] KVM: x86: Load guest FPU state when access
 XSAVE-managed MSRs
From: Sean Christopherson <seanjc@google.com>
To: Xin Li <xin@zytor.com>
Cc: Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, john.allen@amd.com, 
	mingo@redhat.com, minipli@grsecurity.net, mlevitsk@redhat.com, 
	pbonzini@redhat.com, rick.p.edgecombe@intel.com, tglx@linutronix.de, 
	weijiang.yang@intel.com, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 26, 2025, Xin Li wrote:
> On 8/21/2025 6:30 AM, Chao Gao wrote:
> > diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> > index eb3088684e8a..d90f1009ac10 100644
> > --- a/arch/x86/kvm/x86.h
> > +++ b/arch/x86/kvm/x86.h
> > @@ -701,4 +701,28 @@ int ____kvm_emulate_hypercall(struct kvm_vcpu *vcpu, int cpl,
> >   int kvm_emulate_hypercall(struct kvm_vcpu *vcpu);
> > +/*
> > + * Lock and/or reload guest FPU and access xstate MSRs. For accesses initiated
> > + * by host, guest FPU is loaded in __msr_io(). For accesses initiated by guest,
> > + * guest FPU should have been loaded already.
> > + */
> > +
> > +static inline void kvm_get_xstate_msr(struct kvm_vcpu *vcpu,
> > +				      struct msr_data *msr_info)
> > +{
> > +	KVM_BUG_ON(!vcpu->arch.guest_fpu.fpstate->in_use, vcpu->kvm);
> > +	kvm_fpu_get();
> > +	rdmsrl(msr_info->index, msr_info->data);
> 
> s/rdmsrl/rdmsrq/
> 
> > +	kvm_fpu_put();
> > +}
> > +
> > +static inline void kvm_set_xstate_msr(struct kvm_vcpu *vcpu,
> > +				      struct msr_data *msr_info)
> > +{
> > +	KVM_BUG_ON(!vcpu->arch.guest_fpu.fpstate->in_use, vcpu->kvm);
> > +	kvm_fpu_get();
> > +	wrmsrl(msr_info->index, msr_info->data);
> 
> s/wrmsrl/wrmsrq/
> 
> 
> Perhaps it's time to remove rdmsrl() and wrmsrl(), as keeping them around
> won't trigger any errors when the old APIs are still being used.

Yeah, we should bite the bullet and force in-flight code to adapt.  I was _this_
close to making the same goof in the mediated PMU series, and IIRC it was only
some random conflict that alerted me to using the old/wrong APIs.

