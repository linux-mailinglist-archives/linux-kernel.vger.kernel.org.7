Return-Path: <linux-kernel+bounces-678194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6E6AD2566
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 20:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82E7B18910ED
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 18:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3320821D3CC;
	Mon,  9 Jun 2025 18:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B1O2WMIa"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDA655E69
	for <linux-kernel@vger.kernel.org>; Mon,  9 Jun 2025 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749493221; cv=none; b=mFGCj3VL25KnJQ7o61PZDIo2i5xBTOGqZ/htt3Ij5bvOD5D13L7/iQHMnFzo9m3m0sSYRLUhyBZvPKukgkQdsfza3trXhFfrU5cAEhituDy1VWt9clj0DyDgZI4wPrJBICkYRekUhNvvl/wjcSxuNqOppcA5X7zW8Fellr4xEu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749493221; c=relaxed/simple;
	bh=hXtDQVtzBt05LQPWiaTJRzc2pDfK+7mriXwEfggveQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qy1DT4ODt5jP/IdQ8mgA0Wr4Y6XxEBH96J+1Q1ApWB4f+gXRb2hmuG2mpvVcPSldnuzjxNDQKNXNHi2Zf1TWCpxk5OQU4ytLYCLfJN5O7C4/6VXBlMeLDdx21rainjF5MrTVL7uNpk++FUulkC/+J0TFWYq3i6fae18uLvefTq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B1O2WMIa; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-601a67c6e61so1677a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jun 2025 11:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749493218; x=1750098018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3blXDd8YInSQ/c19Uv1xImmNssJZC2qn40udTqZrJH8=;
        b=B1O2WMIapby5lRLQKgUQ4yAugam9O1aL16OSFVqIpBHxzxsX6GTINPFme5ghCrZWOz
         U7+FWzEmtj7iJydGnZKRSinDPA1BZXz/6uHqTHnKHUHTVK99rIDkN4er/fnE36yBudlY
         yJ1oil+eQ81BFsr7BQL04QlPSUgz6WlEkAIM1/httl2bSrJJcpkxYYeij4iSOK+y+KOz
         NqoKunezJ11MvGJPWfgve/jzAgd2LckW5/RPJ5AOesUQz5iPIJ7pc5WCU5cQXuzou/A+
         VO4Yy5G83U1TwX4NjflYU7lNhAACeizMdWYVambze3c+nVDqMu5BXmD5W+pjOR/iuBuD
         YdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749493218; x=1750098018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3blXDd8YInSQ/c19Uv1xImmNssJZC2qn40udTqZrJH8=;
        b=BEl//+8wE8e8cg5kaODglEGmSku5VnooqfKhPb4QVorq7Jh4zfRc/Z3HWpkDOGXrBp
         D8bLCs2Q1ASSA5EayuJgO9/yuGzZdmpr1LAPHY3QVOfVFLJtEFuf5VntDzNVwgG732GV
         knhyR7gDUnVXRA+HIj54stWuIlPXw7RwmoP+34Fjt3Q4Gf1Yh1JVQcgA9MmIQRlhxOYz
         BLABiNzVudmKFVgZxWEXzvVkUF4MR+I01OrxLaJkzPB8K237T52tNDp2MZUlbiMMGRYc
         +UqcrpAdd+2aC/1CQVfdDJWzOjDpeAnOP8PnSCmSuk0VMOJq08RB0St6/Ukej9eL7p8t
         DBwg==
X-Forwarded-Encrypted: i=1; AJvYcCW0UnT71IFzCE9SfgAm+Yacn80t24TwOQyPvhjtn8T9QrgZb7i45M0hH7ze2Wwl9leA6usnW+N6Ulgp3/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9R4NPpWFIXhRwB285xgtfrDfNPWG4PlZYF4aboaI5/VHdwOjG
	DFdWxs1J/7jCkMAV96nmvMlB2ucFnNEFO/Q/gNxY89ctbkqlDUttAYYTcswH2lBicYethWiRE1m
	1cID/cV61qvA/cqeMwXc5X2Uzmv/7yFeRozvJIskC
X-Gm-Gg: ASbGncvOYLdGRQtlHNQashaGlnt10x4Sv9RfcuVdMr57xmckRaSmsoxCoS/orzWPbb3
	nRx06ZUUIpS7MJpmvd3DNyoEygcXgPszrLFdk/MATcBkMTIU9yKROfTt85382Xbxlgve03NDOOv
	hqquwlIqWyuPXYrJdfs2OXd2claOLXjXtiJ+USEyNW1gsvT64PxvLNhg==
