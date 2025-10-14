Return-Path: <linux-kernel+bounces-853370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D7DBDB6AC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800953B2284
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2834B270553;
	Tue, 14 Oct 2025 21:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QTLkkq5R"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96EF188596
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760477476; cv=none; b=uOj36DznGzcNAYW9c8hSlOqTG1h4e0l6XHkRyYxfJGgEAM2pZypen0n5GKfTEdoFx+PbmJ7Uh4zwCumdwGOJhLTM/GUXapECKd/1ZxEVwWJQYjrDVo7PlLEI7koeH5kIm9f9gavEgSPoE66Sulh4EhvpfT9UqCU41mxKdNpSWaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760477476; c=relaxed/simple;
	bh=LrZmi01dJi1077qM19aTvuOPrv0uFtTh2h5BEbeAeC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWnCVk1enQgZYz9haUYOtfrJZpHK+ro8laZuvQ6xKvQCS1I2mLt4ZCLAIgqbzs4z9LEJmiHDf0tFdig61AZWrVhVhycV6Pe/PBK+zNkKf+/bmXtGLBIeykZOI1LZL7C8W9WDerridFtaD/O/Rdq228Tx3v0wMtS6dnKIlzijNWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QTLkkq5R; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62fa84c6916so4756a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760477473; x=1761082273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/FvDDP5WuOibRVeq731Je4IWJQ6E0o70WTzZ9BRRjc=;
        b=QTLkkq5RqCHmZEpB1uYbVBAu04VYBLO5N9KVAKJMIngJRF4DY1Bcx28PCLW1r7N4wr
         RalQpKae5tc48amqxVAmIS5kLSDva6wP6jDtTuMqq9M0ieVVHLDJC6OfgWAydZZiIBgx
         JsOZJONHODizvHncFBt11+fmsTuqCGHMjAw6b1330JpV21K1GsGE2sGvn8b9xjnt7n4/
         RH8USYo1qgIWSTKJJshqbIniny/X15Zl8cd/7N2JuSn74CnAl2jUCqlAYHj7l4D+Qi4C
         9MaLlzWs7Nxdv7mWfp7NKwMswr/zgb5u3kfBBaacq9Jk88yVbaAftRjCcWikwlueNSIu
         VJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760477473; x=1761082273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/FvDDP5WuOibRVeq731Je4IWJQ6E0o70WTzZ9BRRjc=;
        b=SyeSr7rICRxVHZA6/BNXEOVfoQp2NP/fPENbhXFhtlDJwk1UTxzMa4YOsUtExQM4JA
         ajXAaTqMmdAHV0J+4kXLnRKQFZQGSU7gUmY/IUtmrMqFrFp5LiimbMXLyo93XIlgkaBF
         naHnmETKCQz02vFTE+wMYh9uF34mAPU2YqktpEzKJaQ0t0lJanuQI1LT3OkJgHpWPkcV
         vo4//UjKtyONetNZTM/dTKmvyOgwqce8AFq6e2gVS9/VMZAa/pu2xYoDdZgdHX4FygM7
         9N4YsCZr5U1x/+jkURZlhSYlBN7C3eftO7ucruNfex+iNxngqad5a2UFYDGSNy4vvPKJ
         ClyA==
X-Forwarded-Encrypted: i=1; AJvYcCUzLrFaMBt7pvO1uEjw+rS/PYgDoRmiksgEtl77zsqsJkSaFQxV4VdG4HgSPlIMjPARbnsp10UGv/WyWGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Bc5vxfGKmKRXChoiwtmNNJXDs6NdGv/oiNidfPWmpOZekFS+
	3RB/O0XBsdqn5xujDYysg+jfune3TNZ1EBGtpzeNjtqpROKTthgS9rabjOTMkVIYv2Ah6WZWELY
	02IUXVzprytlcOKvQXnGqAwdX+ws9BrReSBMs+PBZ
