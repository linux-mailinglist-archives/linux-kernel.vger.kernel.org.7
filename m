Return-Path: <linux-kernel+bounces-818595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF497B593CA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43ABB3A8369
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBFE3043DC;
	Tue, 16 Sep 2025 10:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="C189w8pJ"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AEF2BE020
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018543; cv=none; b=KiY6nT9tMm37zg9/fp1vt8OmrNEQA5ef3UCWm/nU3yN6ouGOjkBguzioCBj4gShtC5MuSmp5eQMoCSeqsuMJGCyOKWDDWivxRqI+H3MI796Zw4zd2zYSgx1Icy10s2jwvMbeypXjrtkhSY7AviNVlVusnas6/bntFzMP4546mt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018543; c=relaxed/simple;
	bh=opvFEoK+yhT06tMtzvT5H7W0k423QZI/iRxryZ2dzM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KSF4fsdBWW/GKUW9ZKL0wE/sUDY4NhPT6xBW4kq4Bg/thFh+8RqIBxj0W6uN2rUV69WComLp2mSqyQo8xmFdoPwevnRmMF0OVEUyZMGCtZSuxbTS9EX4vAwV03gEoYARYLfn1dtcxUqOLXPn/F6sSlbAl3fk3k5++gL3b9IYzcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=C189w8pJ; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-827923a97e9so280880485a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758018541; x=1758623341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVtnxKhUzhBsXhVoc6XgCECsqL2+mal6aWmAQ944WSU=;
        b=C189w8pJa5ZTWDTEvj78eWKWh4DakDFeiVEpEHnQidSAH3byQTkIOVLxCs20sE7dik
         vvLHVVOe4B7TTOBrX77qavvGh4Q6LD8Vmv0GI06iouRK/0Ux28qbECagobtk+STy2PEs
         9K1nla5HiB6tyTGj6TbOnczLJdZbXKdldzFXbYBbuOb3xiHYAcpIY/FMzkruq/tV2MNL
         COM3ZZ5uAJYXP1aoEJxHZe4xmAaq5Vdg2HHiLJUdDlJSsM1JgyrmyWHZGvaibt1wPc/W
         Avz0RkC6bOdEaqXHm5VxdQn7k8VQ/OGIT6G5fo5cWPxKvQrm5FCc9MUj8VrZSS4KcAkj
         G8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758018541; x=1758623341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVtnxKhUzhBsXhVoc6XgCECsqL2+mal6aWmAQ944WSU=;
        b=eQd3Uo3TbjRtW+DGue9qVl65ty0Jpjl7DZn1Mw4362GjAOHFtSDv+sUnx0nejYeBQX
         ZMBOJq/kgYGcE3/3Frcl2mm+MoDgyavrc34bhfqDdCPUMucuq5/H8opgW0a55YqTuqUQ
         31W3UzDh6f/Qx1CsSWroT+VElCwC7go+fzj5TVessXRaj5v0Bf1Pi8rZtb+25dGltKBo
         1+R44Al9eME0bwNRE6DlwZWpU/JDZ8iD6KWRaYMeL0cv72qskx4/Ujy4a/IzJh5Wsxj/
         gATNrC0SzS+MXtlKbHX0rjzBPKPeE3Ryvkb8DbOV0lagyyzY/aXlqdtxKJ7DWyhoWxB2
         Unzg==
X-Forwarded-Encrypted: i=1; AJvYcCUp5qzjkNC6NpbxmyvThL+cgdlsIurU0DKb/g6FCTCMGyQk3dK2QXwzzSrP3lCZri6eADz2TyC50XiBznw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ394dGvHpqCcoxkAcsL0uQwHdeCFUSYGD1aDGEuMoTPRUk9Uc
	vkgQfOJAlBlgP4uUPq6ndeBOTRTlIRHmhEaBrtW185/biUBw9i8kwoLCedkU/kibTwH3538eYHL
	3cRQE5Q9wpTtRzd8OUPvZgJLjao4FYAor0s9uHbgsRQ==
X-Gm-Gg: ASbGncsVL/GyKgGNrC6ALEUcU4IovJPgGqogsYXmtvYptaULmG3VyLiM0Y8ssNzCu96
	/OrjILHdj7GwqWGrGo09I2YugffKNYTrSP31xV2Yp9d3elYrx2mGYcm0ytAHzTd/7E2qzp7hSxo
	5Xjkipy1Puw4J5QcXBsPRo75tbrbbw4v3MmRyIo7h+tK9KKLtzS1xIna3wWQy77hzrZWYBM0lnd
	P+hb+6XDTVIZ2IK4Lbn7BM=
X-Google-Smtp-Source: AGHT+IFxa/mHkO7l1jsYGXV11do5FbykxlkVIrkhepiY3N/e2eXzxLE7+I2R4McxIU568VBCzMXFRrIxTXk2KTMaFf8=
X-Received: by 2002:a05:620a:4107:b0:802:78a5:a86f with SMTP id
 af79cd13be357-824047c8dd0mr1779923485a.79.1758018540609; Tue, 16 Sep 2025
 03:29:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916090109.91132-1-ethan.w.s.graham@gmail.com> <20250916090109.91132-8-ethan.w.s.graham@gmail.com>
In-Reply-To: <20250916090109.91132-8-ethan.w.s.graham@gmail.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Tue, 16 Sep 2025 11:28:47 +0100
X-Gm-Features: AS18NWCkhNpkebAoSzpi6YfP7wdFTOupUdzVBrFWuQqh8FgNjyJdBm5a2YlrxX8
Message-ID: <CALrw=nE9jYhHZnix8RV9UHApOZaF7otRLPHn3cmvOPaqQLzrnw@mail.gmail.com>
Subject: Re: [PATCH v1 07/10] crypto: implement KFuzzTest targets for PKCS7
 and RSA parsing
