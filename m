Return-Path: <linux-kernel+bounces-765259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF67B22DB9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206C31899966
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30CD2F7474;
	Tue, 12 Aug 2025 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJc3ZOJk"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B17C22E402;
	Tue, 12 Aug 2025 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016109; cv=none; b=BFXxY8elIiXirWIInkK5/GOSqQ7thcPtdi1AFoKIZkQFDBR7aQUguGISfDLoTQdMUVS/uS67CYHhyoa32L8SqTRY1RzbDyVQcZzivIFZZmJm3G1A7h3E9jamDmMpxLwArzSe6WsDYg1EKcb0v+iKvFndO66zquaNn4BFOX7535A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016109; c=relaxed/simple;
	bh=yo6K3Ym4mJuXSteLItfJzvRMIVAUO84PNRihE/Nh5f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYFAUtprSZx6wb4SyuhuizmBWysluEjT63cz4Kd3WEAvG0bKaUVZe0zI2IWtFVc1BGX1a1DaQG0lCW0RnPzJNXygNivMUXEFyY7SfKhCDOxWxwfacDAHjhlPqcqQglmWPdHEite0aUi3f6rl67uPYIAOHxbL5VgyeRPrKe1MpQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJc3ZOJk; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-458baf449cbso55227295e9.0;
        Tue, 12 Aug 2025 09:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755016105; x=1755620905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DEQJQSXLAUts9QuH9e8jbi6NmiQPvWx/N73fs3TVeM=;
        b=VJc3ZOJkgp2eeTSYjhbK4aaS77NN3Pf3TR7GD5J6CqJJc1XXG2UwOvLW05/lH1g5Xv
         bkilTlACIfx2BLe3HYEaCakCkNNXLsq26KLkPw0S1FqQrV3r6Fo/OGLu1XXhLEf1P1fd
         Q+uGE5QNxSaKWrdQns/vXxsEvRNacjJl5mSYYE8DFOhHabUZcogka+R2TreyKIELRvJ5
         j/XZm1t0NHmpXxSMquBFad+nfQhjnOVWxc9W0hjC+8RLgLjisD8PMGoUOJwGDcuAVUa/
         Pld1oF4d7ZriV0SgOSDXSA5W+DONGC6bQjB8zn13iO9gmuX5OrvLovZg/oVvV5wgJ2Xe
         9bMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755016105; x=1755620905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DEQJQSXLAUts9QuH9e8jbi6NmiQPvWx/N73fs3TVeM=;
        b=VjxiiGhwwQUNemhLkY40GQd1NfYC7/iEk4l1qAzaZvSW9rCw3eq3BRP6hH4YYDj4fg
         Ki/LBLGlSJG7cYHbOa7lZ6e0aASxtz86wBhcSXCTfLt696jvgWO1o+yeexsnq6PYZCZd
         xRpT0KNdJhwDXZlSTbDV/BvMA5Nzr6neHSPVOmcjNqWh7n5uQQYqRLpozbZbolpfSTa+
         RTdPaAOuywrVh2wkr594QYgcbQXuHKhYQf1clTUWxkjrisXfi8Xikvzgb1TjLeLbKnE0
         6o0p2Tlh65mOxh8GLhlB2BktsBYF6jeWhJYo+aDHJSuAubNX0XSV2v4+succKDKcY+Xc
         CoJw==
X-Forwarded-Encrypted: i=1; AJvYcCUyEG4w2mPSFkOG8auxAoXnGKahqG/Pk6eejiqVdaA1Jr7tCZXs7IpaWBUsRvYgjcrnLIyE8QaQrscd6rBw@vger.kernel.org, AJvYcCV0+ciiwj5+RTUNzzhWZxwuZlOSAujqyS+ytx1o11qMNQ1ojpMzEUB/ALWyrNdH7bnKd+cQUfeyYzM=@vger.kernel.org, AJvYcCWzqdlZCdOjWfSR0Zp/aZymOg46Fkoy4tEajG7Yl7JdJmYQGkiNlE5ktMVgaN0gTH23Saq/i467Tlze@vger.kernel.org
X-Gm-Message-State: AOJu0YzDihwXmAEWim8SdIXZUNJx9vn0RRwwWEeEvydUWM3Nj46LFIka
	5N2YL4mkXVXsmQWQ9AXgzQ9zcJn5eqB4x8vIuQaRvTJxTqsF3dkLToulOEs3XerQxZ9lhwPPCoC
	bqlcYYkziu71zK+kvFw4M7HNT1qyz1iU=
