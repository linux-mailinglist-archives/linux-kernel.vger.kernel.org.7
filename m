Return-Path: <linux-kernel+bounces-847849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADC9BCBE23
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D933B4986
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AFB271A71;
	Fri, 10 Oct 2025 07:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T4Ne4usu"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1FD270EA5
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760080392; cv=none; b=hzoAg7X834IJRQlXqg0fDMYZy31miKj44Ttchw9t8UOd1GfdxekAUF8SasUyqfGTXS+3DNh8wA4hkzsSM+kgzaogVKSYjp+GOoruc2uTA/O06X4NuQe8+E+ObZSTTGW8AmZdlsQV8lIyQTvrwk3kX+64TYiSPEUHmtWL1JOQ0Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760080392; c=relaxed/simple;
	bh=h1v74N2ewlsKvSOCrLe73G+CWDpE256Nda7B/T/OqYE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h94GATTmlG5qeIveOtNa7HZutIHaaKcCjzn01Xpbd+tGdpvlfxtLw1yGgKejml+9YArAKUEld1aI9xhgW+8zVaB/rQ/LOUneGq0YXq1ee6ozp2HiQ+NXcDUP4LZuOn79WdB/FiCrr/nB6qGoAUWFp9aTjNEHR3W+EGjjAt32NA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=T4Ne4usu; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62fb48315ddso2510875a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760080388; x=1760685188; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1v74N2ewlsKvSOCrLe73G+CWDpE256Nda7B/T/OqYE=;
        b=T4Ne4usuq7ycvlPN1ogsdgqzCXs3Wo9SOFT3N+LRTHsv/DFKCnFxpAvMgxbSRlljtU
         kLZjZeNsHlBjzgvUrWePjvVFL9z37rhwQNPc2TaQ+7m0osILjw7cIAW3XopC3pp5P160
         JMhJA+13qNPjBq3wNZpuLOL7m1PpILbDd2Ddy4+SeXRouXYFhayUI5lCPhYj0vc79I5T
         eQDQuUi5taVhDMjLFWdxYv2HLDCL6wTeR9V8+hwnnSrMe3/ysFNT2bqU8Ef9oiw+CwWk
         Frn1hKG5E/ywnUXph6iXRe1W1YIFKayz/1CxIHJtrOrjbuBy9mV0oe5O6sewBRvXItSk
         y24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760080388; x=1760685188;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h1v74N2ewlsKvSOCrLe73G+CWDpE256Nda7B/T/OqYE=;
        b=c9V1ozsoAArMVZMz+6OKs5vAKyTK7L9wqwff+sSVqB+pbZojo85mnVvlTVHqlhvgSu
         JEdc4RZeYbwnx5r+LKnANOy1+u3A7UgbDsSBK0BbkIlJGpqtVuchU7ZjACgw7Ne4YH1/
         XlCS3J+XRPO8Nw+RUhgLjk6dRtCA8dMMktFGQ7ShXHIhS6rXWXakuN0yLGUD7bc3ai79
         fONuboom7b+Lqo35lkykO88LHmYOPZmRL1OqaQ2ALIXyUjyMWqoW2Hxq1+Hu6Wfo3k1Q
         +cTGH+BiAPylBom3VdxpDTQIPwyeGmPEtIVuaV2HhZ4SN7qeos/iHOOBjQbq340PdBLP
         CXTg==
X-Forwarded-Encrypted: i=1; AJvYcCWquucWSyIBLy7Ngiybmw9yd2TKMJ1gYahXSVrAzlBXsQ5gsVCePhsxJeyW0LYbjwU2hIvavB3NdopRbnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsXY1xvr+fwa/bWzxNutENBwUIjSKwuCYJCRmbZaO9Vry1Gmox
	4eGFReSGn34QNsR3quTqDnkoKthwlIbZZkT+MCIGPGECmWJzQpCk8I5jHxhs7C+Mr2U=
