Return-Path: <linux-kernel+bounces-756654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C10CCB1B74A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65F6518A024F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106C52797A4;
	Tue,  5 Aug 2025 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e1YCQnHk"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F509277C98
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754407137; cv=none; b=IOeo+XAJT6c3rIBqdoxpD5sVLU0PfS4ATu3gpAbT1JnyiT0mjkJ6opB5MfQ6jKZwXHadN+bNWJoqB7C9cSlivm4gAJo55K+OjQCdQzloQhZNiq+mO/PcVmSQSJIse52AWIRss7rdsVlqGJCU2XQlV1DKi2nIEQ8N8uaA3Tt2btw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754407137; c=relaxed/simple;
	bh=zTuaxwh5BUEANXMKajqP0pb4ZTzy3suUZ14oNwTNt94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWQMXbTkGlxzqxY8QkF0YV+L4LH66fDuoHYiyPWyf2BSrx/UhXrjA3HFBL1Q7GeDeZr8LB/zGBs4wrCJ+qGiszYfOrWs1CU61CETavYPYBIpSspoLQiTHnmrZ6jUffiNEjRNg+O0S68Ui6x/pjrtbytiYz8yWeXl52NAL8uvUMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e1YCQnHk; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-7074bad053aso56291986d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 08:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754407134; x=1755011934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HJX1dAULQPf05eofh/qdij5Fv1pcs+BHpuoBOdIhSk=;
        b=e1YCQnHkuWkikWIxEYeLbVVktD+o/nvw1+scJrUiY9Hcj7Riu6onUQxpJ3wxSuI6u/
         kwCNKdw61AKIcAlhvSMxcEkUXHCCzX4SVOUM0qhpS1aELySX7/sv4eQPk6WAfvNwX9b1
         ZZPRI4YpiVlTreCrwCxsiVzf+kDL1gakkAyQRdxeI3lSCOcVdCT/XLlaatJAtIOF9V5Y
         MC/ukI2iXhz33GtJF8qgweELuT0332Ew5+wOAn9dqT2XdAcvVL8pN/fbjTwJiCW+iYH0
         LeFGjP7/Cct0NgSiWVRvlRYivo7mx1vgfHXilBCMaDNshoVBnLC48loDM5BBsaAo64x5
         UJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754407134; x=1755011934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HJX1dAULQPf05eofh/qdij5Fv1pcs+BHpuoBOdIhSk=;
        b=NnZYRaRPwyvthwn9oxuSxnNMqzrzCequgRm/FYWiXdaHRfA3b3Lkr+z3TaogeN7ajv
         DW0WQxlygccqwlP8X2S1NH4UrMahbjVSrYIsIVLKRScFBl3TDakHUOlGtJcVP3Pkn0n4
         5gEsQkRQb8MuyFIuQHO4VXwgUGbav1UkVdczsn3EzdqK0pwqGneGAM+5dJ4YTejcNhyQ
         NCfHWycMDePBuTBmwK4ujZKWjBjgPvVGEoO1Q2H3QxwhrfWpQ+CmRamFF+6u+JuPIeDa
         laccJcrASb1WbF+PJsnwPBPPYSTgVWzqptyArtSDHGNVPpmoLgHAM1uAlTPU7o0VeYbB
         ojLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMQLUB7U2yT7LW7/EEOGzhyDIn3N9eMfQfdntc+gabIBpiAJKhP+OBZywc3BbBu/uss5kk8wQgOG09RaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc9l5o+O6p2rk2VM++2Tm8PpGO+qJgR6iVFzigikCbWww2T6/s
	isucfAA87+wqfaBG/2QHv9kjr86S5pP/x8akkQvBOxvb65cAWbjICZUSCFo7TCTD4wHjIlQLnC7
	O3fHC0vEKSjs14nwGwDbu43CtEZCqYodwNnqMOBZx
