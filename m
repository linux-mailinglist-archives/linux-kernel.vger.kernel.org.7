Return-Path: <linux-kernel+bounces-866260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3FEBFF50B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3495E34F772
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F600256C6F;
	Thu, 23 Oct 2025 06:16:35 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1635235965
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761200194; cv=none; b=amIUmWZpAkn/lW5oo1E8010mKVoOys3WTN8/pTzgXE0UlyzeoIN2YgUptaTsYPrBGjfogaAsavb2f6ANs8fJrKo4wo5DZUo7Th3XSLKefsr2Z9Zg2bfZoTkW++TK3jwVgwlUOP+2FUYE1Vy9cUz7m9Vm8xGDzObBXO5mbjWibAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761200194; c=relaxed/simple;
	bh=SmHagdJi/kc0HWBalielOXNb19n2G+e+fA4gmDpx0X4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ckrm8MTQ/a+LTxG5gNqPWQhd8WfnpY3z4KjjNgGiTSzTro6YeEpc8v3ykcs1Mfcv42K53hI8iOqgedNc42B8lUKJqTxRSQX+xAnUjFDscXQys+xvtQAJmq3QBFJgM5nOYmlQNjcZ4xRy3zGt/ObYXpHepUj+CGJDiYJArQ3aJMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vBocY-0005f6-LT; Thu, 23 Oct 2025 08:16:22 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vBocY-0050so-06;
	Thu, 23 Oct 2025 08:16:22 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A9E7D48DABA;
	Thu, 23 Oct 2025 06:16:21 +0000 (UTC)
Date: Thu, 23 Oct 2025 08:16:19 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: pip-izony <eeodqql09@gmail.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>, Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: kvaser_usb: leaf: Fix infinite loop on zero-length
 cmd
Message-ID: <20251023-athletic-courageous-pogona-1405d3-mkl@pengutronix.de>
References: <20251023003908.130468-2-eeodqql09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bbbqbdtk5slbsqab"
Content-Disposition: inline
In-Reply-To: <20251023003908.130468-2-eeodqql09@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--bbbqbdtk5slbsqab
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: kvaser_usb: leaf: Fix infinite loop on zero-length
 cmd
MIME-Version: 1.0

On 22.10.2025 20:39:09, pip-izony wrote:
> From: Seungjin Bae <eeodqql09@gmail.com>
>=20
> The `kvaser_usb_leaf_read_bulk_callback()` function parse received
> command buffers from the device. The firmware may insert zero-length
> placeholder commands to handle alignment with the USB endpoint's
> wMaxPacketSize.
>=20
> The driver attempts to skip these placeholders by aligning the buffer
> position `pos` to the next packet boundary using `round_up()`
> function.

What about the round_up() in kvaser_usb_leaf_wait_cmd()? Is it also
affected by this problem?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--bbbqbdtk5slbsqab
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmj5yC8ACgkQDHRl3/mQ
kZyeHwf/bEq5HYbfAU+fAT0wwWb+pPjm0XS/MCMb4NMWIsdvF09IPWx9AEWw7YJ3
AxNwcEIlFXO6IxyfwdBucPZGI2h4YAT4ALDFecin/Kbbu5CCzxN1H08whveBTWXJ
glgN+UJQknnMs7pgRJTZja7PNs5+2+1XkykwK3skOTYznJGGfOX6+4YDULYwKqac
MgsOZwD/qO8s9qTdU8FPFbq0AoQeslfimNqNmoPSB4FgqupF1CxmCMlyS1vqrter
QBVaaSmDoHfwibSNZpLmyCx5FuJfH+THcuEDua2n022md+0s4v5LWxxYQX2v1u5O
2s+q5S8oTG4AvdDtdtzmrH6bBrdOHQ==
=KfyH
-----END PGP SIGNATURE-----

--bbbqbdtk5slbsqab--

