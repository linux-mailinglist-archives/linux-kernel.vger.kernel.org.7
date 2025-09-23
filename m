Return-Path: <linux-kernel+bounces-828539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FACCB94D66
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 561314E1E5B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4523164BE;
	Tue, 23 Sep 2025 07:43:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D775F3164A1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613392; cv=none; b=NpnjSU1C5+Wb6E3Asxrfh9cQtvbz8/KwrH6qFnrl8hju++b6uWSTlr0zp2bqJBYLez6hqeYIb2vYah32G7DcekPwbj+9BVscBBjqedsct7OdW8SeV8EGOCzE4SPb13Det1zmjoIAayQaGeCJMP+fXGiVFr4sEofvku//rpcVt0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613392; c=relaxed/simple;
	bh=b3UrihDRIZA8F6HQof9Y7H9neVW3A8WWd1Kyat7rAlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRHXJ1GO7j6V7k8ADMpFKhAk/vk0nhQEdhXO5ulJilNLo02x5zzUnUAxYJ4YmBNIqst/edydlKm3fwEYOv0ZTy/5QFQjaKTscOofgsDKwiua7iEwPZPhqkCMcAIqqmZALTAwJi4+uQ4WVwxmTpBLFI55QjB4hm5HHvu/4AYo7ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0xfh-0003cg-Dt; Tue, 23 Sep 2025 09:42:45 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0xff-0003NS-2V;
	Tue, 23 Sep 2025 09:42:43 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 24ABF4779C9;
	Tue, 23 Sep 2025 06:57:17 +0000 (UTC)
Date: Tue, 23 Sep 2025 08:57:14 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: kernel@pengutronix.de, mailhol.vincent@wanadoo.fr, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, cl@rock-chips.com, 
	kever.yang@rock-chips.com, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 0/4] rockchip: add can for RK3576 Soc
Message-ID: <20250922-charming-resourceful-caterpillar-d47761-mkl@pengutronix.de>
References: <20250922071543.73923-1-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="as43upblxqmnobgv"
Content-Disposition: inline
In-Reply-To: <20250922071543.73923-1-zhangqing@rock-chips.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--as43upblxqmnobgv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 0/4] rockchip: add can for RK3576 Soc
MIME-Version: 1.0

On 22.09.2025 15:15:39, Elaine Zhang wrote:
> rk3576 can is a new controller,new register layout and Bit position
> definition:
> Support CAN and CANFD protocol.
> Support Dma.
>=20
> There are major differences from the previous rk3568.
> All errata on the rk3568 have been fixed and redesigned.

=E2=97=8F 9550057c4efe: net: can: rockchip: add can for RK3576 Soc
  =E2=97=8F checkpatch.pl: drivers/net/can/rockchip/rockchip_canfd-core.c:2=
92: WARNING: void function return statements are not generally useful

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--as43upblxqmnobgv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjSRMUACgkQDHRl3/mQ
kZwilwgAhBRQy2zPv/I02Kws1RfbW8BIiG7My+w4HUDEO2nxf6mBsMyGVqg6JCs2
fXbbzIGaI463/UBdj8EWwZvd11i99LIzikSvrFir7eEGr92tJ6YvdcKDzs40p8Wp
w16+ULDgSrcDO6z5Q8tHwid2gy4W+ZBOC0AD5Ckp5RMbX0lwUWSy1ilXaKetSQMT
qj6KsySbfgfwDeZDSWMc+6ReB2bMjFXFxTpLCDb5j6m9HaVrhWpj+tekJQO+AX0g
is3jh6G+VB7Prr/VI2312a/9bMnIInEYLcjiITUgk2eTR3klze4C4XPuv4kcSEkA
ijb+dmG2vzdoPZpxSzAM0+04TDg/UA==
=vfsm
-----END PGP SIGNATURE-----

--as43upblxqmnobgv--

