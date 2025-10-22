Return-Path: <linux-kernel+bounces-865622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE20ABFD9D8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35B8F1A0798E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F002D0C8B;
	Wed, 22 Oct 2025 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8Nl1Ov/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D597291C33;
	Wed, 22 Oct 2025 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154641; cv=none; b=nCHuzuYuE6D0WCIh/jEj8ZFJ9w2IYf/mLUFW7GCuZXILgqA7xfnsj7JOUd0Y8zgVdBxisa294J2RZ0Gst59DS6W6vFDkBZsX98xVVjIokAl2buKxW8tcwmGqrnEsqsPiWZqjj730OPhC1U3h0L1B0DwAPWnwi+2vczivfrKn35g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154641; c=relaxed/simple;
	bh=5C7JSiw2cENDeyIwTcB8RFCSbO1mNJYYryNwgOrWVso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3fPk4RsiA3Cl/r+atZ8hemVgtUtsXrKptilLGzQ1ZgUZCONojmnrDTcFPe8sC+5QKWLdGXYROY+4PrQfufHXQ/biVhA8bDxUGzTvvrWbK0mK69LRutN/67QLt+n7JMjyHp+2v2L875F2w9FswoY6qYmzM/QFAZE0MSWHaJEvkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8Nl1Ov/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2825DC4CEE7;
	Wed, 22 Oct 2025 17:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761154640;
	bh=5C7JSiw2cENDeyIwTcB8RFCSbO1mNJYYryNwgOrWVso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M8Nl1Ov/VjLVySoMBa78J9a7d+ZFX4EVzcA2t3sF6Y2j7WIyymK/M6nuqwI90VbDj
	 /unVVkTbOx72B2O8rKfle59it6XB63few2+KuCdIdrzHYmPb4812prFN3sMyiBsTfV
	 MK7atH+JfMMZ5rcdVDdjbL+1FxkCDoW7Epj+MR6rMYIR71L31Li+D3BL9s0YS0PZpq
	 pokqPeXjSUyOXDoG2uRvjZFee7XAt5ydHlBDxlS3A8Gav3gEtE66EntVLbnnfQV6BK
	 dxGj9uwu4E4Gmcp03KPeh7RhUwa9Yi/HNHSncKG3h+0IbI3pwbraYviBppNDJl4XpX
	 G4HKT0h8KgMNQ==
Date: Wed, 22 Oct 2025 18:37:15 +0100
From: Conor Dooley <conor@kernel.org>
To: muhammed.efecetin.67@gmail.com
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	heiko@sntech.de, neil.armstrong@linaro.org, lee@kernel.org,
	rafael@kernel.org, efectn@protonmail.com, daniel.lezcano@linaro.org
Subject: Re: [PATCH v3 1/5] dt-bindings: mfd: khadas-mcu: add new compatible
 for Khadas Edge 2
Message-ID: <20251022-maturity-driller-86e2b686066b@spud>
References: <cover.1761059314.git.efectn@protonmail.com>
 <0e604eca9ad9ce71f74b6f3aae60bbb949697590.1761059314.git.efectn@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fkgy7qwVQJZANVWh"
Content-Disposition: inline
In-Reply-To: <0e604eca9ad9ce71f74b6f3aae60bbb949697590.1761059314.git.efectn@protonmail.com>


--fkgy7qwVQJZANVWh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 05:22:41PM +0200, muhammed.efecetin.67@gmail.com wr=
ote:
> From: Muhammed Efe Cetin <efectn@protonmail.com>
>=20
> Add new khadas,mcu-edge2 compatible which is going to be used with Khadas
> Edge 2.
>=20
> Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--fkgy7qwVQJZANVWh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPkWSwAKCRB4tDGHoIJi
0mKOAQCBpjYa4ZhdL2trp7ttjTHXvdg7cdGJcZm3u9Hngw8AAwEA83IZEKUFHqo2
e7poEnoQa42kR0WbPNoO3Xjg3NFgygs=
=OllD
-----END PGP SIGNATURE-----

--fkgy7qwVQJZANVWh--

