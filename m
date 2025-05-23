Return-Path: <linux-kernel+bounces-660901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5354DAC2393
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 15:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C91E3B9E36
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 13:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B55B291163;
	Fri, 23 May 2025 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="g4m8U/u+"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D3E4437C
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748006258; cv=none; b=jS5Hcf61fhgWtNs46vjwlfTAhxgnLt7Reo7OAkkBZX+XpFWs68vho71agLkBmbiIPv+I2xbHm6YjQQxfe31HseLwmqhFD0CooEODypXDh4P3Ofn+vZbU4zZ7Aw/SNYloqP0Vc/ZhkI7659bACURLDEvl4B27yQeV72PjjHge4Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748006258; c=relaxed/simple;
	bh=s7FKmfnt3j9otfDhlONhzVebzNJubqL1vlpgOU5y99I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4d+cnP3s61cMU9mj6tyMxoVb3dpdxSLGUQgPHIpNcZu7T3XnTG0Q33gzOBVnQQTZfkhJ1e5N3IdEHJqC1KE57Zpnqu9co/5gk4CW9sHVGfyWX8ahSKP9Aww+CaCCoypNHJrrdRUOxAyQdZju3a+Pfwa2NVVI48sJQadpsY4gnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=g4m8U/u+; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=s7FK
	mfnt3j9otfDhlONhzVebzNJubqL1vlpgOU5y99I=; b=g4m8U/u+zpjSb85r0t3f
	G2uSqztrliE99E9hzHKnWUTF5ZLHFZbj+ljpyj5figknh07b5+gts+o802TrCQ7Y
	u9PQuKcaLmxtV3jo/sdrVPpe9rJh7/YzWpTw5RbvhFv9U+LM4/WODVtVO7reSj0y
	SZWqbidY6MQ+vEn1tkEAEHE8DwniRPNMhwgXTz6SCDgbRNFsWggghhNRNZwkBXRF
	HS5wO2j9kZcVPekeqZK44UPqRE/CHQBluITc1pL3ZnaEd4XgRec/HjzfEWWev1nR
	dhdL4wbE/+5fVzGs1I3Ex0o4NR/A2XHJP3mMTpfDrzjJURJd+B66RVp0BhlZIDpj
	dg==
Received: (qmail 4052540 invoked from network); 23 May 2025 15:17:34 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 May 2025 15:17:34 +0200
X-UD-Smtp-Session: l3s3148p1@Z8baa801bMdehhrS
Date: Fri, 23 May 2025 15:17:34 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>
Cc: thierry.bultel@linatsea.fr, linux-renesas-soc@vger.kernel.org,
	geert@linux-m68k.org, paul.barker.ct@bp.renesas.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v9 06/10] serial: sh-sci: Use private port ID
Message-ID: <aDB1bm01fuUkk0-U@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
	thierry.bultel@linatsea.fr, linux-renesas-soc@vger.kernel.org,
	geert@linux-m68k.org, paul.barker.ct@bp.renesas.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20250515141828.43444-1-thierry.bultel.yh@bp.renesas.com>
 <20250515141828.43444-7-thierry.bultel.yh@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7Z6tc/8G+wfrnnQj"
Content-Disposition: inline
In-Reply-To: <20250515141828.43444-7-thierry.bultel.yh@bp.renesas.com>


--7Z6tc/8G+wfrnnQj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 04:18:21PM +0200, Thierry Bultel wrote:
> New port types cannot be added in serial_core.h, which is shared with
> userspace.
> In order to support new port types, the coming new ones will have
> BIT(7) set in the id value, and in this case, uartport->type is
> set to PORT_GENERIC.
> This commit therefore changes all the places where the port type is
> read, by not relying on uartport->type but on the private
> value stored in struct sci_port.
>=20
> Signed-off-by: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>

If you promise to incermentally add the stuff we discussed, then

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

;)


--7Z6tc/8G+wfrnnQj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmgwdW0ACgkQFA3kzBSg
KbYCaw/9GEz/FLucy3l5sEdql+ARAfsRci4eTKis9U29FXYUX04AGvMZi2fpMP6t
K5+f2N+NyEnJdKH4S1fyzbmQ3/FRdEyaThu7ol5KGaMs/G+RqBMI3HKib7C0ZPUY
X17NCNNriMPrqV7tRdQ2zsrpomCGJ+Nwn2nTxELr11hKNny5xOD5UrPb/S4b+qtT
030MgQ7CVc4Rij3UxwSPONfjJ0seH21cDfZ4uCAbMD8eUgzoZQI1uFaDaXM4W7Oz
OxjSe8WCmWBBpgOrDqKeBvpAJ/ceZVgAy8sh6S5P4p3oqfDTKI9A/Eom0yTMcIyf
n54m9Tm3XYb+f0N0C0+iqZ0NNs9HT3aiLaRhCFK3dwlzsoej1+ueyZXMl0gCVscK
ctK7mcLUTUbu3Sdrib/0ccPgNAfQXUa+piisyBgs/Q4ILetDpa+l8JVV5nyfHG33
VjpVCEN8pfZoqyoXF5XkPSa+91SjjErkNQTenQCd7ldZJZCW/011Ap+7ZEcu2Dx1
85NbWkDMBqecvLLIrsce0mORFrVVhuPbAiIlX65VusmxQMOO+K3nyBsar4BywEVV
qbEIWaYO4khkJNrkzjaW7zldvSU7Tg1TeuGW0ubelpMrXcP+G38KuYv6fEUp+cbe
RQ2ts/Qn9E4wHfO52rkMibAmWknuh8+chPVuLj1xfK03GTWjqlk=
=wrA/
-----END PGP SIGNATURE-----

--7Z6tc/8G+wfrnnQj--

