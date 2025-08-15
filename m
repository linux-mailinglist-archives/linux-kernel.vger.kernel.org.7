Return-Path: <linux-kernel+bounces-770154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F068EB277BE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22BCF7BF969
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C6F225402;
	Fri, 15 Aug 2025 04:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vThA3BVD"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CAA1DA60D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 04:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755231910; cv=none; b=VO7t/3vUCgezURfZpK0JXcMRL2OnZTSbr7jqo2TLsfYMLqfow9YnNzFxGZxTgXwAJr6Ed0nkq/tgBWQAJkRWWu6Hba3wDnj5hXSlAURUplA/zC+E+y9s/pEhmvjWmpuK1IlBtcw61jvLSPD8Z/b5C9IqYiCznW8ag5CAnHAwv2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755231910; c=relaxed/simple;
	bh=ZUdV+sHgzBAbGmVqwA/+9SHSpnIF2uveWBWRGPl+U5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jyi8qb9SP841Vr1ClN0Mch9j9JJQcuTVmwk6d5kN1iLT/uICPLkyYnb9z+hyNWiEk6fzx/MpekaVEHh1aQHi/P3eElIWUdH0PD5nxnYqje0+xRRict48/c8yv4yleyA2sc2uZeN8ufu2muOAkadd0F+y0ohXvzroOCwh2b+pyaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vThA3BVD; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b0bd88ab8fso153311cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 21:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755231907; x=1755836707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnCucd95Tz0s4cgWs/HFc+YpaS6ltImNSFdaIKcyfXE=;
        b=vThA3BVD2gNx8p0zv0TupdU1tzkatAsJSieZ98KZfE+fMWRhMRM0VCAhTsTUfRjahE
         22iZPa2z/2nF4ssiy1THRWS8WwwMEUumbL+glnFnzImoXcV7BUa5XEtnCnyTpuKaNVWJ
         H6+tz87FxpVqiUwaklDL1UenFyleUkEtdDXqLhts4eiWMZzAcjcLY7X3ErycFQDq55Yf
         CxCvj7E0ql2OvC1HrQzDslJQ8bP5hgAIpoH+keC9RQYRj2jHoYpXZuiJs50OHlS1wq7f
         wJt9ehxUMYe7KP4l905hPd1Jp/J0vL/d4MoHD850I65bvaMPNCWnklKqkX/8Z9DvvnuD
         rC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755231907; x=1755836707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnCucd95Tz0s4cgWs/HFc+YpaS6ltImNSFdaIKcyfXE=;
        b=swDEIHx+j27Wf/LOBaTx1QlEXHxABEDGkwMUUtcScms7QNTToH7F4mlKBchz17zpRP
         2DV9rO/jgFZaQG2zTZFMTxmn3gJq96xc1vEG8fAWrMF771BME/UjVLo751MT5y5zlgaV
         BaDqFpk6/0DHJuyunGiPGhbP6ErTpyNdu4NYItbfLIMCX3qFsdlOuEiUKCyff4NBU0dI
         Z/pGZD0Viu9QUvqndnL7kiyyO4BNm8x/6cJhSS/T1aPz12Eq7ReZmXLLsJfEoos+6Gzp
         ZbQ7CauN2amUpQbPPMPWPYnJO9XdQQJAD4SA4ORlsFNkXDqde0hFlKGM3ppc06PnTGkM
         Z3fA==
X-Forwarded-Encrypted: i=1; AJvYcCUhrfzjpUU/2aKxD24oKLJl9lItrY1WW1HlfNbgEwmcgiWJg/COMZuzNHP4Y08/cQI7faPtmKKTVr6jEvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxByrHXKBc2dhZKn/5sbgJ/4w5wGbtDJzixWZmCQ+wyuhPi5Rqu
	pYMPN5nPN0dJbcoDIzQFGPMnvZr4ESwBaxl5nLrGCv7+upkfUeLeRNNukwRWlDGaZDtJRFRFES+
	PyB6uU0X3t09T7tvxia98+8M7hqP074YbW2Ax2JLX
