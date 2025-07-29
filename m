Return-Path: <linux-kernel+bounces-749333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB17B14D09
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C94A4E648F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE1128DF01;
	Tue, 29 Jul 2025 11:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gh4BWWnN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7F6227EA8
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753788701; cv=none; b=iFBw0gu+c99Abp0tJoaxlx8+rVpfrt0sASODlsBdFnFXBhz9cLQ4PL+YTphz41pv4zacQkqNzNB/uO0PtJz1y0FpKv+oNF0L5k5GiY16wn8zy45sck19cLR/p0xgBmpWRFORvKjmmRyIF92EdHJeQdLuJ+m1wfO1GF0NpdKHzKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753788701; c=relaxed/simple;
	bh=y4vGbQPemKBalKQIjXvDv5t7GDCaowzVXc0y68AGVhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaYkdfDylXsU2l+6q2SP/YRUVr1iUOGo0GRc0a+WMK0Rz5ixcpSFzNkYy7VAkpDxHRkv7rXLkaFnekXiWduYXEUYhS95KF4J659tvt8fJ+1ls/EATSC8WKmM2J3+IMkODFBD3NNkgTbyezACmfQbCKhILXsg2waAElZwci6LetY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gh4BWWnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CF3C4CEF5;
	Tue, 29 Jul 2025 11:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753788700;
	bh=y4vGbQPemKBalKQIjXvDv5t7GDCaowzVXc0y68AGVhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gh4BWWnN1B38M5qEC5SU5f91E5va0e5qOxwTmr43pxSnjArVIFXNwbgy/YdjU6yig
	 ow7GVuylhQ1CzlsFSq214lJLqgA+T4NuZQvOi3IsTQVUx/7Jk5+6iaPZ5In8AkV1kK
	 ppnAx+AbdjGFbkn9u5Ql+bivqgNJy83iCUI0WNy6q7n5tEuKkng9SxuwtFNhTnVf0U
	 x5doAH37MXCTMyeLuzs2IMta58XcC/kccyOvuMNR9V3dVEd9SmVYY7B1mXv+pPfWxo
	 oNTZOakA515YdJQoEtw06lv6cPD/RFiqwLG5igj5KPh0xLwozlfJ4MN0qdMfVxNqXc
	 pS/yI3Wsby/fw==
Date: Tue, 29 Jul 2025 12:31:35 +0100
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
Message-ID: <f9fb2174-5bc5-4c7b-b74b-8542b4f7cbe0@sirena.org.uk>
References: <20250724-arm_cs_fix_clock_v4-v5-0-63f648dae021@arm.com>
 <20250724-arm_cs_fix_clock_v4-v5-4-63f648dae021@arm.com>
 <b3782b8f-8c09-4fb8-bec6-186102cc66a8@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QMmVRuHtuPBSW/9q"
Content-Disposition: inline
In-Reply-To: <b3782b8f-8c09-4fb8-bec6-186102cc66a8@sirena.org.uk>
X-Cookie: Short people get rained on last.


--QMmVRuHtuPBSW/9q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 05:45:04PM +0100, Mark Brown wrote:
> On Thu, Jul 24, 2025 at 04:22:34PM +0100, Leo Yan wrote:
>=20
> Previously we would return NULL for any error (which isn't super great
> for deferred probe but never mind).
>=20
> > +	pclk =3D devm_clk_get_enabled(dev, "apb_pclk");
> > +	if (IS_ERR(pclk))
> > +		pclk =3D devm_clk_get_enabled(dev, "apb");
>=20
> ...
>=20
> >  	return pclk;
> >  }
>=20
> Now we pass errors back to the caller, making missing clocks fatal.

Thinking about this some more I think for compatiblity these clocks need
to be treated as optional - that's what the original code was
effectively doing, and I can imagine this isn't the only SoC which has
(hopefully) always on clocks and didn't wire things up in DT.

--QMmVRuHtuPBSW/9q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiIsRYACgkQJNaLcl1U
h9CP7gf/a6QGIQvui9I8RFs1artw7Ym1nwZpYTmbZEe1GpG3O3wU/Xrwqci8/bIm
+xr5ymPxS+a+Po2e4bJZ1suPpFq/wp15/HzEF6DpEGWdgjvokn7JkteNO3UohWNw
3o67pP6Il9kvUL6W2tRk4GQqqUGITGMlaiHX4Qqc2CuhJTHcNMNYXm3FpXQBeNBL
xXUy04CjKL9I8kqWu/6bnAB5mSjj1MwDtWhQcWi/Xt83VwfeXIHTgMFDdIR3c62S
xZ4KU5uHpxSLqY6dns5JbM6Ibqm3EKmVX1O0ZOTyPD7QgYusdNsQ+zaXqYVhPXAg
yOtwcnHJpB/euhvB9Fui1K+ORnlDEg==
=PiH5
-----END PGP SIGNATURE-----

--QMmVRuHtuPBSW/9q--

