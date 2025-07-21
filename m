Return-Path: <linux-kernel+bounces-739263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32B8B0C408
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02EF33BD7BA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC5D2D29BA;
	Mon, 21 Jul 2025 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvQQNgZE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602DE176AC8;
	Mon, 21 Jul 2025 12:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753100766; cv=none; b=pxrNCZcrlFsTGd/pQksyjucymANBDh1qC09oxtB/wgR6AEDOPy+OSA/1uPjmO8+i8jsRNEPPLgXqoS0Rydj8eh220UWWt+bgL4alI4ElC1ulnLjszZzIY+m74cGAjCkqVknKSZf0qoKwDAWMn6gN4RQ0w6mkKIEmeQ39EGGa/Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753100766; c=relaxed/simple;
	bh=Vo2leQpJHEn6ju7V/6oT8q9qM3p5xBkpL6xkES47luE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLSHgUB1eFPxI2oUlaK1DHuxazh3sAlEBuqxYW94nzRJunQ2wEHVPuiNmUhnU708RYXEvce17RGMsUbhgFNpxib5RttQWAIcaiZk1pP4q8zcBKcms4qnvLhn9C3noxt0MQXapS6lkbqWY+GtRm/Ri94gfIQbfPN2bq8EAkU8shU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvQQNgZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6874FC4CEED;
	Mon, 21 Jul 2025 12:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753100765;
	bh=Vo2leQpJHEn6ju7V/6oT8q9qM3p5xBkpL6xkES47luE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jvQQNgZEC9pEajow0hPQBJU12cKqN7Zi76tILLVFc4fFpXn7hCG6FWTpgCuEPf+Cs
	 RKYzslSE+fvljo3b6QSeB7hlbGEjOwMcPjHdw263Hk0174rLCQpSY8MyvhhtXKdIkw
	 OLwPsHy2VxdrMtCe/2MHG4NcALxaRCje3jEhn9rnh8kGzvzJMtt1ydudk+LfrAbpjy
	 tF6m+ctwkLL44NllmoDNVjw4AMSVaDpf0hh4VsV/LL5/ZvEt8/YF9L6YCLbkkgl429
	 LzCS3psxoUo0fFvkQlQpbbNcEbcTxXVVZiwF8Z5rEjdcwVy+uKrrNavXfxk+E69G8F
	 inFGrFNACdEvA==
Date: Mon, 21 Jul 2025 13:26:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Joy Zou <joy.zou@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>, Ye Li <ye.li@nxp.com>,
	Jacky Bai <ping.bai@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 2/2] regulator: pf0900: Add PMIC PF0900 support
Message-ID: <6e3d022c-daec-4c3f-b064-33abdd7e2c93@sirena.org.uk>
References: <20250721-b4-pf09-v2-v2-0-e2c568548032@nxp.com>
 <20250721-b4-pf09-v2-v2-2-e2c568548032@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m10v8VWyX797GPl6"
Content-Disposition: inline
In-Reply-To: <20250721-b4-pf09-v2-v2-2-e2c568548032@nxp.com>
X-Cookie: Microwaves frizz your heir.


--m10v8VWyX797GPl6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 21, 2025 at 03:11:28PM +0800, Joy Zou wrote:

> The PF0900 is a power management integrated circuit (PMIC) optimized
> for high performance i.MX9x based applications. It features five high
> efficiency buck converters, three linear and one vaon regulators.
> It provides low quiescent current in Standby and low power off Modes.

This looks basically fine, one very minor issue since it looks like you
need to resubmit for the bindings:

> +static const struct regmap_config pf0900_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.volatile_table = &pf0900_volatile_regs,
> +	.max_register = PF0900_MAX_REGISTER - 1,
> +	.cache_type = REGCACHE_RBTREE,
> +};

Unless you've got a strong reason to do something else new drivers
should use _MAPLE, it's a more modern data structure.

--m10v8VWyX797GPl6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmh+MdgACgkQJNaLcl1U
h9Dolgf/ZXjoYj0D4u/FKUTn7FgSCHdoW8DT9uP5G+N9gvBWhQF19Jw6X6M/2Hfo
6AXoUrlTEqkdqr8fuBi9oBxGXy89ej94iiQABrOH7St3R/c7vokFZo80HSmmI4pL
3qpUPE0+wm0UlQfLq4URpTB7nG7aTUM/wb/cmRxQH13Jma0ZdI3Ub4klu/yd6gfX
97W67RQRNObtcQ/Qm6ZmauERjsPkil+onUwZagG2qNwqMN/VuyP+9NpnMit0fJse
txEg1WfmPNWCTOh/kCzEKrq6SD+ZnkxiIeQ+A0dJqyKAnHXK6JIqd7e+pzV/dH4X
BH7ZikaAFE/Y87yCGTVi48/coDAEGw==
=oygU
-----END PGP SIGNATURE-----

--m10v8VWyX797GPl6--

