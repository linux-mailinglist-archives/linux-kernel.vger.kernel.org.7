Return-Path: <linux-kernel+bounces-758135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 463DAB1CB72
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8BD518C525E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6C51E25E8;
	Wed,  6 Aug 2025 17:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nf3mgXL4"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47050634
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754502648; cv=none; b=ZP55arxEOqBRPENlzd+z0occy4wt6DbYIDyDcOdoLxmYpyDAyVi8rX9Hww1jpNW+eYRpzJe3uk4wGEyyBpslhkNV3t0l+iCwk0pFkL9jM8HT0U5WnYRLfHlZ5xdUD2HEXHkfXPWy3EPrI9yAE7kGfBCWqKMRA+rweQtqv1PaDVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754502648; c=relaxed/simple;
	bh=FcOXV+sYQfCKsVG5dl0oBKgrnzCX7QkMU+b/gJSwyuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tHhgfewA4v2q7UJ67XvsHWr/ye/w+jUN5z5Yeqdl162ERMO9/sdlnX7x5PRTYsI928PcF2bvd7zKrup7O2tAH9vH7CURPyeR9p2rwdR+Ww3foigvPkmdIV1lKs8oKwHKeDQnFENzt3EB3YI/LsBlMOtVVz8k5bPj41qNDPJpE54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nf3mgXL4; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso1114a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 10:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754502643; x=1755107443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6ZQ/5BaV6mQdffgVaaglAdkdHfzgWg/eTO8QxYBPeU=;
        b=nf3mgXL4BC3R+xIpTdxk7Q5RRGNZpAzNaKzAErQL5gFZtJLpXuUSa//Qqe3PK+0cU6
         TB/567x7Tt9izg2WCr04s74+/kiuaYEDgU+YItPCgI3yqAh+bZ7e05W++AMYIlxdUpYA
         pgIh52XmVp+XhjIlzX5p0HlWsKg5M3SmFpQ1EgHW2wMkrKO/f6MhQIfCB6Sr2JkfDKu7
         hiX1sw+gxoAI2hTZ0xYLmSZ4JtWSHv32eyb3U6dOvioOySjc8eWyX0obZQI5wkBGmNy0
         2eZYownhI7FP+ddrEvB4NHI8aIRU2voD9aRTHXREU5Z98xF6Wpodf4WHWkcET/1Yi+2q
         gR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754502643; x=1755107443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6ZQ/5BaV6mQdffgVaaglAdkdHfzgWg/eTO8QxYBPeU=;
        b=sJA9fXmfG8YrOkPVf27ADQZQcSxbAKNwgoTtSNAtH5hGB5f7Xp/lVGKltUCLuIjFKM
         R5YYfR32EUQBxPMfUGXoxxymt9jz2dNomGfKnZ9KmMHdmjbJOWmOhNXAR9LKQohJzk43
         X5clhNGMLAKvCEK+TKspCMV5XHL1AAYYqSTD6BwDy7M9UQQ6omgDsZDhbJzCYkQhD2at
         XLvdAz3wpZxC5v2wCADIZUntMzSAYm5Vd1z0AC6qcaQPqY67OjTzdFI+/2UySS4Yxv/q
         s0xF3W0+1fMUY+ZoldQroarjzb8bBH+91uYnXTPCISt+Wc8p8epTMa3ZXsPeKcXCmimI
         3F1A==
X-Forwarded-Encrypted: i=1; AJvYcCX9ir+JQKSRS7psjgnKERhgK21SDKdaKkHzC8czub79qukZ8ggm9PODR1Wr1zJZRlOY/Yl+6JgrhXGlC7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw76xFY0XtusINmlyepxXilbQkJ0zDDzmPvoiU8eMYAjR37lcMY
	tb44jeSEDNfgFqsfqc+0Pd6Ti2Tjg6EwHOx3D9ydwxlbvOcuiOfn4fp3G+2H1QNz74fdre83NXu
	tqIAXs7Wy8/CKnTRJEid/hPACYQIOktFiab5bL4N6
X-Gm-Gg: ASbGnctoH8NVMO6lZVmpji2VlxEjjfqwEcoWThavipIAYhc6CQC8nKHGR7KRJqfl3aN
	jIdKJkUuK1zZ+ISHxQ9aqGYRrJoOBn+sCigMRehIZNrNY9Ds9SdKMkivNocaabztkdstjL4W//K
	taHJggFz+wDGZb5ZGgnfWL1mDivDLBf+0B0rF65Dw+LrScRP6wR7NXGbkxmImYNmxGNhDYbhVEA
	jloqrDNfAR12OcBF3o=
X-Google-Smtp-Source: AGHT+IE+QDtUPARPU2wN4XerAfKdVLgsMbZ03V31aP2LxZYSJjBTKBDhaE0pgDwg/Hur4O5WYOACGm9GKfssEMe+4GQ=
X-Received: by 2002:a05:6402:4c1:b0:615:6167:4835 with SMTP id
 4fb4d7f45d1cf-61797ec0988mr91110a12.7.1754502642599; Wed, 06 Aug 2025
 10:50:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com> <20250729193647.3410634-8-marievic@google.com>
 <CABVgOSmBssmMz3qQi+TdEoaGQJNXaSVBrsO8RSW0MjLUUHPakg@mail.gmail.com>
