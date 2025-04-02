Return-Path: <linux-kernel+bounces-585638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 084FFA795AB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 21:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3544018909C8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 19:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870761E1A32;
	Wed,  2 Apr 2025 19:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dSemILLf"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ECC139CF2
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 19:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743621166; cv=none; b=XFFsDuTfDdiwj9Y8WkWi2s8TKBI5tcsLH97K7d+faAI1tBCyoPivNOU0KN4uUGmYX9PF4cmUcUUT0hjnrOuKqutRA1kfijODF3pnXWIeVKO8db48Ypy5uep4ZnYxL8RT6m0ToPL7F5NMDM9/lkrKovnRNeHdeFAsoO4kkButnBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743621166; c=relaxed/simple;
	bh=aK3VBx6NA3jZwfdsrWRY2dRnu0FqhUszgGEOWyV+h3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnOh8ujwU3URH9qxqWwDzyLqzl2iObP6h2vHDqcBbEr2a7hW4PkyAxOU/dOB4dD5VAwCaVxipqFBQt/KacPsZyucSy8OF3pwf5P/8jYHSi3Z/UqfT89ICcZNAuwdhr0mMJmAYYIxXiH1Cx/uhOMoIbLbw9UlTNeTGGWRVQSXepc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dSemILLf; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5241abb9761so75629e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Apr 2025 12:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743621164; x=1744225964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufQZbME7cCWTlfUFUJg7J87wZvmjwZWF7BNQvB4L4UM=;
        b=dSemILLfNIW/FM82DNZXVSC3qICyNFkkE+6rNsHtXVXd7Dv3mTir70nsib4C+F5iwl
         tvVpZyScNrY/axWTeHN4GWQEdPCfuPEyCFzVmzUQ9lig2MkdSZfOGXe+NbXjvPco1wOW
         OVBmcNdVFZbOamSpYERZ4S+QoDacmOYj0cuvOGNXL5mJf7BfDXkL+Okw7Eaa6MyjMl2A
         wWG06UyGve+FNyAoWwb0CW74YKLTZjuY5DvH7kVrr9C+Vi/tWnQ8jjdTinfxS+ufHaRG
         FtozX7OOSZ2OOsnU/TU93s3riaDcJzo2b8Eaz4u62TTRUubWqUz9EWFvEah5ovkGM4Ke
         JNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743621164; x=1744225964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufQZbME7cCWTlfUFUJg7J87wZvmjwZWF7BNQvB4L4UM=;
        b=I/x+PHEfsw2aqcCRCx5SUq5rl64MpYUse93xzZkma9w13tb08okAcqTb7BBKyvB/Ke
         D5G1xf/CNd6Bq7zGPqlckbHDKa90m7RTZ2/Aitb3vqzaoSx+6U20xzOYd+Hh5gax0HeP
         l+fy82xpIc3O6a/IZgvXwdfhSpgSohXTaDMJj+YymntGvBrkHtoZglTxwbf7cE1Z9NyJ
         0YMZt1a8CAtz51Bzqt5nLFLrVXeSkCgQEQ4Xa2UrM8zGb43aQEqWDo7RkqhR7xxLgTDV
         bLxOtDLBmYyLUp+WcGnHoZFb0SOnwn+Xw7me3WpqfWqPGJFAdicVUUHmybMPkCTyGugS
         4Uhg==
X-Forwarded-Encrypted: i=1; AJvYcCXUb6wO+9Aeul35j2/kgoBXwP/U595J3N9AkxGeiWqEIK7fxfV+HE9SAZ8hujk3sD0EO/bMh1YIJZloKz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQFVyMYnTZXT+CdpDeSu0Tjp3wDtGmNX3pHKf+9u5+Wdy/c/Ni
	VrSF0cEGqJADH6DAiHAGQIvOhK0Lu0YliBdynoN96pbzgUu+SGNLvHsu8Xvmw4hyXrkK8i8Rg8m
	XbVo8VqcjrrUjMx3DEybu7CsuqS4mg6OeNzbMbg==
X-Gm-Gg: ASbGnctQhsv6y9YJvurJxwLXFtV66mwm+BaeU46lZXbKCw1juRhegzFRUF5k5zvN5LS
	7OjQ57TCeR6iSwOgp52W6rR7nvyCS8zWA9jLT2Vx76+IilGD6Eb6r7VdJZxyBvZklf1zM9XGkJg
	P/XdfIdX076EqrtRg4cEL/sDVJCk+CayVxVENhGQW3tvbs+hwzsHD95+4dgdo=
X-Google-Smtp-Source: AGHT+IHwLcsi3BX8Jz57ZZBx4yNh0gsPGUL4LlIBXdD4VmESoE42IUlvk+9eP+LcFYoQddReWmd77wMhRr7Yoibb+IA=
X-Received: by 2002:a05:6122:a07:b0:518:a261:adca with SMTP id
 71dfb90a1353d-5261d4759bcmr11728250e0c.8.1743621163716; Wed, 02 Apr 2025
 12:12:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313135003.836600-1-rppt@kernel.org> <20250313135003.836600-11-rppt@kernel.org>
 <20250402140521-bf9b3743-094e-4097-a189-10cdf1db9255@linutronix.de>
 <Z-0xrWyff9-9bJRf@kernel.org> <20250402145330-3ff21a6b-fb03-4bc8-8178-51a535582c6f@linutronix.de>
 <20250402181842-f25872a1-00f7-4a8f-ae6d-3927899ee3a6@linutronix.de>
