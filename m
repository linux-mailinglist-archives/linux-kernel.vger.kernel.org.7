Return-Path: <linux-kernel+bounces-731594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DB8B056F2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6FA33A1F57
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2410123BF83;
	Tue, 15 Jul 2025 09:45:13 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5862264D5
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572712; cv=none; b=htxakHVQ/+XqXuEpUDvtvKLQ66vdyCTjgcULPbx4x6bkTwQffitOwJTTfm2Ygab7/G0nGDnJWNZJdlTLFqoSq7KBFobwbhQn29SuEdPM8u3ek7oeNZllUPMK1npXHEcXv9RDtrD7m63oPN6aWAkbHZ4JJfl44UIeoN9ot2FYRHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572712; c=relaxed/simple;
	bh=KWOaxjP/bGNjDInQVlB7bR97fr6w9d/PYMDrgGxa8Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CR/9gi6sOndQpt/bTPYGrSLu3c4CWE2UKhvoiRF6wmw09TnLWbkLwdMd6xZyyTcA2LRzDq6QhdWgG/EJz1/vLVu+h5sztXqHa4gf5WzC77OwcLEGNup/xgEFDgGY9gH7LL0WUnHRAn9sC9Xkn9Ke1lqRtfuNANa2tcDySwbXLRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ubcDd-0004mV-06; Tue, 15 Jul 2025 11:45:01 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ubcDc-008YhW-28;
	Tue, 15 Jul 2025 11:45:00 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 55BF6442293;
	Tue, 15 Jul 2025 09:45:00 +0000 (UTC)
Date: Tue, 15 Jul 2025 11:45:00 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
Cc: mailhol.vincent@wanadoo.fr, linux-kernel-mentees@lists.linux.dev, 
	shuah@kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: janz-ican3: use sysfs_emit() in fwinfo_show()
Message-ID: <20250715-idealistic-majestic-goose-1f0486-mkl@pengutronix.de>
References: <20250712133609.331904-1-khaledelnaggarlinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nonvqcqqynx66ck2"
Content-Disposition: inline
In-Reply-To: <20250712133609.331904-1-khaledelnaggarlinux@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--nonvqcqqynx66ck2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: janz-ican3: use sysfs_emit() in fwinfo_show()
MIME-Version: 1.0

On 12.07.2025 16:36:07, Khaled Elnaggar wrote:
> As recommended in Documentation/filesystems/sysfs.rst, show() callbacks
> should use sysfs_emit() or sysfs_emit_at() to format values returned to
> userspace. Replace scnprintf() with sysfs_emit() in fwinfo_show().
>=20
> Signed-off-by: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--nonvqcqqynx66ck2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmh2IxgACgkQDHRl3/mQ
kZz3bAgAqieF81T8iq9I4vH0mpiqkhWao6EwnGxK5WkPhbbJTqP4NPAs9PMpBuB2
V/2GYgNJWaitCLXE/mRLC7F9posbIGZYDLK4gpUYNJc2Ep51QMQsNkrriKx99qmP
NSJ9+qyodWKEW999GLsfn0VOgso02WvL3HESRx+RccoZcaFL+7pK4Tqh7XaQAVwu
8nHrMh9Ez7/PwbSNlqI9Mnv5+ehvEP3/fvPcRy/Sl8daVWqT3KDkCZKwbCIA/wV5
lKEyPDCMnSQCx9RlWPbHmzRm7ycvKblhChQ+Ajjxee1hnP0TQWZSeiiVDoD1BiGj
B/ku6CU1DDEGvAB3SoLX4qS6r7mhAA==
=ht81
-----END PGP SIGNATURE-----

--nonvqcqqynx66ck2--

