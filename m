Return-Path: <linux-kernel+bounces-756650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E90DDB1B73D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A5881899888
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DDF2797B2;
	Tue,  5 Aug 2025 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IyGJnCnV"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E032749DA
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754407067; cv=none; b=a3hXjlAq0tEM5IBOP9HleP2nUzyKTzHIrmxbvsrgTAXj/Sc0xXBRi6ft35EedNTc3GHyvdWkxYFWv4z9+sipqhKVjPTzfli/j0qxxKMwjzsMY9br8UpjEFdyK0VY+WNmkxd6bic4MLLzp2ZiXCKS75C0U5ruQBJtH6GeW/1zdIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754407067; c=relaxed/simple;
	bh=4uTGqFw4J++VGhGxbRFCBduEWyWz/aIs8wS094wvPZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZvMvqkfSnxii9Dx8iPzGvHRtRTpxRN2NyU5bcgo+XWwD+vyEnksFDfozbBYiRh4a8tpxL9t0WQYz80A2HxB+PVBBWhdYh0/sp3csQWp3/tWPwvCCjfkn3hRJSgX1a409YBUhhbaJq9wylLHFfXmTSUvVebf+Yxz76f0h4gwo/TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IyGJnCnV; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-7074a74248dso50867806d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 08:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754407065; x=1755011865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IXs2Kr/JIndnkNpfZSfduZvVHbFnK3EtPg4aqdOsRc=;
        b=IyGJnCnVWr6LUH6Eq53gxZ69P7Bu1k6W1K43xwWrYr7hkj3PTVHlSIXy3mn1W3o7l/
         OFgQqGipejhfS8YGTv1gt5uEWive2pgm+8l4gOgUlyFY7AEtFye7OoiIBFuYehvDsu6Y
         9RC3mswKNLdXubMuBjufOcD2DPq4L5v/LrRxJRH//RWnZvdGrxs28CtPuid8t9/zbQME
         m4q49GRRE+PkXEr4PgHMO50iG/ZaTmca0yoPvKxeCKVJ2WcUV0vgvz8RLdJI4+f9gI+2
         f6KHK52VZwrWcBaq9VTphIEh5XecIjcy1DV27lEf4B1AxblI6MKemTOfdhTmCXnY5/Mr
         WDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754407065; x=1755011865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IXs2Kr/JIndnkNpfZSfduZvVHbFnK3EtPg4aqdOsRc=;
        b=WN43Mixmh3UKwxlAA1jSaKr/3132XYBnbdUet7LZx9iy5QDyMS+mJKsBjY6g92jwY6
         mi9yd4QTg+8smD+XOybCg5FjyFuiCLDucZQ1wvSWGfSDKieYR89xUQcXp/tB5LVLGV71
         o55H0rdTDYMdE0MbeTUn8WY+7rODIGoau9fgxKl4Eb/evwVgjLL6daaXm3LZDYzloM+K
         wrog61p4rBdOP/Ne1HfUJbRh1UtgxRBxpStTH7RuZ6aJYFkXt1EKvHXaX9k5clp9/nKi
         jnwNpdCYwk8gA0Bir/MHy1qMnutC+U/FYFnJXHelo2x+J9J02nhoWtQjShpRZHyFA+cY
         B0NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs0FWEGe2AYVLDbdQewgKB2W6C9nm467CuqWgXf8FMqRVAfQdKPh9Wu5UrZL+GeufyE1VqIxq8GvpKdkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlaMk5sSv6z5UDGGqiUEakJAUN3pn03E9We+jCeFdCdmD3yrKG
	32CJp+AgzrVctS13IrRzhOZlRKsiUxAczomrpX8XGt6BhlXrCP9x1Q568WTpupLUc45JpcXnBeX
	ZpPYuy/EaXNspTTQdpmXGvknuaEoGpsr2X7SrRpKj
