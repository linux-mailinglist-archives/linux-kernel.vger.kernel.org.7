Return-Path: <linux-kernel+bounces-767324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 095F3B252DC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD901C83488
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678492C0F76;
	Wed, 13 Aug 2025 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zWcWqtKW"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416542877F3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755108870; cv=none; b=M5qfNmjQs4SRcs5kM3W9POMFlpEgBiaWUg3KE03A5e/TauRt1tmwmlqS7a78RFOoqQ9NUOCfOTzyOmsKtEQFrUjPsc/8CJRuEQaK5EN6SSnQtQQWsUpOACoUVzcCoepKKcX2xdwTMJ4uz3A1sQQbCJP6j9OGH6x4ywE62yBaSpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755108870; c=relaxed/simple;
	bh=Jb837tfTI/QW5Qv8dIXjBfCO4z5K+wPACGYvRyftbkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jat7n7fyu3kXJXkewyR8VF3kq64UrbuxgBz87igHXJBu5UfBU9EehmUZgmt0UcWwGIRbM6JhBVRhFRhOpAQkJeRA6mnsSAGYHeKjLAuHd0Z2W58AALI9Iym6u58F48Aarl3qlM8Ve+YPlUHl9FtS1YGzWxK0GnfT2LuB9Vv3kq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zWcWqtKW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-244582a738dso219825ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 11:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755108868; x=1755713668; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4hxBfzmvH2TsE+jx0zUQqB7m43IVHQfBxYfENPa1oII=;
        b=zWcWqtKW9VL6z3iL6HdlXDTxvx8eVAcieAEwIRF8chK8Y+H5ohQ2HopPnfjmajdbb7
         Omlse2D5FBp/sGuIPt9w/yNuriPWcH3KXtfCD1l1zUiPMxLAaLwIamCm9rSSuT0HG3kR
         ZqNG1V8nD+d/IgTedgz0uWufx0Hy5FzPqJSQnTfGPKm0E7cjmGuDlyMmMdpaKi49d7Oq
         659FHnwqvmyBajxJ7jUFTuHrlGM5IsOakGnvqUj+soqdf+gGVnSU3ddvU3wLcCibThAK
         gTJ2WexlammoNPstTNaYRNaQLik3Rh/TQgnRsZVOR+GzlU3ddVjAYZFgF5P+OKHIySCo
         u5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755108868; x=1755713668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4hxBfzmvH2TsE+jx0zUQqB7m43IVHQfBxYfENPa1oII=;
        b=obrK/9yEsT08X3gfLV2G2YAScVNkAMbgKR/NL6MTAq5lQOreJkRW+bioyaQjlThrVJ
         c9yoI+dduu8EeW4ZwaUSYdhjXgr3+VJCsLSJJnkFVE1xy4/FnbSYxqOSkG7vjg4EakyN
         n/IaYs7K/Lana9sjPG61aXU+6U6dkJ0RxMbIVNPkMTwacZnOSQezzl1qUGBh5Tp8Iz7n
         LhV3A5bbsHMs39Fs0rjwk0hfqeyLZHDkSNRjm1NB569b4K+j6rv/GJ57Pw1bFiDik5Fh
         nLHOtDmU713MmTPAGN1rtDCzTjNMKsmRbcH9xNDoxwtf0IGNRqJoIYW/eBVBvqbGtEjE
         rmcA==
X-Forwarded-Encrypted: i=1; AJvYcCUXRDzxdAePO5psb4rojg3g75ZzxoE6FniKoXaLIMXVAqgI0sPVVKFRryDYyJqhz88g74p/n90m8ySSyGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwACLxdIdXL35vIGl9O+Cn9wWEWvgA4zekuxPZ6cufch1oZVxl1
	q+KNdN0ITmU8UiMAuvdyQ+w9XAsZozJ3k9IQLIPO3HcGg2DT8rY8VXS09sC8TvHuP9LW/Pt8b4v
	cCptZ0WE/HUI6X/H7w3T1a6e1mBSFR/wCBnkF27Rd
