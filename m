Return-Path: <linux-kernel+bounces-865638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9685BFDA77
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FBD71A6099E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDDE2D836D;
	Wed, 22 Oct 2025 17:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQa0Q8Qk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656D22566DF;
	Wed, 22 Oct 2025 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154985; cv=none; b=F9jlOr4cwKVTJMjz7PV9jUaMSCY1217cTCfW3A04WN6Uz5oAKZxGPPTPrhYu4IXWGE1hBVvaP8bgjfei/aSMu4lUYsYRtkvxvyJH2KRNlbiSnUzdbuPKqYjUYoKSxrUC8sx3aSBb082XZkRYzt5CAJtpAl3v3iNb8eZcRfayw4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154985; c=relaxed/simple;
	bh=8cgZeKAMGPlRgEjWBkK7WS/8uFyCBbFVbv60l3Wo1wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRhkefBJeIjiG2iunXJwPLlvatpc4qtOeOVTdaHobqOewbEnjNb5lVDmdTeUGe93gI7G+YU1aV9laPHj+C9jnSyLtb1kB7EmYGNlq7Gy+X/gq/Pj5p4wBVvTmVw4h3qd7KeDyWJaQBGR04aEbj0VwUGTBVIxncF8MtO3PZTV4ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQa0Q8Qk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24339C4CEE7;
	Wed, 22 Oct 2025 17:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761154984;
	bh=8cgZeKAMGPlRgEjWBkK7WS/8uFyCBbFVbv60l3Wo1wg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fQa0Q8QkLSOV0X8dmllokpPrd5FCEHOn+J2meQuaZjTM14DWbc6Nkc78KkCh60WZt
	 L7S3cJx2XVSXAL1qflRGWoEgVtcQNzrlbTsWpf48NVd0As7tJIbDVMINUdsDqOQaU+
	 7DsQMolDHhgzMsXf55cs8vphra177SqHgwBHemUPDzCOmogNJirFxRHnD++hyZMc5W
	 zCVf8aw60KVgkq61q08ewdVDH7p8l9rPBh9B+oDtF23p4H/VeXwy7/81a47DyccugW
	 lzg7Wi3anzmuFKlX7U9KAmp0VOIVsOIidSTN+k9wRP7Q5D8RAcgmq+nm4GbLgEK2ut
	 WhmaIGLSDE0mg==
Date: Wed, 22 Oct 2025 18:42:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/3] dt-bindings: display: panel: Add the Leadtek
 LTK08QV25BYL panel
Message-ID: <20251022-darkness-defuse-6504a820c648@spud>
References: <20251021073408.195959-1-herve.codina@bootlin.com>
 <20251021073408.195959-2-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jwrhqCsj33Gacxlu"
Content-Disposition: inline
In-Reply-To: <20251021073408.195959-2-herve.codina@bootlin.com>


--jwrhqCsj33Gacxlu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 09:34:03AM +0200, Herve Codina wrote:
> The Leadtek LTK08QV25BYL is a 2.8" 240x320 DSI display.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--jwrhqCsj33Gacxlu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPkXogAKCRB4tDGHoIJi
0rm5AQDBeaboyDOSZC/aXcCqNi6TUmP3JhPlvaDgxuah9wCgyQEA9G2hl02CYcRN
2A9DgmWaIFWTifkheRkHWvklxuDnLww=
=QIKs
-----END PGP SIGNATURE-----

--jwrhqCsj33Gacxlu--

