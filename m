Return-Path: <linux-kernel+bounces-863818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0660CBF92DA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCCDB4E5992
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAED829D265;
	Tue, 21 Oct 2025 23:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7GTEhoP"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC14285CB3
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761088042; cv=none; b=eZFdzvFpllxwLEfDZaZTruEI3Pk7HPsk8EhU1r43V0cKaX7nM6inxxwVT3yJ54jdt2wuDvORbznXkXmwaLRqTFh7P7ZIdp73KG7MvaOxrMKMCYLBHB4oTejomH5L0ORZIv/VR2rxVGrh7VKl+D67ZFPbn7VJQk8c2h2G2sSRB/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761088042; c=relaxed/simple;
	bh=cBoLl85vfWagd/V7d3FnABx4PFfGYLtSHJ30MR7eXUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7GTRDM7UYyzNYWkqvq25OHo58uTnRiJnRogXIKAVWywthnO2t6RFCKgAQZVtVNbqN8JjdbvYcLW3xQOhR8vncIdU1WiPSRvjCI8ayHe7jl8GjDde4a4SjRq6X178ZbBJYKg67pvXOVODR/ajZfTtKc+nO32q2gzezbpLOF3ZL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7GTEhoP; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4285169c005so522167f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761088038; x=1761692838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUs/wuT0kfUsxmbimw3WNKm4HpGep0rE6iJ3jKWwffE=;
        b=L7GTEhoPUSuaxLifvZUlUPAQBE62w0qsB7IRIGvIPiZ9v/ztwHg3q0ZI0xU4qjf3QK
         HmveGM+BrElR7vM12SyQmrKz4/1jxxqDF62cONRHhBRqnCcfmAfpF+7NX3UQDew6XAys
         zNNbwEBo8UuLI9qfpbEaGv1f8EUeoJWqe934KIRYGI+GjquTm63G/FtmRE4Tzd/BmDZ4
         TbRDaMb2Y+traHZHQQBq1RLbY8no0mCzFVI5SciuOcLrI5fRLung2JZK2eod63ya3Ymq
         YIcjPXMeIUXnzp2oTA6M81LGN6ublLqmMUj9dDMO7W2e0sh8/MbMnH0KHqhS0OUoFxnw
         Z0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761088038; x=1761692838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUs/wuT0kfUsxmbimw3WNKm4HpGep0rE6iJ3jKWwffE=;
        b=i8hxbsce1UYCoLC1D/fnTfptqtTCqXU3toLBKo6ZFAYEXBnmv5NBNCwPyHN4xLi/FB
         UPX1AFACeNo8/W+oUWuHlcIC6jK9wT/4KoW7rXLmZm9bPb1xlsxCjnKtfLhwC0ygLUDh
         dczU2tmRL4msIFPj11wheB0MQqWWWg6s09SeqUU84tXb4ZHdyKQ6HAsNxY8ajiV0NJH4
         FD02tlW6p5ATsk5GlKSceTB0LjcCj9Djs5dgOGOMy0XaALPIydYu/G/NQAsIBeHiFfZK
         gcZxpTRiCLv0i+44pnth7jTg2jjLnOFY29As156RHoEa3dO1F9gmw1CIq/178QPL9/w6
         ESHw==
X-Forwarded-Encrypted: i=1; AJvYcCUEObcck9Ax5lqbKIO7OgZvooqhc2bdOieqBUyKU/4R2r8h0R/lFRW3K3FtZOV5SNCXLG8ZyaXisNXSNuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpyLxC9J4PbirsLux/Hov+EfEConqBZtc0Ox7ejErOyVNtqHCk
	WYVLkxAef7au5CS1f6f3kJ481Azx3wjnPdTzP65mwoz116Tk+vSEhoWqd8XDKtuwlivg2ZDchS6
	9EFsERqB3bFbLT2GwQIi8ws7DTxk4er0=