X-Gm-Gg: ASbGncuG/OO4uiFf1CYpkOM0eJ64D2TJCi7EAQ7mRbpBbXXwLyA55dQau9kLAzMZ54h
	Td6iZ98uNTw2w/i9fSJ0JGQsQKhKr03uVfdf7rYUljyuMjDW8ltq9TSLFINtEJ5LjpBfsQOXmRv
	DZQD4+3WhKUoc+cfs2FQ3N78Mzjn7uqy2D//QPu+SFwuIE6O0sviOKqr4yuXrcv5ah4ZIDINqGP
	sM0b+0kerfxFa4nbImWcLBza6tZxqc1cA5oE3ifAqDy7XGz
X-Google-Smtp-Source: AGHT+IHotfho3h1ZZecOKGuq1D2CciZoVsCtf5moBH0RJz5U14Jr0GnJ8FzYfeu03dCe85qFQ/eJAyGnggeHSkOqeXI=
X-Received: by 2002:a17:902:d542:b0:240:41a4:96c0 with SMTP id
 d9443c01a7336-2445867ed19mr701285ad.29.1755108868210; Wed, 13 Aug 2025
 11:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813133812.926145-1-ethan.w.s.graham@gmail.com> <20250813133812.926145-7-ethan.w.s.graham@gmail.com>
In-Reply-To: <20250813133812.926145-7-ethan.w.s.graham@gmail.com>
From: Marco Elver <elver@google.com>
Date: Wed, 13 Aug 2025 20:13:51 +0200
X-Gm-Features: Ac12FXwt2pSL7dVwRutKcMu_hFjjWXkjb4Jh6zDHbgaT8hltdL3d-RuGkNjKm24
Message-ID: <CANpmjNMXnXf879XZc-skhbv17sjppwzr0VGYPrrWokCejfOT1A@mail.gmail.com>
Subject: Re: [PATCH v1 RFC 6/6] crypto: implement KFuzzTest targets for PKCS7
 and RSA parsing
To: Ethan Graham <ethan.w.s.graham@gmail.com>
Cc: ethangraham@google.com, glider@google.com, andreyknvl@gmail.com, 
	brendan.higgins@linux.dev, davidgow@google.com, dvyukov@google.com, 
	jannh@google.com, rmoar@google.com, shuah@kernel.org, tarasmadan@google.com, 
	kasan-dev@googlegroups.com, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Ignat Korchagin <ignat@cloudflare.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, 
	"open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

[+Cc crypto maintainers]

On Wed, 13 Aug 2025 at 15:38, Ethan Graham <ethan.w.s.graham@gmail.com> wrote:
>
> From: Ethan Graham <ethangraham@google.com>

Should also Cc crypto maintainers, as they'll be the ones giving
feedback on how interesting this is to them. Use
./scripts/get_maintainer.pl for that in the next round, and either add
the Cc list below your Signed-off-by so that git send-email picks it
up only for this patch, or just for the whole series (normally
preferred, so maintainers get context of the full series).

