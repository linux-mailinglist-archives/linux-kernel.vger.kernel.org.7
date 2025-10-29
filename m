Return-Path: <linux-kernel+bounces-876840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45757C1CACD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36DB46479C4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76026351FBA;
	Wed, 29 Oct 2025 17:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiItvCa7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C226E3557F7;
	Wed, 29 Oct 2025 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759477; cv=none; b=RsNu0UDQpFHMbVL/Vil2JENq5sh4uXeVf9ygI4yGsCQ80fIk9pkT00tRjCVwhryLd6k47p2EwgbnhBqyLbuDh5VsrU6vZdCWwzj2XarPK2ZMLCkgkkHcWKjSx0k2hBWJDhyZzceqkFTSxF3cxCwRnxj7Z9UBqoXSBr+QeeDT36Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759477; c=relaxed/simple;
	bh=ALlT+zkeisO87P7wkYqqS/FtyMDkmsnbnHyrmAV3V14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAvCGaiGpt6LG203M78ZuH5y+WamXCfw0g2cVOs47JHh1ou88QADcs+Tf/gLEpf7D8z/1I2J2JgUibzES4Rk/jsQ0YqYet9o8MG3/SgTWcVAI6ZbsinTev5TIjderadih/nMSVZNKnYmitBZe/6OPxdc5E9iybdWjwnftrAYqq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiItvCa7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41D5C4CEFB;
	Wed, 29 Oct 2025 17:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761759477;
	bh=ALlT+zkeisO87P7wkYqqS/FtyMDkmsnbnHyrmAV3V14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CiItvCa7fo01wEAviGksvdstjyxr959lPBEhyXFtCg12lGOj1wUoZ25cEHLXqP/Dn
	 /emFc6ELqr48kBp4UDfkZWJKJkTK238nFmOngie69TzqjJGW9jqWgd9l6hePxci+/q
	 lX0E8qdcjwmaHXfpQUujvKvx88tnZl+TTDKGjIQUjMDXjfLYTcQG8jnjsTANF5PVk8
	 L+zouuyIAf/lMjXkS/j7HdqGC/G3j6Wf40D3z+hIOfEEBiAocxjpALYsWsIOUaru7e
	 35+9teWFlFkNNGKIYRCU2igsM4EUfJVyRnec8c8wq64BHJncHmwBad8p34cf5JfFpS
	 V7GMt9ue0mDoQ==
Date: Wed, 29 Oct 2025 17:37:52 +0000
From: Conor Dooley <conor@kernel.org>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Flora Fu <flora.fu@mediatek.com>,
	Alexandre Mergnat <amergnat@baylibre.com>, kernel@collabora.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: soc: mediatek: pwrap: Add compatible for
 MT8189 SoC
Message-ID: <20251029-change-atonable-585dd0397d42@spud>
References: <20251029-mt8189-dt-bindings-pwrap-v1-1-d52b1aa5f5a4@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V7RkbouwCfWtfrQq"
Content-Disposition: inline
In-Reply-To: <20251029-mt8189-dt-bindings-pwrap-v1-1-d52b1aa5f5a4@collabora.com>


--V7RkbouwCfWtfrQq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 02:25:57PM +0100, Louis-Alexis Eyraud wrote:
> Add compatible string for the PWRAP block on MT8189 SoC, which is
> compatible with the one used on MT8195.
>=20
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--V7RkbouwCfWtfrQq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQJQ8AAKCRB4tDGHoIJi
0im1AQCeMlTn6wQy1Vjpm/2Ce/v2/7kzcogQnssK6Ik37VGObQD/SA8jiLZITdoo
izfE3AwS2c3v1VeClOFMLRGxwiCy2AY=
=Yrem
-----END PGP SIGNATURE-----

--V7RkbouwCfWtfrQq--

