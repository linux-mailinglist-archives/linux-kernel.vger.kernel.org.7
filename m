Return-Path: <linux-kernel+bounces-765646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBC9B23BD0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 00:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5651E5834FB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 22:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD64A2DEA99;
	Tue, 12 Aug 2025 22:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zYdNNtFx"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6362D0C9F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 22:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755037408; cv=none; b=lQ3LT+dTFxXSoBQMwwKrxGgsNXnef4gTpCpMPD5vWVV0yDLmkQO16AGWicjL7vkuyCQZqGei6xjZihO3eAfpfM1ZsduYjSeY7pF/o4ab/z4s4P87USyGTWMzZ6bKW9Cf1SN6dqAEqfyqrLHe34P5+aQCo/VwsVTq4TtQaF9lAxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755037408; c=relaxed/simple;
	bh=BAmU/+0qAEcaEMqPEI1xFi/3F6J6ic6RBk08Y2CZWkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MFnp7k63rGGT1vQ7GM+dks8ZKhdE4p5kuIajx/YDhYk8MLOczC2qtJM59NqOVKA0YK8rro3qyGJntx02D3BpLrm+MiOV9MfWhyW2UJ7AUDrQ8DSvti9mJDzTa9+o6dkXrSTedzfGnAWOUZaEX8RwwL5ZbCHjhqPdUktzkgRI/YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zYdNNtFx; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-70884da4b55so62082516d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 15:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755037406; x=1755642206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dd43W/9BQYq1dF7t5hnMw3+hXQjYGCxHF8+As7wEnrs=;
        b=zYdNNtFxZmUqrPLlnJLW7IHKWG1iHMKQ1xigGrhbYmN4ilem2rVaXTFG8wldEqOhKJ
         JHDgfyf+gH2MqXa2Mj4rY6Kkq3wLThE+VMO719QNECrzS6igZ+P/4xBgZhSdoe7X49/c
         7CklZA0s+NP7ESJQBu+oYPgjwOkVT/CRZvPzljyuBEudjUk/ec1MFYAsFsLZXsxfVYZ0
         WVItqiZZLq7YIRVe9cNt5jQoZqq3UkXbk1V2o4kQje/1hp35dmog1xocVG3P3ACx4Gmk
         TmVBHsodjib36fVfwQTa6qAqNQJzzbf/c4bh/X621Yteey+tjw8J74rHxGadnCafihrt
         zWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755037406; x=1755642206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dd43W/9BQYq1dF7t5hnMw3+hXQjYGCxHF8+As7wEnrs=;
        b=G5psMgoCLbWB+9yoySSrp3Yd9PFjYSvBtazUczPB4Zwxa+rQ0/PxSTcu3JKi7QJ4UJ
         T8hJ0zkK+ozyH6KeJMMxnjm6tt8hjZIBuoZ4Ccbo1FRKr6uPNMW0jXety/PWicy3XOTb
         1Tnw0HK+5qy7mKUbd/NKnETnKqe6tmz5GVhfa0B8PCzVZF10s2a+pjpHhzXaB3DD+v8P
         wIaN0Efe/IbdAs6S6XdTSmDGvAG4Yk9eorLkmwIOIVQ1wpPaTLt61+Q/Qh9SxihP6027
         azuKN6H8LA0h8Xtp+tUXvYoBifKuXC1mzywNTdagqORprOG+A0+24fO5vbZ+vXlh1N4J
         eZbg==
X-Forwarded-Encrypted: i=1; AJvYcCVnBNQASIZ9qsnYKh2RXDnWS377PQ7/uQxdNpyWZTi3sc8OXK25S142zuN8DdflA1H3oqYfq3T/7Eyck6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0zNBzxQptCLBnq94eoUXndavKpBkVS0duQuU0HgOF0wFBJxM3
	PHPUTwlXuKBk9RwzlwBIVVO3KF7vuUx6u9/xbDQpdenfk1MApOsTiBlG0OQmP1PoK88TAde+tGM
	3s3u6xfPMnABrIjflv2/7rytPrt2R8019GLY0Ip9p
