Return-Path: <linux-kernel+bounces-798096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF424B41970
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF141896695
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A102C1591;
	Wed,  3 Sep 2025 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="brUcCgje"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A31257851
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889917; cv=none; b=miftqF8G0vwq+qCr5+/8RTC3WO9boz5LZZ7AWMjLngLG7i75tYYVku5kzeg34GxkNY6nEYifKf4vQIBJe25aObIkv84ZAp4CI9AUpLIf8anGxtdRPPJ40OH+P3u7m1VHdAxYCUdoJE14MqSV00IY0nhNSzRCXaW1xN/UwImTqdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889917; c=relaxed/simple;
	bh=cWss5KSr5baYEsadUndMGJzvEYEA64szR0XEJUk+TrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sb/IlLRREKgJlavzIMYBoMcI4MRzxUTmBi51SyuZNXgAfFJIWt31VkyKuADj4g8jxDBto5oPc5wXbtlPGURUNqWH/DiUElHi/2cC54kjKuGPH8I6IhlcA2t0KS3HWhzIg4Q2TxEY47/LQZToDt65aRoGLa2MhTLCjAXpFPVcN1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=brUcCgje; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-33808d9e10bso1971021fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 01:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1756889914; x=1757494714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7DZbr5IPE7KPqwr8CmuJ7G0mqK+7ozrUki3YjXg8lg=;
        b=brUcCgje0/7vA+VOeg+MNxlx4i3uSr2kCH5vMSBGVG9SKTU8NUhEMt8WJDq5Iti3dt
         b3aWlsTkot282PQRdX1I0/tnvLQJNrl3671ijUUDlyevAeaZ3i4vTukHB99sR4azVqdG
         9AL0+aH1JICxBz2SuZrii2BHwnClmt/A5lJhB3oU3LAWVQYQXl2erj9J96VetAICUJBe
         VzrHjV21uwfuDGDFoj33Rm4BkKksyuQGSVt3gR1TMxfKnA1Ym8N0QgcZbhl0HYPT87Fu
         uCzuCOrrEPrTwB4KQ3ApkY8KvxYMWLPm5Ax1XnaNrdSXKRXEXdaCpTYZnRLTx6HNJRCi
         CMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756889914; x=1757494714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7DZbr5IPE7KPqwr8CmuJ7G0mqK+7ozrUki3YjXg8lg=;
        b=mXYw5PUm6+3mcHAXxetTuG6WTd1qyNkmXHrGOp7tJRfeC10shxxTNFYdKp7A0iU4QC
         TiblXVkDiduZ2KiI/dmxEIXwR1XPB0ViJTZQpfANSAWEUHOZ/4AwJqA1DWyzGLVIkqj9
         /AKNwgn1JQ3DNx4OcUyqgKXlMMKVzUQY0Y28V4AFkSKpk26wka1gTi7Yf37jG2EtaZJn
         YwLCk126SRHNH6sI38voiEqyy70bE4aX8IWeGkAxkPo30U9P09Cjcr1lUg3r62z93GJ5
         bxK+LzJK4TPQRfi3Y5gnJoqhnp/eRHo+SnwlAnZw8igZpAwwk4muP6wVfm+JIlIabp9Y
         IxrA==
X-Forwarded-Encrypted: i=1; AJvYcCWVIBOoVojwyYOzIeMcbqaq7qS94qEa7Q/iWQgPjQ8X90Nn+EkS96HAKKM82e3L8NBkn4p5oDWD5hNtzZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI9rMUNN+hX0WxqtZL8Aa41eynSsTv4Sb4pnwPWJkw0HdBDOM6
	rkueM1XDDj+zHgMHpa6wvm3OZgw6A3nZFImIjRmVoWXF0vfRa3d8ILW6VvsOEl2L1to93s4v9Vx
	g0huHINR6vHHbCpcn4CPe66biag488ND3GkshapDxmA==
X-Gm-Gg: ASbGnctXSBQspr5oRxZepjhzw+ZvP1JQchS6Q319HTWySNLYMC4dOQX1xzvyBy3sQWu
	5Kwcupe+zbfwAEb9ws19QpXoVq/SAcicgJSBCjKHB8VzCBi6z+8I5IlYORIiXxXS2/VgPClguXq
	RiPL/8uY6GPcUkfTCbbCKjO+I2ByMYCVjpXtKBjk//u99SZu5lgZUaUwQ787M0lBLGfucUaA5tm
	UWaCqeUp9R0IktGOKyMJ22dMUJzdEUTvADH
