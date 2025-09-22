Return-Path: <linux-kernel+bounces-827631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A75BB92421
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E557B19021B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C10A3126B9;
	Mon, 22 Sep 2025 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o3+oNtS1"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208CB3126BF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758559271; cv=none; b=XuWMccIYamx3aHscWWOo58jhObZvD6gMgMBGUzrAPetJk65o/XC43e5D3e5nW7rkyTad+/pv85CAGK3v05A1/aUjLm5Lfbr4h9B86V4bUhXeCAH+ta5KzwZoEMLnCKZbCu4Yr7QrBetjelQcL2gQq2io+pCQhfneJofliK/HHOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758559271; c=relaxed/simple;
	bh=cgRpOeV/h8eXSJgC9yPwO6bTk7jVPQzl+0xil1ELsMo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BgZM975GIxTn5Ybw5N0fjLP5Qzplwh+qbsz53daaploPKe1malQ6LvGh7jYKkYYQTGELU8XW6OZBvpg081MNIAL5bCwpgUZJ7eWVC3g3HedEDDUix6sEWHjA8oj/P0ZLmZxjH0f6UM5JofyGeI3rtvsL9p108goFWAwv+3fV8+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o3+oNtS1; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77ddaa4caabso6272156b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758559269; x=1759164069; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mTfqCdokW+X8HtLwVeSE+IdGBuVQNPlKza47DCX1dCM=;
        b=o3+oNtS1a2m5574eM/5RS1PDtlXpQUW5EnAefoHiRPaE7A7jpE0kZj/jQZEL9+G3aX
         rXY7SIgnoI0kPMy5otzT0gP6cL0UT2Hxn3vUpHWS2rEm5npMgfqS0ZEKpGiz1IkBJfFq
         a6CLnnidM6R8Hy20KJu68Nyr272CG7qFFCQULTPPzEQs9eIJbakjpXIIvqBrum4fCRwM
         h2eLVozsgvdkGgaan5PzBxM6vQo9ho7xgbx6DIzCVfrhwklEk2N4017PeKTGxFhyfJPJ
         mfaouWXZaRk+WdrEaJBpRlLtr9XplihsDNFpzN5UTi7xqmeXTDErCm+j4D36Aogo3mJ7
         EWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758559269; x=1759164069;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mTfqCdokW+X8HtLwVeSE+IdGBuVQNPlKza47DCX1dCM=;
        b=Cf4cNCKFHtsh4s1+0nLArvS5FhslHCwcVtK5pLHTMh3ES7wSG5RkqHdUHPm99CE4X4
         /geZ9wQ7sr8m0b5bulHbbvcvuUBlqp8AbXZv+ZTadC35g7zpJLkyRlCL9EO3ZnlmHKiu
         R+vi5tJVS1x8yMk3PYhuvZK2CtmbrzjYenZafMA0W97luCVWLI+mWZwPkyNKrFGQG0hx
         3K5ofL5BzanLyyaHVhrI3Uz6fftUBaqEL7tb0Mq7WiXE1EFtRs5s9oXgzsrN/Pd1B6eG
         uYV6xxhV8h6NkuGs4vA5neo1mAuvUk446Kq1jOQBD0D6I3SwSm4u3xMLjTAlBwucenJe
         VVNg==
X-Forwarded-Encrypted: i=1; AJvYcCVXLzyC4e4QZOqZTLNEChpbr2fnDbJ/GUdkDIE8H9bnCqR8UHGk4joAc1rLx3lLQezE1F9cV4fTVPEtjM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPmjknMCgasMhHv3/RjJQI3EfKi11+13Ci/OYfvz6J1nh2pA+h
	XPGlky6HSAyr3blSE0HwzdbDiBhDAn7dAHz2kQBUBKsL95OiwlkeV0qKc6ZBHAimhwF2Jp97EQa
	45EuI7g==
X-Google-Smtp-Source: AGHT+IGx+vF97ASb9/nxfiDDS7HQfaF+ctUmw4CeMoTHspSFjuxuZ2UWCEgDSadB8xY7RzjrLjcoo2AEKD0=
X-Received: from pfbfj7.prod.google.com ([2002:a05:6a00:3a07:b0:772:5ec0:9124])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d88:b0:262:e0d4:6a9
 with SMTP id adf61e73a8af0-2927031a2e0mr21298385637.34.1758559269308; Mon, 22
 Sep 2025 09:41:09 -0700 (PDT)
Date: Mon, 22 Sep 2025 09:41:08 -0700
In-Reply-To: <4570dfa1-1e8d-40e9-9341-4836205f5501@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919223258.1604852-1-seanjc@google.com> <20250919223258.1604852-10-seanjc@google.com>
 <4570dfa1-1e8d-40e9-9341-4836205f5501@linux.intel.com>
Message-ID: <aNF8JMN71Bibp24U@google.com>
Subject: Re: [PATCH v16 09/51] KVM: x86: Load guest FPU state when access
 XSAVE-managed MSRs
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>, Xin Li <xin@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 22, 2025, Binbin Wu wrote:
> 
> 
> On 9/20/2025 6:32 AM, Sean Christopherson wrote:
> [...]
> > 
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 3e66d8c5000a..ae402463f991 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -136,6 +136,9 @@ static int __set_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
> >   static void __get_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
> >   static DEFINE_MUTEX(vendor_module_lock);
> > +static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu);
> > +static void kvm_put_guest_fpu(struct kvm_vcpu *vcpu);
> > +
> >   struct kvm_x86_ops kvm_x86_ops __read_mostly;
> >   #define KVM_X86_OP(func)					     \
> > @@ -3801,6 +3804,67 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
> >   	mark_page_dirty_in_slot(vcpu->kvm, ghc->memslot, gpa_to_gfn(ghc->gpa));
> >   }
> > +/*
> > + * Returns true if the MSR in question is managed via XSTATE, i.e. is context
> > + * switched with the rest of guest FPU state.  Note!  S_CET is _not_ context
> > + * switched via XSTATE even though it _is_ saved/restored via XSAVES/XRSTORS.
> > + * Because S_CET is loaded on VM-Enter and VM-Exit via dedicated VMCS fields,
> > + * the value saved/restored via XSTATE is always the host's value.  That detail
> > + * is _extremely_ important, as the guest's S_CET must _never_ be resident in
> > + * hardware while executing in the host.  Loading guest values for U_CET and
> > + * PL[0-3]_SSP while executing in the kernel is safe, as U_CET is specific to
> > + * userspace, and PL[0-3]_SSP are only consumed when transitioning to lower
> > + * privilegel levels, i.e. are effectively only consumed by userspace as well.
> 
> s/privilegel/privilege[...]

Fixed up, thanks!

