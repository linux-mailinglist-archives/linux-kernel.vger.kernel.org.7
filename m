Return-Path: <linux-kernel+bounces-767932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CA7B25AB1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69AD71C84F91
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A32221A425;
	Thu, 14 Aug 2025 05:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4cys0n2"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B04217734
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 05:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755148230; cv=none; b=VvJwQsXERJQkb+lWMWRLmwfvfk+oHg7NTJYXXKn2CNO4neV7UX4A5ThqymJHSMh8Upq7Dbul40YbkD4zDd30EhH7XxHkCdB3JqVi8+bezqogMHL+ZumduQ75aU8yTlR5bI4ViIOO8cxxpQ52phY3CXq+bKh6Nq2uFWSlTi/VfCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755148230; c=relaxed/simple;
	bh=GqTI8CiJzo/hk3CzqcGhElJMRAbqPYaAyJSNZ1aKfLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qq5HrKg2OquMid6ArFvS2m6XYVkLYR0XfF8eQAmQ6BX26Ozeepci/LvFuV8Twt9qcAk8b0EbEEfYUzuG5vdkWf0qyw9zDSm6YlcbgPspgWXXAdQaMYZRg9rSeTPu8x3QjvUKB2DGkxFKMfsaj2gUhZydxl6iWqxHFVENuQbAOtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4cys0n2; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b9d41d2a5cso392516f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 22:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755148227; x=1755753027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YG44M8DAsMWfH02qr68MhJtAMxD1cxgjmaznwJ5KLJg=;
        b=b4cys0n2wYnnv6cYuu3VBYyx+TSsJrjF4iVzgS09rGeQj/bWT618FAHOiIE/ZgTxus
         UvSnfEe2OQENLfgkBicl0o//kZyWITkXwJ5J3KeJJGFs+JluG/tjLd2pLYJzB8+QBPN0
         HTUk9hRiFiw6Yxl7NCQKiw5AWPcvKFnp7bUdzHp8BcJelx6jQehvJbhOYRQ9iPLMnTyK
         5cwGGjNCgq3aFUVso7EbPIGRkxHn6LSq7o0B0QviRfMvLslTJyXwdU5pUqI47YxjzwKX
         mMN5ra4VvqgoWzGGhymO4ZT++hCY0r7+uaQnC7K1HS8f8n9hVaNtsPKVuEpZ+0btG/YL
         20CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755148227; x=1755753027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YG44M8DAsMWfH02qr68MhJtAMxD1cxgjmaznwJ5KLJg=;
        b=i5PJSROpbC6yMxJ2QLsVtdsLgAVtIFcsxWgzFM+tI/JUPATL0r1VrTOhU5B4Eif0h1
         niYEUzEeb+kl/FYSMmVRUydYAkkvb5Hd5tcKPZMo6IEupX8rx/CqnFmdaxCthUjIZbin
         9b+asMxptT6eETIjxb+e3E221RGVjq03xxhL5GCB9YWwkCCgZbDiJXkd40GX0HsPcsoj
         kTwyzmOMwuodVMGR4t0xmeOz5hrzIem7awFyQ6fqraNuQ6PrL98z1Gdws3o8SpKoUHPc
         aqmEV40To0Wky69osAhtHkWWDIMB8aEj1mQihP09kNzmrm8GUa/8rDlJzSOorpnA84X0
         mDbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwSA0XxznTXGDrNHwp5lLRe1XuAqMeYB0ehvtHdU28jo2yErTXyheMlHoEYpieDZJJByo/1+8UrND4hHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0QD87x5LF8AoxvZKG5wMVec+hdN+wtk36eImD55kLSmF6umDV
	zyNiF0AZ8K1O7d/fbq9Q9CY7cfag84vb+ooa6A99XGp34ae6qjDJjNZhStHflKAXn/xJE5Q6CGX
	HtXJvzXoCuJXCjn8QnDWahGj1DV6vc2U=
X-Gm-Gg: ASbGncv9zXxosm/5/yjM+8cW27Bc67PTv/BQMGsyBBtg27XAgfuG/pn/4ObFrkZt0xr
	PC19nZVcHnAXp4e30ORzYXWpw0SRnSrmTdSDlDLI5MRxlvqwFCbXbRi9GGlPzODcEKTv8/l0ifz
	ud8jc2Rg57i0wM1Faa27Y12Ixts51YcE5tZwikrZ+vwzvqDatkfgivelfX5FevxdAtH1DFB/wBt
	9Gxvlj6gw==
X-Google-Smtp-Source: AGHT+IH3bvcgyzK2aNX18ueV/bOIy3e/jd4WyTGOc9ODs07/SX5JFC5qL+4zGrhveyP0GsCspj9sbn3SUabDgrFM/es=
X-Received: by 2002:a05:6000:402b:b0:3b7:6d95:56d2 with SMTP id
 ffacd0b85a97d-3b9edf1ad3cmr1303620f8f.7.1755148227128; Wed, 13 Aug 2025
 22:10:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729-kasan-tsbrcu-noquarantine-test-v2-1-d16bd99309c9@google.com>
In-Reply-To: <20250729-kasan-tsbrcu-noquarantine-test-v2-1-d16bd99309c9@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 14 Aug 2025 07:10:16 +0200
X-Gm-Features: Ac12FXwk3idO9PD5EAG_isCaljN_b1Avcx5rr-Mcqh7uJPexNYhAO5AIw0nkzeM
Message-ID: <CA+fCnZeuewqXSW0ZKCMkL-Cv-0vV6HthJ_sbUFR9ZDU6PmzT-g@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: add test for SLAB_TYPESAFE_BY_RCU quarantine skipping
To: Jann Horn <jannh@google.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 6:49=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> Verify that KASAN does not quarantine objects in SLAB_TYPESAFE_BY_RCU sla=
bs
> if CONFIG_SLUB_RCU_DEBUG is off.
>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> changes in v2:
>  - disable migration to ensure that all SLUB operations use the same
>    percpu state (vbabka)
>  - use EXPECT instead of ASSERT for pointer equality check so that
>    expectation failure doesn't terminate the test with migration still
>    disabled
> ---
>  mm/kasan/kasan_test_c.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> index 5f922dd38ffa..0d50402d492c 100644
> --- a/mm/kasan/kasan_test_c.c
> +++ b/mm/kasan/kasan_test_c.c
> @@ -1073,6 +1073,43 @@ static void kmem_cache_rcu_uaf(struct kunit *test)
>         kmem_cache_destroy(cache);
>  }
>
> +/*
> + * Check that SLAB_TYPESAFE_BY_RCU objects are immediately reused when
> + * CONFIG_SLUB_RCU_DEBUG is off, and stay at the same address.

Would be great to also add an explanation of why we want to test for
this (or a reference to the related fix commit?).

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

I think this might fail for the HW_TAGS mode? The location will be
reused, but the tag will be different.

We could mark this test as Generic mode only.

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
> @@ -2098,6 +2135,7 @@ static struct kunit_case kasan_kunit_test_cases[] =
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

Thank you!

