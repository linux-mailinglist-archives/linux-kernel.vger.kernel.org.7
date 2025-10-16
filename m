Return-Path: <linux-kernel+bounces-857009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F48ABE5A44
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 00:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C18303B588C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1657B2E62A4;
	Thu, 16 Oct 2025 22:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="cblxN/lN"
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00642E229C
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760652530; cv=none; b=gFkTQzyhmNFDihh9r7SsFkM+oVYcaVWsn4hk65FhwwRcMN2nKAoMPiAa+eLnIi9Las/R0BFDOYf0RQi1D0aU1jxBxWOatbymHSB85e/PtH53WS/EwWzji2KjpRnlmnjQaymUDkU3ExVdB+TCuJGLLIO8ZfGMVfy43JlazffsZNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760652530; c=relaxed/simple;
	bh=6xXkQoRP59P9/QSzLhB8Pi+zN/sRFE2OjwpBeL58xAY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U6YNTM/UzeMPxX9KQXusBklM23KmnOSp9aq2JKBsXPm7J9E8pygv9jz+DcCrQrry37KN9zAsFkf1GwAhmchaktaKtyUq3l9+IH6kfaxQo3tWYAAq+aUPs5jPn80vLlGO8NenMZXzIYSyJkTuXIiJVk8gmBRES4ZbtHjtZbL5yHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=unknown smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=cblxN/lN; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202505; t=1760652315;
	bh=6xXkQoRP59P9/QSzLhB8Pi+zN/sRFE2OjwpBeL58xAY=;
	h=Date:From:To:Subject:From;
	b=cblxN/lNw7e20nEkHStssOGRuv0pjjiVxNdGrdim49QbiP4xtKLec7yDI77Oyg9rB
	 XvKshoRhxBkzEQv04E2bTPgJV1SoU+RU3oC+crV0xrH60RlYBaS3+lLLxp0DvJNr1d
	 4WDFK3iz3ASGagI7GDZSh17k9O+ldSmNy34aRcWctAZ9AyGktWTFL4hlTqP6un9bfC
	 aeV7+ZRSPfRtIKMFMhBbXizI9qtpxxRYuBRTiHKbhQxlOJBIMN1CaU65Q/u85Td+C7
	 oDYovz9SSvAv9+XUCqu+9XmlBlo2zMxs+ahbU9BokzJ+FV8xSKiFA6NMSKIiliUwhm
	 I8U9oUoM5IpyA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 1B000953E;
	Fri, 17 Oct 2025 00:05:15 +0200 (CEST)
Date: Fri, 17 Oct 2025 00:05:14 +0200
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Russell King <linux@armlinux.org.uk>, Richard Purdie <rpurdie@rpsys.net>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: pxa: unset apm_get_power_status on unload
Message-ID: <6nsmky5xtzyb2kgw26x5sfihrdtr2lmzjev3quohwrckrgm2zh@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kqrnnraapgtonbmr"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--kqrnnraapgtonbmr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The API for apm_get_power_status is "call it if it isn't NULL".
If the module is unloaded and it's not unset,
reading /proc/apm will jump into unloaded kernel memory.

Unset it on unload like drivers/macintosh/apm_emu.c.

Also, use the forward declaration from apm-emulation.h.

Fixes: 078abcf95cdb ("[ARM] 3096/1: Add SharpSL Zaurus power and battery ma=
nagement core driver")
Fixes: b7557de41a04 ("[ARM] 3228/1: SharpSL: Move PM code to arch/arm/commo=
n")
Fixes: 78731d33c186 ("[ARM] pxa/sharpsl_pm: merge the two sharpsl_pm.c sinc=
e it's now pxa specific")
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 arch/arm/mach-pxa/sharpsl_pm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
index 71b282b146d0..cc6eba5419c8 100644
--- a/arch/arm/mach-pxa/sharpsl_pm.c
+++ b/arch/arm/mach-pxa/sharpsl_pm.c
@@ -795,8 +795,6 @@ static ssize_t battery_voltage_show(struct device *dev,=
 struct device_attribute
 static DEVICE_ATTR_RO(battery_percentage);
 static DEVICE_ATTR_RO(battery_voltage);
=20
-extern void (*apm_get_power_status)(struct apm_power_info *);
-
 static void sharpsl_apm_get_power_status(struct apm_power_info *info)
 {
 	info->ac_line_status =3D sharpsl_pm.battstat.ac_status;
@@ -892,6 +890,9 @@ static void sharpsl_pm_remove(struct platform_device *p=
dev)
 {
 	suspend_set_ops(NULL);
=20
+	if (apm_get_power_status =3D=3D sharpsl_apm_get_power_status)
+		apm_get_power_status =3D NULL;
+
 	device_remove_file(&pdev->dev, &dev_attr_battery_percentage);
 	device_remove_file(&pdev->dev, &dev_attr_battery_voltage);
=20
--=20
2.39.5

--kqrnnraapgtonbmr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmjxbBoACgkQvP0LAY0m
WPGw+A/+NnOX9+q6q3bEpQE7Y8XV52SNVJPjJyfnNpuhHdvRKA0VTKCeiryq0kw7
dXgzli2fDC4CUJG3LzkmnnHpgbCBamrIpY8hbpWqRmg2EPdmKvt7A9zfCDbBK1OK
UhRQPD+lwWhVxu/o6mxU2Apb8sFSGwYxGwvyeiLufP/R2va2To2V3VoeC+leFHhf
CAvF63jGoZjwOZJShpthvW+lHoW4TNmnfDBIGd0ZcRuwTXpkKXb+CNm7eqtegA0E
4SQAopfv5MPO9ILKAW9URIgwvDIAtn+a5aYPx74En3vrPLfbn04P4jO+nXSBZgyf
MJsrCEBGHUYCd5TKVrTBkJ1+t7WQD00an5UR9KOVMBhadj5UOGCj1J58zBaj+8ZK
te6pJrbJYqlKnLuaPteVp6sm/q+XsLDeZf7rdle0RZr+4X8WzirD7GJ6qewTzZjK
wOiCkMM+YEr4peRQLZxDaxy2LLwk7SN+cNwAxmxlVpq/EL3r3RRTUbkTqpHrFcDj
e+l0uzCqYXmoft+cj51TX7NydQxTsHkSZzObhCVPvmvs0KwHuulkMbH2xJ1OiiT+
Vnb0UBBpp8tQIAR7MD+yRh0sWyus3IINZTL9132MmNoWtGNNUaRz/Vop8Toyq2AF
BAu4onr7ieruVGHRvBHUQ1urmlK2uXOJjQw8BRtjW+5TqANb+/g=
=qiHP
-----END PGP SIGNATURE-----

--kqrnnraapgtonbmr--

