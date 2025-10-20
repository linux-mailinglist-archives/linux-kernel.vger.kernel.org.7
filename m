Return-Path: <linux-kernel+bounces-860207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96562BEF988
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59B024EDB8F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292F92DC330;
	Mon, 20 Oct 2025 07:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hw8gCN7o"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFA42DC32C
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944085; cv=none; b=nwoRFlzd5Qh0WkPMsWn3LTSc07MB0n/G3jtaWZ2byXS6NYrU2PY2Tt5Gr/Ng1MI0aTMfE0rpqD5t93pLBVXCEdSIwHAr7uZGqN0wM9a/2O3MSOpcMJxkeWKorhY4Sw0NC2Y07Od/XUSnLs471qf/LQsqv5USMHpXFusNH7hPVRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944085; c=relaxed/simple;
	bh=XZ0XrFe8i9BOKiZV0xnN18sfKKByLNmWtR6xj1Y69WY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHwCOSNW5u7p3euvz8ekGz/5MwJ9kM7HpRBDtbm+O9KHm9Yw3PJ9P6pn9BSjUHIgPysGazMx3f1E52OuHcpYkEr8fd6mrHDl9YkKFmVJuaDB8RifKvLVmkgTbGC0DE10BfgQpLQcRjXk4XTJYAAzqj86j/2RBUBaEC+tX8qzDKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hw8gCN7o; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-339d53f4960so4063467a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 00:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760944082; x=1761548882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/HOxQeFzZprgS340iSyl+E8y8vVH7kK0gqo8lCK0SDQ=;
        b=Hw8gCN7oSJIanJ7seDeSs7cT6qmeINdD81LFwTET0BnrhqCnTwdyuTHwkSupgmlXzF
         czR+WcTrS2bCbbQey5V+60iOmwQogFHRTaQxrnKnZ9CM0OxZEv7KIo7yEkGFYAN2+A+L
         kjVjGVlj9uaUXZTnZTgdCyERCDYGGXKco6j9aCDAN36GASCpUFrTDapd7b3WBwlr+nsf
         NgzGai106R88mmVazssKKDhkYXPRijbcjfYAEZj+2ZUFFooUuN2tgSPGUKg3ccl3zAWa
         vXCrnY/T1vxXn0k2Bm20BwzwgKIgT3t7snhv3wwtUsePSE/CoQfOG28+tvYHXKKDd7xD
         Sulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760944082; x=1761548882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HOxQeFzZprgS340iSyl+E8y8vVH7kK0gqo8lCK0SDQ=;
        b=XpbHB68Z/0sae38EUdNSgPvxepZNI1e8CPbizroidGIHeH3oINIA0Zsv4+Iw28RalQ
         1lp15WPx8N4dX+I6f13PYI/fmw4vwRIA5ZJtTMptv9swgBYHcnWG/tpAMkWMiivwVojM
         DIU834RHmRhy0ybnzjCHUuOAXUkrSqigS7pVq+a/ufUhyQ4Zdg6OKC0vPcJfT/MPvjre
         mml9LXWbnp5OzYVcdT3T3pXxPgQSdvmjXQJ9dPPzHgvVc0u+KDk03lo1MmAZ96rVhj+U
         Mj7OApXZo8eZsJctzObzeTmZXYkMelQScPCXWvlHlCtwlB56sOoE7JtiJ0kYTk2Jniel
         ySGw==
X-Forwarded-Encrypted: i=1; AJvYcCVlrAp/YFPYH6gzuPVjXub4rXQMHy2ezuIkU3gTf0sWX+Cstk6sQVKBlEM8OXdQJQPRKO5WBo6pMZ7RyZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTN0z5wSp4eaV69EZHCOKJ+tXRNax0DmDHpu4o2luRfm3vZjn2
	freoHZz2trBOIbKWZsAL3UV6oLIOjwcJfOOSgM9M4lkaBggAL7QYWtXe
