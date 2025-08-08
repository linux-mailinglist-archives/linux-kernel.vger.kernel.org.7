Return-Path: <linux-kernel+bounces-760277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66677B1E8D5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C340C1C237FD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827F4279323;
	Fri,  8 Aug 2025 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gbW1SSpX"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8992927A91D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754658088; cv=none; b=TxH34D/GDCpiFA8aklandQYP0wOQuXg3P36i2/9b31CFRRc48640MaJuWTySTyowcm+uPlZr34azGki+LR7xTuSvPX8thLMhNKyDXnOlPZyKGP/EYBfrxre6/gcCX9rM7VsL8TAz2duSNPoApOa0zPJ0qsBb9l+FYDYnUuUPIdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754658088; c=relaxed/simple;
	bh=3GhGLCHzmf946Haxa7tqjrB1qbT7MfyLihvdmo1j+iM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UyafsCL8sZl9RvSP1+Hpb2ngNe5mBueyzgyqw9hEujdpnX3YEpUYdjTRYQEZCprQxflOLPWRizzNDiPRXz7CfTxxQgReMsITM4QKLbc1OHr2tcXg8tpo2G/gK+bi4INxAT+HV2m3Gbiu663ZsHNQt3GMTZMbpeX9CNdq8qQE31c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gbW1SSpX; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6156c3301ccso8643a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 06:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754658085; x=1755262885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=el10QOQEfFkF9p6pSruNEIfZL6m4W9xzMCWGyL33LoI=;
        b=gbW1SSpXWI4z5j+P+kpgRNGxKykbkanDxGINVRo9IjLSMVcJS0lQKhhmzBiQNyn2J1
         1B0mOOuTLKyoFJzG0E3HE+SNsFQGFinyT7GNv5CZ3Pd3pYwLwMznAvn74RxyRx9Dhk40
         m9PMJ2KF1DrP8KwcSIQN7WIgJuvBF84mWSJPFYxLvj6Vgwckvo/dhq1l8+fPE+oYbihs
         dSaTs5OlXhROazNP7FC37bT7IjWvB9UmHvK+4us+A5OEXoGUcxm+wBFgRqoTf8YQQ8Kq
         Gvyt6exRzLjI8L0Crx1f9cEqUSNhR5R+YgChyQ1qpTAi3ZeLPRE6rhbouC7qv/Y6pToG
         sHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754658085; x=1755262885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=el10QOQEfFkF9p6pSruNEIfZL6m4W9xzMCWGyL33LoI=;
        b=aE526HKiZcT7lMJnatQRZXU+Fk+UO1f9nou3y80AaJx5coVNgFvZOVzRVaUNBSFe25
         PqdLeA7OOGPs/vMCbcc6BUA5uu4rWMDmnbZfilnq1CDzJWRBxSasMt21a+Ij0ARYBIJr
         0gEQeniLHx3tWEr8keL1D0EQ1IEP7dslLB1pf9BHGA9lbJe9qlyk/11ytkH+QiynkufQ
         JsZb0zDGSGZcu8MXAWKUg3WQxxtXAYbrhYAqvnSLUvc0A4fVid/Ab6ogbDL6lOzpZshv
         /qwQgyG5GbJqkWjZHFRCoc/p8bQ5V+29NzLjLsoztIFI/TQPavgPXovqe41mNjIrop+T
         yYpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGX2BXYQ+p6pE21Y72MJq6Q7N6UBT6+ZTociqRHZwWlkwR+PjPLZQayfA6KB7sDTrD5eJTbw3HclnZmrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY02kSOHNgKKgqRXV3f4Xa4saK5MD2+cUd39m85cA6wwUkfxtx
	KWGIG54Xf6Dw3HT9PvzyzwN/ELyBbFGjb6B3GxJ+kDtjLWFbrhQmuejGC/wxmhHiPNeIoViHZgF
	ibSgDJXF0Zc8dbS4FDyui6bS90byatviAv0+YfgF1