> Add KFuzzTest targets for pkcs7_parse_message, rsa_parse_pub_key, and
> rsa_parse_priv_key to serve as real-world examples of how the framework is used.
>
> These functions are ideal candidates for KFuzzTest as they perform complex
> parsing of user-controlled data but are not directly exposed at the syscall
> boundary. This makes them difficult to exercise with traditional fuzzing tools
> and showcases the primary strength of the KFuzzTest framework: providing an
> interface to fuzz internal, non-exported kernel functions.
>
> The targets are defined directly within the source files of the functions they
> test, demonstrating how to colocate fuzz tests with the code under test.
>
> Signed-off-by: Ethan Graham <ethangraham@google.com>
> ---
>  crypto/asymmetric_keys/pkcs7_parser.c | 15 ++++++++++++++
>  crypto/rsa_helper.c                   | 29 +++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
>
> diff --git a/crypto/asymmetric_keys/pkcs7_parser.c b/crypto/asymmetric_keys/pkcs7_parser.c
> index 423d13c47545..e8477f8b0eaf 100644
> --- a/crypto/asymmetric_keys/pkcs7_parser.c
> +++ b/crypto/asymmetric_keys/pkcs7_parser.c
> @@ -13,6 +13,7 @@
>  #include <linux/err.h>
>  #include <linux/oid_registry.h>
>  #include <crypto/public_key.h>
> +#include <linux/kfuzztest.h>
>  #include "pkcs7_parser.h"
>  #include "pkcs7.asn1.h"
>
> @@ -169,6 +170,20 @@ struct pkcs7_message *pkcs7_parse_message(const void *data, size_t datalen)
>  }
>  EXPORT_SYMBOL_GPL(pkcs7_parse_message);
>
> +struct pkcs7_parse_message_arg {
> +       const void *data;
> +       size_t datalen;
> +};
> +
> +FUZZ_TEST(test_pkcs7_parse_message, struct pkcs7_parse_message_arg)
> +{
> +       KFUZZTEST_EXPECT_NOT_NULL(pkcs7_parse_message_arg, data);
> +       KFUZZTEST_ANNOTATE_LEN(pkcs7_parse_message_arg, datalen, data);
> +       KFUZZTEST_EXPECT_LE(pkcs7_parse_message_arg, datalen, 16 * PAGE_SIZE);
> +
> +       pkcs7_parse_message(arg->data, arg->datalen);
> +}
> +
>  /**
>   * pkcs7_get_content_data - Get access to the PKCS#7 content
>   * @pkcs7: The preparsed PKCS#7 message to access
> diff --git a/crypto/rsa_helper.c b/crypto/rsa_helper.c
> index 94266f29049c..79b7ddc7c48d 100644
> --- a/crypto/rsa_helper.c
> +++ b/crypto/rsa_helper.c
> @@ -9,6 +9,7 @@
>  #include <linux/export.h>
>  #include <linux/err.h>
>  #include <linux/fips.h>
> +#include <linux/kfuzztest.h>
>  #include <crypto/internal/rsa.h>
>  #include "rsapubkey.asn1.h"
>  #include "rsaprivkey.asn1.h"
> @@ -166,6 +167,20 @@ int rsa_parse_pub_key(struct rsa_key *rsa_key, const void *key,
>  }
>  EXPORT_SYMBOL_GPL(rsa_parse_pub_key);
>
> +struct rsa_parse_pub_key_arg {
> +       const void *key;
> +       size_t key_len;
> +};
> +
> +FUZZ_TEST(test_rsa_parse_pub_key, struct rsa_parse_pub_key_arg)
> +{
> +       KFUZZTEST_EXPECT_NOT_NULL(rsa_parse_pub_key_arg, key);
> +       KFUZZTEST_EXPECT_LE(rsa_parse_pub_key_arg, key_len, 16 * PAGE_SIZE);
> +
> +       struct rsa_key out;
> +       rsa_parse_pub_key(&out, arg->key, arg->key_len);
> +}
> +
>  /**
>   * rsa_parse_priv_key() - decodes the BER encoded buffer and stores in the
>   *                        provided struct rsa_key, pointers to the raw key
> @@ -184,3 +199,17 @@ int rsa_parse_priv_key(struct rsa_key *rsa_key, const void *key,
>         return asn1_ber_decoder(&rsaprivkey_decoder, rsa_key, key, key_len);
>  }
>  EXPORT_SYMBOL_GPL(rsa_parse_priv_key);
> +
> +struct rsa_parse_priv_key_arg {
> +       const void *key;
> +       size_t key_len;
> +};
> +
> +FUZZ_TEST(test_rsa_parse_priv_key, struct rsa_parse_priv_key_arg)
> +{
> +       KFUZZTEST_EXPECT_NOT_NULL(rsa_parse_priv_key_arg, key);
> +       KFUZZTEST_EXPECT_LE(rsa_parse_priv_key_arg, key_len, 16 * PAGE_SIZE);
> +
> +       struct rsa_key out;
> +       rsa_parse_priv_key(&out, arg->key, arg->key_len);
> +}
> --
> 2.51.0.rc0.205.g4a044479a3-goog
>