X-Gm-Gg: ASbGncs3i2X0hLrE8T7pAOnyM4MskM15CS43LSl3fI1GsVnCwVj+tKtBnjj0DRYXUpk
	C1qUN9VCnZeU/46nl+SxaFxUjhEdetzvVrrX1COK5R78Uw8UMu6ZAjSmyK2MdkSftqAR4KQ6OFd
	Pxf31Fm4RHg8B7wFcqoX1mKPzy+WVbVdPHuTe0E7Jjmt/WgcTcb/Ux8qk41QGiTI7p6V4PenN0U
	znMvvBGOUhCAl8T9NaADLteG9g=
X-Google-Smtp-Source: AGHT+IHd6SA3MgC97X9S7t36nkQOJaAvs7iyXRM57zpXLU3JvxlY/aXCRG/hBUTTR3Brlcu5At43PcBPjKyJ1p1qQ9E=
X-Received: by 2002:ad4:5946:0:b0:707:4d3f:c3ae with SMTP id
 6a1803df08f44-709e89af2f6mr10556356d6.36.1755037405616; Tue, 12 Aug 2025
 15:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811221739.2694336-1-marievic@google.com> <20250811221739.2694336-6-marievic@google.com>
In-Reply-To: <20250811221739.2694336-6-marievic@google.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 12 Aug 2025 18:23:14 -0400
X-Gm-Features: Ac12FXx4WN7bEpf6eQ3NksoUvds6szYBE3-JX5urqBkn2O7cDov_AcW1Yy1X-70
Message-ID: <CA+GJov4GzpyfEjjBa1j3C6f7bRKGFMmWocMw5CjqY2bJbnH-+A@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] kunit: Add example parameterized test with shared
 resource management using the Resource API
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
> Add example_params_test_with_init() to illustrate how to manage
> shared resources across a parameterized KUnit test. This example
> showcases the use of the new param_init() function and its registration
> to a test using the KUNIT_CASE_PARAM_WITH_INIT() macro.
>
> Additionally, the test demonstrates how to directly pass a parameter arra=
y
> to the parameterized test context via kunit_register_params_array()
> and leveraging the Resource API for shared resource management.
>
> Signed-off-by: Marie Zhussupova <marievic@google.com>
> ---
>
> Changes in v2:
>
> - kunit_array_gen_params() is now explicitly passed to
>   KUNIT_CASE_PARAM_WITH_INIT() to be consistent with
>   a parameterized test being defined by the existence
>   of the generate_params() function.
> - The comments were edited to be more concise.
> - The patch header was changed to reflect that this example
>   test's intent is more aligned with showcasing using the
>   Resource API for shared resource management.
> - The comments and the commit message were changed to
>   reflect the parameterized testing terminology. See
>   the patch series cover letter change log for the
>   definitions.

Hello!

Thank you for adding this example test! As before, this test looks good to =
me:

Reviewed-by: Rae Moar <rmoar@google.com>
Thanks!

-Rae

