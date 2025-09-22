Return-Path: <linux-kernel+bounces-827477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C65B91DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699442A4910
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177572DEA95;
	Mon, 22 Sep 2025 15:12:17 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476BD2836F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758553936; cv=none; b=h17hxcyaOEoJ6euCc0ggK4KBLXHvX1lLZJzFibNS+qJOao8NM37EfvL64kxIfDSPfoTHyDdzwAr0T+RS9/DNHU8EXE+FJ1j4CRCwONIqyXK+lBvlEwq/p8eK/6WI7DHtzZgjZnayaJjxXFcgwUqpdRj2KdcQoqgS4TSkzkWL/Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758553936; c=relaxed/simple;
	bh=LaIN3J/vQ9YPefRubVXI2BAIJgu1RFfWNe2oY4chlAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaVnx97CfLWCYSTJ8KXAKc6CFZ3BVb1eNS1I7dVUUuUhANAZmqXviNATs0w2Fbsr0NkYaCiLoI/R2ByL1HcN/B2cgJD6h3RDtS3NCmye+Dl0xRT7BqUxKshUeppBUfdYZct87LHAN/a9+GrvTi2rWlCcNVJsRt4c0kivzTHpVmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0iCr-0006IN-Ek; Mon, 22 Sep 2025 17:11:57 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0iCq-002c4x-0Q;
	Mon, 22 Sep 2025 17:11:56 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AD4954771B9;
	Mon, 22 Sep 2025 15:11:55 +0000 (UTC)
Date: Mon, 22 Sep 2025 17:11:55 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, 
	mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com, 
	Gregor Herburger <gregor.herburger@ew.tq-group.com>, mani@kernel.org, thomas.kopp@microchip.com, 
	mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linus.walleij@linaro.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] can: mcp251xfd: add gpio functionality
Message-ID: <20250922-ermine-of-perpetual-culture-41ea3a-mkl@pengutronix.de>
References: <20250918064903.241372-1-viken.dadhaniya@oss.qualcomm.com>
 <20250918064903.241372-6-viken.dadhaniya@oss.qualcomm.com>
 <CAMRc=Mf2ycyKbL35bdy5m1WBEap7Bu8OO2Q9AdZYgc04Uynf8g@mail.gmail.com>
 <20250918-daffy-steady-griffin-5299ac-mkl@pengutronix.de>
 <CAMRc=Mfypwopu6daCBzg90i98dbO-7rwAehkiNkA-tF074fO5w@mail.gmail.com>
 <20250922-magnetic-dashing-piculet-97f38d-mkl@pengutronix.de>
 <CAMRc=MdEkp6Mztoe44Nv0orX+f4ops7nh8XS7hbJS2KvQFc3Fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fgd45ycva64pju5t"
Content-Disposition: inline
In-Reply-To: <CAMRc=MdEkp6Mztoe44Nv0orX+f4ops7nh8XS7hbJS2KvQFc3Fg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--fgd45ycva64pju5t
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 5/6] can: mcp251xfd: add gpio functionality
MIME-Version: 1.0

On 22.09.2025 16:49:07, Bartosz Golaszewski wrote:
> On Mon, Sep 22, 2025 at 4:43=E2=80=AFPM Marc Kleine-Budde <mkl@pengutroni=
x.de> wrote:
> >
> > On 22.09.2025 16:28:53, Bartosz Golaszewski wrote:
> > > > > You must be rebased on pre v6.17 code, this will not compile with=
 current
> > > > > mainline.
> > > >
> > > > You mean "post" v6.17? Best rebase to latest net-next/main, which
> > > > already contains the new signatures for the GPIO callbacks.
> > >
> > > No, you read that right. The signature of the set() and set_multiple()
> > > callbacks changed in v6.17-rc1 so Viken must have rebased his changes
> > > on v6.16 or earlier.
> >
> > I'm not sure if I understand you correctly. This series must apply on
> > current net-next/main, which is v6.17-rc6.
>=20
> The GPIO driver interface changed between v6.16 and v6.17-rc1. This
> series uses the old interface. It will not apply on top of v6.17-rc6.

ACK, apparently we had a communication problem about what we exactly
pre/post and earlier means.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--fgd45ycva64pju5t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjRZzcACgkQDHRl3/mQ
kZypmAf+OPO1II+zolxOvU49bEuzELcZ/w0zUYi15K9jRVgsgzyTszm0QWCs9F5k
RhMeKPx5ABC3chks/wk5f3iXEkIk194EKHOI3x3gjcBzGvHI2FbQfXjqQOHcfQh7
UllDjL9TfrFatFTt9PyTNWhuqejsyokBOwmb+otuwjgDyxRkTdYEGmaurZXTfYS0
ZsJ0lSzgiI+JnyK+wN4td5U1FY0VG+uvG02nBWb/MLxHAuJaRNtAQfo76J+FNf05
kLXLTczvfStOfVuIm/fPVCZH1MES81u/rDIIERo5/1Yt0JSx+s3P/Je4PMp/cwik
YmZKhOwuNlrjXfjDfLcEOnWApGIiAw==
=vOMn
-----END PGP SIGNATURE-----

--fgd45ycva64pju5t--

