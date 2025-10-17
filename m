Return-Path: <linux-kernel+bounces-857766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0493BE7E53
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DED242785D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B408B2DAFD8;
	Fri, 17 Oct 2025 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HUsSOCou"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E412F20C48A
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694769; cv=none; b=qJTDrlKuNfg9duRmJfx5FUJUxktUVBj9gdWbFwZKkgH+v+moLSYM3JUO0mKAXjDISGle49wvWEK/TRL5U3RUdX2BRq5M5oCkpTvlNJOk5z4ohX1EBaQ5YeNa1lJ+5iji7aVIxvDUXsJ1iH9HL9c5Wnp8pcEyNU5gkli03y9prL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694769; c=relaxed/simple;
	bh=krtfbaJmrdnEIUPH92y+4wruHrJQ5/sEYpo+V6iCrH8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WJEmQUuLPYdaLIzcSCQV5Ve3K5qzdkvr2ByAUKb2hB7S0ZiY4fvT8/OxsSWJItZJLEBfohVGinph8D1gA7ApfGZl28McbGBDs+AgHV5t2ZCvvwQSXYWhYXkVK6kPjkm4MEfsIa7Wu2XqEpOWz+7O7bXDg/yyAOOZPRdEwcVevsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HUsSOCou; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-637e9f9f9fbso3255443a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 02:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760694765; x=1761299565; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krtfbaJmrdnEIUPH92y+4wruHrJQ5/sEYpo+V6iCrH8=;
        b=HUsSOCouK5CEJwUOb8FzR6YPWH64PDiogdjXinD0WLmAHMM90Um/ZyVp89eri59uIM
         28Z/vT/SZiA8kulezgwOlZBhjsGkEONH7btpN25gHPeWxIFIrT2j9AnY6BlbBHg/ymns
         VYoX2yfMPStFvUi6VsZI3kBeI3++23Ky28FYoMjTkdBI8wsutQ8mWyQZtYW2YLycbl2A
         c+0KnLRxgDiYrvzw5YOKyfbUGcfb5IGwpGAbxgcDFzBPyF8XEXapZtIM3+9QWUI7KDAO
         SG0r3HxZ6SZ8kQg7SGeAniStddDzl7lwfaF1SIR9p1d4Uxc/e1zZ7WRQnS2ohhYgXyMQ
         vJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760694765; x=1761299565;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=krtfbaJmrdnEIUPH92y+4wruHrJQ5/sEYpo+V6iCrH8=;
        b=ZZZ/Gzw4EvXfmnWsqtrNOjN66EM2v8yJtqlunQnnKd4LtArtmJQ5yQuY5SCoiK7zzj
         ZHixLufD8UiKOYmFMrn1rHgIJVyCbabLxEisRwaGqoBPILEt+9L0wMsNxVnJIhUrz79G
         zCjRih0CnfAWunasas9cTih+tr5jchq91omWV4nrUvlKDC+YR+vS40u5l9Pt6dqUDGBL
         20TeMY3RwdNIvDhYfmh+CYzDsh1Oxt9fe+bIxb6OkD3aFNn9t+J331lkfuI7kokSkATr
         Uax8i6mHZ+E0Bee1n4GFLbpGKbVKyvECcqdwjgUZjQ5zXA+q/oow81qaQt5+O44m/Rj3
         Gnqw==
X-Forwarded-Encrypted: i=1; AJvYcCWkU/UWAiFowJnVJ1O8re9esm/kV/wnRGVvGW/JSnWSC5z3sG1YwyVBr7Lkz9+FRdLf7lb9E0iXff2Q4gU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXCuiCgYZg1Oh1a96WpqxzkxR2hDBEGZF3TSNwsmlZBAgMUvW+
	Nc3/2vgdJ8l1/zD5sLZuZte7lFWK0Dl6fsJ0xHKThfFbQyJjea9FODrTGegdwMVU8gs=
