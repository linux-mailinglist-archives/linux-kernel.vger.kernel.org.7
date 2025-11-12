Return-Path: <linux-kernel+bounces-896787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2304EC51383
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2F024EF26C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E632FD66F;
	Wed, 12 Nov 2025 08:53:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84322FC019
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937580; cv=none; b=YP2/dwP5taDWqimGeitC+oAsEWrz6vr14pzT+0sSKCXiLpZyL4C9WjLxuvG1rvtIeurcmUC2a5aBw00+VTmz8mm7aVIjoAZHTdMiUMa55CieFR0s2CT92qQKg8ZSXVG5D4fORXuxSwYtzheFhg/u9eJ2YUrGzsOtHaQP0j1ElDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937580; c=relaxed/simple;
	bh=EslfWHdR+XW92ZHPUHhcdJqkaTT2B9oFtVsXI6nut1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IR32wNzYiL5IC1ZxVcpNU7mdULWOBJMGQ7NP7FiV4wJL2OrJSN/UHOgLVY+LqfsjGtmIVGHXyX/3jgQvavck9pt8SZLah2STf+9Nw3YHLpDKI9USxO397GHsKdUAOnc6608AsSfgszOpq10ZqmWyo7PaX20TdIJqdCnznruImaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJ6ao-00035C-Q6; Wed, 12 Nov 2025 09:52:42 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJ6an-0003Ix-2E;
	Wed, 12 Nov 2025 09:52:41 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6998949D946;
	Wed, 12 Nov 2025 08:52:41 +0000 (UTC)
Date: Wed, 12 Nov 2025 09:52:41 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: kernel@pengutronix.de, mailhol.vincent@wanadoo.fr, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, cl@rock-chips.com, 
	linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RESEND PATCH v8 0/4] rockchip: add can for RK3576 Soc
Message-ID: <20251112-intrepid-toad-of-prestige-2e67d5-mkl@pengutronix.de>
References: <20251112015940.3695638-1-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tm5vc7kxorjsnqka"
Content-Disposition: inline
In-Reply-To: <20251112015940.3695638-1-zhangqing@rock-chips.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--tm5vc7kxorjsnqka
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RESEND PATCH v8 0/4] rockchip: add can for RK3576 Soc
MIME-Version: 1.0

On 12.11.2025 09:59:36, Elaine Zhang wrote:
> rk3576 can is a new controller,new register layout and Bit position
> definition:
> Support CAN protocol.
> Support Dma.
>
> There are major differences from the previous rk3568.
> All errata on the rk3568 have been fixed and redesigned.
>
> RK3576 CANFD requires authorization and permission. The software
> code is not open by default and needs to be authorized separately.

If you change your patches it's not a "RESEND", but a vN+1.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--tm5vc7kxorjsnqka
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkUStUACgkQDHRl3/mQ
kZyukgf/byzx++cihi0V3YP/622WNyMq4kHAykcsrenUFbYIK6lcjLznqueFBqYI
QFgSFML86Yfyw+jVB3UU4vXbP4Eq4qoqeppCzwQe4mOlYuoarCrjHEla8mtc/IY+
6hzitJnPpN+aahQIDO4KupHNRWnRlJEPmwKLr1ZsjBRfOuG1znCeyKlOco7JKNPe
yIqRdEk8DQcRcXiU8ycqn7/5a2cU25YRK4sdHqXQVLYbLbZ8rey095mIN8A4L5EY
yQKDUcS5pQ/H4cxwPNahP3aDpxqmOO4ut0wAW5hvBaLkpuPwBiLTJ41Lg13rXwKA
6SAfoIhar29+3EGW0YEDV+f6Js+JPg==
=pjXs
-----END PGP SIGNATURE-----

--tm5vc7kxorjsnqka--

