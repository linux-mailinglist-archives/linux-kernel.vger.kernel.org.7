Return-Path: <linux-kernel+bounces-789229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC206B39275
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694C37C660B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD220264A9E;
	Thu, 28 Aug 2025 04:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXamJRPv"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212681C8606;
	Thu, 28 Aug 2025 04:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756354347; cv=none; b=WyUNIqzR6Qpta/b0IbknM4/AlSBXB0/1gJU9lxNj1FJrzadbwz7kUD+z44GnevRezUrQrwV9gytwX1PdcZMqwnneBMGIzkv9zovAKvZm0dbtWi4kVF7TYw+OCsqYhNEMpUn/2DLwm8nGHxVcoqjAEwqkzfnief0jnhoHVm5G0Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756354347; c=relaxed/simple;
	bh=WN89Uo3RwVaX0q4mCLZ6TaHBINalBhQLUUPa5dXyflY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tuzi1fYSnFDh5XAGJ/EOUzr7k7hxMD4ecPBg8zdyeBHe25yfGvXfaUKjb31xmOP1JdQI/pklA5Ba/4uOKQpFz5Ysp0HuJLsTvNQxcHxDBz05fRT3ayRMvGUW3XFz9n3E86W+d9GXJs9I5E3DhJWWb8y7YmWNBj4fFPBOm/gMxkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXamJRPv; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24646202152so6365105ad.0;
        Wed, 27 Aug 2025 21:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756354344; x=1756959144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xM3vptnVaXVwDy7ybty4eLADeK4TA37sWiFwhTzXlgE=;
        b=CXamJRPvvnrNNcLB+R5Jc0b/bCpPRMizwpMqm94MdjcCR2Q0wW9AXhjhTQosSHkZMh
         xVdL3jZyrVTjymUX8iZ/f9iSbfZYg0X4wGDVFQKDtFMvYKEoPykS1gtdwy+L3zNcg6MU
         y+1rSWklhxUW7D9haVf4oGidle21HZGrFyhzs4XE14sBroCFQqhyxcY69PHzsNvjo/yZ
         VEEnw0o2Y64BE7sO1jF5mXy8sEJ1bqt3rVsaBtEhxJ56+0WbX7982kqeC28Hl0ClAM/m
         7LImdHh4c7rfV6c9LLD/Z6BL9BXe8Vej3RcknOJqY69SwHCt5tc9jPeUbpOWGejHo7VZ
         qZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756354344; x=1756959144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xM3vptnVaXVwDy7ybty4eLADeK4TA37sWiFwhTzXlgE=;
        b=ColTRm+nFvpiHnlGo/YVYaRrjzYA9vw1AWt0A41pgUfMhO2F+1E7lR4+DuRQljrZJa
         8yBTzTEjWwqpRJ+sIw83T8pNwtBZjybpaGySXk/A/HcjhMRH6j5IJKhCT/rp6DWdyA27
         Fn3sICJWxWJ0NgF+BejsoYPAnEErbfcx8B9uS7ZY1h1N84i59YdRqNF/P20Go2pkL/Hs
         BNpN3ZfYreDYlLE5egB/IbBo7AhyatnoMlgwH6E+MJVd4ale+ASzak6+fOZrxHIlBiEl
         fPv7yiBedH0RWkKrPLNO7i+e8MlDoE48TUi+fqoxlV1hXmvXw2tBQjVuCkE7Hs46PhFJ
         5Wrw==
X-Forwarded-Encrypted: i=1; AJvYcCVFkEXtS/aFam70kKIBgbq3xlO9nti+bPa63KLo2x7Je1mCiylQQruWhCpeTYHqxbU7ZkZiS3BqXd8=@vger.kernel.org, AJvYcCVfR7QaqRsHFXIJ0MjRQctDNzppScByhyXSar7q5zOZFO5XCG4ZolTl/RCe50RHE2Q3D1CDxDXIYWzq@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/JE3BHHfG+y/i6pX6ckToTOv+Yr9bHpHp/km9HHc1qjUhsz0+
	QSkS5/QL/pPTlQQ/fSyqAH7+ncNungmyfk4bhkSTBBXEUaBD2/TvXqqW
