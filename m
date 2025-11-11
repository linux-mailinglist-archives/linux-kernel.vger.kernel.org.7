Return-Path: <linux-kernel+bounces-895865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EA9C4F236
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E02189A64B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9233730FE;
	Tue, 11 Nov 2025 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpziUyzC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC1F36A009
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762879991; cv=none; b=ju5e7lI1hJ4mUgGeerigSqO0+WHeOeYbEQA+nnDGNPndbb3B95j6LR87rdSku7eUWGjku1hvZDck05vEb5ITyNg0rKy5p4qAt1jdXAX+ATIDH7osoqGI2HG4InHN3uyIertx4agcXsoHi8D6GhhJ3RBlwzExChFBf9fDowarFKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762879991; c=relaxed/simple;
	bh=rIYhvW9MUiGbCKwyd24ZXCqEJm85VEPn9JwM2qTGJYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cCD0kdLGGtrZjnTSbL6hgacJRxdHuqo86GpuNndA1vhfIf2cmVo7nJzSnHF/7mhMd1jeT20Frgs3yqO6sj6Bd81rlUmepgKdluKn2A+9Qo+A3YIWfWTs3TsODj+r9oXXcaKk7qSkL8Ncv9KZcXC3pQ7CGrYM7MPljt8xry2JHtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpziUyzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF683C19424
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762879991;
	bh=rIYhvW9MUiGbCKwyd24ZXCqEJm85VEPn9JwM2qTGJYQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jpziUyzCYc6t1zftYqa4yrCjC10k3rucTYIa+RApM5uEXy598LXIAx4gL7Wk3t11x
	 +/8/7qcK0YOZXpXhKqTdH5E5KfY2N/R2fgNkQfKfZ563R+OUKKBLuI+ucHJ/Epq3ur
	 Rr0WAkK7nijSrqquVn3gzPNMMgTPzES/FzjG947NticGlpeIJAAw8vTGQTFhZYnPnh
	 LTyMNrc3XKQb0j4dwl5AUvfQvalaSrmFjzNEEvWKJGmy/iDXabOdZp0xqDZlMxlCvT
	 AWzxSisIdpcSR4d7TVx+Q9EW021tvF8WgHaEweV77Yy8WUrjgcJSspT2DbF0RzXFd/
	 MOT/HthnC+dJg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-37a33b06028so38396811fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:53:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1+2x+E58LOhSE7Ho2elLG4jCk6oQRPBIMnDFMZs4GLOBopxq5CW3tbLqWEtc48ZyBtkf4OKmnkjLBZ+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW0K8x5PFeha3TYF9ka4hzEXjsXOy1Wn01ezJ58xm4jKfway9S
	WfmJQJ0P6xO91d0vVZjTw1jsF6oTrjIQAGeOtNea190tmPyHC+rMEPAHBrFMzB4UTuwFFbsE2Xm
	RpUKoM2SsmsCYXaQ6oCBSAIZWQ0ldC48=
X-Google-Smtp-Source: AGHT+IErhlumRwKOijIaqN6phBHODr1C2zh2IndoF+0BKiBjjINyODKSfBYUPIkz2ZC9l1eUPqNxYJiOPmfDk6mwTZk=
X-Received: by 2002:a05:6512:1092:b0:594:2f72:2f92 with SMTP id
 2adb3069b0e04-59576df3242mr3362e87.5.1762879989285; Tue, 11 Nov 2025 08:53:09
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106173019.1224443-2-ardb+git@google.com> <20251107205020.GEaQ5bjLIU1Y7ePsJY@fat_crate.local>
In-Reply-To: <20251107205020.GEaQ5bjLIU1Y7ePsJY@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 11 Nov 2025 17:52:58 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG+R0_yShENKqQj4tfDmUqm6OPEoMTdWADnjLb+2QOOZQ@mail.gmail.com>
X-Gm-Features: AWmQ_bm_cUVAwmuyi_yulLFMIfhwaqD65bR10gsEni6jf3UihXuXdjuViSXP3Pg
Message-ID: <CAMj1kXG+R0_yShENKqQj4tfDmUqm6OPEoMTdWADnjLb+2QOOZQ@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/boot/compressed: Disable physical KASLR when
 memmap= appears
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	kees@kernel.org, Michal Clapinski <mclapinski@google.com>, Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Nov 2025 at 21:50, Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Nov 06, 2025 at 06:30:20PM +0100, Ard Biesheuvel wrote:
> > Reported-by: Michal Clapinski <mclapinski@google.com>
> > Reported-by: Chris Li <chrisl@kernel.org>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/boot/compressed/kaslr.c | 100 ++-----------------------------
> >  1 file changed, 6 insertions(+), 94 deletions(-)
>
> I love diffstats like that.
>
> How about this simplification ontop of yours:
>

Yes, better, although we should still clarify that only physical
randomization is affected.

> ---
>
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 96805d6c10a4..7875ae2d514e 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -67,8 +67,6 @@ static unsigned long get_boot_seed(void)
>  #define KASLR_COMPRESSED_BOOT
>  #include "../../lib/kaslr.c"
>
> -static bool memmap_found;
> -
>  /*
>   * Store memory limit: MAXMEM on 64-bit and KERNEL_IMAGE_SIZE on 32-bit.
>   * It may be reduced by "mem=nn[KMG]" command line options.
> @@ -165,9 +163,7 @@ static void handle_mem_options(void)
>                 if (!val && strcmp(param, "--") == 0)
>                         break;
>
> -               if (!strcmp(param, "memmap")) {
> -                       memmap_found = true;
> -               } else if (IS_ENABLED(CONFIG_X86_64) && strstr(param, "hugepages")) {
> +               if (IS_ENABLED(CONFIG_X86_64) && strstr(param, "hugepages")) {
>                         parse_gb_huge_pages(param, val);
>                 } else if (!strcmp(param, "mem")) {
>                         char *p = val;
> @@ -724,12 +720,6 @@ static unsigned long find_random_phys_addr(unsigned long minimum,
>         if (minimum + image_size > mem_limit)
>                 return 0;
>
> -       /* Check if memmap= appears on the command line */
> -       if (memmap_found) {
> -               debug_putstr("memmap= found on the command line, disabling physical KASLR\n");
> -               return 0;
> -       }
> -
>         /*
>          * During kexec handover only process KHO scratch areas that are known
>          * not to contain any data that must be preserved.
> @@ -783,6 +773,11 @@ void choose_random_location(unsigned long input,
>                 return;
>         }
>
> +       if (cmdline_find_option_bool("memmap")) {
> +               warn("KASLR disabled: 'memmap' on cmdline.");
> +               return;
> +       }
> +
>         boot_params_ptr->hdr.loadflags |= KASLR_FLAG;
>
>         if (IS_ENABLED(CONFIG_X86_32))
>
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

