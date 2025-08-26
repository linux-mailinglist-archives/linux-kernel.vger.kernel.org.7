Return-Path: <linux-kernel+bounces-787121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFDAB371A9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 880008E6E12
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FB01A76B1;
	Tue, 26 Aug 2025 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2XFkEO5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2227D28135B;
	Tue, 26 Aug 2025 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756230444; cv=none; b=rleIoUoe9QSGDIVG6ad7MuboHjMK/YTd1cdWhQlp9R6McAyd+kcuJEzftJoANJxoTGvXpzJc7p1JTWD1tkZKtFZqwbT1jjC6fcpv2/njnZSVzHylBDcngO/x/qxH4BfXmy9j+1DUsFz9tlGaem0iAUjrc7HMrvOCvJ+Z2xfOpHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756230444; c=relaxed/simple;
	bh=QdhdgGupXvzMsxi3UpqcbF6p+Oq4kYam9Hl4IiM7fG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcH3t2ZkJ9vXElVp/SYLfrxPcuV96ECJ68cvNALYjB7p27e9bXe+Mbjoo4q2X0m/Ml1/+fn7eaG/Pelzh3z7GmCBHqqTgMyXdEHyty0+aPr5bATRoQpwsuGDcUukk5U9ChvtFtUlasfl9DNOeSmYX42YOZO/BTbcwxF/sy6n6v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2XFkEO5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1C6C4CEF1;
	Tue, 26 Aug 2025 17:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756230443;
	bh=QdhdgGupXvzMsxi3UpqcbF6p+Oq4kYam9Hl4IiM7fG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q2XFkEO5hy3tZUNuy04P05Aej+NwMNzR1V1UUeGsA/fYKNOeEEhmbJcM5+vZ8ng7b
	 rx7xMK0sab0xgNWwV/j0jDXaGoAEcg/LkNW31RQVhyXVr2hoBBh4wTI2dx0gOjmoDG
	 QB5kLtfemgBrb79VykIFQHNzIEIz5nFVjEsS4RVJoUPG0yMmzFXvjf/2flk1s7ccBk
	 pIWbKD5uIpYgoOyTp3VG4sGVRtXQI0CpFhPjp7dFr/pZGlJfychkpuXYewWdrNhgyz
	 wjt2dO+pj1Mj9oyQHoQzi6e76GYtZcb7WCFH0fYUa62OCUExt4FoTWVjzE5Ea9mRuu
	 Cux9TYhmvn/8A==
Date: Tue, 26 Aug 2025 18:47:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: panel: lvds: Append
 ampire,amp19201200b5tzqw-t03 in panel-lvds
Message-ID: <20250826-fragility-darkish-715589203b6c@spud>
References: <20250826-drm-misc-next-v1-1-980d0a0592b9@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9HnhkVHANMCSoXTS"
Content-Disposition: inline
In-Reply-To: <20250826-drm-misc-next-v1-1-980d0a0592b9@foss.st.com>


--9HnhkVHANMCSoXTS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--9HnhkVHANMCSoXTS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaK3zJQAKCRB4tDGHoIJi
0mGVAP9Zv6hXywWIK1K/hJyxUZD1xROsO1NNAjaR7gjBzzzg8QD/TGGd8P9i7J6r
x3M30PfiUvg1IznscukX12dypHsvAAs=
=fpYc
-----END PGP SIGNATURE-----

--9HnhkVHANMCSoXTS--

