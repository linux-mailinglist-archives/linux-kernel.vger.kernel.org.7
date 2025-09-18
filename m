Return-Path: <linux-kernel+bounces-797146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA60B40C6C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F901B21A0D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DBE3469F6;
	Tue,  2 Sep 2025 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="skl7ea3t"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A861732F761
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756835360; cv=none; b=tiuorJyD+Lb03rRov3XmDDTOMMboQqITg3DiB52motrR5AwmNEVkmAAozw6GAqCsYKFO9xkLOR5pKanyf54GIHzzBCF8JTJQJOLkKvt49ovGP+ekPfK/hM6bQaSw0ge8id13sYjl3JbDp1o08BY5qiQsti13Rd98054geswREks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756835360; c=relaxed/simple;
	bh=hcbhKZ17EeJO3SWow8Okj30nk495SpAvxrMcWVans/k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AT0kR41YGMlhtG3STiQYb3lLrv87tErHDA9XSyirL9GzD3aBTSdOcUaHuOzTkTSRlPD4PwS/oKpBlbmAO1bTfQB6ayAYscn/9j/+M+EPSnqcVPA01Q0s7kBrin6aCD7fOFp6SkQYoCxX2CfYzFPF2xcRyrzhlnC73sD+6Y4wAhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=skl7ea3t; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-324e4c3af5fso6004767a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 10:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756835358; x=1757440158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zSO7jaOk19fIWzcYW+aJjISQBTaLHOWQKWeX3X09SOM=;
        b=skl7ea3tXZQriYa/S35ONs8IOePdhAhWzYiS1VWC+Su5Shl1Ede7INfT0KsuMZ6/SG
         MtHeQZSX1gD6yQGx5Hs/Gazuk/iJuqNYccy/W6L3OSAHVfoq+DMEiwIff5vJ8NUq1ja1
         IZNL2kn8tyC8bSxcELmeI2dAzr0t2x7D/JZsfwN5tJdzi/8ucaHBx/w6LTPfIRuIv1KD
         NMcfRNURqqeEIg3e+5bIzImp5ff6XnojKxiz9FZJiGqlf8fVDqFkZx9Fj963rJmx4Bfn
         dInLvZUo6Znc+fFbm2AxjXu7/irBIFZpnVMdbWu87iOhyoBeuIO5LVshwy7lYvLfVOto
         ensA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756835358; x=1757440158;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zSO7jaOk19fIWzcYW+aJjISQBTaLHOWQKWeX3X09SOM=;
        b=tbkYnjS50XQQg78EPLM+x88wiZtpF3nB+9p107zn1cGHr/GOCaG/oOrjV0BtSAgeWm
         yVd1mvT4Jm/BAwneFmJPebnB5/U3bEdM2wyugYKnWxx4P1BINIZ3PIhbCcUXickgVl/9
         5eQMHvHw51fesGwjQX8AgqgOorpRu2pOeNwSH04xFOz3TGZ03E9jGGRr29+g8r3LF1GT
         qywc3qzFeYKNnBumjBobYFDokxZRPCsc6kTrTHW/SYCJZbQqq/4lIFx+d82qBCjZuAWl
         wenProb8ENGSaRHDTsS8IUniakSEDUMmOc49Fztpw/9lnwm64Ag/7fSSg30yzN1UPUiQ
         PkZA==
X-Forwarded-Encrypted: i=1; AJvYcCUI+rbbDh3Ii4vrjEMKc6QOvmf9uDBs7Coits5WvSffDDPgAIdu0Wc1jyGXP7O67p7+BoLMBVdapAxxQaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDZDqUHI6HW0ZGWiEGkqccj+xycN3pF5MknPuMbLn5Rcl/iS/P
	xPHH0awaC1EzbpQFqh3BjbilXLmsQ+VX9QO6OJnsGMYXsAsp/jwg5uwO4WSb2hvgpiYkO8gan8p
	GM0krJw==
X-Google-Smtp-Source: AGHT+IHAPfrxcoNu7KEuhW+xGkd3lhV3j/aHSv9GnE32OYH26Xp7BsiPC3oWimbVRwOHdPeiqle1WA/KIsg=
X-Received: from pjbsp14.prod.google.com ([2002:a17:90b:52ce:b0:30a:7da4:f075])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d08:b0:327:b01c:4fd4
 with SMTP id 98e67ed59e1d1-328154148demr13971862a91.2.1756835357893; Tue, 02
 Sep 2025 10:49:17 -0700 (PDT)
