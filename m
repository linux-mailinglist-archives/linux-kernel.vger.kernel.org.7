Return-Path: <linux-kernel+bounces-770242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E434EB278DD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAFC31CE7FBD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34897293C42;
	Fri, 15 Aug 2025 06:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Crp0b2az"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAA029B8C6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 06:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755238154; cv=none; b=icz5nViSkJq7SYBlSR+ZhEDry/E8KLUXnXpmH9EuCKzZbOiirl2kG7qxfoRwx1T55Qb+SvYAovjasepceCYUIEdimPW9aMFODx7rm5XytCWMJQ0odUTwGLLJoysFR8xwTauNNbjntJ5Fkw3Q+e1XOQf/CguY8eJDSeCC8AQ/URk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755238154; c=relaxed/simple;
	bh=kMghrynXmV/DamG0ADVvmxoSsDyOOnSN6O5WgCijujo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDrvYAyAj6ufY7k6Jah29dsOZl06Ls3OF00hsGW++40V8eUU5Fi0wGEgke8TCRN2prHl7CnJ/uvb+x8Z5//j5ZtiusNJmuRN8nN55KtKp/5HN2FaJ1a1lYjpvxBOrUThvkVBrofXGoXyk/dNCtm5B/5Kt5zzbEPKIcMYq+osLto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Crp0b2az; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b9e414252dso834278f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 23:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755238151; x=1755842951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wACT+FdhCtuGzqGpHgePPwt5rag7S82b8o2EOM9TWRM=;
        b=Crp0b2azni/WQ1BzgqJdbZIBvk4Jdp7dV5+aUru4mBO7Q8v/pdrgr6px25t67dDW5n
         etdAZEiynsoeyK7+IN1bxjjZi7jEAYLefLTv9B+zjBPL9RFHMV2jYlyf/6gzJQT6rhxg
         4l/o2GGTOnQvGTAfFt39Y4KYRa5013gzRzJOqoW0G8+jyrP9czoa8InWPC2bLLOc8B2L
         ND7sg0UBW9MB/9Avz32crHqc3ai6PMhy+Cq1+PwOZvDfjeJOJbGxdtJOMpmNLls6sW1g
         Ozeo4eiAtfWqQDsi7AUIj+szED7qDNmtPJlLqm42JPHQcxQSQCVjVYkeqHTv0k7cy036
         qW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755238151; x=1755842951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wACT+FdhCtuGzqGpHgePPwt5rag7S82b8o2EOM9TWRM=;
        b=vDsHjxgN928RPJRNqSTej0QkIBnygfoNwaWS90A8Bm6GvYHJt2wuQHMbG4gS5sJnFQ
         rai+U8oiY7QqxgEt34Cqm4gyjFpO+i6TDcUtTBELBph+5NnPfd2CnODQ6/oAPieTq97U
         CyzOi8ICrVBxhOaH9pOXlMgVD8gQ4pM+X+5NkEnrErguN4k5Br9ucuNsoB2VnXoRVdtj
         N9eFzzX14OIjdJJ64WlHYumk+7H/wUIxjL0aFgk9GXxMOsQxLPOIFzaY4Zykjtnu28qb
         DGx7YpvqBNusHovoc3uqSgZVCpiAGPmkB1VKYF/NkmisXeoFaLxwS2tsT7knmeOTif8R
         yp3g==
X-Forwarded-Encrypted: i=1; AJvYcCWJDpPVF/QOxCdW17jushAI8Dogs33mdC23/EUZ1jjcbuJmSdzzi/38sIeFU2bOgaLg6YCBWzljynqOyjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy8iixQ61WjKO/XfR1f3E8EHh+qcn6iqvTKzSomkxO3QcJWX1v
	4PyFG9D4XycX1MUwmKIFCGy1TEQmjuHr3H3kpwBywyqIQPxWFXwUGy4csszoWFpvw+rUq5W5P+g
	5IFdodm1ZAWc9sD/Rr+w+aJqPFLu5lZE=
X-Gm-Gg: ASbGncuvzhYvj2ITQe6MkBSgUarTMGhSHjwdlyYR5Xm1qtr1o8g8KAtx6m9o5xV2GIr
	9uUTFBLRZ6H9oI8avuo7ZIDv89q1rWJqzU9KZFM9EzapY1Lx4tSwb7i0x7pEoGB8UwYNe/wRsEe
	AgFFKwzm0EuDBHjfbyabJZ+u16gzbpXzZOgqjjtO8H9zi0ttm6o/yYJA6sIkkR+8RaxUXGf8QM/
	aFfBvvw