X-Gm-Gg: ASbGncvpo4GpFrH9cyewzPAGU3csbnCszQPRROfnWQfLkl7nDknsZ7lLPzaScwarxCQ
	2uTWeQBuQZznBIjQsim/AvS/w1Bxyw1V+JZ/ViOuEUCj/jEny0hkXIFXmFJ5PuwTMTvgF18lc3L
	uz97bLnFcuH781fSUZ1SyksutpGGD4Q9jIX1gAdWCuihlLXw29VSwQmDr9/PUz38XkNTotsnXtm
	IkTJ1Ox3cq7Af6TY7l7JrIlFqcQpMboW2jEsaC2wVxRQ9oEedFnrTYnB3+byj3vepntvTKIa9jX
	WSD/HXhzzV2KzSPS+lNV4+Hz+d1+UK1qP3WuMNxj
X-Google-Smtp-Source: AGHT+IGQHFZvIWqZUrqUsZZZ+Q/stC/g2UdHpo6nn0sLp1JYS0sru3nHrLYk6NYzKyTl+sxTOdX9V4AdnflXA+OxrLY=
X-Received: by 2002:a05:6000:4703:b0:427:690:1d84 with SMTP id
 ffacd0b85a97d-42706901d9fmr10929644f8f.32.1761088038428; Tue, 21 Oct 2025
 16:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009155403.1379150-1-snovitoll@gmail.com> <20251009155403.1379150-2-snovitoll@gmail.com>
In-Reply-To: <20251009155403.1379150-2-snovitoll@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 22 Oct 2025 01:07:07 +0200
X-Gm-Features: AS18NWCmo3ddiV-eCF44oMWKYeYFjMfIoy4ZgUCJRQ4FNMTlti9w47Jhqig1JNY
Message-ID: <CA+fCnZfwPU0_LJQsCbatD3kd8vLE-ep06vZikNaR0W6-6UrkDQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kasan: remove __kasan_save_free_info wrapper
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com, 
	vincenzo.frascino@arm.com, akpm@linux-foundation.org, bhe@redhat.com, 
	christophe.leroy@csgroup.eu, ritesh.list@gmail.com, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 5:54=E2=80=AFPM Sabyrzhan Tasbolatov <snovitoll@gmai=
l.com> wrote:
>
> We don't need a kasan_enabled() check in
> kasan_save_free_info() at all. Both the higher level paths
> (kasan_slab_free and kasan_mempool_poison_object) already contain this
> check. Therefore, remove the __wrapper.
>
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> Fixes: 1e338f4d99e6 ("kasan: introduce ARCH_DEFER_KASAN and unify static =
key across modes")
> ---
>  mm/kasan/generic.c | 2 +-
>  mm/kasan/kasan.h   | 7 +------
>  mm/kasan/tags.c    | 2 +-
>  3 files changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index b413c46b3e0..516b49accc4 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -573,7 +573,7 @@ void kasan_save_alloc_info(struct kmem_cache *cache, =
void *object, gfp_t flags)
>         kasan_save_track(&alloc_meta->alloc_track, flags);
>  }
>
> -void __kasan_save_free_info(struct kmem_cache *cache, void *object)
> +void kasan_save_free_info(struct kmem_cache *cache, void *object)
>  {
>         struct kasan_free_meta *free_meta;
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 07fa7375a84..fc9169a5476 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -399,12 +399,7 @@ void kasan_set_track(struct kasan_track *track, depo=
t_stack_handle_t stack);
>  void kasan_save_track(struct kasan_track *track, gfp_t flags);
>  void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t=
 flags);
>
> -void __kasan_save_free_info(struct kmem_cache *cache, void *object);
> -static inline void kasan_save_free_info(struct kmem_cache *cache, void *=
object)
> -{
> -       if (kasan_enabled())
> -               __kasan_save_free_info(cache, object);
> -}
> +void kasan_save_free_info(struct kmem_cache *cache, void *object);
>
>  #ifdef CONFIG_KASAN_GENERIC
>  bool kasan_quarantine_put(struct kmem_cache *cache, void *object);
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index b9f31293622..d65d48b85f9 100644
> --- a/mm/kasan/tags.c
> +++ b/mm/kasan/tags.c
> @@ -142,7 +142,7 @@ void kasan_save_alloc_info(struct kmem_cache *cache, =
void *object, gfp_t flags)
>         save_stack_info(cache, object, flags, false);
>  }
>
> -void __kasan_save_free_info(struct kmem_cache *cache, void *object)
> +void kasan_save_free_info(struct kmem_cache *cache, void *object)
>  {
>         save_stack_info(cache, object, 0, true);
>  }
> --
> 2.34.1
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