X-Gm-Gg: ASbGncvsMhatvbV9sRbdn1SlMoqJsj3QqsSqGnvh2n+LTOf0UblPPl5YF7RrfMp44lZ
	dyN4H3z0m/b3kbsoQsMAj1Wjr99B0cbC/+Ak5u7S1TXLkBXyXT6Il77XTsj/hYkNQtUxyCOvNZg
	ujstbGtrHTy12b6Hc27sUFNNHpC+YZnRtvUCP393iJWPrZ44Wgklnz+UHrGx9doMz8RxunlmXly
	nJp/qo5NDQEYcyqnsnOClw+aeE4y7G9yyYo19hdD4O+d997O0Kg
X-Google-Smtp-Source: AGHT+IGHJ5ef3IdUmvMY9Fai1WqvGC6EwXd/7iqbQ3HePEHnMcL7VbSWYRyb7kh7CFv5QoeLBBHPdXjnPeiP55uJDC8=
X-Received: by 2002:a05:6214:262b:b0:707:4539:5183 with SMTP id
 6a1803df08f44-70935ea93cfmr185305046d6.5.1754407133193; Tue, 05 Aug 2025
 08:18:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com> <20250729193647.3410634-7-marievic@google.com>
In-Reply-To: <20250729193647.3410634-7-marievic@google.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 5 Aug 2025 11:18:42 -0400
X-Gm-Features: Ac12FXxnJBB1YWr-XbyGzOFY7Eh7XZaJzVBa5N68AZZyN0_GMOzIt18D0BHtBBQ
Message-ID: <CA+GJov7AH5Qyiaua7LKZjVNRoUd==DiSXvd1UP7TcSzvn5JZtQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] kunit: Enable direct registration of parameter arrays
 to a KUnit test
To: Marie Zhussupova <marievic@google.com>
Cc: davidgow@google.com, shuah@kernel.org, brendan.higgins@linux.dev, 
	elver@google.com, dvyukov@google.com, lucas.demarchi@intel.com, 
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	kasan-dev@googlegroups.com, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 3:37=E2=80=AFPM Marie Zhussupova <marievic@google.c=
om> wrote:
>
> KUnit parameterized tests currently support two
> primary methods for getting parameters:
> 1.  Defining custom logic within a `generate_params`
>     function.
> 2.  Using the KUNIT_ARRAY_PARAM and KUNIT_ARRAY_PARAM_DESC
>     macros with pre-defined static arrays.
>
> These methods present limitations when dealing with
> dynamically generated parameter arrays, or in scenarios
> where populating parameters sequentially via
> `generate_params` is inefficient or overly complex.
>
> This patch addresses these limitations by adding a new
> `params_data` field to `struct kunit`, of the type
> `kunit_params`. The struct `kunit_params` is designed to
> store the parameter array itself, along with essential metadata
> including the parameter count, parameter size, and a
> `get_description` function for providing custom descriptions
> for individual parameters.
>
> The `params_data` field can be populated by calling the new
> `kunit_register_params_array` macro from within a
> `param_init` function. By attaching the parameter array
> directly to the parent kunit test instance, these parameters
> can be iterated over in kunit_run_tests() behind the scenes.
>
> This modification provides greater flexibility to the
> KUnit framework, allowing testers to easily register and
> utilize both dynamic and static parameter arrays.
>
> Signed-off-by: Marie Zhussupova <marievic@google.com>

Hello!

Very excited by the prospect of setting up an array dynamically
instead of statically for parameterized tests. In general, I am happy
to see this framework is becoming more flexible and therefore more
tailored to our test author's needs.

I already commented on the modpost error but I have a few more
comments and ideas below. Let me know what you think.

Thanks!
-Rae

> ---
>  include/kunit/test.h | 54 ++++++++++++++++++++++++++++++++++++++++----
>  lib/kunit/test.c     | 26 ++++++++++++++++++++-
>  2 files changed, 75 insertions(+), 5 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 4ba65dc35710..9143f0e22323 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -245,7 +245,8 @@ static inline char *kunit_status_to_ok_not_ok(enum ku=
nit_status status)
>   */
>  #define KUNIT_CASE_PARAM_WITH_INIT(test_name, gen_params, init, exit)   =
       \