X-Gm-Gg: ASbGncvPzmSDRH+MGJgoVBGcLQH5gJtjtoUObnjiZECuJ99XmqJeqtvR7yofVE5Y7lU
	A9wGznUJS8x8xzmkzKgP7ChhmPIwu4zzjEpCk2lbOv3Hc8smP1EkPXGvq1RXRRMNtUuVNUEowLn
	nBwocneT+xi2ED463ax+xAsjgrvhAPSUhUXClMkqhGQ/xfvWjlZszSScPIYELXSCi6anmLfYmg8
	GGbK+n5fqECPWNtkHWoYE1NbmhrsutHNMiiTqPo+DI77UvxKWpqIHxFuvWrBr1ZtHDqeQftCfU/
	+dCayvFnq9oLI3zciGhoE5TaoTSbStBsRN8OIc4szXCas9s9B4MzZyg75Q7Xwga/yDC4/C8Yd1v
	f6bGwRHcno/86LD4pJ2cQtHux/g==
X-Google-Smtp-Source: AGHT+IH+QnEQG5+KkCrkp8dET1zQkhQ6IOwln/X6HVIeh1GSPEnWGCYqoORC/XoORJ8JMAQGmDmMvA==
X-Received: by 2002:a05:6402:5248:b0:634:64b3:3900 with SMTP id 4fb4d7f45d1cf-639d5b6ae58mr9108127a12.9.1760080387581;
        Fri, 10 Oct 2025 00:13:07 -0700 (PDT)
Received: from [10.203.83.184] ([151.37.201.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c321341sm1587808a12.38.2025.10.10.00.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 00:13:07 -0700 (PDT)
Message-ID: <160b32c14df3daa06304fef430534561cabcfaea.camel@baylibre.com>
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO
 batch data rate
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 10 Oct 2025 09:12:56 +0200
In-Reply-To: <aOg3dg21aWNTF47x@lore-desk>
References: <20251009173609.992452-1-flavra@baylibre.com>
	 <20251009173609.992452-3-flavra@baylibre.com> <aOg3dg21aWNTF47x@lore-desk>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-jIKXFv+B4kt7GmFEgaP4"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-jIKXFv+B4kt7GmFEgaP4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-10-10 at 00:30 +0200, Lorenzo Bianconi wrote:
> > The rate at which accelerometer or gyroscope sensor samples are fed
> > to the hardware FIFO (batch data rate, or BDR) does not have to
> > coincide with the sensor sampling frequency (output data rate, or
> > ODR); the only requirement is for the BDR to not be greater than
> > the ODR. Having a BDR lower than the ODR is useful in cases where
> > an application requires a high sampling rate for accurate detection
> > of motion events (e.g. wakeup events), but wants to read sensor
> > sample values from the device buffer at a lower data rate.
>=20
> can you please provide more details here? Are you using the hw fifo to
> read
> data? If we configure the hw fifo according to the BDR (even assuming the
> watermark is set 1) the hw will generate interrupts according to the BDR
> (bdr < odr).

Yes, I'm using the hw fifo to read data. The use case is to enable event
detection (which works best at high sampling rates) and sensor data
streaming at the same time, without requiring the data stream to be at the
same rate as the sensor sampling rate. So the amount of I2C (or SPI)
traffic (as well as the rate of periodic interrupts) required by the data
stream is kept to a minimum without sacrificing the accuracy of event
detection.



--=-jIKXFv+B4kt7GmFEgaP4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmjosfgACgkQ7fE7c86U
Nl9LHQv/Xrl17Hl2tzUXxY2e6WTPUKffw0uAhKJsPon/Blu+ebOoFFyvSaOILfAv
I55gUWjvKFWSpxG3X6wldvNBr0O1LsURO1MPGaWNC5YA6QkHT8KS9d95UclYOkAR
2kfz6MWqmJgOFUhfpSz8PyoVI/9d+JnTwcf9rupFoIA/GJap+bqGQGZ9xHuLeuBr
OXxAw9Rqe0m5gtHoMumccnHZGHVbVPC+P7K6vPuSr8WO2ifoZkIah21EPI2A++SH
8eEPqRufUzM2BoYd7RuUjtBMuZCKftqqA7xfhLn3UodYK/omeo4ucwDMOuQn3FNZ
ErrnbGt9dEkzQ7qCSYgBSAjSsoVXQZJ20tLquiJgM5fk4nCl0QaG0D1c198n3fR6
79IBho1qN7nDo4tzSOfkZmskCXGnzZ4330KQUoE74D2dTst5Km6bjgTH+eieUI3u
iStw47YgETXDqp3fNEvQl1cLZ5pyhSjnrdR7P2yYnLyRSoZftZ4BFVSfe4WT9TIl
86rjc1Sd
=UmNC
-----END PGP SIGNATURE-----

--=-jIKXFv+B4kt7GmFEgaP4--

