Return-Path: <linux-kernel+bounces-830672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE33AB9A431
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108C82A4AF3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DC6306D21;
	Wed, 24 Sep 2025 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ys1HtpVd"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8D4749C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724403; cv=none; b=L6zdnD3KWo0s2gqDL76nmYoNzlcMHOjv1pYHvnmkZriYmPqpQPocv1Fpbj+Dwqt1TJNdDDC7V/xh5UQw1hJw9peE9utlbLEorbEYMJLHXzAL6QkMN2Cb3pP7Tzqm5mG4ngEaOt58ywXFAkgg6oQJLCgDbUw+fofEMG8LgXKSjKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724403; c=relaxed/simple;
	bh=HTk6unxpSlNsZnindmhsTv3IxjNC5xb2UJ9H7C5dmHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3gAhNeVyDqbCUUTH6s2IuoKuDovDAWVbSvdpK09JQn5IYfS2jZ6ja+wkUx1K5wUgEQ9Pi4Ztw/85TFVpG7PfiMScL8EhF65CH+pxKbYO2aivCO7JJiGzVgwT/xxW3Jfr4AE+QhPqS/Ngg459f63g9zjQaJwJkQP/ekvokcr6DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ys1HtpVd; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45df7dc1b98so43568345e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758724398; x=1759329198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VNhsWNt2kqqJEfmWFDpL/GmAKxMyQySWPvc8rdD+R0M=;
        b=Ys1HtpVd0oXNVmdlzPMV8HY8dRjqASW4CvCmnUca3tinMzgNgnc4OFQGTA9ktix1nX
         k6BLhCIW2c0gDC2fMZ0MjLgvf1T3/irPTOi+3ab4HWohf1L1NIAvOITZHpq62iKtdQaC
         +w4OCDfbGJg6SULC3Ae24rcYjLnTTDN1yPApH6Jy3DhTPVLRGp3A1V4hQJi8IHJZA4L3
         JMhQOOUTiiExYh6+w0K7YjWWxr8pyrOTz6S9W1UPGJpyD3dj0oC6eL7KaAz/LMmyr58j
         oQS0b9GIWbrjndIW00H9Aes/XPe0kiJjH8whkaXHo7NzLf3Q/df0k8YPY0LNG7UudPJL
         kEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758724398; x=1759329198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNhsWNt2kqqJEfmWFDpL/GmAKxMyQySWPvc8rdD+R0M=;
        b=ewxY9vJ73hjvKJSIySCMcmNd6jW82BzfFqGKEfXsC05Ip0Rn2ZEvWwFayMgV9fhPWf
         KxtbImboIZxi2gasd+xhepK7UjwAk8lVTICHCHqJcA+SbspykMWNVRVLvvu9kPy5dHxI
         EUWIUArYT0ys1A809OjI9BW1RCLe6H//cOaZka8mur/HcevC754EhLqtO4+L2357UAoU
         qU2TevLHaDHNKWIsuWG32TkubLoVnnkCaNetEqJa1PJaEC/0hx4RUdKfu3/MDcIepjSW
         dPaGIvl5u9yhM/+8lNRe/U+1trxJmUb1ioj6RM6RaOopI6TerNJ8i95nhspGYu5kgSHY
         OjWw==
X-Forwarded-Encrypted: i=1; AJvYcCXxapTehIGv2WgT26zEj0JiX1o1S0NXJwUduhE2EO7lKsm/Fs7ap9xZKziRYLmdGaU0WulDFAoeoEewN9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZdmQmpIq3kUPuLBaHo6EmJTVZr7zbkxgSFU2WKSrzC7KF2tD5
	JOG0GEy4FLlsO28KYolCPUMe6ejZ52InMksXp7/xoS9zmAY3Ur+IGUgEStF28A3+qdI=
X-Gm-Gg: ASbGncsnDtt6Y7x9iyQEfK7pXVmSfv6jB8kHZ3SkG/XIzlhnkD6oRcNlONNzzQlJfJI
	AH68cDKxJh1L3v5/foEFWP8Fdu1OgR+zfU9N5fTjrOf3lFENX7VL+FDUMLOYljWqQkdKikVslIc
	nhxEDXcSNLr97BAxv17Xf1jJiZbV03XW/0fAm4oBcSGu/07rZodGWbrjtvqr2kXaOD9MZDXGg5F
	7+nC/Uw8mnt90n8RBd0Y+qPjeNfUYavJViiVJYYTpu/7oY6yd/8pRI6CEoomDKNdENcEXqflnW5
	4rKSa+V/ei5ty4WVRA81II+ZVTe388LikX6FnEM31VURzZDi4xh+jWy9kyLlSo+ZBvXX1lmoV5Z
	Mfmp6nKYd3nJHzKw9Eu6nTw0AELMgNqN75wW/56W+9BEOQYIR2KrlqkiHtcI9VSupg4ylYpd5jc
	A=
X-Google-Smtp-Source: AGHT+IFnpncVLFL1UMcg6F8+cSbmKY8VnmjZGbwTIIvXTNMjG9iP3giT0Hpu55FZrPYATzJylT2ncg==
X-Received: by 2002:a05:600c:1d22:b0:456:fc1:c26d with SMTP id 5b1f17b1804b1-46e329a7e49mr890755e9.2.1758724398478;
        Wed, 24 Sep 2025 07:33:18 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e2a9982fdsm44359335e9.2.2025.09.24.07.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:33:17 -0700 (PDT)
