Return-Path: <linux-kernel+bounces-838741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90FDBB00CB
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 12:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C431F17F685
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 10:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767462C08C5;
	Wed,  1 Oct 2025 10:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NUqiz9th"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1835F2BF00A
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759315442; cv=none; b=PP0Js1myO7xPJe+8xZ08umes9Ez7WTOJoPnMEjkYO3VWUMwNkw7VX84xjHxvMednBZJpPZ/okd+mtmS35Fk/plBoYe5aG4MeHDhXcAhtQDuVlw8MHq7ooHKs/Ucy82tWS7U61DLSLWjt1Da7xQpDcMskVsUg3c8PJ2Vzptmbj+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759315442; c=relaxed/simple;
	bh=AgSkwJRd80VStmQzpr0QeOrgu20AtVP1C0KmVgylgnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GEsCYi38ZmwtiA67PkJuM921qu35OfnpmywPu3KhdIfB29UH/Wg4YXGQWVnw23gw94mWuu5c4gxdOq+KEcFKAu/eFveSDeVTHwjIUKk4vQZNKP1dAB3mD/2M6pHO6XeUez5cM1d+JUafYpCa8bHP3GKxPvAfynD2k+Qjh/xMAOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NUqiz9th; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57bd482dfd2so7878813e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 03:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759315438; x=1759920238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lZRH7mvLyxN+MzFG95XhIKVBdnkVtDrMCoccREIXhU=;
        b=NUqiz9thhTn9L+LZFuSJm5i0/sR/WoX8qQz92Yq/r+y1FaCIYRoF7pz5LFVD1XwTZ4
         NLzEW78S7zm9A6FFeOi6Qk/pwB4TvAYdL3fhf5yrzKMTJL7WLTZHsdPjkhISF6gb7Ttx
         t37NEVY/BKOie4XiDNkTnBBcjuKMBPcffdwFd4Nipmtqm8aurh7HOjg1iYrSAs64mp37
         rCSLBWUnp7X3QY6xKGo1946D1lcfsK3EqUdsbesB1dxPyZwQKAb0wZs15owZU1xKbj4/
         PregIOyLdFgDCSdKGdkShD9W1QC/vHFGQ5N/xGf8ozeNwI58cspGu8fb8U+B7wLBeKWJ
         JAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759315438; x=1759920238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lZRH7mvLyxN+MzFG95XhIKVBdnkVtDrMCoccREIXhU=;
        b=Fq3Deev7q9iCmeozqdp7vgTrnpvjsS3qeZZ2vo+pWgp3LLMLy7FImlLB/KlXi2qvMF
         NH1O413iKdup/WuX+f0rTsYc6EplhwiLMPCDRoGGZVTS05hKML/r9I2VqyRNcqOBp8Hw
         6urG3ixnr17X1dcDNNq4hhACT/FV5DCDeJK63F806ClsmOM46kKPnJV+3UftPk0Ei2rq
         PU9J+mhbOpJqt6/xmTxQfSrzSufDYisw8iDa6GFz9BQwbMIaHkFHhJdt5m7w3RC5p7g4
         tt5FYLECQyRNyZGQzMG907v0eCjws3txtc0zu4IdnBAEm0ryuknoWGHwdkJZWfOgN0QE
         HNvA==
X-Forwarded-Encrypted: i=1; AJvYcCXFFCTtgsIjLLKQOYHy8BtyOIpgTfYKWPSR8UyCDOt410WnB+vfuX3Z0qNpcdb/lAWG2+72RC25GeKvb8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx29ORFP6n/gUD7Bu9sFsX7zChr8SGecZqUWvYVZZWWr1jF1VV6
	xdrVJ0yyBVcAdP02XV9+dE8EKRIKJw1xI6t8+ODiPKZMQ//veZbAJcGglhwA1ahhQlTex/3eV+1
	IGigM/fLPFUzkoRJs3sHWkFYL10ese/w0X/35fvK0Pg==
X-Gm-Gg: ASbGncvNwUoy2i8+L2ratYNjtjGBvc71yBkZLu5Nbr4SJSVg/jLKIMddUav1/wb3zXl
	Ftfelu+TkvME4vIuqzr4mNFm/q8F2jTTP1PRlFMTmeEBvZFTjk/azQIDd+eawvBU0GtQISwF1sA
	88bPeJwttq3qr/u8cquM/ohhE3XM9Yi/bGAbfNtkVqYWS2QQl3f83AHbLYWNNhKWu1WjWOTpH0u
	OQ5wy3SUkWgwD4r+/QDzeM/wPGoi4Y=
