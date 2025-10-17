Return-Path: <linux-kernel+bounces-858456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 788B3BEAD94
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2316A5C0280
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAA3299AB4;
	Fri, 17 Oct 2025 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3QIcPU3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292D025BEF8;
	Fri, 17 Oct 2025 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718680; cv=none; b=nt+A25Pv4FvnksOiwEU8Bs0gSh9wq1n7S8GGspnAugCElvIf2Xt/lHTtnll/h1AfsHC9heqn//8cc6Eo5Sjb6w3EZm2yTZeeguIfplr2YiqBoEJo6kZ15aBCgS1SxScgsBL2g/m9f6sB8HbMczR4Ifs/ewFIBDcAZJZBeOQYzv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718680; c=relaxed/simple;
	bh=5xMasA4dijTH+D4z29yAG7yMdBg2ZcUrxcBTkA8e/H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgWSahmvCRYDAfsLRNkx0j2PItgCPU53ooItt6m/v0lXniJ9tpkz8MPfS2em6HxQpUF4LRXFivyX0ci+JYUgZaS83TeKbpa9widDUtQHMQw0iLl7CHbMrgWMj4jQMNlwFLy7vPiVpai4aSghcVLz5uqUpFbBymYxZaHFCP6cYK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3QIcPU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2D7C4CEE7;
	Fri, 17 Oct 2025 16:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760718679;
	bh=5xMasA4dijTH+D4z29yAG7yMdBg2ZcUrxcBTkA8e/H0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F3QIcPU3p7RNzyBPQZelatj72PHZvLBO0v7WMQEHKWQkcWw0aRP9NCI45+i4R/QOX
	 xpxQTrVMHpjoS92aFDhaWMEkeF5iUPP9dYnN8ZmaDz1a/+gT/CuePd7sxCfx6AWG+u
	 yD5ltB9eikDPFmSFMKlz5rMyye1n8PgmFkxSxtBDociP9AI6amRnnKUPFhoIzXzR2Z
	 zFvBs7up8qd/VnxeQZUpRilr8lb36OzTZdMjRVzfttLVT1gfLOVT6NRCb8JrCm1/Q5
	 QXzsuwHApBuF7IZmNMJFHht/hBfG2gWtWY+5vsuw45LG5ItzUCua1dX7rV19vEI+CL
	 RMU+fEhy6ObCQ==
Date: Fri, 17 Oct 2025 17:31:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 06/11] ASoC: dt-bindings: sound: cirrus: cs530x: Add
 cs530x variants
Message-ID: <d51da899-cd16-4d5d-a754-e6fecbdab2e8@sirena.org.uk>
References: <20251017161543.214235-1-vitalyr@opensource.cirrus.com>
 <20251017161543.214235-7-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P8YSWoU5Aja4b2E5"
Content-Disposition: inline
In-Reply-To: <20251017161543.214235-7-vitalyr@opensource.cirrus.com>
X-Cookie: Androphobia:


--P8YSWoU5Aja4b2E5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 17, 2025 at 05:15:33PM +0100, Vitaly Rodionov wrote:

> --- a/Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml
> +++ b/Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml
> @@ -22,6 +22,10 @@ properties:
>        - cirrus,cs5302
>        - cirrus,cs5304
>        - cirrus,cs5308
> +      - cirrus,cs4282
> +      - cirrus,cs4302
> +      - cirrus,cs4304
> +      - cirrus,cs4308

I've not gone back and cheked but I suspect Krzysztof's complaint on
prior versions that he wasn't happy you weren't addressing was that
these enumerations should be sorted.

--P8YSWoU5Aja4b2E5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjyb1EACgkQJNaLcl1U
h9BnNAf9FnyhKYn1KSX/ST6QBpGE9aa0GovWGEvRYa1P0k/2X0snV9ucWxg6U8ok
QbjVVfcN0DSpwgyc4JStp2KuwxtNypL+Ot4Tx0hy8h3KToDEvu6VmNhRzPYy/jX9
55oG/ZlmczBIcTaBkio5H5UsdiaGizWD0oh6T8hmvNOnhRZS5Oljfi+CNM140u68
v4mozydi112NiCnQ9GWbOAUci96SevjcbxRDVlTB5iNqatYtvhXLeJCsVejzZgfp
cZz8t+WEBvO7xBAv3pKTrP68jyeomWIpNvEbOETtxGUeRB/OFUJf+EdkwvDMDP9r
zKUv4J/i+NWVO2F6VO4QzlxqvQ39nA==
=p2yG
-----END PGP SIGNATURE-----

--P8YSWoU5Aja4b2E5--

