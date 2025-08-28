Return-Path: <linux-kernel+bounces-790846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D09B3AE41
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 01:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF221C81BDD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBC12F0C68;
	Thu, 28 Aug 2025 23:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLot++9U"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5412F49F3;
	Thu, 28 Aug 2025 23:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422505; cv=none; b=tU/ybHhRXyc//sNNsrsY8RCij4F0Xa3mvFBB4BwqQ2bHwOLprNeZHKrVQBSitiA5mE3wazw4xk5HpK5qku9qTlHwEECWVmPBq6jC9XqawAgE3qF35Y+QZk39g4U688ezaQB/mKE70/K2zwVlubc2/TUHD3GFu69lqPNZ+C/Hutk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422505; c=relaxed/simple;
	bh=eX6r2NsuRf/tdGP9bCsO7EoERmjYNRwFJWXHHnY1GZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jzbw/EO3V1QKfxL22eUaaUrE4Q7DqHyx2Vat2O90UZBp8tTkxaXW0c+2ynocXQjbAYR+zeQMbdzRVjAmUeISvixPuvydhkDlG+JAlO0JNbzEqJW3Jif4ayWAke/HAw4mU6fe8fO9GywiviXQCgMAlnUDs0F3y9VyCrUrj2d+p38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLot++9U; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-771e1e64fbbso1600356b3a.3;
        Thu, 28 Aug 2025 16:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756422503; x=1757027303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LkHIMSlRSqraPsnjE9eX8+909YoaHHE75gUul4j+7Vw=;
        b=lLot++9ULJR895f2EZlFEBYOSuFQLKOksdZUyOvUqQFK2zJxt3kMneb+RGrwaF2Vb4
         MnkwqG67u3nabQe0d1iaXUvasrGi0JOSjDpeRgDe82v+3zHO1QuSTY10ihl7UE02c3d/
         Qz0oCfB/koEYs6+YqUTS3Xqf19Y1rcr43VZ5sh4GSAc38G9+DCuyb7CHINX1fDvWv3CH
         aIYciGga4sbtcn5wYVgKnp09sh/6fuT9rj7kQXoJAcFb7AUhukaQeUmOPn8gWHuC2SA1
         I4FgNEVyZaTwYYrCU6UpvBdaRKSdnQb2pR3MEMQUg7ED7NEYMF8arurDr4ttVrCPS8js
         HM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756422503; x=1757027303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkHIMSlRSqraPsnjE9eX8+909YoaHHE75gUul4j+7Vw=;
        b=QiRyGtBEYjipCVU2dvak+XIH83lJbAhWvr/arTNi09ZpvwqXZWtb4Z0JMyJ1lh3vWF
         CkiKJfYY1Tj2bWlWLQDG+sq5s8itSTGugkv64S4FTKiRvGlU3u9dIxjEg2iNV2yVNJ9O
         tR7iE271VqP6ZftmWPUw4YLBPGcsiqqp8+hFKDN6Wv8V6AYqku+DbUB3K0hqYrFcZzDT
         7ykeBEB+g+uzGutEaN0dK77MFECtJu6n3yxlNPc6+34++Qsxv6jdLwiqp6Eb40TTK0dM
         FV7R89wSk+uLrjeWtmf/rp+rv4bzQkXCpxS8FqY5qDNmKjgFbpR9yD8+01u1LvIrSbJN
         QZYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFXJcwpaQUGiS3fzZSIumHNiUIDs24+Q4ZBsgHz+1KHG4OBUCQvgJdUfcPJY9vltyiu0lgWw7O/8c=@vger.kernel.org, AJvYcCXQ6zfHaLOgOR00Qkpy1qhQfzxbusw67eIi+UxUac1yfHLGmO1Gfbh3KGjU9CtpNRzo3fn99QD6j73Y@vger.kernel.org
