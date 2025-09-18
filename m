Return-Path: <linux-kernel+bounces-814281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33568B551D4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49643BCB25
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D361830103C;
	Fri, 12 Sep 2025 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LSl5xnXP"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DDB17A2FC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687843; cv=none; b=KzDeU7USgI3WLbcB4BYU0fUGIzKjyiiH0gcYp52Ct3sYw6f10BN+JYFq9e00ROHNKb0neK9YwNKavS1LTBur53VVtmNdw/nTF8hkp6EFpaMy1lAVIH98C5hyryqhIeMg7aY0q36TUeFLps6bhhKMQqoOP9isU9AbJKLMBuK+rj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687843; c=relaxed/simple;
	bh=YpwgMyR671W9zCbxFcbCh8JUcv1uLLeYZ10agHNOyOM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bWmcxajSchb9A+JkjubqK+lBWEDk81zlFU9BywIdVJJ6YRQJEHcbC1Wkc8xqMiSWOkrB/dn6oXnAsWJwZGCQhhzRZAmdcwsmtA4KAM4cMkL8QfGXnPhUEkqaTJO1Z8rNEUjEQDhZnxs9Ed/658+QmqeFUlPFD053wppyvTjy9jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LSl5xnXP; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77264a9408cso3952950b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757687841; x=1758292641; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2P+x88UUE2GDQfwUUdAyI+XxcaLbXssYKBKZgNEjDhg=;
        b=LSl5xnXPdRRRTvR6liviTjzTRISzzyYOFRnotRqUjlP7f9HGHbiqwaXQb8LmBV4RLM
         +Mrb8Y4afn+YM13mHgpoHI0E8JMaa4TUe2qL0Um0CAUYxInm8HuIJ7+aM6JaoaXEQ4Sa
         9AsunfyIqnQIdhde2uz8ITxS7LdNOUwQ6Cclq7PFko6lWHIN/O28NDmehO3fvIBU0NCt
         mBNsTSqyZLmUCs7FmiuHVpB48F9At0Lg94roxTT7NKEDCfb2otZZeGLMPsTmE6zSlTOO
         rkZyrQKrDIQvKxEgohMceHb7gNb39P/64BH6KQv6hToXIi9U5xmRusRgjW+xw0g86fFD
         cejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757687841; x=1758292641;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2P+x88UUE2GDQfwUUdAyI+XxcaLbXssYKBKZgNEjDhg=;
        b=FeT9y51wU6jPqF3RtT9GmopBFGjG6gq3I2Z5cPeu/zrK5Lw2u4CHTWPo1KPwBq5MA7
         SsZE+S3mh/JmavzoiAUeDm+KBGf6eyfPwhL86qOerLFrrj2Ml0b9WhkUXBM4PXr5wkS9
         o6yCXIdg4eh0vUWTqFcv045kunmXc5Z3JyXioWr7GwYElpGtPH6zJjYjFfYJ7UZRo0f2
         TaCi4Z1jnq42eIClegIEAlxYmZfOZQYdQ4uo66blj7Y24AcAMfsfm7arMZIEvxbB3ljP
         1HHZLG182iVF02RmgM0m9CnhBMYcaHhpZvxLkBERyy0D2AHyO9IcTECuZJzOT1Q7WKSZ
         wsGw==
X-Forwarded-Encrypted: i=1; AJvYcCU5iOYphXM0a9Fjhguz1BMVKLVwk1wTJmocxD4PyKQiFIg0mn+VTUdux6iySKAHhCDohO9/jNYoWEA12/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YycoR/GAhjghP33vCh7t/eDbeuwC0RbkNRJsyZ2M4Hu8f+59ygZ
	NEDS7CmjTC3QjWg5uM8lXPFv7htajrVxprCsRkcaoBhP27bQOcbw70UKYTV5q50WznTdfkUmHSR
	z5xm2uw==
