Return-Path: <linux-kernel+bounces-772214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AD4B29005
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 20:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3CDF3AB9E9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 18:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE57B22756A;
	Sat, 16 Aug 2025 18:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="nvYbCxx8"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1791922FA
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 18:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755367460; cv=none; b=INr45ap+FVqSaEcfQnMNXOjdR2ieEhM0IenhUpKs5X1HN0i3/l9aMX4NGksTwqBoYNWXHb8kW00XN6zPCIHc+jyubpAZ6LquZHFtYi0Rrp+tguOe7bRQoLooq/DJAzRqcTj18yCn9GPd2XEGn96sWMCQeZzHoTlwq69HFzx6Hm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755367460; c=relaxed/simple;
	bh=c5kwDIg4ySzbw/Qy0FWb9TeEWLS3oMfcoDK/RPtYQRU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Q9d9EKE2JLaw9TlUXRFgq849YBrm5uRUDUBZu/1Bo0pA+5c88uvfOm445h95a0VG4qznsRsmpBoOU7do8dfq/s3EfpgS6qhc6ym40cfPNPzY8DJtfU3eryD/+pj3YKRc2Vu8ZG+BlyaPgXyyzX2QQ9/BxN2WG2yec3Ganz7QRts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=nvYbCxx8; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1755367454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g/26qaPEaVZf4O3FrEsDwnEnfwkxPsNNDVlT5AKBZtc=;
	b=nvYbCxx8gE1v4qHKDtiETp+HCU2IXceJYDeeK2BjUVz2g6bfXOWFQoHj/i2LOyTQkeHCB8
	/coYb/f+5vU3lRZuDICWmmXOI6kKvOe9uPi7nZFL33csgoJltYqXtwho7HLTenjt5AwfhR
	6YaTFOkFJzq9XF8zmuNTcRw4z1LN2++nEvnJ2HNcFuCfT+wDrd11Vjy/jMuofkIe0T456p
	Nv3yFqFAlnANadhisLtdwnTXXeQDTHzaksVAtbOysN17CTx0UZ4G6GlMD4+MZAHV/IapWJ
	5KLpqSe3K9AUPSBPVJ6aNaioF9n38boBG9obdRVHHrxSY9UyT7kg6P91U5Z9DA==
Content-Type: multipart/signed;
 boundary=3f5a0330e6e688bea61be67b32a8485ab792646fbdc4cb21af8054b701f0;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sat, 16 Aug 2025 20:04:00 +0200
Message-Id: <DC41TPTBHO28.134BL9RYKZLK7@cknow.org>
Cc: "Todd Kjos" <tkjos@google.com>, =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=
 <arve@android.com>, "Todd Kjos" <tkjos@android.com>, "Martijn Coenen"
 <maco@android.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Christian
 Brauner" <brauner@kernel.org>, "Carlos Llamas" <cmllamas@google.com>,
 "Suren Baghdasaryan" <surenb@google.com>, <linux-kernel@vger.kernel.org>
Subject: Re: RFE: Make ANDROID_BINDER_IPC tristate
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
References: <DC3UBQJQJ2SN.3B2AJHOP3933Z@cknow.org>
 <2025081642-viewpoint-exemption-006f@gregkh>
 <DC3V792JTD1J.LB1A657GBFQA@cknow.org>
 <CAHRSSEyxcqydwbEHHLzHKar9AaQAjACFuM0CnBxN5XrvFQdBcw@mail.gmail.com>
 <DC410TGMPWBO.3CP1NM5WWBEJ0@cknow.org>
 <2025081612-unpledged-agnostic-7fb3@gregkh>
In-Reply-To: <2025081612-unpledged-agnostic-7fb3@gregkh>
X-Migadu-Flow: FLOW_OUT

--3f5a0330e6e688bea61be67b32a8485ab792646fbdc4cb21af8054b701f0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Sat Aug 16, 2025 at 7:32 PM CEST, Greg Kroah-Hartman wrote:
> On Sat, Aug 16, 2025 at 07:26:16PM +0200, Diederik de Haas wrote:
>> On Sat Aug 16, 2025 at 6:37 PM CEST, Todd Kjos wrote:
>> > This is not feasible since binder relies on many kernel internal funct=
ions
>> > and data that cannot be exported for loadable module. Patches for this=
 have
>> > been attempted in the past, but soundly rejected. You can see some of =
that
>> > discussion at
>> > https://lore.kernel.org/lkml/20180730143710.14413-1-christian@brauner.=
io/.
>>=20
>> That seems to be the upstreaming attempt (or at least trying to start a
>> discussion about it) of the initial patch.
>> A lot could've happened in these 7 years, but apparently not enough for
>> a different outcome. Good to know, thanks :-)
>>=20
>> FWIW these are the current ones:
>> https://salsa.debian.org/kernel-team/linux/-/blob/debian/6.16.1-1_exp1/d=
ebian/patches/debian/export-symbols-needed-by-binder.patch
>
> Ah, that makes more sense, that patch is not going to be accepted
> upsteam sorry.

I deliberately didn't link to those patches in my OP as I wanted to know
if it was possible/feasible at all (perhaps with some rework). I was
pretty sure if I had, the discussion would've only been about that
specific implementation.

The functionality (ie having the possibility to run Waydroid) seems
appealing (even ideal) to me, but (for myself) I didn't want to make it
built-in and having it available as a loadable module seems like a
great way to have both options in my (and other's) kernel.
And a functionality which should be available upstream if at all.

Cheers,
  Diederik

--3f5a0330e6e688bea61be67b32a8485ab792646fbdc4cb21af8054b701f0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaKDIFgAKCRDXblvOeH7b
boFyAP9E4LoSSuIx9dknNwaDHgd2e2kEXpGkH+jFmTHNrQSVAAEArPLBE3Hqx81A
rK9cqiAxS2wKXkLcr2aKcC0iff+snAg=
=JRBo
-----END PGP SIGNATURE-----

--3f5a0330e6e688bea61be67b32a8485ab792646fbdc4cb21af8054b701f0--

