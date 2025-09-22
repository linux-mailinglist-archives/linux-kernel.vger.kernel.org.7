Return-Path: <linux-kernel+bounces-826907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AEAB8F9BF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CF5D7AA6ED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E671275860;
	Mon, 22 Sep 2025 08:42:34 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FBE26E718
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530554; cv=none; b=FwfCUgLWuKH2U7Mm34J5XxpQ+EjPBBUyYUEmvu25Unxc0n4M28RyE7XmW2ZnSIlS4UeBLYYu/BXOy1GLumid1XGpvdgQGofjFJU7WHOhJgJ/fj3ateYC4ubcSJykPKoqWht3mKO8/3kYWUDiKLP5vB6QlNWElANQvJ5QM3gM7ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530554; c=relaxed/simple;
	bh=XN4/LFhbuMm965GkjELnsptjg7r/XfEoVb9AEC91U28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XC+MxWGFhns+9PpCsAdcA0fafCq7/61SnogAadWMx4udIqZjARKbWj3HBkZvxJHSzdtgvSI4PYgncqLeMBhHYs84FY7zjlvwUE7ocZD2uJUQNOUI5+HxROiB9xYMcvctcwPm92vGAq2OjBv5NFXCkTvMbclV2SjTk5N5bHdC6dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0c7s-0003Gr-T4; Mon, 22 Sep 2025 10:42:24 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0c7s-002YsO-0C;
	Mon, 22 Sep 2025 10:42:24 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AD22D476BC6;
	Mon, 22 Sep 2025 08:42:23 +0000 (UTC)
Date: Mon, 22 Sep 2025 10:42:23 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, 
	David Ahern <dsahern@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
Subject: Re: [PATCH iproute2-next 0/3] iplink_can: fix checkpatch.pl warnings
Message-ID: <20250922-astute-impressive-skink-36e51a-mkl@pengutronix.de>
References: <20250921-iplink_can-checkpatch-fixes-v1-0-1ddab98560cd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x3xgujmcnlbrx335"
Content-Disposition: inline
In-Reply-To: <20250921-iplink_can-checkpatch-fixes-v1-0-1ddab98560cd@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--x3xgujmcnlbrx335
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH iproute2-next 0/3] iplink_can: fix checkpatch.pl warnings
MIME-Version: 1.0

On 21.09.2025 16:32:29, Vincent Mailhol wrote:
> This is a clean up series which goes through all the checkpatch
> warnings on ip/iplink_can.c and fixes them one by one. By the end on
> this series, there is only one warning left:
>=20
>   WARNING: Prefer __printf(2, 0) over __attribute__((format(printf, 2, 0)=
))
>   #320: FILE: ip/iplink_can.c:320:
>   +static void __attribute__((format(printf, 2, 0)))
>=20
> Because iproute2 does not declare the __printf() macro, that last one
> can not be fixed.
>=20
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>

For the whole series:

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--x3xgujmcnlbrx335
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjRC+sACgkQDHRl3/mQ
kZzBDAf9EL08OmO1nL09yIWV48Duc/h32BfHiB1PnGxkLuZzeIlcjordRFp13KL+
B0rm7+zaoKY0SV7yazUh4Hg5mWoAThE7pXFA8LIECmRLvv1yMhZEr3FRmSP27lKi
Q29lj7wSTOZ5jspbuytco0EpOOgTO0CYAGiugggYSRu2n/3jucMGws10cmcTjyVX
3UUzKGve/5IytVcQLMfILZfPHTjtvv5hOODvgcJos44+kf1rlF8RRbPq9iI1k27t
3l2jLmmKxJ1NGLR95yqR2mO0ZO7/woVlk8DIFBAQrcFD6AHY7UgXS2YVTv+VAZn5
TS1mQnGG3QHVTVwzi5bGooaotOT3YQ==
=i8s/
-----END PGP SIGNATURE-----

--x3xgujmcnlbrx335--

