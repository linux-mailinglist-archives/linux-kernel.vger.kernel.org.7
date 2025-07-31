Return-Path: <linux-kernel+bounces-752595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE6CB177A9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 23:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC1C1AA518D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 21:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30312256C9B;
	Thu, 31 Jul 2025 21:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e5wJVcIl"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61ED21CFF6
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 21:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753995984; cv=none; b=dSLD7LMnd7pGWBpt9JB2txax+fRVgMfBTMNFzcmV21toPCFjaQV4L28Tt5mv67qAvn0YEqHDjjSjdk+j2crBadWOwh9Y4FH7VrEoie8z05VOif9Tol3kJaQJUxQ94n7KtzGnGMwbnxaAAb9ck09MzBb6dvUkHw2YWnTCeo8CsvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753995984; c=relaxed/simple;
	bh=u97scRes2MGBfyHL/4/UXMUX5BojdNBN6SMyZI+xTbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRyIUk+Yr/QVnTuF9Vsxj/IEuXggRXIuInwh93yE6OEnf62aip8kSZkcYKYwiz4wwc4wyLL8GbeLvf3I9JeqrdhmqBMKzXY1+zUy9ikTKQeYlqNrNCuPaeeD32Sx7eg50wkHss2FdBNb/u2Se+dl19y6kIwqsM+KNpbyuO63lYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e5wJVcIl; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-455b63bfa52so15955e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753995980; x=1754600780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgWYvBUZsAdFKPaveOzEc3d+WOgwdbiYYocXO60wkYI=;
        b=e5wJVcIlnqyEU9iojPSUpGq0yrpbhIkqeu11w5ZiDC0isxzvwV5lf/7WbVTaaJB1mm
         NWZaUnOuGpD0seumsuC0Y5HXw6jAFx8b5Bj9H1VTxqH0Eh/uqGZGADeAudjVOnBAbFVi
         FNs3S510j9+1HlJ/81l5pFRszZfI2F2IiRj+uaELgwo5cFd+iMAGpKaftXqy34Fr/gOr
         yw3JmKsIH4Sy77ThNg+NvqT9+PY4nPTBbhrxF36KKZ/kdtRB1EvnXRMXH3/1It8kcuex
         gL4tGlbOEYJwEIKBRKGyQrU0FI/tM9TYCSztLyfRyA+NF4g5M2YIlfZtdlGxapqyyB98
         BGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753995980; x=1754600780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgWYvBUZsAdFKPaveOzEc3d+WOgwdbiYYocXO60wkYI=;
        b=SaUQ0IXwscJToQ9CZEXR+HqxysNfD6gOnQgi8Wg2TlzZSDLqhdGreBI+it8gLJhWyI
         5BZ/h9wR+0owprnxNVUlVfWoXuvX4FoIM3GZYCNOvAmVjj18TO0yHx769aikmDioSZhU
         wZXwxiprPI1Z3CxYnhuHLSz4oddbo099MiE2EVTGEy9LUydEZEbkIqFpmIQZbcTyKt6g
         ZmsHYVaH69lPGCSolq/+chG43ACVRWfsu9w1ttvj4BRKeN74ydFJE11i1ktVaMuanE9D
         Fg14vb5nm0dR7D19cmHI7f8q9A6vcXgpDLAYrK6waD0Qwoh1K5gnV7n6rS6BUI8spx8J
         zBEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrO4p1c2FA7kCfv047IZeW5QriAeEziAAh+lQQ9T4NFKBXp1rKJb/nrHvJhJHSGFeX+unsoFjG0huyWWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw5knbUpGyKNaziY7xc1wTzpMfgm6AFJLIDYrYEHTjdDEBKYo/
	asZwznYCtED5pcjGasDhW9MeQzevy/NlYylRt93dAeeS/rdwfEdmWzIRJgv7dsrsJHWCo6LuVPA
	e3jYFzZWPS7/y0k+9U4UfSXnuZBuKP5WfMBuBFSNG
X-Gm-Gg: ASbGncug8zTQyezzdfwjDKqNxPzFXfLLeqUpY5x+l6lb2UBXOaYudVc+K9svzYAw9Fv
	yPlmkhJohxplQJvAX68ICn8atydd7W+GmaHFsJ8JyY5gEx9VdVnQfhxST5NNql9wQFUES2GaE8r
	8JZHOY2utEKV9x0qorJTNDearCGthwDK18Gjy0Xa1/jLf8qVWi7Al/nMFRCzpcViLmsj0KSM9+J
	0nRQb77RxRODnOgscWDUJPsPBd+/JwvVkjHgw==
