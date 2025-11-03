Return-Path: <linux-kernel+bounces-882552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B98CC2AB7F
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319DC3B508C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91DC2EA490;
	Mon,  3 Nov 2025 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KgOoiL/3"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886252EA14E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762161908; cv=none; b=Igxjlvy3YgVEgjbL3p0JxUd4BLWRdJlQDQXLkrnjKcSn0Nb3xvSTttTi80vwwaG1P4LHf+BnNr92WpqEMBHheaJSqdVtzqAZWYyoOrN3jguxEwZrPG29NBp351ybHivKf9k2rqq0TujxD5cVNTIsIKMFadXG3JOh/Irj8w9rOWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762161908; c=relaxed/simple;
	bh=J8wpUcNN6eKIe2BNft5mcvC6Lwm7D6CpSo7ypNdqnRg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YmsbtnI7/F9V82hXxqtb8R+7BXLXl7vDXvDvp+Xrt54S4yn+y5Ha5/Kl80L3s03XtAF8Mq8EcrwrlBHJE+1i9TjMQYc24N2ZD2cJnyGZ14Bxupm3PT1de+NwbFgoQzyfzn5BtlvmD60KCxi3563Qt4DSM2nvtfEG0cFfsFCCJo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KgOoiL/3; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640d0ec9651so485841a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 01:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762161902; x=1762766702; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8wpUcNN6eKIe2BNft5mcvC6Lwm7D6CpSo7ypNdqnRg=;
        b=KgOoiL/38Rtc+gBugYUplM6MQImn/eksHW+v/7hDUGOdNaqbui3Zibgq6fuSrhxWsX
         5f27zsZJaevPOgMQFFOuH39EXGDOQed7O5WIJfkgs7vCsB8oqIzUeM2RDlRbw4HZkjCh
         GQ1NE1AxHA8gtomYJsZTV5id+0K8kKZQzUySeEh7AjXwcMfhnKf972K/wzryOxp118kK
         7hBndlOoG7u7BSZsY/fy1I7XK22rw5ab1tRPZyiRB6THvJipbkoiJRgPNhA+ST5zWaEW
         89PsnG8ZfDdJFVHhhtZnZoEvbhKM7GN8/k+XT9MxvbjlEeS/1g7B+GDHJ3272RiDJh9r
         4+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762161902; x=1762766702;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J8wpUcNN6eKIe2BNft5mcvC6Lwm7D6CpSo7ypNdqnRg=;
        b=K9HjAdWFVVmXfTciPr8UgLKgclcVbUw0oaWQFnZTDryxpx8m3AxcJMVBMlIzJE36pq
         GjjCLn83O1Owd5DDlP/CDNtuO1Wg0yQQo3XRIKEE+s40sUinId3NZrW5TAyiAHD4cpTg
         jjbdDbjAxEoast7YcPisDCniGi8g51FaLXIINCYjOBvA1mFUz9GaoMBD3RSC7C9LTkMM
         DoYhqmdZpMKz67reml0ZDUQ3zLoSn5xj0rdUqKhpt11O/U9C3OsszNgm3A9/Bq2kLeG8
         z+hTQzOU/aqmFYXsTiKaZmeSnCE16hPvYk3rtDcX6R8kIMAo3gCg1pKQ0LOGFkQs5SUg
         IkSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbrUZG+T/JwoI17RU64tTcAc3fAtzil61fWhIWjIkd7ulrAs+DkOhiUQ73Spm+mi4dQT0Jpro+R0LWI58=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlxzlE/7boZkxN8dwGdM8xCO8ccDHVYYfyefZUmhG8AbSCmhc6
	dHNvrV8wfZtpXKA5ChciK/4sA/f99Nhqc6AgvHoxosA9tfz4569unTCkum6LiVjUV38=
X-Gm-Gg: ASbGncvvGmd7JMiRO2qqxfJViT9bigf3gZmDPlU+AOwCLlbv/Xf4RV/lg0MNsE/7d02
	AEJhn9Map2NYP2+LW5G7BYpGQDjSuxZ5hACTV6F4oMqocG5eU+MkiUCdZmpVdfMGEP1Y1iQDefH
	jkVXPGmXQSdkUjKU/wEIoSiUycewgEhP/6V1Vk9ZlSnRUYfFml9bLB5V3qouvPJaawVi4+vnj05
	u8LlZYOVeWADjts4W2jQFqX1S6hGdN9yOl5BJffmy3IWBCFrzojtjqr4R4Hzk6P7FadTTh9TY9Z
	Czuj7rVYK7Kos7xbpmZ4dA9793D8eQpQo+PUj57QqsjF8jOa1nxXIt5XwfKmj8/Jp2mSSMVWF1v
	369tr0KvJBE7h0RGqBfBDa3JAAwztaSMQirNQhuN/H1vy9APEx10sNpsFdsMxHn+7gBAAE/feGS
	8lPpmZGNY0W1OnbOCuObuagC+SJIHd9ubJAS3l0naO/8R3KuTFEg==
