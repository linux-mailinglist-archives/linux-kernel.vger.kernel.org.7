Return-Path: <linux-kernel+bounces-848651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B18BCE430
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A4B19A705E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49686301015;
	Fri, 10 Oct 2025 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E/WG3KLX"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A8A86323
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760121326; cv=none; b=jDIyGr6YEDmE9wYTtwOqKfUYZ6ZSkeVopS+Zspiwp1QsuotW+QgNd1qposZCTN9/kQLRXM1VH/fpmmE2J5OXa7PwkqFC4BuAyi1xQAFGoXyo0Pvy9gJcAQ85d8gWt6vVehrPVqQu9DHZSSstpn/kljRV3jx11I0ici2ITrrr3L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760121326; c=relaxed/simple;
	bh=IrzJLT9iyeL7qYoWDmAzmwyBYco3e2Fyxa2T/fvYmP4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rf2z+Y55gvIqg82364fTler1e17GPk1vDh73wg9ONGvrvQo8f+zkIEFeVr/bZZJSCVwX4MnOXxjR5enXOMIY/Eoqa27oQIS0L9FcNMYIEIHwtndXFwQTwjU4w0VfDF+ywbcTGiD6Bvzjw78i07mb3fT4gRmwfLhZN7uwx5ciE1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=E/WG3KLX; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-637dbabdb32so4553382a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 11:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760121319; x=1760726119; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IrzJLT9iyeL7qYoWDmAzmwyBYco3e2Fyxa2T/fvYmP4=;
        b=E/WG3KLX0mo3giyPY++00P2RakGgXok8Qwyqobrs37EcK0+AB9pUZ92/CHlIeGSGIz
         oIt6XG81tH2F89ebXAoTzI9ZWjXfiLT1Oji7ysql0oxi+pCbihdbB4JjYaUHKF2eSLlh
         V0pQDFY75HvTXrsM2n6G8CsjrR5C1ScKh2i+bvZbShhbcC5HLHZpwlI3ap7PLTSlxRhy
         9Yo7lkhSn1IUtKYNTqyuduEJnNmz3Nj2HCzzlFU6zIROnkwt5mUjeQ9P3eW2iumzL04h
         NJ7aPfhl0h0C/p9eTC16SpLozzFL8o+NlSytZNLWzZJvpsB5yv4zBf+C3eHm7caO+LmK
         UCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760121319; x=1760726119;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IrzJLT9iyeL7qYoWDmAzmwyBYco3e2Fyxa2T/fvYmP4=;
        b=Gs4bia2hqgeYpmnWySKgZ5NsycThT1daJ7IfA8MMFgXd1w0U+KzYmqcrB4kBgxRBDT
         QM4nZmqi20RMK7tMv0wUMqqUxAICEyz6VYR3mdSflkGB3fdL+kuW7CoHkKohjTUdGEHW
         HOc6DsCgLFfr6vmvJNxNNSoHfCkzHO+L5QkB1+zjG3rUAjemIGZSz9upJmWpfLm5xQbm
         k4tth16SYLWHaJeNG9ac8QActDjfBq9+d1TJo3r+JgVzxCV9r0GMpHsNBVx7iWD/I8iA
         HkZRFnyc6VKdZ5tie3QUInfIhrMeU9XJ7lWTuhdf5R72H9bhZKmxnNVZcf0Ja0/e0XCj
         QJAA==
X-Forwarded-Encrypted: i=1; AJvYcCVA1TEc/TmTGxeMb7QQlDsuw5BYuEnqSH+4dCKbX2KbwQevCjqGC0So/DwNP2keqC7CPBOZnsetRRZPXjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3JxpOsok9GcRw+IJkyEpDOI/IW8hEYmca8WAnRc9kA2bK/tGw
	QFDTbRxajwJ2S5uJMKeWMZGPRvKDKgMhdVRHgOkOCT7iwd6H4aSsD9H7VYO6RvjO5Z38ussuPqk
	PzSGGY6s=
X-Gm-Gg: ASbGncvR9XsaSUlxmRTBB5hG3yT2HIIKjku5NlC21KTMvMe3vtPHb0rYhmKq3Qf6KnF
	d4K6A2Xq1YuWh7FxwpunMVAB+ZymoUn3KW45npNU9a7CCf9To/Ezf3+dgeTcSnRkoBXrLp+YbSg
	GYVbtk4Dzf989yrFOojX96UyQS7UVJh0Szaoon8AuMlY8XwB/LTb0g3G/8Tsg9LYX9sXuUYqh/u
	DC0V7H27YkkfdF+kK77yhDp0hNp6awYFNUro1djG+k3ujoFWLknRPYgNnN061UFp2ZppRlW5JH0
	qfJfdFuTM/q4uJkT7a/prUt4330p2kdo+5iOM44Qx5jaLDfOVru3iOQzBAgpV6QxyFfehtRUU0X
	cmfQE6eFqinh6BtixWDQUP+Zf3Zk4LI9eJJhfjZs25Z+rp586bIjiYGFwn+fvAqX27ONSDzv/0K
	whfFz9mbk=
