Return-Path: <linux-kernel+bounces-750075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C793B15702
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8962216E540
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB3318DB2A;
	Wed, 30 Jul 2025 01:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbzcuHmm"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F878460;
	Wed, 30 Jul 2025 01:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753839509; cv=none; b=fgr5pmWlAR/YRIZfjZzF0v2qyrR/+zcT3SoHHk+BcxLec4FCiEQoj0EHCxbe4l6LKb79Ti3qYUCo3jAs5kXs2Tc9LxZoxwqDgg8/UFZ5PEQsbPgOHLn95GS7wwfqOuqAAxzhHMeVGYgDzA6Mt3GD9VyGhL/+OERV0U5UXZVOq1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753839509; c=relaxed/simple;
	bh=UGBFpDfSaP3clmVM36byP6ZcqOCc+u/kLxDynqsULK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwUKeDeh/ibianX5b3ALa89JSKpNsAQ3faeoLX0pdCsc4xYaew2WZo6O1lA0sqZ/tbhsGZcSKggNDyUPMmdKeyLuKR0C/je3E0wwhoLgtAGYXzKI3lBdCzBcm/J9ZuGNMtQPIVZLYpUfMdrBm6uHvwzERhh3DDLcu0eiSvywuQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbzcuHmm; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-313154270bbso6661026a91.2;
        Tue, 29 Jul 2025 18:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753839506; x=1754444306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jNZ13qA+CkXTr4v7EYXlbjm7yC2fw299qB0bBfCAp5o=;
        b=MbzcuHmmccH25ESltyhLZE/LtMFBK7IV14H8UQ8NfyxqQW10cDWFEl/FQD9ZGO+OSp
         0n5yeZ8tOvnXaGF2OkJsfJr0l3ZLG84mdVPBtLCrhzp9X6ioYc8suRpNwJ/lZWyoqwyL
         RPpmOcZLtEAV4aJU9T5sarR38sdTqGt+B2zxvxP/HxNJjmY6jgZ7raooBd8QeRsrXp8p
         cqY9eBELOBpfawEaTNmFPsglrN/qHp78WRXHaXrD4HlENAx8Y6S904dk6yIgwTizIb/p
         GD4QLAi+MDZGxjJb3n9qJ6aAIcMIqi3xz1WvHaHY/vTtKi5sa9pY+ajeG0qg19tTD+VM
         h1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753839506; x=1754444306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNZ13qA+CkXTr4v7EYXlbjm7yC2fw299qB0bBfCAp5o=;
        b=CuBj3x1Ct5FZ4mEUtWH9se5YiUEvV/if1DlKStyiiOjKpREu9rDr3Bh5SraPc8rdoP
         +0umb2ZdZnW03jdjLHI2TsSCFppRMM44NAk+k1+H0TPHgNOEw1+pYCkIDM06L65wl+p0
         jmTZdri0WlIzhS+y+KuUyzW+6zoamxxTc7eE521ixlXgp/emNu8k/7jaeQPTwBHOmBrW
         oFXgFHNIc2yYSvX2TPJKHRV3e2zQvQyiHhnPwJiQPwSkopmWBu796v5814uTk9NlfgvA
         IMjM92YTMuzu17qNrBlmzPXnv5cVJeK78wIFWeacddwRscBnUThNemFHd1sB9XA/yY9w
         1UyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGRhXi1Afnyb11TvEtpGLOFczA6YPd43PB0Gx/+V29ioBDqODSKqUW7qafcAEfKsyeTEVK+OU0grfgVMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz768k+xE6HXp1OQm2tzY6p+knLNIycKAGApLTLcWthnHO/x2cr
	vaI/16YIhcQ6nTtHApUvuqHXrZj+tnddtJlT0ikFPpIX1voqCFXJPWDMXpuGDZED
X-Gm-Gg: ASbGncsSUTsTKdpIZxGwZklP94bRubjZl1r5vnBdBz5AkodpYkkyDnKUno/mHNJh6xF
	+Sx71NytJvlhbHZnWP8iM9q413uDwK10B5VaUitmlrvPa8YNvaHwqtXWLqXX2Ex4JdIVo73Xocj
	UBtHfgPpRuekc3NBZ1hGc56YPN+glcIirn+VAHEzPMJ2r2b1c4cLu8CEv7RYEa6nvLYxGiJV5My
	AQcDjLFTTKNI3oiNZiOGVWEW2qg68gUVCxdnqKPsBSmVPbm4iOJU08d6o6ZROSRiwDGZnnbd9cP
	mmGMmR1efhC6SfBMZho2RCcRfeGlJ3Kgluzg6HdOJXx4xVSeLLLZrPs1KrCyzBGLPjRr9dD9AXc
	qTper0BTXA8Dd2DfePMTcDj9JJG7SR5w1
X-Google-Smtp-Source: AGHT+IHO4YicY+3VS195iwgbisZPkkZlqrCNzCY1bEfx5ZIeHqNqOCWUTP4SQnQ76rGlgPih/7xksw==
X-Received: by 2002:a17:90b:4a:b0:31f:42e8:a8a8 with SMTP id 98e67ed59e1d1-31f5dde8a3cmr2217681a91.12.1753839506023;
        Tue, 29 Jul 2025 18:38:26 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da3326sm404684a91.4.2025.07.29.18.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 18:38:25 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 5E260420A923; Wed, 30 Jul 2025 08:38:23 +0700 (WIB)
Date: Wed, 30 Jul 2025 08:38:23 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Linus Torvalds <torvalds@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Documentation for 6.17
Message-ID: <aIl3j8klCw6xWyH3@archie.me>
References: <87y0s81lqe.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="50CkEXK0HxdfabJe"
Content-Disposition: inline
In-Reply-To: <87y0s81lqe.fsf@trenco.lwn.net>


--50CkEXK0HxdfabJe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 07:35:53AM -0600, Jonathan Corbet wrote:
> The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd13544=
94:
>=20
>   Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.lwn.net/linux.git tags/docs-6.17

Hi,

It looks like this PR slips through the cracks (not merged yet?).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--50CkEXK0HxdfabJe
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaIl3jwAKCRD2uYlJVVFO
owwDAP46ajhDrw+oVDa+e9lSzz4LYbnMDGIoNRHl7lVB2J/hrQD9E9s+LH1qaYGy
Yok0cUhmCUMS+aPmekCEiUtzcQuYxQA=
=kgRK
-----END PGP SIGNATURE-----

--50CkEXK0HxdfabJe--

