Return-Path: <linux-kernel+bounces-836088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3791BA8B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C963A712F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383422D6620;
	Mon, 29 Sep 2025 09:38:34 +0000 (UTC)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4D8283FC9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138713; cv=none; b=L2iiAy/uxx64BawG2yChndLFY643BxduvzTEBTDEP3kTVYgFAIq4KK3z9UzDUC3w9ik34A43ti1kEnLP0ICZlUQa3TlNsOQhMocjOUvf/CmX8AbTm1BkJqS4u52w6nDcmX6HZeDk0VeRCjjW7+b7VgUVNZ5H11mwAO9uj+kAfck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138713; c=relaxed/simple;
	bh=o0IirqPLTD59VJ0fkv+jMuzLOTY7bT4uP9ThimL+zio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tVn9Ul99Y7dj4brHqaiAAZZ0UqyRe3YVFzvbpbEPCfKD37EjCxwwWCK7/7vF6AzINlKzKRsTagIh6VUpzqYd3iaJO2Twvxi/n4QY/288Uv5OZf/EjZEMmLdaRmDo+HQKUuJEyZQ3meDPexgCGBHUdZy1QNYKDTrkZbT6sZ5KQsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-8e3d93c0626so3086169241.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759138710; x=1759743510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZZOWUVpIw61KHM85AdnPz6vomTChz2t/QIwYRGjaPM8=;
        b=Zy9wvROkMrkmivhImsGm8oS73V+TAmo5VMKzuWcPAFgRuiXY89e4XjwyVcowu6sEfS
         UojFnSgRA7+J/jCVYpp7WbhpFhXb4z/iSSHtpdOA6szWeFatzsIaOVpp4CkyRLpBJqhu
         NtU1obv2GxDjac4aEVRwHOE9OV8e796Oqj6JUXyKfn5HS4IWnT2AmBMMnVTCMGMDyDYy
         KpOgFzks3e97Wc1psUeUL/IB7XDro4f0/cH6mG/ugH+IrSbwzzBLOsdA6suk7d8Fn6c0
         Qf74dVl4N1K0dLAVShStPtz+9ZBBnFiMVbMF/RKupTxC38mG8CNkowL9+0pBZF27/WaW
         glOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVILB7ZGMU+CH/mpRF6pH7tK8M4HYfnbkZt8WbUnm4BDCVWY/7hqUWXSBbF71eTrVLrOWtkbGnhJIsFa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhCOLPJWu0ETpmMX4d9LssQw4/TgZOu2gYYLVOdSjqsfJJP/le
	RM+9ddjCAT8U0RiPcSnN276Lgvpis/BtvHcjYVT5HWuY1dJD3UxB+Xk1dZ3GwzRR
X-Gm-Gg: ASbGncsg0XpO+RnjyDpO8Bu//6Eg6rnH2AhKBd+SYhRFacWwPGozGFYhWAIdiBacZ4W
	FOjBQhPaEdFep0hkP7wZrLUeRirVUnaEKSjXEyssqq86eJuGfQXAf5atncoa1h8RaDvd12y3shU
	iivKDQpJMnmcn8Sj+j0oQtXFe2ZuZOd7gLsZITNXA0NrqhNg1YXZBJd2h4ml1o6EFHlQtKzBqqT
	fIOLwYbgQsTFXJIOHpNkNcq7WT3Gr5/Skd1qkYLlqTzsyxCZuxqLcTfd0grh3S+HvjUPO4nAuqu
	m9hl9eLpxipbNar/XQj9hHUXWIwf7bJUrGdIEeG9BZDtmEYRcUFCleNgGjyuMMkAJ5d8uVLjKBx
	xR0/eU/kZSi/LgOOPm/GKe5CzQTJb3xU4qsFJLncTvUxPXtV6p1wGYraogbYc
X-Google-Smtp-Source: AGHT+IHvH+na0vJOPAKkCIlApmea/8F0bEd24iyp4+IsT22xKK4pg0+A6FB5fPpawkp0MQ01bTkGLA==
X-Received: by 2002:a05:6102:6113:20b0:59b:f140:ebb2 with SMTP id ada2fe7eead31-5bae22f8e82mr2535443137.7.1759138710171;
        Mon, 29 Sep 2025 02:38:30 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-916d9bb7a6bsm2361913241.18.2025.09.29.02.38.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 02:38:29 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-528a601a3cbso3339252137.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:38:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXgd7jaX8Wt4is4aJhWIOqQDudm3l0JM6VrYPrk6cOknT3s1htnfYTOGP4vHTLp/lmS8/W4wt86OjL8Xg=@vger.kernel.org
