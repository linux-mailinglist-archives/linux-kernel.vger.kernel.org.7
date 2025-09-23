Return-Path: <linux-kernel+bounces-829522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CB1B9743B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038671895C50
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDE9302174;
	Tue, 23 Sep 2025 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEPo+aRh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D7219AD70;
	Tue, 23 Sep 2025 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654024; cv=none; b=NLsQmg7XuTspEVY3ybRk0xtdwNp8GMPbGWASd9J94i5SFDuzSrcq9X9nzj0MTp8Yr42+Mw46FUMn4R+EihqHvM5jAXVk9fNYtMIItg1lJJZwYe29xQVx6xvy+zeFooX08Z7Y1p/30SXGC1gt3vLGe1ScDGr7hAiySRqMTLwqw58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654024; c=relaxed/simple;
	bh=XUTFqyLsRiUw4+Nvp52DmyRLNg8nvrGqeV2q6vnRQUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbDpanyK8yqr2y6LmKcR6DPBUUJQSdg/cPubhlQOo7d15rYpt6LVVWCCMn+sO0A3ClScXsLUT+gNslFhyMDdJrd0c2W+JMaj6LZ0u6Wnl3mPMULAaZn5t2KebgEu8g/NObLv0HLdPEg3Yb/InO5dde8ej5ZcJXaJQIQpjisEros=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEPo+aRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53752C4CEF5;
	Tue, 23 Sep 2025 19:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758654023;
	bh=XUTFqyLsRiUw4+Nvp52DmyRLNg8nvrGqeV2q6vnRQUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MEPo+aRh1jkDSXtKrDyj3L26eYMPhxNsgkT7S5Xf/1owH/w9y8Mn+e5D7+VYI5laI
	 XL8ibTOX4L9HebPN1wJr3iL79Uif/P5t65Dasdd//bVMhmo+Tv1kbPmisthASxKiyy
	 iNTOfU2//lRCwraOOgo+gaf7WHuKLmu0I8zBQxCv15c9PgIJWAghPaxKPZBym5w+A+
	 u2jfm1IpxwDhxHCTBgFGuVWXf4RLJzLdc7XjhRAr/s0oMV7yeHQj7GDGMRbkPohPEv
	 q15LzgmGwttYrHL9mTo20Vp3auNOh0mmKIhCzIOuC1Sjg0dt5EYrXARJMUvXCp19Qa
	 3STSUFJcZhl8g==
Date: Tue, 23 Sep 2025 20:00:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Rogerio Pimentel <rpimentel.silva@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, xiaofeng.wei@nxp.com,
	kernel@pengutronix.de, festevam@gmail.com,
	alexander.stein@ew.tq-group.com,
	dario.binacchi@amarulasolutions.com, marex@denx.de,
	Markus.Niebel@tq-group.com, y.moog@phytec.de,
	joao.goncalves@toradex.com, frieder.schrempf@kontron.de,
	josua@solid-run.com, francesco.dolcini@toradex.com,
	primoz.fiser@norik.com, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: fsl: Add i.MX8MP FRDM board
Message-ID: <20250923-closable-duvet-741100cc086b@spud>
References: <20250922232523.844633-1-rpimentel.silva@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nTbosrGlPtwTCxyt"
Content-Disposition: inline
In-Reply-To: <20250922232523.844633-1-rpimentel.silva@gmail.com>


--nTbosrGlPtwTCxyt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--nTbosrGlPtwTCxyt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNLuQAAKCRB4tDGHoIJi
0oYdAPiLZjc1vLxHXffdihKk1uGPPqVJhdk/F29RKN5MCd9/AQCLChUxXA/UMhul
cgT7Ah/f+QkxEN3CmyC1LRiLogkTBA==
=Nt33
-----END PGP SIGNATURE-----

--nTbosrGlPtwTCxyt--