In-Reply-To: <CABVgOSmBssmMz3qQi+TdEoaGQJNXaSVBrsO8RSW0MjLUUHPakg@mail.gmail.com>
From: Marie Zhussupova <marievic@google.com>
Date: Wed, 6 Aug 2025 13:50:31 -0400
X-Gm-Features: Ac12FXxZ0gzQXyQ3JCYs61KiK41rHInNvNCX1ufle-31wpGuIXR7lV23iXdDrBU
Message-ID: <CAAkQn5KnBZ7O6TkHL8UR0UaJ-v0P51TjtEwoRu7VWaPYd8oeSg@mail.gmail.com>
Subject: Re: [PATCH 7/9] kunit: Add example parameterized test with shared
 resources and direct static parameter array setup
To: David Gow <davidgow@google.com>
Cc: rmoar@google.com, shuah@kernel.org, brendan.higgins@linux.dev, 
	elver@google.com, dvyukov@google.com, lucas.demarchi@intel.com, 
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	kasan-dev@googlegroups.com, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 2, 2025 at 5:45=E2=80=AFAM David Gow <davidgow@google.com> wrot=
e:
>
> On Wed, 30 Jul 2025 at 03:37, Marie Zhussupova <marievic@google.com> wrot=
e:
> >
> > Add `example_params_test_with_init` to illustrate how to manage
> > shared resources across parameterized KUnit tests. This example
> > showcases the use of the new `param_init` function and its registration
> > to a test using the `KUNIT_CASE_PARAM_WITH_INIT` macro.
> >
> > Additionally, the test demonstrates:
> > - How to directly assign a static parameter array to a test via
> >   `kunit_register_params_array`.
> > - Leveraging the Resource API for test resource management.
> >
> > Signed-off-by: Marie Zhussupova <marievic@google.com>
> > ---
>
> Thanks for writing some examples! This is great, and makes the rest of
> the series much easier to understand.
>
> (It also reminds me how much I hate the verbose parts of the resource
> API, but it's definitely out of scope to refactor that here. :-))
>
> It does seem like this is a lot of effort to go through for one shared
> integer, though. In the real world, I'd suggest using
> kunit->parent->priv here. As an example, though, it's fine (though
> maybe using a named resource or even kunit_kzalloc() or similar would
> give a better example of how convenient this could be.
>
> It's also not entirely clear why we're using
> kunit_register_params_array() for a static array, when
> KUNIT_ARRAY_PARAM() exists. (This is clearly because the latter
> doesn't support init functions; and I see why we don't necessarily
> want to make the number of macros explode through adding
> KUNIT_ARRAY_PARAM_WITH_INIT() et al, but maybe we should note that in
> the commit description, either here or before.)
>
> Actual test looks fine, though:
>
> Reviewed-by: David Gow <davidgow@google.com>
>
> Cheers,
> -- David
>

Hello David,

I agree that using the Resource API for a single integer is a bit extra.
My idea behind this test was to demonstrate that the Resource API
could be used for managing shared resources and to have the
style of the existing example tests that do simple things with integers.

Using kunit_kzalloc() would be a great simplification. As for a named
resource, we don't have a function to allocate named resources yet
as would be needed here, but that sounds like a great future patch.

We can actually use the KUNIT_ARRAY_PARAM() macro with
KUNIT_CASE_PARAM_WITH_INIT(). We would just pass that created
`*_gen_params` function to KUNIT_CASE_PARAM_WITH_INIT()
instead of NULL. The reason I used kunit_register_params_array() with
the static array was to show that test users can pass a static array
this way, as well, and also to avoid making the test too long with the
dynamic array
creation. But I do like the consistency of using KUNIT_ARRAY_PARAM()
for static arrays and kunit_register_params_array() only for
dynamic ones.

Thank you,
-Marie

>
> >  lib/kunit/kunit-example-test.c | 112 +++++++++++++++++++++++++++++++++
> >  1 file changed, 112 insertions(+)
> >
> > diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-t=
est.c
> > index 3056d6bc705d..5bf559e243f6 100644
> > --- a/lib/kunit/kunit-example-test.c
> > +++ b/lib/kunit/kunit-example-test.c
> > @@ -277,6 +277,116 @@ static void example_slow_test(struct kunit *test)
> >         KUNIT_EXPECT_EQ(test, 1 + 1, 2);
> >  }
> >
> > +/*
> > + * This custom function allocates memory for the kunit_resource data f=
ield.
> > + * The function is passed to kunit_alloc_resource() and executed once
> > + * by the internal helper __kunit_add_resource().
> > + */
> > +static int example_resource_init(struct kunit_resource *res, void *con=
text)
> > +{
> > +       int *info =3D kmalloc(sizeof(*info), GFP_KERNEL);
> > +
> > +       if (!info)
> > +               return -ENOMEM;
> > +       *info =3D *(int *)context;
> > +       res->data =3D info;
> > +       return 0;
> > +}
> > +
> > +/*
> > + * This function deallocates memory for the 'kunit_resource' data fiel=
d.
> > + * The function is passed to kunit_alloc_resource() and automatically
> > + * executes within kunit_release_resource() when the resource's refere=
nce
> > + * count, via kunit_put_resource(), drops to zero. KUnit uses referenc=
e
> > + * counting to ensure that resources are not freed prematurely.
> > + */
> > +static void example_resource_free(struct kunit_resource *res)
> > +{
> > +       kfree(res->data);
> > +}
> > +
> > +/*
> > + * This match function is invoked by kunit_find_resource() to locate
> > + * a test resource based on defined criteria. The current example
> > + * uniquely identifies the resource by its free function; however,
> > + * alternative custom criteria can be implemented. Refer to
> > + * lib/kunit/platform.c and lib/kunit/static_stub.c for further exampl=
es.
> > + */
> > +static bool example_resource_alloc_match(struct kunit *test,
> > +                                        struct kunit_resource *res,
> > +                                        void *match_data)
> > +{
> > +       return res->data && res->free =3D=3D example_resource_free;
> > +}
> > +
> > +/*
> > + * This is an example of a function that provides a description for ea=
ch of the
> > + * parameters.
> > + */
> > +static void example_param_array_get_desc(const void *p, char *desc)
> > +{
> > +       const struct example_param *param =3D p;
> > +
> > +       snprintf(desc, KUNIT_PARAM_DESC_SIZE,
> > +                "example check if %d is less than or equal to 3", para=
m->value);
> > +}
> > +
> > +/*
> > + * Initializes the parent kunit struct for parameterized KUnit tests.
> > + * This function enables sharing resources across all parameterized
> > + * tests by adding them to the `parent` kunit test struct. It also sup=
ports
> > + * registering either static or dynamic arrays of test parameters.
> > + */
> > +static int example_param_init(struct kunit *test)
> > +{
> > +       int ctx =3D 3; /* Data to be stored. */
> > +       int arr_size =3D ARRAY_SIZE(example_params_array);
> > +
> > +       /*
> > +        * This allocates a struct kunit_resource, sets its data field =
to
> > +        * ctx, and adds it to the kunit struct's resources list. Note =
that
> > +        * this is test managed so we don't need to have a custom exit =
function
> > +        * to free it.
> > +        */
> > +       void *data =3D kunit_alloc_resource(test, example_resource_init=
, example_resource_free,
> > +                                         GFP_KERNEL, &ctx);
> > +
> > +       if (!data)
> > +               return -ENOMEM;
> > +       /* Pass the static param array information to the parent struct=
 kunit. */
> > +       kunit_register_params_array(test, example_params_array, arr_siz=
e,
> > +                                   example_param_array_get_desc);
> > +       return 0;
> > +}
> > +
> > +/*
> > + * This is an example of a parameterized test that uses shared resourc=
es
> > + * available from the struct kunit parent field of the kunit struct.
> > + */
> > +static void example_params_test_with_init(struct kunit *test)
> > +{
> > +       int threshold;
> > +       struct kunit_resource *res;
> > +       const struct example_param *param =3D test->param_value;
> > +
> > +       /* By design, param pointer will not be NULL. */
> > +       KUNIT_ASSERT_NOT_NULL(test, param);
> > +
> > +       /* Here we access the parent pointer of the test to find the sh=
ared resource. */
> > +       res =3D kunit_find_resource(test->parent, example_resource_allo=
c_match, NULL);
> > +
> > +       KUNIT_ASSERT_NOT_NULL(test, res);
> > +
> > +       /* Since the data field in kunit_resource is a void pointer we =
need to typecast it. */
> > +       threshold =3D *((int *)res->data);
> > +
> > +       /* Assert that the parameter is less than or equal to a certain=
 threshold. */
> > +       KUNIT_ASSERT_LE(test, param->value, threshold);
> > +
> > +       /* This decreases the reference count after calling kunit_find_=
resource(). */
> > +       kunit_put_resource(res);
> > +}
> > +
> >  /*
> >   * Here we make a list of all the test cases we want to add to the tes=
t suite
> >   * below.
> > @@ -296,6 +406,8 @@ static struct kunit_case example_test_cases[] =3D {
> >         KUNIT_CASE(example_static_stub_using_fn_ptr_test),
> >         KUNIT_CASE(example_priv_test),
> >         KUNIT_CASE_PARAM(example_params_test, example_gen_params),
> > +       KUNIT_CASE_PARAM_WITH_INIT(example_params_test_with_init, NULL,
> > +                                  example_param_init, NULL),
> >         KUNIT_CASE_SLOW(example_slow_test),
> >         {}
> >  };
> > --
> > 2.50.1.552.g942d659e1b-goog
> >

