Return-Path: <linux-kernel+bounces-836169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DF9BA8EC3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17513BBD68
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9947C2FCC04;
	Mon, 29 Sep 2025 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCPyxRcZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40D934BA48
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759143070; cv=none; b=Y6wYR46HB6YqDVtopQBu5bTE58zOBphNBPP923g/ThxNFuh8KDdzz+vTkWmqYhVCEDBmqZ4+DEDk0pi3bM8xu+b2o/5HT/cxkff9vQxaWAHzhyCzDQtXktJ/MrErFutBi2sgkvLpIhLgAEk4sNsevBa14XTMEeRE0rJm6uEtM4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759143070; c=relaxed/simple;
	bh=T6RaGbL602VdWQJQEC/jgmL+lgQruHLcTPDMvn9WP0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tM01TAaB3K4Y0zJlwUCA3W2ZvImpwD8sf01oKDH/c7W22XIHU644Lz/isXvptFNFeofikALfxvsZ7kgbD/eflDcVwtED9nvkhze31p6tM81xgaTR9372P8kgOkO4LwzdxZgtN7mpX1nWPdexW9dGmaJ2tL1spm7OdrTmUG4+iII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCPyxRcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D07CC4CEF4;
	Mon, 29 Sep 2025 10:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759143069;
	bh=T6RaGbL602VdWQJQEC/jgmL+lgQruHLcTPDMvn9WP0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JCPyxRcZUAKC8vVH7epG7Pxmp1lwcgOYaXrDT8o8oLfM6SmBYbBlSvKuUIHKwERVV
	 y2UVQ8ONHCyZEdNFpesQI59PZ6HnxVMZIt85K4WjsZIUFJfB+6VX5VulftiMtKjBW7
	 tQys0eWaFWx1y67iHqa16UHPV8/9niIuBXy3WR+ufd4ZWH3pyxvsoBNHwXFdeSXYSC
	 E9JtFpUafI1FOxFdomT7OEQXNV2Dmdr9EgOSjgqpEaV5lviF5sD5lCuQdCvt6QKqVN
	 xlx2sanNRIq96iVdgT5xRtqs5DEXweEE/mWbMyEhMRPKe+s4cxmziN92ZQvO78OmgT
	 6lzoHJBrR9E8g==
Date: Mon, 29 Sep 2025 11:51:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	linux-kernel@vger.kernel.org, enze.li@gmx.com
Subject: Re: [PATCH] regmap: mmio: Add module description
Message-ID: <b86c52c3-42f5-46f4-b68e-d01dc8bada18@sirena.org.uk>
References: <20250928085317.284326-1-lienze@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="532Ic0ZZGO5A+h/e"
Content-Disposition: inline
In-Reply-To: <20250928085317.284326-1-lienze@kylinos.cn>
X-Cookie: Prevent forest fires.


--532Ic0ZZGO5A+h/e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 28, 2025 at 04:53:17PM +0800, Enze Li wrote:
> Add a MODULE_DESCRIPTION() for the regmap-mmio module to eliminate the
> following warning:

There's a patch for this already queued.

--532Ic0ZZGO5A+h/e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjaZJcACgkQJNaLcl1U
h9ABNgf/Zd9OCSjzavaAquWH2I3wr2ja25uAC7QcdtLYChdq72bZMK0mSCIvea//
Uofc1jLrSMiVtrG/KHZExGphU0cCQU4RygX60s9ElqYHac2WuSGVOGfaYSNNpwUM
HOyosMIivAQxtl3y1aTABpmKtIw8K3C/UVkWyyH5Ae/87uczMGMC29YWGlh4th50
x3oAmB9cZ5KLW71+wLdiT7NWSne8p+HF7ky4wSXJ/H2Zcg7E4pUBUpZnKMth/Qml
8dlYG48igslIt3x3C2hwsXCOCithkwZnXfYGSCrDeSwIgfnQPtWgXe5VUDGdSWlb
rMHFE+CGW5gBgymx85VXbsdQdlv0sw==
=amLe
-----END PGP SIGNATURE-----

--532Ic0ZZGO5A+h/e--

