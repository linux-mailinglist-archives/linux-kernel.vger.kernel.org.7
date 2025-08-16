Return-Path: <linux-kernel+bounces-772196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A9EB28FC8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 19:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCB51C2583E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 17:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A2D2F60A9;
	Sat, 16 Aug 2025 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="dxv0rl6r"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A132FFDC4
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755365193; cv=none; b=PXBO1VHHRr41xsdtDLx37fmqiVJF2iqrC6WN1AW22eQ0++uLJK4zA9kOgdGG3s1x+JoBTrcUL3TssdLTX99IQ9X2FoVC9X2W/joPFXlHYNglssmdPM0GN5DcoqQXHPoTiDJ8aCJqV5YOWTlxB0vHlBu1DDr2cxjgLSRJcqE0SoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755365193; c=relaxed/simple;
	bh=DVhZox1JbBY2xJ7jFvjY7Bbserpka9EkVtY05SBt2yE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=cNbazeESTA0rd/muGktgFCoCo9raK6P0XusVpkSTAXIqR7hWmgF5HjowPOU0z9K66A1t8sdcxwKBcZho/tCAA/yT8tYJsVh9kAuF2ekcXRkY1ceO9lxY+oK3VsD9BL4gllOmmY6oqiyqVNlOcVMnfRLBPrzCCy5sk7Efdht43Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=dxv0rl6r; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1755365186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ir4PRrv0foJMSUrxJ04CAwKKpBnrB2oKqpw/18RYe5w=;
	b=dxv0rl6rfxiiZoE+vSXvb5+WM0Qv5ruhRJIH928wH3M+mzCl/ldYy8lA6WrZCV9OVjt3Sn
	W5C2mbLSbIVOC1fh6KDdTSKauZOI64FBaXPlieqUBWqcwLDEScHdf2qoMk17VDOdSbBD6l
	1loVKQYJc1usHcpH4sam+PbwammjJWIGqW5XYEXd5V0pvHCUwgx9DS355GSYgh+M19t19O
	uG9yPnvjlamxhDuOEgX8vIWSJU6XmWt43vLdRxNCcsfUzXsqWJ5ARvkfDZ7u99RTn3+jnC
	p2pdB88vL7r/0qcThZ9zbwRoO+3QvlFN6t5jwslJ2MsH6ComSxHBOsT27Lt2Fw==
Content-Type: multipart/signed;
 boundary=ea6e302605aadf16eefba0cee419b443ffd121b0ee764855d111be28c27a;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sat, 16 Aug 2025 19:26:16 +0200
Message-Id: <DC410TGMPWBO.3CP1NM5WWBEJ0@cknow.org>
Subject: Re: RFE: Make ANDROID_BINDER_IPC tristate
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Todd Kjos" <tkjos@google.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, "Todd Kjos"
 <tkjos@android.com>, "Martijn Coenen" <maco@android.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Christian Brauner" <brauner@kernel.org>, "Carlos
 Llamas" <cmllamas@google.com>, "Suren Baghdasaryan" <surenb@google.com>,
 <linux-kernel@vger.kernel.org>, "Diederik de Haas" <didi.debian@cknow.org>
References: <DC3UBQJQJ2SN.3B2AJHOP3933Z@cknow.org>
 <2025081642-viewpoint-exemption-006f@gregkh>
 <DC3V792JTD1J.LB1A657GBFQA@cknow.org>
 <CAHRSSEyxcqydwbEHHLzHKar9AaQAjACFuM0CnBxN5XrvFQdBcw@mail.gmail.com>
In-Reply-To: <CAHRSSEyxcqydwbEHHLzHKar9AaQAjACFuM0CnBxN5XrvFQdBcw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

--ea6e302605aadf16eefba0cee419b443ffd121b0ee764855d111be28c27a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Sat Aug 16, 2025 at 6:37 PM CEST, Todd Kjos wrote:
> This is not feasible since binder relies on many kernel internal function=
s
> and data that cannot be exported for loadable module. Patches for this ha=
ve
> been attempted in the past, but soundly rejected. You can see some of tha=
t
> discussion at
> https://lore.kernel.org/lkml/20180730143710.14413-1-christian@brauner.io/=
.

That seems to be the upstreaming attempt (or at least trying to start a
discussion about it) of the initial patch.
A lot could've happened in these 7 years, but apparently not enough for
a different outcome. Good to know, thanks :-)

FWIW these are the current ones:
https://salsa.debian.org/kernel-team/linux/-/blob/debian/6.16.1-1_exp1/debi=
an/patches/debian/export-symbols-needed-by-binder.patch
https://salsa.debian.org/kernel-team/linux/-/blob/debian/6.16.1-1_exp1/debi=
an/patches/debian/android-enable-building-binder-as-module.patch

Cheers,
  Diederik

> On Sat, Aug 16, 2025 at 5:52=E2=80=AFAM Diederik de Haas <didi.debian@ckn=
ow.org>
> wrote:
>
>> On Sat Aug 16, 2025 at 2:47 PM CEST, Greg Kroah-Hartman wrote:
>> > On Sat, Aug 16, 2025 at 02:11:24PM +0200, Diederik de Haas wrote:
>> >> Programs like Waydroid allows people to run Android in a Linux contai=
ner
>> >> but it needs ANDROID_BINDER_IPC to do that.
>> >>
>> >> So hereby the request to make ANDROID_BINDER_IPC tristate so people t=
hat
>> >> want to use it can load it when needed.
>> >>
>> >> Debian has a patch to make it tristate since 2018, but it would be so
>> >> much more useful to have it tristate upstream.

--ea6e302605aadf16eefba0cee419b443ffd121b0ee764855d111be28c27a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaKC/OwAKCRDXblvOeH7b
bnxRAQDTUfioVWjg5z/Uk+w9RHlMuScF3xkhXYWm58zm/xnXmgD+M5kmWQeKWVtb
ORKOstr347rotj7J6ThpB+L2h+aB2QQ=
=MyJg
-----END PGP SIGNATURE-----

--ea6e302605aadf16eefba0cee419b443ffd121b0ee764855d111be28c27a--

