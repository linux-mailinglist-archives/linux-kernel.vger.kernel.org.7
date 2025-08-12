Return-Path: <linux-kernel+bounces-765640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D87B23BBD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 00:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29841583062
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 22:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6466B28850F;
	Tue, 12 Aug 2025 22:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DbNUX/s2"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E808721CC5B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 22:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755037339; cv=none; b=H5+k9GJEoolq8YDcZ1t2xfVBUzhJ0wMMJksRQl64p11BmK7fwTYnowjNSsf8y4HZIW35AXJ7i5++RPWX4qBZQceZT1PJGNLAuMD7i/rLc90SaTPLoj2u5DtIwEadQexJvNHS3nKGSXMnQllYqPPaIOGltjmJKKzBc7N++L1atqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755037339; c=relaxed/simple;
	bh=DZVGpH2NP2m4OUwS9OYvQYy3pRrUU5yNAOtq2lI0pRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFnbCtaNK/+2MVEe54/bodv6NT/q+XgrAfWTvR8jCTT/8o9hcAsaOzn1DJeGMTnk/j5sHwSEb4vaP5TejeuFbvyhwBPtKM5RLsy72p+EoaS3hYlXuBYFYbDDZrdGQKamm2BUhm/CSDB0F6gHF/AFE8n3sz/7wrPCkWa4js+eDPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DbNUX/s2; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-70748a0e13dso43360096d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 15:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755037337; x=1755642137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWuryeMFKkS3RAr2vCbtx7LOWzlUOf1ahWxEl9iGYmQ=;
        b=DbNUX/s2A36UxeYdfARtZ2fjw4x2aI+lqZfFrEZjEaJRAeBDTR0vgDROHHBCdtPNp9
         4C603Q9q7j/306/9NqJgAcRyItli/scXaNOl09xcL8UYTS1/L/vDKCbrupHzpDXBcxu3
         +38h1Vu/EdFbvdNbuYcQGgTDUPHwLL0ZkjPRhknxsV+z2rv4lgCrK1OIkpxg5jbZyLB/
         aZfwWs0DkqwjKtR12TwsejWQThTdgH7KKMAy1C1FoXY1dNSabSz3vQ97g18GKH6AnUbd
         hmdIKb+fbNk1nSXx+Ro34Z8It996KR4lZt7ETevzkK3++PgXyJxe+C4NNCtxtu+qZ7v4
         0wjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755037337; x=1755642137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWuryeMFKkS3RAr2vCbtx7LOWzlUOf1ahWxEl9iGYmQ=;
        b=SdvYtIBzs9kdz9cJOX/iNyxFY1UBXY/B0achjl99y5g+tOkRqY++TWLdKQO3nrlc3U
         jw8QSxGfvo0n+McBk9qDpnMx884HtMNOmicwleMW5Jv95K1E/HTXecw+jHnFBxMTFJ8i
         klTUSLBjZxBa2cBPKmipsmbKSYdJT0kObmxR/a9M8xqceuZEuS/LI0dnRugCm10HSccx
         XvGpRWp1At7eEAS/RokC/JRWZUiMn11weBkX8pvGSmO+V+G79pTMajr/M53qHsZapvE1
         QX9npRDeWFySHS+o5jGT0Vs1fkih34ULf/dZS98ASIn5aTyJ2wz/zoTBA+E8YeyJa3o0
         wnlA==
X-Forwarded-Encrypted: i=1; AJvYcCWA1KQ+bnrhDGpVP3TmA4w+QvbnR2VA+gTJ32SyP5DGPheOt5ovLDuZlF4aEnJ1MP62LGQlD3GZER7SSrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGrBj8eaj5npHHZxzfKeK9Uc4UfWaBuJMLwZJODS2djpQt+Wyj
	ocQEzTgKMrM541SGHq6Du635kzmzHLTyhmILgZukIHgjE6lXP77OQnz2+Pcty6CLqWlqE1160hj
	ZSLZ4Znuq7eSGYuIctf1mYzaQ2P/bH63188moNmkb
X-Gm-Gg: ASbGncsPiM/RjJSjpQXWnL85pA4uId0tRzSt3wT37cFzdLFYIlyOruX0VoE8LAn93ac
	QlJlXGPw3r0xF1rImGLRPIEg2mFRz6SKvT2T03vp+omLY6rxfPmPmKOiu9rYSYBStZFulsLhnQf
	zk2Mq6zVY1g5EvR34rHqGsMnRTFVd1Iy1jXAIAwTFwgYb6LYwdxudUyysHw3aO50pRFgxfybg3p
	DGcLZ3hSnWiDLAoLRAhMEKS2E0=
