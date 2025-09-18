Return-Path: <linux-kernel+bounces-803687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1618BB463B9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB40D3A8367
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26C1278157;
	Fri,  5 Sep 2025 19:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="HTYXz0D5"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC8D272E51
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100903; cv=none; b=PEovmA4jST6sV73+Ci9Tx1VtJ+DjVC0uoTWXb6Hmpot56lzwvaz8QrqczFYeDCKPzJvz1ojvfjU4MX/6SAK2zHYbrIdjATJWHKyQWGw3EGbd1lHw+a8hGn/fOdDa1hIQarSWRHfieATw3F8bPbEu0nko9l5jPFzY7SQGrD3wbVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100903; c=relaxed/simple;
	bh=Rvh7ciEHXfbDCfD3pPj8ITD6aqCcBeE2e4ML36hIwPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7PLIsa9vYYkwHTkWgvhP769AU9BAPGhhCcVhTB4Sg9lW06hXvAL2TYZ2lnRB0n0SBbL0+f3CtzjvKRXLpdCGf2wuY80kM5OSWwyTzhqfh91v03MsN/MANkAn0Ew8C49c9jAHkD3j4aponxWL5dNYZgqFnFKOEdFO6yWBxcyibo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=HTYXz0D5; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b47052620a6so2573251a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1757100901; x=1757705701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9FAMAwKb9GlFbqFePz07zPDAIQCDZGG7K5Xfr8FjoY=;
        b=HTYXz0D5n3RJV9jFHxbbMOvZiXrwbZs7v24wt02xOQn+hyFZd1zYqFJ8g7O7J6ujBY
         5SXH2UR/p78yQEjh8+G2EI5eF18jPn+OTZGhT8iFtD+VygbwWsgtdjIj70e7rRhg+QGB
         Jf19VloVJPcf0NQKztSH46h+52AXJTkCrMKjcGL3iJkoMnukxlJ26jwLWjyNW0JUdkr4
         EJrKZNP1Mwpf10qkCu2fzBV3KubJmzJk2ewum1ws/W6OXWBTh82wL78ulQC/tJHfQOnV
         Pgo1CissXP64EC6/4YROCZtUWxKO+kK+NrgDf7Mm/XaeO+EL5OUMydl2FayamaeasTwZ
         UYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757100901; x=1757705701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9FAMAwKb9GlFbqFePz07zPDAIQCDZGG7K5Xfr8FjoY=;
        b=YLaurwXBADy5Nues63p+XAgJdbzqv0kwAFG3QeSRsaP9t9iVyuYLBVns4W257HfPux
         pm9/C2bmAa4zVH+Z2JWcJ8P1zX25pzWRrqtTBBXDJ0E7b+TdFs+xTvu/ZZKIJzzuSwe+
         mDjNL8lhTpgt+cHpqe+Tmlioet3Zyfvt7IAezSzovxlskdTEtnHtrGrz8J8v2RBDcPC5
         RMUn0xlYztsw8SW3/U++7K+KhIXm1RnCdsZhftVmAFuomlhmv6TFGBqBJ2UWxuNH+whB
         fly2wY51Y9Xinilyf7stx7YaiIqFkNGO8n54dKcGOeuqEQYsp0yM6B2NDbSy/MlSbXm8
         eaGw==
X-Forwarded-Encrypted: i=1; AJvYcCXmQoTHfY9ezZrMIWbIR2owAVVWygX4QpHrsP4cZV9Jvje25gvfJNXSRMjVlpERwmbzKp9tQd5kI7c+TNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwNjzsQHwZ+/oDockoq/jkoBP4LrRS8RCVxhKBXxc0Q3wOF2wN
	3P1s+qIXsJn2v7kuctVduvRbK0RsR4DCCJD10gGyNs1uJnMSyOb+Xw8adTlSBjTeNKFqe5Y2OkY
	y0MhoZ5I0gK3sNi5hSgrUrXQyy35Vij+SrBhrWg4iAQ==
X-Gm-Gg: ASbGncv5N7ryii5Z2Kpq2Q0jW85Wu42DNVY8pu9FWkc3dKV5k82S276HkBu4nSvcF6e
	LVMilEfswk5CUUzJl7a5M+RE9p/MWyJNsunuSRFN514870OF7jKdubsDJl5+Spq7ZVJfHZNFL+v
	hS5ESqiEAA0gEIUhYWmBDtW7pEBbYHbAPRbFMArjZv86i6Xo49AmheI3jj6pEa2TzFDouEcSRwu
	nkNF9mBCNOAu4H4EeJ18804u9Du2Q==
