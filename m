Return-Path: <linux-kernel+bounces-767930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF45B25AAD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61EA1C83E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85BC1DFE0B;
	Thu, 14 Aug 2025 05:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJKUc3Gs"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4170E1A08A4;
	Thu, 14 Aug 2025 05:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755147865; cv=none; b=AovrLhdCdQ23K4PXAWTL61g5GaVWkCo5UMoP2npXEzof9/fAu+B++a7r90oCVjznB1AQ+JjBGk37xLErFzdVOz0OxDWvONFDMQR4gULwi8qunU9FbYdK8LZvdXtuF4W7Nb56VrznO9qSaaqqcf/giV0/k4qCaYzJzp/V1Tlil0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755147865; c=relaxed/simple;
	bh=+PV2gLsvoTASKKWszWXqo9Dvl0wZ+PHT5lJWgS6t8lM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gU8pb1dEs472J/0pynyG93BQoX0waVDEP3I28saeS9p2f0kaO5YWUOzY9laGvEuZ1g+rD6YIUBgcQdAZ/h9gr1gUsVQGKzf4/f9kJgZwUeknKPR60BjRsAKFXe9+56gD53G0DnS+d6eAQ15cur+Iz0bWdfWg4azOVunzHyQKxwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJKUc3Gs; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9d41bfa35so404562f8f.0;
        Wed, 13 Aug 2025 22:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755147860; x=1755752660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCWbVPquEv5y1FRnrw2PZ9CdMWwpcBL4OO25oZxPA2M=;
        b=GJKUc3Gs7e9UkICAx/XUqOEps7JsZUZ6kJefPTmQKj4gSm9bkLF479NHPJILraGkGz
         zum8YzN2Dmpbh7PBaEsHHaP23nqubw4u12sfWW48d+HjqJptKFrET7u3w9srGIqMftUz
         b9eFmtvyQ29TC071LmjsEnxJiVnMQdnrr/J0C3bXsns+9CLNnbyyXMf/3O/u7Z6mpLA1
         Jld3QZ/m7cOEHMSt7LxNYB5W/Y6UYOeP2rVwR0CunKui7kNcXyiX9GdVG/2lYzK8MSfN
         QX64b3Zm2/NMnP1AP2zuXEOmtEMctmL/FTw8EIdftlgObasJCFIPJ87hn9eyLqnSroVQ
         hrcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755147860; x=1755752660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCWbVPquEv5y1FRnrw2PZ9CdMWwpcBL4OO25oZxPA2M=;
        b=XFje8f5i6sDP17YNzC3uEtjqME0tOyMmZr+TL5uarHXnIXd82sB4B3NAxdtnL+3uvW
         ghKyPAOTBZGxsp9b4Wl1oQc6YIOqKm0G2of8U0lqNd5gnNvUVkCpRzhK9UGdCWgcIJDK
         e4InX9et48hPB7BH0fsZJlO14A+lU8t/1q/LXuONEBXuiEGDtIP9vklnsm5g+y3IjoS4
         PlwGGECkSgBL2k2bwJaZ8e/HnENKvDKSWm4BWptRRyUNSMY6kWjmyeqn4RPySEe4CEeo
         8tZi3mEfLXn87oGAuMW3r/LX1CP+2uuXXJcvxfAAUbczRcwDHs20nZzB3zBDdg+Wg4os
         gMjg==
X-Forwarded-Encrypted: i=1; AJvYcCVGwcKG3gNtGFYKM5+fFk0Q01ZkuYe6r/vWVE639Aov0AjqvfnBnyzcMBPOhC5zWZLbfgUCysvRXZo=@vger.kernel.org, AJvYcCXEQcqY42k4WcXDXMX9T7JPwSTex30fK6Vw3eP7g6DM5TsNInBxFxbt4pKKWDdrFFHJHqqBgmRg8hXa6TPq@vger.kernel.org, AJvYcCXaICyqns0hPmaMMmAssS1BJ4otlNT17CdB3CjsOja7qK2gAOAFDPiVxvP/6++ZRfSTdsrG44e7btkp@vger.kernel.org
X-Gm-Message-State: AOJu0YwbQZ/Ujk7ap4j0nbbCV06PCDAyknDK/6aT9IsYFX7DX9yC+6ou
	dWIgLB4B0hcellX6K7FiGqFsNTP4fed9KJfDki44x+fmRGkTyFSTrjyFxL0yEHlby3tXrr1zlbK
	NPNDDFQs3Q5c7sgWsvYo/2fJ/zDAoTbc=
