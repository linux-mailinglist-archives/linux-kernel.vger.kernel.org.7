Return-Path: <linux-kernel+bounces-836582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5729BAA13C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A57FF3B68D6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A1C30CB50;
	Mon, 29 Sep 2025 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaocYDbQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784C63090EF;
	Mon, 29 Sep 2025 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759165101; cv=none; b=MEUbE4lpJDzZEof0l1OynEHx16Fuh1B2jXURfgv5+bqOo3eiB54GmsVloNCKmYE+uB1mzvXWSOCvB5PS1IwZMf/Rlt9vGTqpFKPdcRcaAlm/cx36hHmNGZCO+gzHsG3Si1VHHwNsoHBniUMGkRKZzaTcSJgNxezrtW2lOGf2aX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759165101; c=relaxed/simple;
	bh=cyxLA5zDiM+479184inpW+ode6YnkOiFHwNLUqPOiIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4D62of0FI0fRSKfwTYv81ZO3lPucC/912GJ3wyVpzu5za6Q82FDy6CSvCVWF01P/mWfkLuDkDLeRIgFi2rQoiheMoXplAM2UOqHqaVCkDwndfgxQWmNth6dOnpWw76FDR+2k4qlNOzxKiWdkckEJHp25faofPa7tF030Y4eCkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaocYDbQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0202C4CEF4;
	Mon, 29 Sep 2025 16:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759165101;
	bh=cyxLA5zDiM+479184inpW+ode6YnkOiFHwNLUqPOiIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jaocYDbQz6xXNY3/7VFiZGJQXeLbfosaVv46KN3a2bINPYfNu0Hvvj0ebqJuLzFNv
	 7JZXcZN+coH5lyrIp5T/tfy6qQmMvJWxymzszEcQe8j4xjo7yRuFFcBEsTJn0l1y/T
	 lFTakMY4eo3pvTRDeVzRs0k1q6mqILEEjXySGtLHbEiIkq9pv8Ha5IRMue8ndmLphC
	 f4w5st9gy7Wmo8jiAwaoihS6Izki5ECFe4voLK3voITYNLPad9mQw5ysKyHIAYpgAv
	 7fV59m1S45897zXAVAGyQzqrmPvBsDOYYXpxtB+atfIp5uS+IM6Z4EegPAX+/mIV/E
	 YUq2v8XXM0M8Q==
Date: Mon, 29 Sep 2025 17:58:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v2 0/1] ASoC: change system_wq with system_dfl_wq
Message-ID: <aNq6pObNPCihWON4@finisterre.sirena.org.uk>
References: <20250929155053.400342-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+3CgqjJ3tGV8N8dy"
Content-Disposition: inline
In-Reply-To: <20250929155053.400342-1-marco.crivellari@suse.com>
X-Cookie: The star of riches is shining upon you.


--+3CgqjJ3tGV8N8dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 05:50:52PM +0200, Marco Crivellari wrote:
> Hi!
>=20
> Below is a summary of a discussion about the Workqueue API and cpu isolat=
ion
> considerations. Details and more information are available here:

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--+3CgqjJ3tGV8N8dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjauqEACgkQJNaLcl1U
h9A4ZAgAhMszp1C15lYGC6+N4CsxCm3fD8rg2P7h810Sd0uySvaWWwn1J1DvMI0O
Cb0eyD185mx47bRZOg/BrmjLf2RC8KT6lmpjE0eCRtPcXxnDQcdpQqfkBdfmN2R0
oqnsY7WnxQ99lYNgfYbfw9E8utjJwQCKBDExH3dGJlnJxHfBRZ3C3e+4dww9ZGLh
bIU8NTL1JA7Por2LG701oBMwyCYduPCwzwkzCVnOa2Mmo61B8zQrItV2Mx8LQW+M
vgP+aGKVBeo9t2xI8jgkLgSNgmpEHhKU4rRjNJr6IMLmGgLSS01zbrhLjHR2zEH6
oBZojJWQXYO2N7bJu4qGDrohER87cQ==
=xnZg
-----END PGP SIGNATURE-----

--+3CgqjJ3tGV8N8dy--

