Return-Path: <linux-kernel+bounces-853459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE92BDBB7A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 00:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67103E4E68
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15E525291B;
	Tue, 14 Oct 2025 22:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qKHpGyYr"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57109222587
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760482756; cv=none; b=I4G1fFT9J3ijJIgqFlK4OiqCC9Ix+dEMhMUk0PIl2OopTnopM7WxDg4jtyovBg4cFlBdIOExwQtZqVSSyEGTDqmeVgj7paGJOhDSUm6ZTPw9eBCrsZEbtD0RoGWtecYdL2isI2u5upIBCvrE1kncWcKs/+MZe2RJXhBLSsZypWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760482756; c=relaxed/simple;
	bh=oCZmimtL8wyakSKNhs3IyHX5fKnbOiFbDJ5tpLjLm+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbiHL3IcX8QTpTKyKWQs3fHFslZKLqL/qMDPHYcrYaTzdlWS3QN+7QTPBttEi4XinPijeZNKPRt9Jqy7/fkFwmSYAgQ9C6xzp4Qd4r9CaOOTx2RzhJkBWo0YSkHfEVC1v4MlgA1F2j+sKX0imNsN6H53pVehXoYSYS8H6/UyJmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qKHpGyYr; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62fa84c6916so5579a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760482753; x=1761087553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtQFLB81g/BVYDITUTQj/DMoi4Risjg7BA5ecZwx/Rw=;
        b=qKHpGyYrxWNrOG2j/Ikq+ZL5QJCptHKYs4JQytQtDZdOwYPMBLAk+OTpa+eYF3G68Z
         wdbPcZXNmHXEinaQJR7yZQG6khzgsHlmEIHsAU4GWeca7O8kwW6aXfKOuqK13PjXBiiC
         mNBud5gwNN1n3LBLVOoEPYUGNCBZDQ+/KCgGFu6lI/t2m78ljQCDbTjur039jMopcxIj
         ZGZR5/+ursyKiGNg07jNCQ53+Fodg37jPZCb66H+M3Gd6QP6Gt86w3FEMVBWD+B246SL
         jbUjOYOVqWQN9flvABmeJTi0BMTV3Of/2f7FkRzX/o4s5NzrLQH29o9UyiS9IuNvwtrp
         lUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760482753; x=1761087553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtQFLB81g/BVYDITUTQj/DMoi4Risjg7BA5ecZwx/Rw=;
        b=sdsZaEjtX9cTTFew1pI3YqDOpaPzIjsWf5e1+tnCRjLq1sJkpA/x0w7E1Mi1uiouSJ
         KNPU+5pSozrFHxxWAldQrj24/n8FjufXxdasxR0oiznciy0WjbtfJ+6sCQyUNbOCoAnW
         ZKGL24rAHxnbE22CkiiWtnsJnoPFq1S45oOPVOz5cfzooic+keXhHw1BaUsIKKAoGwR3
         eaK0QZWWTEhkJa/e3Prx0rK2m1TbKsGOcADLSVxp931QdBnuD6WemDCn2Y+2+Lg+b0sH
         Nb0q1lawLQm/A71N0XNC+lzhjYbh2mTCEuSO2lIyuOucoErhjQt2g14BothYjvNXa6y/
         vs2g==
X-Forwarded-Encrypted: i=1; AJvYcCVPKUiDAX0UiSIM+SdpWb2iHuZgYYtkZfCzY1bBNz28egkJ/OOM6QZQ7C/20Xsdl7DXt0HYUwNaQJddHOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV12OpRJRTq6Mll5u25xa6V7AxJn+EYazIIzdO/ZC8/ae3/LNN
	46yA4fx7tzoKlck8vovce74HR3WufSqJACGsFKC6dIc7k8ckljGxClW7I/2cYPAg6k64zYwJuy7
	WV9rW3I+bAQqNTqeiAdCdybwwzdw0iEBoAu42u0qb
X-Gm-Gg: ASbGncvvs+GBs4zC4rsOdSOBZyyMUtRoNDukSSh7O1g+l/Y2gdpYxky8OBMwZJf3CYt
	vjXXbvX7kqnVpa+Ox8cVmXa1KzDWmp1OKwZQLeoRJZXXay6H9BprG/L1yu6JqAt/Wb+NTm6KimN
	Cq4ESx4Y0LbkXgpj+QlHTlwZ4ZqXGGasKjC9ebcAb/XNG37T3MBvx88GxbXh67ILxnivJEchLwL
	OJaFAEnn0A5769kXtYJG0C3gquAw3NsSaucVzrO1eE=