X-Google-Smtp-Source: AGHT+IH5hULo+8FDQ2WYcjV+y6dq0RuxLkwQQ2iO35o/+oBwlQsLx4u0zvThA0iUaycg5B4WYA5Ppw==
X-Received: by 2002:a05:6402:2750:b0:63c:683c:f9d2 with SMTP id 4fb4d7f45d1cf-64076f78d17mr10299643a12.12.1762161901830;
        Mon, 03 Nov 2025 01:25:01 -0800 (PST)
Received: from [10.203.83.103] (mob-176-247-82-42.net.vodafone.it. [176.247.82.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64094ec0921sm6848587a12.11.2025.11.03.01.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 01:25:01 -0800 (PST)
Message-ID: <87f68357d52fe6406bab42d5bfb41e4addd9d301.camel@baylibre.com>
Subject: Re: [PATCH 1/9] iio: imu: st_lsm6dsx: dynamically initialize
 iio_chan_spec data
From: Francesco Lavra <flavra@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 03 Nov 2025 10:24:54 +0100
In-Reply-To: <20251102111648.73422267@jic23-huawei>
References: <20251030072752.349633-1-flavra@baylibre.com>
	 <20251030072752.349633-2-flavra@baylibre.com>
	 <20251102111648.73422267@jic23-huawei>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-MnvrRlCym1HWP7zf9aXq"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-MnvrRlCym1HWP7zf9aXq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2025-11-02 at 11:16 +0000, Jonathan Cameron wrote:
> On Thu, 30 Oct 2025 08:27:44 +0100
> Francesco Lavra <flavra@baylibre.com> wrote:
>=20
> > Using the ST_LSM6DSX_CHANNEL_ACC() macro as a static initializer
> > for the iio_chan_spec struct arrays makes all sensors advertise
> > channel event capabilities regardless of whether they actually
> > support event generation. And if userspace tries to configure
> > accelerometer wakeup events on a sensor device that does not
> > support them (e.g. LSM6DS0), st_lsm6dsx_write_event() dereferences
> > a NULL pointer when trying to write to the wakeup register.
> > Replace usage of the ST_LSM6DSX_CHANNEL_ACC() and
> > ST_LSM6DSX_CHANNEL() macros with dynamic allocation and
> > initialization of struct iio_chan_spec arrays, where the
> > st_lsm6dsx_event structure is only used for sensors that support
> > wakeup events; besides fixing the above bug, this serves as a
> > preliminary step for adding support for more event types.
> >=20
> > Signed-off-by: Francesco Lavra <flavra@baylibre.com>
>=20
> In cases where there are only a small number of options for what the
> channel
> arrays should contain, my normal preference would be more data over
> moving
> the complexity into code.=C2=A0 That is have two struct iio_chan_spec arr=
ays
> and
> pick between them based on availability of the interrupt.
>=20
> I haven't checked the whole series yet, but how many channel arrays
> would we need to support the features you are introducing here? That is
> how many different combinations exist in the supported chips?

In the current code there are 3 struct iio_chan_spec arrays; we would need
one more to fix the above bug, and one more to add tap event support; so a
total of 5 arrays (each of length 4).
As for struct iio_event_spec, the current code has one array (of length 1),
and to add tap event support we would need another array (of length 2).

--=-MnvrRlCym1HWP7zf9aXq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmkIdOYACgkQ7fE7c86U
Nl+o0Qv+L1+kfzgrRneLLXOc6I57yrBmlGbdoXM7PhnsMsoM78a2fFO+EYxJFd03
HFVM63v6jyl14NDLXiY5YX3XoaMDCdafqimlBYX5EbqBBXzALeyLjAd5ZYwDBfc/
YBdFYRwKAOxwbSN/nLB1nqbNf3vpzU+mZRArVLz/AeyQQXAgpPmKXee4HzXb0nko
af7ywKzE31Y6XznU7887dRt9HyuGqzE1qzb5CBEZqjaULhCHzpqIpdMnlVpMwFjD
87Ff1q69NuNiJW153aakIYHQaZFd+olGvAWZChmaUlNCEsUpzf/sySDdiz2GVnrR
zZ5GP+a6/njT7AJtKCsYbrqmECMR5NsErlHDCAkanTUvuAtoR8p7EXrunHDpleKk
5lhli1jyQNRTsdskptXSJ8PdSogB0noRrIe/E4EAOjHS/bQ4UuIxt18nLSE5KKJI
pHj04/HaNglVynOq/uYuzfkDAkfOei/20P3RpFJHhuBDIdIx+doSmyGlOOpMIy+0
u0RTrkCu
=ZdQR
-----END PGP SIGNATURE-----

--=-MnvrRlCym1HWP7zf9aXq--

