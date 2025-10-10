Return-Path: <linux-kernel+bounces-848657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4368ABCE45E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24EE74EDFE7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9152FE598;
	Fri, 10 Oct 2025 18:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YYXg2d81"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65DC21FF4A
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760121900; cv=none; b=tlOj1662sLH7tEhzBEV6EE52uRmCHk+viRVJww0vZAWs0GnQNjYqRcWht63xISrRWMrnvzPVezpO0vH2T3iQOFg/qg3bKNJcTOz8HGRBamifaBG7uVKYRLJ1VjHvuCOz5CADOFwQNymICDUS3fTI2o2v9LeQseLDU24eQyVQdCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760121900; c=relaxed/simple;
	bh=1zymfUZ1WmQ9h4lNhjIFWuJmeCX04ZzQpO5qgIctNeM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A3xOlBzh9rvokVOu9yNBbXudkmdDRiAx9PcygCiA0iRRAeqiOigfOeJFFPWR2WcZA8F3z/R+a7pbBlb2cjeSr215IQOXwqolebSZroTeV5NAiW/FHq5XIBfNCsKSeglX6FbbXUGYG+Cfsxx/Ob0r2UY6hDZZXIXP5OFwl7wSgus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YYXg2d81; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b48d8deaef9so433712066b.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 11:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760121893; x=1760726693; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1zymfUZ1WmQ9h4lNhjIFWuJmeCX04ZzQpO5qgIctNeM=;
        b=YYXg2d81QDFbKjknKqymgfR+t4+6/pmB0NvJltY3iEm0LE0EGziwhItyqhrTgW8wzd
         B/Elt5/uvF2xNWtXrXvbX3mc0qQaQgl/mlwfl3mm+1pQPvPjRNRDEJ98bySZfsCWEPag
         +WvOBR1Q8Wyzxax8MTR/LE780n2ggX+jHG61WaT3ENsrATC8ud8UdPTBev/KEqvbCeM3
         IH26pMZz0cDPzw0KKJBgWHbUcFIr8Fry1dVxVC7olY6IZDXhrzlfbaAtz3pIDEi1wMNK
         6YJ+bSMntYTzU5hyePaDefob8wDwklZBbYJcdsWICBpnWa1R0Yn67UR3SiAypsN5fkiB
         894g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760121893; x=1760726693;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1zymfUZ1WmQ9h4lNhjIFWuJmeCX04ZzQpO5qgIctNeM=;
        b=H+yEDRFq8BKyJuggrJdlRGXlKE2o/JajfCA/Uf6CxUr+vWSM7jlUir0Sv/nKCI3pI7
         3407dq+46sYkIImJDzbBF9yTA4UYviaPwdtRUF/L0AV7YpEl4F3NyPsM01kcMBsr6tZ1
         wQZdx4QetTTstBhzIkYjF8TpjhPo+G41I85XuyBOPtkZPCZMevGJKqY9pcjmM4voF8XH
         Kc74642Y2Fm0LGdxQHQD7Bs8H3OOSTaHWz/zwvkDcNyTjRmjIK13yxYyE5GiIRwgCKoF
         2rkLE62Bwu8kDzYoAZO5mr+cL7hbdT4zkh4RA1gI7a1PdqWMMsjMXp8D1P6nffhfxfB6
         9vFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+cQpTp5ouGB2N9iJYWEQ2F024tdH9VpF8Tf1TEZbogOiUpcmhA904/5/R4Fahr186FEiQmdza6oWn8/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR1ZFg2rH4yj9bDzmo/V+m7M2UK2ZuP1nYUC1La5Tj0lZm2ffE
	J4LGg0D3J3/R4ol09fAgjEoNB4dhMYl7mmyindEESOU+IzJ+p+DWmSKinx+0hy9VPVQ=
X-Gm-Gg: ASbGnctJqyr1nrQu7p8RgGD4F1AF7eZTWXX2Gh4eGUIYvqppa0xw+3Hyncnyfi3uZeW
	Tgs4MWPGH9gM6q484mL9/USA9jyHAjw/3jiiBbs9+qPwETg1mgKqURVwv483+Ps/EWOer/bj6a9
	gEp2oByTdJY4RsZ3r7eBQ8iVkTNkE5Sw2Pv9fEr09segQS0pWE/R4EPj0b9xak2LDywR3jfvoTh
	fzvQ3KAUA7mrjXnByxzfuVLb/G7J0VFMpHucLg8+nJ6YRRuLFlgB6nGo04xcNfw2P4K62Yo3zI+
	sLlcUXyAaPWBjvJVya45D/HMh3z6zKpj1oeuMP/7OlAlO2UGJtC8koI/871UCJytS1/jZs8v7+v
	ITT1HBnGxdimrFkHclz3dnZ1HU3uIcGPWjn+wCMvp9mA/4kMllKa/Yge0za2agLRuw93FsX2t0c
	dWeucyQGvAU1LgejgfIA==
