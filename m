Return-Path: <linux-kernel+bounces-723943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 221BDAFECCD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E28188FDA2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F44A2E0411;
	Wed,  9 Jul 2025 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c4WhczxS"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E430C2E4252
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072808; cv=none; b=f3aOeZ9Ob3+OEk9z993icMHk7o5kYNTnPOU643XjxqjipAzG+nhgiIyfSPcx0KCeCCmlkkOIV1QmyJdpj5Na64+pFb0KJQSu4slIILiKolO+HNX18UpEt4Lp4zEvUc+4vsiQPnbTr3fWmTlWBlKRnG9+kBSeHdFjMS2C4CDnxEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072808; c=relaxed/simple;
	bh=LfxedUrPezGFuRvltZ/vD3YZPEbpmWeQSlVrX5VEY+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AxxmHgynjjD9DvEA9ZZ65dbKSpDbmeZMO4ved+t5oqvv01E9INbdu33neqAakciVJtecvgcsRrx+fMV4UjsPbey745i8cAiCfeh4ncjv/7lGfZpRa7NXuRAX6BxOjIJIT3oXnSXPRW70x4OjnmucawJ1s5uRLRFInvsZmavKW+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c4WhczxS; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32f2947ab0bso27856831fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752072805; x=1752677605; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cOYdoaWyY3uQXdbZORoJMC4n+n/vVc/HUyRRArbBJO4=;
        b=c4WhczxSOLixpCdQUSfMdMnn7mHyM51zNBEp4ULmiLbBFNm14YQXXcVg0VBgJ2Nobm
         ddMr7h2Gib01zCWAvQjORf6X9S4N+n7YmLg23GH5o6nFPk0NN1bV/8NYBwVD014vw968
         bT/XtVFa4C18DTAqIPpIbmccPLynKecJi6uFp6sKfNLiv0XKidTu1QuhxeefZPF/3ONp
         pNhVY2oOr91TY0d9CVTdggU83dsBk0jaG8WOr6/pqck+j+nfyIceCz4fIOoJAh5XWaXu
         tvuiAQaNU8X+hSermab4w8ZhEeXo9cPF7FnacZRqZ9oxy7oTpr5Gu19hhIk4ftgHyB01
         EE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752072805; x=1752677605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cOYdoaWyY3uQXdbZORoJMC4n+n/vVc/HUyRRArbBJO4=;
        b=rYOcmNghUCo0J8W8OeV4Sma4yYcRz7o8U++a6ctVyQDXRSPB1y3zI4knHes69q/yYt
         bMPlW96rKTEY9T7YWa1f4OQguRTuhyqsKnmuDrbtFuRJLwczt9hKLvrIjo0TgmaKXSHM
         2501o4pLj/Te/n65o2Imetu2xOGOLS9r59nmfPLRNP4tcQ5ErfnAIgTFOuROg/RsuSPi
         /RFZiEqgnKVxFL+BwpkATFXhA1iHJvHPp6X/pN+mOW2+rOieLrf03kMZeq0j6Ih4tbfU
         BFqh84fArOuqNtvGDxufghVk3BQWNNP40FaosemBdIXLyn8+dynt2ePUv+s26iLhFzDP
         ODig==
X-Forwarded-Encrypted: i=1; AJvYcCWolbAsRBR6RaM8BQGa6iOvhdQPJGqEA4AIuUuN7O1P/EDSopDnEsd/Hd8yFMNf9sWOspKqlioGJoQ6e8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9R4umZ166Lj5gns+AbRtxMsLBH2oMK9INGCOzwieM0OQvC+WK
	E3x0ZdFaQQ2WvEkeQbdFbMeYnw1pjPPc6XuJZjHeiTA4Rb/iNAAkN1nv+hmJ88tKDi/FoJCpJ3Y
	IvqYO+lYejAaupShY+hcFeXcIsBSVF56lc23Yxjsv
X-Gm-Gg: ASbGnctBN3cXw/foY6ZbZeXDXUmKlgpjhpmkfOGPQF2Si7c/xt3v5AuDoX1c0KtCT5R
	z/D0IVWbbA/jVnLBClo96Fn1RNA3gOK8ZDAzPvUPiNHjfqnMQLg1l8mMmPQDQPe8aNRlHOGreWm
	o0tbFulZnhilDuaEHs+WLJXpTYt/jqWvDnhRcF44HhmgeTghsdkXeZH9Chje4l6jF5+JTCXPTQJ
	q4l
