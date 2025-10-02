Return-Path: <linux-kernel+bounces-840482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD71BB485B
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242663A685F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F342264B7;
	Thu,  2 Oct 2025 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCeLyZX7"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CB11922FB
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422247; cv=none; b=d9JlI5nQDkhCTQwaMajm4oFCkZ0lMfD37hSyA8LdeN3lU13cve5ocW8K2ty+Ce/tm5nPiT0q2+URrYcZRrATk0neVtaDKMOb8iLxqA5cUUzXqasHivUYNC2iOr3ERtnw78BMuXIF0CVcFDGlIQrHnAgTs2tm+4ih/NZ0GIqrPXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422247; c=relaxed/simple;
	bh=g1zbr69PihA8U/R5ZsVBHF4NB4xtbv/ks2CXP+0Ptts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXzNeVIO9uiVcWY9gf5s42VR2Gsh/2FhcdbvUsi8u0TXQXpPzSlmUocKw/fGKuWRTLt+QfhFEiS4WBF/DH+NxDlqlPzGiV7AHCZMpMt5Zrnvf3X72YTMYDx6Oa9azznQOCB+B3HqnrdBTl6z1LsfJY+TybnYTw1T0OcBMkydnL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCeLyZX7; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3352018e050so1247997a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759422245; x=1760027045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FG4UbihUbbBb4GvGu6r2xMfearc0gtsGkbk+C+0xE2o=;
        b=jCeLyZX7EjbLA2hrUeCjqs8arBCpmEpsFbdAs+xEXZgFvF0/exz2uz2/jXylYwcXYo
         88BPAVj3rhV8j/LLOEBvdO9f5v5gEeLz/2DBPm9LwruFrKhtFmX5mfs6R7VARI5fxr8U
         M+/8qYx8XFRcEf71RIddRDn7qtUKS9ucX0b+ncUKb+bkoIQnn6rnYt7MfgTqbOgcDpaa
         xegbfJqVJzXX+vdgxL87ZpCK6p3Ski8bliFS3bvqzWAk6/4BnPVKJxhn+kZ9rmlxrqeC
         vkofMYVX6pq/bIeKR42UeBMNQ6yctTpAI5GRi8UVE7jkc+UmdDQ6eA60zZLU6a9APRTl
         FYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759422245; x=1760027045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FG4UbihUbbBb4GvGu6r2xMfearc0gtsGkbk+C+0xE2o=;
        b=nsRfPeSH++Vzfm1QBdtFntyoRtubBIiQEbeDkXyOOEQhAuHDE38aDq2ljgFxTcbm+G
         GGi1WRIjVczcz00Z1YL2luFOJNPjqX0tAo+LmoX2Do00vYQPASzACpfLB96VbUzF5AlN
         58ttbckcIfFy9JNh9ajzbEOdxLmcixgmMcr+hJ3FOEdFLZGEU/2wHtEPese8IRzLdyAS
         j1ObPRtC1frjfUs70lCpxtMMnwM0HevkzgTXjdvmBKCIDU0mXts3VJROipD/d9q8hjCv
         CeiGIYD6i3LL77CdkhbXrT6FG3InP0e0JXqP/rW3QR796nIzzShxgVLWbXVPp7706lL6
         jDfA==
X-Forwarded-Encrypted: i=1; AJvYcCW70Onu4IaJ0LF8KsfWEYnXYm+MV44b6wKwYBxl+/jXQm8LhZAuT35Y25ZBdi/potSmC3Gd0GcqM98H/Rc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAKV9f4dINeyB2ffuOe7TW62Fzk3q+8Wmf7mdc0IV/dM4D30kU
	xNO6W3vYsgNGJxdSarexGLzJgKC6PrvK8d4/a8eLNsih9X5uTlQaCxF0s85YaVbNeAigcrZDc8r
	BxgvUv8PYYd0z38sMoCXgz4ymTwVTCFU=
X-Gm-Gg: ASbGncu66MEEUApGUWBCs0+M7QNzkgUR/Wd7pGIIIYPi6k6jvvGNpBJKYxWzzRKeSmJ
	83VGl0LV9uMnM9e7GCT4ypi4T3p+7jcqlnRbN95bWT2GZ0x1eiKMfsqv3mjHoGNcEWDS+rNi0iA
	/wVCcG9kcjOVQmYtRpgM/pLrECtNq1tn8+oSdmqnVDhyJtpJY/cuhP7UomltSxfNW+Tz8nCo1tl
	mm7CDyevqQbhX/z4Mb9HqTn/C3gPOs=
X-Google-Smtp-Source: AGHT+IEvL2rOVyKEurjPCyNZ8bAYpWhfsrSOgGDEbic0Qar3tiz/lZDZg2G/FyqIR7ysbptk3YJBSCysa8pVQY4OV+E=
X-Received: by 2002:a17:90b:1b50:b0:32b:bac7:5a41 with SMTP id
 98e67ed59e1d1-339a6f78db8mr10173373a91.37.1759422244837; Thu, 02 Oct 2025
 09:24:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820-riscv-altn-helper-wip-v1-0-c3c626c1f7e6@iscas.ac.cn> <20250820-riscv-altn-helper-wip-v1-2-c3c626c1f7e6@iscas.ac.cn>