X-Gm-Gg: ASbGncuOz2BUV7SxKqdTAq839aYNYGEfzy7dVjyki+rwtfpiPz+67SDeObv/UBAGEZe
	75OFrUVZwIfhfw7xdhAYO/2hxBR2z/4o6McCELBoOOEl4G0qGaA/SZdS5KKjCpwfvbBtRgUNmmc
	1CcD5PdX6xWsFvcuF6mkKQdy2LweqkznM1g+hRUXr0Z2+XTWNneo2t2Z/TcYvkfsw+ylIhUn+8v
	huBe0XmEmxQsdY9XEcc
X-Google-Smtp-Source: AGHT+IFLJ+cAjhzkSNH+CuXsF4vI5bOc8BeId+vHtA8XwPrwD04ikN55fvK4aJ5sqm4jpjqhvwVeIm7rxYIEdxHb8EU=
X-Received: by 2002:a05:6000:1a8d:b0:3a4:fea6:d49f with SMTP id
 ffacd0b85a97d-3b9edf45fc3mr1190013f8f.49.1755147859952; Wed, 13 Aug 2025
 22:04:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813175335.3980268-1-yeoreum.yun@arm.com> <20250813175335.3980268-3-yeoreum.yun@arm.com>
In-Reply-To: <20250813175335.3980268-3-yeoreum.yun@arm.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 14 Aug 2025 07:04:08 +0200
X-Gm-Features: Ac12FXyLOyZaE_ECpYWEVQi7GnbEZOQMKRL2nuRgMWfUkOASyV2tF222LbrEdfg
Message-ID: <CA+fCnZeT2J7W62Ydv0AuDLC13wO-VrH1Q_uqhkZbGLqc4Ktf5g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kasan: apply store-only mode in kasan kunit testcases
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com, 
	vincenzo.frascino@arm.com, corbet@lwn.net, catalin.marinas@arm.com, 
	will@kernel.org, akpm@linux-foundation.org, scott@os.amperecomputing.com, 
	jhubbard@nvidia.com, pankaj.gupta@amd.com, leitao@debian.org, 
	kaleshsingh@google.com, maz@kernel.org, broonie@kernel.org, 
	oliver.upton@linux.dev, james.morse@arm.com, ardb@kernel.org, 
	hardevsinh.palaniya@siliconsignals.io, david@redhat.com, 
	yang@os.amperecomputing.com, kasan-dev@googlegroups.com, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 7:53=E2=80=AFPM Yeoreum Yun <yeoreum.yun@arm.com> w=