X-Google-Smtp-Source: AGHT+IE5j79jkUt9xnjQLPGwLeJizys2wNTr1XJYZDLe1+/3yT1ILyNEXMRlIefHbqprDowbpiKUaSdIxood5n8rjE0=
X-Received: by 2002:a2e:7014:0:b0:32b:a85f:c0b8 with SMTP id
 38308e7fff4ca-32f483e4ed6mr8361631fa.9.1752072804781; Wed, 09 Jul 2025
 07:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626134158.3385080-1-glider@google.com> <20250626134158.3385080-6-glider@google.com>
In-Reply-To: <20250626134158.3385080-6-glider@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 9 Jul 2025 16:53:13 +0200
X-Gm-Features: Ac12FXxPwTmllLByY7RsdoeFXIB5dcOLBahesrToj0d2F-vfnSS3_ZxXdIirMvk
Message-ID: <CACT4Y+ahHYybYkvT8z8rzr55mmSp-_EDCVZsh+f_TX9mnCJoiA@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] mm/kasan: define __asan_before_dynamic_init, __asan_after_dynamic_init
To: Alexander Potapenko <glider@google.com>
Cc: quic_jiangenj@quicinc.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Aleksandr Nogikh <nogikh@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Jun 2025 at 15:42, Alexander Potapenko <glider@google.com> wrote:
>
> Calls to __asan_before_dynamic_init() and __asan_after_dynamic_init()
> are inserted by Clang when building with coverage guards.
> These functions can be used to detect initialization order fiasco bugs
> in the userspace, but it is fine for them to be no-ops in the kernel.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

>
> ---
> Change-Id: I7f8eb690a3d96f7d122205e8f1cba8039f6a68eb
>
> v2:
>  - Address comments by Dmitry Vyukov:
>    - rename CONFIG_KCOV_ENABLE_GUARDS to CONFIG_KCOV_UNIQUE
>  - Move this patch before the one introducing CONFIG_KCOV_UNIQUE,
>    per Marco Elver's request.
> ---
>  mm/kasan/generic.c | 18 ++++++++++++++++++
>  mm/kasan/kasan.h   |  2 ++
>  2 files changed, 20 insertions(+)
>
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index d54e89f8c3e76..b0b7781524348 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -238,6 +238,24 @@ void __asan_unregister_globals(void *ptr, ssize_t size)
>  }
>  EXPORT_SYMBOL(__asan_unregister_globals);
>
> +#if defined(CONFIG_KCOV_UNIQUE)
> +/*
> + * __asan_before_dynamic_init() and __asan_after_dynamic_init() are inserted
> + * when the user requests building with coverage guards. In the userspace, these
> + * two functions can be used to detect initialization order fiasco bugs, but in
> + * the kernel they can be no-ops.
> + */
> +void __asan_before_dynamic_init(const char *module_name)
> +{
> +}
> +EXPORT_SYMBOL(__asan_before_dynamic_init);
> +
> +void __asan_after_dynamic_init(void)
> +{
> +}
> +EXPORT_SYMBOL(__asan_after_dynamic_init);
> +#endif
> +
>  #define DEFINE_ASAN_LOAD_STORE(size)                                   \
>         void __asan_load##size(void *addr)                              \
>         {                                                               \
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 129178be5e649..c817c46b4fcd2 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -582,6 +582,8 @@ void kasan_restore_multi_shot(bool enabled);
>
>  void __asan_register_globals(void *globals, ssize_t size);
>  void __asan_unregister_globals(void *globals, ssize_t size);
> +void __asan_before_dynamic_init(const char *module_name);
> +void __asan_after_dynamic_init(void);
>  void __asan_handle_no_return(void);
>  void __asan_alloca_poison(void *, ssize_t size);
>  void __asan_allocas_unpoison(void *stack_top, ssize_t stack_bottom);
> --
> 2.50.0.727.gbf7dc18ff4-goog
>

