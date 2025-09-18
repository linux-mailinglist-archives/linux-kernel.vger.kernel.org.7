Return-Path: <linux-kernel+bounces-822979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD167B8538D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34991C87A36
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98CE223324;
	Thu, 18 Sep 2025 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hAAO2o/R"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281A13176E6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204968; cv=none; b=RlHrgwbs1iJhE3LIrFNMz02ls7rNOCSPAOdTOKqRiLb3G1AVn5SSyipUE6Gvder2mXkNb8nkJ9uP2Y5gh6fhIGox0GrJD47goKOYKQvlkmifp+56MGY6A+LRouz8MpJ91PBClv4SrDvuU+6z6FpHxa1YavgucH1+TYCQ4DhBJOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204968; c=relaxed/simple;
	bh=EA7vYi5ofvk1cKNAjb9IvxaMHv14pBRTDKOPF0eO/9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkZ8WyBYVYc2yG+HjE/Nxyl9bLwlIAD4IYoQ6yE0ppKlbGc9lJpVUgVacrngBNSAYcPpa2k2U+cVzCDIXf//sy2wLmkcqJ9fy4NmPvZuqGkNp4OYT916eebMFJ+XVdugRD7b0z03Kc4hYyKt/AVSkOpdflxDfqkpKjbuaIWnLQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hAAO2o/R; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-78d73eef306so9142706d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758204965; x=1758809765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1m9V0QnucGw1fYjnWnkHTlkfdmFSylGoU4nkl6jTtY=;
        b=hAAO2o/RW29jJnKjlwzPfp+JBtsq3p3RoyZnPU1nP30Kkq+OTOsfka2SUcbzMnM9zY
         A32COQJK6I5uv/AblMAslEvn0MLPo4cAwVHEy431i37YIHgiKfsyD4OdM+rJrGES4hSc
         vMtvjJkAQnr93pkn2ZdO7LTPZokzW9zZjiYyu0b0wqxkoBjFUA77lh/IVCmof5J602T+
         aja8YF0inSgW8GCIIXHbctSMVffyglA15+gbrQGlSLJmo/LH9XV66GEd9c9qyqGB+hRf
         5a7U0sNTeqEjNgy8QkFRoAKLEnyevvgfAmOmeeCVUAfLIoGVDdMeqHJl1rdOGU3R5U9q
         uf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758204965; x=1758809765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1m9V0QnucGw1fYjnWnkHTlkfdmFSylGoU4nkl6jTtY=;
        b=mcHTxj1oPY0+aJutaxw8jvxtuEF9RwvJvOkaj5kqMXzrZj7EHEjB8yFz+JU0RhT/3S
         bzLut4We2oxLxJX1vtOM6XfqIh+FYF+jUAk6pGgZ95/fHl4tOR2wUk8w/ZcOeUtzqRXg
         knTonqNk+qZyA7b93kO7RNT4ABaeCZDpCm0l8lGFbagIoiuFzErBNnF8a0r9VtNEtPEA
         fHrgBr8UDlk2wMaA8my4uY+PQy0aB0iBUqXunZILPC2Gl5+tAIYo5sXYVK9Lz6siwkKo
         dU4SWorQoLciVMfUjB0SgyP7em3rN0fc54bH9DpQ3LCGeQ/R7ymB6Sjq4NXIgRWq9y7u
         74aA==
X-Forwarded-Encrypted: i=1; AJvYcCWk3L+DPy655AtNTV3Xq3EBya2exGCy5cZQ1oudoBPeSNregY3xxqqxNyBeG37dYmISIBM7PIRFpj5vZlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnwd7jgNRXPv9ZHKlpqwUHtxv+6gYjxbxYy2ysARE0OfVtffYS
	W1NChmfcIfFAIdNQPEeM8Bra5xmkOFFJIFSLa87WeY9KDoCl+4OJaWgY4SvKLH+w291ykkNp6Oz
	kkeKlrp6ixabNGo9cJWcAFwvhN6Vt1hJza7UMSz2p
X-Gm-Gg: ASbGncvj9bNYYTsdCb90VBo5szDyjQtS0wLr5SfJiJw7G71oWsfVIAXCUv4jlVBg9Iw
	QiOZ0UU+ZW7mN/auZLj3i9z1LC17gGiQGngY+G4h21R+E9NtFiE0CB+25B81M1XqBa/OLpcVg11
	knTBbJjrmrsqTsmb+frErmVAPb5LuXSv/V2ih0bx8u0Gv1ModxldbJDekpfl4+9cSfFsC42FBL0
	lMCMTbdWrAD1OVY/oYAkr6o9Fvc51xf58zxu0U6ocuhpFewK+KOerQc82iPgDA=
X-Google-Smtp-Source: AGHT+IFBpnDsj/3XitirZWPzOjid3pk9f5ycO+u5s3pMsQEUT+8NOpONrRLGkmiWyeP3kqXiHfhufSRzIIkcKBIaTRI=
X-Received: by 2002:a05:6214:2aa5:b0:782:1086:f659 with SMTP id
 6a1803df08f44-78eccb0cae7mr65869736d6.26.1758204964157; Thu, 18 Sep 2025
 07:16:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916090109.91132-1-ethan.w.s.graham@gmail.com> <20250916090109.91132-8-ethan.w.s.graham@gmail.com>
In-Reply-To: <20250916090109.91132-8-ethan.w.s.graham@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 18 Sep 2025 16:15:27 +0200
X-Gm-Features: AS18NWDFBwLJ1l73cBf4HqMXnx0YeCt1p-LK845oN4Qc3Ee7lXGT_Tt4s1Okcjk
Message-ID: <CAG_fn=Xkig71cn1xCUP1t=OLAbk+YYLsec0HhciROuiTD6AELg@mail.gmail.com>
Subject: Re: [PATCH v1 07/10] crypto: implement KFuzzTest targets for PKCS7
 and RSA parsing
To: Ethan Graham <ethan.w.s.graham@gmail.com>, ignat@cloudflare.com
Cc: ethangraham@google.com, andreyknvl@gmail.com, andy@kernel.org, 
	brauner@kernel.org, brendan.higgins@linux.dev, davem@davemloft.net, 
	davidgow@google.com, dhowells@redhat.com, dvyukov@google.com, 
	elver@google.com, herbert@gondor.apana.org.au, jack@suse.cz, jannh@google.com, 
	johannes@sipsolutions.net, kasan-dev@googlegroups.com, kees@kernel.org, 
	kunit-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lukas@wunner.de, 
	rmoar@google.com, shuah@kernel.org, tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 11:01=E2=80=AFAM Ethan Graham
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
>
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

As far as I understand, this function creates an allocation, so the
fuzz test will need to free it using pkcs7_free_message() to avoid
leaking memory.
What do you think, Ignat?


> +       struct rsa_key out;
> +       rsa_parse_pub_key(&out, arg->key, arg->key_len);
> +}

Do we need to deallocate anything here?