In-Reply-To: <20250402181842-f25872a1-00f7-4a8f-ae6d-3927899ee3a6@linutronix.de>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 3 Apr 2025 00:42:32 +0530
X-Gm-Features: ATxdqUEPLfNJB2FSv1nTGKqf_ZE3BXsv2R3C6KxSgMELRNHzW7jhhAvjwROmbyc
Message-ID: <CA+G9fYuM3XR3yMD9qwubGUYTFazpCAzK4kBw33Lagsw2HBQfhA@mail.gmail.com>
Subject: Re: [PATCH v2 10/13] arch, mm: set high_memory in free_area_init()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, 
	"David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Apr 2025 at 22:01, Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> On Wed, Apr 02, 2025 at 03:07:51PM +0200, Thomas Wei=C3=9Fschuh wrote:
> > On Wed, Apr 02, 2025 at 03:46:37PM +0300, Mike Rapoport wrote:
> > > On Wed, Apr 02, 2025 at 02:19:01PM +0200, Thomas Wei=C3=9Fschuh wrote=
:
> > > > (drop all the non-x86 and non-mm recipients)
> > > >
> > > > On Thu, Mar 13, 2025 at 03:50:00PM +0200, Mike Rapoport wrote:
> > > > > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > > > >
> > > > > high_memory defines upper bound on the directly mapped memory.
> > > > > This bound is defined by the beginning of ZONE_HIGHMEM when a sys=
tem has
> > > > > high memory and by the end of memory otherwise.
> > > > >
> > > > > All this is known to generic memory management initialization cod=
e that
> > > > > can set high_memory while initializing core mm structures.
> > > > >
> > > > > Add a generic calculation of high_memory to free_area_init() and =
remove
> > > > > per-architecture calculation except for the architectures that se=
t and
> > > > > use high_memory earlier than that.
> > > >
> > > > This change (in mainline as commit e120d1bc12da ("arch, mm: set hig=
h_memory in free_area_init()")
> > > > breaks booting i386 on QEMU for me (and others [0]).
> > > > The boot just hangs without output.
> > > >
> > > > It's easily reproducible with kunit:
> > > > ./tools/testing/kunit/kunit.py run --arch i386
> > > >
> > > > See below for the specific problematic hunk.
> > > >
> > > > [0] https://lore.kernel.org/lkml/CA+G9fYtdXHVuirs3v6at3UoKNH5keuq0t=
pcvpz0tJFT4toLG4g@mail.gmail.com/
> > > >
> > > >
> > > > > diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
> > > > > index 6d2f8cb9451e..801b659ead0c 100644
> > > > > --- a/arch/x86/mm/init_32.c
> > > > > +++ b/arch/x86/mm/init_32.c
> > > > > @@ -643,9 +643,6 @@ void __init initmem_init(void)
> > > > >                 highstart_pfn =3D max_low_pfn;
> > > > >         printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
> > > > >                 pages_to_mb(highend_pfn - highstart_pfn));
> > > > > -       high_memory =3D (void *) __va(highstart_pfn * PAGE_SIZE -=
 1) + 1;
> > > > > -#else
> > > > > -       high_memory =3D (void *) __va(max_low_pfn * PAGE_SIZE - 1=
) + 1;
> > > > >  #endif
> > > >
> > > > Reverting this hunk fixes the issue for me.
> > >
> > > This is already done by d893aca973c3 ("x86/mm: restore early initiali=
zation
> > > of high_memory for 32-bits").
> >
> > Thanks. Of course I only noticed this shortly after sending my mail.
> > But this usecase is indeed broken on mainline.
> > Some further bisecting lead to the mm merge commit being broken, while =
both its
> > parents work. That lead the bisection astray.
> > eb0ece16027f ("Merge tag 'mm-stable-2025-03-30-16-52' of git://git.kern=
el.org/pub/scm/linux/kernel/git/akpm/mm")
> >
> > As unlikely as it sounds, it's reproducible. I'll investigate a bit.
>
> The issue is fixed with the following diff:

I have applied this patch,

>
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 284154445409..8cd95f60015d 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2165,7 +2165,8 @@ static unsigned long __init __free_memory_core(phys=
_addr_t start,
>                                  phys_addr_t end)
>  {
>         unsigned long start_pfn =3D PFN_UP(start);
> -       unsigned long end_pfn =3D PFN_DOWN(end);
> +       unsigned long end_pfn =3D min_t(unsigned long,
> +                                     PFN_DOWN(end), max_low_pfn);
>
>         if (start_pfn >=3D end_pfn)
>                 return 0;
>
>
> Background:
>
> This reverts part of commit 6faea3422e3b ("arch, mm: streamline HIGHMEM f=
reeing")
> which is the direct child of the partially reverted
> commit e120d1bc12da ("arch, mm: set high_memory in free_area_init()").
> The assumptions the former commit became invalid with the partial revert =
the latter.
>
> This bug only triggers when CONFIG_HIGHMEM=3Dn. When mm was branched from=
 mainline
> the i386 configuration generated by kunit ended up with CONFIG_HIGHMEM=3D=
y.
> With some recent changes in mainline the kunit configuration switched to
> CONFIG_HIGHMEM=3Dn, triggering this specific reproducer only when mm got =
merged
> into mainline again.
>
> New kunit reproducer:
> ./tools/testing/kunit/kunit.py run --arch i386 example --timeout 10 --kco=
nfig_add CONFIG_HIGHMEM=3Dn
>
> Does this sound reasonable?  If so I'll send a patch tomorrow.
>
> @Naresh, could you test this, too?

I have applied the proposed fix patch and tested.
The boot test and LTP smoke test pass.

Links:
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/naresh/tests/2vBZg=
uDGiZclS394TDRdwW61twC

>
>
> Thomas

