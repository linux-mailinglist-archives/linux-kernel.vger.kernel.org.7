Return-Path: <linux-kernel+bounces-737835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FBCB0B116
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 19:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CEF03BB708
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 17:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE540284B4F;
	Sat, 19 Jul 2025 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="d8M51Xwj"
Received: from sonic316-54.consmr.mail.gq1.yahoo.com (sonic316-54.consmr.mail.gq1.yahoo.com [98.137.69.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905AA1E522
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752946441; cv=none; b=C63S58gGosqDYFbNqLSJtTWTdAjqsOivrj0nbI+0I5HAqOeY6PQAC89xLhm8RfaNznZoQMofq4oU48LpsJacbNEC87EkxrFFkkLgq4z4Su8L395Bb2qhOHsu8zcspnLYky1G5VCx7UBAV1llpdrrfhwT7BgyX0I60Kz4ZRukf7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752946441; c=relaxed/simple;
	bh=oAh1qtIIPnEYhKsN1ENIMHXBt23hFQBk2TVf4VG+t0w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PqWLEetxUCTUoWtpSwFkbOjiYoPk4LlepywMgXFPQeT3vVzUkXxfPa6qI+Yr95v7/Dr4laOp9t6J3EkfYYj0ZOZ4iRyiAQo+p4ttfsuF2JckYneFS/WwMetT62Md80gL2tKEsn8TH/cjQ3N2oh4j1pcaDvDge1XmZAqLrfXkLKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=d8M51Xwj; arc=none smtp.client-ip=98.137.69.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1752946433; bh=HiJ3t2uVaCcZ9V24nlVEHev/PFQn63fvHBEDh/RDfhU=; h=Subject:From:To:Cc:Date:In-Reply-To:References:From:Subject:Reply-To; b=d8M51Xwj5z2R/nwG6rI1ej9vJTyYVj5CQCwRAHmOVxDy105rzyx0BQOr+cOLTiz8x1mTvXMZd0xsL4bvRccSbmHSxFoWzu6UazzFPHoIgg99L5qj27DcMaoVAm844nCd3nAzQ0nOrvbD/ma6fG6CV8cqxQvqDelS6VnLl7TvALurOZ/UZRyJs13fNK3QvK+u153ebEguJQ5HFEHBctyC+xTY9cZFjrNtgsL/mX7U3F42xNQanuro1OcWmwDc/Rh4L9FKYfJIcBVpmFIxEKVpd+tR1Fzg9m1/JtbXvD6LGp0uIQqfFkSkGLXCKO4L+EORZcIYSCXC4PGfX0eQnBnKFg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1752946433; bh=45Krh6hjT4rBgZ07aUAEubQo+ApOOc7JHPBtQrhkzZz=; h=X-Sonic-MF:Subject:From:To:Date:From:Subject; b=f3w70l+l/z8puQRxYmkQcCU1Ow2/j3oi3h3nDFWKZdFZkJRt14fu8IicWTUpjHAp/mwu19KrrubbVFu1egRj63nFHAM8VjiCRBzeIUOVq9xYyBVdrNZnG8zThC4cYn+N4TeAKiRT0aUjHnMNx8sk/oPCgLykGx6swT5uxWktm9BT8OqWYTUWJ6k5/vqDARhnaYOu2taSi8AfNUPJI5c8IxjT38CMyTgLe1z+/rgMt1ypVe79soYpaeP0GRDCrHZ2HWdBFTW/rPN5Yxj9oEWrmUEc8qw1h8duoKBNl7lZ/MEnAfnHYArQFzzgTNXUaDvKkos6AVoEyQk4sbdJ8dlqNA==
X-YMail-OSG: 10IONAsVM1m3sVe1jaGfR.ka2W08L_cRLdJtGei.enG3uD0wkpN0DX5AZSy4syB
 jb8dnIvFFkmQ2OYRaAvZ7eg3zJksq7dPQre7HTUpAA48GPlZOXuKdXPRZwbBgSYcnwBeIqy1vcQz
 sgp1WLNANzt1k9JYAj6BdCQKhCyYaAoeHNjfsiWGd9iGHoos_GmfnYshqRmC3WHqfEIp6rHUmo5k
 hw7iZYqEV7SrXpA2Q0M8qQiadH0nSrZv0saEYQ76zyGIasKuhtAfD9NztvvQ_YipkL730fcCZBLY
 gzABP3AwcFKxZSNPmgJFYLEp35W9YofH.5zXd1iri8yBAbikpwJhNEWz.bWW9TvHzTbWHnsvCeLp
 ACXq1tm2_IQFKvb0eqdSGwB0afBFT_S3uB3gA7sXZqnybPcVx.bHJTPLWAmA852dzP6hIIHlJtWR
 km1bf.yw0ECt6y0IC_K7qMO.qf_.MjNBe2RphyxoK2osZ2v7MDhGavznkJXCJ20OU5hA.3quQK0X
 PpHBOcEx3M1BuNSJ75h0LYDTOyv5u6baH36el5mxJgkRi.A1r4rdYmy_LwHLR.lHbNDPP7KlEqwL
 dptWvuu0dgNRtJRf0GQJXVMqNVnC6PwIm5W1lhgZK4.rX5k2rR8Sb3HdH24FXKYspIgGUShX1JJt
 Tv_ewUjEtxHNVBZazvN3kzZlJfXBsTTseu1oq1pKS093fuJtLKUIT8EXB4K4AyF6IWxU3oMY6AzF
 iwjLipq.lKQAfRuoSQRTK8sjMaBn92h0a.rOB5NS2qUjp7PsjtEyMwzX5fujxj5cHULssYKm7Rfk
 reUkgipkiLpJwP4P4bvQy2w86qlnMjGiK4XRDqDS_8pzcCWmOTmt5gpUt2v8JcBghIA4i8D0gTIl
 ass626iCgL1EIhsf3nvxYFT4Ihcj75vHJ2WFKA0kQVdKQa49TpWumYMSOyVSPuB4NdLCU57ytmPo
 J2hPNVwKSY22GicT9r77tV5W4WfzlJHR070fV5rlH7AUpgs8yW_IZd2ds0jcNBLA6MDWKLj0M6JY
 cz7qIp59SoBfmfgMXheCAavkJF2qzQkJZACZ0F_t357QRAyL3HJx0TCRKwd66GT_XScQu7mQk_nl
 i9IZamt87dNRok_.Tw31C8zCdXZDzhN7We_5sScu7slPaapJ95yBONWS.rlDnh4gDV3CXxeFzXjs
 1LTt0VgzOxsbqaD_FMonp0d2VKk8H3aK7ph30EgzsJCrVQZzlf5PQHRS7fKu949ybfdcD48Ao940
 Dq.fqP49nIohVqAjy0ErP_AS9LULjQG2ffqDjIabr3J5QhRPD_HpsF7HMCmFDnYBke1pDMU4vBMQ
 TrgkmVRg3yaM__Ubik27A2ZQAp5a4K0SQBp4p.uAquVYiVpSnCUPS5d_2AhG1FkeAnzI1xQcszBZ
 kNJk1QMQj6HBsptWmdrqwsHHu6OhQO8ug3RD32JABt3nQT8fjY555slU31.SMqlgBfzEnTeH4oNG
 3.UkZfeqrphClRAIXPTlSm7WXAQG6iJHPLAhbY9coIApPECEmbF1hTORgkb0MqKrQK2V9YClM3C6
 gLxEjD.Ggz7ikYQxvlYm1DDmhLCWJVBd8MyolDmNldqVrgSHRWsLmvhEDDH_56OkRx8H1Moy1TRa
 sz5mSo0LnW9R10MnzPgXNrvohThp9p4xHJhPi1utmH9qjXzKdkgCCeMJeMZEUrlNgjp81cnQq7GV
 UymaOWaWlDDfymaiscKMkyRcFJyNvJP2HSclEixaqGOZDP0DVMppLbm4_i4AEs4Eh4pSKFQCyDrs
 hw78znoTXodSYz0Q542JKimOdD22GJh6hZeNum.vy.SJZ7iNLvD19aU01wrblX6wKJLLYzRxwO5K
 ryeHguHBgf7PPzYk98outuPNcLHHC1VdQb8ATs5jbTtv6sNKZri0L.GvhqaQEO9GjfpNtRJm1n9O
 wf3vyuwoYeCTP5pqIYynt3N2Agq.vzAJZSFExLl27YcJDGFVOhGZJwrvj9E7anMOCXBXktJrNxf_
 qMBTVCH3j91OzLs1oeetMvUSYy_t56kNY4Q7RBKU4xhMlsNuLLEQYJmWOiau476V6caHOBhC5o_L
 C1S.P_HgKKDvdTimqUZ5ISoIhKVJkNw0MAbzOFFyMBXXQj_EZnBzo79B1z2ReQA8GS3oydF_KPXb
 ScfmwdcWZnSRCGWYD2lzaJpr_0I0ziRKKXNXUc7BVC3BLcdztsyTgyp4PUT27loU6hR46tq3vNI5
 87Mn_QrfBzT_Zgkj7dsagiNtb1G.ybZ.h4bz10.n2dKjjUvHxHpRx.tuL6UEqJHUO4Q--
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 3e0f2233-44ca-431c-b940-4832ccbd6731
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Sat, 19 Jul 2025 17:33:53 +0000
Received: by hermes--production-ir2-858bd4ff7b-p7k8x (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID db3e695307cb42834ada22e727cb014a;
          Sat, 19 Jul 2025 17:23:45 +0000 (UTC)
Message-ID: <e839e9c3147746ec1e004eaee632c8d0bcd56bc9.camel@aol.com>
Subject: Re: DRM GUD driver debug logging
From: Ruben Wauters <rubenru09@aol.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst
	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Sat, 19 Jul 2025 18:23:42 +0100
In-Reply-To: <ffbc01f2-5571-4fba-ae73-86f959922bcb@suse.de>
References: <2a6afe3532235c7b76758163e2439e55c93df241.camel.ref@aol.com>
	 <2a6afe3532235c7b76758163e2439e55c93df241.camel@aol.com>
	 <ffbc01f2-5571-4fba-ae73-86f959922bcb@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Sat, 2025-07-19 at 18:44 +0200, Thomas Zimmermann wrote:
> Hi
>=20
> Am 17.07.25 um 17:02 schrieb Ruben Wauters:
> > Hello
> >=20
> > I was taking a look at the code for the gud driver. I am aware this
> > driver was recently orphaned and I wish to get up to speed on it,
> > and
> > maybe with enough learning and work I can take over maintainance of
> > it
> > in the future.
>=20
> That's fantastic!
>=20
> There's https://github.com/notro/gud?tab=3Dreadme-ov-file=C2=A0and=20
> https://github.com/notro/gud/wiki=C2=A0for more information about the gud=
=20
> protocol and driver.

Thank you! I will take a look at it

I'm not sure how much experience exactly I'll need to be confident in
taking over maintainership, but I'll take it as it comes, and hopefully
learn on the way :)
>=20
> >=20
> > I noticed that in the function gud_disconnect in gud_driv.c on like
> > 623
> > there is the following code
> >=20
> > 	drm_dbg(drm, "%s:\n", __func__);
> >=20
> > checkpatch.pl marks this as unnecessary ftrace like logging, and
> > suggests to use ftrace instead. Since (as far as I can tell) this
> > effectively just prints the function name, would it not be better
> > to
> > just use ftrace for debugging and remove this call all together?
>=20
> I'm not a great fan of these types of debugging code. We already have
> this in the DRM core/helpers. Whatever drivers print for debugging=20
> should be more helpful than just the function name. So IMHO this can
> be=20
> removed.
>=20
OK, first patch I'll send will probably remove this

> >=20
> > While it isn't actively *harming* the code as such, it does seem a
> > bit
> > unnecessary.
> >=20
> > I'd like to know the DRM maintainers opinions. I know this
> > particular
> > driver does not have a maintainer dedicated to it, so I'd like to
> > know
> > the opinion of those that maintain the subsystem, and anyone else
> > that
> > has any opinion.
>=20
> If you want to do meaningful work on the driver, you could replace=20
> struct drm_simple_display_pipe with the real DRM helpers.=C2=A0 The struc=
t
> is=20
> an artifact from older driver designs, but is now obsolete. Drivers
> are=20
> supposed to be converted to DRM atomic helpers. For an experienced
> dev,=20
> it's a copy-past job. For a newcomer, it's a nice introduction to the
> DRM code. If you want to take a look, you can study commit
> 4963049ea1ae=20
> ("drm/hyperv: Replace simple-KMS with regular atomic helpers"), which
> recently did this conversion for the hyperv driver.

This is very helpful, thank you. One of the problems I've had with
kernel dev is knowing where to start with making meaningful changes.
I've been mainly sticking to cleanup and janitor tasks since, so having
this pinpointed to me is extremely helpful.
>=20
> Best regards
> Thomas
>=20
> >=20
> > Thank you
> >=20
> > Ruben Wauters

