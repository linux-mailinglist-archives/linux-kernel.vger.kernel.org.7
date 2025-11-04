Return-Path: <linux-kernel+bounces-885226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B212EC32523
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41D81895728
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABD3338939;
	Tue,  4 Nov 2025 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wiyp6CfS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4254F3271EF;
	Tue,  4 Nov 2025 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276840; cv=none; b=VGRrly0/cfYxY16GpH7SMeXAVhTNQ72bfesaO1WAhGVnH6FE/VOet0dFAYTrYNLzS7S0wCqR3iUkayXMeaiiJqE/O+krfCKi8POhEDiAjGpbRrkfDOEamg+oAo+Tom4qNfgz1BYAdhIeA3qcKToCzBaA2PXR3BrJTTNfU2IsksI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276840; c=relaxed/simple;
	bh=jmu6OyWnBMfKHX6Zj0i7cFQhUadJ2xlzy+K+HbdcDLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVHaSUmRAjrLw0zTUqOMy2/wLIfIN5nJ1QaXXYlvUw2uT++LhIC17bv6SadVAs2yW/PyDCL3drSeTxCbLUUpxBaa4SsPcwlZBPNc67irNb9bZ196TGmllwc8+FUhnjI6/f8dfx447DhY3qxfJoLsoDaMZKzQ2owFbz9wTSkTNKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wiyp6CfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3005FC4CEF7;
	Tue,  4 Nov 2025 17:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762276839;
	bh=jmu6OyWnBMfKHX6Zj0i7cFQhUadJ2xlzy+K+HbdcDLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wiyp6CfSiFTBpq0MyIPe5kAEf43OVKzhCk9j1lClY2xTc3246kr3Ek4gwZ3x67gcY
	 pUaFKlViKPZ1Sa6BSvDg9MkcxnFSqOK4NWlAJAX7f1gBwF6gMN9d1GRUe+YzmVMnBe
	 JjyPzbyrEwIWdV8mxoPR77le5GCDewlixY26QlpQYx0sRQLPVTOH1y9OjT9BA13UdK
	 luHRPBLLpl5fZxvs2z/vPhVonz9jVN5LEJkk3J/mww3kAbA+cIGrdmvibcRbeAHZn8
	 K3gTxcvRuRwt00jjq7GdIm2AAoi/yd64MhuKTn7SDM30V2SsM7QryoU0+XlI2r9uil
	 znvBTyN1ZYxwg==
Date: Tue, 4 Nov 2025 17:20:34 +0000
From: Conor Dooley <conor@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: arm: ti: add Toradex Aquila AM69
Message-ID: <20251104-spiny-tumbling-87cb4d754be6@spud>
References: <20251104144915.60445-1-francesco@dolcini.it>
 <20251104145240.61219-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X2GGlsUyBYvruX+g"
Content-Disposition: inline
In-Reply-To: <20251104145240.61219-1-francesco@dolcini.it>


--X2GGlsUyBYvruX+g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 03:52:35PM +0100, Francesco Dolcini wrote:
> From: Jo=E3o Paulo Gon=E7alves <joao.goncalves@toradex.com>
>=20
> Add DT compatible strings for the Toradex Aquila AM69 SoM and its
> supported carrier boards: the Aquila Development Board and the Clover
> carrier board.
>=20
> Link: https://www.toradex.com/computer-on-modules/aquila-arm-family/ti-am=
69
> Link: https://www.toradex.com/products/carrier-board/aquila-development-b=
oard-kit
> Link: https://www.toradex.com/products/carrier-board/clover
> Signed-off-by: Jo=E3o Paulo Gon=E7alves <joao.goncalves@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--X2GGlsUyBYvruX+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQo13gAKCRB4tDGHoIJi
0sxkAP4+vHqzJhRKRiGqUGCwTfOBg6kzrwpHR4sIHF8nStqKFAD8Cym+92y4xamh
7UzbMTgSKxHrqRwnyTHjSSTQQTOHtw8=
=oY/v
-----END PGP SIGNATURE-----

--X2GGlsUyBYvruX+g--