rote:
>
> When KASAN is configured in store-only mode,
> fetch/load operations do not trigger tag check faults.
>
> As a result, the outcome of some test cases may differ
> compared to when KASAN is configured without store-only mode.
>
> Therefore, by modifying pre-exist testcases
> check the store only makes tag check fault (TCF) where
> writing is perform in "allocated memory" but tag is invalid
> (i.e) redzone write in atomic_set() testcases.
> Otherwise check the invalid fetch/read doesn't generate TCF.
>
> Also, skip some testcases affected by initial value
> (i.e) atomic_cmpxchg() testcase maybe successd if
> it passes valid atomic_t address and invalid oldaval address.
> In this case, if invalid atomic_t doesn't have the same oldval,
> it won't trigger store operation so the test will pass.
>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  mm/kasan/kasan_test_c.c | 366 +++++++++++++++++++++++++++++++---------
>  1 file changed, 286 insertions(+), 80 deletions(-)
>
> diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> index 2aa12dfa427a..e5d08a6ee3a2 100644
> --- a/mm/kasan/kasan_test_c.c
> +++ b/mm/kasan/kasan_test_c.c
> @@ -94,11 +94,13 @@ static void kasan_test_exit(struct kunit *test)
>  }
>
>  /**
> - * KUNIT_EXPECT_KASAN_FAIL - check that the executed expression produces=
 a
> - * KASAN report; causes a KUnit test failure otherwise.
> + * _KUNIT_EXPECT_KASAN_TEMPLATE - check that the executed expression pro=
duces
> + * a KASAN report or not; a KUnit test failure when it's different from =
@produce.
>   *
>   * @test: Currently executing KUnit test.
> - * @expression: Expression that must produce a KASAN report.
> + * @expr: Expression produce a KASAN report or not.
> + * @expr_str: Expression string
> + * @produce: expression should produce a KASAN report.
>   *
>   * For hardware tag-based KASAN, when a synchronous tag fault happens, t=
ag
>   * checking is auto-disabled. When this happens, this test handler reena=
bles
> @@ -110,25 +112,29 @@ static void kasan_test_exit(struct kunit *test)
>   * Use READ/WRITE_ONCE() for the accesses and compiler barriers around t=
he
>   * expression to prevent that.
>   *
> - * In between KUNIT_EXPECT_KASAN_FAIL checks, test_status.report_found i=
s kept
> + * In between _KUNIT_EXPECT_KASAN_TEMPLATE checks, test_status.report_fo=
und is kept
>   * as false. This allows detecting KASAN reports that happen outside of =
the
>   * checks by asserting !test_status.report_found at the start of
> - * KUNIT_EXPECT_KASAN_FAIL and in kasan_test_exit.
> + * _KUNIT_EXPECT_KASAN_TEMPLATE and in kasan_test_exit.
>   */
> -#define KUNIT_EXPECT_KASAN_FAIL(test, expression) do {                 \
> +#define _KUNIT_EXPECT_KASAN_TEMPLATE(test, expr, expr_str, produce)    \
> +do {                                                                   \
>         if (IS_ENABLED(CONFIG_KASAN_HW_TAGS) &&                         \
>             kasan_sync_fault_possible())                                \
>                 migrate_disable();                                      \
>         KUNIT_EXPECT_FALSE(test, READ_ONCE(test_status.report_found));  \
>         barrier();                                                      \
> -       expression;                                                     \
> +       expr;                                                           \
>         barrier();                                                      \
>         if (kasan_async_fault_possible())                               \
>                 kasan_force_async_fault();                              \
> -       if (!READ_ONCE(test_status.report_found)) {                     \
> -               KUNIT_FAIL(test, KUNIT_SUBTEST_INDENT "KASAN failure "  \
> -                               "expected in \"" #expression            \
> -                                "\", but none occurred");              \
> +       if (READ_ONCE(test_status.report_found) !=3D produce) {          =
 \
> +               KUNIT_FAIL(test, KUNIT_SUBTEST_INDENT "KASAN %s "       \
> +                               "expected in \"" expr_str               \
> +                                "\", but %soccurred",                  \
> +                               (produce ? "failure" : "success"),      \
> +                               (test_status.report_found ?             \
> +                                "" : "none "));                        \
>         }                                                               \
>         if (IS_ENABLED(CONFIG_KASAN_HW_TAGS) &&                         \
>             kasan_sync_fault_possible()) {                              \
> @@ -141,6 +147,26 @@ static void kasan_test_exit(struct kunit *test)
>         WRITE_ONCE(test_status.async_fault, false);                     \
>  } while (0)
>
> +/*
> + * KUNIT_EXPECT_KASAN_FAIL - check that the executed expression produces=
 a
> + * KASAN report; causes a KUnit test failure otherwise.
> + *
> + * @test: Currently executing KUnit test.
> + * @expr: Expression produce a KASAN report.
> + */
> +#define KUNIT_EXPECT_KASAN_FAIL(test, expr)                    \
> +       _KUNIT_EXPECT_KASAN_TEMPLATE(test, expr, #expr, true)
> +
> +/*
> + * KUNIT_EXPECT_KASAN_SUCCESS - check that the executed expression doesn=
't
> + * produces a KASAN report; causes a KUnit test failure otherwise.

Should be no need for this, the existing functionality already checks
that there are no reports outside of KUNIT_EXPECT_KASAN_FAIL().

> + *
> + * @test: Currently executing KUnit test.
> + * @expr: Expression doesn't produce a KASAN report.
> + */
> +#define KUNIT_EXPECT_KASAN_SUCCESS(test, expr)                 \
> +       _KUNIT_EXPECT_KASAN_TEMPLATE(test, expr, #expr, false)
> +
>  #define KASAN_TEST_NEEDS_CONFIG_ON(test, config) do {                  \
>         if (!IS_ENABLED(config))                                        \
>                 kunit_skip((test), "Test requires " #config "=3Dy");     =
 \
> @@ -183,8 +209,12 @@ static void kmalloc_oob_right(struct kunit *test)
>         KUNIT_EXPECT_KASAN_FAIL(test, ptr[size + 5] =3D 'y');
>
>         /* Out-of-bounds access past the aligned kmalloc object. */
> -       KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] =3D
> -                                       ptr[size + KASAN_GRANULE_SIZE + 5=
]);
> +       if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, ptr[0] =3D
> +                                               ptr[size + KASAN_GRANULE_=
SIZE + 5]);
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] =3D
> +                                               ptr[size + KASAN_GRANULE_=
SIZE + 5]);