X-Google-Smtp-Source: AGHT+IFB4zwAL/bbyRE92LhTcq1gPg0XjcpjmyHXPIfj0e6a15qbsoxevjPYKBBnMQoQGTa2xfMI6NukoL2Ts3OUSmM=
X-Received: by 2002:a05:6402:2791:b0:62f:a20d:5a92 with SMTP id
 4fb4d7f45d1cf-63bebfe10cemr45284a12.4.1760482752435; Tue, 14 Oct 2025
 15:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009223153.3344555-1-jmattson@google.com> <20251009223153.3344555-3-jmattson@google.com>
 <aO1-IV-R6XX7RIlv@google.com> <CALMp9eRQZuDy8-H3b8tbdZVQSznUK9=yhuBV9vBFAQz3UP+iRg@mail.gmail.com>
 <aO6-CbTRPp1ZNIWq@google.com> <CALMp9eRJaO9z=u5y0e+D44_U_FH1ye2s+cHNHmtERxEe+k2Dsw@mail.gmail.com>
 <aO7JjaymjPMBcjrz@google.com>
In-Reply-To: <aO7JjaymjPMBcjrz@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 14 Oct 2025 15:58:59 -0700
X-Gm-Features: AS18NWCWQWYl72UNn1FRW6vVPHZKztpwwKp84QmuJqXGgiYdgFqOgu1b1-yeUrI
Message-ID: <CALMp9eQ3Ff4pYJgwcyzq-Ttw=Se6f+Q3VK06ROg5FCJe+=kAhg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] KVM: SVM: Don't set GIF when clearing EFER.SVME
To: Sean Christopherson <seanjc@google.com>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 3:07=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Oct 14, 2025, Jim Mattson wrote:
> > On Tue, Oct 14, 2025 at 2:18=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Tue, Oct 14, 2025, Jim Mattson wrote:
> > > > On Mon, Oct 13, 2025 at 3:33=E2=80=AFPM Sean Christopherson <seanjc=
@google.com> wrote:
> > > > >
> > > > > On Thu, Oct 09, 2025, Jim Mattson wrote:
> > > > > > Clearing EFER.SVME is not architected to set GIF.
> > > > >
> > > > > But it's also not architected to leave GIF set when the guest is =
running, which
> > > > > was the basic gist of the Fixes commit.  I suspect that forcing G=
IF=3D1 was
> > > > > intentional, e.g. so that the guest doesn't end up with GIF=3D0 a=
fter stuffing the
> > > > > vCPU into SMM mode, which might actually be invalid.
> > > > >
> > > > > I think what we actually want is to to set GIF when force-leaving=
 nested.  The
> > > > > only path where it's not obvious that's "safe" is toggling SMM in
> > > > > kvm_vcpu_ioctl_x86_set_vcpu_events().  In every other path, setti=
ng GIF is either
> > > > > correct/desirable, or irrelevant because the caller immediately a=
nd unconditionally
> > > > > sets/clears GIF.
> > > > >
> > > > > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.=
c
> > > > > index a6443feab252..3392c7e22cae 100644
> > > > > --- a/arch/x86/kvm/svm/nested.c
> > > > > +++ b/arch/x86/kvm/svm/nested.c
> > > > > @@ -1367,6 +1367,8 @@ void svm_leave_nested(struct kvm_vcpu *vcpu=
)
> > > > >                 nested_svm_uninit_mmu_context(vcpu);
> > > > >                 vmcb_mark_all_dirty(svm->vmcb);
> > > > >
> > > > > +               svm_set_gif(svm, true);
> > > > > +
> > > > >                 if (kvm_apicv_activated(vcpu->kvm))
> > > > >                         kvm_make_request(KVM_REQ_APICV_UPDATE, vc=
pu);
> > > > >         }
> > > > >
> > > >
> > > > This seems dangerously close to KVM making up "hardware" behavior, =
but
> > > > I'm okay with that if you are.
> > >
> > > Regardless of what KVM does, we're defining hardware behavior, i.e. k=
eeping GIF
> > > unchanged defines behavior just as much as setting GIF.  The only way=
 to truly
> > > avoid defining behavior would be to terminate the VM and completely p=
revent
> > > userspace from accessing its state.
> >
> > This can't be the only instance of "undefined behavior" that KVM deals
> > with.
>
> Oh, for sure.  But unsurprisingly, people only care about cases that actu=
ally
> matter in practice.  E.g. the other one that comes to mind is SHUTDOWN on=
 AMD:
>
>         /*
>          * VMCB is undefined after a SHUTDOWN intercept.  INIT the vCPU t=
o put
>          * the VMCB in a known good state.  Unfortuately, KVM doesn't hav=
e
>          * KVM_MP_STATE_SHUTDOWN and can't add it without potentially bre=
aking
>          * userspace.  At a platform view, INIT is acceptable behavior as
>          * there exist bare metal platforms that automatically INIT the C=
PU
>          * in response to shutdown.
>          *

The behavior of SHUTDOWN while GIF=3D=3D0 is clearly architected:

"If the processor enters the shutdown state (due to a triple fault for
instance) while GIF is clear, it can only be restarted by means of a
RESET."

Doesn't setting GIF in svm_leave_nested() violate this specification?