X-Gm-Gg: ASbGncsKYGRCFed2kH+YTi8532sTswmVpshOMFhz66CEOrJaFk8Cd9bdIPmA1GtuFW9
	gOfyWwYwtvF1kCouao0Qk+3euRphFneOYveFGN6DV1YF2RM4WfO3sl4Ql+EQZjMgPi8Lz7ExSwT
	qdQ2X5BWwlmameeSm+/fc5+4wJL8riNOMelIvwRfr6Cw0T2WGdgBQLXGXXiXmfm6uUXQ41/wRcS
	WB7e3Twtm02o3owSZEHe/1RAnCIRZVsCFDPtoZcTFjMw4nxdY18OjKxFzpAFksskfNfiqw0JJaA
	0dZ9HLONfc6n6gNHndrlSWIAWXG0jUq73e61bfsFHghnb6WyCw7g5zzJJfvIuNh4lMEq3yayu2O
	vjN/ibIGuV3DTizMUbT0kzfeBxZv0koSbvFogrL8bZdtzhVPILKYrj8ArDAPGb7sCLJ7Ki7kIA/
	yDySyaL/6YZzOeuilKjGcDId5yKIHJFmkNSUAPzzetcvWDkbjBk5Gz
X-Google-Smtp-Source: AGHT+IGWZep8ffF+F1GgQnRzfhXT0oTDdMxpNqX0rCxoli2ly79a6bIfyF/nMfUOmRjBANPF1e7aSg==
X-Received: by 2002:a05:6402:3485:b0:639:f548:686e with SMTP id 4fb4d7f45d1cf-63c1f580d94mr3023847a12.0.1760694765206;
        Fri, 17 Oct 2025 02:52:45 -0700 (PDT)
Received: from [10.203.83.121] (mob-176-247-25-234.net.vodafone.it. [176.247.25.234])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c25273f36sm1728474a12.25.2025.10.17.02.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 02:52:44 -0700 (PDT)
Message-ID: <2bfbf4f61119e3f4f52bf591a49a565314ae03e7.camel@baylibre.com>
Subject: Re: [PATCH 1/2] iio: imu: st_lsm6dsx: Fix measurement unit for odr
 struct member
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 17 Oct 2025 11:52:37 +0200
In-Reply-To: <aPFR7r-aHtURsWtD@lore-desk>
References: <20251016172122.1220332-1-flavra@baylibre.com>
	 <20251016172122.1220332-2-flavra@baylibre.com> <aPFR7r-aHtURsWtD@lore-desk>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-+iXbUeoPTGzOPOYfkFqi"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-+iXbUeoPTGzOPOYfkFqi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-10-16 at 22:13 +0200, Lorenzo Bianconi wrote:
> > The `odr` field in struct st_lsm6dsx_sensor contains a data rate
> > value expressed in mHz, not in Hz.
> >=20
> > Fixes: 290a6ce11d938 ("iio: imu: add support to lsm6dsx driver")

I just learned that odr values used to be expressed in Hz in past versions
of the driver, so the right commit for the Fixes: tag is f8710f0357bc3
("iio: imu: st_lsm6dsx: express odr in mHZ"). Will correct this in v3.

> > Signed-off-by: Francesco Lavra <flavra@baylibre.com>
>=20
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>


--=-+iXbUeoPTGzOPOYfkFqi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmjyEeUACgkQ7fE7c86U
Nl8V+Av/ZXdMSbKRnicFYABf1qs538aQeaxDMJqplKf0znbJk8e/kGEpVHGEUoal
jHPORWlP9xA1t2VkYqvI1O1XYYjNR6EjLlHX69eytqSvl1mKD1ZbGmQPcs4ZoO3y
S1xG2weO4AdheIbjV2kDYKzHA6oBYHJZhoM8WqFIASLA1q99nd8eAbqtCFAv/mQA
A5uZCzNVrm6JIB/8pJG73URHMoLCkQzcPNcow2Ijo2GfvgAS1UBIk8Q61E54EbO7
jMTRH9kZn7x26Ddr2CgupoARic6YPt+qp8G00RG5XPR6Vf4kAG1Gel5fzr2YZtJw
Al3ceuFX2XMIisBWm59LaQPuelwgLTnqcmYfCwZgL+CDAy65lqgQ8j83koo4aAhG
rTKoQREYyrnZE62PDguK9KE7iXlv2WeygRXCDiN4HvWO1YxJ4a8qFOQFhrB0bEeu
w851JSiEqBNu2SMNN8iJKt7HwZDMrdy1mHek+lp6KbL/fFZRk/2CnfT+DO9K0Qad
rfmIqduW
=PYbM
-----END PGP SIGNATURE-----

--=-+iXbUeoPTGzOPOYfkFqi--

