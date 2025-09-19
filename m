Return-Path: <linux-kernel+bounces-824791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAF6B8A274
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2E63A6596
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451D73148D7;
	Fri, 19 Sep 2025 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xy7CI/gi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D4730DEA7
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294084; cv=none; b=I+hVsBlKtrXVwvR3ZRCy6DsWUK0V1BVV8kv+7ed1O2dLRpv1Hr94IjuPj6ZlFUl2JL8daUQWcOIX6vkghmEVVLtldtC5OiQSLqx0ZqqHUDtCo2CTe8PTCqrEC/4IVn1Mn5F147OShza09mJDym1Z0wbek7Rj3ZooAcGNabEh3JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294084; c=relaxed/simple;
	bh=saE+P8goRmOxpFQW3uWKh8mknX6g84clIecZEkZdkuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+EiIo1sIfXGlMH++sSQbh5J79F7+MQsNCeI3rRowFwBkKAYXrRJVnCNur/atwN4TPJEc6QMyYDdqwurzitZ7OZRmJLP4CPGxKXJfkrZqHkP3s46fvxZy89EfIcU+G1aAK5VPgLWUcVztGDtxWXAD4rIfihzlxBr0gbU4FyFolQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xy7CI/gi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1AFC4CEF9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758294083;
	bh=saE+P8goRmOxpFQW3uWKh8mknX6g84clIecZEkZdkuI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xy7CI/giaaaBvJWRDCSy9L6ftAHnAg6Gqy4+JwmD+scZSxbnlgwqQRINUPWzJEzF2
	 rpi4FDWBqO4aNJGdJIjgG6/wg2zyE9gBbuLEoXTxIzmbsD4RmKQFU2wgsLgUrPbzXT
	 Bq7gNPLx+Y6YL3gqnuVGk8nNhjVv7U0nKm1joiOK16soR398CHmn+kgo+BrBg+5k1R
	 xs1G6ux7LqtknGv2urqi3RsZxJEm3xruXPUZT+cqVlOWzDUMDgZXDTQOcWSnHbCMKy
	 eQinIFNiLRzFZ+sOFal+7tWJcQbhKgRLbiq4hxErHJ3F1Kk0IXx7RpX9q9skpSWpEC
	 r7YgxskivslgQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-560888dc903so2522803e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:01:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXhE4dkhyKjT01Tl9pMvU51ddvX5qfsrVvkwOYe4ADPPVSBKHAJTqgggCfoMWnXlVfWUxuPZbXa1WUkyhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr7ba/65NQ9wnr0d8VhgxY/iQsuXjyLHZuE8h5+RDnH1OWA/11
	LwBMcuEsBrU0valCpNe6/xUGso27014+TE59Zug6zryEThL6jgBC8jOVcdw7dJn4XDklOIxTmHa
	Yf8TrWMN52w70axGTW5zrAgIMLzWfnQ0=
X-Google-Smtp-Source: AGHT+IGXT7xaqc0MehSYJATRk3j62bszDZlJ0+REGqc7MOVjw7hPH0tRwYf2DbMtCBLbqWw090Xrj/qth/5cVerp7FI=
X-Received: by 2002:ac2:5f1b:0:b0:55b:8afb:e644 with SMTP id
 2adb3069b0e04-579e375ca38mr1096947e87.31.1758294081307; Fri, 19 Sep 2025
 08:01:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919122321.946462-1-abarnas@google.com> <20250919122321.946462-3-abarnas@google.com>
In-Reply-To: <20250919122321.946462-3-abarnas@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 19 Sep 2025 17:01:09 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGaT5Kf9=v0rSxW5TB__vDN=iPK7=+gDNBO=vTPrd_4Zg@mail.gmail.com>
X-Gm-Features: AS18NWC-Kn0GPVDh-zCsx0l7aHJimokOHFMUz7N4ftIprt3RNfvD9-Lo50sjvYY
Message-ID: <CAMj1kXGaT5Kf9=v0rSxW5TB__vDN=iPK7=+gDNBO=vTPrd_4Zg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arch: arm64: Reject modules with internal alternative callbacks
To: =?UTF-8?Q?Adrian_Barna=C5=9B?= <abarnas@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Dylan Hatch <dylanbhatch@google.com>, Mark Rutland <mark.rutland@arm.com>, 
	Fanqin Cui <cuifq1@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On Fri, 19 Sept 2025 at 14:23, Adrian Barna=C5=9B <abarnas@google.com> wrot=
e:
>
> During module loading, check if there is a callback function used by the
> alternatives specified in the '.altinstruction' ELF section and block
> loading the module if such a function is present.
>

Why?