X-Gm-Gg: ASbGncsHhCUCHyTW5WpgCjyrzT+/XLnwgahULuXn7eaJuzVDuI+EU7N478+gHDYLyiz
	UDpkM2D7t6S7uwWO2AMjgkLcHwUPs5/B9CCMj62AP7gg05bhoXSDWxUpgZ5HNHP0mfZXsq8dQDd
	FRop5bsRnxmots6s4KpBaHzZyI0QrvIG+UIGNErBP9cduWEvemUHylUXONWz5iBws3Ki0MS6qwJ
	QLGc7xj7HHLaoNtDI4FU2Bw+WWlNKcWOBc6gidvhg==
X-Google-Smtp-Source: AGHT+IHa9Nch2FIZBNvQFdt72fBtGdTNiWpLK+36OZqHE3rAqtd4pqYuQh8Gb7ugOeLVkjRMznl5Qph/PIQV3EAFD/c=
X-Received: by 2002:ad4:5765:0:b0:706:f753:6b1f with SMTP id
 6a1803df08f44-70935fb3038mr189139186d6.21.1754407064119; Tue, 05 Aug 2025
 08:17:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com> <20250729193647.3410634-2-marievic@google.com>
In-Reply-To: <20250729193647.3410634-2-marievic@google.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 5 Aug 2025 11:17:33 -0400
X-Gm-Features: Ac12FXze3TaZ1ItJhvvsVg6J8U-v3wToEcNYmNz4bKxujCA6Thw0S4iJb4SdDqU
Message-ID: <CA+GJov4BQ1mRa-JaHoML+gF7rk=XY=hCRL+Shag6Aj6VbUgUeg@mail.gmail.com>
Subject: Re: [PATCH 1/9] kunit: Add parent kunit for parameterized test context
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
> Currently, KUnit parameterized tests lack a mechanism
> to share resources across individual test invocations
> because the same `struct kunit` instance is reused for
> each test.
>
> This patch refactors kunit_run_tests() to provide each
> parameterized test with its own `struct kunit` instance.
> A new parent pointer is added to `struct kunit`, allowing
> individual parameterized tests to reference a shared
> parent kunit instance. Resources added to this parent
> will then be accessible to all individual parameter
> test executions.
>
> Signed-off-by: Marie Zhussupova <marievic@google.com>

Hello!

