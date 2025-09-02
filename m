Return-Path: <linux-kernel+bounces-797448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C7CB41097
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2BFB1B63054
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 23:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927E72777FC;
	Tue,  2 Sep 2025 23:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a5u9bMZe"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C3D274B57
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 23:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756854557; cv=none; b=o41kb8EkHLCAOnlbNcvzU/55Asmvu1vY/2XkvosoMnu4q5SyKZvlKDU8VtjaDWeX1KxphGW5eNQdbUJrK3XQUP/4yhZjXDVtPF4jrhQecv75rfvf9J47P9qIMJMir3KNJdu65q//nmaNR7X6woeiGL7QiAHSiOxWTpmF6hixz/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756854557; c=relaxed/simple;
	bh=/Hfq1zGj3CUwWD00dGRfGcAZbooxiSw2BfRusJshfIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lXURAx7R1C70TYxIrrItbPrp+Yjl5Mpve06oTq19/G3Ak4uH6ihX1vS1o3hmMjE3uZH4DOCYE4cJT+lGT/ydmrxME25Lgvu0GfpKVGkFT8idA194Ku4dUeP4g6xJ6ILyYWQeT6GOAfJ6+l7cfbkwpv46U2KWgsx2apvqZY7sFpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a5u9bMZe; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-528d8aa2f3bso1998304137.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 16:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756854555; x=1757459355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ok/LzY68t77UKOxDiwSjWGMeBPTcLr/jFtZLJbmSzEE=;
        b=a5u9bMZemx9MYWLRB7BFGcMesdVcAdEVYf5lDX8qDM2QrHv4edI9QawWJ/fcXEx+gM
         12OhQCG/pkOcM0FXq+RfnSn4te2+nC1NJCZhiDgeXkZ17QLo3jGwlNINHXE7FuqylGdd
         G+7I2AeJqx5MBrKOUu/BQdxPNNlG0u0WCxsH/b/A119+fVVWdL2KW3LdJd3+VsxoNu/6
         GgiANf/uwPASlv3iGJz1SWqqbmr1+uRF3OBbceniuTRlCMYgCuYiKtThXq7K7wQ4fXGQ
         O9A7Hy162RzaR7SCsE/oRBkXT4MR935WG7F26DvUC1c/6dTt/m1GFpYoqafuA8qLJocJ
         1mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756854555; x=1757459355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ok/LzY68t77UKOxDiwSjWGMeBPTcLr/jFtZLJbmSzEE=;
        b=glmUynCGv2Wgw0Rg+523tcCmwrhAEq07gBlhj/5IkiM+pLnoNqhCqHT4gc0hqz+hIb
         MGOJhyZaEhbJLCsVu2GvmhsyGOngEEyYEGAU7BZ17YA04WhGft/SpeRHFycU3xDywF/v
         zAJU2yEBcb75XBsHJcc/uwJGvlikLlqoza7FbMMz2jFP5TQyvOz0Jan33N6ytsGaR6cY
         DyE6tnSBVZOuXkeFwPCOAvluQ1yNM35yXc/RxAeMEakUXoElZCjqszJUIRTv+e3afGfB
         9ud/ZTD4W7IY1QJQDjrNVgKl9NUnFMpK/LQiQee8M0HnJrZalQtUMg1kNRZMcZvTDJxp
         ic4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3Rfr+IegUfjFdXzgIHWpZMKlVu3jdJZt/T7J5VEej3wB9bEfL8NuLr2IOlhd695p+z12FIbomVOIYWpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVvN7Nz4WdjuKvj4UvDtWZgb7bj00aPr8Iee6pMhfSRMeF6vYF
	k+HWKpwZ3n5NG1h2L6/COq6awQ7tnFf/CIWWbgVCcrdUrVvZfkklFCP6VyHmurqJnEuVpESvoii
	C2VqxndIacan4qYJBWQJgxF1znLguGk5HwyPuwqge
X-Gm-Gg: ASbGncvDrQQZuGhxMngMe7I0oeE8ANbjSD09VA8CgWljU0LEd+yJ9jhJigQ38a3Islj
	410+0zGTzhnaTQHJOBchQRJK0YA1dzT+LIWs/h+3fRtFABVq/T535EftdY2POK2Se3D++pBWCaW
	aBOtn6fYrzVvjst6dTbMY4uQck903Zg15UMSZcYgcDBW9jie/ghp5pA7vhHIKJHpUO3t6461HGX
	3C0W4bRlLBwxMxmfeaVl9AbcefmIsS87eXRN+sZP14=
X-Google-Smtp-Source: AGHT+IFhdKhg4nEAeTuWh9UpE13dsM2opfmDBOIVuHeu39wqwcvL97R0YcUTOoAodJqlRurDkGUAODCGGTs6GPLWBMk=
X-Received: by 2002:a05:6102:3053:b0:4fd:35ca:6df5 with SMTP id
 ada2fe7eead31-52b1974e50amr4309938137.7.1756854554786; Tue, 02 Sep 2025
 16:09:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-clang-update-sanitize-defines-v1-1-cf3702ca3d92@kernel.org>
