Return-Path: <linux-kernel+bounces-880014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1FEC24A7B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11EE31A25017
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF6534320F;
	Fri, 31 Oct 2025 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USDSA+cG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A5A277026;
	Fri, 31 Oct 2025 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761908314; cv=none; b=q970AYMmk7I8V5VkLefhbdLsxI0k+Y4fNI/9Ro/7RcZci1ZGUFyCZiQTtV+o4hBCUXjwIkg5W933b3pGPfVkcJZevWlcxF7DcEMSikR/t0YudAtR31/kIkJyK5hxWPkBdjT0/juM0fEPDFkm4FXG6yGg2DMT7uuKj1zTfjQjAak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761908314; c=relaxed/simple;
	bh=LpJlMhIspbUx/F0UxN1zmCEQJYnhFqHunkuXu4FDahw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFst/7ucOwF/EcFoO++N4FgKS3xu07x0DJfrbVCAF87f5S+A8PJ/uAd0NHGkFXG3LTGi6tUR/W4ZPtLfkcNzho5Irc3GcPGvX14pU8L++6tIP/wgGCjMjDJH0kImir5nCXeGUEG4yIFOB01cbJqoWaCoysxaPk5dXPeJmcmW3CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USDSA+cG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997A4C4CEFD;
	Fri, 31 Oct 2025 10:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761908314;
	bh=LpJlMhIspbUx/F0UxN1zmCEQJYnhFqHunkuXu4FDahw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=USDSA+cGrJsbV4SfrArJT9UeuUOBBAM7kuSDKgISSb3ZnEgJGLXh8TkjAvXKVk7xr
	 6Da2tW9iYt/uCbZYRfsDzpuukpW99fukSAJ6lfBo/o0EJF2EGHYag/6C8hwxdQAdVL
	 0TiRBVZ8A2q6/Pt2BTSsldapIL7vtul06kMM077jeUstGgEJvESewl7+/HsD7GvTD4
	 Bx2DOKQ07GV6bq5qFI6sCXgfZ6jfgsZiNrLhqNQgKYPyTwmHGqVRgoDVif7wZ9ZB+o
	 YqVbvd9AtKIejRvD6oUtQwxtQsceAmRqM7mE95aerQr+NKX0Gw6gyWmXIPfzLzRiQf
	 n5C3XWgBXCcgw==
Date: Fri, 31 Oct 2025 10:58:29 +0000
From: Conor Dooley <conor@kernel.org>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/7] reset: mpfs: add non-auxiliary bus probing
Message-ID: <20251031-mosaic-trimness-d683527a6866@spud>
References: <20251029-chewing-absolve-c4e6acfe0fa4@spud>
 <20251029-macarena-neglector-318431fec367@spud>
 <a996e76e-8201-4b72-b4fa-0ea9ac62e6b1@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2eMSdNOwjosdKxAa"
Content-Disposition: inline
In-Reply-To: <a996e76e-8201-4b72-b4fa-0ea9ac62e6b1@tuxon.dev>


--2eMSdNOwjosdKxAa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 09:20:17AM +0200, claudiu beznea wrote:
> On 10/29/25 18:11, Conor Dooley wrote:
> > -static int mpfs_reset_probe(struct auxiliary_device *adev,
> > -			    const struct auxiliary_device_id *id)
> > +static int mpfs_reset_mfd_probe(struct platform_device *pdev)
> >   {
> > -	struct device *dev =3D &adev->dev;
> >   	struct reset_controller_dev *rcdev;
> > +	struct device *dev =3D &pdev->dev;
> > +	struct mpfs_reset *rst;
> > +
> > +	rst =3D devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
> > +	if (!rst)
> > +		return -ENOMEM;
> > +
> > +	rcdev =3D &rst->rcdev;
> > +	rcdev->dev =3D dev;
> > +	rcdev->ops =3D &mpfs_reset_ops;
> > +
> > +	rcdev->of_node =3D pdev->dev.parent->of_node;
> > +	rcdev->of_reset_n_cells =3D 1;
> > +	rcdev->of_xlate =3D mpfs_reset_xlate;
> > +	rcdev->nr_resets =3D MPFS_NUM_RESETS;
> > +
> > +	rst->regmap =3D device_node_to_regmap(pdev->dev.parent->of_node);
> > +	if (IS_ERR(rst->regmap))
> > +		dev_err_probe(dev, PTR_ERR(rst->regmap), "Failed to find syscon regm=
ap\n");
>=20
> Do you want to continue registering the reset controller here? rcdev->base
> is NULL, thus the reset controller ops will fail, if I'm not wrong.


Oh, good point. That line is missing a return.

--2eMSdNOwjosdKxAa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQSWVQAKCRB4tDGHoIJi
0kU4AP0auWGgL7fvd2ZpPml/M7wJExlNMK6dDbH0jluNcknvYAD+MyFTGGUMPK0D
94ntVM/k3LljGZVFZDJ9Lovn1G4vFQw=
=xnj6
-----END PGP SIGNATURE-----

--2eMSdNOwjosdKxAa--

