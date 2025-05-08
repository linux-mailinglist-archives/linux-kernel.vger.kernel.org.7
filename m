Return-Path: <linux-kernel+bounces-639615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE07AAF9CF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 14:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0206179CD0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 12:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75888224B16;
	Thu,  8 May 2025 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ONaTa7mk"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21272253EF
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 12:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746707130; cv=none; b=roVoZkyFEJmYvWaM/iGYBwx8XxyeOQ5d5vYZtsWY0lnNV6Ui+Y/NCRx0bWLm4caFths7skCOrpEUc8OfoKpyRIGyPUxH5ciBZfnYPk/H5H+iWpK95uTiO0jmHfPewE2qPvknU+WOqK6GGW2MnK+Qz48HOpQJsYx6g/rvRLr9Wgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746707130; c=relaxed/simple;
	bh=GSPlMkE9xl1CKG6+aR4Lnpqmp6kkUaBOsXBjm7FdCs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xtqi3woBKbMqmFlcwjGsLJjMXp/NLdG7emAF1YOy/2k3j9ugWQ4Extlbs1LYC8wlYMbt5HzimNha9WYfrCNDbCDEKkCzzk7wNmEpu5r6rkhADR498JRulf7a/ZnLFH8nFOeHGa9wlQS7z/FYvG7WNhWOs5OYyaiWwSgkXcmTUbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ONaTa7mk; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54d98aa5981so1499808e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 May 2025 05:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746707126; x=1747311926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SGXUIdTFQac7mJFRH+e+84EpMzV6neC01o/VEUKascg=;
        b=ONaTa7mkd9jVBDhTxOiNjDB9oo7ZjFFzBT97onAVuG9S+UwGeCqO4hXZK/nqbJUC5t
         2yJo4mux/6GIOUCviWK0mKOKdELAH4WroXckzdLgoeA5rmJ9Vq3E7TZrudMSm4/XLMSU
         We0MQ/50Ns1jLNJ1iFHhLDLCobMR3pRT7CER365RgfcCCqK8pTxwLAVzHwOrcAfmrnQ3
         p55KROtV+WfTFr2ua2Su1IXybLXufIrUacbo2ZwHgI97BYK6FDd2/vSDIXqjm9ApLE/e
         zGp0bwKQ9lPRKEKvymtb7m/acWfQ8mZ/3YlUcbNuGnYsvDhvWBDj/BS03V+9LKduDxhs
         jkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746707126; x=1747311926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGXUIdTFQac7mJFRH+e+84EpMzV6neC01o/VEUKascg=;
        b=UriffJgNOSfYO29dpIgNbXbw3rWi1RpmulW0+CpnALivnut018F/EsmnL70yvjsUIn
         u/QPqioks/MunD436jp+NgMCCm0CDH226xij88JeAXQL2N/9MqpHA36UGDsBREYlIL1T
         Odbgmug+tS78cHIaPcUhCOW808aCivP6yP9tsrTEhQdssJIdDjiF0LBWfWKUMTxFb9Xo
         kxTrZoJdS9+5Ml6DneN3jS5XXz24EyVr5HY1kubjvJ1Yb4S6wnQHGE00v7Tv7tYOxgkp
         o+Yt+uB6vVDrnlz6IrRl5brUI0O8diZSIDuDmCDu8i3MaMAGR7LGS2AiricRYHogY4Rn
         axAw==
X-Forwarded-Encrypted: i=1; AJvYcCXenKd76ZxqoRV1CBbzucLkmi+4IpYE6HpvkteN8qW+oj3bQ6KVw1/MRBpUliodsxER3pA0CTI2NQa4H/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXre8PTfXHaN6hYcZQMdYg0yOw9yVeIfw9ApQtJD3nHccAnWAP
	xgmfDH+CXeYV+H9lmyY8phGOFTq/HU52eyKzNFR5hfVehgcB8Nifg1gf+JBvNLQnZqszmeJs3V3
	ZLsWcmHfcJ+xzZQnOxqFk+s6rSl6TPgxYslXG
X-Gm-Gg: ASbGncv3jO2l8UeAXoDAVnhdk1GqXyAv+OgcvvzQfc5WuOptJecrKqM8q7lz2u9OVdw
	JIlDY6Y/Xu2J7F3lDTJJwe8dDIhOqnybXQPbbE2oTOF4uq0K4rNpvwIv6mrII58YwT4GPeTljF8
	PffZGZeW4aWT/aMa9SwMfchg5l1sNFls5iYFPj69Vi+ODzFGBcpaE8