X-Gm-Gg: ASbGnct4+zwobEKBgkHZkJus3hZhICbJkmx12B5AgZZt1qmg2cuSRnhgRkG/YUtKqQA
	854hze8ObvKYy+Vl3vWQu+vIWIu0boaglVByrq2hXlj9KJcfHSJ/zDIAhy2pGiRxn9gR9vhQjxw
	OdJ6WAzZfX2OyFrisWLdkjvU7e5Y4qAhjQCrt7sBSWEUE2QugTYvx5g2M28Oj7CIhn2xIToVca9
	H6+eC8Ncg==
X-Google-Smtp-Source: AGHT+IH3LcFrZP4xMU06DK74RgD0UODfe3deWBFBu8fZRXAKt+I4e40tKgIh39y6/0pdqOfCUGxAxa42ZahzhHUYv5c=
X-Received: by 2002:a05:600c:4585:b0:458:b01c:8f with SMTP id
 5b1f17b1804b1-45a15b1f996mr4788815e9.8.1755016104985; Tue, 12 Aug 2025
 09:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811173626.1878783-1-yeoreum.yun@arm.com> <20250811173626.1878783-3-yeoreum.yun@arm.com>
In-Reply-To: <20250811173626.1878783-3-yeoreum.yun@arm.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 12 Aug 2025 18:28:12 +0200
X-Gm-Features: Ac12FXwkg1JQz-u0IFfkfNxUBQy7VDQUXrQz_SW_sB6Boita2CZHjuZOWhhTDCM
Message-ID: <CA+fCnZeSV4fDBQr-WPFA66OYxN8zOQ2g1RQMDW3Ok8FaE7=NXQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kasan: apply store-only mode in kasan kunit testcases
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

