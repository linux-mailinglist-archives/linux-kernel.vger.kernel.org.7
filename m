Return-Path: <linux-kernel+bounces-748877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85877B14716
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 06:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD111189F0F0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 04:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D36220F4C;
	Tue, 29 Jul 2025 04:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmX1Ef+P"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC106126F0A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 04:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753762635; cv=none; b=HRLkmXmLvkAtEZSFPW4jOBkSc5S+9QxnLFjjtZA5hnrOTWb5Wm2MGvbYZMYSIaioQMa/1MIpvZDH7d9VAGGOy4RpyDu9W5TFvaCvUISdw2XjiZQXfxbz8gx4+HvHzm4vqEv5X1804b8kRTQGxkMN4+DnG0lQE0azbQlPzV3vLD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753762635; c=relaxed/simple;
	bh=WCgqgD4fKpyBS97qlpo7ocaqmNNlLUD/cRFaClGGi/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mUsDLUi7nQMwhHCVqcs9JybMqSiE91Q24+PUsteUx+liCnI8Q9PvYVto46/0GDrA4LALQKiuR2SFdl+fSQGJODr7BE7fwM8b17YD6DuAerxSbNh3SZBJ9WLT2zJ94x1ERvMA2jeFp7tPr/aw624oFeCA43Wl5WvJLXoihQg9KFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmX1Ef+P; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-41b7d1240d8so1930175b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 21:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753762632; x=1754367432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNLbOHqgEt1SbO6Tjq1iIaZdqSSy0ent5yRbkUG/EBc=;
        b=NmX1Ef+Pub8RSZv5G6E0y2tkPfNHAKmLXuzRsDzm3P/SgAKfwsaCo4pTGIGVW6GoLY
         /K+ttjmj5pbxKDTB2d09BT8iBfPbJBxX6XUHNowtOn7REeFrUpbM4G3Jxkf4nCyPW5ec
         O96yRbyc5D60izkinefUJHM6SmCrL6BfbAEI8wjF4TubpAFrVpW+V43t51H5rIdxNTUF
         De7fdUd0NQ38xSns9pNp6AJNIxmz6XjRCHwV0BVwl15U03Zjqd2BtbCZ3usPj5azWgRT
         faAgFli5iWsrqotUdFhLRGhjjYc9GuQ0yizEfZBdo+S+xXmAeFvc/ddqKZBmSAZU3lNa
         Nwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753762632; x=1754367432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNLbOHqgEt1SbO6Tjq1iIaZdqSSy0ent5yRbkUG/EBc=;
        b=fsMIBvBta8NbQci9TkpFgYvdhsHf2rqzQexZ8ZTn/rV/0NmUSwIaxHMVssC65IW/Eh
         urnlrlsLjoout2puD2MADV+wZHXCP7GV9jRaM6BSuiyPRXgzJPdjWp8V6Zk5isRjkjiZ
         H1O4+ZzD8jzjfRh3soBtLJijw40Q0+g3f4rf1gwLO5yaCl7f31uU4ExMyKGnna5Vfs2m
         4BOvMUb/nYzgc+PY6rkgaN2Uy8q4e4PWQgH45BeXa5d6NI2LqA1kB2XR/BaFmctCF2rv
         U2M06MH1tSmgeiTvGGCaF+wtdwI8nUeSFUwkrygmNtUZezCL8vo4ZManImq9sqXY3e22
         oCTA==
X-Forwarded-Encrypted: i=1; AJvYcCVbRBP/xbKCCIkKLwIEliZXBTmhmGxDqvGB7qyYrXjjOLTtIre/uh0bIWJcAvZfhknmPKqx0Gf3A3p5Gmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsvTNWw1rCjNB+Of55VdxPzzUjxIj2zqqNfaxhgR8tIyLdENZe
	QyaTcyFr6y/wEZyCFLFFQ+elmYyPffWlC20YsfYpFZKJnVq/UwwQ1fUZ+gGm8ve1lc8OCYzQbM5
	FLBMnWTgzZ0fVF2GzHhwedAMcQCFI8kg=
X-Gm-Gg: ASbGncsUueq0Ge1zMLx/MZ/59EYIpNfK3SaGIpqFJ8Yb7mF93QjiBva8VvC0l35FZLq
	K2Ep4HMxMS4replwsQd2Uge8RIMOeL8AaSszn4qdi2weI98MpwC8hgzaWUoRZWhHbQb/K6OcHgW
	cTebMqR8tDXbtUtm1OvqnGIqUlydlKh3L+FEsTPjZiNZ87TypJi/0Imzl/W5G74slaIRqCFCTI6
	0BrTqXV
