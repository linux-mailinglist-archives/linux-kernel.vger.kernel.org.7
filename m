Return-Path: <linux-kernel+bounces-749163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8735EB14AD6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E4017A8EC2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4062874E6;
	Tue, 29 Jul 2025 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgopZ0Z8"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F377A286D7F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780254; cv=none; b=f+VOgBQopkGGRV5ODrpk62QEsqRWUTZqOi8Y2DDHm8K5bl5DcVErJfiFMCnqkd28T6qyQF27Z8awdU757VskjF4As6jrLYZo3YZhC7zaLrbRMgV9dxnx6P9Ji0s8pPslT9S78YOD7OuAvbThcu9quECjc6LOlXl4lu+Ru8q1CQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780254; c=relaxed/simple;
	bh=wk5XZ9Xoesnwv7BpUoCcwRfupjsCE7OBDZgYxGgI/rQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKhglrtm9GVj583sPZCOle/lCt9zANA2vsZTv2dNDxTUDx0hzqbOlJLM2/Ql+NWfQqoaUfQY9ibIF3z/vrNi7duGkINWWpyNP8LZ2YQXxaP9JOc9lSL2QdV0KHRLDkAtL6LhAnDXtQI6Y/Djq50fgsXqL0Xvhnt3kYCs6Jiel30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgopZ0Z8; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-61591e51092so2654938eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 02:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753780252; x=1754385052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVgUoy1pfAxiiccKL1EGeyDQmYYL5g4stylxxDaAc4I=;
        b=RgopZ0Z8m4WACoAlJUXgfYN8vkb9OyTU357UTJ5S4yuaLAbWPNvGe+uSwnoVbYWU+q
         kxJR69xqpUJrX9Gu9rvVwYwGg31CWfKrxmCiO+pLc7oA0thxBOiqJ0nBCksXNT9n5VHB
         tjH7DcsIkmddzY3zMLpENhCkXjt+4zJuhkUAkt1x/CFyxQzL0WP8zorEWLfUM7OIjmMR
         tqHMDbrbtRHtcIkcilLz4F2JeV7H2E/iI/N8W++7wlnmWY15j7ZhhlftSWZY7hPWXgDZ
         bl7bQG18R+fK7hIiOa6XW1td2Lau5A4z8Hi+P2VpcrrmOMu+XjqPOe54ECf2+o33kK56
         AvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753780252; x=1754385052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVgUoy1pfAxiiccKL1EGeyDQmYYL5g4stylxxDaAc4I=;
        b=kgpu4/5laLVeAZZKwUXCOuhbvqGRaQOcQX14X75JufvSnxPK7KcRALhxvHnNYP+rKG
         B1zTWiDZCbQzvdHWvKxkggiWjGOR6dGanKKEr55gJAZmL06Keq8621D0vwG8IBeEp6r2
         ErYpHpQwu37I+x5OEu1o/wJmVRLCOrnv6cGGhCGsmz4NgAjCusw+s4NqKwfKXum6T+bj
         wq1z5uDGMCptb5Uu5AbKPpvUQ9QV1zjnDi4XjtqFXe0lGb056SMtackk1yhsEF8emqSe
         aEq6uy5q1dD+lUB3HGEBJlAwfHrLfIzPLqS3E/9SWRqrdYIzmwu0sXDrR5stWJSX0Nti
         667w==
X-Forwarded-Encrypted: i=1; AJvYcCVld+p+LsNXT26GE1ImDrww+rQ3BvNPYzlsleIExOiXb9dlNUlxcle90S0wWzqnu62oS93aTYy5Nii/2mc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz8gcT5Rkrvj0xHLdf2/TQDxQHWtL2RnDOpHWM4baZ373u/iuW
	9UNQ7ClhudC2meaTEStZjxOvhZqIGNqlwMnV0d7+/HxFOenC9aaaP6eqYaBqI2RrxTzH4TFdb2/
	a5Mh8qUqVUdoMc8qFM4cXesb7UWMlBcOUlidLAJ+F5A==
