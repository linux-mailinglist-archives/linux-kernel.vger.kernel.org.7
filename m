Return-Path: <linux-kernel+bounces-808370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91992B4FEE4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23571BC6337
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2EF33437A;
	Tue,  9 Sep 2025 14:07:51 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28573342CBF
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426871; cv=none; b=UtFxnKdPKNLvYu3rLoSF80tEIua2uFEg/o32hx8yerJBCqxxO5ZvU2QCvSh+lrTdVjGNEbd8FGw9SZrLjQq17N57d7i3QaYIeh2ZVDM0uVmLONw4ire2zn/xZuJ8gKKaebOLqxjS+AsOe3xwbXJORStdJQEcGjZWXAjtz0nJzGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426871; c=relaxed/simple;
	bh=VhoA4haQCmodoJykqHwx55yQ5Wpyj38vfJVNz5fWeEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSj+RiYziRJi17p//lCWP98ue3tF6kLiIOzoFu8QufZsiIT5toQyHLdWA4sAUH8T/7BNbqV3fL+ea2AQ19lvE/lheh1djgXPfSY6BUkp1RUIUBcmpAnoMetRFopeQyuS5GUhMczZtESEXFkISzEQnzHNlzRDqMujqxsGCR6cQ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvz0L-0007xJ-4u; Tue, 09 Sep 2025 16:07:29 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvz0J-000Qts-0q;
	Tue, 09 Sep 2025 16:07:27 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E55C346A0F7;
	Tue, 09 Sep 2025 14:07:26 +0000 (UTC)
Date: Tue, 9 Sep 2025 16:07:26 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Patrik Flykt <patrik.flykt@linux.intel.com>, 
	Dong Aisheng <b29396@freescale.com>, Fengguang Wu <fengguang.wu@intel.com>, 
	Varka Bhadram <varkabhadram@gmail.com>, Wu Bo <wubo.oduw@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH 2/7] can: m_can: m_can_rx_handler(): only handle active
 interrupts
Message-ID: <20250909-warping-blue-pigeon-8522c3-mkl@pengutronix.de>
References: <20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de>
 <20250812-m_can-fix-state-handling-v1-2-b739e06c0a3b@pengutronix.de>
 <DC69H7OUANQR.ZVMFRCS8UF4D@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="76gxjfhmdqyff52s"
Content-Disposition: inline
In-Reply-To: <DC69H7OUANQR.ZVMFRCS8UF4D@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--76gxjfhmdqyff52s
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/7] can: m_can: m_can_rx_handler(): only handle active
 interrupts
MIME-Version: 1.0

On 19.08.2025 10:29:09, Markus Schneider-Pargmann wrote:
> On Tue Aug 12, 2025 at 7:36 PM CEST, Marc Kleine-Budde wrote:
> > Among other things, the M_CAN IP core has an Interrupt Register (IR)
> > and an Interrupt Enable (IE) register. An interrupt is triggered if at
> > least 1 bit is set in the bitwise and of IR and IE.
> >
> > Depending on the configuration not all interrupts are enabled in the
> > IE register. However the m_can_rx_handler() IRQ handler looks at all
> > interrupts not just the enabled ones. This may lead to handling of not
> > activated interrupts.
>=20
> But isn't that happening for m_can_interrupt_handler() in general then?

Yes, I'll add it to the m_can_interrupt_handler(), too.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--76gxjfhmdqyff52s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjANJsACgkQDHRl3/mQ
kZxGZgf/WVi/7W01tVsCCw89JpwOrdg3e4GisljifLdyZOJuOZ3+BMQ8Gp/1PVpK
nEpF3dXzxO8VjmN1XW2PVjszLeZAhGpHZNE++d6CQ0LwgKuq8f3AEej+olbcUIfg
Yz4OQrdSgL7KBNaDosG4o21NU0/u1deoFACW01KsTIFe0azwlWz3YqmZBKahG+5C
ckoWVtHHLiRp6TuMJQS9r2z/iiS0LVxZf8E1nHt6DqeBYA6mktWG3uE62LNHPjEc
yHQ0qDJ6JZjpJmy3tyxG/dedNI4QTpT2X+j4XoAsVEBqLK9v0uhBnWM17fliQ9HA
LScA81E/kq0bzc+qe5gS3opGRkView==
=G+CG
-----END PGP SIGNATURE-----

--76gxjfhmdqyff52s--

