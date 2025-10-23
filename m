Return-Path: <linux-kernel+bounces-866880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EA2C00ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3064B18C7893
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA23830F7EE;
	Thu, 23 Oct 2025 11:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6MSL1sz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B8230EF94;
	Thu, 23 Oct 2025 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761220557; cv=none; b=XnQLzpFWD26h7j4PtO2Xtd+iy5+ldG2HMbgwIi0qHr9OOW45H8n6lkum8xR7eWwd/YRyK2IMI2q01Vo1NRV8rOtp+3BolggdJvtw/G7IMcHKgV9wHeQE8q8+kIKhNVEizBFo1r53zdV2wvpPs8jjmyI80SfP8yX/0Oe3PhsqK34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761220557; c=relaxed/simple;
	bh=Cz+i37Ja3afu19huL1DhVA1yCa+sVA2FSefg54htZH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bw80zCJk6xNe+fD0ibsICzf2Kt34vQMsgnrN0iU+gERptRaIg5IUceRE0Ag82/Rj/doXOlCF5BPV2Uh3hL7xqPj02bmJ6XJBhnbNh8rAn4s67yQGDFf8lGExLVkyU1ZpGRqP0WIA1rgBLKOuwxC9BBiBpKDSWYNn2Oc8m9NgeMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6MSL1sz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4D5C19421;
	Thu, 23 Oct 2025 11:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761220556;
	bh=Cz+i37Ja3afu19huL1DhVA1yCa+sVA2FSefg54htZH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C6MSL1szBc3VuB2KDluYUHvoX7sNGh7TBnSNhh/RjVJr2Q+K3sPiW9xVGReow3ltX
	 QUQoEIaUUIJEuGmkRCiwn4S5MyYepVNonX7KfgC2W0tMMoTzrFkW0yWw0GnroaFkYN
	 fGRs3TmIvZA2Vnx1sUXz5ENkkGhCMVPrW9yhlUPzIufkDszVksY0oQWBqdUqUoMLDa
	 Qj1p8KRV1Rwt6lQ/ieNAVTZIxQ6C+1dDsb5AjpEWistvOvUg0NkXjuXkkrFbSShhE8
	 ZnXLtR1ZTgST0GMaZEY40ln8nSHgKb+QyFijVHZP/1gXLrVf3Y33qdzBOELWd9EYkA
	 JYyCLC9ydwWfQ==
Date: Thu, 23 Oct 2025 12:55:49 +0100
From: Mark Brown <broonie@kernel.org>
To: wangweidong.a@awinic.com
Cc: alexey.klimov@linaro.org, ardb@kernel.org, arnd@arndb.de,
	cy_huang@richtek.com, ebiggers@google.com, hangyi@everest-semi.com,
	lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, linux@treblig.org,
	nick.li@foursemi.com, niranjan.hy@ti.com, perex@perex.cz,
	rf@opensource.cirrus.com, shenghao-ding@ti.com,
	srinivas.kandagatla@oss.qualcomm.com, thorsten.blum@linux.dev,
	tiwai@suse.com, yesanishhere@gmail.com, yijiangtao@awinic.com
Subject: Re: [PATCH V2 1/7] ASoC: codecs:Rework the awinic driver lib
Message-ID: <ad81a2b7-5df4-4e41-9bf1-6949723d43b8@sirena.org.uk>
References: <72907b06-c7f8-455e-8dd9-f5b4041d4bde@sirena.org.uk>
 <20251023115037.35553-1-wangweidong.a@awinic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zSaFTpnV73q1nzCn"
Content-Disposition: inline
In-Reply-To: <20251023115037.35553-1-wangweidong.a@awinic.com>
X-Cookie: I've got a bad feeling about this.


--zSaFTpnV73q1nzCn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 23, 2025 at 07:50:37PM +0800, wangweidong.a@awinic.com wrote:
> On Mon, Oct 20, 2025 at 02:40:32 +0100, broonie@kernel.org wrote:

> > This doesn't apply against current code, please check and resend.

> Thank you very much for your review.
> Could you help me? What caused this?

Whatever tree you used to base the patch on is different enough to my
tree that the patches didn't apply.  My tree, as listed in MAINTAINERS,
is:

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

--zSaFTpnV73q1nzCn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmj6F8QACgkQJNaLcl1U
h9C9Cgf/eBjYYc0/zGcUh3YCzE9bQbSTNsCEFPnKPkgr1n1uOPvPHJHdvY7eY2lU
XulOB73erX/Jhs9MgkwHT1oTSgGqpKlMkQ+SmBjcydUtAFtt2RMhvI1e8egIwwN+
m6xoIkXlu5ggcIpC4wO0OuVmNxhEj4eAoj30YmV4KTA+VPunAbjQGVDVt9XecngK
ufmftHx/aONbXkbB2mJDxEktLBXb4FMET3KTrwShAvywtj9WdQpgLraofLdpyx/5
9kP+O2IekXndYedGNmup3yH687vBIn3CsPxYkz1K/gyhuMNL65e5T28gee42NSkz
XliosXO8SKwT5iYOl9hZcraX+glx5w==
=eync
-----END PGP SIGNATURE-----

--zSaFTpnV73q1nzCn--

