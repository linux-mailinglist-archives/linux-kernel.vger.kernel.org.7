Return-Path: <linux-kernel+bounces-895849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B24E6C4F1AC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4158334CACF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA283730EF;
	Tue, 11 Nov 2025 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leINhPUn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F87F3730C2;
	Tue, 11 Nov 2025 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762879597; cv=none; b=mtYG+k9QqbU7wkptDqwY2IoRNfpTxdDfdvwZMwIJxwq0ncOx4G/rA5Chx7a2OGx7JumX7SxTu+W2EE9xcKW1LU+Uoxhr22/5D4zD+ZG31iBrE3veQq5gEdsKaovitgx+dVNd5Z6DRyEIl16SnT9I6pYn0F9TjT0yt4OkE0v5Pa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762879597; c=relaxed/simple;
	bh=jeDtFvGUXIuVgUDPgyVS9vBhjXcXU//Cn4BpthaOkM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJ9mzrGvGm9MhSffnlNF9aa2NflA4mRU5s63vawva//IDSu4AyQiir7MEazbHGxlW0JPB+rppKF6wWngmAG8G1Uxcd7IKsvLW1RNVLPKLKQehnAZ+C9ijoPERWSfmXCBkDV2T2fMPuyKgewWggV81nPeVu6igJkyL5Dtuo/R9R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leINhPUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1597CC4CEFB;
	Tue, 11 Nov 2025 16:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762879596;
	bh=jeDtFvGUXIuVgUDPgyVS9vBhjXcXU//Cn4BpthaOkM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=leINhPUnfTtmVDkHrVZuiuhH38TSZeyEd+IyIWhXZV5UYD4/CMbUIw+80GBULpBci
	 OdzhLsUuct8gS9MljKSePHzRtP+uWmuVVcmoTFmeU2wTbb68i/huv5Zi4xYkv2Bjei
	 WoqnrW20p5qK89MuNndzjPVctflnmm1pEqp2JZ5+kvjCnrUD3nWWq5v0ylMN4Y5eci
	 EwhHhIyRxpqjLBtT9DayUNOGF+1aOfVJobfW+UFDVJGFJEClkfBPj9scudgvc/RRR2
	 f1Rr4Sbz2BLL7NhetWqTQiO9lVb4yzuH+2VHcyRAFKtSBIqe+7JFPNX3DhyqF7eSes
	 DXRdIwDAA1e8Q==
Date: Tue, 11 Nov 2025 16:46:31 +0000
From: Conor Dooley <conor@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: claudiu.beznea@tuxon.dev, Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/5] reset: mpfs: add non-auxiliary bus probing
Message-ID: <20251111-apron-dispersal-6bd72d4a41a1@spud>
References: <20251110-zookeeper-femur-68a0ae346397@spud>
 <20251110-evict-gratified-bb816e2799a2@spud>
 <2fabead977bee651800790f6b0d6323ffdc372c5.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ONeNsy8hStpVyMW+"
Content-Disposition: inline
In-Reply-To: <2fabead977bee651800790f6b0d6323ffdc372c5.camel@pengutronix.de>


--ONeNsy8hStpVyMW+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 12:34:16PM +0100, Philipp Zabel wrote:
> On Mo, 2025-11-10 at 11:23 +0000, Conor Dooley wrote:
>=20
> With the superfluous cleanup include fixed.
>=20
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
>=20
> and
>=20
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
>=20
> to be merged with the reset of the series.

Cool, I have dropped the include and pushed the patch to the
clk-microchip branch:
https://git.kernel.org/at91/c/4a75fcd2000e1af452343aac6e34387f8e794f37

I opted to leave the include of regmap.h in mpfs.h unchanged.

Cheers,
Conor.

--ONeNsy8hStpVyMW+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRNoZAAKCRB4tDGHoIJi
0u/OAP4opIygXiE1msTAsenTF2y3vFMINksWzjFlo4txUmVtAwEApW/hg6Lu/LrI
Q6y1spEYrjz9xkO8cWWj/Le7Z07Cuw8=
=G7cd
-----END PGP SIGNATURE-----

--ONeNsy8hStpVyMW+--