X-Google-Smtp-Source: AGHT+IFWZ1KRHLT58ws0GLUyYgsxqndwv00B/CVuSizWtD5TQIXhe4G2nzXHLgGunu2r8TYG1KYxHIJpaIS7aNOjkHw=
X-Received: by 2002:a05:651c:410c:b0:337:f40b:ceff with SMTP id
 38308e7fff4ca-337f40bd6b0mr10888081fa.0.1756889913537; Wed, 03 Sep 2025
 01:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901164212.460229-1-ethan.w.s.graham@gmail.com> <20250901164212.460229-8-ethan.w.s.graham@gmail.com>
In-Reply-To: <20250901164212.460229-8-ethan.w.s.graham@gmail.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Wed, 3 Sep 2025 09:58:22 +0100
X-Gm-Features: Ac12FXzBn0vfVPWXT-oRg7YFxfn5ZjyJ_zA4MQI9Ke7h9u6mEjL9U6otTFUfOcM
Message-ID: <CALrw=nGkk01xXG7S68FggsWQXygTXnXGz8AvseQuRE9K-OE0uA@mail.gmail.com>
Subject: Re: [PATCH v2 RFC 7/7] crypto: implement KFuzzTest targets for PKCS7
 and RSA parsing
To: Ethan Graham <ethan.w.s.graham@gmail.com>
Cc: ethangraham@google.com, glider@google.com, andreyknvl@gmail.com, 
	brendan.higgins@linux.dev, davidgow@google.com, dvyukov@google.com, 
	jannh@google.com, elver@google.com, rmoar@google.com, shuah@kernel.org, 
	tarasmadan@google.com, kasan-dev@googlegroups.com, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, dhowells@redhat.com, 
	lukas@wunner.de, herbert@gondor.apana.org.au, davem@davemloft.net, 
	linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 5:43=E2=80=AFPM Ethan Graham <ethan.w.s.graham@gmail=
.com> wrote:
>
> From: Ethan Graham <ethangraham@google.com>
>
> Add KFuzzTest targets for pkcs7_parse_message, rsa_parse_pub_key, and
> rsa_parse_priv_key to serve as real-world examples of how the framework i=
s used.
>
> These functions are ideal candidates for KFuzzTest as they perform comple=
x
> parsing of user-controlled data but are not directly exposed at the sysca=
ll
> boundary. This makes them difficult to exercise with traditional fuzzing =
tools
> and showcases the primary strength of the KFuzzTest framework: providing =
an
> interface to fuzz internal functions.

nit: can I ask for another real example? AFAIK this subsystem is
rarely used (at least directly by users). However, one user-controlled
widely used parser terrifies me: load_script() function from
binfmt_script.c, which parses the shebang line for scripts. I would
really like to see what this framework can do to fuzz that.

> The targets are defined within /lib/tests, alongside existing KUnit
> tests.
>
> Signed-off-by: Ethan Graham <ethangraham@google.com>
>
> ---
> v2:
> - Move KFuzzTest targets outside of the source files into dedicated
>   _kfuzz.c files under /crypto/asymmetric_keys/tests/ as suggested by
>   Ignat Korchagin and Eric Biggers.
> ---
> ---
>  crypto/asymmetric_keys/Kconfig                | 15 ++++++++
>  crypto/asymmetric_keys/Makefile               |  2 +
>  crypto/asymmetric_keys/tests/Makefile         |  2 +
>  crypto/asymmetric_keys/tests/pkcs7_kfuzz.c    | 22 +++++++++++
>  .../asymmetric_keys/tests/rsa_helper_kfuzz.c  | 38 +++++++++++++++++++
>  5 files changed, 79 insertions(+)
>  create mode 100644 crypto/asymmetric_keys/tests/Makefile
>  create mode 100644 crypto/asymmetric_keys/tests/pkcs7_kfuzz.c
>  create mode 100644 crypto/asymmetric_keys/tests/rsa_helper_kfuzz.c
>
> diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kcon=
fig
> index e1345b8f39f1..7a4c5eb18624 100644
> --- a/crypto/asymmetric_keys/Kconfig
> +++ b/crypto/asymmetric_keys/Kconfig
> @@ -104,3 +104,18 @@ config FIPS_SIGNATURE_SELFTEST_ECDSA
>         depends on CRYPTO_ECDSA=3Dy || CRYPTO_ECDSA=3DFIPS_SIGNATURE_SELF=
TEST
>
>  endif # ASYMMETRIC_KEY_TYPE
> +
> +config PKCS7_MESSAGE_PARSER_KFUZZ

I'm a bit worried about the scalability of defining one (visible)
config option per fuzz file/module. Is there a use-case, where a user
would want to enable some targets, but not the others? Can it be
unconditionally enabled and compiled only if CONFIG_KFUZZTEST=3Dy?

