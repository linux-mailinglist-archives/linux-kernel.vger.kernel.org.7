Return-Path: <linux-kernel+bounces-791976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B40EB3BEFB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2755E2984
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107B7322A2D;
	Fri, 29 Aug 2025 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K68jz20C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691D8322773;
	Fri, 29 Aug 2025 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756480488; cv=none; b=gyLSxnqY8X6BVo9vHD4dszNO9sdZtnZ7g89ufva459PdEbOLvbVrg0lLHzGTIpIGlpxZhQplpRlaMIGhcC+oPh83jOkmToD1C62KOYmEP3clduIZGOuxvWb1XKmI+dkjZgeVg5SXJhucmEJt4BfoWuFZG60Nh3w9enWwF2+r5zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756480488; c=relaxed/simple;
	bh=k+zd4T4lSzfL8coBryVKuV0leuYZBzr8PX3IWC/2ywA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVX0tPNIXIYfb0PZroSS3wZe43FvELwnJyEyoc90q2UDI93kIzZ88caETwNC3H3+ZS1FMkIi1CQsHugTVTBHiBiI5ePjyPPXT9X5Y/DEaOeTnA8U27E7VIiReEKbu5WuVbym8HzqiW4K8oU+UcHqmDFaM1R2yGAJLi7jg+5e0kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K68jz20C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90DAC4CEF0;
	Fri, 29 Aug 2025 15:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756480488;
	bh=k+zd4T4lSzfL8coBryVKuV0leuYZBzr8PX3IWC/2ywA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K68jz20CnBpOVER+ZgjqfAj4TaAjAF07Z8tT1lIK6bSlLdqjIqb97K/dXM1XdHh4Z
	 SUvKQWTf/s96oTNV86+bHDFZ0NEjH3pcwNl5ANoEssKKhyoaJiGsAp3+tPT1X/cVBy
	 R6h1mj4BbUcRCHcyzLFr/knrF5USp9y5DwbslgDVr7dyDBRSheSmc8Xe12+0L7ph8J
	 C3dWO9SsUr332yNURgf6DcgpK+8C6OSBxUSux+A4JJpI2gj3wsKL/OIs4+hqYn2CXA
	 8AH53kSlJ4T9/0UkD6wcjJKMyU1KlG0scfkWP2OukYkdHNZNcw7upVhqiRE6LbXI7C
	 HZvTTybTwTVDg==
Date: Fri, 29 Aug 2025 16:14:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: panel: lvds: Append edt,etml0700z8dha in
 panel-lvds
Message-ID: <20250829-geek-unearned-786928b128af@spud>
References: <20250829-drm-misc-next-v1-1-fedb48cf50dd@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3aIRal9bDEDOJiKa"
Content-Disposition: inline
In-Reply-To: <20250829-drm-misc-next-v1-1-fedb48cf50dd@foss.st.com>


--3aIRal9bDEDOJiKa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--3aIRal9bDEDOJiKa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaLHD4gAKCRB4tDGHoIJi
0gCIAPYv2+V8kpg5sN3cfWsDPpNNmCuk3Nvh3+yfi2YaQtm/AQDcZ0ZEpTENDEoa
+f5cE4x5RJxDyD/okF68lUmTvCj9DA==
=7dgQ
-----END PGP SIGNATURE-----

--3aIRal9bDEDOJiKa--

