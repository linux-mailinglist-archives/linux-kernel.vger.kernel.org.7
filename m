Return-Path: <linux-kernel+bounces-886615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D86C3613F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D681A229BC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873A132C318;
	Wed,  5 Nov 2025 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VO0hIIJc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C8F231826;
	Wed,  5 Nov 2025 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353249; cv=none; b=Hxi+s7akODGCHgqUCS5cUcLd89+qpZgzDQHddy7BpPk0aNnaNvMY79q//NXy+RddmE3X+Rk4ddEbja4QgOVFvpAoJwcLrfR2Qy2EoUP7oD5tEo0m2Nc5ylVWkoOzS1ybhvfcuQ/5J8abeRix8wInN/ytHQ4zb9Z+5xVtAGzb0N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353249; c=relaxed/simple;
	bh=cHcSCbKYmhQRTCv8RtcXgy0IJIn1bnOWWcXVYzzHE9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6eHoii8Gjzo5HpylNv7xaVE2gpL6CfGvOGjls9iYtCyKQh/jaIqrbTH57+wIbKFx8EzIW4huyb/Q56M7sLghheuqyXlZQILV5gGXwE23dj7Ed4MwP2VoncTwp/1lMeyM1UsM1it7sfccY6z6Nh7dvVvFHQ3uo7pTo2ty0aBQUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VO0hIIJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6278C4CEF5;
	Wed,  5 Nov 2025 14:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762353249;
	bh=cHcSCbKYmhQRTCv8RtcXgy0IJIn1bnOWWcXVYzzHE9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VO0hIIJccXDKoPF7JWYTxwGqbG/8apEUPmUkTwmLdh+CjC9LFW49THVQIfRR95OSS
	 1k+nJ2/N7nOpkm80izduwoq/VHu0vSKPbyjdvCqEzR3ODwR5ICUASd4iJ/8/sGPhpv
	 r6pliCP6teqNfBrjweDv4pFHGrgnNOrHqPF8AErWm3ze6SpP2fqNoTlr/66IcRrLfs
	 jfCV/rNJ2RELq6+IUj73ZpnH4ETZMnX52Q3+NgRPmEA6ychMbrmzfkmmNwQmfCjVxD
	 aGyTCiHldRopT6fCZrRf40R1cGXL9DfTquvTxnKH6HS8m/QzP34vOk72Nzh7l+7aAu
	 AfHJrcnVUMJbA==
Date: Wed, 5 Nov 2025 14:34:06 +0000
From: Mark Brown <broonie@kernel.org>
To: wangweidong.a@awinic.com
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	srinivas.kandagatla@oss.qualcomm.com, arnd@arndb.de,
	cy_huang@richtek.com, nick.li@foursemi.com, shenghao-ding@ti.com,
	alexey.klimov@linaro.org, niranjan.hy@ti.com, linux@treblig.org,
	zhangyi@everest-semi.com, thorsten.blum@linux.dev,
	kuninori.morimoto.gx@renesas.com, yesanishhere@gmail.com,
	marco.crivellari@suse.com, ebiggers@google.com, ardb@kernel.org,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	yijiangtao@awinic.com
Subject: Re: [PATCH V3 1/7] ASoC: codecs:Rework the awinic driver lib
Message-ID: <aQtgXpbx5Da97sO6@finisterre.sirena.org.uk>
References: <20251028123357.46161-1-wangweidong.a@awinic.com>
 <20251028123357.46161-2-wangweidong.a@awinic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xbLaYFKsH6xuR34n"
Content-Disposition: inline
In-Reply-To: <20251028123357.46161-2-wangweidong.a@awinic.com>
X-Cookie: Alaska:


--xbLaYFKsH6xuR34n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 28, 2025 at 08:33:51PM +0800, wangweidong.a@awinic.com wrote:

> ---
>  sound/soc/codecs/aw-common-device.c           |  507 +++++
>  sound/soc/codecs/aw-common-device.h           |  204 ++
>  .../aw88395_lib.c => aw-common-firmware.c}    |  150 +-
>  sound/soc/codecs/aw-common-firmware.h         |  211 ++
>  sound/soc/codecs/aw88395/aw88395_data_type.h  |  142 --
>  sound/soc/codecs/aw88395/aw88395_device.c     | 1720 -----------------

This breaks the build:

/build/stage/linux/sound/soc/codecs/aw87390.c:15:10: fatal error: aw88395/aw8839
5_data_type.h: No such file or directory
   15 | #include "aw88395/aw88395_data_type.h"
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[6]: *** [/build/stage/linux/scripts/Makefile.build:287: sound/soc/codecs/aw
87390.o] Error 1
/build/stage/linux/sound/soc/codecs/aw88081.c:15:10: fatal error: aw88395/aw8839
5_device.h: No such file or directory
   15 | #include "aw88395/aw88395_device.h"
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~

--xbLaYFKsH6xuR34n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkLYF0ACgkQJNaLcl1U
h9BwNQf/fzPPiLW48KnIuAwJaYXUqcAz6LK72C18OcSyYEya0aIMXndUPlz9uVPS
z0BWKGm0wYa9OLNd6DDZyvP676G46lJG2f3tA2owdXnKQVdGnVpNyHbK3+0Wrx0b
WCUDGjG9SxOi+ZTChTPkxNu6SRUozQDC1Pjf15oO/JfObxw3kgCprEmNNYHa056/
zkEBrs766AzIAbJaAEtGGQ1+g8XtUcvefHcJ36/Q9dYoI2frfjkR/8MyvwJzr0lg
z2v73g2ibTvBhJOB6FEDoMpwqfkJbTSbkBlHSmwD1eCIkRwm0wMCk1ocrReaE/7d
lIwWTn9huERs1Kvm/Tw9SNlkLpt0Jw==
=hJAp
-----END PGP SIGNATURE-----

--xbLaYFKsH6xuR34n--

