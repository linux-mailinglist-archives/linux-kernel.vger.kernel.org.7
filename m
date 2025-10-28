Return-Path: <linux-kernel+bounces-874582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B13DC169F2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96EB3AA010
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED6134FF41;
	Tue, 28 Oct 2025 19:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLs+Hv3f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681AB29A9F9;
	Tue, 28 Oct 2025 19:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761679898; cv=none; b=H5CN7rt5rOvsALQVlZ0qZqF+UOmiHZwKz1e4erKJWLOmac3CXCBbMxVVCf6PDQur0voZNl9Z1LSWu5UQn9ogEeljjh/Oau0X+1kvQcfllvSKR1VUws7EblcMFy1D5xamNwgN7zh8/cyb5ZGoP9LHqB3hSQRjo6k4accmOU0d5zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761679898; c=relaxed/simple;
	bh=DcJvgp5kzm0iZtaexyuV+sB0byJmjCNfqV14wFgw6lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxvCQDPT5Oo8xPgpStIJb7vJl5OKHfkwUAYfxtxpAB8QJkuoVeUeY3VY06HD473GsWPp76ZIcHGG6oRopfAUXEOt3FgPzEyl6/Np7Ue6RAcAd3v81CRRP1SI+WYuWpGAPclgNOxDFZHh79S8R+YPcBnqvuK8/xRQSq/6Ql996Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLs+Hv3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5242AC4CEE7;
	Tue, 28 Oct 2025 19:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761679898;
	bh=DcJvgp5kzm0iZtaexyuV+sB0byJmjCNfqV14wFgw6lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gLs+Hv3fT2HDVMwXUEt2CTggHlxbhkJkDlN492kqM9CTFlikSTjItP2mrafCdAZz3
	 OiQwt+a+Haw56J/R0GesDE9SRDuGQZsmdfCQB+Rd2ocdV3qT21jiia2ZnOCGzPwP4m
	 LArmmweR5wqKcoH2qdEA2KG74sAhzPCrh+SONneHc54U+DDEBY8k1OuqIMEMChzNqK
	 vuSMl8JanF18Xx6+bbtWlef+AFIivymorqVbAK6mx0gLKeXhAwkXrMAsKNKGoFMSl5
	 GvQ6rhbVvzdn2J25FMyUvZR5dchxaQkrT6/9kQ0OQKwBvEzXeVrbQ5naVaskBsdXTO
	 GG4Jfuj+lrYQA==
Date: Tue, 28 Oct 2025 19:31:34 +0000
From: Conor Dooley <conor@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Robin Gong <yibin.gong@nxp.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: regulator: nxp,pca9450: document
 input supplies
Message-ID: <20251028-luminous-undertook-c518378eb3d3@spud>
References: <20251027124415.989301-1-o.rempel@pengutronix.de>
 <20251027124415.989301-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DkNDWamEZMwAVTmF"
Content-Disposition: inline
In-Reply-To: <20251027124415.989301-2-o.rempel@pengutronix.de>


--DkNDWamEZMwAVTmF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 01:44:14PM +0100, Oleksij Rempel wrote:
> Add missing supply properties for PCA945x input pin groups:
> - inl1-supply (for LDOs)
> - inb13-supply (for BUCK1/3)
> - inb26-supply (for BUCK2/6)
> - inb45-supply (for BUCK4/5)
>=20
> These properties describe external power sources for each input group.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

pw-bot: not-applicable
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--DkNDWamEZMwAVTmF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQEaFQAKCRB4tDGHoIJi
0rfCAQC+JmVCiE4ACIE20eVbZN1rDutzHSSRk8ZqFkKFG0h0mwEAh9a7JNNQGx+7
ihIQc0kZQEPsrzTZ8j1HusH1i+ldWA0=
=ylpm
-----END PGP SIGNATURE-----

--DkNDWamEZMwAVTmF--

