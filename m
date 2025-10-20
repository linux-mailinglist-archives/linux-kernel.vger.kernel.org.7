Return-Path: <linux-kernel+bounces-860044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B06BFBEF319
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 05:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D730189925F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA702BD5B2;
	Mon, 20 Oct 2025 03:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLLlUaZ/"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4BE29DB65
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760931247; cv=none; b=OMv4TJYXN36zS6nPy4oRCAf15yxEyNnNBUMmk64okl8QIy0AlnhSZeIH6sGtD0J4DAJWkHOhc5QqQe3Pq4Iw55VCEo5xRba8iuHjEtWFSjeD89MNLZ/Zl6s6XUBszfs9r0iXD1c+9BTt0zyjlTqtXCSo3aLoA1A6o+bq2bUPbLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760931247; c=relaxed/simple;
	bh=ubONa7ropRcOUm568w5bPPTu9W0xpzaxAOWU/R0wKy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoSMeOHIQbPcD3xDH87HEqLmX08KywyWVsQd6dOVGbTXoDpFxtGQRsL04nDf7Kj3z5OMn1XFXKbzDGfmLF7wD7RLByDTgkb9nqbTcA9gOqqjXuznaKKn18q2zHz/yYxZXnSYVox/+TcXweNxa3EjQGF/0Q8aVQskw/Ae63YfMMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLLlUaZ/; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7810289cd4bso3749458b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 20:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760931245; x=1761536045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e9KCGk0JC3CTk5iIZQYbC1DgG/1ZW9eR1AJEbPiuOW0=;
        b=XLLlUaZ/gc5cPikZoKIpw+1TRZ9tNhl7I7xfmjpB4ygJmBH8vz1TczHOaqGKmeBb3E
         /Du6uwAOnuG8jW9x5NpzkHqWU7MDMx68Y6W30GWI3UgVZbRFTM2ve29tWHuIsnuRrhsI
         uq1W/GQAv6v5X3w+JEn6H67gNrYiH+G/JzcDx/GpPDQuyU5CCFw09wpphVNDA4ao02RU
         Fmt/gWQzgdnbanrMasK2RxPl9Xi2CHhuHFWh5KMtnPrJWNixBfIt1EdLIFU0SmAiu86v
         NhZMEKt80MoZIXatn2nz8FF1KO1hRGfuEWWzJ505rCY/x1DJtIv6XyqnXW9p8/H5OdUT
         erag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760931245; x=1761536045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9KCGk0JC3CTk5iIZQYbC1DgG/1ZW9eR1AJEbPiuOW0=;
        b=GBHEr48SpSw5Qh4ybBE1tFJrh5KPdNUyrSerADDi+vwma+VrhrwY7NJtXpZ1fbgkyx
         jBu4SNOfkLGfBaQc5cUEb9LRiPjMiE3fSXPEGWX9Nn1hxFTCWUo7vJSJY1K4Z5n80maP
         cwb2W7ChiOlSKI7x8HAuaJlNPQspP2qucmSTZ+0Lexwo4Q0Z3dSut2l6G6bN+1WBis87
         35wSbDy6o0ZVJzG9c/wZKWiTGFE6XHORNWeC1ixTN3FgHXfzXW4n3kzgz4fzj15xY26x
         OAhN9PzBh9vkiiBvpv0A4scxyLoSoN25zdEEM7y1j3ZIDQmvZIMOjqveJ5sCZtPbw1IR
         7XSA==
X-Forwarded-Encrypted: i=1; AJvYcCUwO7fPNhGcKXgacgAgfznlMtsHJkAn+6mnasnSx2DnjF7dXTfzm/jl9gyWpdAeau643D+GBbtt03dF1IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhekRIHMzqXNMAMXvfiO32w58gbDNXdUDaJ7FFM7EDw3+ywtjZ
	uZzirhzNrgKgaqCFIw14MoVrSY/LevTxF6T+qwhFX/AuRW0hsd1GQ29S
X-Gm-Gg: ASbGncslm2bfNTlvPrvtbr+HPI7JiZu82xx1kLzKXW+y9tN04xD51mnZG6rd5XtIJcQ
	LvjF+pQge3AIfe5u9zaw4nhpn385NUYQwVdfEVSjuTDThmy6Nl6TE4YJ5BWdAjBxpcO45T7I+lw
	IUcq2waZPo+j3PEqdVs+GbpWAowt4rD5kXD7lRdSGaQvr9mStsF4+iw6FjlMBl3T/aYn/9toP8H
	xwA2ASiOdLw9O7BJkcFqQQGmVss7kuHQxVnk/jB5m8A9B+W813jyEbqJbaOpJ0wNyhcndsDyE2f
	eGaTgWo4MFXVDl9VylU8o9tYmGfmznFunKTrC9HcclnjOX06C2K876IVQ2xLRsPoUdoE/i25veJ
	QNFQ8PKWaxtDT28/r7ypSJdMZwqFaZd3slNjp9rsbWx8PlZvyvNxsApymOm+OJxT2MGK1/qozzW
	E37Dst/8qi2XAIPQ==
X-Google-Smtp-Source: AGHT+IE3Iwg4NUHF6OYx4wb4cVhQ7Cs6qD/ZwCO1Ze/O5Ksvhac9AtWKMOgaiXSa0ybeYFo8/3pCWg==
X-Received: by 2002:a05:6a21:328c:b0:334:8239:56dc with SMTP id adf61e73a8af0-334a8650107mr15007720637.56.1760931244502;
        Sun, 19 Oct 2025 20:34:04 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b59d0csm6330782a12.30.2025.10.19.20.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 20:34:03 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 7AAE641E481B; Mon, 20 Oct 2025 10:34:01 +0700 (WIB)
Date: Mon, 20 Oct 2025 10:34:01 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Linux Crypto List <linux-crypto@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the crypto tree
Message-ID: <aPWtqT17TiqKTibG@archie.me>
References: <20251020135339.5df5ec50@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8rjPh9wMhciqOQRv"
Content-Disposition: inline
In-Reply-To: <20251020135339.5df5ec50@canb.auug.org.au>


--8rjPh9wMhciqOQRv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 01:53:39PM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the crypto tree, today's linux-next build (htmldocs)
> produced this warning:
>=20
> Documentation/security/keys/trusted-encrypted.rst:18: ERROR: Unexpected i=
ndentation. [docutils]
> Documentation/security/keys/trusted-encrypted.rst:19: WARNING: Block quot=
e ends without a blank line; unexpected unindent. [docutils]
>=20
> Introduced by commit
>=20
>   95c46f40aac4 ("docs: trusted-encrypted: trusted-keys as protected keys")

Fixed by [1].

Thanks.

[1]: https://lore.kernel.org/linux-doc/20251017181135.354411-1-krishnagopi4=
87@gmail.com/

--=20
An old man doll... just what I always wanted! - Clara

--8rjPh9wMhciqOQRv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaPWtnwAKCRD2uYlJVVFO
o6V8AP9EERIgzNXWepKUt/dJ+FI1xiL7XrKtxTO+dHX/XlNmhwEA8F+VLcrlw4CM
RD8IRaGDSenpZ7Pw8YJ1mpqsnKVGDAQ=
=4Xco
-----END PGP SIGNATURE-----

--8rjPh9wMhciqOQRv--