On Mon, Aug 11, 2025 at 7:36=E2=80=AFPM Yeoreum Yun <yeoreum.yun@arm.com> w=
rote:
>
> When KASAN is configured in store-only mode,
> fetch/load operations do not trigger tag check faults.
> As a result, the outcome of some test cases may differ
> compared to when KASAN is configured without store-only mode.
>
> To address this:
>   1. Replace fetch/load expressions that would
>      normally trigger tag check faults with store operation
>      when running under store-only and sync mode.
>      In case of async/asymm mode, skip the store operation triggering
>      tag check fault since it corrupts memory.
>
>   2. Skip some testcases affected by initial value
>      (i.e) atomic_cmpxchg() testcase maybe successd if
>      it passes valid atomic_t address and invalid oldaval address.
>      In this case, if invalid atomic_t doesn't have the same oldval,
>      it won't trigger store operation so the test will pass.
>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  mm/kasan/kasan_test_c.c | 423 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 341 insertions(+), 82 deletions(-)
>
> diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> index 2aa12dfa427a..22d5d6d6cd9f 100644
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
> @@ -183,8 +209,15 @@ static void kmalloc_oob_right(struct kunit *test)
>         KUNIT_EXPECT_KASAN_FAIL(test, ptr[size + 5] =3D 'y');
>
>         /* Out-of-bounds access past the aligned kmalloc object. */
> -       KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] =3D
> -                                       ptr[size + KASAN_GRANULE_SIZE + 5=
]);
> +       if (kasan_stonly_enabled()) {
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, ptr[0] =3D
> +                                               ptr[size + KASAN_GRANULE_=
SIZE + 5]);
> +               if (!kasan_async_fault_possible())
> +                       KUNIT_EXPECT_KASAN_FAIL(test,
> +                                       ptr[size + KASAN_GRANULE_SIZE + 5=
] =3D ptr[0]);
> +       } else
> +               KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] =3D
> +                                               ptr[size + KASAN_GRANULE_=
SIZE + 5]);
>
>         kfree(ptr);
>  }
> @@ -198,7 +231,13 @@ static void kmalloc_oob_left(struct kunit *test)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
>         OPTIMIZER_HIDE_VAR(ptr);
> -       KUNIT_EXPECT_KASAN_FAIL(test, *ptr =3D *(ptr - 1));
> +       if (kasan_stonly_enabled()) {
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, *ptr =3D *(ptr - 1));
> +               if (!kasan_async_fault_possible())
> +                       KUNIT_EXPECT_KASAN_FAIL(test, *(ptr - 1) =3D *(pt=
r));
> +       } else
> +               KUNIT_EXPECT_KASAN_FAIL(test, *ptr =3D *(ptr - 1));
> +
>         kfree(ptr);
>  }
>
> @@ -211,7 +250,13 @@ static void kmalloc_node_oob_right(struct kunit *tes=
t)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
>         OPTIMIZER_HIDE_VAR(ptr);
> -       KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] =3D ptr[size]);
> +       if (kasan_stonly_enabled()) {
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, ptr[0] =3D ptr[size]);
> +               if (!kasan_async_fault_possible())
> +                       KUNIT_EXPECT_KASAN_FAIL(test, ptr[size] =3D ptr[0=
]);
> +       } else
> +               KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] =3D ptr[size]);
> +
>         kfree(ptr);
>  }
>
> @@ -291,7 +336,12 @@ static void kmalloc_large_uaf(struct kunit *test)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>         kfree(ptr);
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[0]);
> +       if (kasan_stonly_enabled()) {
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, ((volatile char *)ptr)[0=
]);
> +               if (!kasan_async_fault_possible())
> +                       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)p=
tr)[0] =3D 0);
> +       } else
> +               KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[0]);
>  }
>
>  static void kmalloc_large_invalid_free(struct kunit *test)
> @@ -323,7 +373,13 @@ static void page_alloc_oob_right(struct kunit *test)
>         ptr =3D page_address(pages);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] =3D ptr[size]);
> +       if (kasan_stonly_enabled()) {
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, ptr[0] =3D ptr[size]);
> +               if (!kasan_async_fault_possible())
> +                       KUNIT_EXPECT_KASAN_FAIL(test, ptr[size] =3D ptr[0=
]);
> +       } else
> +               KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] =3D ptr[size]);
> +
>         free_pages((unsigned long)ptr, order);
>  }
>
> @@ -338,7 +394,12 @@ static void page_alloc_uaf(struct kunit *test)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>         free_pages((unsigned long)ptr, order);
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[0]);
> +       if (kasan_stonly_enabled()) {
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, ((volatile char *)ptr)[0=
]);
> +               if (!kasan_async_fault_possible())
> +                       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)p=
tr)[0] =3D 0);
> +       } else
> +               KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[0]);
>  }
>
>  static void krealloc_more_oob_helper(struct kunit *test,
> @@ -455,10 +516,15 @@ static void krealloc_uaf(struct kunit *test)
>         ptr1 =3D kmalloc(size1, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
>         kfree(ptr1);
> -
>         KUNIT_EXPECT_KASAN_FAIL(test, ptr2 =3D krealloc(ptr1, size2, GFP_=
KERNEL));
>         KUNIT_ASSERT_NULL(test, ptr2);
> -       KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)ptr1);
> +
> +       if (kasan_stonly_enabled()) {
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, *(volatile char *)ptr1);
> +               if (!kasan_async_fault_possible())
> +                       KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p=
tr1 =3D 0);
> +       } else
> +               KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)ptr1);
>  }
>
>  static void kmalloc_oob_16(struct kunit *test)
> @@ -501,7 +567,13 @@ static void kmalloc_uaf_16(struct kunit *test)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
>         kfree(ptr2);
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, *ptr1 =3D *ptr2);
> +       if (kasan_stonly_enabled()) {
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, *ptr1 =3D *ptr2);
> +               if (!kasan_async_fault_possible())
> +                       KUNIT_EXPECT_KASAN_FAIL(test, *ptr2 =3D *ptr1);
> +       } else
> +               KUNIT_EXPECT_KASAN_FAIL(test, *ptr1 =3D *ptr2);
> +
>         kfree(ptr1);
>  }
>
> @@ -640,8 +712,17 @@ static void kmalloc_memmove_invalid_size(struct kuni=
t *test)
>         memset((char *)ptr, 0, 64);
>         OPTIMIZER_HIDE_VAR(ptr);
>         OPTIMIZER_HIDE_VAR(invalid_size);
> -       KUNIT_EXPECT_KASAN_FAIL(test,
> -               memmove((char *)ptr, (char *)ptr + 4, invalid_size));
> +
> +       if (kasan_stonly_enabled()) {
> +               KUNIT_EXPECT_KASAN_SUCCESS(test,
> +                       memmove((char *)ptr, (char *)ptr + 4, invalid_siz=
e));
> +               if (!kasan_async_fault_possible())
> +                       KUNIT_EXPECT_KASAN_FAIL(test,
> +                               memmove((char *)ptr + 4, (char *)ptr, inv=
alid_size));
> +       } else
> +               KUNIT_EXPECT_KASAN_FAIL(test,
> +                       memmove((char *)ptr, (char *)ptr + 4, invalid_siz=
e));
> +
>         kfree(ptr);
>  }
>
> @@ -654,7 +735,13 @@ static void kmalloc_uaf(struct kunit *test)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
>         kfree(ptr);
> -       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[8]);
> +
> +       if (kasan_stonly_enabled()) {
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, ((volatile char *)ptr)[8=
]);
> +               if (!kasan_sync_fault_possible())
> +                       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)p=
tr)[8] =3D 0);
> +       } else
> +               KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[8]);
>  }
>
>  static void kmalloc_uaf_memset(struct kunit *test)
> @@ -701,7 +788,13 @@ static void kmalloc_uaf2(struct kunit *test)
>                 goto again;
>         }
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr1)[40]);
> +       if (kasan_stonly_enabled()) {
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, ((volatile char *)ptr1)[=
40]);
> +               if (!kasan_sync_fault_possible())
> +                       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)p=
tr1)[40] =3D 0);
> +       } else
> +               KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr1)[40]=
);
> +
>         KUNIT_EXPECT_PTR_NE(test, ptr1, ptr2);
>
>         kfree(ptr2);
> @@ -727,19 +820,35 @@ static void kmalloc_uaf3(struct kunit *test)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
>         kfree(ptr2);
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr1)[8]);
> +       if (kasan_stonly_enabled()) {
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, ((volatile char *)ptr1)[=
8]);
> +               if (!kasan_sync_fault_possible())
> +                       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)p=
tr1)[8] =3D 0);
> +       } else
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
> +       if (kasan_stonly_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, READ_ONCE(*i_unsafe));
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test, READ_ONCE(*i_unsafe));
> +
>         KUNIT_EXPECT_KASAN_FAIL(test, WRITE_ONCE(*i_unsafe, 42));
> -       KUNIT_EXPECT_KASAN_FAIL(test, smp_load_acquire(i_unsafe));
> +       if (kasan_stonly_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, smp_load_acquire(i_unsaf=
e));
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test, smp_load_acquire(i_unsafe))=
;
>         KUNIT_EXPECT_KASAN_FAIL(test, smp_store_release(i_unsafe, 42));
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, atomic_read(unsafe));
> +       if (kasan_stonly_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, atomic_read(unsafe));
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test, atomic_read(unsafe));
> +
>         KUNIT_EXPECT_KASAN_FAIL(test, atomic_set(unsafe, 42));
>         KUNIT_EXPECT_KASAN_FAIL(test, atomic_add(42, unsafe));
>         KUNIT_EXPECT_KASAN_FAIL(test, atomic_sub(42, unsafe));
> @@ -752,18 +861,38 @@ static void kasan_atomics_helper(struct kunit *test=
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
> +       if (!kasan_stonly_enabled())
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
> +       if (!kasan_stonly_enabled()) {
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
> +       if (kasan_stonly_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, atomic_long_read(unsafe)=
);
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_read(unsafe));
> +
>         KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_set(unsafe, 42));
>         KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_add(42, unsafe));
>         KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_sub(42, unsafe));
> @@ -776,16 +905,32 @@ static void kasan_atomics_helper(struct kunit *test=
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
> +       if (!kasan_stonly_enabled())
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
> +       if (!kasan_stonly_enabled()) {
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
> @@ -842,8 +987,18 @@ static void ksize_unpoisons_memory(struct kunit *tes=
t)
>         /* These must trigger a KASAN report. */
>         if (IS_ENABLED(CONFIG_KASAN_GENERIC))
>                 KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size=
]);
> -       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size + 5]);
> -       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[real_size - =
1]);
> +
> +       if (kasan_stonly_enabled()) {
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, ((volatile char *)ptr)[s=
ize + 5]);
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, ((volatile char *)ptr)[r=
eal_size - 1]);
> +               if (!kasan_sync_fault_possible()) {
> +                       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)p=
tr)[size + 5] =3D 0);
> +                       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)p=
tr)[real_size - 1] =3D 0);
> +               }
> +       } else {
> +               KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size=
 + 5]);