X-Google-Smtp-Source: AGHT+IEadRB7taAvJL3meXl06djQ3Xt2tF79cuy40DLQCj2PV7nyTVommhLIfxsMSiSB57BjHwmxI3MbCeBYuqIhz/o=
X-Received: by 2002:a05:6214:dc6:b0:704:7df6:44b4 with SMTP id
 6a1803df08f44-709e893bab1mr14144146d6.23.1755037336426; Tue, 12 Aug 2025
 15:22:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811221739.2694336-1-marievic@google.com> <20250811221739.2694336-2-marievic@google.com>
In-Reply-To: <20250811221739.2694336-2-marievic@google.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 12 Aug 2025 18:22:05 -0400
X-Gm-Features: Ac12FXy4odiVUbmTVSv_FQj3XmTzKCP2JeRGz1wZpwmC4BzXnA3qMhak1o8tSGs
Message-ID: <CA+GJov6aVg70yjXF3=3teg26AKhcOwLEOgGT8by61nMJvB15jg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] kunit: Add parent kunit for parameterized test context
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

On Mon, Aug 11, 2025 at 6:17=E2=80=AFPM Marie Zhussupova <marievic@google.c=
om> wrote:
>
> Currently, KUnit parameterized tests lack a mechanism
> to share resources across parameter runs because the
> same `struct kunit` instance is cleaned up and
> reused for each run.
>
> This patch introduces parameterized test context,
> enabling test users to share resources between
> parameter runs. It also allows setting up resources
> that need to be available for all parameter runs only once,
> which is helpful in cases where setup is expensive.
>
> To establish a parameterized test context, this
> patch adds a parent pointer field to `struct kunit`.
> This allows resources added to the parent `struct kunit`
> to be shared and accessible across all parameter runs.
>
> In kunit_run_tests(), the default `struct kunit`
> created is now designated to act as the parameterized
> test context whenever a test is parameterized.
>
> Subsequently, a new `struct kunit` is made
> for each parameter run, and its parent pointer is
> set to the `struct kunit` that holds the
> parameterized test context.
>
> Signed-off-by: Marie Zhussupova <marievic@google.com>
> ---
>
> Changes in v2:
>
> - Descriptions of the parent pointer in `struct kunit`
>   were changed to be more general, as it could be
>   used to share resources not only between parameter
>   runs but also between test cases in the future.
> - When printing parameter descriptions using
>   test.param_index was changed to param_test.param_index.
> - kunit_cleanup(&test) in kunit_run_tests() was moved
>   inside the parameterized test check.
> - The comments and the commit message were changed to
>   reflect the parameterized testing terminology. See
>   the patch series cover letter change log for the
>   definitions.

Hello!

Thanks for making these changes! I really like the change to the new
terminology for parameterized tests, as well as the description change
for "parent".

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!

-Rae


>
> ---
>  include/kunit/test.h |  8 ++++++--
>  lib/kunit/test.c     | 34 ++++++++++++++++++++--------------
>  2 files changed, 26 insertions(+), 16 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 39c768f87dc9..b47b9a3102f3 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -268,14 +268,18 @@ struct kunit_suite_set {
>   *
>   * @priv: for user to store arbitrary data. Commonly used to pass data
>   *       created in the init function (see &struct kunit_suite).
> + * @parent: reference to the parent context of type struct kunit that ca=
n
> + *         be used for storing shared resources.
>   *
>   * Used to store information about the current context under which the t=
est
>   * is running. Most of this data is private and should only be accessed
> - * indirectly via public functions; the one exception is @priv which can=
 be
> - * used by the test writer to store arbitrary data.
> + * indirectly via public functions; the two exceptions are @priv and @pa=
rent
> + * which can be used by the test writer to store arbitrary data and acce=
ss the
> + * parent context, respectively.
>   */
>  struct kunit {
>         void *priv;
> +       struct kunit *parent;
>
>         /* private: internal use only. */
>         const char *name; /* Read only after initialization! */
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index f3c6b11f12b8..14a8bd846939 100644
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
> @@ -679,37 +680,42 @@ int kunit_run_tests(struct kunit_suite *suite)
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
> -                                                "param-%d", test.param_i=
ndex);
> +                                                "param-%d", param_test.p=
aram_index);
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
> +                       /* TODO: Put this kunit_cleanup into a try-catch.=
 */
> +                       kunit_cleanup(&test);
>                 }
>
>                 kunit_print_attr((void *)test_case, true, KUNIT_LEVEL_CAS=
E);
> --
> 2.51.0.rc0.205.g4a044479a3-goog
>