X-Google-Smtp-Source: AGHT+IFfvfcLY9EpH48b8KUoBKLc3ABghjOCvKmqW+GJKDAY8JIvC48/YhBRUDCQtcjEqLdQEiiFDg==
X-Received: by 2002:aa7:c54d:0:b0:639:7781:ea20 with SMTP id 4fb4d7f45d1cf-639d5b807bfmr8070467a12.11.1760121318814;
        Fri, 10 Oct 2025 11:35:18 -0700 (PDT)
Received: from [10.203.83.193] (mob-176-247-62-200.net.vodafone.it. [176.247.62.200])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c1348b2sm2872205a12.37.2025.10.10.11.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 11:35:18 -0700 (PDT)
Message-ID: <2039f9bfcadfd9189ecf84b780e1e5542aa0a4a1.camel@baylibre.com>
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO
 batch data rate
From: Francesco Lavra <flavra@baylibre.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Lorenzo Bianconi
	 <lorenzo@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>,  Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 10 Oct 2025 20:35:07 +0200
In-Reply-To: <CAHp75Vd8MmDXm_OPooHC3B+HdHoTn-TvGbRg-C3-gjNSZQoU7Q@mail.gmail.com>
References: <20251009173609.992452-1-flavra@baylibre.com>
	 <20251009173609.992452-3-flavra@baylibre.com> <aOg3dg21aWNTF47x@lore-desk>
	 <160b32c14df3daa06304fef430534561cabcfaea.camel@baylibre.com>
	 <aOjAK9LRMCcBspkb@lore-desk>
	 <9dbd2ae7883ec8dba65706603a29f3144076840e.camel@baylibre.com>
	 <aOkG-jBOYXxWy1z3@lore-desk>
	 <007e87d2-92f5-417a-a6bf-1babd4c60c61@baylibre.com>
	 <aOkysKyWX2hYEnED@lore-desk>
	 <CAHp75Vd8MmDXm_OPooHC3B+HdHoTn-TvGbRg-C3-gjNSZQoU7Q@mail.gmail.com>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-ZugHdSKtu42cytraGbrO"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-ZugHdSKtu42cytraGbrO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-10-10 at 19:23 +0300, Andy Shevchenko wrote:
> On Fri, Oct 10, 2025 at 7:22=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.=
org>
> wrote:
> > On Oct 10, David Lechner wrote:
> > > On 10/10/25 8:15 AM, Lorenzo Bianconi wrote:
>=20
> ...
>=20
> > > In the IIO subsystem, we prefer to include the units in the variable/
> > > field name as well, e.g. hw_fifo_odr_mHz.
> >=20
> > ack, but please avoid camel case :)
>=20
> Don't mix up a camel case with units.
> Or do you have a way to distinguish milli from mega, please?

OK, I will use hwfifo_odr_mHz

--=-ZugHdSKtu42cytraGbrO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmjpUdsACgkQ7fE7c86U
Nl9GAQwAolP2iIbwn+F+PHxtffg9p4cZFn2qiRdUxAOOjGAbO9iRWPP2VPQqf9Kd
1RNFbKjgT1ELCIYLTqMYa08skUgN5SUUmyv1C6W3fe5KswRk2s0GBq0T9Q6ZdSqJ
k+qdSdlCxiFJoG4JXwb24F00F41yftsnExjQ6pswy8Wp9xHwyf8g+uza2gaU31ie
JYgnRBa6dip+mM6oib6J/epjeV2Gwn/RNViQuQj5ucmALw0NlL4YPnF+M1Ts/RTx
Vzr64aWsq9YjxwunC4gxrqFtXQnfBs9cZEtHWYzdew8OHNUfpw7RpLYpxA5wPuKl
K/VpNAJgjZ3nD5zFiPP1YMvvaDEeWusM4CQGz/gOurGpahYfDT/pKNjl171Kd+bL
UZq9WbbU67eqO582A1oc1b2t4UxGywthCpDoSmejdNMYEJZE4+ZwU3w6SUvCoAe+
5mMtrFsE12q+doUKc6s/YBXpCp4PSviDXSPm9XkUu3oDljc0dQs1xzFgt6kWP3mG
IntWiwqc
=2k7z
-----END PGP SIGNATURE-----

--=-ZugHdSKtu42cytraGbrO--

