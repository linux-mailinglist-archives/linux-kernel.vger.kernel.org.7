Return-Path: <linux-kernel+bounces-832452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 402C0B9F5B2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50327189DC2D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CD31E00B4;
	Thu, 25 Sep 2025 12:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knufJr5W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206201C8611;
	Thu, 25 Sep 2025 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804713; cv=none; b=Dp4mvkfbcDvCZHZrOBqcIpxdBJ3E18OZ/VpU9pTAjAqoJImypK4nKADnWeUb3zsOXDFP3C9D9SjJeBVI+LW+nBjEJmNjda15BJcQOJSbcgPnFPw3PUG/A4qKz74ExndQnymzEB4Wi9+FKxOeEHkzBcrbq/fc51L2uA0/2JBEf3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804713; c=relaxed/simple;
	bh=mO1eURmsQ/Q67GVCleK7Z0UQWNq3rMCZKy4D+DzPFzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGOn32gyasgm+gkMGXM4ScdjD0EeOe4e9H9ITHvF/FB8XY+0yenWYopWf28j00eHsGmJvgMcjOPJqhK7mv89u2kvK51vZBzKA/gDfoyXaGfdeJLLYlh36Lt74KegbxIvSohY5nEeMtPkZvqt7QOogCE5z6/my0MxrAyV1LqHU6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knufJr5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0117C4CEF0;
	Thu, 25 Sep 2025 12:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758804712;
	bh=mO1eURmsQ/Q67GVCleK7Z0UQWNq3rMCZKy4D+DzPFzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=knufJr5WE1keDJ9mqbAtEZ1ArQdYVue5Q49Wtujs25pDpg1IU+gTJb5zb+GZN0Ztj
	 32Yoh7w14n8CQ/Bz9XKhQuEqkgpnKz2u5iSM+K6oJ1fBf2nJ8v4a1aGpKg0ZfSxa5d
	 /2/p2cuDjy4JaEMe7Owi7PSLPDKz0Y59fNJk2CPlQfP3v+I7RmFA0A7Hc5wiLGwUcS
	 QNG0sxJfxYV3+MTC8/oCq82CIZHreuCcuaOZ0smQdvcMsCHrHiZNUiXNVmuaTuacJG
	 mUk1mthDKUUfiwGJJtsNq+ORbti3iE0GmAW+DoNBAaMuhddeXWkL25yjUArWuyDbpN
	 yrG4gxGudy2Ig==
Date: Thu, 25 Sep 2025 13:51:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
	tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
	yijie.yang@oss.qualcomm.com,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] regulator: dt-bindings: qcom,rpmh: Add support for
 PMR735D
Message-ID: <584e307c-527b-4bf4-b9b8-13497021637f@sirena.org.uk>
References: <20250924-knp-regulator-v1-0-d9cde9a98a44@oss.qualcomm.com>
 <20250924-knp-regulator-v1-1-d9cde9a98a44@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ldOXRTuo48jZKpOF"
Content-Disposition: inline
In-Reply-To: <20250924-knp-regulator-v1-1-d9cde9a98a44@oss.qualcomm.com>
X-Cookie: The only perfect science is hind-sight.


--ldOXRTuo48jZKpOF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 04:30:47PM -0700, Jingyi Wang wrote:
> From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
>=20
> Add support for PMR735D PMIC used on Kaanapali boards.

This doesn't apply against current code, please check and resend.

--ldOXRTuo48jZKpOF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjVOuIACgkQJNaLcl1U
h9B1SggAhSi7EbAtG3IgIfC9DG7kpX8kB+GyDZ9GpmTAMIRLybUZmwjAqGe72hoM
KJ1m8kUvxIzi3dNG1NovOzBE0Hr0MUrR78YFosMWC2U979/HjxIL6ZwMOnNTNsj8
Kd4VEwwNm3i/FFwsf8yPa4Nwq9DX4jq2kj7fK9XZQDbKSWiCrDpndw49b9Bhebwd
DA6ET8YrxqUREddRZp1hoMshYoaUjM485tz5Sdk1w8aD1m/8KpiMCi/svnlj+Qlk
keszR+HB39shfC12lep3bgfIRDnKGBrf5ZpjwpggzlONbE9rtuUgPBAiUzRPosJK
xIztDMVU7wPZv1N65P8m8IEG3OyzCg==
=CgSr
-----END PGP SIGNATURE-----

--ldOXRTuo48jZKpOF--

