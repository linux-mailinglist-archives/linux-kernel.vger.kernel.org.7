Return-Path: <linux-kernel+bounces-891934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA499C43D8F
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 13:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87ACF4E4BC5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 12:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736D62DE200;
	Sun,  9 Nov 2025 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNEr1lj2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C398E4A1E;
	Sun,  9 Nov 2025 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762691447; cv=none; b=UFFN8KSs3Yaw7AbkllCTFnKCLvWxvWNid4Dj85dMOnt0i98wlawwirazCsJTq6LQngCimycBhfgD0OsSMh2jrRDhFWR6Yo0C+Od3XQh1IV5IPJy8APOcU3jlnuKHvv1bKgrFv+7aZe96dEB0to+vQuF4DyQIHkdA0fw86xJr1Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762691447; c=relaxed/simple;
	bh=uaAzoyaBailq2b/m0o0Kpjlu+Dde1wzPbhrBuIBEfDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHu0ZUwC2InpHu/T1DL8Qvlb8cqaR7T9RlfRx1RL3M9WqfHPJVI+Cv+et+HH5W421NX8pZVWFigapfkLTkzeEw8U3kPii8oWs+aI+SpNBTK/EQpbnMfvqBb5eRS1WehwhV9g508OxWsZDVN4jbYClLSeqwfzufMJPhDNL5vS9jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNEr1lj2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776D7C19424;
	Sun,  9 Nov 2025 12:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762691447;
	bh=uaAzoyaBailq2b/m0o0Kpjlu+Dde1wzPbhrBuIBEfDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FNEr1lj2oRM9QL/mU9SWQIDdmge4KwfbwhjMVBEhst+fkf+a+ZUTpmY7ziG4zbWk8
	 o1BhVcs9yexQfaHgyOfke3dsodcmL3Wpe2mtQJap8VdLTePPm+NjV8PKzxHzCeL2Ra
	 dwgHOwrgJHw4qF92ZXTq1pLuxLIZ8ZNbohqP+hIhVACo4VH4xxHSddZeQW0GIZuzF2
	 9Z/vfA8VFioDp2BnhxijTAIGfxikPpTmcsZLVBDzNBixQo07yjWprRR3CnRuIMbfEE
	 lGE0jbdSNVReiHoKq3WObsEZkO7HdM7zIewhXozXzrmhsG/brWoDlZqT0VHVop8kW2
	 x6xPHNNnE/JOQ==
Date: Sun, 9 Nov 2025 13:30:42 +0100
From: Alejandro Colomar <alx@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v2 1/4] array_size.h: Add ARRAY_END()
Message-ID: <hianmnv3t7xz4mf5oaicei4q7vqudrnkhmexzkoxags3gvyj2n@qvebtox3uvyn>
References: <35255c1ceb54518779a45351dcd79a3c1910818a.1762637046.git.alx@kernel.org>
 <202511091804.XUQA4dOK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nm4vwnmvmi2ifa5n"
Content-Disposition: inline
In-Reply-To: <202511091804.XUQA4dOK-lkp@intel.com>


--nm4vwnmvmi2ifa5n
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v2 1/4] array_size.h: Add ARRAY_END()
Message-ID: <hianmnv3t7xz4mf5oaicei4q7vqudrnkhmexzkoxags3gvyj2n@qvebtox3uvyn>
References: <35255c1ceb54518779a45351dcd79a3c1910818a.1762637046.git.alx@kernel.org>
 <202511091804.XUQA4dOK-lkp@intel.com>
MIME-Version: 1.0
In-Reply-To: <202511091804.XUQA4dOK-lkp@intel.com>

Hi,