X-Google-Smtp-Source: AGHT+IFm3eKGXrXl/O/AM6upHGvXxmGw78o++n3la/oaRAWXtoLaY8AnkOKammwFhld3+mfKolmNlEirM7qsdbyTR+8=
X-Received: by 2002:a05:600c:524d:b0:456:e94:466c with SMTP id
 5b1f17b1804b1-458aa0ceb0fmr65675e9.3.1753995979762; Thu, 31 Jul 2025 14:06:19
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604050902.3944054-1-jiaqiyan@google.com> <20250604050902.3944054-2-jiaqiyan@google.com>
 <aHFohmTb9qR_JG1E@linux.dev> <CACw3F509B=AHhpaTcuH9O851rrDdHh1baC8uRYy7bDa7BSMhgg@mail.gmail.com>
 <aHK-DPufhLy5Dtuk@linux.dev> <CACw3F53TYZ1KFv0Yc-GCyOxn7TF3iYjTNSE8bd3nte=KaCN0UQ@mail.gmail.com>
 <CACw3F50Q_G75wf2rBm-P-NkyyO72i1NKqR9se99QrgipfD62yg@mail.gmail.com> <aIk88sBA2eIEF7w-@linux.dev>
In-Reply-To: <aIk88sBA2eIEF7w-@linux.dev>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Thu, 31 Jul 2025 14:06:07 -0700
X-Gm-Features: Ac12FXzFKc2B2EcyGnO8u_UvWK78u_LF9_nWfSQdCWk4Auknl3BBza84szmbGVs
Message-ID: <CACw3F504DbPhnN5MyBq4XES-=Te3Z4Xxqfkpifiu1DEgO3tUyg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] KVM: arm64: VM exit to userspace to handle SEA
To: Oliver Upton <oliver.upton@linux.dev>
Cc: maz@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, 
	pbonzini@redhat.com, corbet@lwn.net, shuah@kernel.org, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, duenwen@google.com, rananta@google.com, 
	jthoughton@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 2:28=E2=80=AFPM Oliver Upton <oliver.upton@linux.de=
v> wrote:
>
> On Fri, Jul 25, 2025 at 03:54:10PM -0700, Jiaqi Yan wrote:
> > On Sat, Jul 19, 2025 at 2:24=E2=80=AFPM Jiaqi Yan <jiaqiyan@google.com>=
 wrote:
> > >
> > > On Sat, Jul 12, 2025 at 12:57=E2=80=AFPM Oliver Upton <oliver.upton@l=
inux.dev> wrote:
> > > >
> > > > On Fri, Jul 11, 2025 at 04:59:11PM -0700, Jiaqi Yan wrote:
> > > > > >  - Add some detail about FEAT_RAS where we may still exit to us=
erspace
> > > > > >    for host-controlled memory, as we cannot differentiate betwe=
en a
> > > > > >    stage-1 or stage-2 TTW SEA when taken on the descriptor PA
> > > > >
> > > > > Ah, IIUC, you are saying even if the FSC code tells fault is on T=
TW
> > > > > (esr_fsc_is_secc_ttw or esr_fsc_is_sea_ttw), it can either be gue=
st
> > > > > stage-1's or stage-2's descriptor PA, and we can tell which from
> > > > > which.
> > > > >
> > > > > However, if ESR_ELx_S1PTW is set, we can tell this is a sub-case =
of
> > > > > stage-2 descriptor PA, their usage is for stage-1 PTW but they ar=
e
> > > > > stage-2 memory.
> > > > >
> > > > > Is my current understanding right?
> > > >
> > > > Yep, that's exactly what I'm getting at. As you note, stage-2 abort=
s
> > > > during a stage-1 walk are sufficiently described, but not much else=
.
> > >
> > > Got it, thanks!
> > >
> > > >
> > > > > > +/*
> > > > > > + * Returns true if the SEA should be handled locally within KV=
M if the abort is
> > > > > > + * caused by a kernel memory allocation (e.g. stage-2 table me=
mory).
> > > > > > + */
> > > > > > +static bool host_owns_sea(struct kvm_vcpu *vcpu, u64 esr)
> > > > > > +{
> > > > > > +       /*
> > > > > > +        * Without FEAT_RAS HCR_EL2.TEA is RES0, meaning any ex=
ternal abort
> > > > > > +        * taken from a guest EL to EL2 is due to a host-impose=
d access (e.g.
> > > > > > +        * stage-2 PTW).
> > > > > > +        */
> > > > > > +       if (!cpus_have_final_cap(ARM64_HAS_RAS_EXTN))
> > > > > > +               return true;
> > > > > > +
> > > > > > +       /* KVM owns the VNCR when the vCPU isn't in a nested co=
ntext. */
> > > > > > +       if (is_hyp_ctxt(vcpu) && (esr & ESR_ELx_VNCR))
> > > > > > +               return true;
> > > > > > +
> > > > > > +       /*
> > > > > > +        * Determining if an external abort during a table walk=
 happened at
> > > > > > +        * stage-2 is only possible with S1PTW is set. Otherwis=
e, since KVM
> > > > > > +        * sets HCR_EL2.TEA, SEAs due to a stage-1 walk (i.e. a=
ccessing the PA
> > > > > > +        * of the stage-1 descriptor) can reach here and are re=
ported with a
> > > > > > +        * TTW ESR value.
> > > > > > +        */
> > > > > > +       return esr_fsc_is_sea_ttw(esr) && (esr & ESR_ELx_S1PTW)=
;
> > > > >
> > > > > Should we include esr_fsc_is_secc_ttw? like
> > > > >   (esr_fsc_is_sea_ttw(esr) || esr_fsc_is_secc_ttw(esr)) && (esr &=
 ESR_ELx_S1PTW)
> > > >
> > > > Parity / ECC errors are not permitted if FEAT_RAS is implemented (w=
hich
> > > > is tested for up front).
> > >
> > > Ah, thanks for pointing this out.
> > >
> > > >
> > > > > > +}
> > > > > > +
> > > > > >  int kvm_handle_guest_sea(struct kvm_vcpu *vcpu)
> > > > > >  {
> > > > > > +       u64 esr =3D kvm_vcpu_get_esr(vcpu);
> > > > > > +       struct kvm_run *run =3D vcpu->run;
> > > > > > +       struct kvm *kvm =3D vcpu->kvm;
> > > > > > +       u64 esr_mask =3D ESR_ELx_EC_MASK  |
> > > > > > +                      ESR_ELx_FnV      |
> > > > > > +                      ESR_ELx_EA       |
> > > > > > +                      ESR_ELx_CM       |
> > > > > > +                      ESR_ELx_WNR      |
> > > > > > +                      ESR_ELx_FSC;
> > > > >
> > > > > Do you (and why) exclude ESR_ELx_IL on purpose?
> > > >
> > > > Unintended :)
> > >
> > > Will add into my patch.
> > >
> > > >
> > > > > BTW, if my previous statement about TTW SEA is correct, then I al=
so
> > > > > understand why we need to explicitly exclude ESR_ELx_S1PTW.
> > > >
> > > > Right, we shouldn't be exposing genuine stage-2 external aborts to =
userspace.
> > > >
> > > > > > +       u64 ipa;
> > > > > > +
> > > > > > +
> > > > > >         /*
> > > > > >          * Give APEI the opportunity to claim the abort before =
handling it
> > > > > >          * within KVM. apei_claim_sea() expects to be called wi=
th IRQs
> > > > > > @@ -1824,7 +1864,32 @@ int kvm_handle_guest_sea(struct kvm_vcpu=
 *vcpu)
> > > > > >         if (apei_claim_sea(NULL) =3D=3D 0)
> > > > >
> > > > > I assume kvm should still lockdep_assert_irqs_enabled(), right? T=
hat
> > > > > is, a WARN_ON_ONCE is still useful in case?
> > > >
> > > > Ah, this is diffed against my VNCR prefix which has this context. Y=
es, I
> > > > want to preserve the lockdep assertion.
> > >
> > > Thanks for sharing the patch! Should I wait for you to send and queue
> > > to kvmarm/next and rebase my v3 to it? Or should I insert it into my
> > > v3 patch series with you as the commit author, and Signed-off-by you?
> >
> > Friendly ping for this question, my v3 is ready but want to confirm
> > the best option here.
> >
> > Recently we found even the newer ARM64 platforms used by our org has
> > to rely on KVM to more gracefully handle SEA (lacking support from
> > APEI), so we would really want to work with upstream to lock down the
> > proposed approach/UAPI asap.
>
> Posted the VNCR fix which I plan on taking in 6.17. Feel free to rebase
> your work on top of kvmarm-6.17 or -rc1 when it comes out.

Thanks Oliver! I sent out v3 based on the VNCR fix here on top of the
current kvmarm/next.

>
> https://lore.kernel.org/kvmarm/20250729182342.3281742-1-oliver.upton@linu=
x.dev/
>
> Thanks,
> Oliver