> +               KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[real=
_size - 1]);
> +       }
>
>         kfree(ptr);
>  }
> @@ -863,8 +1018,17 @@ static void ksize_uaf(struct kunit *test)
>
>         OPTIMIZER_HIDE_VAR(ptr);
>         KUNIT_EXPECT_KASAN_FAIL(test, ksize(ptr));
> -       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[0]);
> -       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size]);
> +       if (kasan_stonly_enabled()) {
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, ((volatile char *)ptr)[0=
]);
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, ((volatile char *)ptr)[s=
ize]);
> +               if (!kasan_sync_fault_possible()) {
> +                       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)p=
tr)[0] =3D 0);
> +                       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)p=
tr)[size] =3D 0);
> +               }
> +       } else {
> +               KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[0]);
> +               KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size=
]);
> +       }
>  }
>
>  /*
> @@ -886,7 +1050,11 @@ static void rcu_uaf_reclaim(struct rcu_head *rp)
>                 container_of(rp, struct kasan_rcu_info, rcu);
>
>         kfree(fp);
> -       ((volatile struct kasan_rcu_info *)fp)->i;
> +
> +       if (kasan_stonly_enabled() && !kasan_async_fault_possible())
> +               ((volatile struct kasan_rcu_info *)fp)->i =3D 0;
> +       else
> +               ((volatile struct kasan_rcu_info *)fp)->i;
>  }
>
>  static void rcu_uaf(struct kunit *test)
> @@ -899,9 +1067,14 @@ static void rcu_uaf(struct kunit *test)
>         global_rcu_ptr =3D rcu_dereference_protected(
>                                 (struct kasan_rcu_info __rcu *)ptr, NULL)=
;
>
> -       KUNIT_EXPECT_KASAN_FAIL(test,
> -               call_rcu(&global_rcu_ptr->rcu, rcu_uaf_reclaim);
> -               rcu_barrier());
> +       if (kasan_stonly_enabled() && kasan_async_fault_possible())
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
> @@ -924,8 +1097,12 @@ static void workqueue_uaf(struct kunit *test)
>         queue_work(workqueue, work);
>         destroy_workqueue(workqueue);
>
> -       KUNIT_EXPECT_KASAN_FAIL(test,
> -               ((volatile struct work_struct *)work)->data);
> +       if (kasan_stonly_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test,
> +                       ((volatile struct work_struct *)work)->data);
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test,
> +                       ((volatile struct work_struct *)work)->data);
>  }
>
>  static void kfree_via_page(struct kunit *test)
> @@ -972,7 +1149,12 @@ static void kmem_cache_oob(struct kunit *test)
>                 return;
>         }
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, *p =3D p[size + OOB_TAG_OFF]);
> +       if (kasan_stonly_enabled()) {
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, *p =3D p[size + OOB_TAG_=
OFF]);
> +               if (!kasan_async_fault_possible())
> +                       KUNIT_EXPECT_KASAN_FAIL(test, p[size + OOB_TAG_OF=
F] =3D *p);
> +       } else
> +               KUNIT_EXPECT_KASAN_FAIL(test, *p =3D p[size + OOB_TAG_OFF=
]);
>
>         kmem_cache_free(cache, p);
>         kmem_cache_destroy(cache);
> @@ -1068,7 +1250,12 @@ static void kmem_cache_rcu_uaf(struct kunit *test)
>          */
>         rcu_barrier();
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, READ_ONCE(*p));
> +       if (kasan_stonly_enabled()) {
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, READ_ONCE(*p));
> +               if (!kasan_async_fault_possible())
> +                       KUNIT_EXPECT_KASAN_FAIL(test, WRITE_ONCE(*p, 0));
> +       } else
> +               KUNIT_EXPECT_KASAN_FAIL(test, READ_ONCE(*p));
>
>         kmem_cache_destroy(cache);
>  }
> @@ -1206,7 +1393,13 @@ static void mempool_oob_right_helper(struct kunit =
*test, mempool_t *pool, size_t
>         if (IS_ENABLED(CONFIG_KASAN_GENERIC))
>                 KUNIT_EXPECT_KASAN_FAIL(test,
>                         ((volatile char *)&elem[size])[0]);
> -       else
> +       else if (kasan_stonly_enabled()) {
> +               KUNIT_EXPECT_KASAN_SUCCESS(test,
> +                       ((volatile char *)&elem[round_up(size, KASAN_GRAN=
ULE_SIZE)])[0]);
> +               if (!kasan_async_fault_possible())
> +                       KUNIT_EXPECT_KASAN_FAIL(test,
> +                               ((volatile char *)&elem[round_up(size, KA=
SAN_GRANULE_SIZE)])[0] =3D 0);
> +       } else
>                 KUNIT_EXPECT_KASAN_FAIL(test,
>                         ((volatile char *)&elem[round_up(size, KASAN_GRAN=
ULE_SIZE)])[0]);
>
> @@ -1273,7 +1466,13 @@ static void mempool_uaf_helper(struct kunit *test,=
 mempool_t *pool, bool page)
>         mempool_free(elem, pool);
>
>         ptr =3D page ? page_address((struct page *)elem) : elem;
> -       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[0]);
> +
> +       if (kasan_stonly_enabled()) {
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, ((volatile char *)ptr)[0=
]);
> +               if (!kasan_async_fault_possible())
> +                       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)p=
tr)[0] =3D 0);
> +       } else
> +               KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[0]);
>  }
>
>  static void mempool_kmalloc_uaf(struct kunit *test)
> @@ -1532,8 +1731,13 @@ static void kasan_memchr(struct kunit *test)
>
>         OPTIMIZER_HIDE_VAR(ptr);
>         OPTIMIZER_HIDE_VAR(size);
> -       KUNIT_EXPECT_KASAN_FAIL(test,
> -               kasan_ptr_result =3D memchr(ptr, '1', size + 1));
> +
> +       if (kasan_stonly_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test,
> +                       kasan_ptr_result =3D memchr(ptr, '1', size + 1));
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test,
> +                       kasan_ptr_result =3D memchr(ptr, '1', size + 1));
>
>         kfree(ptr);
>  }
> @@ -1559,8 +1763,14 @@ static void kasan_memcmp(struct kunit *test)
>
>         OPTIMIZER_HIDE_VAR(ptr);
>         OPTIMIZER_HIDE_VAR(size);
> -       KUNIT_EXPECT_KASAN_FAIL(test,
> -               kasan_int_result =3D memcmp(ptr, arr, size+1));
> +
> +       if (kasan_stonly_enabled())
> +               KUNIT_EXPECT_KASAN_SUCCESS(test,
> +                       kasan_int_result =3D memcmp(ptr, arr, size+1));
> +       else
> +               KUNIT_EXPECT_KASAN_FAIL(test,
> +                       kasan_int_result =3D memcmp(ptr, arr, size+1));
> +
>         kfree(ptr);
>  }
>
> @@ -1593,9 +1803,16 @@ static void kasan_strings(struct kunit *test)
>         KUNIT_EXPECT_EQ(test, KASAN_GRANULE_SIZE - 2,
>                         strscpy(ptr, src + 1, KASAN_GRANULE_SIZE));
>
> -       /* strscpy should fail if the first byte is unreadable. */
> -       KUNIT_EXPECT_KASAN_FAIL(test, strscpy(ptr, src + KASAN_GRANULE_SI=
ZE,
> -                                             KASAN_GRANULE_SIZE));
> +       if (kasan_stonly_enabled()) {
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, strscpy(ptr, src + KASAN=
_GRANULE_SIZE,
> +                                                     KASAN_GRANULE_SIZE)=
);
> +               if (!kasan_async_fault_possible())
> +                       /* strscpy should fail when the first byte is to =
be written. */
> +                       KUNIT_EXPECT_KASAN_FAIL(test, strscpy(ptr + size,=
 src, KASAN_GRANULE_SIZE));