Date: Wed, 24 Sep 2025 16:33:16 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7124: fix temperature channel
Message-ID: <apfh25e3k7dpho7dcjayl7g5dpq5lnsuhnc7xhbjlqtfw5lyql@lopr22johw5z>
References: <20250923-iio-adc-ad7124-fix-temperature-channel-v1-1-e421c98c0d72@baylibre.com>
 <h2rof27omrhv4l6pjisdsnvkpb35ovy7e6m4soeltfun5rafk5@oriv7e3egh3p>
 <9e20ce95-a401-46ca-94aa-bd4488b45025@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="orpui3etjel2edtj"
Content-Disposition: inline
In-Reply-To: <9e20ce95-a401-46ca-94aa-bd4488b45025@baylibre.com>


--orpui3etjel2edtj
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] iio: adc: ad7124: fix temperature channel
MIME-Version: 1.0

Hello David,

On Wed, Sep 24, 2025 at 08:17:21AM -0500, David Lechner wrote:
> On 9/24/25 6:03 AM, Uwe Kleine-K=F6nig wrote:
> > On Tue, Sep 23, 2025 at 03:18:02PM -0500, David Lechner wrote:
> >> Fix temperature channel not working due to gain and offset not being
> >> initialized. This was causing the raw temperature readings to be always
> >> 8388608 (0x800000).
> >>
> >> To fix it, we just make sure the gain and offset values are set to the
> >> default values and still return early without doing an internal
> >> calibration.
> >>
> >> While here, add a comment explaining why we don't bother calibrating
> >> the temperature channel.
> >>
> >> Fixes: 47036a03a303 ("iio: adc: ad7124: Implement internal calibration=
 at probe time")
> >> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >> ---
> >>  drivers/iio/adc/ad7124.c | 11 +++++++----
> >>  1 file changed, 7 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> >> index 374e39736584f55c1290db3e257dff2c60f884d2..94d90a63987c0f9886586d=
b0c4bc1690855be2c1 100644
> >> --- a/drivers/iio/adc/ad7124.c
> >> +++ b/drivers/iio/adc/ad7124.c
> >> @@ -1518,10 +1518,6 @@ static int __ad7124_calibrate_all(struct ad7124=
_state *st, struct iio_dev *indio
> >>  	int ret, i;
> >> =20
> >>  	for (i =3D 0; i < st->num_channels; i++) {
> >> -
> >> -		if (indio_dev->channels[i].type !=3D IIO_VOLTAGE)
> >> -			continue;
> >> -
> >>  		/*
> >>  		 * For calibration the OFFSET register should hold its reset default
> >>  		 * value. For the GAIN register there is no such requirement but
> >> @@ -1531,6 +1527,13 @@ static int __ad7124_calibrate_all(struct ad7124=
_state *st, struct iio_dev *indio
> >>  		st->channels[i].cfg.calibration_offset =3D 0x800000;
> >>  		st->channels[i].cfg.calibration_gain =3D st->gain_default;
> >> =20
> >> +		/*
> >> +		 * Only the main voltage input channels are important enough
> >> +		 * to be automatically calibrated here.
> >> +		 */
> >> +		if (indio_dev->channels[i].type !=3D IIO_VOLTAGE)
> >> +			continue;
> >> +
> >=20
> > I don't understand a detail of the problem. The commit log suggests that
> > there is a general problem, but looking at the patch I suspect there is
> > only a problem if at probe time the OFFSET and GAIN register for the
> > temperature channel are different from their reset default setting.
>=20
> What I failed to mention is that st->channels[i].cfg.calibration_offset
> and st->channels[i].cfg.calibration_gain are zero-initialized. And that
> these values are later programmed into the ADC. Programming these to
> zero is what caused reading the raw value value to always return a fixed
> value because the real value got multiplied by 0 in the ADC.
>=20
> Is that enough to clear it up?

Yes, got the whole picture now. Thanks for explaining.

So maybe:

	For channels other than the voltage ones calibration is skipped (which
	is OK). However that results in the calibration register values
	tracked in st->channels[i].cfg all being zero. These zeros are
	then written to hardware before a measurement and thus resulting
	in temperature readings to be always 8388608 (0x800000). This is
	easily fixed by postponing the channel type check until
	st->channels[i].cfg is initialized with the uncalibrated default
	values.

Best regards
Uwe


--orpui3etjel2edtj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjUASkACgkQj4D7WH0S
/k45UwgAiR+/IwqtkNLvDlWTqkhljV24kmmMlrL8zqR713AH7noGbRsPExJCgWMh
yDWolydpKHMNPvDeNmj+jwX/QlVeaaVPbhseK3MVApin3c25RTXqf6+rdOOMW9sK
g8cqiHOYrO+opxcGX09n3q0V/W4MCiOsxlclsytmUu9YhpeIu4seqTM2EccZcWh6
mDgMGMmU28F9wSPIDyhf0e7gFlMzV/l+ehzt4dkGp7GrvcW47rVNzDrooLLrg6iV
QZ3W4QTt2q0TM2pk7vlOTPiA7NbPfPlTd5yrLLKfdXRvzzzJS3uR8DuS2z1SEOs1
ZJzQjHoME//szwP5H/SD6O7CSQODAg==
=lKiv
-----END PGP SIGNATURE-----

--orpui3etjel2edtj--

