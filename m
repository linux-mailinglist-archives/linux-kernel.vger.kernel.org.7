Return-Path: <linux-kernel+bounces-856444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8B1BE42B8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3371895977
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094A53469EC;
	Thu, 16 Oct 2025 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKj0kEsd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC423054C4;
	Thu, 16 Oct 2025 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627883; cv=none; b=bKsAivbi7UXmHTumqa6cGh+LWqumoRvLfO5sdORp5RKeBGZTcF/Mo3skcofi8/l7M0a1CXyRKtlUGXhQ5ZlFgesh9PseEWQ2OBHKJkr2pP9Z/F0sJN1Hsp6ZJ6pZS2hIU77vseH9f4rMlzwZ1Pre964FhI0tNOvpzCgcPTmgJMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627883; c=relaxed/simple;
	bh=OLnjTBsFhS0CId8p8aaFBJZI0umIpECS/0vXz5PL+w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEDJV5QKyXThnnGrHsSlZRdbzYDX0WlAlZRePRN6jkycYhbICeM+WqKBsc+ij4XkWPruonaez0fb0YR5uxtcknAo5xfOuJEk813DyE6zl2OQeKZzFr5oeZTMF26XWPsTJj/w2a3bAuKkq5V55dl5eZJOPtoDAsA4z84U0gCUrxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKj0kEsd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEE0C4CEF1;
	Thu, 16 Oct 2025 15:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760627882;
	bh=OLnjTBsFhS0CId8p8aaFBJZI0umIpECS/0vXz5PL+w8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VKj0kEsd+aS2RZwQEt4B+17ygXz+unO4/ewuvgXyT6PEydMGpLQOTjs3Byc8uk14D
	 +t4wVTmWAQtrVH6sM0pdk5sxAO+Gfy1HqARSe8MWBiTVMGEq514rzJCY1sOdJn0Ykf
	 ltUmLw320DKnZfgOT3xWmLpqsmxgPsYasO0IIxAqFVLTecd3RUSFqpd5fSno7zw+85
	 OfyYL/b++1IURqXBF08aIGO5AyZ7PAoy5PTaEwPXgm9baSzd0UJUqr4AKQVDWneFB4
	 Y8Np3Le5wbkjQOr0UGNy0kVuPakJ8ARC8V3UqYwApf0XTb89JkD/mibdl3P6JNF5Q4
	 S33CHW9BdnqHg==
Date: Thu, 16 Oct 2025 16:17:57 +0100
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	broonie@kernel.org, igor.belwon@mentallysanemainliners.org,
	linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
	kernel@collabora.com, matthias.bgg@gmail.com, wenst@chromium.org,
	devicetree@vger.kernel.org, krzk+dt@kernel.org, lee@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, conor+dt@kernel.org
Subject: Re: [PATCH v9 1/9] dt-bindings: regulator: Document MediaTek MT6316
 PMIC Regulators
Message-ID: <20251016-sporty-nectar-aecdb9499624@spud>
References: <20251016093054.126293-1-angelogioacchino.delregno@collabora.com>
 <20251016093054.126293-2-angelogioacchino.delregno@collabora.com>
 <176061229682.2195705.7053755296248416631.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ohtOrGlqHgKDXiIM"
Content-Disposition: inline
In-Reply-To: <176061229682.2195705.7053755296248416631.robh@kernel.org>


--ohtOrGlqHgKDXiIM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 05:58:16AM -0500, Rob Herring (Arm) wrote:
>=20
> On Thu, 16 Oct 2025 11:30:46 +0200, AngeloGioacchino Del Regno wrote:
> > Add bindings for the regulators found in the MediaTek MT6316 PMIC,
> > usually found in board designs using the MT6991 Dimensity 9400 and
> > on MT8196 Kompanio SoC for Chromebooks.
> >=20
> > This chip is fully controlled by SPMI and has multiple variants
> > providing different phase configurations.
> >=20
> > Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
> > ---
> >  .../regulator/mediatek,mt6316b-regulator.yaml | 78 +++++++++++++++++++
> >  .../regulator/mediatek,mt6316c-regulator.yaml | 78 +++++++++++++++++++
> >  .../regulator/mediatek,mt6316d-regulator.yaml | 77 ++++++++++++++++++
> >  3 files changed, 233 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/regulator/mediate=
k,mt6316b-regulator.yaml
> >  create mode 100644 Documentation/devicetree/bindings/regulator/mediate=
k,mt6316c-regulator.yaml
> >  create mode 100644 Documentation/devicetree/bindings/regulator/mediate=
k,mt6316d-regulator.yaml
> >=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/r=
egulator/mediatek,mt6316c-regulator.example.dtb: pmic@6 (mediatek,mt6316c-r=
egulator): '#address-cells' does not match any of the regexes: '^pinctrl-[0=
-9]+$', '^vbuck(124|3)$'
> 	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6316=
c-regulator.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/r=
egulator/mediatek,mt6316b-regulator.example.dtb: pmic@8 (mediatek,mt6316b-r=
egulator): '#address-cells' does not match any of the regexes: '^pinctrl-[0=
-9]+$', '^vbuck(12|34)$'
> 	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6316=
b-regulator.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/r=
egulator/mediatek,mt6316d-regulator.example.dtb: pmic@7 (mediatek,mt6316d-r=
egulator): '#address-cells' does not match any of the regexes: '^pinctrl-[0=
-9]+$'
> 	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6316=
d-regulator.yaml#
=20

 pw-bot: changes-requested

--ohtOrGlqHgKDXiIM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPEMogAKCRB4tDGHoIJi
0qc5AQC6xrazBME8K5XiVlRmkQmWm65ekJKMBRgQQ4h9Gki0+QEA2a5XkyiAuneG
Od5C/18x/63rpqNUfJk81SW/QURIGQc=
=IJSe
-----END PGP SIGNATURE-----

--ohtOrGlqHgKDXiIM--

