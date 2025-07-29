Return-Path: <linux-kernel+bounces-750035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DA5B15621
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2E5E18A5E68
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58B628726E;
	Tue, 29 Jul 2025 23:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rDZ3izHG"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BCE23F40E
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753832828; cv=none; b=dPtcMhrY37N1ZNRq9yN4AjcTW/yVeNs14mx2s6LjP09J2A03GEKba9eRa0ijN+dRkzdIdHypzft9OKu6b6Clp+0CWRGNhLtqdMmTBhLLfP/FX1+jVpkCOuSyr1rhYrnFS0+m5TM5qLpBnAOYCdXv2hQ8613zsyf5QfnIm1YcSOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753832828; c=relaxed/simple;
	bh=J0UexsktNSqCM9oZLpEk47OgaAxXlbfBFz7je7XQr2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbwnNlqhj3cjvIh+pY15mkPgnelJ13lNzmmh7d0UC06ybzAXjxG0BLshqNESk6B/aBZe6IYH1XXTdHmrxNbozBlT2KGXUHdEH0MtN/QVDp0pxneihnyvS11hm9OTBvc5vbwq/1xykMkawXRuAq5rADCZVJ/PJmI6r9pdeu+Dhus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rDZ3izHG; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso5891795a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 16:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753832825; x=1754437625; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D5t7MDT/jSpU+9EuuhzwQmjAC64RK3pa7YGAopoG6Q0=;
        b=rDZ3izHGJhanoZWkCYnDrJiVjLTspRQ/6/4wO+1xtJCNf2mnTemoHGiVTfuu3MK1Sp
         /M53g7c2ly5PVb8CGMKbN55TjqwVWXeG+rmzbsDZZKutG4YzauOPeIKvxkWP4A8xGDXm
         +CMENdXrpknycydz6n33xe7LsghhruVnvTBhhKfX8P88LVrqLGMyNcCgiVOYzbC+typa
         0pKEhIPQM1I3SDbALw8idBKNow1mGze4Hxy1ua24Q5eSDEatcR37IDcRSjd+IaDoB9hu
         1cywh5P5559q9IL8bJaI/STyBa/ZmqhB/fmOK4O0FOXH3uZUsSfQ/m9jny1gHOo5tYPG
         RUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753832825; x=1754437625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5t7MDT/jSpU+9EuuhzwQmjAC64RK3pa7YGAopoG6Q0=;
        b=JJRi3lSWufgmxmEyiANaWkaqsjRutXkyroJ9SqLkcSbKojoLmtJQXj3csBSFel/fWs
         5V/AmBxgkhThl818E97ee9fd+C3t+dguAJqXJUr31R8Q58NLL87KJayUC2d78Frdch7Q
         ozSAJYUEqy8mPRpFIiwlqMXM1k28kTY3GVsZsUllQRIxIdCS4LqoeJk4XSSY7iSs38Q5
         JOPEtxtxy/BIXnSGxagcz2yGtvCwsEsbgOf8HP2Rums4ekiDvXqgq/Tghm+O5hWxHhnx
         Bvv8MhOGLz1AEY+yFKi9tByBUEc57THQOD3GKHZ1KGWlCp2AM3Ac+whLM1UXnk9oef0/
         2o2w==
X-Forwarded-Encrypted: i=1; AJvYcCVRUovoEEj/ERiSsLUqRKfBrcLUNZ6/AWMEZtdxPboqH1S61nDCx5ZEQgOYKiijlzwWNcjVyhpknF9QQrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfzT1XNRA94w1JdiehjXU/mI6faI45oVwcswtFFmtISrkXZzUR
	PRBrZzD3kc1Mr9mG+d7OE+Xi4ACUyCcEOTNFegGTJXJE/PIcppVWe4ysCOo8he/4ymvzb3rUIdZ
	Qqw5f5DmM4xJQNoar9Z1pQU8ifXC7CXZ1yWglRcrJ
X-Gm-Gg: ASbGncuTiDkqHMJZfFZSnNcgfa3pKFtwt34NFAi1VboPffSRIYW/ZJ8XVC/TQGeT+js
	lGWJaDwfCNNGZ1bJJMetOJI9lvn4uCW3CCAvhXPT51kJJDUCP6MNWynXLMNJ255DzFYOYngl1dx
	pAfDOwY9nXc2vmV9wYEIRfxUp1xjTmuisuQrm4jApiYE5TR2gZA54BDTyxFjHt6XHWWpCDMrpKE
	HSV38I86EpH4h+3fXP8q+Ncgd4hTrvGoQE4ZGs=
X-Google-Smtp-Source: AGHT+IFatYHgbdkljf2uPOkFYPjGqRSd5VZTTw5Hl+NajdqJb3Z+1Xk7PfcV2apzyvJWSR0lq7DZY2BZw1y0sfbpKyg=
X-Received: by 2002:a17:90b:540d:b0:311:df4b:4b81 with SMTP id
 98e67ed59e1d1-31f5de555ecmr1560173a91.25.1753832824572; Tue, 29 Jul 2025
 16:47:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729234055.it.233-kees@kernel.org>