X-Google-Smtp-Source: AGHT+IGJ9OoCSt69qSz0S+IZPQ24WcgNAq7AL1kC005K8SJV8OJKe3mHbmPlw9uuhNpvC5T8Eyr0LjgcKU1Qm7+Wghs=
X-Received: by 2002:a05:651c:1553:b0:36f:4c94:b55e with SMTP id
 38308e7fff4ca-373a7487662mr6999571fa.39.1759315438106; Wed, 01 Oct 2025
 03:43:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-ltm8054-driver-v2-0-bb61a401a0dc@bootlin.com>
 <20250925-ltm8054-driver-v2-2-bb61a401a0dc@bootlin.com> <2a503edb-fe9f-4d61-92c0-c1083a028e19@baylibre.com>
 <5015441.GXAFRqVoOG@fw-rgant>
In-Reply-To: <5015441.GXAFRqVoOG@fw-rgant>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 1 Oct 2025 12:43:47 +0200
X-Gm-Features: AS18NWByDMtr1hcTFcPp3qerygswAkBQ0L9YHlvelZDEmKOElWDCvIdZewkZNO0
Message-ID: <CAMknhBHJ8Je2Tcz6yBi1g5tBswoVFXr78tKeZRrfi_9TjLdMuA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] iio: add processed write API
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies if you are receiving the same message twice. Re-sending as
text email so that the mailing lists will pick up the reply.

On Wed, Oct 1, 2025 at 9:19=E2=80=AFAM Romain Gantois
<romain.gantois@bootlin.com> wrote:
>
> Hello David,
>
> On Thursday, 25 September 2025 23:10:14 CEST David Lechner wrote:
> > On 9/25/25 7:37 AM, Romain Gantois wrote:
> > > Add a function to allow IIO consumers to write a processed value to a
> ...
> > > +static int iio_convert_processed_to_raw_unlocked(struct iio_channel
> > > *chan,
> > > +                                            int processed, int *raw,
> > > +                                            unsigned int scale)
> > > +{
> > > +   int scale_type, scale_val, scale_val2;
> > > +   int offset_type, offset_val, offset_val2;
> > > +   int ret;
> > > +
> > > +   scale_type =3D iio_channel_read(chan, &scale_val, &scale_val2,
> > > +                                 IIO_CHAN_INFO_SCALE);
> > > +   if (scale_type >=3D 0) {
> > > +           ret =3D iio_divide_by_value(raw, processed, scale_type,
> scale_val,
> > > scale_val2); +              if (ret < 0)
> > > +                   return ret;
> > > +   } else {
> > > +           *raw =3D processed;
> > > +   }
> > > +
> > > +   if (!scale)
> > > +           return -ERANGE;
> > > +
> > > +   *raw =3D div_s64(*raw, scale);
> > > +
> > > +   offset_type =3D iio_channel_read(chan, &offset_val, &offset_val2,
> > > +                                  IIO_CHAN_INFO_OFFSET);
> > > +   if (offset_type >=3D 0) {
> > > +           switch (offset_type) {
> > > +           case IIO_VAL_INT:
> > > +           case IIO_VAL_INT_PLUS_MICRO:
> > > +           case IIO_VAL_INT_PLUS_NANO:
> > > +                   break;
> > > +           case IIO_VAL_FRACTIONAL:
> > > +                   offset_val /=3D offset_val2;
> > > +                   break;
> > > +           case IIO_VAL_FRACTIONAL_LOG2:
> > > +                   offset_val >>=3D offset_val2;
> > > +                   break;
> > > +           default:
> > > +                   return -EINVAL;
> > > +           }
> > > +
> > > +           *raw -=3D offset_val;
> > > +   }
> >
> > There are some rounding biases in this function, but I'm not sure if
> > it is worth trying to make a perfectly fair function.
>
> I'm unfamiliar with the notion of rounding bias, does it mean that nested
> calls of this function would tend to amplify rounding errors? In this cas=
e,
> would rounding to the nearest integer instead of whatever is being done b=
y the
> integer division here be a good solution?

In this case, the issue is when you are taking multiple samples. When you
look at the average of all of the samples, you will be able to see the
bias. For example, in one of the drivers I was looking at there is an
offset of xxxx.6. Since the IIO_VAL_INT_PLUS_MICRO case is just dropping
any fractional part, the raw value will be on average 0.6 lsb lower that
the requested value. This could be a problem in an application where high
precision is required. But probably not noticeable in cases where 1 lsb is
less than the noise level.

The floor division for IIO_VAL_FRACTIONAL creates a similar bias.
DIV_ROUND_CLOSEST can help there, but even that has a small bias because
values of exactly 0.5 always get rounded in the same direction. That kind
of bias is much smaller though, so easier to ignore.


>
> Maybe I'm misunderstanding what you mean, in that case please let me know=
.
>
> Thanks,
>
> --
> Romain Gantois, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

