Return-Path: <linux-kernel+bounces-827625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CEEB923EA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8143AB793
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B4A3115BB;
	Mon, 22 Sep 2025 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ep3Mh3sQ"
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB88A3115B5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758558921; cv=none; b=Y9h8iCDsXaeel4Oy+9wM+DjuZCdOxvhdk7o3wDAbM878Eavxz9cbpWAln2kxEq19LFBrQsJx0zekEk+V0528mjh+P7ElhBw08wZrggjob09yEAiSkuIlj2dQ3iVyVd2fZfaIBzo7e9Kc69AiHnSMTO5ShYUaseNiiKiUhj/uZEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758558921; c=relaxed/simple;
	bh=sJZA5W8i8FsY6q8Pk9qSsL/tO9ihyOxw5JG0kLaL5NA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ba6nrKPkVSNu45zS6AdRvB02bJdI3FVd4HUowCVWJbU/dGMYNVOl3C6aX4C59ARbAeakwifw/t7pWrh1WZxAypmIbXwaw4B0XTSu6+qoDO0vOWSFaSgqiEVDBJaiIqVyhrT6v1qXOqjbL7yenuljKDkHDEAaSc0KrWJdfsufvQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ep3Mh3sQ; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-7900f7f4ba9so40059906d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758558918; x=1759163718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=maAo7eOe8o8YutYShD5omzBkIATahAgKdVnzIjAE84c=;
        b=BGgEn2RiEDEGLblsi7bsEof5QY2Jt5c8gHHRNNfUATc676S7O8swzHwbtZVttT0Lbh
         36UtPSMBBG4jUHB5dORaWoV8E/Kc1XXtX4rkLLWdNzWH9kC8oQnLhSSGiCtD3T2sOkUn
         5i9S61jEK+Fzrz5awYVSDtl6f8mF65FyKPY44ozqvfgtllp1aMweUfkdpHrd0vv8aGht
         4Cmob7uqZinxyBkN4dZGRHTI21IF0NhC4H/maCf4jz6IsgAj+RvQWnM7wX+AR37KSqMk
         IeC9N6dod83juLnWYmEqpg7bcM/sHXL3Yek2Nn4Lnxbuj8SVN6ytqejOk8Zq/N+nubV6
         h/+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhgq4MTnIdFC2e/C+uzxiAzz3ycq25rrzgFHykwJCFhZX64nT6s4opM53mGG6lLQzWvJLcXyR7CQW2aK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBjtI4ZYnJNC1Uqberh9OK204zaIicvCuJP8ec7AIu+xuiX9Mc
	t54oT9cQ1G1tRR+kRYDcqfvSDVvMCRkDfmUXfHvXSfL0Kx1fNnvA16V59eO2WTgKlZ/Rz41hV8s
	CPj7jthNl9AmB/6vZN2IeC6GwoqdEnAFjck+gRHuFaQCdasx7ras/QbM9j5xujPSrq++m4DcwiP
	dIURzu4gmAar0wby083vFe77dv3cWv6uy8r8j60d3U6nggwoSqiUdOfqIPS1gd9VDORZT/Z2iDx
	OQ0aughyAXOWyOGvOsy
X-Gm-Gg: ASbGncsCsYQxnfFcoXbr5TkVbStBJ9vicNblMxOE96QEXZY55T/RRYEAeujVim2BEee
	Rtv8knt7VYQABPpHrZ7t270SjZbQ75pWUx0sm0O+BVUNWcWaZqE/CeN9PJuBcl5CiCNsk4OMc4W
	rAMtBGo4d1brM/8Ny27RHKxhiQheNXPhl0RrNjpthGbuwDKbdzyJO2WMML3GVYzYUCtuHwsNq3Y
	nCkz9owunuAm0dhXmwrpKQ34m2mSihVmvgqcT8AsyUcej8QB1j2O8UmtSDHurpEN5obwkU64mCZ
	K92k/k7mwD0ghvlbtDU3fEPf/z0XVE18miYAbqqZ4ji6kGTcO6vwyH0GXjRNsdD3c3gX2eCnQQ0
	c38v7L3LY354X3IOO1fL2VkAqzGqwRqah2Ht1T1VNBsGxJBcaYffAFzqtkVX054mwQ1JXf0ctBg
	Rr
X-Google-Smtp-Source: AGHT+IFxgBXUKy/bBdYD1+GMxBQTSdDH0MrfQj4/YwFGyyXCIWJpdMf3g6xnHIhI9impMOjEQonJW7+kKJwe
X-Received: by 2002:a05:6214:2a88:b0:70d:6df4:1b21 with SMTP id 6a1803df08f44-7991e594e1cmr147277446d6.62.1758558918155;
        Mon, 22 Sep 2025 09:35:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-79352917cdasm7596056d6.43.2025.09.22.09.35.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Sep 2025 09:35:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-71d603bf1c4so45327207b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758558917; x=1759163717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maAo7eOe8o8YutYShD5omzBkIATahAgKdVnzIjAE84c=;
        b=Ep3Mh3sQraSgens7bZUWpoJzZDDh4lYbJZSx4VhVvWCq+F15ROVNDjw3g9b1BWwnzI
         PbZVqeFhIHXhDb8NZ5mAlrSeG4C0XRShTOtXG2fHfwOa+Ch/hPRrRCdJDFaNyX1znOJM
         zVemg76pxftu9i8W1KlJR8Q+bTQYexITg+pPE=
