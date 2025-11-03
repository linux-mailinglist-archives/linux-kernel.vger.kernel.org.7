Return-Path: <linux-kernel+bounces-883375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E6DC2D364
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8911898059
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B547231A545;
	Mon,  3 Nov 2025 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kwTwneeu"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947DA264614
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188271; cv=none; b=eXnQFBL95QeJosqMsH+rHTYKXrPahLc/MGzPNzxKCbWCAkD6jML8VoxuYZ2Yd55Th8jYFxR11s32SkeyYrmsYP5Qk/McpmChihT6XiVBYTYTijqOJun2BN/UrUAPcEeMsiFpYb1tzDuoNIKRu8EZJPqXO8bAlKNk8wZM295AhSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188271; c=relaxed/simple;
	bh=w2feD2ttgeXkYR55jPw9Y7SXgsX+KQU5PqxDgw8kmJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K4/2SxanJdVSi9nvhXE/0PQeeYg4/Hr3HmqlkhZMPrgqq1Pgj+sv+fu4gUlcY2meVkuAqP4p+aeFw0rYcVncgEIrzc1c+ZTzcmfaKgb8V0JWOHqmmJGifCi6ZgYaOpgdwyPXS7FuRdGi1pIAMUtmsPuahAu52mvLIBUvKmE3OI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kwTwneeu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-295c64cb951so212785ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762188269; x=1762793069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usZ/GjzUptuHMzqFuSlgFzDClkHAfq8dzjjPtBKSebs=;
        b=kwTwneeuOvqrvHonTtml9vbU+0ufkOsTpY+BGRIDM7SF52N42RLcjIsm3PUpZjxV+Q
         dddQ4wFULIVxkY5HN3pJMYN62EB1epgRbosPVlmNx7s4IsthwoTF/pMoNqELy0Pih+VY
         QmGwZPynqRjaiSM4HEJu+J4icnw3CI13tpxfDmii3Lg4JRkgN2Rrez2JuB7lart8D3Rq
         LuHg7xSx7+6TjqKHrd1uXmRN3NIGmflJF/c56d6VrU9viBxxVbLMPokHzrfTbKKH1GoV
         ub5jvqbkpR5S5LN2/xwivq9zZ/VHsmdKmwG6tzrj9yaZMJWUhrRYGGnP/CyqJVk4V/Gs
         3U3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188269; x=1762793069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usZ/GjzUptuHMzqFuSlgFzDClkHAfq8dzjjPtBKSebs=;
        b=QpQkfYO34yDhYctgya/ZZdl3uyegk23jST3s859MKq5qqJKU8FOX6Oy43rteF3m2RI
         2ZG5ExRrouOIUb9hc4XXuisSfbfF7z54BGcVKS8ytm2/g5T1FueerlwP2esD7Unmt7vZ
         XIIplEqD7Ah9/7DEG1nOYM8ya+KXxIMRoLXKC8at8N3HclmPKqnN12bsXn/s6xX6x27+
         VYPaM5YAAs+LX7jzqkkqb9w4Y66kMnaeBQwrvN+FQERKnuxd/gkyXqp0RzTp4IhUXUHo
         uvRcyn7hpl3MXRjRAc+12lw6aiR4TAC+t8GAvfveKDbzddQ8kZJXbHcWU0N7j/XN5ceZ
         eO0w==
X-Forwarded-Encrypted: i=1; AJvYcCW9GsHKNAjBdC9M7VUjUWBAyslGHOz+s7/nL+Z0H3Ur3l7hOIrWvwjXkjShOCormiowJ2xrGBQpHryivWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwICLyaO8p4NclKGu+Rum13sEiEv93y+I23pjMrxVB+2hdpZrzd
	RFb+JlpbIXCqUnqI6bCBts7RZ20n6B9pq/Oz/YDwn4ObnC+ZSqGcSPGY8GYiHj72/6SG+J+WPYx
	9F5U9dSIt3yaNw+Qm31fqkmX1ngfPSq773p8Xo5Nq
X-Gm-Gg: ASbGnctncA9zIfoye3sIeYn86i61o7I34kA1LJnUwZm+h1wxJ/hOkfctlmEqadPfsaS
	igA7kKXYRK2/d1JXDwP0wasVS3x2W7iWWo5Ie+UYfXe57KcUQx8uvgOESp6GDAKu+2pSZABze/N
	+mt0mlPRwsSohYmBNXCx3xCt46cOfYSMJO5K43CGSDOIE/WxUVmTN1BcJIfl50NTmbjMW1uQOOI
	k8kA8AxZ/xAPdwosC7QwoK8h4tZA9qGMcdJyM2EtBA1uF6s1ApACqmgvSzWgTzhP8tNq1JwGUtd
	ufunEo9Cb4vb/h6DKLBewMEqunpz