X-Gm-Gg: ASbGncupPR/L/PiSomZA47I1p2ZGpT3pSdL2vYkUHhWHm4kCniGFd78DUqoFQZsqEBY
	dhD8oI/NLix7lW+iWuNVjDPqrrC/8s2TLuk+qpiF+vEFpOOiZrNz5/G4r61RMXXfyY9tynwHN8Q
	Vm/XXPwMgPR448dGFleD86meCnmOxNx0b2bqXj3YN06PfP068EUuJ8Ud50DbIAHhoTOOVaRjAp3
	0ub6MjO
X-Google-Smtp-Source: AGHT+IHrd6bOJN9L9i0wLAqStU6H0dOMIJiEcqH+r6EB0PtjIexDMQjYqPbwW8PCSfB99TZ/+c2XmdSCGs73XLWqcKw=
X-Received: by 2002:a05:6871:ea86:b0:2ff:92c6:51f6 with SMTP id
 586e51a60fabf-30701ffd2admr8099650fac.15.1753780251834; Tue, 29 Jul 2025
 02:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729042621.6403-1-suchitkarunakaran@gmail.com>
 <2025072925-lint-agreement-77e8@gregkh> <CAO9wTFg_jCUZ+DxXVDM11_715r6ALJ=HyRXkcBxhGrBUo4iVUg@mail.gmail.com>
 <2025072931-recount-stifling-73e8@gregkh> <CAO9wTFj1qCkhNG24hAWDfZqoJy4mhPFf6mKp=jg7GnaLmHix-w@mail.gmail.com>
 <2025072947-laziness-unlikable-e0f3@gregkh>
In-Reply-To: <2025072947-laziness-unlikable-e0f3@gregkh>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Tue, 29 Jul 2025 14:40:40 +0530
X-Gm-Features: Ac12FXwzdH2V2A5JwFiJLqVmS_WZQ4xv5WIo5FkdR20FIcyNONhvA_yMIZUZjG0
Message-ID: <CAO9wTFixNE8F23-29WCHB_b+WadyU+J_rcA-=Od5TOJg2+hGOQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/intel: Fix always false range check in x86_vfm
 model matching
To: Greg KH <gregkh@linuxfoundation.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, darwi@linutronix.de, 
	sohil.mehta@intel.com, peterz@infradead.org, ravi.bangoria@amd.com, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Jul 2025 at 14:31, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 29, 2025 at 02:24:43PM +0530, Suchit Karunakaran wrote:
> > On Tue, 29 Jul 2025 at 13:26, Greg KH <gregkh@linuxfoundation.org> wrot=
e:
> > >
> > > On Tue, Jul 29, 2025 at 12:23:27PM +0530, Suchit Karunakaran wrote:
> > > > On Tue, 29 Jul 2025 at 10:58, Greg KH <gregkh@linuxfoundation.org> =
wrote:
> > > > >
> > > > > On Tue, Jul 29, 2025 at 09:56:21AM +0530, Suchit Karunakaran wrot=
e:
> > > > > > Fix a logic bug in early_init_intel() where a conditional range=
 check:
> > > > > > (c->x86_vfm >=3D INTEL_P4_PRESCOTT && c->x86_vfm <=3D INTEL_P4_=
WILLAMETTE)
> > > > > > was always false due to (PRESCOTT) being numerically greater th=
an the
> > > > > > upper bound (WILLAMETTE). This triggers:-Werror=3Dlogical-op:
> > > > > > logical =E2=80=98and=E2=80=99 of mutually exclusive tests is al=
ways false
> > > > > > The fix corrects the constant ordering to ensure the range is v=
alid:
> > > > > > (c->x86_vfm >=3D  INTEL_P4_PRESCOTT && c->x86_vfm <=3D INTEL_P4=
_CEDARMILL)
> > > > > >
> > > > > > Fixes: fadb6f569b10 ("x86/cpu/intel: Limit the non-architectura=
l
> > > > > > constant_tsc model checks")
> > > > > >
> > > > > > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> > > > > >
> > > > > > Changes since v1:
> > > > > > - Fix incorrect logic
> > > > > > ---
> > > > > >  arch/x86/kernel/cpu/intel.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/=
intel.c
> > > > > > index 076eaa41b8c8..6f5bd5dbc249 100644
> > > > > > --- a/arch/x86/kernel/cpu/intel.c
> > > > > > +++ b/arch/x86/kernel/cpu/intel.c
> > > > > > @@ -262,7 +262,7 @@ static void early_init_intel(struct cpuinfo=
_x86 *c)
> > > > > >       if (c->x86_power & (1 << 8)) {
> > > > > >               set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
> > > > > >               set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
> > > > > > -     } else if ((c->x86_vfm >=3D INTEL_P4_PRESCOTT && c->x86_v=
fm <=3D INTEL_P4_WILLAMETTE) ||
> > > > > > +     } else if ((c->x86_vfm >=3D  INTEL_P4_PRESCOTT && c->x86_=
vfm <=3D INTEL_P4_CEDARMILL) ||
> > > > > >                  (c->x86_vfm >=3D INTEL_CORE_YONAH  && c->x86_v=
fm <=3D INTEL_IVYBRIDGE)) {
> > > > > >               set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
> > > > > >       }
> > > > > > --
> > > > > > 2.50.1
> > > > > >
> > > > > >
> > > > >
> > > > > Hi,
> > > > >
> > > > > This is the friendly patch-bot of Greg Kroah-Hartman.  You have s=
ent him
> > > > > a patch that has triggered this response.  He used to manually re=
spond
> > > > > to these common problems, but in order to save his sanity (he kep=
t
> > > > > writing the same thing over and over, yet to different people), I=
 was
> > > > > created.  Hopefully you will not take offence and will fix the pr=
oblem
> > > > > in your patch and resubmit it so that it can be accepted into the=
 Linux
> > > > > kernel tree.
> > > > >
> > > > > You are receiving this message because of the following common er=
ror(s)
> > > > > as indicated below:
> > > > >
> > > > > - You have marked a patch with a "Fixes:" tag for a commit that i=
s in an
> > > > >   older released kernel, yet you do not have a cc: stable line in=
 the
> > > > >   signed-off-by area at all, which means that the patch will not =
be
> > > > >   applied to any older kernel releases.  To properly fix this, pl=
ease
> > > > >   follow the documented rules in the
> > > > >   Documentation/process/stable-kernel-rules.rst file for how to r=
esolve
> > > > >   this.
> > > > >
> > > > > If you wish to discuss this problem further, or you have question=
s about
> > > > > how to resolve this issue, please feel free to respond to this em=
ail and
> > > > > Greg will reply once he has dug out from the pending patches rece=
ived
> > > > > from other developers.
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h's patch email bot
> > > >
> > > > Hi Greg,
> > > > I've a question regarding backporting this fix. Can this fix be
> > > > backported to stable kernel version 6.15.8? Also, should I send the
> > > > backport patch only after the initial patch has been merged in
> > > > mainline or linux-next?
> > >
> > > Did you read the document that my bot linked to above?  It should ans=
wer
> > > those questions :)
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Hi Greg,
> > I did go through the document you linked. I just wanted to clarify
> > about the backporting process, especially since the merge window has
> > already started and it might take some time for this to be merged into
> > mainline. Regardless, I'll send the backport patch after the initial
> > one has been merged.
>
> As the document states, a commit must be in Linus's tree first, before
> we can consider it for any stable release.
>
> thanks,
>
> greg k-h

Hi Greg,
Thank you for the clarification. I now understand that a commit must
be in Linus's tree before it can be considered for any stable release.
I apologize for the repeated questions and any inconvenience.

Thanks,
Suchit

