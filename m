Return-Path: <linux-kernel+bounces-765647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B91DB23BE1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 00:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A536E6960
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 22:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EF62C15BB;
	Tue, 12 Aug 2025 22:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b+esLjLi"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4E52882DE
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 22:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755037438; cv=none; b=ZhVQr+UzTq4cqOHfr8sf+RgsYB/MrSWwYsOqxGJCsknJiDJ3tHNgCGDVi3edN8MkSxQYwpKyzt2aiEKM/rA3e9y6XsTLDPm2b+4B6Ti3QsrmhMqp3Pjprv38cM3XFa2GRbPrg7KpVQKq2tpABKxXxA5DYN5MppNtxaQN2/5HTSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755037438; c=relaxed/simple;
	bh=m77zUdikKLuIFQbPypcuee6VmMV4tmpdqFOhuW27r70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bl9jz/ZH+lypPQYmkxqcLNcyAnVeRMiokhjB5xeQKHs/nQaCOhUNfz/6wY7CV00oBZ5Ns6U469wXTfYMw11yRrVJ3KN8+vhtjxIQg/RdnjkzT7i7AU5AzF5fW+LQxNHW4100+dYpGO+W1K4NedWjh25PfHhxzHAv2bY9NLxk6hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b+esLjLi; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-7074a74248dso53837746d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 15:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755037436; x=1755642236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJnpYXsl8YxSyj1wYhStEbnRqv/Bs6CSw0kV2AlWC5o=;
        b=b+esLjLiIdqISj7t8Wbr8a5j4vqVhwo5CWZTABvaoEnqcRr0ClZvKGPuHAV81GGn1R
         No7gtbyZWIar2RL/+RglvP+cAHVUKrFf9GGxijLweRFRT1rENUYBYobpYjf6Jop67XcI
         CpqJbpGumLD1Q26FVWxH9dUa2J7J6s5VEL8zg7x4yzdGd9o4GdO49EbI4A0bIeWw5ohf
         1tYc7/KBkIFD7iA9h7XD87qUNCCCAopYehBeAu2o31tsuXP8RdeaCWJBX/Cu8LzuDtkn
         V5Q7UDj/Ozu3CKY4f1U2ZRQl1df6QqCxeNfeYSeTqs3Smge+t61Oe9dX8C9VnXTfusnJ
         9F/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755037436; x=1755642236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJnpYXsl8YxSyj1wYhStEbnRqv/Bs6CSw0kV2AlWC5o=;
        b=caVwBVb6PMN0sgUIPCSxT7P32b+JjGcKIWGhaLlqPhHKhuJb7fmXYOGmnfd6fe29RU
         C2jKJ7hupcAvrUURkrYzqBO1saFngKszOrQ7dbPIsEojEyzl72ACQo2K1dKIRdhboVPZ
         c8dDQtdA7ou9ryeVKgnuOjaPWW+kNziajGjlmkvPcXcFcy+FJ5XtCUTOKfuB2t/Cp3+G
         aAYE31nreladS/taMBACaPhc6bZFZ8+GIIbmFo8k3ELZKAQooiWEEtJr1T6M4AoWD7F6
         EPmM5dIEMnzbVAXW5CVCB6K67RUfGOTfZYO4smpjMQEACuGd4eD12WgSjR7IqSTAVzSE
         9Gug==
X-Forwarded-Encrypted: i=1; AJvYcCU2PKsQxhd02PRXuCIHaAhnov4NdsbxHfKJkgfauBmT2VDcEvAJUk5Ay791IS1Zvqi5t4Ot3LYxhUeQJEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyEP9C19hPGv31NMAx3ccSSyZ+F5hSaGd2/egmOjc0HYyotNW8
	uWGjC3Yfla9j6rOBT9rkz9VIV1MhqANK1o+XQbUWfT3TSTxjIrxxSVdcaCyNeRWzWEzBiiq6I7y
	rhPdEDTXKqaYor+iBHAHG1j/qKePLbsEcTJx7mhUI