X-Google-Smtp-Source: AGHT+IE1gQ7ivjZR8g0gLqSSuhwVcNqxUEvHF3Z4Hr5v0ExRBR0jo9zcuJja0j6DJ3NuA4KDhWRWN7Wyrms=
X-Received: from pgno17.prod.google.com ([2002:a63:7e51:0:b0:b47:18b4:f5cb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7d86:b0:248:e0f7:1326
 with SMTP id adf61e73a8af0-26029eaa47dmr4203315637.2.1757687840892; Fri, 12
 Sep 2025 07:37:20 -0700 (PDT)
Date: Fri, 12 Sep 2025 07:37:19 -0700
In-Reply-To: <ac7eb055-a3a2-479c-8d21-4ebc262be93b@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909093953.202028-1-chao.gao@intel.com> <20250909093953.202028-16-chao.gao@intel.com>
 <8121026d-aede-4f78-a081-b81186b96e9b@intel.com> <aMKniY+GguBPe8tK@intel.com> <ac7eb055-a3a2-479c-8d21-4ebc262be93b@intel.com>
Message-ID: <aMQwH8UZQoU90LBr@google.com>
Subject: Re: [PATCH v14 15/22] KVM: x86: Don't emulate instructions guarded by CET
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acme@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	john.allen@amd.com, mingo@kernel.org, mingo@redhat.com, 
	minipli@grsecurity.net, mlevitsk@redhat.com, namhyung@kernel.org, 
	pbonzini@redhat.com, prsampat@amd.com, rick.p.edgecombe@intel.com, 
	shuah@kernel.org, tglx@linutronix.de, weijiang.yang@intel.com, x86@kernel.org, 
	xin@zytor.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 12, 2025, Xiaoyao Li wrote:
> On 9/11/2025 6:42 PM, Chao Gao wrote:
> > > > @@ -4941,6 +4947,24 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int
> > > >    	if (ctxt->d == 0)
> > > >    		return EMULATION_FAILED;
> > > > +	if (ctxt->ops->get_cr(ctxt, 4) & X86_CR4_CET) {
> > > > +		u64 u_cet, s_cet;
> > > > +		bool stop_em;
> > > > +
> > > > +		if (ctxt->ops->get_msr(ctxt, MSR_IA32_U_CET, &u_cet) ||
> > > > +		    ctxt->ops->get_msr(ctxt, MSR_IA32_S_CET, &s_cet))
> > > > +			return EMULATION_FAILED;
> > > > +
> > > > +		stop_em = ((u_cet & CET_SHSTK_EN) || (s_cet & CET_SHSTK_EN)) &&
> > > > +			  (opcode.flags & ShadowStack);
> > > > +
> > > > +		stop_em |= ((u_cet & CET_ENDBR_EN) || (s_cet & CET_ENDBR_EN)) &&
> > > > +			   (opcode.flags & IndirBrnTrk);
> > > 
> > > Why don't check CPL here? Just for simplicity?
> > 
> > I think so. This is a corner case and we don't want to make it very precise

Checking CPL here would not make the code more complex, e.g. naively it could be
something like:

		u64 cet;
		int r;

		if (ctxt->ops->cpl(ctxt) == 3)
			r = ctxt->ops->get_msr(ctxt, MSR_IA32_U_CET, &cet);
		else
			r = ctxt->ops->get_msr(ctxt, MSR_IA32_S_CET, &cet);
		if (r)
			return EMULATION_FAILED;

		if (cet & CET_SHSTK_EN && opcode.flags & ShadowStack)
			  return EMULATION_FAILED;

		if (cet & CET_ENDBR_EN && opcode.flags & IndirBrnTrk)
			  return EMULATION_FAILED;

> > (and thus complex). The reason is that no one had a strong opinion on whether
> > to do the CPL check or not. I asked the same question before [*], but I don't
> > have a strong opinion on this either.
> 
> I'm OK with it.

I have a strong opinion.  :-)

KVM must NOT check CPL, because inter-privilege level transfers could trigger
CET emulation and both levels.  E.g. a FAR CALL will be affected by both shadow
stacks and IBT at the target privilege level.

So this need more than just a changelog blurb, it needs a comment.  The code
can also be cleaned up and optimized.  Reading CR4 and two MSRs (via indirect
calls, i.e. potential retpolines) is wasteful for the vast majority of instructions,
and gathering "stop emulation" into a local variable when a positive test is fatal
is pointless.

	/*
	 * Reject emulation if KVM might need to emulate shadow stack updates
	 * and/or indirect branch tracking enforcement, which the emulator
	 * doesn't support.  Deliberately don't check CPL as inter-privilege
	 * level transfers can trigger emulation at both privilege levels, and
	 * the expectation is that the guest will not require emulation of any
	 * CET-affected instructions at any privilege level.
	 */
	if (opcode.flags & (ShadowStack | IndirBrnTrk) &&
	    ctxt->ops->get_cr(ctxt, 4) & X86_CR4_CET) {
		u64 u_cet, s_cet;

		if (ctxt->ops->get_msr(ctxt, MSR_IA32_U_CET, &u_cet) ||
		    ctxt->ops->get_msr(ctxt, MSR_IA32_S_CET, &s_cet))
			return EMULATION_FAILED;

		if ((u_cet | s_cet) & CET_SHSTK_EN && opcode.flags & ShadowStack)
			  return EMULATION_FAILED;

		if ((u_cet | s_cet) & CET_ENDBR_EN && opcode.flags & IndirBrnTrk)
			  return EMULATION_FAILED;
	}

