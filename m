Return-Path: <linux-kernel+bounces-857010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A19BE5A47
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 00:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA195E6EC7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510D92E7BAE;
	Thu, 16 Oct 2025 22:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="gCZ1VDWq"
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFDF28CF49
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760652532; cv=none; b=q8pcgyvS9eDs04rU+RukDwh2Yenm9Cut6wVg7aJwh8SocNufanJwT3LXSS4xwhGHB1fY4S3TeifZHYm+v3P5FbnsB70u50jzWuW/2mu2vkMD1AAhoiim3eXM2MMNLzuR0qfaZky7xcyzB/vrEc+7POGUVlWl9OQgBoDF3lGgGRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760652532; c=relaxed/simple;
	bh=9VBx6HLxYf1h5Y9aM5w6gij9WxTfK4/6Q0mDdPXBo68=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AkkNxBnLJAIxV4dBXYN3BrRgYg19ZfDQ2ngh5Vwg5WRmv0B+SaNltWutz4LsBUkgjgKuE1InyPrHoY+VmlwkojBsc84iljGlPkJN+877xWG50ckjDd+G3rp/VPLouiNspB4xMrPlp3i0tQljFwKjpQVLICxNTF/XDHtWIPd4eW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=gCZ1VDWq; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202505; t=1760652310;
	bh=9VBx6HLxYf1h5Y9aM5w6gij9WxTfK4/6Q0mDdPXBo68=;
	h=Date:From:To:Subject:From;
	b=gCZ1VDWq65B2r6CKSYeh1ncdiva/aUK+hdrrETIVXgJgAwiv484/+2AFAfr462mdF
	 ht9jqkeUSm+yUnoz35Vc+zv2kMSazAVlygmNW7N9YTOSGMI+nVK5ObqDovCmSvIlY/
	 K6bJCjCLrdthucubM+JYulEMaXtjznM3p/4P4TGUHaCtq4PNyAUTWM8BopGdT3eKOW
	 HUSIcf3JUXBRAE5iRnGgpA4w1P2ka4RjMZI+ldPEk8Rw8UuaoOontXtQCtc1+Fp/tW
	 1yrMxl0eMaUvOU2EjVCcNYiuBNrRF+LQGmAKK96axoXXh3R/VKpJkpX/Dv25YDGAQp
	 rYAbLwZpAYxVw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id C87AA9A10;
	Fri, 17 Oct 2025 00:05:10 +0200 (CEST)
Date: Fri, 17 Oct 2025 00:05:10 +0200
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Jiri Kosina <jikos@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] apm-emulation: remove unused __apm_get_power_status
Message-ID: <ba3nzxffdpuz2eo5kbpm5iez2rcdves3qpd4kvnmshxwjburwo@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="enqutmzgj7verk7j"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--enqutmzgj7verk7j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The API for apm_get_power_status is "call it if it isn't NULL",
except it's also initialised with a no-op __apm_get_power_status.
This was added alongside apm_get_power_status in 2007.

The apm_get_power_status symbol is used in these files:
  arch/arm/mach-pxa/sharpsl_pm.c:extern void (*apm_get_power_status)(struct=
 apm_power_info *);
  arch/arm/mach-pxa/sharpsl_pm.c: apm_get_power_status =3D sharpsl_apm_get_=
power_status;
  arch/sh/boards/mach-hp6xx/hp6xx_apm.c:  apm_get_power_status =3D hp6x0_ap=
m_get_power_status;
  drivers/char/apm-emulation.c:void (*apm_get_power_status)(struct apm_powe=
r_info *) =3D __apm_get_power_status;
  drivers/char/apm-emulation.c:EXPORT_SYMBOL(apm_get_power_status);
  drivers/char/apm-emulation.c:   if (apm_get_power_status)
  drivers/char/apm-emulation.c:           apm_get_power_status(&info);
  drivers/macintosh/apm_emu.c:    apm_get_power_status =3D pmu_apm_get_powe=
r_status;
  drivers/macintosh/apm_emu.c:    if (apm_get_power_status =3D=3D pmu_apm_g=
et_power_status)
  drivers/macintosh/apm_emu.c:            apm_get_power_status =3D NULL;
  drivers/power/supply/apm_power.c:       apm_get_power_status =3D apm_batt=
ery_apm_get_power_status;
  drivers/power/supply/apm_power.c:       apm_get_power_status =3D NULL;
  include/linux/apm-emulation.h:extern void (*apm_get_power_status)(struct =
apm_power_info *);

All of them are compatible with the API (post-remove UAFs notwithstanding)
and don't even read it except to compare with their own values;
on a cursory glance this doesn't seem to have ever not been the case.

Fixes: 7726942fb15e ("[APM] Add shared version of APM emulation")
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 drivers/char/apm-emulation.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/char/apm-emulation.c b/drivers/char/apm-emulation.c
index 53ce352f7197..4aa5d1c76f83 100644
--- a/drivers/char/apm-emulation.c
+++ b/drivers/char/apm-emulation.c
@@ -142,18 +142,10 @@ static struct apm_queue kapmd_queue;
 static DEFINE_MUTEX(state_lock);
=20
=20
-/*
- * Compatibility cruft until the IPAQ people move over to the new
- * interface.
- */
-static void __apm_get_power_status(struct apm_power_info *info)
-{
-}
-
 /*
  * This allows machines to provide their own "apm get power status" functi=
on.
  */
-void (*apm_get_power_status)(struct apm_power_info *) =3D __apm_get_power_=
status;
+void (*apm_get_power_status)(struct apm_power_info *);
 EXPORT_SYMBOL(apm_get_power_status);
=20
=20
--=20
2.39.5

--enqutmzgj7verk7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmjxbBMACgkQvP0LAY0m
WPH3TQ//al5it2QDhu4QhEh7AfzURA/VhSRN6ArSAl7I9Ko2EhMhtpaCZ6rKNQlC
W+7CZ/O1A6Osi20pyCPpG5BIhSeU542WNQgm2O0+cYuQBeEwlkQTPB/b/Z00hCeK
Z5iSXB9VMBIH+bUT5ZXDe1JNVtnMsqjU1gyk4bOuYubOMS5/qg5RyPMkjpNxHyTc
mXHJZktepBEIiXxDh2jSOznYvWYKsoM/GMRdfJR4h4ZIaijeCRr/NLg+YO2GqsGr
YD+7TseqZY9b72ib2KTrHsnT/6pcRmi9uHR9/LmSK+A6G+9v6Xne09scb+gyc1yS
MWgTVpYqAWVuZQ1YBT+U0Gk6zUJZMGIGpU0sAEELIJoAViMczcTDk49HOMmlF6wO
+rknsGwAnUCbJ/FsEi1a0xoRZlaO2hxdcvtMA1jxp3KXywxKftiN5VC7UrGKbVaa
ldQ8OOtPXB/wWxsTVkanfkfeDpvexihslMKbap7+iJOiBQauMuYBhzZM7M2WpSW6
L89DN6g0frbLDEAsaXJuvsCD1znrVe2D4evA1W0yIbOlnZMi2rESkXicp1mqTxo0
ZUyiJjDP5XJY7i2iwbTk7LN3E7NyjrEizep/9WHvr/TcTnXJQan2kQIXHDn7sMop
MDjhwktNRlyDWP/3GT6dh1SZ2av5d7g0/uBZpz8ea+FMUxj4Ehc=
=86cB
-----END PGP SIGNATURE-----

--enqutmzgj7verk7j--

