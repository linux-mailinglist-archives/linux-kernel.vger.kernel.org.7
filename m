Return-Path: <linux-kernel+bounces-829353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC1CB96DF7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FACD19C683C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411892E2DDE;
	Tue, 23 Sep 2025 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TahcP1yF"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54811F4295
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758645984; cv=none; b=c/5Foyvt0QcIbeEHDSrcawSAzJh5OLlGzUVwaHX1Ilo5Rvt9td2bjiJHbDuUytRC9a1A+QRZ5a3o08QdIX41S/0Uu5A4AIEWx1wZiWv15n9pW2mxz5DZmtSb6uo21zdYRle0yzskhnNLvsIzRnjRnL7dMGv4zXhcqXHEUSBbrug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758645984; c=relaxed/simple;
	bh=QaGJKywzMIg34PVw2pMJ12QoZsJVOXlA2Id5RVZ88k8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ErDT8O4y6fnlTNPsgvJwURigtTbN5S6HbwqRVUnFIDSljGgTGPSJ9pVA2am3bwSzbsQtlF2SOvJqR+bbqdh6YjjtMOIPE83nlNtlqG0nxgDS7amXn2feL93hHu4e7FQQr5+eIwQlKGZSKK6HommGoDb5v8jwZxyD93tIK1muql0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TahcP1yF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-468973c184bso24414525e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758645980; x=1759250780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imzMF9eGcF1IvmXHD33jpPta8P3x9Urk2l5tDJ26VmM=;
        b=TahcP1yFDAKiOKEOPu9wj2beFAoGJVGXaSP/4Eb2vLGrfK9u3mb33bCFKz+/A92wGX
         bh8U0svbUCzR2Wcensn/nvznippgqKYFz06hAtrLQkOapSsv3We/kms2svXsxTGDxo7f
         f/Q3I17t4uyDL12AMXO1K4yy7iiIC3lRX0Qg49OgdMCis7TnaXk0ERULolfoXM65DoKG
         lUc3GzEFv5yO25TLmrZA8gaAcs2UX/ERme2rHXKEZeA+lRv4G95x2c9lAU0FqWSqObWA
         6TOFa1eG3XTnaO1PlfIFh+OZQc0j6Uq5+Ycs6J6rVwNUTs9OOAc1FHPTdfwXk/Jm4eLz
         nbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758645980; x=1759250780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imzMF9eGcF1IvmXHD33jpPta8P3x9Urk2l5tDJ26VmM=;
        b=RR4VwPFhWQ8PCn1tX0C+m0JRrADPZEyewIzzM5wf4wDjG9p6X0Z3EGb8Lpv3UdzqCc
         yPA5+qv1rm/r9ULqsWQnE4H/uRTu8aR16Vfo69oOxOHNR7AWGathaOvozRwZkPc0Fel6
         4IJTrB+wu/SO4vlhdmSdtkR5pmHNAg5y9FePcx2sx+vaS1NnM1dXmsh2kgmzvwAC0fvV
         hq1Jco+h3w2/deDasSLC+zBa67vHrhAZ7xZdEZOb5cqW6Gw0423I3wMdLdjMxRKeBIk7
         5rPYpfNvVHKwQV97UJQud9+ZFnOLQ155ir+lhYMqSATPyC+E5QsdGo3oBJzq5LqIhwGm
         XqhA==
X-Forwarded-Encrypted: i=1; AJvYcCVsvlwf/PgshlekVcoAS+70o+jgLiIAXNKT4VygaZr52s4P6UYp0SAtaEw8f9QUGdC50Q4vPwrQJoYQn7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHCBQ5xc9WORHNPicf0DwrOOIjjfFvsc5QCv2rx6SHJICcwWYa
	i62WZGcqUeUDbG1NiNnLaQa/8QnH6Cvte7q1wglE6ooTMZtpUITcNbqCbAKMyCSAbInGjqA694o
	oXjQoW9lbWCPW7EUtMXIhJhidmahMKwo=
X-Gm-Gg: ASbGncuO0egXyexxWqWv4UN1ZgshNFJY9g80bkeHBVMjesDEZso6jlWCLZE41Z33j3B
	howgMrPRdwazDX72qB1yMdxRJOsiThJrkoLMY/uftg6xl8x3WTK7HGy1gO6w50Y0rXtwu5JQy3g
	ll2ZMnJoApxQSONrATxciSHwNLpod2WMfy1nmC5qOCnnxnUweBfEvCQoS+ns/vegRLxQPgfnTmT
	3wWQEtehw==
X-Google-Smtp-Source: AGHT+IFP8pTY+nYi3192pC7v/zVC0ylFZb4IKvnNmuLy2m/5DZrc79HwlN5a4NAdoI7tQpvEg0iRs5lwN2jl7QYp5Qg=
X-Received: by 2002:a05:6000:25c8:b0:3e7:1f63:6e7d with SMTP id
 ffacd0b85a97d-405ccbd6d4cmr3017672f8f.45.1758645979885; Tue, 23 Sep 2025
 09:46:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919145750.3448393-1-ethan.w.s.graham@gmail.com> <20250919145750.3448393-2-ethan.w.s.graham@gmail.com>