Let's instead add KUNIT_EXPECT_KASAN_FAIL_READ() that only expects a
KASAN report when the store-only mode is not enabled. And use that for
the bad read accesses done in tests.


>
>         kfree(ptr);
>  }
> @@ -198,7 +228,11 @@ static void kmalloc_oob_left(struct kunit *test)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
>         OPTIMIZER_HIDE_VAR(ptr);
> -       KUNIT_EXPECT_KASAN_FAIL(test, *ptr =3D *(ptr - 1));
> +       if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, *ptr =3D *(ptr - 1));
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test, *ptr =3D *(ptr - 1));
> +
>         kfree(ptr);
>  }
>
> @@ -211,7 +245,11 @@ static void kmalloc_node_oob_right(struct kunit *tes=
t)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
>         OPTIMIZER_HIDE_VAR(ptr);
> -       KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] =3D ptr[size]);
> +       if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, ptr[0] =3D ptr[size]);
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] =3D ptr[size]);
> +
>         kfree(ptr);
>  }
>
> @@ -291,7 +329,10 @@ static void kmalloc_large_uaf(struct kunit *test)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>         kfree(ptr);
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[0]);
> +       if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, ((volatile char *)ptr)[0=
]);
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[0]);
>  }
>
>  static void kmalloc_large_invalid_free(struct kunit *test)
> @@ -323,7 +364,11 @@ static void page_alloc_oob_right(struct kunit *test)
>         ptr =3D page_address(pages);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] =3D ptr[size]);
> +       if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, ptr[0] =3D ptr[size]);
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] =3D ptr[size]);
> +
>         free_pages((unsigned long)ptr, order);
>  }
>
> @@ -338,7 +383,10 @@ static void page_alloc_uaf(struct kunit *test)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>         free_pages((unsigned long)ptr, order);
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[0]);
> +       if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, ((volatile char *)ptr)[0=
]);
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[0]);
>  }
>
>  static void krealloc_more_oob_helper(struct kunit *test,
> @@ -455,10 +503,13 @@ static void krealloc_uaf(struct kunit *test)
>         ptr1 =3D kmalloc(size1, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
>         kfree(ptr1);
> -
>         KUNIT_EXPECT_KASAN_FAIL(test, ptr2 =3D krealloc(ptr1, size2, GFP_=
KERNEL));
>         KUNIT_ASSERT_NULL(test, ptr2);
> -       KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)ptr1);
> +
> +       if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, *(volatile char *)ptr1);
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)ptr1);
>  }
>
>  static void kmalloc_oob_16(struct kunit *test)
> @@ -501,7 +552,11 @@ static void kmalloc_uaf_16(struct kunit *test)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
>         kfree(ptr2);
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, *ptr1 =3D *ptr2);
> +       if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, *ptr1 =3D *ptr2);
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test, *ptr1 =3D *ptr2);
> +
>         kfree(ptr1);
>  }
>
> @@ -640,8 +695,14 @@ static void kmalloc_memmove_invalid_size(struct kuni=
t *test)
>         memset((char *)ptr, 0, 64);
>         OPTIMIZER_HIDE_VAR(ptr);
>         OPTIMIZER_HIDE_VAR(invalid_size);
> -       KUNIT_EXPECT_KASAN_FAIL(test,
> -               memmove((char *)ptr, (char *)ptr + 4, invalid_size));
> +
> +       if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test,
> +                       memmove((char *)ptr, (char *)ptr + 4, invalid_siz=
e));
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test,
> +                       memmove((char *)ptr, (char *)ptr + 4, invalid_siz=
e));
> +
>         kfree(ptr);
>  }
>
> @@ -654,7 +715,11 @@ static void kmalloc_uaf(struct kunit *test)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
>         kfree(ptr);
> -       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[8]);
> +
> +       if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, ((volatile char *)ptr)[8=
]);
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[8]);
>  }
>
>  static void kmalloc_uaf_memset(struct kunit *test)
> @@ -701,7 +766,11 @@ static void kmalloc_uaf2(struct kunit *test)
>                 goto again;
>         }
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr1)[40]);
> +       if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, ((volatile char *)ptr1)[=
40]);
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr1)[40]=
);
> +
>         KUNIT_EXPECT_PTR_NE(test, ptr1, ptr2);
>
>         kfree(ptr2);
> @@ -727,19 +796,33 @@ static void kmalloc_uaf3(struct kunit *test)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
>         kfree(ptr2);
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr1)[8]);
> +       if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, ((volatile char *)ptr1)[=
8]);
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr1)[8])=
;
>  }
>
>  static void kasan_atomics_helper(struct kunit *test, void *unsafe, void =
*safe)
>  {
>         int *i_unsafe =3D unsafe;
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, READ_ONCE(*i_unsafe));
> +       if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, READ_ONCE(*i_unsafe));
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test, READ_ONCE(*i_unsafe));
> +
>         KUNIT_EXPECT_KASAN_FAIL(test, WRITE_ONCE(*i_unsafe, 42));
> -       KUNIT_EXPECT_KASAN_FAIL(test, smp_load_acquire(i_unsafe));
> +       if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, smp_load_acquire(i_unsaf=
e));
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test, smp_load_acquire(i_unsafe))=
;
>         KUNIT_EXPECT_KASAN_FAIL(test, smp_store_release(i_unsafe, 42));
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, atomic_read(unsafe));
> +       if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, atomic_read(unsafe));
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test, atomic_read(unsafe));
> +
>         KUNIT_EXPECT_KASAN_FAIL(test, atomic_set(unsafe, 42));
>         KUNIT_EXPECT_KASAN_FAIL(test, atomic_add(42, unsafe));
>         KUNIT_EXPECT_KASAN_FAIL(test, atomic_sub(42, unsafe));
> @@ -752,18 +835,38 @@ static void kasan_atomics_helper(struct kunit *test=
, void *unsafe, void *safe)
>         KUNIT_EXPECT_KASAN_FAIL(test, atomic_xchg(unsafe, 42));
>         KUNIT_EXPECT_KASAN_FAIL(test, atomic_cmpxchg(unsafe, 21, 42));
>         KUNIT_EXPECT_KASAN_FAIL(test, atomic_try_cmpxchg(unsafe, safe, 42=
));
> -       KUNIT_EXPECT_KASAN_FAIL(test, atomic_try_cmpxchg(safe, unsafe, 42=
));
> +
> +       /*
> +        * The result of the test below may vary due to garbage values of=
 unsafe in
> +        * store-only mode. Therefore, skip this test when KASAN is confi=
gured
> +        * in store-only mode.
> +        */
> +       if (!kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_FAIL(test, atomic_try_cmpxchg(safe, un=
safe, 42));
> +
>         KUNIT_EXPECT_KASAN_FAIL(test, atomic_sub_and_test(42, unsafe));
>         KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec_and_test(unsafe));
>         KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc_and_test(unsafe));
>         KUNIT_EXPECT_KASAN_FAIL(test, atomic_add_negative(42, unsafe));
> -       KUNIT_EXPECT_KASAN_FAIL(test, atomic_add_unless(unsafe, 21, 42));
> -       KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc_not_zero(unsafe));
> -       KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc_unless_negative(unsafe))=
;
> -       KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec_unless_positive(unsafe))=
;
> -       KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec_if_positive(unsafe));
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_read(unsafe));
> +       /*
> +        * The result of the test below may vary due to garbage values of=
 unsafe in
> +        * store-only mode. Therefore, skip this test when KASAN is confi=
gured
> +        * in store-only mode.
> +        */
> +       if (!kasan_store_only_enabled()) {
> +               KUNIT_EXPECT_KASAN_FAIL(test, atomic_add_unless(unsafe, 2=
1, 42));
> +               KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc_not_zero(unsafe)=
);
> +               KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc_unless_negative(=
unsafe));
> +               KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec_unless_positive(=
unsafe));
> +               KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec_if_positive(unsa=
fe));
> +       }
> +
> +       if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, atomic_long_read(unsafe)=
);
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_read(unsafe));
> +
>         KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_set(unsafe, 42));
>         KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_add(42, unsafe));
>         KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_sub(42, unsafe));
> @@ -776,16 +879,32 @@ static void kasan_atomics_helper(struct kunit *test=
, void *unsafe, void *safe)
>         KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_xchg(unsafe, 42));
>         KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_cmpxchg(unsafe, 21, 42)=
);
>         KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_try_cmpxchg(unsafe, saf=
e, 42));
> -       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_try_cmpxchg(safe, unsaf=
e, 42));
> +
> +       /*
> +        * The result of the test below may vary due to garbage values in
> +        * store-only mode. Therefore, skip this test when KASAN is confi=
gured
> +        * in store-only mode.
> +        */
> +       if (!kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_try_cmpxchg(saf=
e, unsafe, 42));
> +
>         KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_sub_and_test(42, unsafe=
));
>         KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_dec_and_test(unsafe));
>         KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_inc_and_test(unsafe));
>         KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_add_negative(42, unsafe=
));
> -       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_add_unless(unsafe, 21, =
42));
> -       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_inc_not_zero(unsafe));
> -       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_inc_unless_negative(uns=
afe));
> -       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_dec_unless_positive(uns=
afe));
> -       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_dec_if_positive(unsafe)=
);
> +
> +       /*
> +        * The result of the test below may vary due to garbage values in
> +        * store-only mode. Therefore, skip this test when KASAN is confi=
gured
> +        * in store-only mode.
> +        */
> +       if (!kasan_store_only_enabled()) {
> +               KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_add_unless(unsa=
fe, 21, 42));
> +               KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_inc_not_zero(un=
safe));
> +               KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_inc_unless_nega=
tive(unsafe));
> +               KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_dec_unless_posi=
tive(unsafe));
> +               KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_dec_if_positive=
(unsafe));
> +       }
>  }
>
>  static void kasan_atomics(struct kunit *test)
> @@ -842,8 +961,14 @@ static void ksize_unpoisons_memory(struct kunit *tes=
t)
>         /* These must trigger a KASAN report. */
>         if (IS_ENABLED(CONFIG_KASAN_GENERIC))
>                 KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size=
]);
> -       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size + 5]);
> -       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[real_size - =
1]);
> +
> +       if (kasan_store_only_enabled()) {
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, ((volatile char *)ptr)[s=
ize + 5]);
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, ((volatile char *)ptr)[r=
eal_size - 1]);
> +       } else {
> +               KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size=
 + 5]);
