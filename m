Return-Path: <linux-kernel+bounces-895855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22375C4F1E8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34EAF3B5ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7543730FD;
	Tue, 11 Nov 2025 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNF/G/l6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742123730E7;
	Tue, 11 Nov 2025 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762879789; cv=none; b=sZId25FMT/iClauTV0uby3NKJOTvZTzBYiCe60FMekw3A0Al/T6JHeGrQKQRXNtmSuQKDGg5ik6EdwHs7N3+yy4/xBXCc71mBhtftaLWKyAgCBQe4Mj4mvkDEK6gq0CMTH/wfTIurJMMfI/wzLCnGX/LNWQ9LaeHnbS4Ps0Kkco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762879789; c=relaxed/simple;
	bh=kpe5yNkzl1ylQk4HWkjZz+J5d1iHVL1ZFwBmlT0/iSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyFP035CLarh6c7oCV4+ETmfAyA73tKdEcc875AxYaBOOJZ5BCvdQB9aegCsck2VW2giv8QgQFt3iDXJGDFDuR3+Q6edA8a6bkRWaocy0RUAUcBs+kX6ywEfVTNsHLqkdiLgLXq7YqZ0Qlos1XhigA7KnmcC9BFQbiSJj+iIKpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNF/G/l6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CF8C113D0;
	Tue, 11 Nov 2025 16:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762879789;
	bh=kpe5yNkzl1ylQk4HWkjZz+J5d1iHVL1ZFwBmlT0/iSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YNF/G/l6d2q9beti94869bl7xQ9koe+hfeuOxk06ralzTMh3MnL7CTaQ75CXGqwlT
	 cTu9797bpTWYDVc/45hPIR27L0H3tPjZWIGLCftY2WgdAKpBSZIh5y5F9cHcgEwKi8
	 o5JRm7Zvlt2uUL1SW4fZpWHR0PAgcrn2xgRe2QzhuJuyjkLMaIwuWB2SvzgpTGfpLn
	 LHtu/i6Um5qulwEIcIxfPLOETnL1gs4upbgMO3uykP5v4kaOjHQWWjHpXLugUCoIHg
	 2HmDoW9y5VRg8DdadyrVZcGXKXDIbzZ8amTyxdFShr4OcBftR2cTdiDmMA5vXRTBFh
	 0B6yWBltDpvYQ==
Date: Tue, 11 Nov 2025 16:49:44 +0000
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
Message-ID: <20251111-cattle-stole-7bdec770bbe0@spud>
References: <20251110-zookeeper-femur-68a0ae346397@spud>
 <20251110-evict-gratified-bb816e2799a2@spud>
 <2fabead977bee651800790f6b0d6323ffdc372c5.camel@pengutronix.de>
 <20251111-apron-dispersal-6bd72d4a41a1@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+1N/XShC9pu5yYwB"
Content-Disposition: inline
In-Reply-To: <20251111-apron-dispersal-6bd72d4a41a1@spud>


--+1N/XShC9pu5yYwB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 04:46:31PM +0000, Conor Dooley wrote:
> On Mon, Nov 10, 2025 at 12:34:16PM +0100, Philipp Zabel wrote:
> > On Mo, 2025-11-10 at 11:23 +0000, Conor Dooley wrote:
> >=20
> > With the superfluous cleanup include fixed.
> >=20
> > Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> >=20
> > and
> >=20
> > Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> >=20
> > to be merged with the reset of the series.
>=20
> Cool, I have dropped the include and pushed the patch to the
> clk-microchip branch:
> https://git.kernel.org/at91/c/4a75fcd2000e1af452343aac6e34387f8e794f37

And of course I made a mistake hand assembling this, that's the hash
=66rom before I removed the header. The actual commit is here:
https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git/commit/?h=3D=
clk-microchip&id=3D781f60e45bdfe351aad692ac0fa89e36f8bf4a36

--+1N/XShC9pu5yYwB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRNpKAAKCRB4tDGHoIJi
0strAQCaeCfO/jKbKqDwIwnIpTIJ/gnmLI4l3QhScBIpyCR9CwEAr7UHKcT+Ph1N
4Ox+Rgxn0tyGTs0P83gtbFaLQqUJnQk=
=hPke
-----END PGP SIGNATURE-----

--+1N/XShC9pu5yYwB--