To: Ethan Graham <ethan.w.s.graham@gmail.com>
Cc: ethangraham@google.com, glider@google.com, andreyknvl@gmail.com, 
	andy@kernel.org, brauner@kernel.org, brendan.higgins@linux.dev, 
	davem@davemloft.net, davidgow@google.com, dhowells@redhat.com, 
	dvyukov@google.com, elver@google.com, herbert@gondor.apana.org.au, 
	jack@suse.cz, jannh@google.com, johannes@sipsolutions.net, 
	kasan-dev@googlegroups.com, kees@kernel.org, kunit-dev@googlegroups.com, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lukas@wunner.de, rmoar@google.com, shuah@kernel.org, 
	tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 10:01=E2=80=AFAM Ethan Graham
<ethan.w.s.graham@gmail.com> wrote:
>
> From: Ethan Graham <ethangraham@google.com>
>
> Add KFuzzTest targets for pkcs7_parse_message, rsa_parse_pub_key, and
> rsa_parse_priv_key to serve as real-world examples of how the framework
> is used.
>
> These functions are ideal candidates for KFuzzTest as they perform
> complex parsing of user-controlled data but are not directly exposed at
> the syscall boundary. This makes them difficult to exercise with
> traditional fuzzing tools and showcases the primary strength of the
> KFuzzTest framework: providing an interface to fuzz internal functions.
>
> To validate the effectiveness of the framework on these new targets, we
> injected two artificial bugs and let syzkaller fuzz the targets in an
> attempt to catch them.
>
> The first of these was calling the asn1 decoder with an incorrect input
> from pkcs7_parse_message, like so:
>
> - ret =3D asn1_ber_decoder(&pkcs7_decoder, ctx, data, datalen);
> + ret =3D asn1_ber_decoder(&pkcs7_decoder, ctx, data, datalen + 1);
>
> The second was bug deeper inside of asn1_ber_decoder itself, like so:
>
> - for (len =3D 0; n > 0; n--)
> + for (len =3D 0; n >=3D 0; n--)
>
> syzkaller was able to trigger these bugs, and the associated KASAN
> slab-out-of-bounds reports, within seconds.
>
> The targets are defined within /lib/tests, alongside existing KUnit
> tests.
>
> Signed-off-by: Ethan Graham <ethangraham@google.com>

Reviewed-by: Ignat Korchagin <ignat@cloudflare.com>

> ---
> v3:
> - Change the fuzz target build to depend on CONFIG_KFUZZTEST=3Dy,
>   eliminating the need for a separate config option for each individual
>   file as suggested by Ignat Korchagin.
> - Remove KFUZZTEST_EXPECT_LE on the length of the `key` field inside of
>   the fuzz targets. A maximum length is now set inside of the core input
>   parsing logic.
> v2:
> - Move KFuzzTest targets outside of the source files into dedicated
>   _kfuzz.c files under /crypto/asymmetric_keys/tests/ as suggested by
>   Ignat Korchagin and Eric Biggers.
> ---
> ---
>  crypto/asymmetric_keys/Makefile               |  2 +
>  crypto/asymmetric_keys/tests/Makefile         |  2 +
>  crypto/asymmetric_keys/tests/pkcs7_kfuzz.c    | 22 +++++++++++
>  .../asymmetric_keys/tests/rsa_helper_kfuzz.c  | 38 +++++++++++++++++++
>  4 files changed, 64 insertions(+)
>  create mode 100644 crypto/asymmetric_keys/tests/Makefile
>  create mode 100644 crypto/asymmetric_keys/tests/pkcs7_kfuzz.c
>  create mode 100644 crypto/asymmetric_keys/tests/rsa_helper_kfuzz.c
>
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
> index 000000000000..4ffe0bbe9530
> --- /dev/null
> +++ b/crypto/asymmetric_keys/tests/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_KFUZZTEST) +=3D pkcs7_kfuzz.o
> +obj-$(CONFIG_KFUZZTEST) +=3D rsa_helper_kfuzz.o
> diff --git a/crypto/asymmetric_keys/tests/pkcs7_kfuzz.c b/crypto/asymmetr=
ic_keys/tests/pkcs7_kfuzz.c
> new file mode 100644
> index 000000000000..37e02ba517d8
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
> +       KFUZZTEST_ANNOTATE_ARRAY(pkcs7_parse_message_arg, data);
> +       KFUZZTEST_ANNOTATE_LEN(pkcs7_parse_message_arg, datalen, data);
> +
> +       pkcs7_parse_message(arg->data, arg->datalen);
> +}
> diff --git a/crypto/asymmetric_keys/tests/rsa_helper_kfuzz.c b/crypto/asy=
mmetric_keys/tests/rsa_helper_kfuzz.c
> new file mode 100644
> index 000000000000..bd29ed5e8c82
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
> +       KFUZZTEST_ANNOTATE_ARRAY(rsa_parse_pub_key_arg, key);
> +       KFUZZTEST_ANNOTATE_LEN(rsa_parse_pub_key_arg, key_len, key);
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
> +       KFUZZTEST_ANNOTATE_ARRAY(rsa_parse_priv_key_arg, key);
> +       KFUZZTEST_ANNOTATE_LEN(rsa_parse_priv_key_arg, key_len, key);
> +
> +       struct rsa_key out;
> +       rsa_parse_priv_key(&out, arg->key, arg->key_len);
> +}
> --
> 2.51.0.384.g4c02a37b29-goog
>

