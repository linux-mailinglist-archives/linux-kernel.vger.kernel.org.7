Return-Path: <linux-kernel+bounces-802371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9A7B4519B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886AA1C840B0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53DA279DB1;
	Fri,  5 Sep 2025 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UYNJMWU3"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B5A3054D5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061207; cv=none; b=b0bP7ZjXSw6cavOLdy8tL/H5f/BM0mnMZWPKZfjbze0WstlCl2fiF25527dAhd89SHYc09tfboJpsQ61xHwxRAALJqnb7vpuKt3OzKXQiwD35mNg58qNkmZ8Cm5q/z1JR40y1HG0AYSs8+/hQQjLErvN5C+7KRM/GHbu9a7BYmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061207; c=relaxed/simple;
	bh=sERTmrMS6SUba8UigigIzKHhTfdo+49rlFbT2cdDBVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tm1/Q2bUOA68OX7h+NYjlOuFf7jtJrnz3LnsbR6sgN1QdGJNvjRGTTLU8GaF4QBZVfNHrvgKqirj/7jsFV199kFqTiuaTBZUiXFictMdht1IRqhvQ/COdM6B36dYCIwEGexAcRQOUwyF2bkrH5fUiABefyZeLeXM5D44o3hDGJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UYNJMWU3; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-726549f81a6so20067756d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 01:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757061204; x=1757666004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NiGQFhCM+75MKVgSkB143RjF35qXTjKYNYENw01ZAOY=;
        b=UYNJMWU3aTT+J+nDdU0k9/sT+M6oUdTQkqj8Cg5zUYFpELsJtQRouF3rF+yQRSWqy6
         yVdGepR/mPVt1eTaGa4UfkKbswfq1yXoGu/q2NFLj5jlXDhdHwabWnz9XlYMSmAYHiiP
         J4aCOLDoAMoUenPUNkn196OHeaFuuNVIsXbxKCteZK6I065gLmHNHnG/JzgPkIRLx4CC
         tXl/OpJlycwGfuG4MgP+gy6FEiBjm3wJPDBfmRaYLD5rX0EDIjZoPYz0te7YSqPMR3hU
         xooHe96DAAfoa8ip1ne9YtECE3KO2SthqnY2WOS7v29V6MvFkaGj+D5ORb50d0gX7HPW
         obig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757061204; x=1757666004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NiGQFhCM+75MKVgSkB143RjF35qXTjKYNYENw01ZAOY=;
        b=LKJZIJGN6OPcu6vO5qv1chScoRDaBNiIU6H+8AnxVvCuPeMwn4GUMZVFWk9E0ygcj0
         VL82Qo4ui6drHwikY77/vdtOYLn6OX9Aiz09oMku0YlHyC8RYaY6wzGJ+DOGm7ra9D2I
         Ue5QFqc7gRaV7AJ+SfFKNj49lZ3mXpP28oKqsTkJN4Nfph8RRoQAJ1NCFuV9W0WWdjCN
         1Sh0129u00B4HMuHvdFDYHH90jAqLSQIJLzUcnTJP0cThgtOqaOloXUvEjSd4Gsw4KG0
         531h/ValIPhyyTBhFlxnGARTcSwUvwfS99z/oKjUXZoQvYU2kTVZAhV55xyNNKANbb9g
         3vxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjiYtLDsn0NtXZuV8l7WTThW4CzBYInBrh/Z5Wtfd7shxSzp/luXFzUWQjmKC0YHX/4p+Uaw0+JvInsgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEq2hZVFkJN4aw6stGlv4G9Xf+zBIxCNLrb+1jtzWOsELseG/J
	p0ttr36lbs6vAS+mLI237auOG4aO7JQyhkb++lIivHOpsoV0SONRGdFu/2jwiGV18ABXPSkSZ4o
	mA75ooJDoXxHHZI054sPmhxGwNimz9mJtNSgVm8Be
