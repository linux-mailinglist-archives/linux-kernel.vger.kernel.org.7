Return-Path: <linux-kernel+bounces-878926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E403EC21C8B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B5B425F25
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52A036E351;
	Thu, 30 Oct 2025 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrX5K6ww"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2950236CE0E;
	Thu, 30 Oct 2025 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761849092; cv=none; b=dVZpsH2ncEIK3EFot9KErX4hKLkZ1Ccm+mZS3K9TnamYO1L6I5pfYa32hDDUsS3gkuMXaRwbwpJ689LESwjed9CNatxV5cNLGf9q4bei28/UotfnMWaP04L11SkDmCrauQAaXL9W+Dp/pV2REVOu+nlBcm0VfE4aTdnCNbjqFzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761849092; c=relaxed/simple;
	bh=mnJDg2WGDKJZf/Vr8jH9TK7ujlvyU3706J8AQsGf+6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOVT55T/H+y3ztie0pWd4OmH/xKkvyaX2NvVJJRNfd59Y+fudDdieXtsSubjVjS0+scLgT6X8Eb30JmGRYFEFettidVsMHtrURN/FLDzL8OG2M9kYVgWs/n82e7EECTgePBL0QzzSD6fSeRkFAc3HDleb1yCHBdFNFM79x/1pOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrX5K6ww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D2BC4CEF1;
	Thu, 30 Oct 2025 18:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761849091;
	bh=mnJDg2WGDKJZf/Vr8jH9TK7ujlvyU3706J8AQsGf+6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RrX5K6wwbb3APve/VViJ7SCkh1wSjv1FBBNDscm6CyEcMzDIL2OhRrHaiyRbM1j+C
	 KXRIIPttDnSkzINlq6735qu0REbZru8+HR4bxWIVvU4it/ajF5t7Tnl1YY8OH2Cko8
	 z8LHrpy5x6paRFIiRmOEg7G10FKwe9jJLwejKMvgf1D4yzXCW8lY8GZasFCHHOwHSO
	 vm0twT0L/qf32ao3hyV0lLpjGCS3iQyUOuUHrXekOnMcWRZht8DNE+taamR18nk92H
	 RuS3GsojVOfKyuScICccgtch4npD5Fuow1w/RjRukOVTVMjydupSC61pDhhdfTRwwv
	 SGIToUdaHGJNA==
Date: Thu, 30 Oct 2025 18:31:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Lala Lin <lala.lin@mediatek.com>, kernel@collabora.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: nvmem: mediatek: efuse: Add compatible for
 MT8189 SoC
Message-ID: <20251030-sandpaper-baritone-ecb365a33ff9@spud>
References: <20251030-mt8189-dt-bindings-efuse-v1-1-1148e474a9f5@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3UnDEVVN0m5ukz0j"
Content-Disposition: inline
In-Reply-To: <20251030-mt8189-dt-bindings-efuse-v1-1-1148e474a9f5@collabora.com>


--3UnDEVVN0m5ukz0j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 11:26:10AM +0100, Louis-Alexis Eyraud wrote:
> Add compatible string for the eFuse layout on MT8189 SoC, that is
> compatible with MT8186.
>=20
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--3UnDEVVN0m5ukz0j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQOu/gAKCRB4tDGHoIJi
0jyOAQCMZqMa4KCJVr16fS+kvyHNDmyxiyRUFY0xY3kWUc7SWgD+PRxa7CiB6A5Y
OnbuON6dKugcaPsf6DWFkhLkUoSyOAI=
=oK0x
-----END PGP SIGNATURE-----

--3UnDEVVN0m5ukz0j--