X-Gm-Gg: ASbGncufT+sKEARCy1mpVa8Y6ArJ7SdTIMYrY3rBf4nGLEdTQsPQGxgmLq4gqPD5SA9
	GSl020H12n3kRUqgycAIXZ3ODua9qlNOn3lpD5csZpZzDCQCLynYNN45iUDzGrVqoZvHGoFNX19
	DBVeWWWucsrxvmCHkVuhUu7x5q8T/MxcDS/Q0CRRc7gel+af38cd/izBQTzYse269yk18WhDZW7
	zc0XadefC8cYsbGGsMYs7nxSr9mo3JIv7XHVFM0JmvGd8D3RBOTL+XubFg2N5np9gU6e33MQ9YJ
	dQRnGNODl5xuh/j+7sg/Z1hF1IsQr4to8GLlXwxpJbd4ViojtNopyZKc7QMFN4YgQt9VqC5B6WS
	y2PuzbIS5bbJr1EvOLCde+4sgNRkzpUJ1dHOmtWD3irA4dSW0WVrzNmWF5huMD1WEs19TSyAX87
	uoVKI=
X-Google-Smtp-Source: AGHT+IEQ5375x2wAPSKC6RY36q65Xq6o1ABPfooltKbLM5TnVL2vpALRNQnKbvej+kaD3bTB+gwZ+Q==
X-Received: by 2002:a17:90b:4b0f:b0:32e:8c14:5cd2 with SMTP id 98e67ed59e1d1-33bcf8faac8mr15518129a91.28.1760944081925;
        Mon, 20 Oct 2025 00:08:01 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5deae553sm7219872a91.21.2025.10.20.00.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 00:08:00 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 123104241816; Mon, 20 Oct 2025 14:07:57 +0700 (WIB)
Date: Mon, 20 Oct 2025 14:07:57 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Stephan Mueller <smueller@chronox.de>
Subject: Re: [PATCH 03/17] lib/crypto: Add SHA3-224, SHA3-256, SHA3-384,
 SHA3-512, SHAKE128, SHAKE256
Message-ID: <aPXfzd0KBNg-MjXi@archie.me>
References: <20251020005038.661542-1-ebiggers@kernel.org>
 <20251020005038.661542-4-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bwyeZRG0SF5QekIi"
Content-Disposition: inline
In-Reply-To: <20251020005038.661542-4-ebiggers@kernel.org>


--bwyeZRG0SF5QekIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 05:50:24PM -0700, Eric Biggers wrote:
> +The SHA-3 algorithm base, as specified in NIST FIPS-202[1], provides a n=
umber
> +of specific variants all based on the same basic algorithm (the Keccak s=
ponge
> +function and permutation).  The differences between them are: the "rate"=
 (how
> +much of the common state buffer gets updated with new data between invoc=
ations

Use reST footnotes, like:

---- >8 ----
diff --git a/Documentation/crypto/sha3.rst b/Documentation/crypto/sha3.rst
index c27da98c89b7f8..ae1fd3e01e34c2 100644
--- a/Documentation/crypto/sha3.rst
+++ b/Documentation/crypto/sha3.rst
@@ -18,7 +18,7 @@ SHA-3 Algorithm collection
 Overview
 =3D=3D=3D=3D=3D=3D=3D=3D
=20
-The SHA-3 algorithm base, as specified in NIST FIPS-202[1], provides a num=
ber
+The SHA-3 algorithm base, as specified in NIST FIPS-202 [1]_, provides a n=
umber
 of specific variants all based on the same basic algorithm (the Keccak spo=
nge
 function and permutation).  The differences between them are: the "rate" (=
how
 much of the common state buffer gets updated with new data between invocat=
ions
@@ -136,7 +136,7 @@ should use the much more comprehensive KUnit test suite=
 instead.
 References
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-[1] https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.202.pdf
+.. [1] https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.202.pdf
=20
=20
=20
> +If selectable algorithms are required then the crypto_hash API may be us=
ed
> +instead as this binds each algorithm to a specific C type.

What is crypto_hash API then? I can't find any of its documentation beside
being mentioned here.

--=20
An old man doll... just what I always wanted! - Clara

--bwyeZRG0SF5QekIi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaPXfxAAKCRD2uYlJVVFO
o3A4AP9bdkVnmtIfCagfxHcW5eGHSyGy7zxDqFUTIe8b2dhvVAD+KVzQDxqnujqm
eYhwNKRJG53xvL9m37FLDKGqqZLtLw0=
=VJti
-----END PGP SIGNATURE-----

--bwyeZRG0SF5QekIi--