>                 { .run_case =3D test_name, .name =3D #test_name,         =
           \
> -                 .generate_params =3D gen_params,                       =
         \
> +                 .generate_params =3D (gen_params)                      =
         \
> +                  ?: kunit_get_next_param_and_desc,                     =
       \
>                   .param_init =3D init, .param_exit =3D exit,            =
           \
>                   .module_name =3D KBUILD_MODNAME}
>
> @@ -294,6 +295,21 @@ struct kunit_suite_set {
>         struct kunit_suite * const *end;
>  };
>
> +/* Stores the pointer to the parameter array and its metadata. */
> +struct kunit_params {
> +       /*
> +        * Reference to the parameter array for the parameterized tests. =
This
> +        * is NULL if a parameter array wasn't directly passed to the
> +        * parent kunit struct via the kunit_register_params_array macro.
> +        */
> +       const void *params;
> +       /* Reference to a function that gets the description of a paramet=
er. */
> +       void (*get_description)(const void *param, char *desc);
> +
> +       int num_params;

Since in some cases we know the number of params within a series/suite
of the parameterized tests, is it possible for us to print a test plan
line in KTAP when this number is known? This would be helpful for
reading test results but also the parser could verify the number of
subtests is the number expected.

> +       size_t elem_size;
> +};
> +
>  /**
>   * struct kunit - represents a running instance of a test.
>   *
> @@ -302,12 +318,14 @@ struct kunit_suite_set {
>   * @parent: for user to store data that they want to shared across
>   *         parameterized tests. Typically, the data is provided in
>   *         the param_init function (see &struct kunit_case).
> + * @params_data: for users to directly store the parameter array.
>   *
>   * Used to store information about the current context under which the t=
est
>   * is running. Most of this data is private and should only be accessed
> - * indirectly via public functions; the two exceptions are @priv and @pa=
rent
> - * which can be used by the test writer to store arbitrary data or data =
that is
> - * available to all parameter test executions, respectively.
> + * indirectly via public functions. There are three exceptions to this: =
@priv,
> + * @parent, and @params_data. These members can be used by the test writ=
er to
> + * store arbitrary data, data available to all parameter test executions=
, and
> + * the parameter array, respectively.
>   */
>  struct kunit {
>         void *priv;
> @@ -316,6 +334,8 @@ struct kunit {
>          * during parameterized testing.
>          */
>         struct kunit *parent;
> +       /* Stores the params array and all data related to it. */
> +       struct kunit_params params_data;

I might slightly prefer the term params_array rather than params_data.
Up to what you prefer.

>
>         /* private: internal use only. */
>         const char *name; /* Read only after initialization! */
> @@ -386,6 +406,8 @@ void kunit_exec_list_tests(struct kunit_suite_set *su=
ite_set, bool include_attr)
>  struct kunit_suite_set kunit_merge_suite_sets(struct kunit_suite_set ini=
t_suite_set,
>                 struct kunit_suite_set suite_set);
>
> +const void *kunit_get_next_param_and_desc(struct kunit *test, const void=
 *prev, char *desc);
> +
>  #if IS_BUILTIN(CONFIG_KUNIT)
>  int kunit_run_all_tests(void);
>  #else
> @@ -1735,6 +1757,30 @@ do {                                              =
                              \
>                 return NULL;                                             =
                       \
>         }
>
> +/**
> + * kunit_register_params_array() - Register parameters for a KUnit test.
> + * @test: The KUnit test structure to which parameters will be added.
> + * @params_arr: An array of test parameters.
> + * @param_cnt: Number of parameters.
> + * @get_desc: A pointer to a function that generates a string descriptio=
n for
> + * a given parameter element.
> + *
> + * This macro initializes the @test's parameter array data, storing info=
rmation
> + * including the parameter array, its count, the element size, and the p=
arameter
> + * description function within `test->params_data`. KUnit's built-in
> + * `kunit_get_next_param_and_desc` function will automatically read this
> + * data when a custom `generate_params` function isn't provided.
> + */
> +#define kunit_register_params_array(test, params_arr, param_cnt, get_des=
c)                     \

I also might slightly prefer params_array and param_count here instead
of params_arr and param_cnt. Again this is definitely a nitpick so up
to you.

> +       do {                                                             =
                       \
> +               struct kunit *_test =3D (test);                          =
                 \
> +               const typeof((params_arr)[0]) * _params_ptr =3D &(params_=
arr)[0];                 \
> +               _test->params_data.params =3D _params_ptr;               =
                         \
> +               _test->params_data.num_params =3D (param_cnt);           =
                         \
> +               _test->params_data.elem_size =3D sizeof(*_params_ptr);   =
                         \
> +               _test->params_data.get_description =3D (get_desc);       =
                         \
> +       } while (0)
> +
>  // TODO(dlatypov@google.com): consider eventually migrating users to exp=
licitly
>  // include resource.h themselves if they need it.
>  #include <kunit/resource.h>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index f50ef82179c4..2f4b7087db3f 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -337,6 +337,13 @@ void __kunit_do_failed_assertion(struct kunit *test,
>  }
>  EXPORT_SYMBOL_GPL(__kunit_do_failed_assertion);
>
> +static void __kunit_init_params(struct kunit *test)
> +{
> +       test->params_data.params =3D NULL;
> +       test->params_data.num_params =3D 0;
> +       test->params_data.elem_size =3D 0;
> +}
> +
>  void kunit_init_test(struct kunit *test, const char *name, struct string=
_stream *log)
>  {
>         spin_lock_init(&test->lock);
> @@ -347,6 +354,7 @@ void kunit_init_test(struct kunit *test, const char *=
name, struct string_stream
>                 string_stream_clear(log);
>         test->status =3D KUNIT_SUCCESS;
>         test->status_comment[0] =3D '\0';
> +       __kunit_init_params(test);
>  }
>  EXPORT_SYMBOL_GPL(kunit_init_test);
>
> @@ -641,6 +649,22 @@ static void kunit_accumulate_stats(struct kunit_resu=
lt_stats *total,
>         total->total +=3D add.total;
>  }
>
> +const void *kunit_get_next_param_and_desc(struct kunit *test, const void=
 *prev, char *desc)
> +{
> +       struct kunit_params *params_arr =3D &test->params_data;
> +       const void *param;
> +
> +       if (test->param_index < params_arr->num_params) {
> +               param =3D (char *)params_arr->params
> +                       + test->param_index * params_arr->elem_size;
> +
> +               if (params_arr->get_description)
> +                       params_arr->get_description(param, desc);
> +               return param;
> +       }
> +       return NULL;
> +}

I also agree with David that it should definitely be considered: 1 -
whether to utilize struct kunit_params for the case of using
KUNIT_ARRAY_PARAM and 2 - whether the user should actively input this
function instead of setting generate_params to NULL.

Another idea that just popped into my head is if we have access to
struct kunit* test now in all of the generate_params functions,
instead of setting a "desc" could we just set the test->name field?

> +
>  static void __kunit_init_parent_test(struct kunit_case *test_case, struc=
t kunit *test)
>  {
>         if (test_case->param_init) {
> @@ -687,7 +711,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>                         /* Test marked as skip */
>                         test.status =3D KUNIT_SKIPPED;
>                         kunit_update_stats(&param_stats, test.status);
> -               } else if (!test_case->generate_params) {
> +               } else if (!test_case->generate_params && !test.params_da=
ta.params) {

I agree with David that it is helpful to have one check for whether a
test is a parameterized test rather than two. My instinct is that if
test_case->generate_params is NULL it should be safe to assume the
test isn't a parameterized test.

However, as an alternative or even as a helpful addition, I like the
idea of a simple kunit_test_is_param function that can pass in the
test and it will return a bool whether the test is parameterized or
not.




>                         /* Non-parameterised test. */
>                         test_case->status =3D KUNIT_SKIPPED;
>                         kunit_run_case_catch_errors(suite, test_case, &te=
st);
> --
> 2.50.1.552.g942d659e1b-goog
>

