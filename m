Return-Path: <linux-kernel+bounces-788235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F1FB381A5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6F81BA6A46
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611392FF65C;
	Wed, 27 Aug 2025 11:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ip2F1tNP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84C92FD7AA
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756294856; cv=none; b=Zbv6050xF9p5k2Db4xbj/MGLp8eB1Bj92bSqrZkiZZotf3pZfG0+1dIaA+kIFMsmzPOOj7diiNCfikyTKiA2TfoSjrFizoWIY8NsRuk1iNCJzwGRCvfwRwmmiq7iKvCVWLaZy4C1FsDNjuzIvABo4f+EnoB+g7ly35w7Izve4k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756294856; c=relaxed/simple;
	bh=j7JKN3Qxc8gOY3CGeEKvm2JllThAj0nwSwGpt/ZdFUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjRf/owqZzpNnbbVTNl4biigIIp4TN2F9vpTwcGWOBB1iT7kpXO1bhtfoRGgOvzIHEvPWEisM/mMmwx4g2pRuNP+zi728ZBlDkUC8NmBbXzLdNNp43/L/0qcdktDKBUiO2FT2lzKvd10lmTfxTcF7sSI+ZGpT+SC3ZHk0sbBUaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ip2F1tNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35E7C4CEEB;
	Wed, 27 Aug 2025 11:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756294856;
	bh=j7JKN3Qxc8gOY3CGeEKvm2JllThAj0nwSwGpt/ZdFUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ip2F1tNPOmPTmdlUfxlgawt4/MvQbcBMAU5HrNLXaB2Uc1GWZSOXl7C7awQSv8+2r
	 T+RgU8qvZsLzeAC26JINq4UZXamUuwPCKRrEVqhi9joV1Ea1nKYwnyJJ3eQEpWB/2v
	 oE7sAvjdSpVlNxC3zP9tUVTL/2l391lP3CSde8VXqCpnUketo+At91daksdMMdXWQ/
	 eUPRKsR3KGeJnBTmJnGafNWTA3q+rUYsBzVBi+RUW1bjWDFcHMTSayRGXgs4IULwfL
	 avJ8BYTywObghm1f2Nj88UK5+B1n6TWgBfwqqIcI7I30OPVvKcrmqTRHb0EtYLDutW
	 0bvjKpTHBdeOA==
Date: Wed, 27 Aug 2025 13:40:53 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Daniel Stone <daniel@fooishbar.org>
Cc: Shengyu Qu <wiagn233@outlook.com>, 
	Marius Vlad <marius.vlad@collabora.com>, alexander.deucher@amd.com, christian.koenig@amd.com, 
	airlied@gmail.com, simona@ffwll.ch, harry.wentland@amd.com, sunpeng.li@amd.com, 
	siqueira@igalia.com, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	contact@rafaelrc.com, lijo.lazar@amd.com, jesse.zhang@amd.com, tim.huang@amd.com, 
	dark_sylinc@yahoo.com.ar, mario.limonciello@amd.com, alex.hung@amd.com, 
	aurabindo.pillai@amd.com, sunil.khatri@amd.com, chiahsuan.chung@amd.com, mwen@igalia.com, 
	Roman.Li@amd.com, Wayne.Lin@amd.com, dominik.kaszewski@amd.com, alvin.lee2@amd.com, 
	Aric.Cyr@amd.com, Austin.Zheng@amd.com, Sung.Lee@amd.com, PeiChen.Huang@amd.com, 
	dillon.varone@amd.com, Richard.Chiang@amd.com, ryanseto@amd.com, linux@treblig.org, 
	haoping.liu@amd.com, Relja.Vojvodic@amd.com, Yihan.Zhu@amd.com, Samson.Tam@amd.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 0/2] Add "pixel_encoding" to switch between RGB & YUV
 color modes
Message-ID: <20250827-skilled-jasper-angelfish-853f26@houat>
References: <TY4PR01MB14432B688209B2AA416A95228983EA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <aK1hPoCmLziaPPOd@xpredator>
 <TY4PR01MB1443219A9870877AF120FE63B9839A@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <20250827-imperial-mongrel-of-dignity-712fab@houat>
 <CAPj87rPhK+E2FP62fnNxFySDOkqqKxo_oa94i7DR3_6a1j1o1A@mail.gmail.com>
 <20250827-enchanted-merciful-badger-d51816@houat>
 <CAPj87rMDj-3ohEtXQYy25Rp0zNtZxQxS4Rmd-akgx9kkvB4Ysw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="kncuhvsrr3qnlsnj"
Content-Disposition: inline
In-Reply-To: <CAPj87rMDj-3ohEtXQYy25Rp0zNtZxQxS4Rmd-akgx9kkvB4Ysw@mail.gmail.com>


--kncuhvsrr3qnlsnj
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/2] Add "pixel_encoding" to switch between RGB & YUV
 color modes
MIME-Version: 1.0

On Wed, Aug 27, 2025 at 12:36:53PM +0100, Daniel Stone wrote:
> Hey,
>=20
> On Wed, 27 Aug 2025 at 12:21, Maxime Ripard <mripard@kernel.org> wrote:
> > On Wed, Aug 27, 2025 at 11:39:25AM +0100, Daniel Stone wrote:
> > > There are other reasons to have uAPI though ...
> > >
> > > One is because you really care about the colour properties, and you'd
> > > rather have better fidelity than anything else, even if it means some
> > > modes are unusable.
> > >
> > > Another is for situations which static quirks can't handle. If you
> > > want to keep headroom on the link (either to free up bandwidth for
> > > other uses), or you accidentally bought a super-long cable so have a
> > > flaky link, you might well want to force it to use lower fidelity so
> > > you can negotiate a lower link rate.
> > >
> > > I'm all for just dtrt automatically, but there are definitely reasons
> > > to expose it to userspace regardless.
> >
> > Oh, yeah, definitely.
> >
> > But bringing the big guns and the requirements we have for those to
> > address the point initially discussed by the gitlab issues seems like
> > biting off more than they can chew.
> >
> > Even more so since whatever uapi we come up with would still depend on
> > the EDIDs, and they would still be broken for these monitors.
>=20
> Sounds like we're agreeing with each other then.
>=20
> Shengyu's 'I want these broken panels to work' usecase is probably
> best served with an EDID quirk, yeah.
>=20
> The reason Marius is working on it is the reasons I said above though
> - some for uses where we'd rather clearly fail out and push an error
> to userspace than continue with visually-degraded output, and some for
> uses where people have bought a too-long cable (or bought a too-short
> one which is now at tension through a 180=B0 bend) so we want to force
> the lowest link rate possible, without dropping to a ridiculously low
> resolution.
>=20
> So I don't think these are in tension, and Marius should proceed with
> his work (complete with the proper userspace to back it up), and
> Shengyu should proceed with new in-kernel quirks, which will be
> effective when the properties are set to auto, but hard overridden by
> userspace if it decides otherwise.
>=20
> How does that sound?

Like a great plan :)

Maxime

--kncuhvsrr3qnlsnj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaK7uxQAKCRAnX84Zoj2+
doZGAYDeBn4U42pxYflUBmNr4nmthfZRNjbO/t9qAtySVnQYrc+Y88V/FrBzvE24
Kzq7rV8BgNYxo8ee0B72lotJLyC5ir/zpX0Cpf2Itc46E4GudmvDK2a2nnUA2VOx
STT9RUM2Xw==
=r7ye
-----END PGP SIGNATURE-----

--kncuhvsrr3qnlsnj--

