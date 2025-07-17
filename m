Return-Path: <linux-kernel+bounces-734740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C03B0859A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15F64581590
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6083F218AAB;
	Thu, 17 Jul 2025 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGPR5+GT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9461D7E5B;
	Thu, 17 Jul 2025 06:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735424; cv=none; b=SG4mNOIqIsL4WqNXVIAD/2+vzRZ3AksW2nzAtukzXQf2kxpHYWR7+6mP6UFNTvXvL6+BIIUg7dY1pM8YRh4ty5QKEQm7Un8ffy19NXVUk8Q0zlH+wKTLh2aFx1BEcok4hfpXf49RHCqRfMSOj+Z0cZo8LFdVcLeE58UFl4b77JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735424; c=relaxed/simple;
	bh=7UNIxyfgxpuJvviww/9S/FSs6awv1lrEbpiKGrlQfIo=;
	h=Content-Type:Date:Message-Id:From:To:Subject:Cc:References:
	 In-Reply-To; b=XfvyUvTeB+6RDj+LyZxq28EjRatpIdZ49QrjQBdik1iDFMKSAMuTGICQsSLZ1KxklH/0z3+8ldc/yYLSD+5MMpAhD839JU4l/f4zGIknBTDf1oTIJ2hbKwWR27TnkpJKyIgN6gSsDl26PqPxIdTbtYKP3VGoYVtJUfZEFIhGPT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGPR5+GT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB41BC4CEE3;
	Thu, 17 Jul 2025 06:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752735424;
	bh=7UNIxyfgxpuJvviww/9S/FSs6awv1lrEbpiKGrlQfIo=;
	h=Date:From:To:Subject:Cc:References:In-Reply-To:From;
	b=LGPR5+GTb/BQ6QwL6rq/umhI9EbasKfBVpAbuqgSa36ENcO3R2YGSTF07mI1KUTPW
	 puvKRTk/9ApIeaBeabcbSR34Tfc088hplI1iseH+UlCujENqKajzeY784YeyXtVfRS
	 FCh1ru2LAnQ4RVO51IxZSPSbYaSOI+JSdl8eJ+lMB8CDmLjlUW62eKIZyKIxtRGgR+
	 2nqNQ7cu2g8tCHQZmxJv3h60D/y2bbkm9qz3DqXpy7IFqVqTnaQI7lIeCDASfy25U6
	 BJm1n/WYGeS1aIgb6KJamwa5Dc0PW88eXb7sViBtdRQJolYLg+PVQ24Ysq5G0NbpXZ
	 lw+XTDM4ayzYw==
Content-Type: multipart/signed;
 boundary=b95479761a3121fe8ae2e0878dabae26aaef421d356b40d4b638e9ad269c;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 17 Jul 2025 08:56:59 +0200
Message-Id: <DBE4UO2RGAYX.17V1DAF8MQYJM@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Andrew Davis" <afd@ti.com>, "Frank Binns" <frank.binns@imgtec.com>,
 "Matt Coster" <matt.coster@imgtec.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Nishanth Menon" <nm@ti.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, "Tero Kristo" <kristo@kernel.org>
Subject: Re: [RFC PATCH 1/3] dt-bindings: gpu: img: Add AM62P SoC specific
 compatible
Cc: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
X-Mailer: aerc 0.16.0
References: <20250716134717.4085567-1-mwalle@kernel.org>
 <20250716134717.4085567-2-mwalle@kernel.org>
 <d76c0299-a19d-4524-b026-79874fee10ee@ti.com>
In-Reply-To: <d76c0299-a19d-4524-b026-79874fee10ee@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--b95479761a3121fe8ae2e0878dabae26aaef421d356b40d4b638e9ad269c
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Andrew,

On Wed Jul 16, 2025 at 6:17 PM CEST, Andrew Davis wrote:
> On 7/16/25 8:47 AM, Michael Walle wrote:
> > The AM62P and the J722S features the same BXS-4 GPU as the J721S2. Add =
a
> > new SoC specific compatible.
> >=20
>
> If the GPU is the same, and the integration is the same, do you really ne=
ed
> a new compatible?

AFAIK it's good practise to have one to have a base for future SoC
specific quirks. For example, there are differences how that IP was
integrated, i.e. the am62p doesn't have DMA coherency (for this
peripheral), the clock is dedicated and there might be more.

>
> > Signed-off-by: Michael Walle <mwalle@kernel.org>
> > ---
> >   Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml | 1 +
> >   1 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.ya=
ml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> > index 4450e2e73b3c..bad3e412a168 100644
> > --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> > +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> > @@ -23,6 +23,7 @@ properties:
> >             - const: img,img-rogue
> >         - items:
> >             - enum:
> > +              - ti,am62p-gpu
>
> There is a check below based on SoC compat:
>
> >  - if:
> >      properties:
> >        compatible:
> >          contains:
> >            enum:
> >              - ti,am62-gpu
> >              - ti,j721s2-gpu
> >    then:
> >      properties:
> >        clocks:
> >          maxItems: 1
>
> If you do add a new SoC specific compatible does this check need updating=
?

Thanks! Yes probably.

-michael

--b95479761a3121fe8ae2e0878dabae26aaef421d356b40d4b638e9ad269c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaHievBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/i5owGAm2rEvW9RmbxVokhD0dJUoLHn70z6itL9
b5tCySRPREmz+X0GKE03SJhXp9kaOms3AYDO/Zxy0UXbuWjjBW92jHZ9S/6Wo2dM
tpjaLZDW7YArWfJEju57j2GH/KEnPp9KQ3E=
=VcfS
-----END PGP SIGNATURE-----

--b95479761a3121fe8ae2e0878dabae26aaef421d356b40d4b638e9ad269c--

