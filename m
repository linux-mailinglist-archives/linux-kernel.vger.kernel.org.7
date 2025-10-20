Return-Path: <linux-kernel+bounces-859949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEF5BEF069
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1468A1898983
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 01:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462DE1A76BC;
	Mon, 20 Oct 2025 01:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvK88p86"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B89313EFE3;
	Mon, 20 Oct 2025 01:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760924439; cv=none; b=rdwvs7bpUdHYzFGj9ZJhSfs4tsBc4+ID8pug5J6iSUZuZYSqYoRHXbmEfT++KQKO5zuYJBKOZbO3XuzeluhdD9gyNIQWBR7ftyEkvGfHtFAGZMi3BuWVAr90HiW3NaXAzK7fwGhuESUeRRYY3WNHNVleixhMjDd4ngQlLqt2geg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760924439; c=relaxed/simple;
	bh=ncV+BB5LnsdnGOmj1J0hFguoTEWuNEhshozSzbNUc7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiVVl7r0Ihf83o6+Efs/CCLBZaRkYUqhLYGgNYK+fDklHzLC3mhrduZTNC7FRuE9f6F/Fm9+WuGFPJl5dayvxnBNB1iiwEhOzzxlQqz5ztYFiTlpFCyPT+lUpl7/w2oaE9kiASevALo19RjyPnBwhKx8+j+ChvkFtCWyk+mxeDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvK88p86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE6EC4CEE7;
	Mon, 20 Oct 2025 01:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760924439;
	bh=ncV+BB5LnsdnGOmj1J0hFguoTEWuNEhshozSzbNUc7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lvK88p86RRCdjnK89JGlagZW3E68RzoTsvKMndOUduD71PY/+4iOo6N1qaCARElK3
	 6sMabHEPgcmpLm89tdCduelkJJPCU9apCgDzwE3glvEMSivuGrWf7iap3KnKg6VP0X
	 g4gG20pAqgS+lKQoiISOhhGiRgJoMPT6NijgsZp/3S05R4UTgpeRqARB2FZRNDWBr9
	 ui+0bK018Nz7ijfc2nz19qNCYC0hOI5A0/jWibFHTkziY4j2mn7Skd8lLCBsiR3ndY
	 hPe9r7i9zzwICvO7VcNPQ8spsu7pq26Ei1WWmPoK2l9taY2Plp0j31aInnHoQKfezd
	 nEzx+iFKJg2jw==
Date: Mon, 20 Oct 2025 02:40:32 +0100
From: Mark Brown <broonie@kernel.org>
To: wangweidong.a@awinic.com
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, arnd@arndb.de,
	srinivas.kandagatla@oss.qualcomm.com, cy_huang@richtek.com,
	nick.li@foursemi.com, hangyi@everest-semi.com,
	alexey.klimov@linaro.org, niranjan.hy@ti.com, shenghao-ding@ti.com,
	linux@treblig.org, rf@opensource.cirrus.com,
	thorsten.blum@linux.dev, yesanishhere@gmail.com, ardb@kernel.org,
	ebiggers@google.com, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, yijiangtao@awinic.com
Subject: Re: [PATCH V2 1/7] ASoC: codecs:Rework the awinic driver lib
Message-ID: <72907b06-c7f8-455e-8dd9-f5b4041d4bde@sirena.org.uk>
References: <20251017101106.370742-1-wangweidong.a@awinic.com>
 <20251017101106.370742-2-wangweidong.a@awinic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OCQkiBZKWxSSnBpK"
Content-Disposition: inline
In-Reply-To: <20251017101106.370742-2-wangweidong.a@awinic.com>
X-Cookie: You are lost in the Swamps of Despair.


--OCQkiBZKWxSSnBpK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 06:10:59PM +0800, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>
>=20
> Extract the awxxxx driver common interfaces into
> aw-common-firmware and aw-common-device
> to facilitate subsequent driver usage.

This doesn't apply against current code, please check and resend.

--OCQkiBZKWxSSnBpK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmj1kw8ACgkQJNaLcl1U
h9BSqwf+ItSJ3juwRzgglR51vzxFQ44jxWsGxyYIwFPapmP5ktV5gkMzDbsYsQ0G
Qu7rzlBFixpgIcx9RyViQJ10SBxEl15M/+6SWYR8RRB4/YoFUmyfELtt4kwoSr0G
S9kgTzHG8uWER6Cv8akG16rkfS6uXaiJqu/SLhQ8SsjipeDLV63rtHEhwudkV3Uv
iubfQI1WMo9B5ULMmazAOlYtHw0xfkpbYnbsrprQgG52YXLhfIe3RbiPP7Ej0SD+
lvp1Hj/c7FNjzQvu0FQkPaUsKMql/gz9E4OJYa/vilzd1LLtCmYI0uQ/fC+s/fN+
rgz42qafn+aKak0+6Thd02TD3kmHqA==
=wdef
-----END PGP SIGNATURE-----

--OCQkiBZKWxSSnBpK--