Thank you so much for sending out this series. I have wanted to see an
update of our parameterized test framework for a while. I have a few
comments below for this patch. But otherwise it is looking good.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
>  include/kunit/test.h | 12 ++++++++++--
>  lib/kunit/test.c     | 32 +++++++++++++++++++-------------
>  2 files changed, 29 insertions(+), 15 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 39c768f87dc9..a42d0c8cb985 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -268,14 +268,22 @@ struct kunit_suite_set {
>   *
>   * @priv: for user to store arbitrary data. Commonly used to pass data
>   *       created in the init function (see &struct kunit_suite).
> + * @parent: for user to store data that they want to shared across
> + *         parameterized tests.
>   *

As David mentioned, I would also prefer that this provides a more
general description of the @parent field here. Although this is
currently only used for parameterized tests, it could have other use
cases in the future.

>   * Used to store information about the current context under which the t=
est
>   * is running. Most of this data is private and should only be accessed
> - * indirectly via public functions; the one exception is @priv which can=
 be
> - * used by the test writer to store arbitrary data.
> + * indirectly via public functions; the two exceptions are @priv and @pa=
rent
> + * which can be used by the test writer to store arbitrary data or data =
that is
> + * available to all parameter test executions, respectively.

In addition, I would prefer that the call out to @parent here is also
changed to a more general description of the @parent field. However,
feel free to also include the description of the use case for the
parameterized tests.

>   */
>  struct kunit {
>         void *priv;
> +       /*
> +        * Reference to the parent struct kunit for storing shared resour=
ces
> +        * during parameterized testing.
> +        */

I am more 50/50 on changing this description. Could change it just to:
"Reference to the parent struct kunit for storing shared resources."

> +       struct kunit *parent;
>
>         /* private: internal use only. */
>         const char *name; /* Read only after initialization! */
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index f3c6b11f12b8..4d6a39eb2c80 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -647,6 +647,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>         struct kunit_case *test_case;
>         struct kunit_result_stats suite_stats =3D { 0 };
>         struct kunit_result_stats total_stats =3D { 0 };
> +       const void *curr_param;
>
>         /* Taint the kernel so we know we've run tests. */
>         add_taint(TAINT_TEST, LOCKDEP_STILL_OK);
> @@ -679,36 +680,39 @@ int kunit_run_tests(struct kunit_suite *suite)
>                 } else {
>                         /* Get initial param. */
>                         param_desc[0] =3D '\0';
> -                       test.param_value =3D test_case->generate_params(N=
ULL, param_desc);
> +                       /* TODO: Make generate_params try-catch */
> +                       curr_param =3D test_case->generate_params(NULL, p=
aram_desc);
>                         test_case->status =3D KUNIT_SKIPPED;
>                         kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT =
KUNIT_SUBTEST_INDENT
>                                   "KTAP version 1\n");
>                         kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT =
KUNIT_SUBTEST_INDENT
>                                   "# Subtest: %s", test_case->name);
>
> -                       while (test.param_value) {
> -                               kunit_run_case_catch_errors(suite, test_c=
ase, &test);
> +                       while (curr_param) {
> +                               struct kunit param_test =3D {
> +                                       .param_value =3D curr_param,
> +                                       .param_index =3D ++test.param_ind=
ex,
> +                                       .parent =3D &test,
> +                               };
> +                               kunit_init_test(&param_test, test_case->n=
ame, test_case->log);
> +                               kunit_run_case_catch_errors(suite, test_c=
ase, &param_test);
>
>                                 if (param_desc[0] =3D=3D '\0') {
>                                         snprintf(param_desc, sizeof(param=
_desc),
>                                                  "param-%d", test.param_i=
ndex);

This probably doesn't matter too much either way but should this be
param_test.param_index instead? This would cover the case where the
param_index is changed during the test run even though it shouldn't.

>                                 }
>
> -                               kunit_print_ok_not_ok(&test, KUNIT_LEVEL_=
CASE_PARAM,
> -                                                     test.status,
> -                                                     test.param_index + =
1,
> +                               kunit_print_ok_not_ok(&param_test, KUNIT_=
LEVEL_CASE_PARAM,
> +                                                     param_test.status,
> +                                                     param_test.param_in=
dex,
>                                                       param_desc,
> -                                                     test.status_comment=
);
> +                                                     param_test.status_c=
omment);
>
> -                               kunit_update_stats(&param_stats, test.sta=
tus);
> +                               kunit_update_stats(&param_stats, param_te=
st.status);
>
>                                 /* Get next param. */
>                                 param_desc[0] =3D '\0';
> -                               test.param_value =3D test_case->generate_=
params(test.param_value, param_desc);
> -                               test.param_index++;
> -                               test.status =3D KUNIT_SUCCESS;
> -                               test.status_comment[0] =3D '\0';
> -                               test.priv =3D NULL;
> +                               curr_param =3D test_case->generate_params=
(curr_param, param_desc);
>                         }
>                 }
>
> @@ -723,6 +727,8 @@ int kunit_run_tests(struct kunit_suite *suite)
>
>                 kunit_update_stats(&suite_stats, test_case->status);
>                 kunit_accumulate_stats(&total_stats, param_stats);
> +               /* TODO: Put this kunit_cleanup into a try-catch. */
> +               kunit_cleanup(&test);

I might be missing something here but why not do this cleanup before
the printing stage and only if the test was a parent param test?



>         }
>
>         if (suite->suite_exit)
> --
> 2.50.1.552.g942d659e1b-goog
>

