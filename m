Return-Path: <linux-kernel+bounces-876837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EC24DC1C7DD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 976FA3472E7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576D2354ACC;
	Wed, 29 Oct 2025 17:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUH/wVOA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DBA22652D;
	Wed, 29 Oct 2025 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759460; cv=none; b=s6QPJJKrHshzE/BBwYq2CUqptZvgu/F8PGswjfoyAFUy8UsSHwpMm51PtyI2avIjCI1byi9HyZ+w6kCWTtq3OvjqSjVSguoD2pf0HPGhzk7a+TM4N9ip0Bjd4TlNe9QUc7H/po7iAiTjb1gA1NesbPnS3lfa6nfsmi2sswZkipA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759460; c=relaxed/simple;
	bh=BZxMvMgp/oTJXG8V0pkzxp4anTh6Z7OzA6kttBVt1Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BE0ZvhFjQqYRk4SYPAPE/PIP7hMts1vYHVUuPSBs0NMiyYnDo4RcNOHrEMLyd5pAMRipXv6RvTfSOMUkTblS0hkBYDlYb8QDnaS9qzIdQJOQvVuOLz+hNDKvvzWFeQ9OCzYTFPkjLYN7G8gOQcPg9XIWWFCh2dtrMvxo2/ZRvOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUH/wVOA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6D0C113D0;
	Wed, 29 Oct 2025 17:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761759460;
	bh=BZxMvMgp/oTJXG8V0pkzxp4anTh6Z7OzA6kttBVt1Tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AUH/wVOAwFD6vnYUs4aYrhtlV71ZIBmTuztwLl1wysr5+NjY26oeRCv5SJHEZUaDr
	 lWLio7QgKGnfPhERc2RFpRXfgvL7m0GZEfnH1D4TzMfgBfdAElVHGogJL8UuYg8b5B
	 Ux9rJUGM2LiE/D7mmXt42wjmAyug9WHz/f0v3US4D/ONOkc7PGJdcGADSbjceRuX+K
	 rgOskbKmgOVDoLurTn7SRrUsNQdhMeXgJ58h1/OlC/LVtOrcDmUjOsRD4G/0ydcsiF
	 U3UGU9JbJHnf9L3AjgtyZQJOf7M1ZJ+9b4p2Y+SRnrJWnxtEJRr0rN87I2VZU3AUy8
	 K8zbeldIj2Wdg==
Date: Wed, 29 Oct 2025 17:37:35 +0000
From: Conor Dooley <conor@kernel.org>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
	kernel@collabora.com, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: spmi: spmi-mtk-pmif: Add compatible for
 MT8189 SoC
Message-ID: <20251029-energize-synopses-14b86eeaaa2c@spud>
References: <20251029-mt8189-dt-bindings-spmi-v1-1-fbea12a4ed5e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3Q7C2oA8gPlSdO/P"
Content-Disposition: inline
In-Reply-To: <20251029-mt8189-dt-bindings-spmi-v1-1-fbea12a4ed5e@collabora.com>


--3Q7C2oA8gPlSdO/P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 02:31:16PM +0100, Louis-Alexis Eyraud wrote:
> Add compatible string for the SPMI block on MT8189 SoC, which is
> compatible with the one used on MT8195.
>=20
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--3Q7C2oA8gPlSdO/P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQJQ3wAKCRB4tDGHoIJi
0mlQAP90Purps8XXysFdri+DkHVn5X8gpgEJrCBoYShUbvTPNAD/RDmppUCgpXif
UI01VO/FYSNXlqL+z/TNwb0ynrPp9gM=
=tHul
-----END PGP SIGNATURE-----

--3Q7C2oA8gPlSdO/P--