> +       bool "Build fuzz target for PKCS#7 parser"
> +       depends on KFUZZTEST
> +       depends on PKCS7_MESSAGE_PARSER
> +       default y
> +       help
> +         Builds the KFuzzTest targets for PKCS#7.
> +
> +config RSA_HELPER_KFUZZ
> +       bool "Build fuzz targets for RSA helpers"
> +       depends on KFUZZTEST
> +       default y
> +       help
> +         Builds the KFuzzTest targets for RSA helper functions.
> diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Mak=
efile
> index bc65d3b98dcb..77b825aee6b2 100644
> --- a/crypto/asymmetric_keys/Makefile
> +++ b/crypto/asymmetric_keys/Makefile
> @@ -67,6 +67,8 @@ obj-$(CONFIG_PKCS7_TEST_KEY) +=3D pkcs7_test_key.o
>  pkcs7_test_key-y :=3D \
>         pkcs7_key_type.o
>
> +obj-y +=3D tests/
> +
>  #
>  # Signed PE binary-wrapped key handling
>  #
> diff --git a/crypto/asymmetric_keys/tests/Makefile b/crypto/asymmetric_ke=
ys/tests/Makefile
> new file mode 100644
> index 000000000000..42a779c9042a
> --- /dev/null
> +++ b/crypto/asymmetric_keys/tests/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_PKCS7_MESSAGE_PARSER_KFUZZ) +=3D pkcs7_kfuzz.o
> +obj-$(CONFIG_RSA_HELPER_KFUZZ) +=3D rsa_helper_kfuzz.o
> diff --git a/crypto/asymmetric_keys/tests/pkcs7_kfuzz.c b/crypto/asymmetr=
ic_keys/tests/pkcs7_kfuzz.c
> new file mode 100644
> index 000000000000..84d0b0d8d0eb
> --- /dev/null
> +++ b/crypto/asymmetric_keys/tests/pkcs7_kfuzz.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * PKCS#7 parser KFuzzTest target
> + *
> + * Copyright 2025 Google LLC
> + */
> +#include <crypto/pkcs7.h>
> +#include <linux/kfuzztest.h>
> +
> +struct pkcs7_parse_message_arg {
> +       const void *data;
> +       size_t datalen;
> +};
> +
> +FUZZ_TEST(test_pkcs7_parse_message, struct pkcs7_parse_message_arg)
> +{
> +       KFUZZTEST_EXPECT_NOT_NULL(pkcs7_parse_message_arg, data);
> +       KFUZZTEST_ANNOTATE_LEN(pkcs7_parse_message_arg, datalen, data);
> +       KFUZZTEST_EXPECT_LE(pkcs7_parse_message_arg, datalen, 16 * PAGE_S=
IZE);
> +
> +       pkcs7_parse_message(arg->data, arg->datalen);
> +}
> diff --git a/crypto/asymmetric_keys/tests/rsa_helper_kfuzz.c b/crypto/asy=
mmetric_keys/tests/rsa_helper_kfuzz.c
> new file mode 100644
> index 000000000000..5877e54cb75a
> --- /dev/null
> +++ b/crypto/asymmetric_keys/tests/rsa_helper_kfuzz.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * RSA key extract helper KFuzzTest targets
> + *
> + * Copyright 2025 Google LLC
> + */
> +#include <linux/kfuzztest.h>
> +#include <crypto/internal/rsa.h>
> +
> +struct rsa_parse_pub_key_arg {
> +       const void *key;
> +       size_t key_len;
> +};
> +
> +FUZZ_TEST(test_rsa_parse_pub_key, struct rsa_parse_pub_key_arg)
> +{
> +       KFUZZTEST_EXPECT_NOT_NULL(rsa_parse_pub_key_arg, key);
> +       KFUZZTEST_ANNOTATE_LEN(rsa_parse_pub_key_arg, key_len, key);
> +       KFUZZTEST_EXPECT_LE(rsa_parse_pub_key_arg, key_len, 16 * PAGE_SIZ=
E);
> +
> +       struct rsa_key out;
> +       rsa_parse_pub_key(&out, arg->key, arg->key_len);
> +}
> +
> +struct rsa_parse_priv_key_arg {
> +       const void *key;
> +       size_t key_len;
> +};
> +
> +FUZZ_TEST(test_rsa_parse_priv_key, struct rsa_parse_priv_key_arg)
> +{
> +       KFUZZTEST_EXPECT_NOT_NULL(rsa_parse_priv_key_arg, key);
> +       KFUZZTEST_ANNOTATE_LEN(rsa_parse_priv_key_arg, key_len, key);
> +       KFUZZTEST_EXPECT_LE(rsa_parse_priv_key_arg, key_len, 16 * PAGE_SI=
ZE);
> +
> +       struct rsa_key out;
> +       rsa_parse_priv_key(&out, arg->key, arg->key_len);
> +}
> --
> 2.51.0.318.gd7df087d1a-goog
>

Ignat

