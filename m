Return-Path: <linux-kernel+bounces-775432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F36FB2BF18
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5578683B12
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB31322C75;
	Tue, 19 Aug 2025 10:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zgau1pc1"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E27D322A3F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755599778; cv=none; b=WkPP1M2b5vuptHUxYJTLrvdymMd2BlzQTiKpQMaX+/2XYG8gS7gT30MGhmcaZdDuj4Z56RMtxqpEqitpW4mMbPbEQl+OU6PE0ZqQZhfSX49mZ09DBchMt8MiE9oPg3Y+g4HhcEv80lA2Q/16z3B/XQ1AmoDTfcN6ekw3BSd9SXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755599778; c=relaxed/simple;
	bh=f0QsgYzieVeY78Rm9/QS4ztp2XaR7DWI6fggUzgPROg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBmDuraT67uUQaTU/jQwaVq0VOHc64RcPblRk64JcXvJ2wwiplPgiqaAB+TozxOEZ3UhDuhJ579DT5GDWRvX/OyF17tnztNlHppDaBDTPzal6Rd2Pzv4IrWeNJV8BrbNNB7BMNyJh22rg0YH/G4akXzD7aeYjY938qntL2EiSbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zgau1pc1; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71e6eb6494eso29516987b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755599774; x=1756204574; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2fN+Cw2GD8q7ciDJSfP7W+cnq2F/R7FubEkGbK5iPps=;
        b=zgau1pc1vM/ONpX2QQ6/mgp5wudfRS0gd3fEaGd+1JjN5XS4zP5zjIoltt9GRQ1Kr3
         y4L58SA3I8+R7s/4bWjOWQS1yZqWSlixSbcJj2FFxwapKWsxPOAdtjSn/jhbdjx/jF15
         oLoicNFbUanwSvzodRlQFRDjgbpE3DdfYdBsTmyQcpWrTyd4PRtMtjAc9FAtiThhKmAb
         tXB6OrQqZ+Fqyoa66+Jm7yvF9XklettyscOqZLhgTyZTkV8B1gTC3YimUzwHMQl1uDtR
         +hi3ySM6i4ZajMoA7mAesUm5DkWk8Efb2fLj90PiWt9LAuK0yaSp1w5apcdJJ+Rpnpyl
         hOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755599774; x=1756204574;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2fN+Cw2GD8q7ciDJSfP7W+cnq2F/R7FubEkGbK5iPps=;
        b=uLEktNUVGQu8/rKXRPTMUDQ+DePl08xJkhAcnZ4WILW+Q9+oZ47WwShr8gAWPvMmCe
         h7zclw9z5R9sCgJJdtplhRI4Foj7ypyT/NyBXVSfu+6rcEzhb+JtWU3wWAwuJfDcc0Zi
         xq0+546z0YjFP+sOA6AC61VOnoE5Yzi1WSsEHctY7WPzfOLrVd6jgVmvYQqjiSUijAcc
         B1kToUaQKHN7Jo1eq+5Bh1IeM42Chq7EqioU+qVaO99+eporUt4DERFfkf9TbMfOI4LL
         y6vtoSGBQGyTzgw6K6O6hFVIy5X8dhj5ZrmBON8Uz99LJyj4nUg2k0N2NpFghwAciqAM
         YKNA==
X-Forwarded-Encrypted: i=1; AJvYcCUUUJFT04Rpg0/RcbPCRwIeNFecDBM/ui8/keGama0NlvA2aViR7hT/A3bFT7Ke08b61aVX6Rr2Q/V91oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJDp/7IviAfoJeiXXN/FwUQxC4vDS5IhPRl3OPLNd+WenKgXnU
	g4GEVZHr7xvbJmPLalw3sabzDO78w26omjLRSZgEWsM3krmCrcc3ZsOnKuya9Ec2ERNNFM1r3Xj
	so0hKpV7DsoJi6Qf8R34f9jjo9Y+11mwAQIXmbrYz
