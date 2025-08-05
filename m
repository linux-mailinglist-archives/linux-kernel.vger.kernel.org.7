Return-Path: <linux-kernel+bounces-756821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DAAB1B9C3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC0B165335
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F092294A17;
	Tue,  5 Aug 2025 18:01:25 +0000 (UTC)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54CB1B043C;
	Tue,  5 Aug 2025 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.101.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754416885; cv=none; b=cO6cgGFnsQjICjmSSQrmu0e75161Gja2pa8Hxd43/6ngs3Wf642nh7MyNF5yvMNKySUp2crfJ6OWfpkNEyAhD4WH7SXs4XFOmoW37E3QeUZPCX27/2p5qGVaZcrdOjalCs8588qKPsPJDR8ZyuNkNnnXastXzQ8Y8l7SmgIIMqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754416885; c=relaxed/simple;
	bh=v/LPVoyr9guUgma6ueQgLdA0NQU3TQ2dgvrIbsGqERc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prymTWKRtAXb5CCe8G5zW2droGuxtMQh6O37iX3SdmKvCJ2t2y+m8k+rYcIkuu2K1MULxnbqqDpjlSCaNeDySV4eHz+7DuQXxD7V0LwR+iMgT11aX9Bql5sDBV0g0ErFqeDw7YVJ9aA922VwvM3iv2hDL4jLfwl3ZH3IY46Wxm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io; spf=pass smtp.mailfrom=sys-base.io; arc=none smtp.client-ip=185.233.101.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
	by leonov.paulk.fr (Postfix) with ESMTPS id 8BF8B1F00050;
	Tue,  5 Aug 2025 18:01:14 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
	id 36146B011EE; Tue,  5 Aug 2025 18:01:12 +0000 (UTC)
X-Spam-Level: 
Received: from collins (unknown [192.168.1.1])
	by laika.paulk.fr (Postfix) with ESMTPSA id 7B3B7B011EA;
	Tue,  5 Aug 2025 18:01:10 +0000 (UTC)
Date: Tue, 5 Aug 2025 20:01:08 +0200
From: Paul Kocialkowski <paulk@sys-base.io>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: simple: Add Olimex
 LCD-OLinuXino-5CTS
Message-ID: <aJJG5PU3hIJJrQ6i@collins>
References: <20250702082230.1291953-1-paulk@sys-base.io>
 <175432157672.3671011.14707033702603455664.b4-ty@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gB+aj2eJYR9cQpGK"
Content-Disposition: inline
In-Reply-To: <175432157672.3671011.14707033702603455664.b4-ty@linaro.org>


--gB+aj2eJYR9cQpGK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Le Mon 04 Aug 25, 17:32, Neil Armstrong a =C3=A9crit :
> On Wed, 02 Jul 2025 10:22:29 +0200, Paul Kocialkowski wrote:
> > Add the Olimex LCD-OLinuXino-5CTS, a 5-inch TFT LCD panel.
>=20
> Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (dr=
m-misc-next)

Thanks for the review and merge!

All the best,

Paul

>=20
> [1/2] dt-bindings: display: simple: Add Olimex LCD-OLinuXino-5CTS
>       https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/1da71a08080=
bb5cf5601f237e94c3dd5cede446b
> [2/2] drm/panel: simple: Add Olimex LCD-OLinuXino-5CTS support
>       https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/26232780077=
b3e6147fabb6111afd0bd9a60f973
>=20
> --=20
> Neil
>=20

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--gB+aj2eJYR9cQpGK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmiSRuQACgkQhP3B6o/u
lQyoOhAAmJnQfFcOAssGCV/hD7wAv9KgYX8Ys/d6LwaZdnwgJ+l2oHdv36fH5rq7
JJuYydPP/7DrAWnuSWlI3oPW5I1tEPXeOcY6kTVFVD/4rXRSLRXqPcHw91+BEU6s
20pLAzNvRnjG5zzRugE5rd8CYmtAmINmczEAvzlaCVNWmrg8+wwexsdUKb8oe4mI
T/kVN2JT0aTrosb5wvDSYhanA+Q2GPTUh1HKCm7tJFgVRBwCb6TF1Q/HWL5smGEV
capM3il6vZqKMeSUgc9qOUNnWoZl4zyMyX0AMPboWbxGxTmbormvgwyRpXwuYwVq
Vj/yB3bm3gNQY2fZhBmATGvW20nflldLeFRW44RdSQ5EIsVzJ2U6oq/bhKmYEL9a
MvwBWMjQGY8HdyN4STrq7wkyy4Q2zofeJornKCxU50FYoIy16ge8sHU0SGMfMwxU
EAgNid2nNgY0vYMocwdhugtX4I+ngGHAHA92WC+pKUiVW0v1Pc1lt8xxYjEMGXPG
C++brVvCCS8X3HSPpUmSetYkV4HlOAgzHFip5Xqx1O63lTiCrWxjFWe4JPpRGcad
8QFCW63VkGnbbyrgM0FG0pb4uzPV6CMDR2H1oX5E4E3OyqitWLLmAwLsy6nN5v+T
TEuBRs2vm6wtTOQ+etniDUpo8f9L8hP0er9Jqy7yM+r8knVGYS8=
=ufcX
-----END PGP SIGNATURE-----

--gB+aj2eJYR9cQpGK--