X-Gm-Message-State: AOJu0YxLa8ar/rBDz+FnhDDbQv6lYaFUUohnA9ZoRy+jWLoToEYq3TD6
	aM3RGRnUuLEAAi97rgy1+Xcf3I2XoJ9sy8ML5sBqBXndaP6yWb1NxE5X
X-Gm-Gg: ASbGncvebFWVRwbpgV9NXZLYzXG3CJu2mSyW08EDrHbZJXQmC2MVfwBCfflymxuyeoM
	l49q8fTYyRfS82/DT2cbrK0XluKm/Y+hjOrGaM5lbCu4r65DL2tS2eFT3nQlyADn0drYgnoFJxY
	GSScSUoUhKndO6OMcOxHQa+2BeQkYKJa0zshb+49M76e34Jpf2L1oZwAFTt5fvk6FWm4d/hygnG
	QPxxGN0aeMHlYtiBzSnM0a8suw6k6mXsdwpR6wJqnigD3IlCPz7ApscRAo4KDWxw8Vwsf1Dm528
	8YGylzejGapmvH1s6BjRFfZRI1wxlts4rzxKdfViKjMA3tiXqYSB4qH3w89kIrwOXxR3Ez2cKdK
	z8wk2Xslj/xMSdksrt1OmzrEKGAGBoMGD/ZP0
X-Google-Smtp-Source: AGHT+IHm0rSXUFbT8NcpQHtRt5Q5aFipA7quxiO4gi3X8kUjka9pjKXRHjgnyM5iWtloGFbopZTfPQ==
X-Received: by 2002:a05:6a20:6a0f:b0:243:c36b:becb with SMTP id adf61e73a8af0-243c36bc0c8mr146477637.8.1756422502810;
        Thu, 28 Aug 2025 16:08:22 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd2f99ae5sm464233a12.41.2025.08.28.16.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 16:08:21 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 5C599420A933; Fri, 29 Aug 2025 06:08:19 +0700 (WIB)
Date: Fri, 29 Aug 2025 06:08:19 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Workflows <workflows@vger.kernel.org>,
	Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Fox Foster <fox@tardis.ed.ac.uk>,
	Federico Vaga <federico.vaga@vaga.pv.it>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] Documentation: management-style: Reword "had better
 known the details" phrase
Message-ID: <aLDhY00iaiMYV4Lg@archie.me>
References: <20250827044848.17374-1-bagasdotme@gmail.com>
 <87wm6p9v8l.fsf@trenco.lwn.net>
 <20250827113312.62162725@foz.lan>
 <aK_XIoncppxWp7sB@archie.me>
 <d0070beb-f6fd-477c-a315-a2c6db99c227@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c6Y9TGKcPWDNoxXS"
Content-Disposition: inline
In-Reply-To: <d0070beb-f6fd-477c-a315-a2c6db99c227@infradead.org>


--c6Y9TGKcPWDNoxXS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 09:18:57PM -0700, Randy Dunlap wrote:
> On 8/27/25 9:12 PM, Bagas Sanjaya wrote:
> > On Wed, Aug 27, 2025 at 11:33:12AM +0200, Mauro Carvalho Chehab wrote:
> >> Considering that "know" (noun) seems to be a shortcut
> >> for "knowledge", what about:
> >>
> >> 	They "had better knowledge about the details than you"
> >=20
> > That can be alternative.
>=20
> Nope, afraid not. Just leave it as is or (I think) 2 people have suggested
> something like "They should know better about the details than you".

Should I send v3 then using "should" wording as you mentioned?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--c6Y9TGKcPWDNoxXS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaLDhXwAKCRD2uYlJVVFO
o5azAQCuC5hbn6MsjQ+JvOU3To/10K+PuKYddM6jzKo2OlYRnAD+JpcUu1b33S24
2CuYM5xFXBmED5T+tUfzLnFZ5ga8lA8=
=MRKC
-----END PGP SIGNATURE-----

--c6Y9TGKcPWDNoxXS--

