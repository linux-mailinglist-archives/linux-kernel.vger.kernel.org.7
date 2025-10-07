Return-Path: <linux-kernel+bounces-844661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2587CBC272A
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DE23C7F40
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DF02E9EA7;
	Tue,  7 Oct 2025 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="kzchrdik"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF11F2E7F27
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759863269; cv=none; b=d3Df92J1I5dp+Y+goCq7q2mnqyAZ9pCIV6mushg5CbQvELqWrxOnbvpHWmAErAc67S4/0iVvIH63s2lWUvOIkkkfAhuERp26MkkkQ8iceWLR5+Sz1Y2RdSyxePthPfibNpbJsxbv8s5PuZL8fJSycH+S9QGQISdAAQRMLbWVZjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759863269; c=relaxed/simple;
	bh=fyqYBk39edhoU3hvwcDq4RniKRvu8ih3vY+jGbKyhzg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cfUeib2Oh1ADUe1C+t+UdQK/yc+tQp9TMlqANT6EcZidYCw+4WAfYmbJvjkM7+LAGh8VbfBpu6ewGsQi1noZffgQ1JwSqGr7WGIxIvBuoDgOFMchXls4lt7KCCWeC3PnGYYr0v+gTRjG44QtmDWAjGrt1W6ItqPCwk9iJXsSqcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=kzchrdik; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-78f30dac856so62403966d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1759863266; x=1760468066; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fyqYBk39edhoU3hvwcDq4RniKRvu8ih3vY+jGbKyhzg=;
        b=kzchrdikhUv21qCVt4IxSIPMLRVM4SC76uhM2gu6HjFUkhkzfBNFt29NdwLE8K6k34
         Ml2dBZGS1Blztn4jaW/LGIku4raD5T78ksaC3qXXWuuJ0JzfqTaBFrMlsCNXzItRsc5R
         33yZ1igkFNMfeyHfTp8b5avbMKs+n0GVRSUSBMlsk4ciF/MGq0JcJMcSuhpwTqiuhZf/
         zAQzUE4DvbUW+H1sLQT2HJ9r9Y6jDoyqd1fad1d3ZIWlEVmAreM3KSS+bponKXUgFH4J
         TGlfHQyHMP3eLdkA6Dehqjv3SYOFih9Q3XCIMdiENYA390nFQpYiLWP5BjlkWYWXcz8c
         mSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759863266; x=1760468066;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyqYBk39edhoU3hvwcDq4RniKRvu8ih3vY+jGbKyhzg=;
        b=FxQ86B/82VJ3s3ToFxIeEYMa+rGHoFdKZXDje9Yi/+1EneB/Oe2m6aNx0dU9XS+Ild
         1VP6XXkqudxJDHDAMKDvEG1/p7k7Soyb2V4wx/jw1/7pcByf7Ak4aGkioPpT8l9BSMcj
         vXJADucLiH15H29hxpd4wa6PY0cc7NyJ1GydHQPyxgNG3n3skoj0LeLa9+v8PoIezrGf
         N4xOsL/10+zlwxmSopL3606EPqE3GFe04CjiDStP0sqG4nwJ7UlvvJbb+osXDRtyvrSF
         3+art0BMrZCd871BU53j4B4zJEXlqYVeMueOcY0Ww2n5iFf2IrgtcIxOpzOlSpulYUW2
         cl6w==
X-Forwarded-Encrypted: i=1; AJvYcCW7oKsfxkyWVkl1U67mX7kALS+LBOtdW0p+Tml4KAGrFwfp9Q4D2K2KotJI3tvHMRgwpVKjl+Vs41vsff0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdAouI3T+1V17NMuK1XiLpWHtpuqj5wQQ8otPeQJ5XrxS4N6bU
	uoTqUyOsGC2VmqFPT45GpKhJOCbXyDLN5bL346eHc9oYRmTZ421nPbgIvqCc/6UdOwo=
X-Gm-Gg: ASbGncsqYPjNugb8JKEFKZOxmonGApocdSh2pMU6xt400J4uXWiWGIxdahUwmY/W5b+
	eAMX20xFYDAecdedNa+ES1Ixv9X0huXoqM+LjC5DAoEoW1tvF45PcZ0aXiDul9xE/pOdszvFbP0
	5w/Q8g0jXh6320eJ07kM6zjRwkHQVkBioo/6/2zWgnr/bsONvyg8iIwm9UAW7k6Yh6qRLLJa7Zu
	o3MT0k9/Trg9Lw7u1TkjeEJwCCTFHchOn5DbKxXWRh3r+rDFofzlatZDAi/AGJjTNe9jz919FBf
	P/SZkb4QHlsVjpVa5SLAmnDvZaTNwR+PS5ceT+enPAaRHPuVu5As4OWiDlByPOD1gutTVD6WRB6
	Bu7Syy67q3mVT7HIL+hyPs2Li/anp4Yx2Osiv7Qd56A74mOU/n177