X-Gm-Gg: ASbGncscyvqr+t8Ak6WnZy+/1OvFyozE6Qqzsf1/brRRpzjjEAmDV8wIMh+jFO46MFz
	mKUhJkST78PuGO0rBZzgCbm03M50rGVnd3z34JY/RjPsdFZaNsfNgo4DO7epreGPgNAZncu0Zvm
	0yDUdTlhS6Hx5yQDMI3B/6Ne7ztD0g78fi7D5lBXjSZpaDj/T4LlkDp3KzjDZtxoEzZkNXrZcub
	gCBVJOJIPJ4wQCt
X-Google-Smtp-Source: AGHT+IEwDSp+uAZx9i/O1h0v7kjf30A79uhDxEYqawlem4HdnxAi4uwKsQSOhZjOXxmJqsh0y9SqGZ4LhD+p2yZudVk=
X-Received: by 2002:ad4:5fc7:0:b0:707:616f:fff4 with SMTP id
 6a1803df08f44-709e87ed0c5mr12374106d6.10.1755037435662; Tue, 12 Aug 2025
 15:23:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811221739.2694336-1-marievic@google.com> <20250811221739.2694336-7-marievic@google.com>
In-Reply-To: <20250811221739.2694336-7-marievic@google.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 12 Aug 2025 18:23:44 -0400
X-Gm-Features: Ac12FXxKNs5XUmU5widgmneS2GgZSAhi_XzG1wZdZRmg99Z9O_yPFEdmMws-MoU
Message-ID: <CA+GJov5uwE43RQwP96i617=dtZ0VAfVtrLu_DV863nhA2+4DmQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] kunit: Add example parameterized test with direct
 dynamic parameter array setup
To: Marie Zhussupova <marievic@google.com>
Cc: davidgow@google.com, shuah@kernel.org, brendan.higgins@linux.dev, 
	mark.rutland@arm.com, elver@google.com, dvyukov@google.com, 
	lucas.demarchi@intel.com, thomas.hellstrom@linux.intel.com, 
	rodrigo.vivi@intel.com, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, kasan-dev@googlegroups.com, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 6:18=E2=80=AFPM Marie Zhussupova <marievic@google.c=
om> wrote:
>
> Introduce example_params_test_with_init_dynamic_arr(). This new
> KUnit test demonstrates directly assigning a dynamic parameter
> array, using the kunit_register_params_array() macro, to a
> parameterized test context.
>
> It highlights the use of param_init() and param_exit() for
> initialization and exit of a parameterized test, and their
> registration to the test case with KUNIT_CASE_PARAM_WITH_INIT().
>
> Signed-off-by: Marie Zhussupova <marievic@google.com>
> ---
>
> Changes in v2:
>
> - kunit_array_gen_params() is now explicitly passed to
>   KUNIT_CASE_PARAM_WITH_INIT() to be consistent with
>   the parameterized test being defined by the existence
>   of the generate_params() function.
> - param_init() was changed to output a log at the start
>   of a parameterized test.
> - The parameter array was changed to be allocated
>   using kunit_kmalloc_array(), a KUnit memory allocation
>   API, as that would be the preferred/easier method. To
>   still demonstrate a use of param_exit(), it now outputs
>   a log at the end of the parameterized test.
> - The comments and the commit message were changed to
>   reflect the parameterized testing terminology. See
>   the patch series cover letter change log for the
>   definitions.
>

Hi!

I am happy with these changes and I really like this test!

Happy to mark this as:
Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!

-Rae