In-Reply-To: <20250919145750.3448393-2-ethan.w.s.graham@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 23 Sep 2025 18:46:08 +0200
X-Gm-Features: AS18NWC3Zatya8SBoZMxgc3ReWws0f2Kk0nbCOoRpJZnpr-tGokn7pV_jWkKaCg
Message-ID: <CA+fCnZegSdAeLkutKP54BH19Kv+FAaFbW1oOvAgbTZZMsyu0sg@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] mm/kasan: implement kasan_poison_range
To: Ethan Graham <ethan.w.s.graham@gmail.com>
Cc: ethangraham@google.com, glider@google.com, andy@kernel.org, 
	brauner@kernel.org, brendan.higgins@linux.dev, davem@davemloft.net, 
	davidgow@google.com, dhowells@redhat.com, dvyukov@google.com, 
	elver@google.com, herbert@gondor.apana.org.au, ignat@cloudflare.com, 
	jack@suse.cz, jannh@google.com, johannes@sipsolutions.net, 
	kasan-dev@googlegroups.com, kees@kernel.org, kunit-dev@googlegroups.com, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lukas@wunner.de, rmoar@google.com, shuah@kernel.org, 
	sj@kernel.org, tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 4:58=E2=80=AFPM Ethan Graham <ethan.w.s.graham@gmai=
l.com> wrote:
>
> From: Ethan Graham <ethangraham@google.com>
>
> Introduce a new helper function, kasan_poison_range(), to encapsulate
> the logic for poisoning an arbitrary memory range of a given size, and
> expose it publically in <include/linux/kasan.h>.
>
> This is a preparatory change for the upcoming KFuzzTest patches, which
> requires the ability to poison the inter-region padding in its input
> buffers.
>
> No functional change to any other subsystem is intended by this commit.
>
> Signed-off-by: Ethan Graham <ethangraham@google.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>
>
> ---
> PR v1:
> - Enforce KASAN_GRANULE_SIZE alignment for the end of the range in
>   kasan_poison_range(), and return -EINVAL when this isn't respected.
> ---
> ---
>  include/linux/kasan.h | 11 +++++++++++
>  mm/kasan/shadow.c     | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 890011071f2b..cd6cdf732378 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -102,6 +102,16 @@ static inline bool kasan_has_integrated_init(void)
>  }
>
>  #ifdef CONFIG_KASAN
> +
> +/**
> + * kasan_poison_range - poison the memory range [@addr, @addr + @size)
> + *
> + * The exact behavior is subject to alignment with KASAN_GRANULE_SIZE, d=
efined
> + * in <mm/kasan/kasan.h>: if @start is unaligned, the initial partial gr=
anule
> + * at the beginning of the range is only poisoned if CONFIG_KASAN_GENERI=
C=3Dy.
> + */
> +int kasan_poison_range(const void *addr, size_t size);
> +
>  void __kasan_unpoison_range(const void *addr, size_t size);
>  static __always_inline void kasan_unpoison_range(const void *addr, size_=
t size)
>  {
> @@ -402,6 +412,7 @@ static __always_inline bool kasan_check_byte(const vo=
id *addr)
>
>  #else /* CONFIG_KASAN */
>
> +static inline int kasan_poison_range(const void *start, size_t size) { r=
eturn 0; }
>  static inline void kasan_unpoison_range(const void *address, size_t size=
) {}
>  static inline void kasan_poison_pages(struct page *page, unsigned int or=
der,
>                                       bool init) {}
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index d2c70cd2afb1..7faed02264f2 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -147,6 +147,40 @@ void kasan_poison(const void *addr, size_t size, u8 =
value, bool init)
>  }
>  EXPORT_SYMBOL_GPL(kasan_poison);
>
> +int kasan_poison_range(const void *addr, size_t size)

This should go into common.c, otherwise this won't be built with the
HW_TAGS mode enabled.

Also, you need a wrapper with a kasan_enabled() check; see how
kasan_unpoison_range() is defined.

> +{
> +       uintptr_t start_addr =3D (uintptr_t)addr;
> +       uintptr_t head_granule_start;
> +       uintptr_t poison_body_start;
> +       uintptr_t poison_body_end;
> +       size_t head_prefix_size;
> +       uintptr_t end_addr;
> +
> +       if ((start_addr + size) % KASAN_GRANULE_SIZE)
> +               return -EINVAL;

Other similar KASAN functions do a WARN_ON(bad alignment). I think
printing a warning is fair for this to force the caller to enforce
proper alignment.

> +
> +       end_addr =3D ALIGN_DOWN(start_addr + size, KASAN_GRANULE_SIZE);

I don't think we need to ALIGN_DOWN(): we already checked that
(start_addr + size) % KASAN_GRANULE_SIZE =3D=3D 0.

> +       if (start_addr >=3D end_addr)
> +               return -EINVAL;

Can also do a WARN_ON().

> +
> +       head_granule_start =3D ALIGN_DOWN(start_addr, KASAN_GRANULE_SIZE)=
;
> +       head_prefix_size =3D start_addr - head_granule_start;
> +
> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC) && head_prefix_size > 0)
> +               kasan_poison_last_granule((void *)head_granule_start,
> +                                         head_prefix_size);

Let's rename kasan_poison_last_granule() to kasan_poison_granule()
then. Here the granule being poisoned is not the last one.


> +
> +       poison_body_start =3D ALIGN(start_addr, KASAN_GRANULE_SIZE);
> +       poison_body_end =3D ALIGN_DOWN(end_addr, KASAN_GRANULE_SIZE);

end_addr is already aligned.


> +
> +       if (poison_body_start < poison_body_end)
> +               kasan_poison((void *)poison_body_start,
> +                            poison_body_end - poison_body_start,
> +                            KASAN_SLAB_REDZONE, false);
> +       return 0;
> +}
> +EXPORT_SYMBOL(kasan_poison_range);
> +
>  #ifdef CONFIG_KASAN_GENERIC
>  void kasan_poison_last_granule(const void *addr, size_t size)
>  {
> --
> 2.51.0.470.ga7dc726c21-goog
>