Date: Tue, 2 Sep 2025 10:49:16 -0700
In-Reply-To: <d74ff3c1c70f815a10b8743647008bd4081e7625.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <fdcc635f13ddf5c6c2ce3d5376965c81ce4c1b70.camel@infradead.org>
 <01000198cf7ec03e-dfc78632-42ee-480b-8b51-3446fbb555d1-000000@email.amazonses.com>
 <aK4LamiDBhKb-Nm_@google.com> <e6dd6de527d2eb92f4a2b4df0be593e2cf7a44d3.camel@infradead.org>
 <aLDo3F3KKW0MzlcH@google.com> <ea0d7f43d910cee9600b254e303f468722fa355b.camel@infradead.org>
 <54BCC060-1C9B-4BE4-8057-0161E816A9A3@amazon.co.uk> <caf7b1ea18eb25e817af5ea907b2f6ea31ecc3e1.camel@infradead.org>
 <aLIPPxLt0acZJxYF@google.com> <d74ff3c1c70f815a10b8743647008bd4081e7625.camel@infradead.org>
Message-ID: <aLcuHHfxOlaF5htL@google.com>
Subject: Re: [PATCH v2 0/3] Support "generic" CPUID timing leaf as KVM guest
 and host
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paul Durrant <pdurrant@amazon.co.uk>, Fred Griffoul <fgriffo@amazon.co.uk>, 
	Colin Percival <cperciva@tarsnap.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Graf (AWS), Alexander" <graf@amazon.de>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 02, 2025, David Woodhouse wrote:
> On Fri, 2025-08-29 at 13:36 -0700, Sean Christopherson wrote:
> > =C2=A0
> > > This does mean userspace would have to set the vCPU's TSC frequency a=
nd
> > > then query the kernel before setting up its CPUID. And in the absence
> > > of scaling, this KVM API would report the hardware TSC frequency.
> >=20
> > Reporting the hardware TSC frequency on CPUs without scaling seems all =
kinds of
> > wrong (which another reason I don't like KVM shoving in the state).=C2=
=A0 Of course,
> > reporting the frequency KVM is trying to provide isn't great either, as=
 the guest
> > will definitely observe something in between those two.
>=20
> Yes, on CPUs that don't support TSC scaling, we should not attempt to
> advertise a frequency.
>=20
> Where I said 'in the absence of scaling' I meant modern CPUs but where
> the VMM just didn't ask for TSC scaling.
>=20
> > > I guess the API would have to return -EHARDWARETOOSTUPID if the TSC f=
requency
> > > *isn't* the same across all CPUs and all power states, etc.
> >=20
> > What if KVM advertises the flag in KVM_GET_SUPPORTED_CPUID if and only =
if the
> > TSC will be constant from the guest's perspective?=C2=A0 TSC scaling ha=
s been supported
> > by AMD and Intel for ~10 years, it doesn't seem at all unreasonable to =
restrict
> > the feature to somewhat modern hardware.=C2=A0 And if userspace or the =
admin knows
> > better than KVM, then userspace can always ignore KVM and report the fr=
equency
> > anyways.
>=20
> I hadn't put it in KVM_GET_SUPPORTED_CPUID; I was following the lead of
> the existing Xen leaf support, where *if* userspace provides that leaf,
> KVM will dynamically correct the values in it.
>=20
> The problem is that KVM_GET_SUPPORTED_CPUID is a *system* ioctl on the
> bare /dev/kvm device, isn 't it?

Yep.

> So even if a VMM has set the TSC frequency VM-wide with KVM_SET_TSC_KHZ
> instead of doing it the old per- vCPU way, how can it get the results for=
 a
> specific VM?

I don't see any need for userspace to query per-VM support.  What I'm propo=
sing
is that KVM advertise the feature if the bare metal TSC is constant and the=
 CPU
supports TSC scaling.  Beyond that, _KVM_ doesn't need to do anything to en=
sure
the guest sees a constant frequency, it's userspace's responsibility to pro=
vide
a sane configuration.

And strictly speaking, CPUID is per-CPU, i.e. it's architecturally legal to=
 set
per-vCPU frequencies and then advertise a different frequency in CPUID for =
each
vCPU.  That's all but guaranteed to break guests as most/all kernels assume=
 that
TSC operates at the same frequency on all CPUs, but as above, that's usersp=
ace's
responsibility to not screw up.

