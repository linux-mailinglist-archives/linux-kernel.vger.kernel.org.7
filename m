Return-Path: <linux-kernel+bounces-889107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35659C3CBF0
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF09D4FEC27
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670CD34DCD1;
	Thu,  6 Nov 2025 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hOdgNQwH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9707D2E54D3;
	Thu,  6 Nov 2025 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448792; cv=none; b=nQLnfXewdhhFsY8ecrjy7lryZRK7RwWNLG0qlhwTtYnfXYOw6y/vctQCpJuWuwZX3wBJziTu9UL9WWPdqaKQIme03ggdAVz49gcPhYIie0inAp9ZKoZrj9m+Z+FLnnT5L87qk/k+T8z7LJF4RpWjjfBrHCMB6TfKHtKMqf1tvAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448792; c=relaxed/simple;
	bh=FUbMYbaELvLrs8bf13pLYSXjByOOd4CHpAy3KOf73zU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PAN9Uy+kIpQeYHOpOok8+aULaTrlG0R8fZ5vp5hrT1WrSVpFpW7ihhjc3hxbzwYzDuGYUrS+JXFHm+2SzSXaqgST+PDr7ysjJfj6EfHHtSsa8tPBsnXSeDkCqDWdIlDU/RsVA7XWbHpIUOl26sGtMXMBt7tvCwrP8NKGD/5b0NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hOdgNQwH; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762448790; x=1793984790;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FUbMYbaELvLrs8bf13pLYSXjByOOd4CHpAy3KOf73zU=;
  b=hOdgNQwHOA0S9nOentNv8xnf5ySG5gMk/Fiev/dS6B80yAoXJHsyvNaT
   6R9wWqWg11BTAXIqwaFQqk6nMesNLHIvEMowrJIcid7oiThggIVsaQIM5
   XZdvYZMBKaYAgFNRg1v5fFHD5rbrqz5maKZdJmw1Mpwh0L7TIS8lpQ0po
   vImqgPUomDIOADdDGLN1WoKo7rJAnni1b3+WcGAEiNWj0qbuYKiKbhzEU
   RpYYac2X6SJPefSof4YE/j1su4QEX1ymEpYukn/DQd0dMnws1ebx1JjPq
   KxqN7ee+1NMZ1ozHBLSjbnysmXIeymDamHY5csINCahk+ukkJl6aTbYb8
   w==;
X-CSE-ConnectionGUID: 3B/KXMkVR6GI5t4LA1CoBw==
X-CSE-MsgGUID: PS538C+nTSKZB7Su3MoKMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64630388"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="64630388"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 09:06:29 -0800
X-CSE-ConnectionGUID: WrSmznYITU+IH82s+lGP1g==
X-CSE-MsgGUID: DLBTkHZ8RQaDaINnNIc9PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="225055223"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.187])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 09:06:28 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 6 Nov 2025 19:06:24 +0200 (EET)
To: Marcos Vega <marcosmola2@gmail.com>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] [PATCH v2] platform/x86: hp-wmi: Fixed Omen MAX
 16-ah0xx board name
In-Reply-To: <20251106165657.23241-1-marcosmola2@gmail.com>
Message-ID: <f89e0a02-91a2-e98c-d06a-6b7060bb2848@linux.intel.com>
References: <81699228-710c-144c-0909-1fe5be0604ca@linux.intel.com> <20251106165657.23241-1-marcosmola2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-17423666-1762448784=:981"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-17423666-1762448784=:981
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 6 Nov 2025, Marcos Vega wrote:

> You are totally right, after more thorough testing, I realised I had made=
 a mistake,
> board 8D41 must only go on victus_s_thermal_profile_boards.
>=20
> I send the correct commit in hopes to fix this.
> This is my first time contributing to the kernel, =C2=A1thank you for you=
r patience!

It's no problem.

Please, send v3 with the usual changelog (see also below for one=20
additional comment).

In case you need to add (additional) comments like here now is, those=20
should be placed under --- line so our tools will automatically remove=20
them when applying.

It's also custom to add patch version history below --- line so the=20
reviewers know what was changed.

> Signed-off-by: Marcos Vega <marcosmola2@gmail.com>
> ---
>  drivers/platform/x86/hp/hp-wmi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/h=
p-wmi.c
> index 8b3533d6ba09..7a3cad80f0b5 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -92,9 +92,10 @@ static const char * const victus_thermal_profile_board=
s[] =3D {
>  =09"8A25"
>  };
> =20
> -/* DMI Board names of Victus 16-r1000 and Victus 16-s1000 laptops */
> +/* DMI Board names of Victus 16-r1000 and Victus 16-s1000 laptops, as we=
ll
> +   as some Omen boards using this profile */
>  static const char * const victus_s_thermal_profile_boards[] =3D {
> -=09"8C99", "8C9C"
> +=09"8C99", "8C9C", "8D41"

It would be better to base this on top of the review-ilpo-fixes branch=20
which currently has many additions to this so I can easily apply this=20
patch there too.

As this is a new prefix (8D), place it on own line and include the=20
trailing comma (I just decided while dealing with all these recent ID=20
patches, we really want to have these better organized than in the other=20
disorganized array).

--=20
 i.

--8323328-17423666-1762448784=:981--

