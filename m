Return-Path: <linux-kernel+bounces-878922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FA5C21C5B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91963B504B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E76236C248;
	Thu, 30 Oct 2025 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7dExoPs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B961548C;
	Thu, 30 Oct 2025 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761848989; cv=none; b=k/RfwDG6zASFaJuQ0KNMHiOFpcqR+EFrgQCBhZ7MJ8tW5WNzYj+FcBdAwUbT5T5wGwI/ZIIbUoccz378IKDxyCw4yc9G3S5Evl5sOu5NTj5SmZED3XF9qUl53WKUG+lGjdw/d1gqa3vfO6H+ubLfd7RcTX5RAo3/zFG57wj6BAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761848989; c=relaxed/simple;
	bh=+uuKMEWLzn2zwOIfLtXco0IaJ91ANXLA0ZCgeVdK5q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlYiXzCJBWm64kmWi3Dw5E1OGFeEZ1MZxV4J4Pz/RYWtVVoPt2Bb+INsA9l+aomVIX3e2C12aepYgwJrzh1HJsXDUPVzHL52B4yB31tRCe53lwxYzXWxeuH0oXM2F9akhXYIjACx+Vj1wTJCCKRVBblQ0xRSWcMNpL07M9IKXq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7dExoPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665B3C4CEF8;
	Thu, 30 Oct 2025 18:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761848989;
	bh=+uuKMEWLzn2zwOIfLtXco0IaJ91ANXLA0ZCgeVdK5q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C7dExoPsOU+hOnpoNMC4B/YuNUBa5OizFsiIeNrRvdEOdPbR1Y7vtxjTYYivfGtgo
	 tGczM3ZL0TJc7QnqB99S5bxB7vSJ+D7L4KoRWSsTz7sUdRy1G4Owl722ea9p+fJ2xH
	 ZNR12PmyFaz6bZ8xAsORDAaTTomqk5oqqxvcDPhkBDNOKiKyomZEdDOfTPXbjxyxCN
	 Fu2bNBrqCPbn6QLJoF8tgtA8MYq1XJFp5BHYgit9DkReLoi6OOSly2yX3hrMdoc30c
	 cq15iNaQLurM5T5HDfJq6UMvYZUWQRahaw9AaBN6bo+gMR6I7UUYMMTuhd1Jw91Il7
	 077y/m4ryTJLg==
Date: Thu, 30 Oct 2025 18:29:45 +0000
From: Conor Dooley <conor@kernel.org>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Andrew Bresticker <abrestic@rivosinc.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: Update license for
 MIPS GIC header
Message-ID: <20251030-unreached-bullish-8fee0b5526cb@spud>
References: <20251030-fix_gic_dt_licence-v2-1-94444b458e36@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZL4Y+h5a8akuIdjd"
Content-Disposition: inline
In-Reply-To: <20251030-fix_gic_dt_licence-v2-1-94444b458e36@bootlin.com>


--ZL4Y+h5a8akuIdjd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 05:43:44PM +0100, Gregory CLEMENT wrote:
> According to Documentation/devicetree/bindings/submitting-patches.rst:
> "DT binding files should be dual-licensed." The second license should
> be a BSD-like license, allowing the use of the binding in projects
> other than Linux. Initially, this file was submitted without any
> license and was later automatically converted to the default Linux
> license. Let=E2=80=99s now update it to follow the preferred license for =
the
> binding.
>=20
> Acked-by: Andrew Bresticker <abrestic@rivosinc.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--ZL4Y+h5a8akuIdjd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQOulQAKCRB4tDGHoIJi
0sgNAP9Ooww6FNzTeTCNaVmuQ9nx4Qf36b5Yh/pWhx61wlISpwEAqEZGFrNw5cOw
26ykDLnRC9q7/k/vhhvuv0wKY4GCZA4=
=gDsM
-----END PGP SIGNATURE-----

--ZL4Y+h5a8akuIdjd--

