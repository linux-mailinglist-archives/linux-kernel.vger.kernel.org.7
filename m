Return-Path: <linux-kernel+bounces-741953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08F4B0EB29
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8222A4E2942
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4F126CE3B;
	Wed, 23 Jul 2025 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRzH6EUa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035A1A95E;
	Wed, 23 Jul 2025 07:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753254125; cv=none; b=dO420AGM70UUwD/HzAXSiOlnQwDGMT8RNnX/81RfIPXHMAOr8N4/g7Lres/Xnf/Kxj8UvlLCx3/GQIS6BRK+UK4ruvmcn71Pzq7GpzUPrBMAgUiHTNsTFPIgdVvROvS0yitPayYlx/WPsBpNq+wtm0Nth4b1Q0Cw/V4FOzx3OIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753254125; c=relaxed/simple;
	bh=Fpw/c/5kjWltygJbu4uMApywQxizJHEZ9+QAerRo8G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4V7fpvQwwwVZavCZBtdDtBVfzPWGQ/9CxqOwd9MKMdTkU7uE5cEHYCApUS6OYlpdROK6Jf8jp4YhSLPdwbtxAgdEZ/tx1hDy6JZBR+z5c1ykeK33KS0Mi0gLilzLURA38/+Xqx1CmTlSYsmrokmO7uvA0i2GznPuU3+BLftqF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRzH6EUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8CFC4CEE7;
	Wed, 23 Jul 2025 07:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753254124;
	bh=Fpw/c/5kjWltygJbu4uMApywQxizJHEZ9+QAerRo8G8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nRzH6EUamh0byFfsvuIMPVTeKD0ba7KG0PKDyFH5/elK0LmSMIxADrSkcVmNaSQ6W
	 XmLAFX5AuwuF1adUhQSRoxBmZuvrl/MMmbRHhgEQinVWJugDcnRzOWJ4+gxuAUJ2pD
	 sAoonuEf96mCvDfiQg8oOo/aDNzLBi62AcHXIP1OrFh59CWmDHb6f+sK9VBfNg9ULl
	 mbh9R2hSV+4kEWUAERv0Yeuuw0rqJiar2zLA4iesvh9Y9BOR5W9o8N3fvlB3gL+5NZ
	 1/f7iqlZRAwE7vr0stisUlcfFhFckyObHhN3c6iWzfnxWC0gD86Q72iSzVt6VcptYa
	 dXzWmupArPaLA==
Date: Wed, 23 Jul 2025 09:02:02 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Otto =?utf-8?Q?Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Kevin Tang <kevin.tang@unisoc.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/15] drm: of: try binding port parent node instead
 of the port itself
Message-ID: <20250723-bandicoot-of-simple-support-b42bcb@houat>
References: <20250722-ums9230-drm-v2-0-054276ec213d@abscue.de>
 <20250722-ums9230-drm-v2-4-054276ec213d@abscue.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="fojbrzpoh2sk3fsf"
Content-Disposition: inline
In-Reply-To: <20250722-ums9230-drm-v2-4-054276ec213d@abscue.de>


--fojbrzpoh2sk3fsf
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 04/15] drm: of: try binding port parent node instead
 of the port itself
MIME-Version: 1.0

On Tue, Jul 22, 2025 at 04:41:06PM +0200, Otto Pfl=FCger wrote:
> The drm_of_component_probe function is intended to bind all devices in
> an OF graph given a set of ports linked using the "ports" property on a
> main device node. This means that it should also bind the components
> providing these ports, not just the components of other ports connected
> to them. In order to do this, it calls drm_of_component_match_add with
> a pointer to each port node after checking that its parent node is a
> device.
>=20
> However, when given a pointer to the port node, the compare_of callback
> does not match it with a device node and thus fails to detect that the
> node belongs to a component. Fix this by passing a pointer to the parent
> node here too.
>=20
> Currently only the Unisoc platform driver relies on this feature, which
> was previously broken and is fixed by this change. On other platforms,
> the "ports" property points to ports that are not part of a component,
> i.e. the components only have indirect connections to the main node.
>=20
> Signed-off-by: Otto Pfl=FCger <otto.pflueger@abscue.de>

Should this get a Fixes tag?

Maxime

--fojbrzpoh2sk3fsf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaICI6QAKCRAnX84Zoj2+
dtvVAX9udslNDQ57hVZEjNb1iONfXuGwnS/BUlBV4LARSgg8P8O37+c2S9O1SiBG
/Bn03MEBgIsfznoSYFHNIZtYf91r3YxrZIm0wFxg6YtmePsN1AxF/tnoAIC93UHW
GD21BzVvbA==
=dERO
-----END PGP SIGNATURE-----

--fojbrzpoh2sk3fsf--