X-Gm-Gg: ASbGncsDOpA5F3RD0nJVcGr+SNvVyXm0TmzzNl4XiNzfrZIeEuOsbalDxj3RZEUmfXU
	FCjtTCxEdrgfLNWkQS12wdtvh47MFwwk2Kwvl4vxupmS3yIA2gxE7BgTucuRL3WJL06z8aKqwSp
	PsSQhmnjockOve2yVS6gtgLT6yoAGgXH8GPF7KliafxJHdMTFkNNIkcZ2bPyp+QKP/4jhl3Shtn
	UFP/cAD
X-Google-Smtp-Source: AGHT+IHtuiN9mDRQxccaUEGnFq3haaKpvRXvsbPz32ZppWzDXTwGOn/a0aI41FhPm9sgUkEKck1hcKgb1YiS54Za1Lw=
X-Received: by 2002:a05:6402:292f:b0:615:63af:84c7 with SMTP id
 4fb4d7f45d1cf-617e0c2fea6mr72212a12.0.1754658084244; Fri, 08 Aug 2025
 06:01:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com> <20250729193647.3410634-3-marievic@google.com>
 <CA+GJov5R2GnBfxXR=28vS3F4b1E-=WLDXpgdJo0SpKAXb1dpsw@mail.gmail.com>
In-Reply-To: <CA+GJov5R2GnBfxXR=28vS3F4b1E-=WLDXpgdJo0SpKAXb1dpsw@mail.gmail.com>
From: Marie Zhussupova <marievic@google.com>
Date: Fri, 8 Aug 2025 09:01:11 -0400
X-Gm-Features: Ac12FXyqcN3QWXqYkDaIcNwJHxUBYobG5GbAMtvuIIACGkmsNKYyn--VKTTbYU0
Message-ID: <CAAkQn5JXHFRXRRfUCWZDi+d0mDvGsgKW0poWgj5XCJGz_YTw8w@mail.gmail.com>
Subject: Re: [PATCH 2/9] kunit: Introduce param_init/exit for parameterized
 test shared context management
To: Rae Moar <rmoar@google.com>
Cc: davidgow@google.com, shuah@kernel.org, brendan.higgins@linux.dev, 
	elver@google.com, dvyukov@google.com, lucas.demarchi@intel.com, 
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	kasan-dev@googlegroups.com, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 11:18=E2=80=AFAM Rae Moar <rmoar@google.com> wrote:
>
> On Tue, Jul 29, 2025 at 3:37=E2=80=AFPM Marie Zhussupova <marievic@google=
.com> wrote:
> >
> > Add `param_init` and `param_exit` function pointers to
> > `struct kunit_case`. Users will be able to set them
> > via the new `KUNIT_CASE_PARAM_WITH_INIT` macro.
>
> Hello!
>
> Very intrigued by this idea to add an init and exit function for
> parameterized tests. In a way, this allows parameterized test series
> to act more like suites. Either way I am happy to see more flexibility
> being brought to the parameterized test framework.
>
> I have a few comments below that I would like to discuss before a
> final review. But this patch is looking good.
>
> Thanks!
> -Rae
>
> >
> > These functions are invoked by kunit_run_tests() once before
> > and once after the entire parameterized test series, respectively.
>
> This is a philosophical question but should we refer to a group of
> parameterized tests as a parameterized test series or a parameterized
> test suite? In the KTAP, the appearance is identical to a suite but in
> the running of the tests it acts distinct to a test case or suite.
> Curious on David's opinion here.
>

Thank you for bringing this up! Using the wording of the patch that
introduced the parameterized tests:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/l=
ib/kunit?id=3Dfadb08e7c7501ed42949e646c6865ba4ec5dd948,
"parameterized test" will refer to a group of parameterized tests and
"parameter run" will refer to a single parameter execution. I will also
specify this terminology in the docs for v2.

