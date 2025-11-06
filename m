Return-Path: <linux-kernel+bounces-889251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D999AC3D126
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 19:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075A23AEC5B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 18:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F7534E744;
	Thu,  6 Nov 2025 18:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tt/9nv3l"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AC534D4C6
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762453787; cv=none; b=OuXwuWpag+KXZt559zYQ34Vo8etYCeZD4sCxuz16IUY007WP4l3K6eDIs6r1wwixUKsc9hhE5s2bRQ9NOTaIPBKVzdLJbRzdglmRf6udPOCX3GGS0OxTtYZI90iBrB3Vg7eG95H7qCsdZsihR6ktAs0XSOwGgU2jHkofSDVIIbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762453787; c=relaxed/simple;
	bh=Hk2kkkXAIhT7SLFpYPU2qd4ra9YnnoIlTUZDjuxhE60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7KVb128K+DReO+Rsw52tDQ3FJEnS9nO77NaZl+rHAP5BnH0YtlfQhG4tDF/lWWBGoXsq+h2NDJIZLYdJ1yKnZ+X1i8fduH3osKcBSXGs6T/qpcZ2HrMjxYNsW5677Oe10UQfbgsHIQcfgrCEKDCG4iLn6L8q1yGmtb2pssvnbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tt/9nv3l; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3761e5287c9so12097191fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 10:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762453783; x=1763058583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A66ECIPhhDrcdtn9psWFuT8F3KeGTGpZjxoa205S5r8=;
        b=Tt/9nv3lUq5QJzNNzSri/kDy0kaEUZC0TPtpx+vGRjEvyWq1rkJg3dgbON04HCFGfD
         Nl6PdypFngkKZKsSukE0TgFCUnTRE1qwfKByD4wWHv7bpKXBSh8tjKyU/zlvN0tcRdnX
         TMaaFwcQG2gAEBUgITjVyAe0oN6IoUMIc2bDbcIjSVOKIkS+RQVcq0oHelC2trKCarys
         P1CbUUJc5NnGNiGZZdBop4VMDFLRDo0ZnCsaetVKsTK95cgL4MKoMSWjiSRbGrwkkwD0
         ajOgHxrQZjqchViSQijo3ON6VH2VY4FNKkEJP2i2wGTnM8bmcDwdbWTdkqMPmGqHQpxY
         2wOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762453783; x=1763058583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A66ECIPhhDrcdtn9psWFuT8F3KeGTGpZjxoa205S5r8=;
        b=CucdYvDGRiozv+Mw0LCOSzeY8CGf3ilnExsAz7nMisn0azu1iKtx8AGZvWG3PsJUeS
         zyD9fHJq9YgdfVxYVA7EBXPG752QrFAOZKXT1O24dSbRliUuGOZAGpxY34x7auIichs3
         pYmHWA67JodxY2LHt71ASwDr1S1rFNBFaJ0x5Dsh+hBt5vGLIicg0yBCT7ER67ZEfXuS
         ZLeIYkqqB9lqAoay9uirrtTLgT0roO53DxnTOhC35xjngBbjngPEybPQFEsD0tASE0QV
         DEpeD9vufmKGxd5mwAJ/tLQN7rh4HRWH8/mrUP3WfN2fELECbBzc9xmcWi8coOeUaPTF
         A3JA==
X-Forwarded-Encrypted: i=1; AJvYcCW9uyCjutFY22Y1ab6s4gFFSnLxk6BJdXrBodiMijnaPFC+rvalAoZLiSxgtxSignBwKrAb4OqGplG9hTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylngh3CKroFJK4zEYgLcSnrtHolB7EvOH6k5xSoyEKT4s9v1Xi
	2egGEQuo0ncXxF+fWZ+8yZzoWIHaL6sOequfHdxzp74KMguCVpcioDiFFfVB3cODgDDc8yka9ZO
	89GTPK3Z+yJFIeT0Pn/GSeEJTk/VvFas=
