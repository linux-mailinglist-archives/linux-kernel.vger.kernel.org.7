Return-Path: <linux-kernel+bounces-890837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A06C4123C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 18:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE65562739
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 17:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED613376AC;
	Fri,  7 Nov 2025 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liDl2Xni"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F0833711C;
	Fri,  7 Nov 2025 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762537509; cv=none; b=ArPa7m/1DtsNW9xXNw6wblE+wSrJFfbMSuJQkfVOpJ0ZWzJbKQvdJfkE/TuxaIPWdKl4GF+B/oc1lkjTf45ui5h9D+G59sxn3MBF0Qz8WAR4ZYQ1E0uTTqEZXfMpNFbq3GJiQgZIy3liCxBS5dGWtTPU/yOyFPXc/qeZvdV5pWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762537509; c=relaxed/simple;
	bh=8UBP4r5CsBAmdMBC7TGsubOEbdmbQ9s7WdxZkROZk/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rp9hVburdg4bA4Np8X+c++3fYrvL6YHX9isvJCVXeymB/JV8btZSdRnr6tFFP8VP07Z9QTnqPOdeA+Y00i1s8h+bKD6Ta2ivL3Poj1C3byUiils/Lx09lGXogvnyz8L4jnicAOQNsD2VSincPGVjxJHapLIYuBJ4r9qFAFm52Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liDl2Xni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC82EC4CEF8;
	Fri,  7 Nov 2025 17:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762537509;
	bh=8UBP4r5CsBAmdMBC7TGsubOEbdmbQ9s7WdxZkROZk/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=liDl2XninbWYIcqybmOwmVOzJLQd/CoAGBZLnfDn3BSnQlhAmpHku3GmkbZDBWCsF
	 ej3bn4e0fR7wpfU60f+u2Zy+BNdbyS+NTlfS/NkMFfIJ2o3IuEfhrnlHj0bcztYHb7
	 NZ7G+o3qUwk0quMF+K+pMXl6sWa8l4eZWbGxR3/BxnihXtdXjeW7nMtEHED7v7i/Cy
	 I3CaF9gPPpcZi8m/A/UVDF0Yzt7PsOIpBAkRVu31XQ/hXxgIbeBYf+M+m/1IRl5HTn
	 A2eTVfG/MxD9XTEdJ8fGDZ05KCZoEQV/iyGlIjqmMh/StX0+ujfcarDZEPeX2UyElz
	 Zu++h6f3uhhbQ==
Date: Fri, 7 Nov 2025 17:45:02 +0000
From: Conor Dooley <conor@kernel.org>
To: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, venkata.valluru@oss.qualcomm.com,
	jessica.zhang@oss.qualcomm.com, Yi Zhang <zhanyi@qti.qualcomm.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: bridge: lt9211c: Add bindings
Message-ID: <20251107-batting-wimp-b98f79cf6318@spud>
References: <20251107-add-lt9211c-bridge-v2-0-b0616e23407c@oss.qualcomm.com>
 <20251107-add-lt9211c-bridge-v2-1-b0616e23407c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J84/gdKCYWS1iHDH"
Content-Disposition: inline
In-Reply-To: <20251107-add-lt9211c-bridge-v2-1-b0616e23407c@oss.qualcomm.com>


--J84/gdKCYWS1iHDH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 07, 2025 at 06:32:58PM +0530, Nilesh Laad wrote:
> From: Yi Zhang <zhanyi@qti.qualcomm.com>
>=20
> Add bindings for lt9211c.
>=20
> Signed-off-by: Yi Zhang <zhanyi@qti.qualcomm.com>
> Signed-off-by: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
> ---
>  .../bindings/display/bridge/lontium,lt9211c.yaml   | 113 +++++++++++++++=
++++++
>  1 file changed, 113 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt9=
211c.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt9211=
c.yaml
> new file mode 100644
> index 000000000000..619f718618d6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9211c.ya=
ml
> @@ -0,0 +1,113 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/lontium,lt9211c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Lontium LT9211C DSI/LVDS/DPI to DSI/LVDS/DPI bridge.
> +
> +maintainers:
> +  - Marek Vasut <marex@denx.de>

Why is Marek here?
The patch seems fine, but this is confusing.

--J84/gdKCYWS1iHDH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQ4wHgAKCRB4tDGHoIJi
0mh7AQDLr/nyRgvC1Ynncg3iPh/plfKOkx0hTqa5hBFd+ADX7QD9GZ0tkFjapgio
gGLJ2bq5QYL2qjNC3za8P8n5yFrcXAc=
=AjS0
-----END PGP SIGNATURE-----

--J84/gdKCYWS1iHDH--

