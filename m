Return-Path: <linux-kernel+bounces-760535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF18B1EC8A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7014D7AD36B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D74285CBD;
	Fri,  8 Aug 2025 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBOaR7ov"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01508285C9E;
	Fri,  8 Aug 2025 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668540; cv=none; b=tI/AdREN0D9Bx+pkwp2+ijn4jUjTK8x0PM3m6P31HfM1wOJZMkW65qO4me8pYWU1N2yzz9KyaOa6Rjqg0veCv4gr8c/lRCfh62YuvsR619TCE8tOAvh/g5GbbJ2keS/+qf0de+m34TEATNGlBb/2Os88Zvp27Tvy9bmlohQamYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668540; c=relaxed/simple;
	bh=nuZ9g9XS98deNhUpvfIEudupikEWzNYWGLOR/GgCxQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGsFNbNZR9blfDZQx2mvfESOFUnGraX6cxdmoWP734f9dzKkuptafWNHJAcr+WTScM6VQJ+bFEU7bIIoUt5bC2czJvWCuKCeBJ2AAacPeTAYovNYVkdYIywO1Dyqu0w8MXtxrjHK5yGY+L/YB6M5Qmv1gXUlOMfIxH7KJdLoWF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBOaR7ov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73039C4CEED;
	Fri,  8 Aug 2025 15:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754668539;
	bh=nuZ9g9XS98deNhUpvfIEudupikEWzNYWGLOR/GgCxQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bBOaR7ovp6fjp+sJtSNMhxOPBwVPDbEtsxrPwoTC6RuZZWEwWiSGU3OgWOdQ1yy8e
	 ddZg8wpqKy611x1gNWPntA1Ji5sumsYlC+XqSKf/X/JaKXCy4PA7T25WTkvaCTInEw
	 WFcztoaq3N4XJXBy+tieSQ75l0SZ0SBlUVgnVsPtEynZP1Zzmyyam3IDMt9tCWYlNY
	 nikd64zthJtmhUeFL3d8cvcx3xzpJ7hldSkGjRXlnIvmGq0NZNo2Z0NCuCtSUnV24c
	 rmvAjdPIYEzgD7Phm7qEr/g3CcxBOWKBgorNwADzhX11tbEKDaoD01xLIlMCv1pESf
	 geuGtZj8aRPhA==
Date: Fri, 8 Aug 2025 16:55:34 +0100
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: Drop imx-audio-sgtl5000.txt
Message-ID: <20250808-pureblood-princess-ee6902b82af7@spud>
References: <20250807214358.4172451-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PZ/KRAbWhOF6Zls9"
Content-Disposition: inline
In-Reply-To: <20250807214358.4172451-1-robh@kernel.org>


--PZ/KRAbWhOF6Zls9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 07, 2025 at 04:43:57PM -0500, Rob Herring (Arm) wrote:
> The "fsl,imx-audio-sgtl5000" binding is already covered by
> fsl-asoc-card.yaml, so remove the old text binding.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--PZ/KRAbWhOF6Zls9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaJYd9gAKCRB4tDGHoIJi
0kNmAQCK+Q/xDJm3yc05xw7IemO22vGZ1iB9oUmNTEPFBvkk8wEAkugWYoCdikr5
lR7BcpOyJtMbWDS9osCbkCSL4NMsRwo=
=Krot
-----END PGP SIGNATURE-----

--PZ/KRAbWhOF6Zls9--

