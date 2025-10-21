Return-Path: <linux-kernel+bounces-863060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 038D0BF6E90
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C056350727C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D66339B34;
	Tue, 21 Oct 2025 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c3psRs9d"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8A43385BB
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054722; cv=none; b=TMdgegoZef6Vk1hr5zjN7KUF70xEo7emgeths+S/0p6wxG7NWI2VJstZM0aDhbnMbE66tqF1jVHr6LY2jgpJegvc3+g83AKAY7lniosNFc3QHO1zc6/rR0NKY/QgCJurpNfAKRNGGdT6W3r4XxtoF8DhrY6JGlhoTSx5IfBazCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054722; c=relaxed/simple;
	bh=cKFEf/mkujNMWCNn288lix+mx7uATbdtwPCr645LzQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TH9XB2d3iuF9oeSzvPVEa5W39QS8m3CHoZcyLAmncJGqM6Wb7JHN6b/OLgg9247urcalDjxvb2gJgXgFgp4Wigdh8ks7MNbar52a721DPYiJ1BbmZxJX/ZzX5VLU4b3GSLV0WEy2YU1hsIENX+H6WxJYTgJNJmm3ar7PZtMghoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c3psRs9d; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4711f3c386eso27441405e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761054718; x=1761659518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2DyGAU+rMA/cRZrPzQupQaBzSC5vN1SBLAXdhns1VBg=;
        b=c3psRs9dCxelf/aUOXvb+s91iQFgGtFocu21KJGzmx/OFjdFr+liPSKreuteIapmAu
         RA/9LbcZ5iWEcGese/FGlR6IqlrpXRjvg6LzBb7MAUbLgyJ18pzuF5i29JMvRywT+Cov
         uDW840jYvC17mez5rttoLLHpsvPxqeJAG1/yNveDdQ/8avt3u6wSyiF9cp+My1e1sRGj
         F8vp+ujI4lRUk93yxKLGpDg3aXDRCAwMapKTmnhO+6s1toLzcIxR2yDt01hmZVA5T725
         ayd2WCmdVXKrcafzt5LTtFc9A+aIMEPvxjdCyZfotvY6d9zDqcW1ebRNRlx8Wn1bqLb1
         IsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761054718; x=1761659518;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2DyGAU+rMA/cRZrPzQupQaBzSC5vN1SBLAXdhns1VBg=;
        b=n62eUVjCLqIwkFBxDYdmA9tUCWpawhh2dgj0VTxjZbi/R/Bz0BcZYfxLZrQDM6DeX9
         lH71TTxA5Z7nIYAXEO76FiIDL1hIm3t1AJA9ID0hEiEoJfu7MmP8juv1t4WxNSU+Fv/o
         an1HZSmOuBQdjn0dY3QYOhMdoPE59JsANT0q2GKkfWqW+d4pcnB9mOXAUzwIBbTouGxA
         z3bRTsRc/nL5/mVy1bmXXbJZI1ZHoIccdm+1FVUUeXCK3dFPVbr3rPYwEmsAg8lOTTGw
         rovoe6Vjn1D8rH4jj25PPlP4r2e6vYA4UU/E0SWhy99TgNale5vntbYJMfRZEDFa4QSY
         hz8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRt9RWXCYglugjOVB9YIV9IWzi/EkPvfkiitnBZYjlqFPyaJW5gmWgjnM7+9wKAFgjXrTyUTwdWmUIE44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2OkLfzbyZUMuar9ybidI+Z79nNMIZdCduMCOQVtLjqzfjYZOJ
	32UJi7cKdliXOvP9y5Q1decXVQUXzuq7uosqjDVKFwLt5n9hgw+5JYbEb63cqxuQqco=
X-Gm-Gg: ASbGncukchSruLSNZ2VuIyOhF4MKH5PueUyuLmjVYwpJkzMqO0eQnnXy6XFBDm+dfTM
	w6qNPgise/mUrHgPxsIY/CIyBsmiM9CavYlnoDE/8LO+27ZCkKLU6xRzJXMMYzfok+Us2Ss0/MO
	WxiTK0Xy8aT/gBQQaM4RM01dKBQzdaf1ioaaytNFvffJaSWVtIgwzetSseBgyULokQhInAAoXbz
	bZ95NxQXsyYb1R8I30yAaVopDksCDsvWn1knIEaOM4a2+jZFOIzo7rXnJ5eZQ9KrGOdfK+626sg
	xt60nD0kPgH5JEpmOuID8ivyrwOZIyNVZ7CtvbTC+TUF7d6bpyMNO3psIW/ugBhbUgciRQi9e2k
	1zS59a+qfCYJ2NdZDhP7KoopjUFDe4GmZZwZRsUJsd6E5X8giIfC68MM45tfNpz37q7ejuH+r+K
	8Y9jY+5f4glP4rN/Uj+2f9Ey9SAMT9nsA=
