Return-Path: <linux-kernel+bounces-777883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7BBB2DED1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57A731669A3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C3F26B95B;
	Wed, 20 Aug 2025 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMluIu+L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58C126A1D8;
	Wed, 20 Aug 2025 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698930; cv=none; b=IQETPoJ5oEP/ETZqMKKhPFbtN51JERyGYtFAcJ4+oMpzBbdTE/+7cccZfSioUJi7cfWtB9czq9FSOwUNy+gsxbimdFLaa5bhx97oxUlQ6qp9TIo9/iEWcIlfXi+YM61zKipRuLtJzeJXqe4tu0OFxuGDzZwsVZy6u6AwLkEAkog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698930; c=relaxed/simple;
	bh=pMXgzqRfvoRVUf9L0RDd1Zb77kzZePSRtO3S30aU0Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwdYnpzwskSPGosYy4GZ0xKOtz1r4Gdl2UUS2Riqrnx5+Vq0B6gnKqBTH3lN/Mo2W6HC4KiOy4GowHJ1utBgqcvaWwVmUShKKrrJbhNydQUeoczzUqiNSAwb5BKGVAiR5KiQ7Sz49TpQ1aDOS4slsWq1rU85cKGx68xb7zhp8iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMluIu+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48077C4CEE7;
	Wed, 20 Aug 2025 14:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755698930;
	bh=pMXgzqRfvoRVUf9L0RDd1Zb77kzZePSRtO3S30aU0Xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZMluIu+L7G0qZ27ch6bbEMCHqZYo4zO0+4qfGiWeY8Ym3Pi6Jj3xQ631+UDAlxO6p
	 WlSORCiLj0OjmbQzC2fpqQgrLaCPbQSvIENijX4JhpOPt6IpxJDRVz4A1+tbBi/4PW
	 GjmF3XCkx8d81oCaFx6vmxCRkKQq/RGvmCjBOVK15fV/xaHBFC243GDwGOUwKPv/gq
	 u+cTO9cPPUswMkATRkwRuvAJ9okXE1YWaIfef06n/h5XA+SihM72+BX//I6k4B4ZXT
	 vBxnET2lXMz7ZWkgw8s0WQeVaZ6f0+2ocSueMIhTlaIGs+3+KBQ6iv80DcLgbrkW8w
	 /GxW6XmWtNnaQ==
Date: Wed, 20 Aug 2025 15:08:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v2 3/3] ASoC: cs35l56: Remove SoundWire Clock Divider
 workaround for CS35L63
Message-ID: <5e89d3eb-15d1-40c3-a777-01c3f97a89ed@sirena.org.uk>
References: <20250820125045.117740-1-sbinding@opensource.cirrus.com>
 <20250820125045.117740-4-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FV8WXpWu7APsZlZW"
Content-Disposition: inline
In-Reply-To: <20250820125045.117740-4-sbinding@opensource.cirrus.com>
X-Cookie: Semper Fi, dude.


--FV8WXpWu7APsZlZW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 01:50:36PM +0100, Stefan Binding wrote:
> Production silicon for CS36L63 has some small differences compared to
> pre-production silicon. Remove soundwire clock workaround as no
> longer necessary. We don't want to do tricks with low-level clocking
> controls if we don't need to.
>=20
> Fixes: d3197a09a117 ("ASoC: cs35l56: Add initial support for CS35L63 for =
I2C and SoundWire")

This patch isn't present in mainline?

--FV8WXpWu7APsZlZW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmil1u0ACgkQJNaLcl1U
h9CpwQf+I4uXAKXSLcpDCNBFi8iOLJiAwQLUjElQQW6WlxXg5jH+/kZgeBvrGk42
FzkPHSJyY95iaP5kPY6jhS/PRT9XMJRTSG1kZWHVmPIhDUdE1rnaBC7XBnr3E//5
tjS0GmGni9qL2l3Nmjx69h51XIj9v+QetApwWLh/PMzbdsx8PQhm/uqjyvy9RFYM
wECLlCgFS8b14qK2NxahsY/5boZhy+VCnrpIjj74+P9wZltdvJR6goUFe03i4zhZ
4iVf8aT1q3F4/5V3LklkSQfuX+c3v4YV080YM3yE4ipgGcIZPkLneab/piXJEpNr
d7vfyapOL8LvjhxiHT9qZKu0BflbEQ==
=LlrB
-----END PGP SIGNATURE-----

--FV8WXpWu7APsZlZW--

