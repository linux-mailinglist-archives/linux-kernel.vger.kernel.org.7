Return-Path: <linux-kernel+bounces-796751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0049DB406B4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ABC51A83C5A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7521C30CD95;
	Tue,  2 Sep 2025 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BFS0QYtY"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7605E2F068A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823307; cv=none; b=jvDqZktvTgglgQhUoHUQ5RVrWarLdHSicEsGKzfMpOk42cnbdMJaGKvgmEQYhM56ng6Mwd3IUdAAEYp7Cu1oTjc7vON6UnVsiF1vS4HlB3qrLU92nqDtoQam8IPHBZskDA8+SHp/NB9bP9QiBj/txaT4Sx5T00YfqoLfe0R7DXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823307; c=relaxed/simple;
	bh=KBLdgHhXj8kbcwYt/i79fBzOVsyI+gtXA22gqjWbUaQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZUE2IulA9YOvWznqOcmxtf/x3pemsNbXihgYYTqAKQTfUTt7JIJJk3zWlRgsqpednmbVSMuHDkUeF1HaKwRc5b8FRhTZzvhhNbbtlC9tgWnBhORLKEc64S2BmkzSsGxSRkbCfC4NX2EmQqJ1/ODO60SiLg0mPTdNJwB05kLsNqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BFS0QYtY; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-329ee69e7deso574489a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 07:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756823306; x=1757428106; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OSRCXNbvXWCVXjqxqcKGmi+7XO6ame9D4lh6tc/TGM4=;
        b=BFS0QYtYbcol+O/b8lucJPQVlgO753nascXc0x0AtEbWLtMdRIcJPvwcBz+mxqCpW8
         zpfjeI6DsTWs292zNTTUZoL1//NylDBLAcl0GZbrGzUR4PVD3erJ/XFFG0q37U08C6DG
         KeWtyvqoGxpha03Ezaz1km+l8VYYdhUR9P4lWbz/ynfO0rI+Sa77CPOICdxCU3KCON7A
         zJCKT7Q523jqtRgXq6SngMEw0H1hzAXPQC5tu0QSeypDAYCjwRju//qk7rpLMhw1dHO+
         oXfPtbLWM/3u0l3rJCGe92ABrjwJnuLjgxZswtHFxbKPfUWa30TK1RzlQF83Rs44HNkD
         EEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756823306; x=1757428106;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSRCXNbvXWCVXjqxqcKGmi+7XO6ame9D4lh6tc/TGM4=;
        b=qHgWZY3XCeGcOAMv86rTIwVhA//SYGvDcifgK8SvuiYrduZDZT9mycE/01Gt/Y66SQ
         D+pB6nIz3k4tm7oDKzmQM0m4nxn8LSgej6ndlKZRCwjeN0sBDOqOPYt9aAyVum9VMJnf
         cdZhJcjcuCMwTfg1mO06xDt7FToKWSRKR/zAlC4lnmwvknk+LS02drRppt9pcidutLxL
         xN41AK4VlmI54o+F3RUof79byFE9dCsbR3d6WUW4lnMYZps8NO1QcuEBmHZg0cHaM/LJ
         MC21BS3YuOXQl/+41C58ceRQdyxwKyhLXpzLS9j4+kcWcwFwCG91YUtfKx7MD3cFTyLl
         nkJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRogOPMsMjwVStXeLxylClWtmUSxFQsq4+Bjq2NR+KWXdGNFom1l/Qc6JMalZYVyBTpauUTyszG9xhHpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1I42dKsNL/RidVW+The0+kIpltz4swKOTUoCSsin7MbGpwt4X
	Wy+Q536gJIaqHiwEnxtTxJdZjV6OXh78gPDfarmDINydt5Bg696y5kzu9mCACrNOD4eQSjpAQ7C
	thk3X/w==
X-Google-Smtp-Source: AGHT+IHHRBiyECP4mGAdoaOLkGC0xpbDE94gJyIYaPxf9B8jfvPPal2CO9RkxF3fr0oaOA8+qLaWrxFJDoY=
X-Received: from pjbpl4.prod.google.com ([2002:a17:90b:2684:b0:329:f232:dac7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5587:b0:32b:4c71:f40a
 with SMTP id 98e67ed59e1d1-32b4c71f85amr1107840a91.24.1756823305760; Tue, 02
 Sep 2025 07:28:25 -0700 (PDT)
Date: Tue, 2 Sep 2025 07:28:21 -0700
In-Reply-To: <5a19db9d-3c76-4712-a308-d88c9ac23f71@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812025606.74625-1-chao.gao@intel.com> <20250812025606.74625-2-chao.gao@intel.com>
 <5a19db9d-3c76-4712-a308-d88c9ac23f71@intel.com>
Message-ID: <aLb_BTmViawQyXbG@google.com>
Subject: Re: [PATCH v12 01/24] KVM: x86: Rename kvm_{g,s}et_msr()* to show
 that they emulate guest accesses
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mlevitsk@redhat.com, rick.p.edgecombe@intel.com, weijiang.yang@intel.com, 
	xin@zytor.com, Mathias Krause <minipli@grsecurity.net>, John Allen <john.allen@amd.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 01, 2025, Xiaoyao Li wrote:
> On 8/12/2025 10:55 AM, Chao Gao wrote:
> 
> ...
> 
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > index f19a76d3ca0e..86e4d0b8469b 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -2149,11 +2149,11 @@ void kvm_prepare_event_vectoring_exit(struct kvm_vcpu *vcpu, gpa_t gpa);
> >   void kvm_enable_efer_bits(u64);
> >   bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer);
> > -int kvm_get_msr_with_filter(struct kvm_vcpu *vcpu, u32 index, u64 *data);
> > -int kvm_set_msr_with_filter(struct kvm_vcpu *vcpu, u32 index, u64 data);
> > +int kvm_emulate_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data);
> > +int kvm_emulate_msr_write(struct kvm_vcpu *vcpu, u32 index, u64 data);
> ...
> > -int kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data);
> > -int kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data);
> > +int __kvm_emulate_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data);
> > +int __kvm_emulate_msr_write(struct kvm_vcpu *vcpu, u32 index, u64 data);
> 
> I dislike the rename, it loses the information of filter.
> 
> can we keep the filer information and make them as below?
> 
>   kvm_get_msr_with_filter() -> kvm_emulate_msr_read_with_filter()
>   kvm_get_msr() -> kvm_emulate_msr_read()
>   kvm_set_msr_with_filter() -> kvm_emulate_msr_write_with_filter()
>   kvm_set_msr() -> kvm_emulate_msr_write()

Sorry, no.  I detest the "with_filter".  Requiring developers to add "with_filter"
suggests that emulating an access _with_ the filter is somehow exceptional.  That's
the exact opposite of the truth: emulating MSR accesses _without_ the filter should
only be done in very rare situations, e.g. when loading guest state as part of a
complex transition (RSM, SMI, VM-Enter, VM-Exit).

And if we keep "with_filter", the relationship between kvm_emulate_msr_{read,write}()
and __kvm_emulate_msr_{read,write}() will be non-obvious.