On Sun, Nov 09, 2025 at 06:43:46PM +0800, kernel test robot wrote:
> Hi Alejandro,
>=20
> kernel test robot noticed the following build warnings:
>=20
> [auto build test WARNING on 6146a0f1dfae5d37442a9ddcba012add260bceb0]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Alejandro-Colomar/=
array_size-h-Add-ARRAY_END/20251109-062234
> base:   6146a0f1dfae5d37442a9ddcba012add260bceb0
> patch link:    https://lore.kernel.org/r/35255c1ceb54518779a45351dcd79a3c=
1910818a.1762637046.git.alx%40kernel.org
> patch subject: [PATCH v2 1/4] array_size.h: Add ARRAY_END()
> config: alpha-defconfig (https://download.01.org/0day-ci/archive/20251109=
/202511091804.XUQA4dOK-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 15.1.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20251109/202511091804.XUQA4dOK-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202511091804.XUQA4dOK-lkp=
@intel.com/
>=20
> All warnings (new ones prefixed by >>):
>=20
> >> drivers/block/floppy.c:4805:9: warning: 'ARRAY_END' redefined
>     4805 | #define ARRAY_END(X) (&((X)[ARRAY_SIZE(X)]))
>          |         ^~~~~~~~~

Hmmm, nice!  There's already an ARRAY_END() there.  I'll remove that
definition.

BTW, this reminds me that I forgot to parenthesize 'a' in my
implementation.  Do you have any preference on the implementation?
I could use either of

	(&((a)[ARRAY_SIZE(a)]))

	((a) + ARRAY_SIZE(a))


Have a lovely day!
Alex

>    In file included from include/linux/string.h:6,
>                     from include/linux/bitmap.h:13,
>                     from include/linux/nodemask.h:91,
>                     from include/linux/numa.h:6,
>                     from include/linux/async.h:13,
>                     from drivers/block/floppy.c:166:
>    include/linux/array_size.h:17:9: note: this is the location of the pre=
vious definition
>       17 | #define ARRAY_END(a)  (a + ARRAY_SIZE(a))
>          |         ^~~~~~~~~
>=20
>=20
> vim +/ARRAY_END +4805 drivers/block/floppy.c
>=20
> 5a74db06cc8d36 Philippe De Muyter 2009-02-18  4804 =20
> 5a74db06cc8d36 Philippe De Muyter 2009-02-18 @4805  #define ARRAY_END(X) =
(&((X)[ARRAY_SIZE(X)]))
> 5a74db06cc8d36 Philippe De Muyter 2009-02-18  4806 =20
>=20
> --=20
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--nm4vwnmvmi2ifa5n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmkQiXEACgkQ64mZXMKQ
wqmWEBAArRv4KqHros/WN5GykK1OkUTtJHY9EMVRNzdOYuVwLFmlCcXNgJCNmkZB
OQiOvD+vb05Dz54F3QM5IEQ9b7Ucd9PnaoPFGX74T27mBkVQCQHKctCxlV4jDsTr
hc9Mlsa6P825DWNGIOUenVXZnedXYdJ6QZQBakMGmGNTmM59MO7EsOyGGAsKuSNc
g2fWS7dmuu9UsGqLChOFuIPzyYOG+zDyx/ZsqL4KuJQdmwtsqT5hS/F7MlRYCzR7
ZL0psqotrkw+J6J10eGbnG5eD1hhryhzM220njMAa2+5dHkcmlDgaGPlFVDGu36e
k32S7FDy+8ekl4bHDcWF+u3HZdQZrznMYEGI9XERB8lRy2HHKUa84/2rEHYcKMZN
/01JlnfJDdwMTXK5UPesC8JnRKxS5WgINcbwx25pjVe4DB5Llyd0ZfeMJ2A3oO6s
mNAUdAEuxQDXp5gOGt6cNp8fHJ0WRjc8/hLKRMKzdG79A99uQyhtPJIblJ+ncY97
OrYNpmLr7nqlaNUn0Q1gc68R7eJ+0CfVwPARBd/avVt4fIbhddCV01/2wOaDakOK
ejvhJgpaDWnQiI/PczyH/APqN6jQ9zYQtN/3Gdo8gYjATsNQlur3xHlX3CEJ1TPM
/6+l/fQNKftr8OB61bbZWt34ZY6RqkIosS6aTy09EQNRN5opeRM=
=smMe
-----END PGP SIGNATURE-----

--nm4vwnmvmi2ifa5n--