X-Google-Smtp-Source: AGHT+IF9mcAQ3MkhkBFO6rPgQ/DBPBOy6XN7G/fAwKwKxSFoundtgnbaWliaUR8sfEpjC3Mxmubl5g==
X-Received: by 2002:a17:906:c144:b0:b49:b3ca:52b4 with SMTP id a640c23a62f3a-b50aab9d64amr1296859666b.23.1760121892916;
        Fri, 10 Oct 2025 11:44:52 -0700 (PDT)
Received: from [10.203.83.193] (mob-176-247-62-200.net.vodafone.it. [176.247.62.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cadb18sm297243066b.3.2025.10.10.11.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 11:44:52 -0700 (PDT)
Message-ID: <aa0fc9e1bf78b9390642e80db3fc1c51e6217e95.camel@baylibre.com>
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO
 batch data rate
From: Francesco Lavra <flavra@baylibre.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>,  David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 10 Oct 2025 20:44:50 +0200
In-Reply-To: <CAHp75VfOfeS21=5SK6Qa9Fc-WQdjDkz1ecoTFrk=hT1NGGt0TA@mail.gmail.com>
References: <20251009173609.992452-1-flavra@baylibre.com>
	 <20251009173609.992452-3-flavra@baylibre.com>
	 <CAHp75VfOfeS21=5SK6Qa9Fc-WQdjDkz1ecoTFrk=hT1NGGt0TA@mail.gmail.com>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-UpencNko6xic6jQY8Xw0"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-UpencNko6xic6jQY8Xw0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-10-10 at 17:55 +0300, Andy Shevchenko wrote:
> On Thu, Oct 9, 2025 at 8:36=E2=80=AFPM Francesco Lavra <flavra@baylibre.c=
om>
> wrote:
> >=20
> > The rate at which accelerometer or gyroscope sensor samples are fed
> > to the hardware FIFO (batch data rate, or BDR) does not have to
> > coincide with the sensor sampling frequency (output data rate, or
> > ODR); the only requirement is for the BDR to not be greater than
> > the ODR. Having a BDR lower than the ODR is useful in cases where
> > an application requires a high sampling rate for accurate detection
> > of motion events (e.g. wakeup events), but wants to read sensor
> > sample values from the device buffer at a lower data rate.
> > To support the above use case, add a sampling_frequency sysfs
> > attribute to the buffer directory of st_lsm6dsx IIO devices, which
> > controls the BDR for a given sensor independently from the "main"
> > sampling_frequency attribute (which controls the ODR); introduce a
> > new `bdr` field in struct st_lsm6dsx_sensor to keep track of the
> > current BDR value, and use this field instead of the `odr` field in
> > the code that deals with the FIFO data rate. In the sensor hub
> > driver, make the bdr value always mirror the odr value, since there
> > is no separate configuration setting to control the BDR for data
> > produced by the sensor hub functionality.
>=20
> ...
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 *max_odr =3D max_t(u32, *max_odr, sensor->odr);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 *min_odr =3D min_t(u32, *min_odr, sensor->odr);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 *max_odr =3D max_t(u32, *max_odr, sensor->bdr);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 *min_odr =3D min_t(u32, *min_odr, sensor->bdr);
>=20
> Can we get rid of '_t' parts at some point? Or IOW what is the good
> justification for typed macros here?

I think they are not justified here, I will get take this opportunity to
get rid of them.

> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D iio_str_to_fixpoint(buf, =
100, &integer, &fract);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdr =3D integer * 1000 + fract;
>=20
> MILLI?

If you mean replacing fract with milli, will do.

--=-UpencNko6xic6jQY8Xw0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmjpVCIACgkQ7fE7c86U
Nl92Kgv/RQjdkwljZmvRSUOnkO36pZPvF/zKmfCsoungHTuca7c78LsnlPG6A+al
QZ7pz8VfJ7jFfi5d4aBNeRRNWigqSnMPcm28M1WfQYdAmRQLevBp1nzzxo6KOdIO
mO9+glhSUnuxTXFMQZkVs5f5CBmlllsWYeL1XktPzLjWGizqp3P8lkBzbaJOyHFW
fdMOxrrmxYXe1ACcMA9XMCYdcyJu71JGtZbz1VcZ/6ba0gTuzD2hEDJcbm7rY31r
oJyYqk/UiEeu/aIw+OcKl+6GH3Ir4yATkWdgzaewnscKgEzmgVnklfuUNrWpRIzC
5FSWPOpmxd2U3ymVlYt+JhwuEJn9wtmIHmEcoGxnY95ojLpYi/TIImGEstZ1npA7
rlqnAPPRSRer82mIfU9prpeYP91LytnKfQWIixfZuN+G7I2odIH3ZY+JL/iQ5dwr
XU6fdTY648WBfE5/kg0RBJoNmE/2pEFfpBk1u4UqI4QiJ1ghANdqohi2e1+gRfFm
ZIAr8T6S
=2Xlu
-----END PGP SIGNATURE-----

--=-UpencNko6xic6jQY8Xw0--