> +               KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[real=
_size - 1]);
> +       }
>
>         kfree(ptr);
>  }
> @@ -863,8 +988,13 @@ static void ksize_uaf(struct kunit *test)
>
>         OPTIMIZER_HIDE_VAR(ptr);
>         KUNIT_EXPECT_KASAN_FAIL(test, ksize(ptr));
> -       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[0]);
> -       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size]);
> +       if (kasan_store_only_enabled()) {
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, ((volatile char *)ptr)[0=
]);
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, ((volatile char *)ptr)[s=
ize]);
> +       } else {
> +               KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[0]);
> +               KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size=
]);
> +       }
>  }
>
>  /*
> @@ -886,6 +1016,7 @@ static void rcu_uaf_reclaim(struct rcu_head *rp)
>                 container_of(rp, struct kasan_rcu_info, rcu);
>
>         kfree(fp);
> +
>         ((volatile struct kasan_rcu_info *)fp)->i;
>  }
>
> @@ -899,9 +1030,14 @@ static void rcu_uaf(struct kunit *test)
>         global_rcu_ptr =3D rcu_dereference_protected(
>                                 (struct kasan_rcu_info __rcu *)ptr, NULL)=
;
>
> -       KUNIT_EXPECT_KASAN_FAIL(test,
> -               call_rcu(&global_rcu_ptr->rcu, rcu_uaf_reclaim);
> -               rcu_barrier());
> +       if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test,
> +                       call_rcu(&global_rcu_ptr->rcu, rcu_uaf_reclaim);
> +                       rcu_barrier());
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test,
> +                       call_rcu(&global_rcu_ptr->rcu, rcu_uaf_reclaim);
> +                       rcu_barrier());
>  }
>
>  static void workqueue_uaf_work(struct work_struct *work)
> @@ -924,8 +1060,12 @@ static void workqueue_uaf(struct kunit *test)
>         queue_work(workqueue, work);
>         destroy_workqueue(workqueue);
>
> -       KUNIT_EXPECT_KASAN_FAIL(test,
> -               ((volatile struct work_struct *)work)->data);
> +       if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test,
> +                       ((volatile struct work_struct *)work)->data);
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test,
> +                       ((volatile struct work_struct *)work)->data);
>  }
>
>  static void kfree_via_page(struct kunit *test)
> @@ -972,7 +1112,10 @@ static void kmem_cache_oob(struct kunit *test)
>                 return;
>         }
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, *p =3D p[size + OOB_TAG_OFF]);
> +       if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, *p =3D p[size + OOB_TAG_=
OFF]);
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test, *p =3D p[size + OOB_TAG_OFF=
]);
>
>         kmem_cache_free(cache, p);
>         kmem_cache_destroy(cache);
> @@ -1068,7 +1211,10 @@ static void kmem_cache_rcu_uaf(struct kunit *test)
>          */
>         rcu_barrier();
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, READ_ONCE(*p));
> +       if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, READ_ONCE(*p));
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test, READ_ONCE(*p));
>
>         kmem_cache_destroy(cache);
>  }
> @@ -1206,6 +1352,9 @@ static void mempool_oob_right_helper(struct kunit *=
test, mempool_t *pool, size_t
>         if (IS_ENABLED(CONFIG_KASAN_GENERIC))
>                 KUNIT_EXPECT_KASAN_FAIL(test,
>                         ((volatile char *)&elem[size])[0]);
> +       else if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test,
> +                       ((volatile char *)&elem[round_up(size, KASAN_GRAN=
ULE_SIZE)])[0]);
>         else
>                 KUNIT_EXPECT_KASAN_FAIL(test,
>                         ((volatile char *)&elem[round_up(size, KASAN_GRAN=
ULE_SIZE)])[0]);
> @@ -1273,7 +1422,11 @@ static void mempool_uaf_helper(struct kunit *test,=
 mempool_t *pool, bool page)