X-Google-Smtp-Source: AGHT+IFs+i74UEsPKiI4HBGk0AHRpY3oPKbKNmcPl4IvOaPQn9Rz7GlwRRaoVvhFaH16oJIE3DvbsmkRkuVoBFJNKRQ=
X-Received: by 2002:a17:902:e84d:b0:271:9873:80d9 with SMTP id
 d9443c01a7336-295f8cc34f0mr347465ad.7.1762188268555; Mon, 03 Nov 2025
 08:44:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901160930.1785244-1-pbonzini@redhat.com> <20250901160930.1785244-5-pbonzini@redhat.com>
 <CAGtprH-63eMtsU6TMeYrR8bi=-83sve=ObgdVzSv0htGf-kX+A@mail.gmail.com>
 <811dc6c51bb4dfdc19d434f535f8b75d43fde213.camel@intel.com>
 <ec07b62e266aa95d998c725336e773b8bc78225d.camel@intel.com>
 <114b9d1593f1168072c145a0041c3bfe62f67a37.camel@intel.com>
 <CAGtprH9uhdwppnQxNUBKmA4DwXn3qwTShBMoDALxox4qmvF6_g@mail.gmail.com> <3cc285fc5f376763b7a0b02700ac4520e95cf4d6.camel@intel.com>
In-Reply-To: <3cc285fc5f376763b7a0b02700ac4520e95cf4d6.camel@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Mon, 3 Nov 2025 08:44:16 -0800
X-Gm-Features: AWmQ_bnpejAZPjxey9qNJ4qVNIQOpviEighDn8xmxts_7VWMUGm00GjcWVLHS1I
Message-ID: <CAGtprH9jc9Xu83_K1g0dbTtPKYx=oODz8aeqbKOtpHYsAgg5yg@mail.gmail.com>
Subject: Re: [PATCH 4/7] x86/kexec: Disable kexec/kdump on platforms with TDX
 partial write erratum
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>, "Hansen, Dave" <dave.hansen@intel.com>, 
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "Williams, Dan J" <dan.j.williams@intel.com>, 
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>, 
	"dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>, 
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "Chatre, Reinette" <reinette.chatre@intel.com>, 
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"sagis@google.com" <sagis@google.com>, "Chen, Farrah" <farrah.chen@intel.com>, 
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "Gao, Chao" <chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 2:31=E2=80=AFAM Huang, Kai <kai.huang@intel.com> wr=
ote:
>
> On Mon, 2025-10-27 at 17:07 -0700, Vishal Annapurve wrote:
> > On Mon, Oct 27, 2025 at 2:28=E2=80=AFPM Huang, Kai <kai.huang@intel.com=
> wrote:
> > >
> > > On Mon, 2025-10-27 at 16:23 +0000, Edgecombe, Rick P wrote:
> > > > On Mon, 2025-10-27 at 00:50 +0000, Huang, Kai wrote:
> > > > > >
> > > > > > IIUC, kernel doesn't donate any of it's available memory to TDX=
 module
> > > > > > if TDX is not actually enabled (i.e. if "kvm.intel.tdx=3Dy" ker=
nel
> > > > > > command line parameter is missing).
> > > > >
> > > > > Right (for now KVM is the only in-kernel TDX user).
> > > > >
> > > > > >
> > > > > > Why is it unsafe to allow kexec/kdump if "kvm.intel.tdx=3Dy" is=
 not
> > > > > > supplied to the kernel?
> > > > >
> > > > > It can be relaxed.  Please see the above quoted text from the cha=
ngelog:
> > > > >
> > > > >  > It's feasible to further relax this limitation, i.e., only fai=
l kexec
> > > > >  > when TDX is actually enabled by the kernel.  But this is still=
 a half
> > > > >  > measure compared to resetting TDX private memory so just do th=
e simplest
> > > > >  > thing for now.
> > > >
> > > > I think KVM could be re-inserted with different module params? As i=
n, the two
> > > > in-tree users could be two separate insertions of the KVM module. T=
hat seems
> > > > like something that could easily come up in the real world, if a us=
er re-inserts
> > > > for the purpose of enabling TDX. I think the above quote was talkin=
g about
> > > > another way of checking if it's enabled.
> > >
> > > Yes exactly.  We need to look at module status for that.
> >
> > So, the right thing to do is to declare the host platform as affected
> > by PW_MCE_BUG only if TDX module is initialized, does that sound
> > correct?
>
> I was thinking something like this:
>
> https://lore.kernel.org/lkml/20250416230259.97989-1-kai.huang@intel.com/

This seems to be an important thing to make progress on. IMO,
disabling kexec/kdump even if the host doesn't plan to use TDX
functionality but wants to keep the build config enabled is a
regression.

I think explicitly doing TDX module initialization[1] ideally needs
something like the above series from Kai and possibly resetting the
PAMT memory during kexec/kdump at least on SPR/EMR CPUs. Otherwise
it's effectively impossible to enable CONFIG_INTEL_TDX_HOST and have
kexec/kdump working on the host even if no confidential workloads are
scheduled on such SPR/EMR hosts.

[1] https://lore.kernel.org/kvm/20251010220403.987927-4-seanjc@google.com/