X-Google-Smtp-Source: AGHT+IHqWqyZqFIuzyIZvE/SUKQfYYN6g516wmc4GuFbgQsfUPht0NsXKsfItF2EyucT/HQ/Jt/iNNsDf0c9xrLH2sg=
X-Received: by 2002:a17:90b:3c44:b0:32b:6223:262 with SMTP id
 98e67ed59e1d1-32bbcb945aemr5935479a91.3.1757100901459; Fri, 05 Sep 2025
 12:35:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829-pmu_event_info-v5-0-9dca26139a33@rivosinc.com>
 <20250829-pmu_event_info-v5-6-9dca26139a33@rivosinc.com> <aLIR3deQPxVI2VrE@google.com>
 <CAHBxVyHFkNtFdX-vciPvYnTOH=GXvHVW7hjFrLA4MFr9wqWVvQ@mail.gmail.com> <aLqd9bKB6ucarR3e@google.com>
In-Reply-To: <aLqd9bKB6ucarR3e@google.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Fri, 5 Sep 2025 12:34:48 -0700
X-Gm-Features: Ac12FXzDuYbaevvtu1cjWIBdIgE-JZvhAwCG0_v0qb1Ic8gyKF3DjAY5IEIX5wM
Message-ID: <CAHBxVyE7Tp97GfbH=deaA7gqWQXByno3O3OHbHDJCJ=J7FUQvw@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] KVM: Add a helper function to check if a gpa is in
 writable memselot
To: Sean Christopherson <seanjc@google.com>
Cc: Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Mayuresh Chitale <mchitale@ventanamicro.com>, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 1:23=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Wed, Sep 03, 2025, Atish Kumar Patra wrote:
> > On Fri, Aug 29, 2025 at 1:47=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Fri, Aug 29, 2025, Atish Patra wrote:
> > > > +static inline bool kvm_is_gpa_in_writable_memslot(struct kvm *kvm,=
 gpa_t gpa)
> > > > +{
> > > > +     bool writable;
> > > > +     unsigned long hva =3D gfn_to_hva_prot(kvm, gpa_to_gfn(gpa), &=
writable);
> > > > +
> > > > +     return !kvm_is_error_hva(hva) && writable;
> > >
> > > I don't hate this API, but I don't love it either.  Because knowing t=
hat the
> > > _memslot_ is writable doesn't mean all that much.  E.g. in this usage=
:
> > >
> > >         hva =3D kvm_vcpu_gfn_to_hva_prot(vcpu, shmem >> PAGE_SHIFT, &=
writable);
> > >         if (kvm_is_error_hva(hva) || !writable)
> > >                 return SBI_ERR_INVALID_ADDRESS;
> > >
> > >         ret =3D kvm_vcpu_write_guest(vcpu, shmem, &zero_sta, sizeof(z=
ero_sta));
> > >         if (ret)
> > >                 return SBI_ERR_FAILURE;
> > >
> > > the error code returned to the guest will be different if the memslot=
 is read-only
> > > versus if the VMA is read-only (or not even mapped!).  Unless every r=
ead-only
> > > memslot is explicitly communicated as such to the guest, I don't see =
how the guest
> > > can *know* that a memslot is read-only, so returning INVALID_ADDRESS =
in that case
> > > but not when the underlying VMA isn't writable seems odd.
> > >
> > > It's also entirely possible the memslot could be replaced with a read=
-only memslot
> > > after the check, or vice versa, i.e. become writable after being reje=
cted.  Is it
> > > *really* a problem to return FAILURE if the guest attempts to setup s=
teal-time in
> > > a read-only memslot?  I.e. why not do this and call it good?
> > >
> >
> > Reposting the response as gmail converted my previous response as
> > html. Sorry for the spam.
> >
> > From a functionality pov, that should be fine. However, we have
> > explicit error conditions for read only memory defined in the SBI STA
> > specification[1].
> > Technically, we will violate the spec if we return FAILURE instead of
> > INVALID_ADDRESS for read only memslot.
>
> But KVM is already violating the spec, as kvm_vcpu_write_guest() redoes t=
he
> memslot lookup and so could encounter a read-only memslot (if it races wi=
th
> a memslot update), and because the underlying memory could be read-only e=
ven if
> the memslot is writable.
>

Ahh. Thanks for clarifying that.

> Why not simply return SBI_ERR_INVALID_ADDRESS on kvm_vcpu_write_guest() f=
ailure?
> The only downside of that is KVM will also return SBI_ERR_INVALID_ADDRESS=
 if the
> userspace mapping is completely missing, but AFAICT that doesn't seem to =
be an
> outright spec violation.

Yes. That's correct. That can still be considered as invalid address.
I will revise the patch according to this.
Thanks for the suggestions.