X-Gm-Gg: ASbGncu1MOWAJcBaLav8+CqYeY3rpOM3wkmUFmJxbURnvn27EnSgAObDuJWoEuakrif
	mi9ZUgtGIwy1QKt9rtf0qbzAf4hOureFVCjtcW3otiwE2KRXx6ay9ND55y/Xv72mwj5SpoD/L0J
	k7AfZT4jpkt2aoTOqpO49ULZnkoO9XgGkCQNbQPTmrBMhSfzQxYgeu/Sxvb7KdG9ZnOO1WnQCTf
	1u40fmmGs8sq5VRTVPOMzpPUUsilbPpPIeVn3YZ4FsxI0ki8WRKGH8HJVq1QKCEzIZb88NPZ0k7
	/Rc5+AVMuY5qPj6htHzS5bERaCsT/iO9yRzzv+NXvhIPVhCdVHjTjyn95cOvJN5zBgSZMutIna8
	NP6wGsEIQ/a8Y1X36vkOVqHh9dw==
X-Google-Smtp-Source: AGHT+IHZ21AbUNmQHZ4t298crnlzLeXMfJjiOdcDaX0sZfTOfM2/+k1g3zkljInt0QdEyTrliIkz8A==
X-Received: by 2002:a17:902:f64f:b0:246:8bdd:17d7 with SMTP id d9443c01a7336-2468bdd1bfcmr188200135ad.13.1756354344110;
        Wed, 27 Aug 2025 21:12:24 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248d4e362d4sm8938915ad.148.2025.08.27.21.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 21:12:21 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 595784027828; Thu, 28 Aug 2025 11:12:18 +0700 (WIB)
Date: Thu, 28 Aug 2025 11:12:18 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Workflows <workflows@vger.kernel.org>,
	Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Fox Foster <fox@tardis.ed.ac.uk>,
	Federico Vaga <federico.vaga@vaga.pv.it>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] Documentation: management-style: Reword "had better
 known the details" phrase
Message-ID: <aK_XIoncppxWp7sB@archie.me>
References: <20250827044848.17374-1-bagasdotme@gmail.com>
 <87wm6p9v8l.fsf@trenco.lwn.net>
 <20250827113312.62162725@foz.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3kp2UqL1B3tlnqWW"
Content-Disposition: inline
In-Reply-To: <20250827113312.62162725@foz.lan>


--3kp2UqL1B3tlnqWW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 11:33:12AM +0200, Mauro Carvalho Chehab wrote:
> As a non-native English speaker, "had better know" looks really
> weird on my eyes, as, at least for me, "know" is a verb.
>=20
> Heh, I just discovered today by looking on a dictionary:
>=20
> 	https://dictionary.cambridge.org/dictionary/english/know
>=20
> That know can informally be used as a noun (a shortcut for
> knowledge?).
>=20
> For me as a non-native English speaker, when one writes:
>=20
> 	They "most likely know"		(know here is a verb)
>=20
> or:
> 	They "had better knowledge"	(knowledge is a name)
>=20
> Things become clearer.
>=20
> Heh:
>=20
> 	They "had better know the details better than you"
>=20
> the "better" word is used twice, and yeah, this is requires more
> fluency in English for a non-native speaker to get what it says.
>=20
> Considering that "know" (noun) seems to be a shortcut
> for "knowledge", what about:
>=20
> 	They "had better knowledge about the details than you"

That can be alternative.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--3kp2UqL1B3tlnqWW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaK/XHQAKCRD2uYlJVVFO
o49WAPsEAvJcJNYwU4d66ZTyPkrKkSJhDiFl0sLolEoQljcXvgD/YN+6gGbmw7bA
QRtPBYIm0VgoI8+XNqa98l9ImkRrBw4=
=evxw
-----END PGP SIGNATURE-----

--3kp2UqL1B3tlnqWW--