X-Google-Smtp-Source: AGHT+IHELJP6PjDmjgnoQ+DcewZezMvkPDTBk3DlAEgOIW2HtUu14uSoRBVrm2tBSd/cEMjU36ADUjG1Ap9y8UFRrr8=
X-Received: by 2002:a05:651c:b11:b0:30b:f006:3f5 with SMTP id
 38308e7fff4ca-326b87dacdfmr7793251fa.15.1746707125568; Thu, 08 May 2025
 05:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507180852.work.231-kees@kernel.org> <20250507181615.1947159-2-kees@kernel.org>
 <CANpmjNPcYPvnQzMT3p+Vc2=EiEbR1WnykUEjuYc0bH2HOFi6HQ@mail.gmail.com>
In-Reply-To: <CANpmjNPcYPvnQzMT3p+Vc2=EiEbR1WnykUEjuYc0bH2HOFi6HQ@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 8 May 2025 14:25:13 +0200
X-Gm-Features: ATxdqUEOMWVMkXbvXQaHqruZq4t8-pmXFLrRyvMg5ohXOpGrzDC1z300bwlcEE0
Message-ID: <CACT4Y+betRmieWEHBdEf=gOLhWiNVRH5CSDeN6ykBtoP1GrzLA@mail.gmail.com>
Subject: Re: [PATCH 2/8] init.h: Disable sanitizer coverage for __init and __head
To: Marco Elver <elver@google.com>
Cc: Kees Cook <kees@kernel.org>, Alexander Potapenko <glider@google.com>, 
	Aleksandr Nogikh <nogikh@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	kasan-dev@googlegroups.com, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	sparclinux@vger.kernel.org, llvm@lists.linux.dev, 
	syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 May 2025 at 14:23, Marco Elver <elver@google.com> wrote:
>
> +Cc KCOV maintainers
>
> On Wed, 7 May 2025 at 20:16, Kees Cook <kees@kernel.org> wrote:
> >
> > While __noinstr already contained __no_sanitize_coverage, it needs to
> > be added to __init and __head section markings to support the Clang
> > implementation of CONFIG_STACKLEAK. This is to make sure the stack depth
> > tracking callback is not executed in unsupported contexts.
> >
> > The other sanitizer coverage options (trace-pc and trace-cmp) aren't
> > needed in __head nor __init either ("We are interested in code coverage
> > as a function of a syscall inputs"[1]), so this appears safe to disable
> > for them as well.
>
> @ Dmitry, Aleksandr - Will this produce some unwanted side-effects for
> syzbot? I also think it's safe, but just double checking.

I do not see any problems with this.

> > Link: https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/kcov.c?h=v6.14#n179 [1]
> > Signed-off-by: Kees Cook <kees@kernel.org>
>
> Acked-by: Marco Elver <elver@google.com>
>
> > ---
> > Cc: Marco Elver <elver@google.com>
> > Cc: Andrey Konovalov <andreyknvl@gmail.com>
> > Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: <x86@kernel.org>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > Cc: Hou Wenlong <houwenlong.hwl@antgroup.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Cc: <kasan-dev@googlegroups.com>
> > ---
> >  arch/x86/include/asm/init.h | 2 +-
> >  include/linux/init.h        | 4 +++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
> > index 8b1b1abcef15..6bfdaeddbae8 100644
> > --- a/arch/x86/include/asm/init.h
> > +++ b/arch/x86/include/asm/init.h
> > @@ -5,7 +5,7 @@
> >  #if defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 170000
> >  #define __head __section(".head.text") __no_sanitize_undefined __no_stack_protector
> >  #else
> > -#define __head __section(".head.text") __no_sanitize_undefined
> > +#define __head __section(".head.text") __no_sanitize_undefined __no_sanitize_coverage
> >  #endif
> >
> >  struct x86_mapping_info {
> > diff --git a/include/linux/init.h b/include/linux/init.h
> > index ee1309473bc6..c65a050d52a7 100644
> > --- a/include/linux/init.h
> > +++ b/include/linux/init.h
> > @@ -49,7 +49,9 @@
> >
> >  /* These are for everybody (although not all archs will actually
> >     discard it in modules) */
> > -#define __init         __section(".init.text") __cold  __latent_entropy __noinitretpoline
> > +#define __init         __section(".init.text") __cold __latent_entropy \
> > +                                               __noinitretpoline       \
> > +                                               __no_sanitize_coverage
> >  #define __initdata     __section(".init.data")
> >  #define __initconst    __section(".init.rodata")
> >  #define __exitdata     __section(".exit.data")
> > --
> > 2.34.1
> >