X-Google-Smtp-Source: AGHT+IG9ztMok/aqL/yvVGIqj8nxbavXUaNllC13qZXPpar9TQggxm6DeKT3NAwmq8GRl8lwhJ95MohJ1nUbYJr/WL4=
X-Received: by 2002:aa7:d286:0:b0:606:b6da:5028 with SMTP id
 4fb4d7f45d1cf-607aad5dd84mr154060a12.0.1749493218088; Mon, 09 Jun 2025
 11:20:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20211207095230.53437-1-jiangshanlai@gmail.com>
 <51bb6e75-4f0a-e544-d2e4-ff23c5aa2f49@redhat.com> <4a66adfa-fc10-4668-9986-55f6cf231988@zytor.com>
 <aEbuSmAf4aAHztwC@google.com> <CALMp9eSA0u5+_dPA7-M4oZgqt4sv-qez4fMuZ6S5X4rUp=33xQ@mail.gmail.com>
In-Reply-To: <CALMp9eSA0u5+_dPA7-M4oZgqt4sv-qez4fMuZ6S5X4rUp=33xQ@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 9 Jun 2025 11:20:05 -0700
X-Gm-Features: AX0GCFuZIV6CD7DM3SYh0VfLc_yWYx6NF-Qt3paJZCJhW2qN5kiwzTX3YMaH12Y
Message-ID: <CALMp9eQOCrUDKoLDokgJ2ZTJQGnhLchdPi=-GWdrOJH6ztEvsQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: X86: Raise #GP when clearing CR0_PG in 64 bit mode
To: Sean Christopherson <seanjc@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Lai Jiangshan <laijs@linux.alibaba.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Wanpeng Li <wanpengli@tencent.com>, Joerg Roedel <joro@8bytes.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 11:16=E2=80=AFAM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Mon, Jun 9, 2025 at 7:23=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > On Fri, Jun 06, 2025, H. Peter Anvin wrote:
> > > On 2021-12-09 09:55, Paolo Bonzini wrote:
> > > > On 12/7/21 10:52, Lai Jiangshan wrote:
> > > > > From: Lai Jiangshan <laijs@linux.alibaba.com>
> > > > >
> > > > > In the SDM:
> > > > > If the logical processor is in 64-bit mode or if CR4.PCIDE =3D 1,=
 an
> > > > > attempt to clear CR0.PG causes a general-protection exception (#G=
P).
> > > > > Software should transition to compatibility mode and clear CR4.PC=
IDE
> > > > > before attempting to disable paging.
> > > > >
> > > > > Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> > > > > ---
> > > > >   arch/x86/kvm/x86.c | 3 ++-
> > > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > > > index 00f5b2b82909..78c40ac3b197 100644
> > > > > --- a/arch/x86/kvm/x86.c
> > > > > +++ b/arch/x86/kvm/x86.c
> > > > > @@ -906,7 +906,8 @@ int kvm_set_cr0(struct kvm_vcpu *vcpu, unsign=
ed
> > > > > long cr0)
> > > > >           !load_pdptrs(vcpu, kvm_read_cr3(vcpu)))
> > > > >           return 1;
> > > > > -    if (!(cr0 & X86_CR0_PG) && kvm_read_cr4_bits(vcpu, X86_CR4_P=
CIDE))
> > > > > +    if (!(cr0 & X86_CR0_PG) &&
> > > > > +        (is_64_bit_mode(vcpu) || kvm_read_cr4_bits(vcpu,
> > > > > X86_CR4_PCIDE)))
> > > > >           return 1;
> > > > >       static_call(kvm_x86_set_cr0)(vcpu, cr0);
> > > > >
>
> Isn't this redundant with the "if (cs_l)" check above?

Never mind. That's an attempt to set CR0.PG, not to clear it.

> > > > Queued, thanks.
> > > >
> > >
> > > Have you actually checked to see what real CPUs do in this case?
> >
> > I have now, and EMR at least behaves as the SDM describes.  Why do you =
ask?
> >
> >
> > kvm_intel: Clearing CR0.PG faulted (vector =3D 13)
> >
> >
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index f79604bc0127..f90ad464ab7e 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -8637,6 +8637,23 @@ void vmx_exit(void)
> >         kvm_x86_vendor_exit();
> >  }
> >
> > +static noinline void vmx_disable_paging(void)
> > +{
> > +       unsigned long cr0 =3D native_read_cr0();
> > +       long vector =3D -1;
> > +
> > +       asm volatile("1: mov %1, %%cr0\n\t"
> > +                    "   mov %2, %%cr0\n\t"
> > +                    "2:"
> > +                    _ASM_EXTABLE_FAULT(1b, 2b)
> > +                    : "+a" (vector)
> > +                    : "r" (cr0 & ~X86_CR0_PG), "r" (cr0)
> > +                    : "cc", "memory" );
> > +
> > +       pr_warn("Clearing CR0.PG %s (vector =3D %ld)\n",
> > +               vector < 0 ? "succeeded" : "faulted", vector);
> > +}
> > +
> >  int __init vmx_init(void)
> >  {
> >         int r, cpu;
> > @@ -8644,6 +8661,8 @@ int __init vmx_init(void)
> >         if (!kvm_is_vmx_supported())
> >                 return -EOPNOTSUPP;
> >
> > +       vmx_disable_paging();
> > +
> >         /*
> >          * Note, hv_init_evmcs() touches only VMX knobs, i.e. there's n=
othing
> >          * to unwind if a later step fails.
> >