>
> ---
>
>  lib/kunit/kunit-example-test.c | 118 +++++++++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
>
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-tes=
t.c
> index 3056d6bc705d..f2819ee58965 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -277,6 +277,122 @@ static void example_slow_test(struct kunit *test)
>         KUNIT_EXPECT_EQ(test, 1 + 1, 2);
>  }
>
> +/*
> + * This custom function allocates memory and sets the information we wan=
t
> + * stored in the kunit_resource->data field.
> + */
> +static int example_resource_init(struct kunit_resource *res, void *conte=
xt)
> +{
> +       int *info =3D kmalloc(sizeof(*info), GFP_KERNEL);
> +
> +       if (!info)
> +               return -ENOMEM;
> +       *info =3D *(int *)context;
> +       res->data =3D info;
> +       return 0;
> +}
> +
> +/*
> + * This function deallocates memory for the kunit_resource->data field.
> + */
> +static void example_resource_free(struct kunit_resource *res)
> +{
> +       kfree(res->data);
> +}
> +
> +/*
> + * This match function is invoked by kunit_find_resource() to locate
> + * a test resource based on certain criteria.
> + */
> +static bool example_resource_alloc_match(struct kunit *test,
> +                                        struct kunit_resource *res,
> +                                        void *match_data)
> +{
> +       return res->data && res->free =3D=3D example_resource_free;
> +}
> +
> +/*
> + * This is an example of a function that provides a description for each=
 of the
> + * parameters in a parameterized test.
> + */
> +static void example_param_array_get_desc(struct kunit *test, const void =
*p, char *desc)
> +{
> +       const struct example_param *param =3D p;
> +
> +       snprintf(desc, KUNIT_PARAM_DESC_SIZE,
> +                "example check if %d is less than or equal to 3", param-=
>value);
> +}
> +
> +/*
> + * This function gets passed in the parameterized test context i.e. the
> + * struct kunit belonging to the parameterized test. You can use this fu=
nction
> + * to add resources you want shared across the whole parameterized test =
or
> + * for additional setup.
> + */
> +static int example_param_init(struct kunit *test)
> +{
> +       int ctx =3D 3; /* Data to be stored. */
> +       size_t arr_size =3D ARRAY_SIZE(example_params_array);
> +
> +       /*
> +        * This allocates a struct kunit_resource, sets its data field to
> +        * ctx, and adds it to the struct kunit's resources list. Note th=
at
> +        * this is parameterized test managed. So, it doesn't need to hav=
e
> +        * a custom exit function to deallocation as it will get cleaned =
up at
> +        * the end of the parameterized test.
> +        */
> +       void *data =3D kunit_alloc_resource(test, example_resource_init, =
example_resource_free,
> +                                         GFP_KERNEL, &ctx);
> +
> +       if (!data)
> +               return -ENOMEM;
> +       /*
> +        * Pass the parameter array information to the parameterized test=
 context
> +        * struct kunit. Note that you will need to provide kunit_array_g=
en_params()
> +        * as the generator function to KUNIT_CASE_PARAM_WITH_INIT() when=
 registering
> +        * a parameter array this route.
> +        *
> +        * Alternatively, since this is a static array we can also use
> +        * KUNIT_CASE_PARAM_ARRAY(,DESC) to create  a `*_gen_params()` fu=
nction
> +        * and pass that to  KUNIT_CASE_PARAM_WITH_INIT() instead of regi=
stering
> +        * the parameter array here.
> +        */
> +       kunit_register_params_array(test, example_params_array, arr_size,
> +                                   example_param_array_get_desc);
> +       return 0;
> +}
> +
> +/*
> + * This is an example of a test that uses shared resources available in =
the
> + * parameterized test context.
> + */
> +static void example_params_test_with_init(struct kunit *test)
> +{
> +       int threshold;
> +       struct kunit_resource *res;
> +       const struct example_param *param =3D test->param_value;
> +
> +       /* By design, param pointer will not be NULL. */
> +       KUNIT_ASSERT_NOT_NULL(test, param);
> +
> +       /*
> +        * Here we pass test->parent to search for shared resources in th=
e
> +        * parameterized test context.
> +        */
> +       res =3D kunit_find_resource(test->parent, example_resource_alloc_=
match, NULL);
> +
> +       KUNIT_ASSERT_NOT_NULL(test, res);
> +
> +       /* Since kunit_resource->data is a void pointer we need to typeca=
st it. */
> +       threshold =3D *((int *)res->data);
> +
> +       /* Assert that the parameter is less than or equal to a certain t=
hreshold. */
> +       KUNIT_ASSERT_LE(test, param->value, threshold);
> +
> +       /* This decreases the reference count after calling kunit_find_re=
source(). */
> +       kunit_put_resource(res);
> +}
> +
>  /*
>   * Here we make a list of all the test cases we want to add to the test =
suite
>   * below.
> @@ -296,6 +412,8 @@ static struct kunit_case example_test_cases[] =3D {
>         KUNIT_CASE(example_static_stub_using_fn_ptr_test),
>         KUNIT_CASE(example_priv_test),
>         KUNIT_CASE_PARAM(example_params_test, example_gen_params),
> +       KUNIT_CASE_PARAM_WITH_INIT(example_params_test_with_init, kunit_a=
rray_gen_params,
> +                                  example_param_init, NULL),
>         KUNIT_CASE_SLOW(example_slow_test),
>         {}
>  };
> --
> 2.51.0.rc0.205.g4a044479a3-goog
>