X-Gm-Gg: ASbGnctzFs7nW+++iMRYeIJXTfp4UGd749+7T0/f4GXyd2txa8KXNwQgmN080mpoZrn
	OiCRBhjK6Rbn/HnJzQ63N9Jf72qPnk+qv77HW0v7lwEITb2Xf/M6BdiktkJREkGEVCzALEu5jDX
	MYrMCiuiu4NkdUJFqGhy5Em2Xh6eS8ciVpeXhEFemtPOsejgIf0w/u/55Eo00Nj2Tzn9ETSKZ5X
	FFu1/7UtUkTCPvVA2jMk3mB3W3VwutZ2eVZv3XQmO3o
X-Google-Smtp-Source: AGHT+IH/DBAwk6CJl0zPHvkvyybbJDJwRBFvtKF7fuH7ZxC/t8JRFTJCkN03HH9959f/gxZEw9kh5A4knxtTV8AylRs=
X-Received: by 2002:ad4:5c8d:0:b0:729:4be4:7fdb with SMTP id
 6a1803df08f44-7294be484d2mr55718806d6.52.1757061204289; Fri, 05 Sep 2025
 01:33:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901164212.460229-1-ethan.w.s.graham@gmail.com> <20250901164212.460229-2-ethan.w.s.graham@gmail.com>
In-Reply-To: <20250901164212.460229-2-ethan.w.s.graham@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 5 Sep 2025 10:32:46 +0200
X-Gm-Features: Ac12FXwF_nrqiRF1QRwe4SEL1LOgGhI7gT4sYUe3e0eDMXNCPS7Bt_KSLOk4LK4
Message-ID: <CAG_fn=UfKBSxgcNp5dB3DDoNAnCpDbYoV8HC4BhS7LbgQSpwQw@mail.gmail.com>
Subject: Re: [PATCH v2 RFC 1/7] mm/kasan: implement kasan_poison_range
To: Ethan Graham <ethan.w.s.graham@gmail.com>
Cc: ethangraham@google.com, andreyknvl@gmail.com, brendan.higgins@linux.dev, 
	davidgow@google.com, dvyukov@google.com, jannh@google.com, elver@google.com, 
	rmoar@google.com, shuah@kernel.org, tarasmadan@google.com, 
	kasan-dev@googlegroups.com, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, dhowells@redhat.com, 
	lukas@wunner.de, ignat@cloudflare.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 6:43=E2=80=AFPM Ethan Graham <ethan.w.s.graham@gmail=
.com> wrote:
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
> ---
>  include/linux/kasan.h | 16 ++++++++++++++++
>  mm/kasan/shadow.c     | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 890011071f2b..09baeb6c9f4d 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -102,6 +102,21 @@ static inline bool kasan_has_integrated_init(void)
>  }
>
>  #ifdef CONFIG_KASAN
> +
> +/**
> + * kasan_poison_range - poison the memory range [start, start + size)
> + *
> + * The exact behavior is subject to alignment with KASAN_GRANULE_SIZE, d=
efined
> + * in <mm/kasan/kasan.h>.
> + *
> + * - If @start is unaligned, the initial partial granule at the beginnin=
g
> + *     of the range is only poisoned if CONFIG_KASAN_GENERIC is enabled.

Nit: for consistency with other functions in this header, can we
change @start to @addr?

> + * - The poisoning of the range only extends up to the last full granule=
 before
> + *     the end of the range. Any remaining bytes in a final partial gran=
ule are
> + *     ignored.

Maybe we should require that the end of the range is aligned, as we do
for e.g. kasan_unpoison()?
Are there cases in which we want to call it for non-aligned addresses?

>
> +void kasan_poison_range(const void *start, size_t size)
> +{
> +       void *end =3D (char *)start + size;

There's only a single use of `end` below, so maybe drop this variable
altogether?

> +       uintptr_t start_addr =3D (uintptr_t)start;
> +       uintptr_t head_granule_start;
> +       uintptr_t poison_body_start;
> +       uintptr_t poison_body_end;
> +       size_t head_prefix_size;
> +       uintptr_t end_addr;
> +
> +       end_addr =3D ALIGN_DOWN((uintptr_t)end, KASAN_GRANULE_SIZE);

I suggest making it
       end_addr =3D ALIGN_DOWN((uintptr_t)start + size, KASAN_GRANULE_SIZE)=
;
instead.