In-Reply-To: <20250820-riscv-altn-helper-wip-v1-2-c3c626c1f7e6@iscas.ac.cn>
From: ChaosEsque Team <chaosesqueteam@gmail.com>
Date: Thu, 2 Oct 2025 12:29:02 -0400
X-Gm-Features: AS18NWBy6l9AZ0sUiCbnZdHynQXPVRh8RBVZN4pNdo2bGD2DCQPVJ1Ix8nPZDM8
Message-ID: <CALC8CXdigEV4KWOv9-WOknxt8RD29mamBAUkw=5dDN_zeC7v6w@mail.gmail.com>
Subject: Re: [PATCH 2/6] riscv: pgtable: Convert to use_alternative_unlikely
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Vivian Wang <uwu@dram.page>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I see you have a woman's name "Vivian": so am I to assume you are one
of the beloved "trannies" linus threw all the MAMALLLLEEE hackers (who
helped him from 1993-2003...2008) for? Or are China-wumans just more
competent than whites?

On Wed, Aug 20, 2025 at 9:51=E2=80=AFAM Vivian Wang <wangruikang@iscas.ac.c=
n> wrote:
>
> Use use_alternative_unlikely() to check for RISCV_ISA_EXT_SVVPTC,
> replacing the use of asm goto with ALTERNATIVE.
>
> The "unlikely" variant is used to match the behavior of the original
> implementation using ALTERNATIVE("nop", "j %l[svvptc]", ...).
>
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> ---
>  arch/riscv/include/asm/pgtable.h | 15 +++++++--------
>  arch/riscv/mm/pgtable.c          | 22 ++++++++++------------
>  2 files changed, 17 insertions(+), 20 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index 91697fbf1f9013005800f713797e4b6b1fc8d312..81eb386da837f064c7372530e=
2f2227575a703d3 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -495,8 +495,13 @@ static inline void update_mmu_cache_range(struct vm_=
fault *vmf,
>                 struct vm_area_struct *vma, unsigned long address,
>                 pte_t *ptep, unsigned int nr)
>  {
> -       asm goto(ALTERNATIVE("nop", "j %l[svvptc]", 0, RISCV_ISA_EXT_SVVP=
TC, 1)
> -                : : : : svvptc);
> +       /*
> +        * Svvptc guarantees that the new valid pte will be visible withi=
n
> +        * a bounded timeframe, so when the uarch does not cache invalid
> +        * entries, we don't have to do anything.
> +        */
> +       if (use_alternative_unlikely(0, RISCV_ISA_EXT_SVVPTC))
> +               return;
>
>         /*
>          * The kernel assumes that TLBs don't cache invalid entries, but
> @@ -508,12 +513,6 @@ static inline void update_mmu_cache_range(struct vm_=
fault *vmf,
>         while (nr--)
>                 local_flush_tlb_page(address + nr * PAGE_SIZE);
>
> -svvptc:;
> -       /*
> -        * Svvptc guarantees that the new valid pte will be visible withi=
n
> -        * a bounded timeframe, so when the uarch does not cache invalid
> -        * entries, we don't have to do anything.
> -        */
>  }
>  #define update_mmu_cache(vma, addr, ptep) \
>         update_mmu_cache_range(NULL, vma, addr, ptep, 1)
> diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
> index 8b6c0a112a8db4e91de54c3bd3bd527a605a6197..e0c414fa0d433fdc39c80ec39=
0c467ca59a9a334 100644
> --- a/arch/riscv/mm/pgtable.c
> +++ b/arch/riscv/mm/pgtable.c
> @@ -9,8 +9,16 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
>                           unsigned long address, pte_t *ptep,
>                           pte_t entry, int dirty)
>  {
> -       asm goto(ALTERNATIVE("nop", "j %l[svvptc]", 0, RISCV_ISA_EXT_SVVP=
TC, 1)
> -                : : : : svvptc);
> +       if (use_alternative_unlikely(0, RISCV_ISA_EXT_SVVPTC)) {
> +               if (!pte_same(ptep_get(ptep), entry)) {
> +                       __set_pte_at(vma->vm_mm, ptep, entry);
> +                       /* Here only not svadu is impacted */
> +                       flush_tlb_page(vma, address);
> +                       return true;
> +               }
> +
> +               return false;
> +       }
>
>         if (!pte_same(ptep_get(ptep), entry))
>                 __set_pte_at(vma->vm_mm, ptep, entry);
> @@ -19,16 +27,6 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
>          * the case that the PTE changed and the spurious fault case.
>          */
>         return true;
> -
> -svvptc:
> -       if (!pte_same(ptep_get(ptep), entry)) {
> -               __set_pte_at(vma->vm_mm, ptep, entry);
> -               /* Here only not svadu is impacted */
> -               flush_tlb_page(vma, address);
> -               return true;
> -       }
> -
> -       return false;
>  }
>
>  int ptep_test_and_clear_young(struct vm_area_struct *vma,
>
> --
> 2.50.1
>
>