X-Gm-Gg: ASbGnct1vJLL6GIrs7X3ZMDFCx/RI+nD/g//2a6x9PNib2d+5t0PY8nhtb4MUxe2yYM
	14MblTmyt4aqY0j9zR3nMvrTK/0NWr5yGSawsf/Nfk581ZxJjuDvttvDSPefDOKJhaGG1MSg9nj
	hmq7+bLXZ9TlHEc5RzBKb83/+zLY87XV0s+juYMJsjXv2AjD94TpTJLWnDfiiD0JYjE+nhVzHtl
	tiN2M+D8L8hR/pk9KyOSwYp+tNqGT2hXAMZGvJ/cDw/NoJ3cplVYFaX
X-Google-Smtp-Source: AGHT+IEyQkk7FbmcgWE6e5Fltqxk8e2OmEel306FAGI6BUzZSbzI9juKCgBNuurFH75DIL/XFm7wd0hLUiRSVtYPoVQ=
X-Received: by 2002:a05:690c:6c02:b0:71e:325e:5468 with SMTP id
 00721157ae682-71f9d494f58mr24000397b3.5.1755599774272; Tue, 19 Aug 2025
 03:36:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818-bump-min-llvm-ver-15-v1-0-c8b1d0f955e0@kernel.org> <20250818-bump-min-llvm-ver-15-v1-9-c8b1d0f955e0@kernel.org>
In-Reply-To: <20250818-bump-min-llvm-ver-15-v1-9-c8b1d0f955e0@kernel.org>
From: Marco Elver <elver@google.com>
Date: Tue, 19 Aug 2025 12:35:37 +0200
X-Gm-Features: Ac12FXy_pMfFpBqlyslz5YoDfRSNwKDNUf2Ii-KoSTGsRrmWmRwz_9vxZQpt2K4
Message-ID: <CANpmjNN243_NoHOEdHvs0zDTzX5w4hjWoeo9TnQbwgfPzOWJAA@mail.gmail.com>
Subject: Re: [PATCH 09/10] objtool: Drop noinstr hack for KCSAN_WEAK_MEMORY
To: Nathan Chancellor <nathan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Kees Cook <kees@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, patches@lists.linux.dev, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Aug 2025 at 20:58, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Now that the minimum supported version of LLVM for building the kernel
> has been bumped to 15.0.0, __no_kcsan will always ensure that the thread
> sanitizer functions are not generated, so remove the check for tsan
> functions in is_profiling_func() and the always true depends and
> unnecessary select lines in KCSAN_WEAK_MEMORY.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: Marco Elver <elver@google.com>

Good riddance.

> ---
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: kasan-dev@googlegroups.com
> ---
>  lib/Kconfig.kcsan     |  6 ------
>  tools/objtool/check.c | 10 ----------
>  2 files changed, 16 deletions(-)
>
> diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> index 609ddfc73de5..4ce4b0c0109c 100644
> --- a/lib/Kconfig.kcsan
> +++ b/lib/Kconfig.kcsan
> @@ -185,12 +185,6 @@ config KCSAN_WEAK_MEMORY
>         bool "Enable weak memory modeling to detect missing memory barriers"
>         default y
>         depends on KCSAN_STRICT
> -       # We can either let objtool nop __tsan_func_{entry,exit}() and builtin
> -       # atomics instrumentation in .noinstr.text, or use a compiler that can
> -       # implement __no_kcsan to really remove all instrumentation.
> -       depends on !ARCH_WANTS_NO_INSTR || HAVE_NOINSTR_HACK || \
> -                  CC_IS_GCC || CLANG_VERSION >= 140000
> -       select OBJTOOL if HAVE_NOINSTR_HACK
>         help
>           Enable support for modeling a subset of weak memory, which allows
>           detecting a subset of data races due to missing memory barriers.
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index d14f20ef1db1..efa4c060ff4e 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2453,16 +2453,6 @@ static bool is_profiling_func(const char *name)
>         if (!strncmp(name, "__sanitizer_cov_", 16))
>                 return true;
>
> -       /*
> -        * Some compilers currently do not remove __tsan_func_entry/exit nor
> -        * __tsan_atomic_signal_fence (used for barrier instrumentation) with
> -        * the __no_sanitize_thread attribute, remove them. Once the kernel's
> -        * minimum Clang version is 14.0, this can be removed.
> -        */
> -       if (!strncmp(name, "__tsan_func_", 12) ||
> -           !strcmp(name, "__tsan_atomic_signal_fence"))
> -               return true;
> -
>         return false;
>  }
>
>
> --
> 2.50.1
>

