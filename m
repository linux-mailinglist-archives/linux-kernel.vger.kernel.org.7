Return-Path: <linux-kernel+bounces-761571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E521B1FBFB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 22:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273EC3AE685
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 20:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD7F217709;
	Sun, 10 Aug 2025 20:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHPqAFdM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39AE42049;
	Sun, 10 Aug 2025 20:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754856510; cv=none; b=NGA3usE4MDiMW6X2o9qG2Ca6ECHUlKkwSICXOfA04IKeMNBVD1mUIHFLIfx//XrLqyGcMxlRRvPFU36AKZZKYLztFT9HWQ9FsbgT3bKE/nv2g5Wmesu2rVDV15ubajm23XkaSwiza/It2JojDGEHOAqGMWes7qcKheFN6Y1yoOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754856510; c=relaxed/simple;
	bh=Y5Q/vr0kJLcgM5XgDCcBAyfuPIcq6nswgQBR9Q/BEzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jc9RCPr4su7GgNa5JXWp8MWGXTcJNqPoWTfJzshO0SYQmdm22wwlvDK0/JVUZcvuelkL40uAap3go1yMgiK58lZfIrP+RIm3v3jooyIudFPD8MmXRlFJqt0fNQc+oJzfJxD3BmsqQlnpfIbUUvV/kNzgj4LTJzCA6xw9oRbRmmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHPqAFdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04D7C4CEEB;
	Sun, 10 Aug 2025 20:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754856510;
	bh=Y5Q/vr0kJLcgM5XgDCcBAyfuPIcq6nswgQBR9Q/BEzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hHPqAFdMylbeQCy59EAgM8clk2Tuu+QaV8KgzT6/jSp9lNH4Nrqq0IDvZXbQYGv21
	 ytFqM0HX2gU1DKb0ResjDKiOdRjKLCimE0A0I24Adog5PTxtakMbFe/PJgGGJ+tEqP
	 NOV0q7h0cRmUOYkAOgOdUCn2iR3/apUrsQfPU+ikm0rayyowvm+vLMHj9jz9PKhKyn
	 5k8hUGQUpXXfmjvKixN5XIA5ubswGiGNuZgwDh0VCmdNaKRQHMwED6pAEjJuykKDjx
	 E2up4o4WZGHFR2UTUMY/t9tuEp6+VpIOrip4FAwjStvFV4nSmUMPOgPgGwq2fXqWi0
	 lvroQTnlU9ktQ==
Date: Sun, 10 Aug 2025 21:08:18 +0100
From: Mark Brown <broonie@kernel.org>
To: Nick <nick.li@foursemi.com>
Cc: lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
	xiaoming.yang@foursemi.com, danyang.zheng@foursemi.com,
	like.xy@foxmail.com, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] MAINTAINERS: Add entry for FourSemi audio
 amplifiers
Message-ID: <2bab3a67-5c22-4de3-a0c2-4c1ffeda9196@sirena.org.uk>
References: <20250723090934.480055-1-nick.li@foursemi.com>
 <20250723090934.480055-6-nick.li@foursemi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bDG4Eff0x5LWHWp6"
Content-Disposition: inline
In-Reply-To: <20250723090934.480055-6-nick.li@foursemi.com>
X-Cookie: Forty two.


--bDG4Eff0x5LWHWp6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 23, 2025 at 05:09:34PM +0800, Nick wrote:
> Add entry for FourSemi maintainer and related files

This doesn't apply against current code, please check and resend.

--bDG4Eff0x5LWHWp6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiY/DIACgkQJNaLcl1U
h9C/DAf/c+pMZps4ZOjeRABAys7Ufdmf01FaAStuf3bt6kHmy3Zk2h8eybO8eR2a
kokB8+tZ4bvyZI6ZeRs1M1y9cAOy4oYBMHstVBt0rkefqkRmFkRBBsTbXxfrinZw
+cd90+2SYQxajYlGCyZmnjPr7Pny30ltdZKojmJwEenvaV9pb+evGmNv8N+l15ZK
CljNbM/hwMUGbDPOd2TFVG9CoQ9dM0eBBXZCJdtUn7JR7ka0HpCrAtIfa2+wUaby
0/UFpR3PYTOwrTXLtUu5uEWOmWUhkBKWPX9yOz7M8iGjEF8ZgBkiF5X97Rh9l2mf
1t+Lx9H6QtYx9livUIjvIJumXVot+A==
=bwy4
-----END PGP SIGNATURE-----

--bDG4Eff0x5LWHWp6--