X-Gm-Gg: ASbGncuq7TRlIf1G6ZdFsTJY2Zv9VGvn5OEXB3kKoYjq3k8AVtwVNnOOfmiToAB871R
	Q+CJB9KAdezhSwC/8BnYCGFX5wpv+gzegIRRTwPgEaBYU9AejVnAjU8fng+xa3uS1GeA1IOPXcc
	Kdokgtcp/O+WNE1O0pujZXEr0d9vRUp3WPre8doVW9CpEv6ncSlYec43h3LjVuXAAaZxAT8qSN6
	mF/Q/szRXYhsq6cchNgKtExAXtxgoIEMEQFrJvmQc7v3w==
X-Google-Smtp-Source: AGHT+IETDxqJsA81l8z4YH4m940rMMfHJ2+RVY6eY3g4bogbh2PFnaPd/dUjty4EW5+gtY5dqSNUT868lcudGdIw8Es=
X-Received: by 2002:ac8:5a11:0:b0:4a8:eb0:c528 with SMTP id
 d75a77b69052e-4b11b7954a0mr1769361cf.15.1755231907054; Thu, 14 Aug 2025
 21:25:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com> <20250807201628.1185915-3-sagis@google.com>
 <aJoyT-w9U9lJhR-z@google.com>
In-Reply-To: <aJoyT-w9U9lJhR-z@google.com>
From: Sagi Shahar <sagis@google.com>
Date: Thu, 14 Aug 2025 23:24:56 -0500
X-Gm-Features: Ac12FXwn7bR78b4_yj_pg2SkkAXfUr0b8A_ETfgotgXuFCVlQfcRJcv8Z1XtJZQ
Message-ID: <CAAhR5DFzN7YNpmzCwG+oYWxz3pbPaqrETnrCFAGvnkGHRkG+vg@mail.gmail.com>
Subject: Re: [PATCH v8 02/30] KVM: selftests: Expose function that sets up
 sregs based on VM's mode
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 1:11=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Aug 07, 2025, Sagi Shahar wrote:
> > From: Ackerley Tng <ackerleytng@google.com>
> >
>
> Make changelogs standalone, i.e. don't rely on the subject/shortlog for c=
ontext.
>
> > This allows initializing sregs without setting vCPU registers in
> > KVM.
> >
> > No functional change intended.
> >
> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > Signed-off-by: Sagi Shahar <sagis@google.com>
> > ---
> >  .../selftests/kvm/include/x86/processor.h     |  1 +
> >  .../testing/selftests/kvm/lib/x86/processor.c | 45 ++++++++++---------
> >  2 files changed, 25 insertions(+), 21 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tool=
s/testing/selftests/kvm/include/x86/processor.h
> > index b11b5a53ebd5..f2eb764cbd7c 100644
> > --- a/tools/testing/selftests/kvm/include/x86/processor.h
> > +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> > @@ -1025,6 +1025,7 @@ static inline struct kvm_cpuid2 *allocate_kvm_cpu=
id2(int nr_entries)
> >  }
> >
> >  void vcpu_init_cpuid(struct kvm_vcpu *vcpu, const struct kvm_cpuid2 *c=
puid);
> > +void vcpu_setup_mode_sregs(struct kvm_vm *vm, struct kvm_sregs *sregs)=
;
> >
> >  static inline void vcpu_get_cpuid(struct kvm_vcpu *vcpu)
> >  {
> > diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/te=
sting/selftests/kvm/lib/x86/processor.c
> > index a92dc1dad085..002303e2a572 100644
> > --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> > @@ -488,34 +488,37 @@ static void kvm_seg_set_tss_64bit(vm_vaddr_t base=
, struct kvm_segment *segp)
> >       segp->present =3D 1;
> >  }
> >
> > -static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
> > +void vcpu_setup_mode_sregs(struct kvm_vm *vm, struct kvm_sregs *sregs)
> >  {
> > -     struct kvm_sregs sregs;
> > -
> >       TEST_ASSERT_EQ(vm->mode, VM_MODE_PXXV48_4K);
> >
> > -     /* Set mode specific system register values. */
> > -     vcpu_sregs_get(vcpu, &sregs);
> > -
> > -     sregs.idt.base =3D vm->arch.idt;
> > -     sregs.idt.limit =3D NUM_INTERRUPTS * sizeof(struct idt_entry) - 1=
;
> > -     sregs.gdt.base =3D vm->arch.gdt;
> > -     sregs.gdt.limit =3D getpagesize() - 1;
> > +     sregs->idt.base =3D vm->arch.idt;
> > +     sregs->idt.limit =3D NUM_INTERRUPTS * sizeof(struct idt_entry) - =
1;
> > +     sregs->gdt.base =3D vm->arch.gdt;
> > +     sregs->gdt.limit =3D getpagesize() - 1;
> >
> > -     sregs.cr0 =3D X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
> > -     sregs.cr4 |=3D X86_CR4_PAE | X86_CR4_OSFXSR;
> > +     sregs->cr0 =3D X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
> > +     sregs->cr4 |=3D X86_CR4_PAE | X86_CR4_OSFXSR;
> >       if (kvm_cpu_has(X86_FEATURE_XSAVE))
> > -             sregs.cr4 |=3D X86_CR4_OSXSAVE;
> > -     sregs.efer |=3D (EFER_LME | EFER_LMA | EFER_NX);
> > +             sregs->cr4 |=3D X86_CR4_OSXSAVE;
> > +     sregs->efer |=3D (EFER_LME | EFER_LMA | EFER_NX);
> > +
> > +     kvm_seg_set_unusable(&sregs->ldt);
> > +     kvm_seg_set_kernel_code_64bit(&sregs->cs);
> > +     kvm_seg_set_kernel_data_64bit(&sregs->ds);
> > +     kvm_seg_set_kernel_data_64bit(&sregs->es);
> > +     kvm_seg_set_kernel_data_64bit(&sregs->gs);
> > +     kvm_seg_set_tss_64bit(vm->arch.tss, &sregs->tr);
> >
> > -     kvm_seg_set_unusable(&sregs.ldt);
> > -     kvm_seg_set_kernel_code_64bit(&sregs.cs);
> > -     kvm_seg_set_kernel_data_64bit(&sregs.ds);
> > -     kvm_seg_set_kernel_data_64bit(&sregs.es);
> > -     kvm_seg_set_kernel_data_64bit(&sregs.gs);
> > -     kvm_seg_set_tss_64bit(vm->arch.tss, &sregs.tr);
> > +     sregs->cr3 =3D vm->pgd;
>
> Add helpers/macros for the few things that are open coded here so that th=
e TDX
> code can get the "default" values.  Bouncing data through kvm_sregs is un=
necessary
> (unless you're trying to win the Obfuscated C contest) and makes it much =
harder to
> understand what TDX actually needs, and why.
>
> IDT.base, GDT.base, and CR3 (vm->pgd) are already available, so something=
 like:
>
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/test=
ing/selftests/kvm/lib/x86/processor.c
> index d4c19ac885a9..83efcf48faad 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -498,15 +498,13 @@ static void vcpu_init_sregs(struct kvm_vm *vm, stru=
ct kvm_vcpu *vcpu)
>         vcpu_sregs_get(vcpu, &sregs);
>
>         sregs.idt.base =3D vm->arch.idt;
> -       sregs.idt.limit =3D NUM_INTERRUPTS * sizeof(struct idt_entry) - 1=
;
> +       sregs.idt.limit =3D kvm_get_default_idt_limit();
>         sregs.gdt.base =3D vm->arch.gdt;
> -       sregs.gdt.limit =3D getpagesize() - 1;
> +       sregs.gdt.limit =3D kvm_get_default_gdt_limit();
>
> -       sregs.cr0 =3D X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
> -       sregs.cr4 |=3D X86_CR4_PAE | X86_CR4_OSFXSR;
> -       if (kvm_cpu_has(X86_FEATURE_XSAVE))
> -               sregs.cr4 |=3D X86_CR4_OSXSAVE;
> -       sregs.efer |=3D (EFER_LME | EFER_LMA | EFER_NX);
> +       sregs.cr0 =3D kvm_get_default_cr0();
> +       sregs.cr4 |=3D kvm_get_default_cr4();
> +       sregs.efer |=3D kvm_get_default_efer();
>
>         kvm_seg_set_unusable(&sregs.ldt);
>         kvm_seg_set_kernel_code_64bit(&sregs.cs);
>
>

Thanks for the suggestion. I'll be dropping this patch in the next version.

> > +}
> > +
> > +static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
> > +{
> > +     struct kvm_sregs sregs;
> >
> > -     sregs.cr3 =3D vm->pgd;
> > +     vcpu_sregs_get(vcpu, &sregs);
> > +     vcpu_setup_mode_sregs(vm, &sregs);
> >       vcpu_sregs_set(vcpu, &sregs);
> >  }
> >
> > --
> > 2.51.0.rc0.155.g4a0f42376b-goog
> >