X-Google-Smtp-Source: AGHT+IHWJuVwFzbFlMqm8ao/URm2+K5hiKjfkJF6MOKyAoW5c12azTqzQXI62G8B/tUeCFgJ75QR4A==
X-Received: by 2002:a05:600c:45c9:b0:471:115e:87bd with SMTP id 5b1f17b1804b1-4711791c601mr124597535e9.26.1761054718131;
        Tue, 21 Oct 2025 06:51:58 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4715257d90bsm198104915e9.2.2025.10.21.06.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 06:51:57 -0700 (PDT)
Message-ID: <81080a24-e4a9-4287-8653-9d707e574d95@suse.com>
Date: Tue, 21 Oct 2025 15:51:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 17/17] modsign: Enable ML-DSA module signing
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, "Jason A . Donenfeld"
 <Jason@zx2c4.com>, Ard Biesheuvel <ardb@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Stephan Mueller <smueller@chronox.de>, Lukas Wunner <lukas@wunner.de>,
 Ignat Korchagin <ignat@cloudflare.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-crypto@vger.kernel.org,
 keyrings@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251017144311.817771-1-dhowells@redhat.com>
 <20251017144311.817771-18-dhowells@redhat.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251017144311.817771-18-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/25 4:43 PM, David Howells wrote:
> Allow ML-DSA module signing to be enabled.
> 
> Note that openssl's CMS_*() function suite does not, as of openssl-3.5.1,
> support the use of CMS_NOATTR with ML-DSA, so the prohibition against using
> authenticatedAttributes with module signing has to be removed.  The selected
> digest then applies only to the algorithm used to calculate the digest
> stored in the messageDigest attribute.
> 
> The ML-DSA algorithm uses its own internal choice of digest (SHAKE256)
> without regard to what's specified in the CMS message.  This is, in theory,
> configurable, but there's currently no hook in the crypto_sig API to do
> that, though possibly it could be done by parameterising the name of the
> algorithm, e.g. ("ml-dsa87(sha512)").
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Lukas Wunner <lukas@wunner.de>
> cc: Ignat Korchagin <ignat@cloudflare.com>
> cc: Stephan Mueller <smueller@chronox.de>
> cc: Eric Biggers <ebiggers@kernel.org>
> cc: Herbert Xu <herbert@gondor.apana.org.au>
> cc: keyrings@vger.kernel.org
> cc: linux-crypto@vger.kernel.org
> ---
>  Documentation/admin-guide/module-signing.rst | 15 +++++------
>  certs/Kconfig                                | 24 ++++++++++++++++++
>  certs/Makefile                               |  3 +++
>  crypto/asymmetric_keys/pkcs7_verify.c        |  4 ---
>  kernel/module/Kconfig                        |  5 ++++
>  scripts/sign-file.c                          | 26 ++++++++++++++------
>  6 files changed, 58 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/admin-guide/module-signing.rst b/Documentation/admin-guide/module-signing.rst
> index a8667a777490..6daff80c277b 100644
> --- a/Documentation/admin-guide/module-signing.rst
> +++ b/Documentation/admin-guide/module-signing.rst
> @@ -28,10 +28,11 @@ trusted userspace bits.
>  
>  This facility uses X.509 ITU-T standard certificates to encode the public keys
>  involved.  The signatures are not themselves encoded in any industrial standard
> -type.  The built-in facility currently only supports the RSA & NIST P-384 ECDSA
> -public key signing standard (though it is pluggable and permits others to be
> -used).  The possible hash algorithms that can be used are SHA-2 and SHA-3 of
> -sizes 256, 384, and 512 (the algorithm is selected by data in the signature).
> +type.  The built-in facility currently only supports the RSA, NIST P-384 ECDSA
> +and NIST FIPS-204 ML-DSA (Dilithium) public key signing standards (though it is
> +pluggable and permits others to be used).  For RSA and ECDSA, the possible hash
> +algorithms that can be used are SHA-2 and SHA-3 of sizes 256, 384, and 512 (the
> +algorithm is selected by data in the signature); ML-DSA uses SHAKE256.

This update looks ok to me. However, I'll note some problems that
I noticed in the original text, notably:

The text doesn't match the implementation because kernel/module/Kconfig
still allows selecting SHA-1 for module signing. What happened is that
commit 16ab7cb5825f ("crypto: pkcs7 - remove sha1 support") initially
removed CONFIG_MODULE_SIG_SHA1. Then, commit f2b88bab69c8
("Documentation/module-signing.txt: bring up to date") removed it from
the documentation. However, commit 203a6763ab69 ("Revert "crypto: pkcs7
- remove sha1 support"") brought back CONFIG_MODULE_SIG_SHA1 without
reverting the documentation update.

Another problem is that for MODULE_SIG_KEY_TYPE_ECDSA, certs/Kconfig
contains the line
"depends on !(MODULE_SIG_SHA256 || MODULE_SIG_SHA3_256)",
which intends to allow ECDSA only with MODULE_SIG_SHA384,
MODULE_SIG_SHA512, MODULE_SIG_SHA3_384 and MODULE_SIG_SHA3_512. This
restriction was added in commit d4f5bfe20da9 ("certs: Limit
MODULE_SIG_KEY_TYPE_ECDSA to SHA384 or SHA512") and 446b1e0b7b39
("module: enable automatic module signing with FIPS 202 SHA-3").
However, the documentation suggests that ECDSA can still be used with
SHA-2/3 of size 256.

I'll prepare fixes for these issues. For the first problem, I think we
can drop CONFIG_MODULE_SIG_SHA1 instead of correcting the documentation.

>  
>  
>  ==========================
> @@ -146,9 +147,9 @@ into vmlinux) using parameters in the::
>  
>  file (which is also generated if it does not already exist).
>  
> -One can select between RSA (``MODULE_SIG_KEY_TYPE_RSA``) and ECDSA
> -(``MODULE_SIG_KEY_TYPE_ECDSA``) to generate either RSA 4k or NIST
> -P-384 keypair.
> +One can select between RSA (``MODULE_SIG_KEY_TYPE_RSA``), ECDSA
> +(``MODULE_SIG_KEY_TYPE_ECDSA``) and ML-DSA (``MODULE_SIG_KEY_TYPE_ML_DSA``) to
> +generate an RSA 4k, a NIST P-384 keypair or an ML-DSA keypair.
>  
>  It is strongly recommended that you provide your own x509.genkey file.
>  
> diff --git a/certs/Kconfig b/certs/Kconfig
> index 78307dc25559..a09db4b2c87c 100644
> --- a/certs/Kconfig
> +++ b/certs/Kconfig
> @@ -39,6 +39,30 @@ config MODULE_SIG_KEY_TYPE_ECDSA
>  	 Note: Remove all ECDSA signing keys, e.g. certs/signing_key.pem,
>  	 when falling back to building Linux 5.14 and older kernels.
>  
> +config MODULE_SIG_KEY_TYPE_ML_DSA_44
> +	bool "ML-DSA (Dilithium) 44"
> +	select CRYPTO_ML_DSA
> +	select LIB_SHA3
> +	help
> +	  Use an ML-DSA (Dilithium) 87 key (NIST FIPS 204) for module signing
> +	  with a SHAKE256 'hash' of the message.

Copy-and-paste error in the help message: 87 -> 44.

> +
> +config MODULE_SIG_KEY_TYPE_ML_DSA_65
> +	bool "ML-DSA (Dilithium) 65"
> +	select CRYPTO_ML_DSA
> +	select LIB_SHA3
> +	help
> +	  Use an ML-DSA (Dilithium) 87 key (NIST FIPS 204) for module signing
> +	  with a SHAKE256 'hash' of the message.

Similarly here: 87 -> 65.

> +
> +config MODULE_SIG_KEY_TYPE_ML_DSA_87
> +	bool "ML-DSA (Dilithium) 87"
> +	select CRYPTO_ML_DSA
> +	select LIB_SHA3
> +	help
> +	  Use an ML-DSA (Dilithium) 87 key (NIST FIPS 204) for module signing
> +	  with a SHAKE256 'hash' of the message.
> +

Should all MODULE_SIG_KEY_TYPE_ML_DSA_* options depend on
MODULE_SIG_SHAKE256 to match the updated
Documentation/admin-guide/module-signing.rst?

Similarly, do MODULE_SIG_KEY_TYPE_RSA and MODULE_SIG_KEY_TYPE_ECDSA
require any "depends on" update with respect to the addition of
MODULE_SIG_SHAKE256?

-- 
Thanks,
Petr

