Return-Path: <linux-kernel+bounces-824350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D276CB88BEC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ABD21C24BF6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0FC23C4FF;
	Fri, 19 Sep 2025 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="UCPRR2pz"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B21D1C5F23
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758276231; cv=none; b=mfRFk0sA0NTedP3iTAw4xVgorZ3lxsl4JHRZUABzt6xOHxJIkrdqftPAnXxojh3veJfAi5mPT4FSZd/IP9YxUqtOBdXMWbW9Cf38yyrfp1TlnokD/AbwWdjpNm8R+aGgteoCzsAC+WA3aRK50lFQKFxrWDEYQkgxRYNANBhMB8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758276231; c=relaxed/simple;
	bh=zOikqsz0sSTFBeV/uESM3AufGzQGVE02sLnd09rVnWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIum4zvWyc6LTwHDGEcse5DhyVnFxG+Vbz+h+Pfehw0H25w+0/lmlLb42JZUGUOD9VgcjBsUqU63nCxFPwyeA2nRx0ezvvjHsAMtkeDLxBKHpZBFJBp+Lf4gP/xbrx5IyaZZBpEVF90xyUWy76mifWyNma/FBT9KDbjLLUBd6pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=UCPRR2pz; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=zOik
	qsz0sSTFBeV/uESM3AufGzQGVE02sLnd09rVnWc=; b=UCPRR2pzoIZSM07uEasL
	Wk9F7jrRhGvWk3SwrtmlRk1vIBKXJ7FPospE7Z8dqBNbrfw5jo9sgw5/+aFpelaO
	T4ENH2GbRWkFJn7vgnN1+cfCjQZuwt8k7zog6yufNaK0Ij70pqrgeArsr4BEt+oW
	npxyqAsZwQNmXoVJOKxR10h8TLIoavISEXtCTWrtuJrQ/3v6ewzMG3H+pxQJJHvM
	s1Vzcbj9Ic5QO0n0lV2QEY9FyTgbw1eMwSiXVmIq8+2KwgVbGIUciGAB+gfmiGHo
	hJkJpt40HACwDB2Zapg2JJaXTkNqNGDwTW0N3RtSycbDZ2ui4/FvUWv7pBMcf0eE
	pA==
Received: (qmail 3872646 invoked from network); 19 Sep 2025 12:03:42 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Sep 2025 12:03:42 +0200
X-UD-Smtp-Session: l3s3148p1@AgKmlSQ/9Kwujns7
Date: Fri, 19 Sep 2025 12:03:41 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Hoan Tran <hoan@os.amperecomputing.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Saravana Kannan <saravanak@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 5/8] ARM: dts: r9a06g032: Add GPIO controllers
Message-ID: <aM0qfauVfS9d1sj1@ninjato>
References: <20250918104009.94754-1-herve.codina@bootlin.com>
 <20250918104009.94754-6-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F6D+YsTzfsTQB4L7"
Content-Disposition: inline
In-Reply-To: <20250918104009.94754-6-herve.codina@bootlin.com>


--F6D+YsTzfsTQB4L7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 12:40:03PM +0200, Herve Codina (Schneider Electric)=
 wrote:
> Add GPIO controllers (Synosys DesignWare IPs) available in the
> r9a06g032 (RZ/N1D) SoC.
>=20
> Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.co=
m>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Maybe we can apply this already? It is useful on its own.


--F6D+YsTzfsTQB4L7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmjNKn0ACgkQFA3kzBSg
KbbcEhAAmMpZIB9rjPFE0tmtUS3SohiCb3mxtYatO1EF3la3frruJ68eFiLNL4tb
gZlbSv1QhbMd3QSV1OWV970UUfQrL8ofXzmtj3Uw2h7H8CdVqBU9fuNU3Cay24AC
jjL+jHruczjbs5ScQXjI/srvoYp/IqkU0i56c4ZplI7UBhoSUgnnRa5IhKd0z+TP
eB/AH1RSx2p6RG/Nm4BAXKcoSZ6+vkBQsEutuWGgcfCpmY7JqYKyvXI3DpInoulD
SJZMSwoi3AB1Z5zcqIfLAj3o22loD0sFzlLRIwq13dZw+hqGFaNv/WSUNZkFhXau
0XIuOxZAgLafD9rNbNdnjLuKwGR+vtGr4WDKFdbo9ke2ppeMYpF7CSSkn8Mn8zOa
DUkb01CIFTe04Dyal64xKHOTI/sTRvFl8Wq12foOvusZQr9xI/UJdqV1/fHWgo/0
+mvJaXDhU5DZkcR3uZKNyvos2vS8zNFxa4c2T9QKGQrCfx7Gr48Os1eNxSQPiuq2
P74VAGo7KRFkYtLv+Yp46wsXZ32y7Vumx5ZS1DVarNAAXwdzcP/VjRIF5cfQVw12
K36ok4QUH465oFG8BWVNwCQhY+UqY9wp6wpB76xPpYo8MOx/4dMaoDTnCZ/3GrRA
1SEulEwb7LPpcTZ48h3AI1gWpc+KATlzsz8ydzmQeFO2pNYw5RE=
=3tHZ
-----END PGP SIGNATURE-----

--F6D+YsTzfsTQB4L7--

