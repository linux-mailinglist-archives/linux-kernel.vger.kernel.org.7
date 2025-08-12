Return-Path: <linux-kernel+bounces-764893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56402B22889
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A565D502F34
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF3D27E1B1;
	Tue, 12 Aug 2025 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="fO1COuL7"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA4C27AC50
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005074; cv=none; b=KV3TzobswVDU34hhwg1yS8mMph9maFT4Dljr0VHBCSBaLaLKV08seij0NNGQ/QfEltXbmxjZofWvQEJzSlCkL6OCo35/B3Ps2qqLZieAv/N8CVAjsMMR1reu7kogqhOT3/Whr/9BcRk8gqydt7/uJswZtlfDpGTcSFGS2oJErtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005074; c=relaxed/simple;
	bh=k+RzygnHtw77cY5oUC1S1yGHZ5QakgKwOCKRT3EcUfA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=mI8XKycDO2NYhTN913fHvVv78YtmqrlQ2kzXwKIAojhDoN3BN7x4B7FLF51PbEsA4vqDpJBaJ3jDOs1GZjs9kUGu5kXIX2DeZg46Q14ldP109aY/XHepuBJ3gL+9P4lEvZ7vH1J/hVcviRJ2BfDpB7U8O3Z3KpGIn2uyWWda5gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=fO1COuL7; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1755005066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HT2hqwAZZG0UAbHiYEwWNljrR3mJBNDjqO64v62M4Fo=;
	b=fO1COuL7ORNxs3B9H3eGGgHU9jirAwVsKZdXfDYQgh+bWhrPOwnFtvbFpwFtmMrK8h7QSx
	G1R1zOR/S018416supYWIA/skr45GD15EDyxzwf5e02YMHZ3gWFQuWrV2108YVFoKmMHyc
	hbuoLiHAtfyt6ZgiYCo20JrHBiT6byXF+QYtTvctbCorhcpSW/GeEyUGP3zR/E0lWMdhHe
	BjWQezA7xH3eHnGuTxNraXzhvJ0fQLGcXrAI64bheWpRKS/FiWloe/KEsydGnJK9vU4bHC
	SXnUYbPFfsivpYnu++s2au44lOTAWHdj3xDLn+7hr1tUQUVkX9R1EGDKhsOHuw==
Content-Type: multipart/signed;
 boundary=72ec2ff28c27c182335a5ca95df6427b9de7efab639d68f403e5354ccd1f;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 12 Aug 2025 15:23:55 +0200
Message-Id: <DC0HD39JC201.N1K8MVD1P7OI@cknow.org>
Subject: Re: [PATCH v2] rockchip/drm: vop2: make vp registers nonvolatile
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, "Piotr Zalewski"
 <pZ010001011111@proton.me>
Cc: <hjc@rock-chips.com>, <andy.yan@rock-chips.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250706083629.140332-2-pZ010001011111@proton.me>
 <OWFHI491RHadO01jlQPA34GX28LC7SseKfNRwqQy4etkkJyP1YeF_0EDdAgpSXx5RW7go62EAOkedW5nbyn_hlz_K-NUrnNJeDFWv0OOSO8=@proton.me> <DB4WNMVBIWYS.273Z54K6O7DTM@cknow.org> <4207630.fIoEIV5pvu@diego>
In-Reply-To: <4207630.fIoEIV5pvu@diego>
X-Migadu-Flow: FLOW_OUT

--72ec2ff28c27c182335a5ca95df6427b9de7efab639d68f403e5354ccd1f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Heiko,

On Sun Jul 6, 2025 at 12:46 PM CEST, Heiko St=C3=BCbner wrote:
> Am Sonntag, 6. Juli 2025, 12:37:40 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Diederik de Haas:
>> On Sun Jul 6, 2025 at 12:20 PM CEST, Piotr Zalewski wrote:
>> >> With a new version of a patch, you're supposed to add the tags you
>> >> received for previous versions, like my Tested-by tag [1].
>> >>=20
>> >> (unless the new version has changed so much you feel they should not =
be
>> >> carried over; you then need to explicitly describe that and why you
>> >> dropped them)
>> > =20
>> > Forgot... Should i send it as PATCH v2 RESEND?
>>=20
>> I don't think that's needed; the maintainer will let you know if that's
>> desirable or that they will add it (back) when committing.
>
> The problem is then remembering to manually collect the tags from a
> previous series.
>
> For my reference, it was
> Tested-by: Diederik de Haas <didi.debian@cknow.org>
>
> So hopefully I'll remember now :-) and there is no need for a resend
> at this time.

Is more needed to get this patch accepted? If so, can I help with that?

Cheers,
  Diederik

--72ec2ff28c27c182335a5ca95df6427b9de7efab639d68f403e5354ccd1f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaJtAgAAKCRDXblvOeH7b
blk/AP9qVD2EKzBtPo/59n2gdL4G9t/u9M80pLQJzj/tM0PwowEA/d9FYzxx/rFZ
lfZGkb8gpfOqw60ZYCxDwIfQQoqU7wQ=
=3G71
-----END PGP SIGNATURE-----

--72ec2ff28c27c182335a5ca95df6427b9de7efab639d68f403e5354ccd1f--