AIUI, the issue being addressed is the fact that we cannot yet execute
code from the module itself when alternatives are being applied, and
so the callback must live in the core kernel, or in another module.

So this is a really big hammer, given that it disallows all callback
alternatives, including ones that we could easily support.

I don't object to the approach per se, but please explain why this
solution is reasonable (after you've explained the problem)



> Reported-by: Fanqin Cui <cuifq1@chinatelecom.cn>
> Closes: https://lore.kernel.org/all/20250807072700.348514-1-fanqincui@163=
.com/
> Signed-off-by: Adrian Barna=C5=9B <abarnas@google.com>
> ---
>  arch/arm64/include/asm/alternative.h |  4 ++--
>  arch/arm64/kernel/alternative.c      | 15 ++++++++++-----
>  arch/arm64/kernel/module.c           |  8 ++++++--
>  3 files changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/as=
m/alternative.h
> index 00d97b8a757f..6eab2517c809 100644
> --- a/arch/arm64/include/asm/alternative.h
> +++ b/arch/arm64/include/asm/alternative.h
> @@ -26,9 +26,9 @@ void __init apply_alternatives_all(void);
>  bool alternative_is_applied(u16 cpucap);
>
>  #ifdef CONFIG_MODULES
> -void apply_alternatives_module(void *start, size_t length);
> +int apply_alternatives_module(void *start, size_t length);
>  #else
> -static inline void apply_alternatives_module(void *start, size_t length)=
 { }
> +static inline int apply_alternatives_module(void *start, size_t length) =
{ }
>  #endif
>
>  void alt_cb_patch_nops(struct alt_instr *alt, __le32 *origptr,
> diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternat=
ive.c
> index 8ff6610af496..69fae94c843a 100644
> --- a/arch/arm64/kernel/alternative.c
> +++ b/arch/arm64/kernel/alternative.c
> @@ -139,15 +139,18 @@ static noinstr void clean_dcache_range_nopatch(u64 =
start, u64 end)
>         } while (cur +=3D d_size, cur < end);
>  }
>
> -static void __apply_alternatives(const struct alt_region *region,
> -                                bool is_module,
> -                                unsigned long *cpucap_mask)
> +static int __apply_alternatives(const struct alt_region *region,
> +                               bool is_module,
> +                               unsigned long *cpucap_mask)
>  {
>         struct alt_instr *alt;
>         __le32 *origptr, *updptr;
>         alternative_cb_t alt_cb;
>
>         for (alt =3D region->begin; alt < region->end; alt++) {
> +               if (ALT_HAS_CB(alt) && is_module)
> +                       return -EPERM;

Nit: is EPERM the appropriate error code here?

> +
>                 int nr_inst;
>                 int cap =3D ALT_CAP(alt);
>
> @@ -193,6 +196,8 @@ static void __apply_alternatives(const struct alt_reg=
ion *region,
>                 bitmap_and(applied_alternatives, applied_alternatives,
>                            system_cpucaps, ARM64_NCAPS);
>         }
> +
> +       return 0;
>  }
>
>  static void __init apply_alternatives_vdso(void)
> @@ -277,7 +282,7 @@ void __init apply_boot_alternatives(void)
>  }
>
>  #ifdef CONFIG_MODULES
> -void apply_alternatives_module(void *start, size_t length)
> +int apply_alternatives_module(void *start, size_t length)
>  {
>         struct alt_region region =3D {
>                 .begin  =3D start,
> @@ -287,7 +292,7 @@ void apply_alternatives_module(void *start, size_t le=
ngth)
>
>         bitmap_fill(all_capabilities, ARM64_NCAPS);
>
> -       __apply_alternatives(&region, true, &all_capabilities[0]);
> +       return __apply_alternatives(&region, true, &all_capabilities[0]);
>  }
>  #endif
>
> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> index 5d6d228c6156..aeefc50229e3 100644
> --- a/arch/arm64/kernel/module.c
> +++ b/arch/arm64/kernel/module.c
> @@ -478,8 +478,12 @@ int module_finalize(const Elf_Ehdr *hdr,
>         int ret;
>
>         s =3D find_section(hdr, sechdrs, ".altinstructions");
> -       if (s)
> -               apply_alternatives_module((void *)s->sh_addr, s->sh_size)=
;
> +       if (s) {
> +               ret =3D apply_alternatives_module((void *)s->sh_addr, s->=
sh_size);
> +               if (ret < 0)
> +                       pr_err("module %s: error occurred when applying a=
lternatives\n", me->name);
> +                       return ret;
> +       }
>
>         if (scs_is_dynamic()) {
>                 s =3D find_section(hdr, sechdrs, ".init.eh_frame");
> --
> 2.51.0.534.gc79095c0ca-goog
>