> +       } else
> +               /* strscpy should fail if the first byte is unreadable. *=
/
> +               KUNIT_EXPECT_KASAN_FAIL(test, strscpy(ptr, src + KASAN_GR=
ANULE_SIZE,
> +                                                     KASAN_GRANULE_SIZE)=
);
>
>         kfree(src);
>         kfree(ptr);
> @@ -1607,17 +1824,22 @@ static void kasan_strings(struct kunit *test)
>          * will likely point to zeroed byte.
>          */
>         ptr +=3D 16;
> -       KUNIT_EXPECT_KASAN_FAIL(test, kasan_ptr_result =3D strchr(ptr, '1=
'));
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, kasan_ptr_result =3D strrchr(ptr, '=
1'));
> -
> -       KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result =3D strcmp(ptr, "2=
"));
> -
> -       KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result =3D strncmp(ptr, "=
2", 1));
> -
> -       KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result =3D strlen(ptr));
> -
> -       KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result =3D strnlen(ptr, 1=
));
> +       if (kasan_stonly_enabled()) {
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
> @@ -1636,12 +1858,27 @@ static void kasan_bitops_test_and_modify(struct k=
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
> +       if (!kasan_stonly_enabled())
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
> +       if (kasan_stonly_enabled()) {
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, kasan_int_result =3D tes=
t_bit(nr, addr));
> +               if (!kasan_async_fault_possible())
> +                       KUNIT_EXPECT_KASAN_FAIL(test, set_bit(nr, addr));
> +  } else
> +               KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result =3D test_b=
it(nr, addr));
> +
>         if (nr < 7)
>                 KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result =3D
>                                 xor_unlock_is_negative_byte(1 << nr, addr=
));
> @@ -1765,7 +2002,12 @@ static void vmalloc_oob(struct kunit *test)
>                 KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)v_ptr)[si=
ze]);
>
>         /* An aligned access into the first out-of-bounds granule. */
> -       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)v_ptr)[size + 5])=
;
> +       if (kasan_stonly_enabled()) {
> +               KUNIT_EXPECT_KASAN_SUCCESS(test, ((volatile char *)v_ptr)=
[size + 5]);
> +               if (!kasan_async_fault_possible())
> +                       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)v=
_ptr)[size + 5] =3D 0);
> +       } else
> +               KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)v_ptr)[si=
ze + 5]);
>
>         /* Check that in-bounds accesses to the physical page are valid. =
*/
>         page =3D vmalloc_to_page(v_ptr);
> @@ -2042,16 +2284,33 @@ static void copy_user_test_oob(struct kunit *test=
)
>
>         KUNIT_EXPECT_KASAN_FAIL(test,
>                 unused =3D copy_from_user(kmem, usermem, size + 1));
> -       KUNIT_EXPECT_KASAN_FAIL(test,
> -               unused =3D copy_to_user(usermem, kmem, size + 1));
> +
> +       if (kasan_stonly_enabled())
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
> +       if (kasan_stonly_enabled())
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
> +       if (kasan_stonly_enabled())
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

This patch does not look good.

Right now, KASAN tests are crafted to avoid/self-contain harmful
memory corruptions that they do (e.g. make sure that OOB write
accesses land in in-object kmalloc training space, etc.). If you turn
read accesses in tests into write accesses, memory corruptions caused
by the earlier tests will crash the kernel or the latter tests.

The easiest thing to do for now is to disable the tests that check bad
read accesses when store-only is enabled.

If we want to convert tests into doing write accesses instead of
reads, this needs to be done separately for each test (i.e. via a
separate patch) with an explanation why doing this is safe (and
adjustments whenever it's not). And we need a better way to code this
instead of the horrifying number of if/else checks.

Thank you!

