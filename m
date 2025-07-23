Return-Path: <linux-kernel+bounces-741882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA195B0EA2D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969A11AA34E8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 05:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11EA2472B9;
	Wed, 23 Jul 2025 05:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="i1Xaz+Xn"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97970182D3
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 05:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753249772; cv=none; b=B2w361ra0etOizcHwOkAkyfLivXCB/V9RTGnlZguDMZCtUHzbqGJxyCL3EYsihz23Hd5k7ioY19+qXvPo8yhbZXObRQXzLDVC2G/SJPitIgFngAkxe8bhmC/eUMU87RjL1n1YSgPTcaVRu2ZdmHRO3nafnGhT8tlxs6thmBsQiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753249772; c=relaxed/simple;
	bh=73p836xKCRq3dwX2rUQysnZdyHxBMQ5vD/ZoRQqOK+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZUeClSAxe3BLQd7ABgUpJYhKHtnNv/gNde/KhhMBWHsQ0i9rGEhx39f1BhnP+4yfeKJmt+4/JKc1Nmrp2+oYP/eabFB8lUoUUM4Vb1bmVynyqVqfYzB2ilJveqRBRX5hlmti0CV6TQxqOP2m6aS08+2cx1qLL+CPWE3XEcxP0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=i1Xaz+Xn; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=73p8
	36xKCRq3dwX2rUQysnZdyHxBMQ5vD/ZoRQqOK+w=; b=i1Xaz+XnY5yNlqafx5uS
	Zo89+wS8+ch0sYXvAO0fpmomiujxw086W3rw4aaJLXoR6IW7eryoNVG0pgQsJbFL
	GQfu0FQhJxDEdZkLXx3a7XvlkuAlFzWCRkshEe9RTtpjSChklONJGhZtrQAxJVx0
	IYDVA4s7asSgnxSbU5xz8wOODWyFW3jYS3haUnilc90MCC1aRcIU0zJcfW9qn7Fl
	o1Ayns88kPQIomuaUeXeHQy5VmfEgnYtUm+t13pVleGjSIoOSKos2xRQ6uDm/IfQ
	qPOfAK7+hqbYnd2Fmb6z5bL28CgHSlg3eWb+vPgG5zG4KG8DReZhntEMMYyNf2dO
	Iw==
Received: (qmail 1581928 invoked from network); 23 Jul 2025 07:49:23 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 Jul 2025 07:49:23 +0200
X-UD-Smtp-Session: l3s3148p1@M/5YRZI61FJtKPJT
Date: Wed, 23 Jul 2025 07:49:23 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	Romain Gantois <romain.gantois@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH -resend] misc: ti_fpc202: Switch to of_fwnode_handle()
Message-ID: <aIB345FIxUqpWWio@shikoro>
References: <20250723053516.1796097-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ejw6P1Wqjqbd2cux"
Content-Disposition: inline
In-Reply-To: <20250723053516.1796097-1-jirislaby@kernel.org>


--ejw6P1Wqjqbd2cux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 07:35:16AM +0200, Jiri Slaby (SUSE) wrote:
> of_node_to_fwnode() is an irqdomain's reimplementation of the
> "officially" defined of_fwnode_handle(). The former is in the process of
> being removed, so use the latter instead.
>=20
> This is the last in-tree user.
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Fixes: 1e5c9b1efa1c ("misc: add FPC202 dual port controller driver")
> Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--ejw6P1Wqjqbd2cux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmiAd94ACgkQFA3kzBSg
Kbaaxw//c+TnPBzyEh80qXzPrZStHmRcWEIIBDifYbDcS0XD8g5lQg17MibOT+p9
giNU1sp27Mok97xy9EVHw7KowYsVTNQx8NYEXdlvzyfHJ2SnFedOZwfTc/P2sfTT
UZpqpSPB85nys1dCzqqrqqSlLWVhUQzSUJrsNnkfo5Lj792Q6VRRd1Gg4I01MWRb
MOzUFVbL/wRYmK5uPllhm8vCB1jGhmGT2h63nQkEcPG+Aks1DrUBIOzwnIFSJSDe
iW13xFDsm5GLsODbTOPt/1mTRV0v9VTVeTfwoCTdpchSR+D9k64j38EoTIbhx4Ri
YlLj34W4XRz+QSG/rgoj2OGcnmM76lcX9sawjqsMSq4UT0U3u3dQydeG8AkCPRCD
J0fzlPYhCdXTZhj61yR7kUT4iHL2uscGf1l5V7lOYhOZopuRZTVL3oQE6VSbXMYp
W/bISmHxRLKsvJdHG8edVYAPg3EYEHlvk4VeQ3wwFII2OgytkWgP92mhcnD/0wDE
6E+FG8dHeKMuq430OZgzgxLyiuB+fMOaUbwipBYh4ePuZ3+A3mRPTu6aqgxxXeOo
+IqOGSEiglI6ByISWA0PFnrvhk1+uEfx+zco44n7XARCRMKPFg5IvEsF6XkelKOk
b+H4jALU5OBMP5rRugFzUB79LDqIA9g0cKImH0vyvv5lbJMThwY=
=a/If
-----END PGP SIGNATURE-----

--ejw6P1Wqjqbd2cux--