> > They will receive the parent kunit test instance, allowing users
> > to register and manage shared resources. Resources added to this
> > parent kunit test will be accessible to all individual parameterized
> > tests, facilitating init and exit for shared state.
> >
> > Signed-off-by: Marie Zhussupova <marievic@google.com>
> > ---
> >  include/kunit/test.h | 33 ++++++++++++++++++++++++++++++++-
> >  lib/kunit/test.c     | 23 ++++++++++++++++++++++-
> >  2 files changed, 54 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index a42d0c8cb985..d8dac7efd745 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -92,6 +92,8 @@ struct kunit_attributes {
> >   * @name:     the name of the test case.
> >   * @generate_params: the generator function for parameterized tests.
> >   * @attr:     the attributes associated with the test
> > + * @param_init: The init function to run before parameterized tests.
> > + * @param_exit: The exit function to run after parameterized tests.
>
> If we decide on a terminology for the parameterized test group, it
> might be clearer to label these "The init function to run before
> parameterized test [suite/series]." and same for the exit function.
>

Will update this in v2.

> >   *
> >   * A test case is a function with the signature,
> >   * ``void (*)(struct kunit *)``
> > @@ -129,6 +131,13 @@ struct kunit_case {
> >         const void* (*generate_params)(const void *prev, char *desc);
> >         struct kunit_attributes attr;
> >
> > +       /*
> > +        * Optional user-defined functions: one to register shared reso=
urces once
> > +        * before the parameterized test series, and another to release=
 them after.
> > +        */
> > +       int (*param_init)(struct kunit *test);
> > +       void (*param_exit)(struct kunit *test);
> > +
> >         /* private: internal use only. */
> >         enum kunit_status status;
> >         char *module_name;
> > @@ -218,6 +227,27 @@ static inline char *kunit_status_to_ok_not_ok(enum=
 kunit_status status)
> >                   .generate_params =3D gen_params,                     =
           \
> >                   .attr =3D attributes, .module_name =3D KBUILD_MODNAME=
}
> >
> > +/**
> > + * KUNIT_CASE_PARAM_WITH_INIT() - Define a parameterized KUnit test ca=
se with custom
> > + * init and exit functions.
> > + * @test_name: The function implementing the test case.
> > + * @gen_params: The function to generate parameters for the test case.
> > + * @init: The init function to run before parameterized tests.
> > + * @exit: The exit function to run after parameterized tests.
>
> If we do change the description above of param_init/param_exit, it
> might be nice to change it here too.
>

Will update this, as well.

> > + *
> > + * Provides the option to register init and exit functions that take i=
n the
> > + * parent of the parameterized tests and run once before and once afte=
r the
> > + * parameterized test series. The init function can be used to add any=
 resources
> > + * to share between the parameterized tests or to pass parameter array=
s. The
> > + * exit function can be used to clean up any resources that are not ma=
naged by
> > + * the test.
> > + */
> > +#define KUNIT_CASE_PARAM_WITH_INIT(test_name, gen_params, init, exit) =
         \
> > +               { .run_case =3D test_name, .name =3D #test_name,       =
             \
> > +                 .generate_params =3D gen_params,                     =
           \
> > +                 .param_init =3D init, .param_exit =3D exit,          =
             \
> > +                 .module_name =3D KBUILD_MODNAME}
> > +
> >  /**
> >   * struct kunit_suite - describes a related collection of &struct kuni=
t_case
> >   *
> > @@ -269,7 +299,8 @@ struct kunit_suite_set {
> >   * @priv: for user to store arbitrary data. Commonly used to pass data
> >   *       created in the init function (see &struct kunit_suite).
> >   * @parent: for user to store data that they want to shared across
> > - *         parameterized tests.
> > + *         parameterized tests. Typically, the data is provided in
> > + *         the param_init function (see &struct kunit_case).
> >   *
> >   * Used to store information about the current context under which the=
 test
> >   * is running. Most of this data is private and should only be accesse=
d
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index 4d6a39eb2c80..d80b5990d85d 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -641,6 +641,19 @@ static void kunit_accumulate_stats(struct kunit_re=
sult_stats *total,
> >         total->total +=3D add.total;
> >  }
> >
> > +static void __kunit_init_parent_test(struct kunit_case *test_case, str=
uct kunit *test)
>
> It would be nice to include "param" in this function name. Currently
> it sounds more like you are initializing the @parent field of struct
> kunit *test.

That is a great suggestion, I will incorporate it in v2.

>
> > +{
> > +       if (test_case->param_init) {
> > +               int err =3D test_case->param_init(test);
> > +
> > +               if (err) {
> > +                       kunit_err(test_case, KUNIT_SUBTEST_INDENT KUNIT=
_SUBTEST_INDENT
> > +                               "# failed to initialize parent paramete=
r test.");
> > +                       test_case->status =3D KUNIT_FAILURE;
> > +               }
> > +       }
> > +}
> > +
> >  int kunit_run_tests(struct kunit_suite *suite)
> >  {
> >         char param_desc[KUNIT_PARAM_DESC_SIZE];
> > @@ -668,6 +681,8 @@ int kunit_run_tests(struct kunit_suite *suite)
> >                 struct kunit_result_stats param_stats =3D { 0 };
> >
> >                 kunit_init_test(&test, test_case->name, test_case->log)=
;
> > +               __kunit_init_parent_test(test_case, &test);
> > +
>
> Is it possible to move this so this function is only called when it is
> a parameterized test? I see the check for KUNIT_FAILURE is useful but
> I think I would still prefer this within the section for parameterized
> tests.

Yes, I will do that, unless we decide to go with the route
to set generate_params to point to kunit_get_next_param_and_desc
in the __kunit_init_parent_test function.

>
> >                 if (test_case->status =3D=3D KUNIT_SKIPPED) {
> >                         /* Test marked as skip */
> >                         test.status =3D KUNIT_SKIPPED;
> > @@ -677,7 +692,7 @@ int kunit_run_tests(struct kunit_suite *suite)
> >                         test_case->status =3D KUNIT_SKIPPED;
> >                         kunit_run_case_catch_errors(suite, test_case, &=
test);
> >                         kunit_update_stats(&param_stats, test.status);
> > -               } else {
> > +               } else if (test_case->status !=3D KUNIT_FAILURE) {
> >                         /* Get initial param. */
> >                         param_desc[0] =3D '\0';
> >                         /* TODO: Make generate_params try-catch */
> > @@ -727,6 +742,12 @@ int kunit_run_tests(struct kunit_suite *suite)
> >
> >                 kunit_update_stats(&suite_stats, test_case->status);
> >                 kunit_accumulate_stats(&total_stats, param_stats);
> > +               /*
> > +                * TODO: Put into a try catch. Since we don't need suit=
e->exit
> > +                * for it we can't reuse kunit_try_run_cleanup for this=
 yet.
> > +                */
> > +               if (test_case->param_exit)
> > +                       test_case->param_exit(&test);
>
> Also here I am not sure why this is done outside of the check for if
> the test is parameterized? Either way this should definitely be done
> before the test stats and ok/not ok line are printed because if there
> is any log output during the param_exit function it is necessary to
> print that before the status line to identify that that log
> corresponds with that test.

Thank you for catching this! Yes, it should be inside the check for if
the test is parameterized.

>
> Also just curious why you chose to implement a function to perform the
> param_init but not the param_exit?

To be consistent with the existing style of "exit" functions in KUnit,
test->param_exit returns void. Therefore, similar to how it's done for
suite->suite_exit
(https://elixir.bootlin.com/linux/v6.16/source/lib/kunit/test.c#L685),
I didn't do extra error handling as the function itself doesn't
indicate an error and
therefore, didn't put it in a separate function. To do error handling
for it, it would
need to be in a try catch, then we could check if the cleanup timed out or
if there was an internal error.

>
>
>
> >                 /* TODO: Put this kunit_cleanup into a try-catch. */
> >                 kunit_cleanup(&test);
> >         }
> > --
> > 2.50.1.552.g942d659e1b-goog
> >

