Return-Path: <linux-kernel+bounces-878228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0022FC20110
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0F8E4EB475
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C12E32AAC9;
	Thu, 30 Oct 2025 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnkvz0/J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA44326D4A;
	Thu, 30 Oct 2025 12:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828140; cv=none; b=Az1MVlihMVT1PwOtVKkxWw67kPT7piuVGe8AS8w6PrhuN1wRv0C4NXUMFZFbDvfAyvnwaA0c7H2fzoCPAIkdRWl9yhydeXn72Bi8t9yxNBkeKo/6QTw4b7TRPmSaT+RT3lpQ05H6lauURF6oyyuJl35kgjN9Nx30CExKAMrn1wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828140; c=relaxed/simple;
	bh=/XfJU+cdY0jpYU5tPGaNdi+JWjcrGHtgmumVolcAM3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6JyOFWYZVR/V3pYRgj6Rr7Koga949rcWl4BTeoky1556i+QEEbeK2eTvneFKIeMOTeWtZ2mzw84WbxTIdpXMMnl4o+KeENCTd05RprdvBWwE7Eu2Hn4BlVvm9IXMjuEUDn6cMaa/6x6z0ZsRvqtt3dTjHAy+rYHrCsN3aXh6xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnkvz0/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12984C4CEF1;
	Thu, 30 Oct 2025 12:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761828139;
	bh=/XfJU+cdY0jpYU5tPGaNdi+JWjcrGHtgmumVolcAM3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bnkvz0/JD8J1nSXnJ80taDNxCsASTKz4tmkyiMkkB/j8+6HPEoS0bGyb28DXdik3x
	 UYDUzI/hUqwDDLDyxaGifTacj9v6Mo1cFbwsMnju1hpAh4utcL7rJfVVTOhsLVnK7x
	 6YVMMdepfOqU5WE0UNuNyUUPN6KZb3gXj1fLBhFrlcUzsClHHiB2HEkampof0ksiwU
	 IOZ1iFcsp2h1Dz8e871zofCPExK4fwLo6CXd+NRK6w37w5Maj2ux0SuOFXoDiQHwnb
	 6VRezHmiO2+wOwZv6QF+LuSmXt8R9bJzFiJb3nuqDE17ZIRPWQqGEVgHyymNhrLV7T
	 CRjXjG/vfeWlw==
Date: Thu, 30 Oct 2025 12:42:10 +0000
From: Mark Brown <broonie@kernel.org>
To: "Liao, Bard" <bard.liao@intel.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"tiwai@suse.de" <tiwai@suse.de>,
	"vinod.koul@linaro.org" <vinod.koul@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pierre-louis.bossart@linux.dev" <pierre-louis.bossart@linux.dev>
Subject: Re: [PATCH RESEND 5/7] ASoC: SOF: Intel: export
 hda_sdw_bpt_get_buf_size_aligment
Message-ID: <8dac7fb5-ca36-4150-93e8-18d3173efe5f@sirena.org.uk>
References: <20251030070253.1216871-1-yung-chuan.liao@linux.intel.com>
 <20251030070253.1216871-6-yung-chuan.liao@linux.intel.com>
 <fa2758bc-7149-43db-8dd9-610d97d86137@sirena.org.uk>
 <SJ2PR11MB84240C3B09792E128D1D057EFFFBA@SJ2PR11MB8424.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="djrmMc/L29cExWVT"
Content-Disposition: inline
In-Reply-To: <SJ2PR11MB84240C3B09792E128D1D057EFFFBA@SJ2PR11MB8424.namprd11.prod.outlook.com>
X-Cookie: Is there life before breakfast?


--djrmMc/L29cExWVT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 12:05:23PM +0000, Liao, Bard wrote:

> > The rest of ASoC is _GPL?

> All functions exported in hda-sdw-bpt.c are with EXPORT_SYMBOL_NS.=20
> I suppose it is ok?

OK, I guess that's fine.

Acked-by: Mark Brown <broone@kernel.org>

--djrmMc/L29cExWVT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkDXSEACgkQJNaLcl1U
h9DaPwf+LMg2s588T2+Z7Of6rjQBKPF6uk7MvdSUB7VGvcOZfwVih4WNljG4U8JV
0NyluuKSleyB2fnn+jvyHBe04dN83pDkJ5vfXmF7nwVeFkvZGNODgXxudNVf9mOp
hUPdHOoNdgNSMsxMw+zeaoJfFUIb8vFbThM7Yza08ZMetOIgUdABqDqije1lt05S
wHHt4k/CxbUKtWWn37GO/aicuygHXWDaxJxi7eY4hplj+6OKRMZlvQec5Q1HjV0P
F/je+dE9CSP5E/DpZr5tidpwUl6gI6tGfQBHQzHKg2NZcrM/vM/wvJmCKfMQJMhn
hE4E/PKOrufGvoUAhTYDnrs01Sm1ZA==
=819G
-----END PGP SIGNATURE-----

--djrmMc/L29cExWVT--