X-Google-Smtp-Source: AGHT+IEixUIOgl0MCHeaJ3U9YoVpppcjNIJi8FhlBiYJXzIZViLBMX0i5qQwH5C+bK/YoahAmV9Giw==
X-Received: by 2002:a05:6214:5012:b0:879:db53:df0 with SMTP id 6a1803df08f44-87b2efe7106mr6252686d6.46.1759863266399;
        Tue, 07 Oct 2025 11:54:26 -0700 (PDT)
Received: from ?IPv6:2606:6d00:17:ebd3::c41? ([2606:6d00:17:ebd3::c41])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878be61f6bcsm146805896d6.65.2025.10.07.11.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 11:54:25 -0700 (PDT)
Message-ID: <46a1915e81b027d1c344eed0477683dd3a68d810.camel@ndufresne.ca>
Subject: Re: [PATCH 16/16] media: rockchip: rga: add rga3 support
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Krzysztof Kozlowski <krzk@kernel.org>, Sven =?ISO-8859-1?Q?P=FCschel?=	
 <s.pueschel@pengutronix.de>, Jacob Chen <jacob-chen@iotwrt.com>, Ezequiel
 Garcia <ezequiel@vanguardiasur.com.ar>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, kernel@pengutronix.de
Date: Tue, 07 Oct 2025 14:54:24 -0400
In-Reply-To: <bf989d9f-9e8e-4acc-b502-1674ce215318@kernel.org>
References: <20251007-spu-rga3-v1-0-36ad85570402@pengutronix.de>
	 <20251007-spu-rga3-v1-16-36ad85570402@pengutronix.de>
	 <bf989d9f-9e8e-4acc-b502-1674ce215318@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-I9QXmLgSnsRRCh9PPEnb"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-I9QXmLgSnsRRCh9PPEnb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Le mardi 07 octobre 2025 =C3=A0 17:39 +0900, Krzysztof Kozlowski a =C3=A9cr=
it=C2=A0:
> On 07/10/2025 17:32, Sven P=C3=BCschel wrote:
> > Add support for the RGA3 unit contained in the RK3588.
> >=20
> > Only a basic feature set consisting of scaling and color conversion is
> > implemented. Advanced features like rotation and cropping will just be
> > ignored. Also the BT601F color space conversion is currently hard coded=
.
> >=20
> > The register address defines were copied from the
> > vendor Rockchip kernel sources and slightly adjusted to not start at 0
> > again for the cmd registers.
> >=20
> > Signed-off-by: Sven P=C3=BCschel <s.pueschel@pengutronix.de>
> > ---
> > =C2=A0drivers/media/platform/rockchip/rga/Makefile=C2=A0 |=C2=A0=C2=A0 =
2 +-
> > =C2=A0drivers/media/platform/rockchip/rga/rga.c=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 4 +
> > =C2=A0drivers/media/platform/rockchip/rga/rga.h=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 2 +-
> > =C2=A0drivers/media/platform/rockchip/rga/rga3-hw.c | 490
> > ++++++++++++++++++++++++++
> > =C2=A0drivers/media/platform/rockchip/rga/rga3-hw.h | 186 ++++++++++
> > =C2=A05 files changed, 682 insertions(+), 2 deletions(-)
>=20
> Your order of patches is a mess. DTS cannot be in the middle. In fact,
> DTS should not be even in this patchset, because you are targeting media.

Indeed, order is broken, though I do appreciate having the DTS as part of t=
he
submission, this way I don't have to chase for them when testing. That bein=
g
said, a link or message ID in the cover later would be as good.

Nicolas

>=20
> Best regards,
> Krzysztof

--=-I9QXmLgSnsRRCh9PPEnb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaOVh4AAKCRDZQZRRKWBy
9O1JAQCgbiRyx2yEWIDJARh2LE+kwcz/R5TwyiD48kcAsBRc3gEAj9DcD7rTLpzu
68L0DpQYyIRrsE94HVozLhgCExOv9gk=
=P0io
-----END PGP SIGNATURE-----

--=-I9QXmLgSnsRRCh9PPEnb--