X-Google-Smtp-Source: AGHT+IE2iVhvoVUI4WD9TksZUQ8mafderIzzAthb51jW9QtuLXEvyBFidwc4tkovmHWyLA1RdE/oPNRuQPMitpyVh6I=
X-Received: by 2002:a05:6808:144c:b0:40c:f680:89e5 with SMTP id
 5614622812f47-42bb9d09e16mr8456399b6e.28.1753762631693; Mon, 28 Jul 2025
 21:17:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728180923.160966-1-suchitkarunakaran@gmail.com> <a1044e00-8e61-4de5-b22a-3878920e471a@intel.com>
In-Reply-To: <a1044e00-8e61-4de5-b22a-3878920e471a@intel.com>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Tue, 29 Jul 2025 09:47:00 +0530
X-Gm-Features: Ac12FXx1vkiz3k3XgXRqkUXmwBzeIKtVeNFaRenjX1eppnpJO5KQoyJva_c_W8M
Message-ID: <CAO9wTFiQLLTFcTew+ymC85m8dNLu_KcJOYj9vu2ke0fcUYW-Cw@mail.gmail.com>
Subject: Re: [PATCH] x86/intel: Fix always false range check in x86_vfm model matching
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, darwi@linutronix.de, 
	peterz@infradead.org, ravi.bangoria@amd.com, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Jul 2025 at 00:26, Sohil Mehta <sohil.mehta@intel.com> wrote:
>
> On 7/28/2025 11:09 AM, Suchit Karunakaran wrote:
> > Fix a logic bug in early_init_intel() where a conditional range check:
> >     (c->x86_vfm >=3D INTEL_P4_PRESCOTT && c->x86_vfm <=3D INTEL_P4_WILL=
AMETTE)
> > was always false due to (PRESCOTT) being numerically greater than the
> > upper bound (WILLAMETTE). This triggers: -Werror=3Dlogical-op:
> > logical =E2=80=98and=E2=80=99 of mutually exclusive tests is always fal=
se
> > The fix corrects the constant ordering to ensure the range is valid:
> >     (c->x86_vfm >=3D INTEL_P4_WILLAMETTE && c->x86_vfm <=3D INTEL_P4_PR=
ESCOTT)
> >
>
> Thank you for reporting this issue!
>
> This is indeed a bug, but the resolution proposed here seems incorrect.
>
> > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> > ---
> >  arch/x86/kernel/cpu/intel.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> > index 076eaa41b8c8..3ec1555cbdc3 100644
> > --- a/arch/x86/kernel/cpu/intel.c
> > +++ b/arch/x86/kernel/cpu/intel.c
> > @@ -262,7 +262,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
> >       if (c->x86_power & (1 << 8)) {
> >               set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
> >               set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
> > -     } else if ((c->x86_vfm >=3D INTEL_P4_PRESCOTT && c->x86_vfm <=3D =
INTEL_P4_WILLAMETTE) ||
> > +     } else if ((c->x86_vfm >=3D INTEL_P4_WILLAMETTE && c->x86_vfm <=
=3D INTEL_P4_PRESCOTT) ||
> >                  (c->x86_vfm >=3D INTEL_CORE_YONAH  && c->x86_vfm <=3D =
INTEL_IVYBRIDGE)) {
> >               set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
> >       }
>
> See commit fadb6f569b10 ("x86/cpu/intel: Limit the non-architectural
> constant_tsc model checks")
>
> The original check that this replaced is:
>
>         if ((c->x86 =3D=3D 0xf && c->x86_model >=3D 0x03) ||
>                 (c->x86 =3D=3D 0x6 && c->x86_model >=3D 0x0e))
>                 set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
>
> The first check is supposed to cover all P4 models starting with model 3
> (INTEL_P4_PRESCOTT). In order to set an upper bound for Family 15, the
> check should cover all models until model 6 (INTEL_P4_CEDARMILL) which
> is the last model released in that family.
>
> The error that I made was to use an incorrect upper bound. The actual
> fix should be this:
>
> s/INTEL_P4_WILLAMETTE/INTEL_P4_CEDARMILL
>
> > @@ -262,7 +262,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
> >         if (c->x86_power & (1 << 8)) {
> >                 set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
> >                 set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
> > -       } else if ((c->x86_vfm >=3D INTEL_P4_PRESCOTT && c->x86_vfm <=
=3D INTEL_P4_WILLAMETTE) ||
> > +       } else if ((c->x86_vfm >=3D INTEL_P4_PRESCOTT && c->x86_vfm <=
=3D INTEL_P4_CEDARMILL) ||
> >                    (c->x86_vfm >=3D INTEL_CORE_YONAH  && c->x86_vfm <=
=3D INTEL_IVYBRIDGE)) {
> >                 set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
> >         }
>
> Also, please add a
> Fixes: fadb6f569b10 ("x86/cpu/intel: Limit the non-architectural
> constant_tsc model checks")
>

Thanks for reviewing. I'll send a v2 patch with the suggested changes.