>         mempool_free(elem, pool);
>
>         ptr =3D page ? page_address((struct page *)elem) : elem;
> -       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[0]);
> +
> +       if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, ((volatile char *)ptr)[0=
]);
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[0]);
>  }
>
>  static void mempool_kmalloc_uaf(struct kunit *test)
> @@ -1532,8 +1685,13 @@ static void kasan_memchr(struct kunit *test)
>
>         OPTIMIZER_HIDE_VAR(ptr);
>         OPTIMIZER_HIDE_VAR(size);
> -       KUNIT_EXPECT_KASAN_FAIL(test,
> -               kasan_ptr_result =3D memchr(ptr, '1', size + 1));
> +
> +       if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test,
> +                       kasan_ptr_result =3D memchr(ptr, '1', size + 1));
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test,
> +                       kasan_ptr_result =3D memchr(ptr, '1', size + 1));
>
>         kfree(ptr);
>  }
> @@ -1559,8 +1717,14 @@ static void kasan_memcmp(struct kunit *test)
>
>         OPTIMIZER_HIDE_VAR(ptr);
>         OPTIMIZER_HIDE_VAR(size);
> -       KUNIT_EXPECT_KASAN_FAIL(test,
> -               kasan_int_result =3D memcmp(ptr, arr, size+1));
> +
> +       if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test,
> +                       kasan_int_result =3D memcmp(ptr, arr, size+1));
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test,
> +                       kasan_int_result =3D memcmp(ptr, arr, size+1));
> +
>         kfree(ptr);
>  }
>
> @@ -1593,9 +1757,13 @@ static void kasan_strings(struct kunit *test)
>         KUNIT_EXPECT_EQ(test, KASAN_GRANULE_SIZE - 2,
>                         strscpy(ptr, src + 1, KASAN_GRANULE_SIZE));
>
> -       /* strscpy should fail if the first byte is unreadable. */
> -       KUNIT_EXPECT_KASAN_FAIL(test, strscpy(ptr, src + KASAN_GRANULE_SI=
ZE,
> -                                             KASAN_GRANULE_SIZE));
> +       if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, strscpy(ptr, src + KASAN=
_GRANULE_SIZE,
> +                                                     KASAN_GRANULE_SIZE)=
);
> +       else
> +               /* strscpy should fail if the first byte is unreadable. *=
/
> +               KUNIT_EXPECT_KASAN_FAIL(test, strscpy(ptr, src + KASAN_GR=
ANULE_SIZE,
> +                                                     KASAN_GRANULE_SIZE)=
);
>
>         kfree(src);
>         kfree(ptr);
> @@ -1607,17 +1775,22 @@ static void kasan_strings(struct kunit *test)
>          * will likely point to zeroed byte.
>          */
>         ptr +=3D 16;
> -       KUNIT_EXPECT_KASAN_FAIL(test, kasan_ptr_result =3D strchr(ptr, '1=
'));
> -
> -       KUNIT_EXPECT_KASAN_FAIL(test, kasan_ptr_result =3D strrchr(ptr, '=
1'));
> -
> -       KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result =3D strcmp(ptr, "2=
"));
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result =3D strncmp(ptr, "=
2", 1));
> -
> -       KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result =3D strlen(ptr));
> -
> -       KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result =3D strnlen(ptr, 1=
));
> +       if (kasan_store_only_enabled()) {
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, kasan_ptr_result =3D str=
chr(ptr, '1'));
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, kasan_ptr_result =3D str=
rchr(ptr, '1'));
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, kasan_int_result =3D str=
cmp(ptr, "2"));
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, kasan_int_result =3D str=
ncmp(ptr, "2", 1));
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, kasan_int_result =3D str=
len(ptr));
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, kasan_int_result =3D str=
nlen(ptr, 1));
> +       } else {
> +               KUNIT_EXPECT_KASAN_FAIL(test, kasan_ptr_result =3D strchr=
(ptr, '1'));
> +               KUNIT_EXPECT_KASAN_FAIL(test, kasan_ptr_result =3D strrch=
r(ptr, '1'));
> +               KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result =3D strcmp=
(ptr, "2"));
> +               KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result =3D strncm=
p(ptr, "2", 1));
> +               KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result =3D strlen=
(ptr));
> +               KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result =3D strnle=
n(ptr, 1));
> +       }
>  }
>
>  static void kasan_bitops_modify(struct kunit *test, int nr, void *addr)
> @@ -1636,12 +1809,25 @@ static void kasan_bitops_test_and_modify(struct k=
unit *test, int nr, void *addr)
>  {
>         KUNIT_EXPECT_KASAN_FAIL(test, test_and_set_bit(nr, addr));
>         KUNIT_EXPECT_KASAN_FAIL(test, __test_and_set_bit(nr, addr));
> -       KUNIT_EXPECT_KASAN_FAIL(test, test_and_set_bit_lock(nr, addr));
> +
> +       /*
> +        * When KASAN is running in store-only mode,
> +        * a fault won't occur even if the bit is set.
> +        * Therefore, skip the test_and_set_bit_lock test in store-only m=
ode.
> +        */
> +       if (!kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_FAIL(test, test_and_set_bit_lock(nr, a=
ddr));
> +
>         KUNIT_EXPECT_KASAN_FAIL(test, test_and_clear_bit(nr, addr));
>         KUNIT_EXPECT_KASAN_FAIL(test, __test_and_clear_bit(nr, addr));
>         KUNIT_EXPECT_KASAN_FAIL(test, test_and_change_bit(nr, addr));
>         KUNIT_EXPECT_KASAN_FAIL(test, __test_and_change_bit(nr, addr));
> -       KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result =3D test_bit(nr, a=
ddr));
> +
> +       if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, kasan_int_result =3D tes=
t_bit(nr, addr));
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result =3D test_b=
it(nr, addr));
> +
>         if (nr < 7)
>                 KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result =3D
>                                 xor_unlock_is_negative_byte(1 << nr, addr=
));
> @@ -1765,7 +1951,10 @@ static void vmalloc_oob(struct kunit *test)
>                 KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)v_ptr)[si=
ze]);
>
>         /* An aligned access into the first out-of-bounds granule. */
> -       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)v_ptr)[size + 5])=
;
> +       if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, ((volatile char *)v_ptr)=
[size + 5]);
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)v_ptr)[si=
ze + 5]);
>
>         /* Check that in-bounds accesses to the physical page are valid. =
*/
>         page =3D vmalloc_to_page(v_ptr);
> @@ -2042,16 +2231,33 @@ static void copy_user_test_oob(struct kunit *test=
)
>
>         KUNIT_EXPECT_KASAN_FAIL(test,
>                 unused =3D copy_from_user(kmem, usermem, size + 1));
> -       KUNIT_EXPECT_KASAN_FAIL(test,
> -               unused =3D copy_to_user(usermem, kmem, size + 1));
> +
> +       if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test,
> +                       unused =3D copy_to_user(usermem, kmem, size + 1))=
;
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test,
> +                       unused =3D copy_to_user(usermem, kmem, size + 1))=
;
> +
>         KUNIT_EXPECT_KASAN_FAIL(test,
>                 unused =3D __copy_from_user(kmem, usermem, size + 1));
> -       KUNIT_EXPECT_KASAN_FAIL(test,
> -               unused =3D __copy_to_user(usermem, kmem, size + 1));
> +
> +       if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test,
> +                       unused =3D __copy_to_user(usermem, kmem, size + 1=
));
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test,
> +                       unused =3D __copy_to_user(usermem, kmem, size + 1=
));
> +
>         KUNIT_EXPECT_KASAN_FAIL(test,
>                 unused =3D __copy_from_user_inatomic(kmem, usermem, size =
+ 1));
> -       KUNIT_EXPECT_KASAN_FAIL(test,
> -               unused =3D __copy_to_user_inatomic(usermem, kmem, size + =
1));
> +
> +       if (kasan_store_only_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test,
> +                       unused =3D __copy_to_user_inatomic(usermem, kmem,=
 size + 1));
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test,
> +                       unused =3D __copy_to_user_inatomic(usermem, kmem,=
 size + 1));
>
>         /*
>         * Prepare a long string in usermem to avoid the strncpy_from_user=
 test
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>

