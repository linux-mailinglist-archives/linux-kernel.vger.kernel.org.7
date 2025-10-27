Return-Path: <linux-kernel+bounces-872164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 673C1C0F6BA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E52684EB7F5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B706311C32;
	Mon, 27 Oct 2025 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGqLiySm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA70311C27;
	Mon, 27 Oct 2025 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583421; cv=none; b=fCgBoOqWzEG2oL4xQx2FsE3q852BAplqZhAI6aWNdKywRYDHEVnnuhd56U5+SSbF41FfdL7W3zzNOG2srTtlZoW7IAbUJbZEhDri2lpajN8Ihovfmzj0nPz1LUnEh1exOs3YgIE8OzgKzmguofcMHzhzsl5RL/877FN0GzJx9AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583421; c=relaxed/simple;
	bh=qFhFn8+YqOP959WuEQxNYNWaORbGiOqWcenVkBVo0cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4k95XLx1cAHbftbXEi0kvZfpE8gggN71mixqr+Px8i0YolK39I2147MdSBXlXU5B29jhjlIr7mW51SKXNgjHUBi7gWdvh5NeEPTHmttG2wnoZfmh+FcnioWsaX+xAML8pF7JbcR2YIlunZqOKEtQ6uWLthj4Qslqs8rot7VRCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGqLiySm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE11C4CEF1;
	Mon, 27 Oct 2025 16:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761583420;
	bh=qFhFn8+YqOP959WuEQxNYNWaORbGiOqWcenVkBVo0cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LGqLiySmE7AZKyT5XiEEksJdfc4/P6ZrYQinCiweFORc06kwdBZufqa4Vgkhnl/jZ
	 koHzPI1P3GTvj4kf9xJKoHnNadezmUUlWjsNaAlS8xemfP9D1VvlOjEs1j+3QrSX/1
	 E4X6MmUeA/MWumAPuPzrLzw1jdsKOx1fNux0gQWaofh6ekFi9xrGsGqx1Wa4pq+0zb
	 3o1OLq1jSkbrb+Qqcmk7crK3mpvXZsXeSEp/2HpwPAtCOZ9Ay228NUfK+zupVtobey
	 F6wTRRafdJTfCMie9oCSH4+4l6snL5seSW/rZRAmtc0H5riHF0JzehWvDWF6MLiIKG
	 h8rhantcxWRSg==
Date: Mon, 27 Oct 2025 16:43:35 +0000
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, lee@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com, wenst@chromium.org,
	igor.belwon@mentallysanemainliners.org
Subject: Re: [PATCH v11 1/9] dt-bindings: regulator: Document MediaTek MT6316
 PMIC Regulators
Message-ID: <20251027-swirl-backtalk-7a4c456c6b55@spud>
References: <20251027110527.21002-1-angelogioacchino.delregno@collabora.com>
 <20251027110527.21002-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YUnqGUl9BxDmKz8j"
Content-Disposition: inline
In-Reply-To: <20251027110527.21002-2-angelogioacchino.delregno@collabora.com>


--YUnqGUl9BxDmKz8j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 12:05:19PM +0100, AngeloGioacchino Del Regno wrote:
> Add bindings for the regulators found in the MediaTek MT6316 PMIC,
> usually found in board designs using the MT6991 Dimensity 9400 and
> on MT8196 Kompanio SoC for Chromebooks.
>=20
> This chip is fully controlled by SPMI and has multiple variants
> providing different phase configurations.
>=20
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--YUnqGUl9BxDmKz8j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaP+hNwAKCRB4tDGHoIJi
0lUDAP0WtLoUfhkx8dU7bCtSgXO7e8/K3Fa3iB9P0XeKf11FMAEApZ7sIqQkFKPk
0QLNEhetIA5+lVhTly2bu1Ut1PSRTwo=
=r/Dw
-----END PGP SIGNATURE-----

--YUnqGUl9BxDmKz8j--