X-Received: by 2002:a05:6102:44da:10b0:5cd:e513:384d with SMTP id
 ada2fe7eead31-5cde51341ffmr109116137.0.1759138709242; Mon, 29 Sep 2025
 02:38:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916163004.674341701@linutronix.de> <20250916163252.100835216@linutronix.de>
 <20250916184440.GA1245207@ax162> <87ikhi9lhg.ffs@tglx> <87frcm9kvv.ffs@tglx>
In-Reply-To: <87frcm9kvv.ffs@tglx>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Sep 2025 11:38:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVvAQbN8g7TJyK2MCLusGPwDbzrQJHw8uxDhOvjAh7_Pw@mail.gmail.com>
X-Gm-Features: AS18NWBdCAubwt71LwkVRoRA7LVpa5BFQK_dgundxdrnw5KTmaxVCF_m7ZP3vyo
Message-ID: <CAMuHMdVvAQbN8g7TJyK2MCLusGPwDbzrQJHw8uxDhOvjAh7_Pw@mail.gmail.com>
Subject: Re: [patch V2a 2/6] kbuild: Disable CC_HAS_ASM_GOTO_OUTPUT on clang <
 version 17
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Nathan Chancellor <nathan@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	x86@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

On Wed, 17 Sept 2025 at 07:51, Thomas Gleixner <tglx@linutronix.de> wrote:
> clang < 17 fails to use scope local labels with CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y:
>
>      {
>         __label__ local_lbl;
>         ...
>         unsafe_get_user(uval, uaddr, local_lbl);
>         ...
>         return 0;
>         local_lbl:
>                 return -EFAULT;
>      }
>
> when two such scopes exist in the same function:
>
>   error: cannot jump from this asm goto statement to one of its possible targets
>
> There are other failure scenarios. Shuffling code around slightly makes it
> worse and fail even with one instance.
>
> That issue prevents using local labels for a cleanup based user access
> mechanism.
>
> After failed attempts to provide a simple enough test case for the 'depends
> on' test in Kconfig, the initial cure was to mark ASM goto broken on clang
> versions < 17 to get this road block out of the way.
>
> But Nathan pointed out that this is a known clang issue and indeed affects
> clang < version 17 in combination with cleanup(). It's not even required to
> use local labels for that.
>
> The clang issue tracker has a small enough test case, which can be used as
> a test in the 'depends on' section of CC_HAS_ASM_GOTO_OUTPUT:
>
> void bar(void **);
> void* baz();
>
> int  foo (void) {
>     {
>             asm goto("jmp %l0"::::l0);
>             return 0;
> l0:
>             return 1;
>     }
>     void *x __attribute__((cleanup(bar))) = baz();
>     {
>             asm goto("jmp %l0"::::l1);
>             return 42;
> l1:
>             return 0xff;
>     }
> }
>
> Add another dependency to config CC_HAS_ASM_GOTO_OUTPUT for it and use the
> clang issue tracker test case for detection by condensing it to obfuscated
> C-code contest format. This reliably catches the problem on clang < 17 and
> did not show any issues on the non known to be broken GCC versions.
>
> That test might be sufficient to catch all issues and therefore could
> replace the existing test, but keeping that around does no harm either.
>
> Thanks to Nathan for pointing to the relevant clang issue!
>
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1886
> Link: https://github.com/llvm/llvm-project/commit/f023f5cdb2e6c19026f04a15b5a935c041835d14

Thanks for your patch, which is now commit e2ffa15b9baa447e ("kbuild:
Disable CC_HAS_ASM_GOTO_OUTPUT on clang < 17") in v6.17.

> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -99,7 +99,10 @@ config GCC_ASM_GOTO_OUTPUT_BROKEN
>  config CC_HAS_ASM_GOTO_OUTPUT
>         def_bool y
>         depends on !GCC_ASM_GOTO_OUTPUT_BROKEN
> +       # Find basic issues
>         depends on $(success,echo 'int foo(int x) { asm goto ("": "=r"(x) ::: bar); return x; bar: return 0; }' | $(CC) -x c - -c -o /dev/null)
> +       # Detect buggy clang, fixed in clang-17
> +       depends on $(success,echo 'void b(void **);void* c();int f(void){{asm goto("jmp %l0"::::l0);return 0;l0:return 1;}void *x __attribute__((cleanup(b))) = c();{asm goto("jmp %l0"::::l1);return 2;l1:return 1;}}' | $(CC) -x c - -c -o /dev/null)

This is supposed to affect only clang builds, right?  I am using
gcc version 13.3.0 (Ubuntu 13.3.0-6ubuntu2~24.04) to build for
arm32/arm64/riscv, and thus have:

    CONFIG_CC_IS_GCC=y

Still, this commit causes

    CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
    CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y

to disappear from my configs? Is that expected?

Thanks!

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