> ---
>  lib/kunit/kunit-example-test.c | 104 +++++++++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
>
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-tes=
t.c
> index f2819ee58965..ff21511889a4 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -393,6 +393,107 @@ static void example_params_test_with_init(struct ku=
nit *test)
>         kunit_put_resource(res);
>  }
>
> +/*
> + * Helper function to create a parameter array of Fibonacci numbers. Thi=
s example
> + * highlights a parameter generation scenario that is:
> + * 1. Not feasible to fully pre-generate at compile time.
> + * 2. Challenging to implement with a standard generate_params() functio=
n,
> + * as it only provides the previous parameter, while Fibonacci requires
> + * access to two preceding values for calculation.
> + */
> +static void *make_fibonacci_params(struct kunit *test, size_t seq_size)
> +{
> +       int *seq;
> +
> +       if (seq_size <=3D 0)
> +               return NULL;
> +       /*
> +        * Using kunit_kmalloc_array here ties the lifetime of the array =
to
> +        * the parameterized test i.e. it will get automatically cleaned =
up
> +        * by KUnit after the parameterized test finishes.
> +        */
> +       seq =3D kunit_kmalloc_array(test, seq_size, sizeof(int), GFP_KERN=
EL);
> +
> +       if (!seq)
> +               return NULL;
> +       if (seq_size >=3D 1)
> +               seq[0] =3D 0;
> +       if (seq_size >=3D 2)
> +               seq[1] =3D 1;
> +       for (int i =3D 2; i < seq_size; i++)
> +               seq[i] =3D seq[i - 1] + seq[i - 2];
> +       return seq;
> +}
> +
> +/*
> + * This is an example of a function that provides a description for each=
 of the
> + * parameters.
> + */
> +static void example_param_dynamic_arr_get_desc(struct kunit *test, const=
 void *p, char *desc)
> +{
> +       const int *fib_num =3D p;
> +
> +       snprintf(desc, KUNIT_PARAM_DESC_SIZE, "fibonacci param: %d", *fib=
_num);
> +}
> +
> +/*
> + * Example of a parameterized test param_init() function that registers =
a dynamic
> + * array of parameters.
> + */
> +static int example_param_init_dynamic_arr(struct kunit *test)
> +{
> +       size_t seq_size;
> +       int *fibonacci_params;
> +
> +       kunit_info(test, "initializing parameterized test\n");
> +
> +       seq_size =3D 6;
> +       fibonacci_params =3D make_fibonacci_params(test, seq_size);
> +
> +       if (!fibonacci_params)
> +               return -ENOMEM;
> +
> +       /*
> +        * Passes the dynamic parameter array information to the paramete=
rized test
> +        * context struct kunit. The array and its metadata will be store=
d in
> +        * test->parent->params_array. The array itself will be located i=
n
> +        * params_data.params.
> +        *
> +        * Note that you will need to pass kunit_array_gen_params() as th=
e
> +        * generator function to KUNIT_CASE_PARAM_WITH_INIT() when regist=
ering
> +        * a parameter array this route.
> +        */
> +       kunit_register_params_array(test, fibonacci_params, seq_size,
> +                                   example_param_dynamic_arr_get_desc);
> +       return 0;
> +}
> +
> +/*
> + * Example of a parameterized test param_exit() function that outputs a =
log
> + * at the end of the parameterized test. It could also be used for any o=
ther
> + * teardown logic.
> + */
> +static void example_param_exit_dynamic_arr(struct kunit *test)
> +{
> +       kunit_info(test, "exiting parameterized test\n");
> +}
> +
> +/*
> + * Example of test that uses the registered dynamic array to perform ass=
ertions
> + * and expectations.
> + */
> +static void example_params_test_with_init_dynamic_arr(struct kunit *test=
)
> +{
> +       const int *param =3D test->param_value;
> +       int param_val;
> +
> +       /* By design, param pointer will not be NULL. */
> +       KUNIT_ASSERT_NOT_NULL(test, param);
> +
> +       param_val =3D *param;
> +       KUNIT_EXPECT_EQ(test, param_val - param_val, 0);
> +}
> +
>  /*
>   * Here we make a list of all the test cases we want to add to the test =
suite
>   * below.
> @@ -414,6 +515,9 @@ static struct kunit_case example_test_cases[] =3D {
>         KUNIT_CASE_PARAM(example_params_test, example_gen_params),
>         KUNIT_CASE_PARAM_WITH_INIT(example_params_test_with_init, kunit_a=
rray_gen_params,
>                                    example_param_init, NULL),
> +       KUNIT_CASE_PARAM_WITH_INIT(example_params_test_with_init_dynamic_=
arr,
> +                                  kunit_array_gen_params, example_param_=
init_dynamic_arr,
> +                                  example_param_exit_dynamic_arr),
>         KUNIT_CASE_SLOW(example_slow_test),
>         {}
>  };
> --
> 2.51.0.rc0.205.g4a044479a3-goog
>

