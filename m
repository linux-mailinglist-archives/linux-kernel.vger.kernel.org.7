Return-Path: <linux-kernel+bounces-756652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7DDB1B745
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3F81735B6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E671279DB2;
	Tue,  5 Aug 2025 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2n697Lj9"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52063279784
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754407106; cv=none; b=TRTBKuYwAD8kPjAPDqfY/6HcUscd+Ec2TUAmbhOXRI5eATbir2i/yXgZHzXJVKhByGztEQkawiC29IlSPBMTiZgBTzfa0BELR0g+YvIe4kCE1iTZ7G6ll2GFcVePIRdUiHd71kTUfwpMcqS4W1PKeoKWtgp/iHrsIEB+gQzIpss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754407106; c=relaxed/simple;
	bh=1ECG87lC2qm1qN7vLX1WlO39n+HFFgTyOKI6P54s1S8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NT1r8BtpyuHA783QUB/A946d3Z4RoPiJCthjArPoAPAGk22Lh0qi9apbOSOtEFIOEOCTriroOzH6sikrDUyAMEtsrrrIi7chbVEhNcFNKLEOOaz04cfryR5lSQuntkaiWxteB7zGeau937XIgCY274wISTWYZBgo6o0u94SNPLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2n697Lj9; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b06d6cb45fso28515061cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 08:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754407104; x=1755011904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ei2suQoiKM6jZ+vrvxUS6sJAz8bgwy+vg3WdcqYInd4=;
        b=2n697Lj9RaVsbtlQOSax5ZJtzCFdCHqlhMBss7ZlvvdWSGJieP625J6Cl9TusJ432v
         7//OLS1C1qtEjPVxhhOt07EqEhaK/oULHTKbQpiveeTxAThrMW8A9oMC4sqmbn8F4uLr
         DaFWIvhzlDc5n9x41ygj4NHq1CAScsKyrOmkA0woDnrGi/+MlTOBN/+mIOK7k7VTgZnZ
         bFYJuvFslh7DMYWaWr6s0U0L4j/lADIKkn0E/DEa1AFPoGWdsNEfB11hCsEFczTiQqKc
         AQFDTYVfhsr9r7GR+Nq3s6UeDuu/2+UbH1U7RDl5zB6d+m+xYHLQEy7/V64zS1AEv4d+
         Zh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754407104; x=1755011904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ei2suQoiKM6jZ+vrvxUS6sJAz8bgwy+vg3WdcqYInd4=;
        b=Z7/LOkgg4iIt+m5V9IG/69QVgvWdPOG77L2nEj82Vo26PeJYGlecnoqwnwta0Sq3qu
         WTP/dWOJmCn82iG4IbDTFk+Q8UUYbvTDTKyz67x5LOqyahvaUgNBDnkJqTAqEXUQdVMV
         wFV9qhQwpdc1zjxHRN8ZxKv0smmPmff/7KoKCS5LKfxqO+Qk9qhGUNtfbDX628BZA64C
         1dTlHlaUiCSd1Q5ZOhJWtkOyLkuctMus4HzJMpwPFQtOI8NIY3kfkPxKEqlEKnlPNmFQ
         oAwo2Dz/Otd6FMDZ7lrCXdQ0RqOv2Qqa1d6IpNyRh/n+ceUhZulTCVvxgxwKC7z0sPV4
         u7yw==
X-Forwarded-Encrypted: i=1; AJvYcCWZLtc+6XGBSKaShT32c/GICwCDFatWcTTbtiw6+KwbDgIvfWivibDRCUb64r0WGdl0je/8QSAkS+1Hs8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6H+TPjeF7TO/2ghl2wrQ0PyBebC+CbZ2Wko3gmYm+tmTQA8/B
	dzWkuKou4s6ObYbu7+j0NG9cCFZMPGMggpCxSIf5QAW817rxt6iynH/U+KjnQYq7pN+/rZQ7Nx6
	42VyeKmAsGr9VRIpksQrtmCyzakw18Z6FIPQjFjuB
X-Gm-Gg: ASbGnctnjovyqyzIYTtLCgps1kvP7tCPLnROmpHFYl79xY9HOzvObobnX7QiSiNS2vf
	NBRBw1I0gITFNKX6IZsEuDcAM90rV4xfxdbeWQUTchb0CpsWm8TvIK+3xEbG9Q8T3MFszjBcHbK
	tLK6Qvk+1LPe08cHfbOsXz+55HdVToZcAxv/m4aVTEdD+TC5SpUunVkq+1qcunVew9TBd59WvUt
	RwStraJgpX3tSQSIjWvMTlQTzcbUV6lEgIDcBM2dw==
