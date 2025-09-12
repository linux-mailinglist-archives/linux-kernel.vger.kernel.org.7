Return-Path: <linux-kernel+bounces-814805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA41CB558EC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 00:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55EDFAC8123
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5356433EB1C;
	Fri, 12 Sep 2025 22:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="JrTuTlC6"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8C127280C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 22:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757715070; cv=none; b=Sqz8NzE9DQgzo6ZHA/rztnrGsq9L4k2jTJw2S75mRrj6rhxsKa1wp5YGr/jGZ1mLN3NgW5sIU84oDvQvV6VRG5bzWC6rovKk+ZkP64YYxaRcipHLEdhpC9VdfhFQidIxU4RcmeaeB3S169RFh/stzeSE8yamA+z9x6C9elDKa3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757715070; c=relaxed/simple;
	bh=Do/QvGbQwHCSoORXG3wZywD4x2NobHezRPoGvcXH1Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dj3mE6nMB4D7GmhuSpWEbP160nXUjhF03IB6DllLxujnVM3XQZRhvhqEIZsNRokBGarS2jp+nRRFlWuOTrpES+6t0Dai10Y9KFUX9QGXOKaYRQItI1hVqlqWi1v1lKbTHceUVEfkPcsxgBpiwSJwsfpz9ycdPl6HIqHbpCGKC80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=JrTuTlC6; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Do/Q
	vGbQwHCSoORXG3wZywD4x2NobHezRPoGvcXH1Dw=; b=JrTuTlC6XmDXRFkkoAa5
	ZcbmsLfNXNeDnn7nmUpkTAwi32rBl8c3FbSkvA5QR/fJUMmTJHk9EoR0P9rMM5yR
	Hxr7u3afuJrz5TvGzmzfRnuNewVW8wP1sk4h2BrzqpR4w6yP3k9VhYxfKfPHY2Tg
	6Qw162y7LK6rV1DRjCsjGV9yKMlEL0gIsUDbYjtZvX7EUuoHSS4cSEHPnOAtHBVp
	bm3kifPH4X7eaGGyHvrJvoLAPvfTutjWe67j7oH1jGqojjK639kwKQ/twj4UbGEk
	UhMZhmCxVBsgvL8kGbSgXVoasF3fSRaIJVJ3IqYD9atMpxnub62gUAzE0Qx2zH+8
	tA==
Received: (qmail 1500904 invoked from network); 13 Sep 2025 00:11:06 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Sep 2025 00:11:06 +0200
X-UD-Smtp-Session: l3s3148p1@J5si7qE+VMEgAQnoAHJ8AC93OVDMgFWg
Date: Sat, 13 Sep 2025 00:11:05 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
	viken.dadhaniya@oss.qualcomm.com
Subject: Re: [PATCH] MAINTAINERS: Update email address for Qualcomm's I2C
 GENI maintainers
Message-ID: <aMSaedMWatJ3agPL@shikoro>
References: <20250826185718.467474-1-mukesh.savaliya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NVXODSEym1yQVLDF"
Content-Disposition: inline
In-Reply-To: <20250826185718.467474-1-mukesh.savaliya@oss.qualcomm.com>


--NVXODSEym1yQVLDF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 12:27:18AM +0530, Mukesh Kumar Savaliya wrote:
> Update email address to @oss.qualcomm.com for both the maintainers
> from qualcomm, Viken dadhani and Mukesh Kumar Savaliya.
>=20
> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>

Applied to for-current, thanks!


--NVXODSEym1yQVLDF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmjEmnkACgkQFA3kzBSg
KbYKhA//RknMf0vFAzMsxg1tmRbMquXwmUb0V0jbGXvLv6KyGmYlJnpL5et2Y+B1
IxdrxeZlld8FKi/vTB06XGZq4tha/04uTGIBzk04sD2z0Uqf+TyHaBikrLOro0TO
EXCfCR+q3F8Zaes3X30OpU/M4fNEO0Z/VyVLArAa4T7eccasa0xGW90jkscDJ/2X
yXd4udCDypwM/glNhhiV2cQ+PjeYiCadulzIl1cKDZG2VGdrKgXzJvhM+86ilVu5
b84OtjqjvuYgjpPWH7h+BU1TveApf4qfR2wqdNotLIynhnEO52+9XjMrNMBej48s
aFxd5Pkdl6zpiaNxZhX1g7PcDT72EGGQS/I0lA9acghPvRzIucvWLvauaxNUd4aJ
KzoV2vzQmHgnumBsPOxhJI1J7Dbh8vtEjss+ETsdPaCgsLpPwv3/gX1lOHix04au
4E2bgLSZ6RuOlDo5Au6XivNoOyMqxRQ3dpRE4fvyn84OZYTQPoOJccZndfcCyW3U
aWUvFdeYuXTglF3qBF2u5lcbmCeGL8H+/tTP17LdzyyBbfNo/DUCiAaEeTBQA+Rw
eGYEIiz9ady81O684ZkUwZsM/q6E7czxufRr9GOqojgTKdcVEvcF4fRpfyKBwP5u
DLMlKDGEVMrgboq1Yo+LJEvygajvjcHRuYW2p62yBKsSEx6TUk0=
=z/09
-----END PGP SIGNATURE-----

--NVXODSEym1yQVLDF--

