Return-Path: <linux-kernel+bounces-807281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DF7B4A27C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683571889E0B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D830303A21;
	Tue,  9 Sep 2025 06:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBShvBgE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A73328E7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 06:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757400095; cv=none; b=lC67UCg08jlw+sxBcHeJUJ0NuyXQVW4Z+lD900s9mTB+jvf6fbjP7ez5zvdKS6lpLbZQTeR5Dl/NEK/5ogJ0T47T8Bu+QSaVC5Ge7bOgFTmn5wq3k4KjI0dLpzQyTdS5hKBcGghE+RigGP2XhOkx3V0LtCh5F8hD9ibcc02mSV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757400095; c=relaxed/simple;
	bh=tvbZLeSVrZ/8x96VcQLRCzel3SO3pd60ytffiqMePUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRTnyugRiSxQInSvlPxvYsuhZdNvmgI5XbiBdGOnMShrGV/aRwtdOOS241HVaXQb6g6nETsvQhBv+6HyHiO/ophRDepOTcrLhNSm/y82WJj8dBmjHFdx//jBukL9HbrJl2xbuuujNL5nlaFJKEQEfSsH7a4G8pASxU6ANMSR9Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBShvBgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D522C4CEFA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 06:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757400095;
	bh=tvbZLeSVrZ/8x96VcQLRCzel3SO3pd60ytffiqMePUo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cBShvBgExeJGYssh8t+Pl7yWhsPpXp+EJg6QcUz7lcgIsl1zi47SHjALGg+ZHn+09
	 XcFkY1ay7O00Sr3bpLqvUvCkYWrfkNwtDfIiHzQF7/8PrFX69n7AeVgFSqutrETnbz
	 Kzt3OXilfnxAQ+OLOmbpEEdYnU0c0JyLHaco3Oir5knG0d/4hhHLtuN/AYM84P7TVc
	 smDSBI1GgrnbS+aVQh+8u7HP0+GH9mcC2YNRgjxFdMkO/I8Tvkcz/7ca5u4V7QWwb3
	 8CYJCDy++jZr4ptz5Oz/BlpGm/16YMaYW0wcHs/D5hiXcmh8k1aKGcLFH0fxdSWnvY
	 efOsxI+/35gnw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5607c2f1598so5315755e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 23:41:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWvbZt5h0Qt/o3ccGasR5XrO+ZUGHZ5Wfq4JGep1Q/5aP7mUS3EdQ1NIVGQJP52Bi58YZmV69BE5p1z6yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbP6A8kY50IkXT72NFZMhuZ4Lect6ybPb/Cu4GQxdS07xwM1ZD
	UVyTKf1IDV4rXAXxSlWJU7EcaGGGwzNgSmMqXY90sCGjI0e6rnDram2iHWC8W3j6xeSDxcOSCw0
	pgWXNdsCthtDKpZ31xafXZF8D36+4ULw=
X-Google-Smtp-Source: AGHT+IFRk5vlx3r7DuqtSV3uP1njUO0NVVYNGyPngaaf5MBFVDStEXWFIcebgnGKgqOfpgxvBpGYZQytBxU4QgeZmmc=
X-Received: by 2002:a05:6512:252b:b0:560:8d1b:9b5 with SMTP id
 2adb3069b0e04-5625f5354admr3182169e87.15.1757400093573; Mon, 08 Sep 2025
 23:41:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908-x86-startup-fix-pi-cfi-warnings-v1-1-4b42b43fecf3@kernel.org>
In-Reply-To: <20250908-x86-startup-fix-pi-cfi-warnings-v1-1-4b42b43fecf3@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 9 Sep 2025 08:41:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEiFundZnhcAmFt14SQBMw0fBTxm9RX9sagu3BqN6X=vw@mail.gmail.com>
X-Gm-Features: Ac12FXxHJPkMM4CzYFbsvLElNVC-h4FIh8GBF_dtbB0pFsEnXKI3Y-M8JDyc1Xk
Message-ID: <CAMj1kXEiFundZnhcAmFt14SQBMw0fBTxm9RX9sagu3BqN6X=vw@mail.gmail.com>
Subject: Re: [PATCH] objtool: Ignore __pi___cfi_ prefixed symbols
To: Nathan Chancellor <nathan@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Borislav Petkov <bp@alien8.de>, x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Sept 2025 at 22:04, Nathan Chancellor <nathan@kernel.org> wrote:
>
> When building with CONFIG_CFI_CLANG=y after the recent series to
> separate the x86 startup code, there are objtool warnings along the
> lines of:
>
>   vmlinux.o: warning: objtool: __pi___cfi_startup_64_load_idt() falls through to next function __pi_startup_64_load_idt()
>   vmlinux.o: warning: objtool: __pi___cfi_startup_64_setup_gdt_idt() falls through to next function __pi_startup_64_setup_gdt_idt()
>   vmlinux.o: warning: objtool: __pi___cfi___startup_64() falls through to next function __pi___startup_64()
>
> As the comment in validate_branch() states, this is expected, so ignore
> these symbols in the same way that __cfi_ and __pfx_ symbols are already
> ignored for the rest of the kernel.
>
> Fixes: 7b38dec3c5af ("x86/boot: Create a confined code area for startup code")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  tools/objtool/check.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 92ce18886477..6d6323508e4b 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -3576,6 +3576,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>                         /* Ignore KCFI type preambles, which always fall through */
>                         if (!strncmp(func->name, "__cfi_", 6) ||
>                             !strncmp(func->name, "__pfx_", 6) ||
> +                           !strncmp(func->name, "__pi___cfi_", 11) ||
>                             !strncmp(func->name, "__pi___pfx_", 11))
>                                 return 0;
>
>
> ---
> base-commit: 8e5b2f272c1801071142af33b193130bbcc5ba9d
> change-id: 20250908-x86-startup-fix-pi-cfi-warnings-9edf2970ddfe
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>