X-Forwarded-Encrypted: i=1; AJvYcCX5S2STTSkqTHHnwBLlelscJHhNSeYQq2VLKoLcb8C+SgI+iGRzfBAvT2CSf/ibeMOMfO26YOuaPWCcHOA=@vger.kernel.org
X-Received: by 2002:a05:690c:4c03:b0:721:3bd0:d5c0 with SMTP id 00721157ae682-73d222a3e42mr118281757b3.9.1758558917400;
        Mon, 22 Sep 2025 09:35:17 -0700 (PDT)
X-Received: by 2002:a05:690c:4c03:b0:721:3bd0:d5c0 with SMTP id
 00721157ae682-73d222a3e42mr118281367b3.9.1758558916916; Mon, 22 Sep 2025
 09:35:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920021024.847323-1-william.zhang@broadcom.com> <CAMm8Nh0oGokMDFt8ghomX1_SA3sbfv_xJVUXd2V1XeBA0OR08g@mail.gmail.com>
In-Reply-To: <CAMm8Nh0oGokMDFt8ghomX1_SA3sbfv_xJVUXd2V1XeBA0OR08g@mail.gmail.com>
From: William Zhang <william.zhang@broadcom.com>
Date: Mon, 22 Sep 2025 09:35:05 -0700
X-Gm-Features: AS18NWDDY16I_X8qmh0EBU9sMd591UP-PTflwsPGfCYMoggseyLlr2EinoIFL5E
Message-ID: <CAHi4H7HeEdmOx1xUDj81hY8qAeshFKjH52HyQhNATMYwwSbNhw@mail.gmail.com>
Subject: Re: [PATCH] ARM: module: fix unwind section relocation out of range error
To: Kursad Oney <kursad.oney@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org, song@kernel.org, 
	linus.walleij@linaro.org, florian.fainelli@broadcom.com, ardb@kernel.org, 
	anand.gore@broadcom.com, 
	Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>, 
	Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi Kursad,

On Mon, Sep 22, 2025 at 6:13=E2=80=AFAM Kursad Oney <kursad.oney@broadcom.c=
om> wrote:
>
> Hi William,
>
>
> On Fri, Sep 19, 2025 at 10:10=E2=80=AFPM William Zhang
> <william.zhang@broadcom.com> wrote:
> >
> > In an armv7 system that uses non-3G/1G split and with more than 512MB
> > physical memory, driver load may fail with following error:
> >    section 29 reloc 0 sym '': relocation 42 out of range (0xc2ab9be8 ->
> > 0x7fad5998)
> >
> > This happens when relocation R_ARM_PREL31 from the unwind section
> > .ARM.extab and .ARM.exidx are allocated from the VMALLOC space while
> > .text section is from MODULES_VADDR space. It exceeds the +/-1GB
> > relocation requirement of R_ARM_PREL31 hence triggers the error.
> >
> > The fix is to mark .ARM.extab and .ARM.exidx sections as executable so
> > they can be allocated within .text section and always meet range
> > requirement.
>
> Not "within" .text, but "along with" or "in close proximity to".
Yeah that is more accurate.  Will update.

>
> >
> > Co-developed-by: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: William Zhang <william.zhang@broadcom.com>
>
> I think a Fixes tag might be appropriate?
Yes, the change ac3b43283923 ("module: replace module_layout with
module_memory") does expose this issue. But I won't say that change
itself has a bug and it is more of an enhancement that this arm module
code has to handle different memory allocation scenarios.
>
> >
> > ---
> >
> >  arch/arm/kernel/module-plts.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plt=
s.c
> > index 354ce16d83cb..5f5bf5e63bd6 100644
> > --- a/arch/arm/kernel/module-plts.c
> > +++ b/arch/arm/kernel/module-plts.c
> > @@ -225,6 +225,18 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_=
Shdr *sechdrs,
> >                         mod->arch.init.plt =3D s;
> >                 else if (s->sh_type =3D=3D SHT_SYMTAB)
> >                         syms =3D (Elf32_Sym *)s->sh_addr;
> > +#if defined(CONFIG_ARM_UNWIND) && !defined(CONFIG_VMSPLIT_3G)
> > +               else if (s->sh_type =3D=3D ELF_SECTION_UNWIND ||
> > +                        (strncmp(".ARM.extab", secstrings + s->sh_name=
, 10) =3D=3D 0)) {
> > +                       /*
> > +                        * To avoid the possible relocation out of rang=
e issue for
> > +                        * R_ARM_PREL31, mark unwind section .ARM.extab=
 and .ARM.exidx as
> > +                        * executable so they will be allocated within =
.text section to meet
> > +                        * +/-1GB range requirement of the R_ARM_PREL31=
 relocation
> > +                        */
> > +                       s->sh_flags |=3D SHF_EXECINSTR;
> > +               }
> > +#endif
> >         }
> >
> >         if (!mod->arch.core.plt || !mod->arch.init.plt) {
> > --
> > 2.43.7
> >

