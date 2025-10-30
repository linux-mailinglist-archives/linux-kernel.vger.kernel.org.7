Return-Path: <linux-kernel+bounces-878286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FBEC202E5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 335AC4EB85B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E145F3546E6;
	Thu, 30 Oct 2025 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rA7J4Wn8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4C33546E3
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761829871; cv=none; b=OYQ7l91d10OLcXad0r4P9BzVao5SYgUUJEYgPQYedT9fTsC+LEQCsBYwdksnA7qnqqIKucfo4iYs5fjl2E9WQOC0UhlCZaQCB2XOFqkSQ3X8Q7cMANuFuDj+mG4kug6ZVCGGwLsq6Vq12A3zxuPbwncBr2ORkzMHbRtiwCM0+4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761829871; c=relaxed/simple;
	bh=cUfmunFmOKx1Kdn9OOY6+9IMgFP68sYho/khWU56jgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmZQdvsyjt4vFZ5L+MlLmvpg0/xjQuTOltW4zH6d70XNMXqhMhrJPIPqkpVZuORPnY+I9clsuUU9i+yXrNahy3QGlQeaoWDi0HRN6jfy4NiQvsV38cI0iy/NEYLag7lcET5XLVSV1C8mXNIkfQ0MIPaizDBp+s9EVUrACaokPT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rA7J4Wn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68589C4CEF1;
	Thu, 30 Oct 2025 13:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761829871;
	bh=cUfmunFmOKx1Kdn9OOY6+9IMgFP68sYho/khWU56jgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rA7J4Wn8SUe44IeZE5HtGG5H8CyV3vHl3VMZF+ZoYxFIR8fG2tAbMKlv44iMS9ZRN
	 yI9himw24uEDo20AfpucXeaqQp0Tog9INey2ObSrlEgwtyG4GkoyeUkyDJnT6p8vFb
	 VNN/0fBzLuuxRdyoLRWSNVvAW30OV4dt+vGpVNXPMQttnNFlhlhkAnsEnTYDRFMA0Y
	 9uZF2Tmxp/nOOLIdXwiOMmTo+4pBo27D/QOFYxNE7k+qAOz5qZKv/6/QYeyIBP44D5
	 qb11DKEmfCWaCg9zocdgZhiGKpjqE3UVVcIlh4Nq0FizwhNFvHYzGsDyG3490A0AV9
	 sx207KDsQB9Ag==
Date: Thu, 30 Oct 2025 13:11:04 +0000
From: Mark Brown <broonie@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Hui Pu <Hui.Pu@gehealthcare.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] Revert "drm/display: bridge_connector: get/put
 the stored bridges"
Message-ID: <7873e2ab-a8ea-4fdc-8534-746f91c8368b@sirena.org.uk>
References: <20251017-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v2-0-667abf6d47c0@bootlin.com>
 <20251017-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v2-1-667abf6d47c0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UaEwUEMakzRpcyay"
Content-Disposition: inline
In-Reply-To: <20251017-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v2-1-667abf6d47c0@bootlin.com>
X-Cookie: Marriage, n.:


--UaEwUEMakzRpcyay
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 06:15:04PM +0200, Luca Ceresoli wrote:
> This reverts commit 2be300f9a0b6f6b0ae2a90be97e558ec0535be54.
>=20
> The commit being reverted moved all the bridge_connector->bridge_*
> assignments to just before the final successful return in order to handle
> the bridge refcounting in a clean way.

Is there any news on getting this series merged - the currently broken
code in -next is causing boot issues on several affected platforms (eg,
Rock5B) which is disrupting other testing?  If the other patches are
somehow causing issues could we perhaps get the revert in to fix the
boot issue while those issues are resolved?

--UaEwUEMakzRpcyay
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkDY+cACgkQJNaLcl1U
h9CppAf8CCGhznw7w0TXi5YjdWcrrOmjeDEoIv1HKQcYKRGO+/tahZ3lbX8bnuLN
CpBj57Mzat1s/wXgZzlPaXSS2rbb1Jq6zNTjfZ46NV39LV8cyzV7u9rZx8ldGp9q
rIZY/xPwufbrGAc7M8J6JyYDUJGu4RFFlAcvhppN3wbyU42Om+3ZFqCp8lZlN/tT
suYQK0vLrRIiZB4FjQgUzSULdO1FFphEd7Zc0H/7CEleFUIraStxtd6d+TWh3iq0
pYJXU0xezs+G15RjdmrRGazvhlVG6BXqn+GjS1aVKTyk+w5zSSc9mOuBn4U2gsjG
YfwhD1DqMRKDOzB3Cw5gxk3yR2YQrg==
=6XLc
-----END PGP SIGNATURE-----

--UaEwUEMakzRpcyay--