X-Google-Smtp-Source: AGHT+IGlWdT5T+vrtEukolYStRP1zGethFLAlqa7L7jsXqEu+52gbiouMhUNWLt2Xp/Xbd7hHUETokSfoCGI9lBDsso=
X-Received: by 2002:ad4:5c62:0:b0:707:6302:90aa with SMTP id
 6a1803df08f44-7093626d773mr195026586d6.27.1754407103617; Tue, 05 Aug 2025
 08:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com> <20250729193647.3410634-4-marievic@google.com>
In-Reply-To: <20250729193647.3410634-4-marievic@google.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 5 Aug 2025 11:18:12 -0400
X-Gm-Features: Ac12FXz9W5TjaYltj_nslVN8LL6euuV8WCMgJLzVdBjdaff9DG8lUm24r6Pqnn8
Message-ID: <CA+GJov5Faik_aBzDO6QY3Rj_ycq=A6ZqOsuP-m6G1n3jtpNCYg@mail.gmail.com>
Subject: Re: [PATCH 3/9] kunit: Pass additional context to generate_params for
 parameterized testing
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
> To enable more complex parameterized test scenarios,
> the `generate_params` function sometimes needs additional
> context beyond just the previously generated parameter.
> This patch modifies the `generate_params` function signature
> to include an extra `struct kunit *test` argument, giving
> users access to the parent kunit test's context when
> generating subsequent parameters.
>
> The `struct kunit *test` argument was added as the first parameter
> to the function signature as it aligns with the convention
> of other KUnit functions that accept `struct kunit *test` first.
> This also mirrors the "this" or "self" reference found
> in object-oriented programming languages.
>
> Signed-off-by: Marie Zhussupova <marievic@google.com>

Hello!

Extremely happy about this change. This will provide us much more
flexibility when defining test parameters. Thank you for this
implementation!

Reviewed-by: Rae Moar <rmoar@google.com>


-Rae

> ---
>  include/kunit/test.h | 9 ++++++---
>  lib/kunit/test.c     | 5 +++--
>  2 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index d8dac7efd745..4ba65dc35710 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -128,7 +128,8 @@ struct kunit_attributes {
>  struct kunit_case {
>         void (*run_case)(struct kunit *test);
>         const char *name;
> -       const void* (*generate_params)(const void *prev, char *desc);
> +       const void* (*generate_params)(struct kunit *test,
> +                                      const void *prev, char *desc);
>         struct kunit_attributes attr;
>
>         /*
> @@ -1701,7 +1702,8 @@ do {                                               =
                              \
>   * Define function @name_gen_params which uses @array to generate parame=
ters.
>   */
>  #define KUNIT_ARRAY_PARAM(name, array, get_desc)                        =
                       \
> -       static const void *name##_gen_params(const void *prev, char *desc=
)                      \
> +       static const void *name##_gen_params(struct kunit *test,         =
                       \
> +                                            const void *prev, char *desc=
)                      \
>         {                                                                =
                       \
>                 typeof((array)[0]) *__next =3D prev ? ((typeof(__next)) p=
rev) + 1 : (array);      \
>                 if (__next - (array) < ARRAY_SIZE((array))) {            =
                       \
> @@ -1722,7 +1724,8 @@ do {                                               =
                              \
>   * Define function @name_gen_params which uses @array to generate parame=
ters.
>   */
>  #define KUNIT_ARRAY_PARAM_DESC(name, array, desc_member)                =
                       \
> -       static const void *name##_gen_params(const void *prev, char *desc=
)                      \
> +       static const void *name##_gen_params(struct kunit *test,         =
                       \
> +                                            const void *prev, char *desc=
)                      \
>         {                                                                =
                       \
>                 typeof((array)[0]) *__next =3D prev ? ((typeof(__next)) p=
rev) + 1 : (array);      \
>                 if (__next - (array) < ARRAY_SIZE((array))) {            =
                       \
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index d80b5990d85d..f50ef82179c4 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -696,7 +696,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>                         /* Get initial param. */
>                         param_desc[0] =3D '\0';
>                         /* TODO: Make generate_params try-catch */
> -                       curr_param =3D test_case->generate_params(NULL, p=
aram_desc);
> +                       curr_param =3D test_case->generate_params(&test, =
NULL, param_desc);
>                         test_case->status =3D KUNIT_SKIPPED;
>                         kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT =
KUNIT_SUBTEST_INDENT
>                                   "KTAP version 1\n");
> @@ -727,7 +727,8 @@ int kunit_run_tests(struct kunit_suite *suite)
>
>                                 /* Get next param. */
>                                 param_desc[0] =3D '\0';
> -                               curr_param =3D test_case->generate_params=
(curr_param, param_desc);
> +                               curr_param =3D test_case->generate_params=
(&test, curr_param,
> +                                                                       p=
aram_desc);
>                         }
>                 }
>
> --
> 2.50.1.552.g942d659e1b-goog
>