In-Reply-To: <20250902-clang-update-sanitize-defines-v1-1-cf3702ca3d92@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 2 Sep 2025 16:09:04 -0700
X-Gm-Features: Ac12FXywF_5PF4EJJMAvgc55AUTlDfNYbymSWMWfPLD0aBiRhuuGXQUjDtVsZ0g
Message-ID: <CAFhGd8qku6wkpqNCq+KpM4TMh-djVQW4UEdXON1Tk1BRtN8V6g@mail.gmail.com>
Subject: Re: [PATCH] compiler-clang.h: Define __SANITIZE_*__ macros only when undefined
To: Nathan Chancellor <nathan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	kasan-dev@googlegroups.com, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 3:49=E2=80=AFPM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> Clang 22 recently added support for defining __SANITIZE__ macros similar
> to GCC [1], which causes warnings (or errors with CONFIG_WERROR=3Dy or
> W=3De) with the existing defines that the kernel creates to emulate this
> behavior with existing clang versions.
>
>   In file included from <built-in>:3:
>   In file included from include/linux/compiler_types.h:171:
>   include/linux/compiler-clang.h:37:9: error: '__SANITIZE_THREAD__' macro=
 redefined [-Werror,-Wmacro-redefined]
>      37 | #define __SANITIZE_THREAD__
>         |         ^
>   <built-in>:352:9: note: previous definition is here
>     352 | #define __SANITIZE_THREAD__ 1
>         |         ^
>
> Refactor compiler-clang.h to only define the sanitizer macros when they
> are undefined and adjust the rest of the code to use these macros for
> checking if the sanitizers are enabled, clearing up the warnings and
> allowing the kernel to easily drop these defines when the minimum
> supported version of LLVM for building the kernel becomes 22.0.0 or
> newer.
>
> Cc: stable@vger.kernel.org
> Link: https://github.com/llvm/llvm-project/commit/568c23bbd3303518c5056d7=
f03444dae4fdc8a9c [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
> Andrew, would it be possible to take this via mm-hotfixes?
> ---
>  include/linux/compiler-clang.h | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clan=
g.h
> index fa4ffe037bc7..8720a0705900 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -18,23 +18,42 @@
>  #define KASAN_ABI_VERSION 5
>
>  /*
> + * Clang 22 added preprocessor macros to match GCC, in hopes of eventual=
ly
> + * dropping __has_feature support for sanitizers:
> + * https://github.com/llvm/llvm-project/commit/568c23bbd3303518c5056d7f0=
3444dae4fdc8a9c
> + * Create these macros for older versions of clang so that it is easy to=
 clean
> + * up once the minimum supported version of LLVM for building the kernel=
 always
> + * creates these macros.
> + *
>   * Note: Checking __has_feature(*_sanitizer) is only true if the feature=
 is
>   * enabled. Therefore it is not required to additionally check defined(C=
ONFIG_*)
>   * to avoid adding redundant attributes in other configurations.
>   */
> +#if __has_feature(address_sanitizer) && !defined(__SANITIZE_ADDRESS__)
> +#define __SANITIZE_ADDRESS__
> +#endif
> +#if __has_feature(hwaddress_sanitizer) && !defined(__SANITIZE_HWADDRESS_=
_)
> +#define __SANITIZE_HWADDRESS__
> +#endif
> +#if __has_feature(thread_sanitizer) && !defined(__SANITIZE_THREAD__)
> +#define __SANITIZE_THREAD__
> +#endif
>
> -#if __has_feature(address_sanitizer) || __has_feature(hwaddress_sanitize=
r)
> -/* Emulate GCC's __SANITIZE_ADDRESS__ flag */
> +/*
> + * Treat __SANITIZE_HWADDRESS__ the same as __SANITIZE_ADDRESS__ in the =
kernel.
> + */
> +#ifdef __SANITIZE_HWADDRESS__
>  #define __SANITIZE_ADDRESS__
> +#endif
> +
> +#ifdef __SANITIZE_ADDRESS__
>  #define __no_sanitize_address \
>                 __attribute__((no_sanitize("address", "hwaddress")))
>  #else
>  #define __no_sanitize_address
>  #endif
>
> -#if __has_feature(thread_sanitizer)
> -/* emulate gcc's __SANITIZE_THREAD__ flag */
> -#define __SANITIZE_THREAD__
> +#ifdef __SANITIZE_THREAD__
>  #define __no_sanitize_thread \
>                 __attribute__((no_sanitize("thread")))
>  #else
>
> ---
> base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
> change-id: 20250902-clang-update-sanitize-defines-845000c29d2c
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>