X-Gm-Gg: ASbGncscNICD0WOniHH2YIPTry5AAOSb4XeliGpHqBlg7ZgHRiTSiE94VdcYcjHuBhI
	hL4bIy8h4MHKA0OtOP/SNZi7jP/aLRYrE46jaKqEX/Kg2NYHU9V2ETeckaHaZh7YxnABF2Qhatz
	YOOBJlCJY8LEpy3pKdkxCAkUbx7Tz9N2mv68yaXLKQy+lkaIRiH44bSPxTcBxmysWwzZY6ZmuuN
	EhgoDgKfhv8KQKDGmj1JFcfG2+M3UdX
X-Google-Smtp-Source: AGHT+IFubOLyGfccp18VZ2iaf0m+asVedjW2o/+sCbHyBLQervH8mVm0W9qfdbV6tz5CEk3AQlyqFoxyixCHo65zN5Q=
X-Received: by 2002:a05:6402:2791:b0:62f:a20d:5a92 with SMTP id
 4fb4d7f45d1cf-63bebfe10cemr33165a12.4.1760477472887; Tue, 14 Oct 2025
 14:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009223153.3344555-1-jmattson@google.com> <20251009223153.3344555-3-jmattson@google.com>
 <aO1-IV-R6XX7RIlv@google.com> <CALMp9eRQZuDy8-H3b8tbdZVQSznUK9=yhuBV9vBFAQz3UP+iRg@mail.gmail.com>
 <aO6-CbTRPp1ZNIWq@google.com>
In-Reply-To: <aO6-CbTRPp1ZNIWq@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 14 Oct 2025 14:31:00 -0700
X-Gm-Features: AS18NWD-jYwuNGiS5wI0FbvoxP7Ig0Kad9858TMaa3GVHF-gmRGAKkG6XV-DCyY
Message-ID: <CALMp9eRJaO9z=u5y0e+D44_U_FH1ye2s+cHNHmtERxEe+k2Dsw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] KVM: SVM: Don't set GIF when clearing EFER.SVME
To: Sean Christopherson <seanjc@google.com>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 2:18=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Oct 14, 2025, Jim Mattson wrote:
> > On Mon, Oct 13, 2025 at 3:33=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Thu, Oct 09, 2025, Jim Mattson wrote:
> > > > Clearing EFER.SVME is not architected to set GIF.
> > >
> > > But it's also not architected to leave GIF set when the guest is runn=
ing, which
> > > was the basic gist of the Fixes commit.  I suspect that forcing GIF=
=3D1 was
> > > intentional, e.g. so that the guest doesn't end up with GIF=3D0 after=
 stuffing the
> > > vCPU into SMM mode, which might actually be invalid.
> > >
> > > I think what we actually want is to to set GIF when force-leaving nes=
ted.  The
> > > only path where it's not obvious that's "safe" is toggling SMM in
> > > kvm_vcpu_ioctl_x86_set_vcpu_events().  In every other path, setting G=
IF is either
> > > correct/desirable, or irrelevant because the caller immediately and u=
nconditionally
> > > sets/clears GIF.
> > >
> > > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > > index a6443feab252..3392c7e22cae 100644
> > > --- a/arch/x86/kvm/svm/nested.c
> > > +++ b/arch/x86/kvm/svm/nested.c
> > > @@ -1367,6 +1367,8 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
> > >                 nested_svm_uninit_mmu_context(vcpu);
> > >                 vmcb_mark_all_dirty(svm->vmcb);
> > >
> > > +               svm_set_gif(svm, true);
> > > +
> > >                 if (kvm_apicv_activated(vcpu->kvm))
> > >                         kvm_make_request(KVM_REQ_APICV_UPDATE, vcpu);
> > >         }
> > >
> >
> > This seems dangerously close to KVM making up "hardware" behavior, but
> > I'm okay with that if you are.
>
> Regardless of what KVM does, we're defining hardware behavior, i.e. keepi=
ng GIF
> unchanged defines behavior just as much as setting GIF.  The only way to =
truly
> avoid defining behavior would be to terminate the VM and completely preve=
nt
> userspace from accessing its state.

This can't be the only instance of "undefined behavior" that KVM deals
with. What about, say, misaligned accesses to xAPIC memory?

