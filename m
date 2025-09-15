Return-Path: <linux-kernel+bounces-817538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B871B58372
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C6E1A27E28
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE42299927;
	Mon, 15 Sep 2025 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQE73fdk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228AC27F74B;
	Mon, 15 Sep 2025 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956800; cv=none; b=kD3rC+bXnKLdznOjshizKpRFNnDoF5PedwKCLCg+89T1s/tAJ2PUkbH4UHHfNwSJDp9lT6Yav+uVDaeWHsCMrE3cX2Bvf6m/o81pT0Miul4MvzUJxLRiC4epuKrzvkDuf9GPGV+V3r1Ozok4gl0rJrYzO+biowkn/Uf/w+qbK2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956800; c=relaxed/simple;
	bh=AJJvh5w1R9nXmEjFqkW+/hKYN+hA2MRPzYEwZlDdaW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXMrsZC0LCMlPecNz7VFLRTgSbIt4mSjotpLDW7r9qEkKbuoroOL0/o9ngGChsMK0AJS7KO/1COlHEzAwIMF9zJJZ0GBExGAR/bf4wkKKgyeZpISS/Oyel8v1su5AnG+wIr2lPLPB9+8cosfTUyEW4NnoFUYPgUKIKUlZw4mMJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQE73fdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D480C4CEFB;
	Mon, 15 Sep 2025 17:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757956799;
	bh=AJJvh5w1R9nXmEjFqkW+/hKYN+hA2MRPzYEwZlDdaW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XQE73fdk9HVoEr27DncLojCtI3t2zTiAJZ1jG90/3TAllz/SdD2TZT2bB8wHpyvGf
	 pPjbhfRitWlMchsQeePyfsowMhGqXLD44mmBjwFVszsuEk23JnZsTG2DL3nuzrUgTC
	 DnW4auiS/7v6cGYh4fwS0dNhxQ9y2bDg9gMMXzoOtT5Sk3dOLb0jsTn3Gv5OgwwHK7
	 nHBfHVsD31eRxYhrBfQP2hvUXdWwM2o4JFUyy9JAdFZ656ECly252AntEzKzWzVqMn
	 oN13ZXFhLWgxi2vkiaX57UpI9eArYgJTgG0kGIxjlMXmTH48GFN5YXg8wz4N4ChXuP
	 /JnHgVCCM7+Jg==
Date: Mon, 15 Sep 2025 18:19:53 +0100
From: Conor Dooley <conor@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Andrew Davis <afd@ti.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: gpu: img: Add AM62P SoC specific
 compatible
Message-ID: <20250915-raisin-placidly-d440495fdf53@spud>
References: <20250915143440.2362812-1-mwalle@kernel.org>
 <20250915143440.2362812-2-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OipVD4JuPL8umPoi"
Content-Disposition: inline
In-Reply-To: <20250915143440.2362812-2-mwalle@kernel.org>


--OipVD4JuPL8umPoi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--OipVD4JuPL8umPoi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMhKuQAKCRB4tDGHoIJi
0n0mAQDS/ZfHn4W7+zS0AA9bqS3UWH1Ag9jyYeFsCd98agveXgD/RF/LIo62w7p+
hPL25pXNWVcvLg8/Mu7ZElqxG4JDUAk=
=88JP
-----END PGP SIGNATURE-----

--OipVD4JuPL8umPoi--

