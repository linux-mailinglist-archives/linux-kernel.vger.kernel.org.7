Return-Path: <linux-kernel+bounces-748389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AF7B1408F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB2016433F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2671F212B28;
	Mon, 28 Jul 2025 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWGGmqx6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8517A274B42
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753721104; cv=none; b=hbPb4EbQDtFpubEaxd26brKqkHX1iiObw0N/xLLx9Pg7/klrAYL3WJIcosS7Wqp0FsF4W7nQsDrWjBE1l8biBcy4c+bvHKaYs1H5lbypyvsJTl9wRt3oOQ81GFSMa9w2Da+pReccGm9KJYHc4sCqHTbhFqOfS43rHZB+NRp66Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753721104; c=relaxed/simple;
	bh=X4T3huFMENK/bbr2LynN8Axapfi9UhpKjcbblmGX5Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5TMUtDImVBlRuLmVauM/4rFnNDNYI/FrXgOIZhM/DZaGEowlVAsouXWE/pOnaBMCust4UW1NWhdu9aTrk3IpEB4OUfXeqgeMcGm2LxJCh6aPvaZ4zg3OQjsS0UHPGDoBOB3p2SSSZaREQkU/gwX8TvCxSEwSi51G9xIEaDAdBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWGGmqx6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2ED1C4CEE7;
	Mon, 28 Jul 2025 16:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753721104;
	bh=X4T3huFMENK/bbr2LynN8Axapfi9UhpKjcbblmGX5Bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qWGGmqx66EfxCa8gov6J7bRBjwLBblLLX//wYzazzAxB4vrLuQSBOyZ7MbM8WLlZG
	 ySStgBEYbgA7/x68MEgzeESnjy4Y3A6KhTb438ZqWedAiVzHKOeSrbeGmYUkFdHwKT
	 K+7ql7zBFZn5c6dYKe59rYfyzi1ltec00QEx3UYUCjvkVf4a5LUYdeW3ncybTlRYEF
	 CwyJ8Cs/ko7WrDx5ygDP/SwwcsInBxe+KnbIL4w614FELAzcl4SMBMUmzEcGcwzsBp
	 JTFk+Pa3QaGB7R0bbzP9FRbViAFIgon2IpyinY6mfVRqal5mR+ocYCeUg+KlluOOBF
	 C9/bu42paKwUg==
Date: Mon, 28 Jul 2025 17:44:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 04/10] coresight: Appropriately disable programming
 clocks
Message-ID: <b3782b8f-8c09-4fb8-bec6-186102cc66a8@sirena.org.uk>
References: <20250724-arm_cs_fix_clock_v4-v5-0-63f648dae021@arm.com>
 <20250724-arm_cs_fix_clock_v4-v5-4-63f648dae021@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jva5e9nRu1WNTR+w"
Content-Disposition: inline
In-Reply-To: <20250724-arm_cs_fix_clock_v4-v5-4-63f648dae021@arm.com>
X-Cookie: Do not exceed recommended dosage.


--jva5e9nRu1WNTR+w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 04:22:34PM +0100, Leo Yan wrote:

>  static inline struct clk *coresight_get_enable_apb_pclk(struct device *d=
ev)
>  {
>  	struct clk *pclk;
> -	int ret;
> =20
> -	pclk =3D clk_get(dev, "apb_pclk");
> -	if (IS_ERR(pclk)) {
> -		pclk =3D clk_get(dev, "apb");
> -		if (IS_ERR(pclk))
> -			return NULL;
> -	}

Previously we would return NULL for any error (which isn't super great
for deferred probe but never mind).

> +	pclk =3D devm_clk_get_enabled(dev, "apb_pclk");
> +	if (IS_ERR(pclk))
> +		pclk =3D devm_clk_get_enabled(dev, "apb");

=2E..

>  	return pclk;
>  }

Now we pass errors back to the caller, making missing clocks fatal.

--jva5e9nRu1WNTR+w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiHqQoACgkQJNaLcl1U
h9AEugf/Q0rlo7qxVE/p7BjSpN/fElPo7fwtwPg2sDCGvqLKh0MlhHgi8Hi/Zcj4
A/T+FYfF71i/5Np0lVNDNVXcv2g2ogF+jcS9N+KeAaG/5x58IbNe0s4USb/qt1BF
vcCuZac0BR4hNQOJX1EOgZ/NgU611k7NRDJPUqXbaacM7on4h4BabU+QJYpUaZY5
mUjSzh1USlrhb3lspn5CTKKMxtrtv65RuXzZvQpfpU4atL8N2akJtzElvks6xTDm
j4TGsbkTbStSt3WVaEeZDNAlcxMMgjMbFRF3efxrokRBdMklJL6wIzHILgBCcsX4
QDpPwEp1A8sKUIZ9BxwJbPVABY66GA==
=gcbM
-----END PGP SIGNATURE-----

--jva5e9nRu1WNTR+w--