X-Gm-Gg: ASbGnctIKXdHJcpQA9fd3xrumnjFQ1/y8+Wnnn9M5cdn0kLPE2ZmWodv1bl/bQv4BOm
	CNPmuxi4pSwxIB50xX+CFVA2DdKb6kE0018ww1FtrrkrtXsqC0+Dq9h8+dF4tTam27UHUr2PVbc
	XGboKZz3De3dr4BKRYP3vPxUr8b2T0NVNguGRAJHdQfB/6jHpvEyJsn54TCIxGHOHGv/0R55Ahx
	voseTQsmN5BDXHIRTyFjitodetmrSTayalvklu/7tmqE6FP+1xu+zDYvSOQDjuHb5u+ouY=
X-Google-Smtp-Source: AGHT+IFxE5CJeoOVNA1k5WhO44qMMlAItFYH7FTjGkRzoWepzYjW/MXRUWMCq/Gb8/8s2KlF+dkeFMMq6bXkYiuXaMY=
X-Received: by 2002:a05:651c:f08:b0:37a:2e63:d4c0 with SMTP id
 38308e7fff4ca-37a73155778mr907001fa.16.1762453783180; Thu, 06 Nov 2025
 10:29:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807063733.6943-1-ubizjak@gmail.com> <aKSRbjgtp7Nk8-sb@google.com>
 <CAFULd4ZOtj7WZkSSKqLjxCJ-yBr20AYrqzCpxj2K_=XmrX1QZg@mail.gmail.com>
 <aKTI1WOJAKDnkRyu@google.com> <CAFULd4ZR6TPVqq5TXToR-0HbX5oM=NEdw126kcDe5LNDdxZ++w@mail.gmail.com>
 <CAFULd4Y6W0hJbA8Ki2yB60537mC8+ohXyUgxD+HuKDQhq7zGmA@mail.gmail.com> <aQv14mmAkUPL-Fap@google.com>
In-Reply-To: <aQv14mmAkUPL-Fap@google.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 6 Nov 2025 19:29:31 +0100
X-Gm-Features: AWmQ_bmgjjm2sj4rYZqaFqFzmhntIXH-7Wb0by4SazycfXC0teZFBBV6Nt2z3SQ
Message-ID: <CAFULd4Zc4-nPLSEeUbOh_A1O9VyC8arHVy=Y4Gg-d_Rjhon1Ow@mail.gmail.com>
Subject: Re: [PATCH] KVM: VMX: Micro-optimize SPEC_CTRL handling in __vmx_vcpu_run()
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 2:12=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:

> > VMX patch is at [1]. SVM patch is a bit more involved, because new
> > 32-bit code needs to clobber one additional register. The SVM patch is
> > attached to this message, but while I compile tested it, I have no
> > means of testing it with runtime tests. Can you please put it through
> > your torture tests?

[...]

> > -
> >       /* Now restore the host value of the MSR if different from the gu=
est's.  */
> > -     movl PER_CPU_VAR(x86_spec_ctrl_current), %eax
> > -     cmp SVM_spec_ctrl(%_ASM_DI), %eax
> > +     mov SVM_spec_ctrl(%rdi), %rdx
> > +     cmp PER_CPU_VAR(x86_spec_ctrl_current), %rdx
> >       je 901b
> > -     xor %edx, %edx
> > +     movl %edx, %eax
> > +     shr $32, %rdx
> > +#else
> > +     mov %eax, SVM_spec_ctrl(%edi)
> > +     mov %edx, SVM_spec_ctrl + 4(%edi)
> > +998:
> > +     /* Now restore the host value of the MSR if different from the gu=
est's.  */
> > +     mov SVM_spec_ctrl(%edi), %eax
> > +     mov PER_CPU_VAR(x86_spec_ctrl_current), %esi
> > +     xor %eax, %esi
> > +     mov SVM_spec_ctrl + 4(%edi), %edx
> > +     mov PER_CPU_VAR(x86_spec_ctrl_current + 4), %edi
> > +     xor %edx, %edi
> > +     or %edi, %esi
> > +     je 901b
>
> This particular flow is backwards, in that it loads the guest value into =
EDX:EAX
> instead of the host values.

Yeah, sorry about that, I was really not sure which value is where.
Please just swap

SVM_spec_ctrl(%edi) with PER_CPU_VAR(x86_spec_ctrl_current)

references (and their offseted variants) in the above code, and it
will result in the correct and optimal code.

Thanks,
Uros.