In-Reply-To: <20250729234055.it.233-kees@kernel.org>
From: Marco Elver <elver@google.com>
Date: Wed, 30 Jul 2025 01:46:28 +0200
X-Gm-Features: Ac12FXx5J_uI5wvGiwYtgZvEifeHFoZvdN3qjvmiKrjmEOPX9wOpmjCSn_Ig6-A
Message-ID: <CANpmjNOrerXn9DyLyazQPhg4JDEBm+NfNhR_zua04TcwQO76yA@mail.gmail.com>
Subject: Re: [PATCH v2] compiler_types: Provide __no_kstack_erase to disable
 coverage only on Clang
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, kernel test robot <lkp@intel.com>, 
	syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com, 
	Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, "Kirill A . Shutemov" <kas@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jan Hendrik Farr <kernel@jfarr.cc>, 
	Uros Bizjak <ubizjak@gmail.com>, Marc Herbert <Marc.Herbert@linux.intel.com>, 
	Yafang Shao <laoar.shao@gmail.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 01:41, Kees Cook <kees@kernel.org> wrote:
>
> In order to support Clang's stack depth tracking (for Linux's kstack_erase
> feature), the coverage sanitizer needed to be disabled for __init (and
> __head) section code. Doing this universally (i.e. for GCC too) created
> a number of unexpected problems, ranging from changes to inlining logic
> to failures to DCE code on earlier GCC versions.
>
> Since this change is only needed for Clang, specialize it so that GCC
> doesn't see the change as it isn't needed there (the GCC implementation
> of kstack_erase uses a GCC plugin that removes stack depth tracking
> instrumentation from __init sections during a late pass in the IR).
>
> Successfully build and boot tested with GCC 12 and Clang 22.
>
> Fixes: 381a38ea53d2 ("init.h: Disable sanitizer coverage for __init and __head")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507270258.neWuiXLd-lkp@intel.com/
> Reported-by: syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6888d004.a00a0220.26d0e1.0004.GAE@google.com/
> Signed-off-by: Kees Cook <kees@kernel.org>

Looks good:

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  v2: correctly split compiler-specific stuff out of compiler_types.h (Miguel)
>  v1: https://lore.kernel.org/all/20250729224325.work.019-kees@kernel.org/
> Cc: Linus Torvalds <torvalds@linuxfoundation.org>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: <x86@kernel.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Hou Wenlong <houwenlong.hwl@antgroup.com>
> Cc: Kirill A. Shutemov <kas@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/x86/include/asm/init.h    | 2 +-
>  include/linux/compiler-clang.h | 3 +++
>  include/linux/compiler_types.h | 4 ++++
>  include/linux/init.h           | 2 +-
>  4 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
> index 6bfdaeddbae8..5a68e9db6518 100644
> --- a/arch/x86/include/asm/init.h
> +++ b/arch/x86/include/asm/init.h
> @@ -5,7 +5,7 @@
>  #if defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 170000
>  #define __head __section(".head.text") __no_sanitize_undefined __no_stack_protector
>  #else
> -#define __head __section(".head.text") __no_sanitize_undefined __no_sanitize_coverage
> +#define __head __section(".head.text") __no_sanitize_undefined __no_kstack_erase
>  #endif
>
>  struct x86_mapping_info {
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index 4fc8e26914ad..fa4ffe037bc7 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -89,6 +89,9 @@
>  #define __no_sanitize_coverage
>  #endif
>
> +/* Only Clang needs to disable the coverage sanitizer for kstack_erase. */
> +#define __no_kstack_erase      __no_sanitize_coverage
> +
>  #if __has_feature(shadow_call_stack)
>  # define __noscs       __attribute__((__no_sanitize__("shadow-call-stack")))
>  #endif
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 2b77d12e07b2..16755431fc11 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -424,6 +424,10 @@ struct ftrace_likely_data {
>  # define randomized_struct_fields_end
>  #endif
>
> +#ifndef __no_kstack_erase
> +# define __no_kstack_erase
> +#endif
> +
>  #ifndef __noscs
>  # define __noscs
>  #endif
> diff --git a/include/linux/init.h b/include/linux/init.h
> index c65a050d52a7..a60d32d227ee 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -51,7 +51,7 @@
>     discard it in modules) */
>  #define __init         __section(".init.text") __cold __latent_entropy \
>                                                 __noinitretpoline       \
> -                                               __no_sanitize_coverage
> +                                               __no_kstack_erase
>  #define __initdata     __section(".init.data")
>  #define __initconst    __section(".init.rodata")
>  #define __exitdata     __section(".exit.data")
> --
> 2.34.1
>

