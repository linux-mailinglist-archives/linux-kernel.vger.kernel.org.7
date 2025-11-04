Return-Path: <linux-kernel+bounces-885246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3629C325E6
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E223C3B8FCC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4467271457;
	Tue,  4 Nov 2025 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoqmPNu8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF3A33A000;
	Tue,  4 Nov 2025 17:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277659; cv=none; b=NYkUs+g1ymF7EnY1ASonSzfafKkOLbAsJCnis2bJIuF9+9cVePnJ/wZu7KixVjXw3bK3E3Gk0LM0OVu70OADWqdMOHub1aJlnLDJ7uMtbuxwby70dJ0L6MjI04au5BODwImVXsgj7zTIQsMZXLEVHO7zS+QHzid7uYRWIUBa/L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277659; c=relaxed/simple;
	bh=VZP4zd1NqOxxRJ4gQ1MkLDJmFVtrGm7/6INqxLsACeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpktjiViUUZQopCtrDJfrtmgh5wHP2H/GSo43AcRtNW19wN2f0CGXXcLo/itPZH9Ob7RbuQfiw869zbMYSuAIy63c18KnZ4QTE6nVyKYOEke8/fNxdvxGrqwrtC09lgPPix5uh3GuONDvMfxSKoNvpOcDERfHx7ECAuNcJ1rvV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoqmPNu8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1E3C4CEF7;
	Tue,  4 Nov 2025 17:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762277658;
	bh=VZP4zd1NqOxxRJ4gQ1MkLDJmFVtrGm7/6INqxLsACeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JoqmPNu8intzOPqud57ssx4DDfOS5yhueWy7EAVdZDgLbhZ1g/HsEQO8MjxpNv6Ik
	 fZxvf0jZcywhPhM30yhpmvaQeQDobuMT7IBZmJobFpVv9aP/D/dPo6KhK2+fB4ptka
	 0xXd/1xoVZ9zbI66GrqtuzlNiIUOSXTYXrsWyBssFEMFiPbxGCnS5A+MgHldavGxCm
	 jVlOKncPPK2PouQ/qeh9U9N0/RDssR4qf7pPIS0r4EvmSI26lDMoQFW5dv6xnfwLjE
	 iRR27o8LAKxvq1vepSl+aYKdAkayg21Ko0mIylE25tVkyv7Loy4eaz1o38F7OOazyV
	 f/1deH2/3zmNw==
Date: Tue, 4 Nov 2025 17:34:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Longbin Li <looong.bin@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Ze Huang <huangze@whut.edu.cn>, devicetree@vger.kernel.org,
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 1/3] dt-bindings: soc: sophgo: add TOP syscon for
 CV18XX/SG200X series SoC
Message-ID: <20251104-dandruff-handed-0ebaced9ffc6@spud>
References: <20251101014329.18439-1-looong.bin@gmail.com>
 <20251101014329.18439-2-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c4nufWis6uU2YIVM"
Content-Disposition: inline
In-Reply-To: <20251101014329.18439-2-looong.bin@gmail.com>


--c4nufWis6uU2YIVM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 01, 2025 at 09:43:21AM +0800, Longbin Li wrote:
> The Sophgo CV18XX/SG200X SoC top misc system controller provides register
> access to configure related modules. It includes a usb2 phy and a dma
> multiplexer.
>=20
> Co-developed-by: Inochi Amaoto <inochiama@gmail.com>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Signed-off-by: Longbin Li <looong.bin@gmail.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--c4nufWis6uU2YIVM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQo5FQAKCRB4tDGHoIJi
0lstAP9lVrXNxIptvJ/6DAvNyO717UosSVDKjRMXSocxnyyJMAD+PgfXNqFJ/7T2
x1q8qupFxYP/7lvhFaJGBAoFK+N6Bgc=
=VOqT
-----END PGP SIGNATURE-----

--c4nufWis6uU2YIVM--