X-Google-Smtp-Source: AGHT+IEmY4UxHNmzT5mmcGJ5yVWYiyyr32yQzIRK7G4RTu5taVUk+2ZjZyZEW43hZqMKpqbwNBeamGx203WJvwXYLvY=
X-Received: by 2002:a05:6000:25c2:b0:3b7:926f:894c with SMTP id
 ffacd0b85a97d-3bb675d3c7bmr406864f8f.23.1755238150774; Thu, 14 Aug 2025
 23:09:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814-kasan-tsbrcu-noquarantine-test-v3-1-9e9110009b4e@google.com>
In-Reply-To: <20250814-kasan-tsbrcu-noquarantine-test-v3-1-9e9110009b4e@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 15 Aug 2025 08:08:59 +0200
X-Gm-Features: Ac12FXw5QESzTXxkbg4UmhQH3TfIEeRhPi07Vg1NeAqS36aDi6tcJzP5tYrOvmc
Message-ID: <CA+fCnZcNy5NGL38YdKiqTVYeO2dAp_VEKHe6iOEo49H15X8gzw@mail.gmail.com>
Subject: Re: [PATCH v3] kasan: add test for SLAB_TYPESAFE_BY_RCU quarantine skipping
To: Jann Horn <jannh@google.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 5:11=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> Verify that KASAN does not quarantine objects in SLAB_TYPESAFE_BY_RCU sla=
bs
> if CONFIG_SLUB_RCU_DEBUG is off.
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> Changes in v3:
>  - add vbabka's ack
>  - make comment more verbose (andreyknvl)
>  - Link to v2: https://lore.kernel.org/r/20250729-kasan-tsbrcu-noquaranti=
ne-test-v2-1-d16bd99309c9@google.com
> Changes in v2:
>  - disable migration to ensure that all SLUB operations use the same
>    percpu state (vbabka)
>  - use EXPECT instead of ASSERT for pointer equality check so that
>    expectation failure doesn't terminate the test with migration still
>    disabled
> ---
>  mm/kasan/kasan_test_c.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> index 5f922dd38ffa..0affadb201c2 100644
> --- a/mm/kasan/kasan_test_c.c
> +++ b/mm/kasan/kasan_test_c.c
> @@ -1073,6 +1073,45 @@ static void kmem_cache_rcu_uaf(struct kunit *test)
>         kmem_cache_destroy(cache);
>  }
>
> +/*
> + * Check that SLAB_TYPESAFE_BY_RCU objects are immediately reused when
> + * CONFIG_SLUB_RCU_DEBUG is off, and stay at the same address.
> + * Without this, KASAN builds would be unable to trigger bugs caused by
> + * SLAB_TYPESAFE_BY_RCU users handling reycled objects improperly.
> + */
> +static void kmem_cache_rcu_reuse(struct kunit *test)
> +{
> +       char *p, *p2;
> +       struct kmem_cache *cache;
> +
> +       KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_SLUB_RCU_DEBUG);
> +
> +       cache =3D kmem_cache_create("test_cache", 16, 0, SLAB_TYPESAFE_BY=
_RCU,
> +                                 NULL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cache);
> +
> +       migrate_disable();
> +       p =3D kmem_cache_alloc(cache, GFP_KERNEL);
> +       if (!p) {
> +               kunit_err(test, "Allocation failed: %s\n", __func__);
> +               goto out;
> +       }
> +
> +       kmem_cache_free(cache, p);
> +       p2 =3D kmem_cache_alloc(cache, GFP_KERNEL);
> +       if (!p2) {
> +               kunit_err(test, "Allocation failed: %s\n", __func__);
> +               goto out;
> +       }
> +       KUNIT_EXPECT_PTR_EQ(test, p, p2);
> +
> +       kmem_cache_free(cache, p2);
> +
> +out:
> +       migrate_enable();
> +       kmem_cache_destroy(cache);
> +}
> +
>  static void kmem_cache_double_destroy(struct kunit *test)
>  {
>         struct kmem_cache *cache;
> @@ -2098,6 +2137,7 @@ static struct kunit_case kasan_kunit_test_cases[] =
=3D {
>         KUNIT_CASE(kmem_cache_double_free),
>         KUNIT_CASE(kmem_cache_invalid_free),
>         KUNIT_CASE(kmem_cache_rcu_uaf),
> +       KUNIT_CASE(kmem_cache_rcu_reuse),
>         KUNIT_CASE(kmem_cache_double_destroy),
>         KUNIT_CASE(kmem_cache_accounted),
>         KUNIT_CASE(kmem_cache_bulk),
>
> ---
> base-commit: 0df7d6c9705b283d5b71ee0ae86ead05bd3a55a9
> change-id: 20250728-kasan-tsbrcu-noquarantine-test-5c723367e056
> prerequisite-change-id: 20250723-kasan-tsbrcu-noquarantine-e207bb990e24:v=
1
> prerequisite-patch-id: 4fab9d3a121bfcaacc32a40f606b7c04e0c6fdd0
>
> --
> Jann Horn <jannh@google.com>
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thank you!

