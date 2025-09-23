Return-Path: <linux-kernel+bounces-828674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DACAB9528A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE6E2E597E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B770C320CCF;
	Tue, 23 Sep 2025 09:09:35 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A134C320CA6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618575; cv=none; b=TOwtLUgLL4V1VgIESH6j5M5QAcclksXVbrCpEXqN9yCkNoXX1NZac7HUmNZnbibvKXDyT+VYhK2TBOMMwz+jty2f3AFjrf+YXXVaOFrlQoIhXvu06DfMJBYDWAyw45ataA/W0g/+m+n6/v2StZW+PfrFYDzhitWX6O3r8aRJ/UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618575; c=relaxed/simple;
	bh=Wg6qeA5JvtJBCkVI3FEDmgx3vZ3JPNEuaacPIaFiuos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKpIdbWLgfes3nfcfjXPJNY+yVq2ScArniCQm/HMxsk546yEBB88Ur+L9W3/g8W8wqm26JgT8QiEpZvLL2S+mfQFZILmB7Y+E2zHGF6mDaao546rj1GJq6xUjRqaVELYplqo6PckXyEfd01YAV3OCq05mINgOVVvadlMiVVMtFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0z1W-0005cV-BY; Tue, 23 Sep 2025 11:09:22 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0z1W-00049S-0A;
	Tue, 23 Sep 2025 11:09:22 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C09E7477BE7;
	Tue, 23 Sep 2025 09:09:21 +0000 (UTC)
Date: Tue, 23 Sep 2025 11:09:21 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	=?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@hms-networks.com>, Robert Nawrath <mbro1689@gmail.com>, 
	Minh Le <minh.le.aj@renesas.com>, Duy Nguyen <duy.nguyen.rh@renesas.com>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/20] can: netlink: preparation before introduction
 of CAN XL step 3/3
Message-ID: <20250923-olive-centipede-of-inquire-242626-mkl@pengutronix.de>
References: <20250923-canxl-netlink-prep-v4-0-e720d28f66fe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6pefrnj6yyafjhak"
Content-Disposition: inline
In-Reply-To: <20250923-canxl-netlink-prep-v4-0-e720d28f66fe@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--6pefrnj6yyafjhak
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 00/20] can: netlink: preparation before introduction
 of CAN XL step 3/3
MIME-Version: 1.0

On 23.09.2025 15:58:25, Vincent Mailhol wrote:
> In November last year, I sent an RFC to introduce CAN XL [1]. That
> RFC, despite positive feedback, was put on hold due to some unanswered
> question concerning the PWM encoding [2].

Added linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--6pefrnj6yyafjhak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjSY74ACgkQDHRl3/mQ
kZwtWAgAm4beH7tIQYrcP9ln7IWPVaxhZyJLK4gZZnavFFhypmC4G2JZMxf1yIGX
depIogP6C3NLf2zIlQDwaM7SgEU/K+ROdGzQX5UANIJUjO9lccdYF7zNriySCqcl
agVa5vLRH+1JZUZAiVz8Ko55hhfKkMHMn7cz7ddkJJEKizVF6dKbo5VFKI6RxXum
Rt9xLG7icXQaf1BQ74PVXrJhstPQAJHbdxTc+edJ+rRLIgXCNMoTRBiXjQpv/AWc
KZKKPMi5rhLZ8I17weCtNv/djP5PaHpZS6cIbC7w7JXkTW3Qg3f7fw1oWk+8e3E6
NH7EMkJlZLCdohbiLZ8HM0FrkCVnUQ==
=qm2i
-----END PGP SIGNATURE-----

--6pefrnj6yyafjhak--

