Return-Path: <linux-kernel+bounces-872159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F23AC0F680
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FC314E79B4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A17E310624;
	Mon, 27 Oct 2025 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPvB2bfw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A72EEACE;
	Mon, 27 Oct 2025 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583340; cv=none; b=nS6JXUvkiaJ7qoby9/uBT6bv3znqDkwXlTU05MfMSTioYPrKrpeJ+RivlApbtawtm+47ZHNqwt1I5PVLVIz4OoW9PieV2Zy5WjxLzjj49v6E2YOMLeL1oEAabsnHA8lNHl7AZg3w7cfNblmUAQxDlDBacaqKMsgrXPw4uqIyivY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583340; c=relaxed/simple;
	bh=EHx2M6g+EAlFKiq+5G5E+4KFp696VRvzSrJ5XFbCxek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kelLFE1MPVkLp83f8ej3UT8DwB4lkNMIsGafb+84S1ELDUfewsMrhAX6cndlcz0vdvnA1S4YNiAzg69DnawaiIEaCmIsTUp+5PynKvov6zu006RnfThnjssUFP9kXRUEktCQx9Rs+qfRWXk9SMJHp83jo6PcteHT8827Tvz2NOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPvB2bfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067B0C113D0;
	Mon, 27 Oct 2025 16:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761583340;
	bh=EHx2M6g+EAlFKiq+5G5E+4KFp696VRvzSrJ5XFbCxek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IPvB2bfwFV6WYvMXAd8vU17nGchCLQ9RsLgnQxYYU/R3VLUs+ekwuSmdpcUdyQuRN
	 a+rAN1sk4Em9OU6d0PtOfnDjjOFxhmEFJ96ouIFz/rxKS1M6umWvkFkW7PDvCXJPVG
	 aglqrLm0lkcOfcIx7Gnwk1ZZXLZ1ZamXoeTZ03j9eS/eVnZouOLOrijvzwhe3J5ADk
	 6QUtjwaWIWHpEnS3UWOX6G8nV2n26TgRLw/4Ty5QDr6PDoGTY0/hbmZJAX1vSkpBim
	 WhZ241SB4vpXyGkoWMLPnUZGufouVaAp4BnwRAVauXIN+YNg01QDZUBhmZVyqrDAjp
	 oYVLXH6wshbGA==
Date: Mon, 27 Oct 2025 16:42:14 +0000
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sboyd@kernel.org, mturquette@baylibre.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	laura.nao@collabora.com, nfraprado@collabora.com,
	wenst@chromium.org, y.oudjana@protonmail.com,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 6/7] dt-bindings: clock: Describe MT6685 PM/Clock IC
 Clock Controller
Message-ID: <20251027-oblivious-antiquity-1c2b0f3972dc@spud>
References: <20251027111343.21723-1-angelogioacchino.delregno@collabora.com>
 <20251027111343.21723-7-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NeWl3Rg4icXQ/OM8"
Content-Disposition: inline
In-Reply-To: <20251027111343.21723-7-angelogioacchino.delregno@collabora.com>


--NeWl3Rg4icXQ/OM8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 12:13:42PM +0100, AngeloGioacchino Del Regno wrote:
> Add bindings to describe the SCK_TOP clock controller embedded
> in the MT6685 IC, reachable over the SPMI bus.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--NeWl3Rg4icXQ/OM8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaP+g5gAKCRB4tDGHoIJi
0qinAP4qLR3o3aZJbssQAeJ7otn4Uy3XT2CNs4xAyhDkX/oUOQEAhHZSAs3z/fUg
W6t168PxJh6XweOhoxLKJANAvx6JkQs=
=JA0w
-----END PGP SIGNATURE-----

--NeWl3Rg4icXQ/OM8--

