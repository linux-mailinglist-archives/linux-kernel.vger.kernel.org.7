Return-Path: <linux-kernel+bounces-863449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF8CBF7E01
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3088504A44
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2BE353ACF;
	Tue, 21 Oct 2025 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cjHCmx+d"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3D1352FAE
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067155; cv=none; b=ZjPIGIksfku4IjC88Cxej2xjlKQMoWTakwUXcigv0iTxYOScGUZVUz1Zbdihi6mxF4w6qpC2K6kMiUDOIjpKNesw1uSGGOM9XW8v4tCZn8SLqy6pSHLcF35BrYSPIjGU8X21rLH7ir16DdrzP4ZM/eugGyTwyhj624+Me1yIUZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067155; c=relaxed/simple;
	bh=cnD/H/0gNm98pqZbQfHq8ymYqO3lWuk3CMpCEik4/lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qK7dv37q6dpSp6JbDJv85NNBOBd8hi2lJPp/rgCi40Pk3mZcm+hTaZJQBwW6HeNmVuT8B6WRTnYfhTkm/oWry/eFi3ge633Dks6x5NyKLYxVpICR4QiNMca0UAzfD/IecnYgt9JYlZrncYSEjVjIJOoScl8c6a7d5qSXQ/4Z3Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cjHCmx+d; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M+Kr7F5xXeMkJk76WZuYzSfsdDFuThSvbzE/jrNSXJg=; b=cjHCmx+dW9qBiQIWU/ZwIATd7e
	mtPJQTQytSkRTQ/t9+YrdxDzoN2sIDh1BGK3rdIxMA1IzrOg6XZ0wNgpK3jV/SnTyL6Ic1b88OEzX
	zIDeqSUod4D6nlPqYGCUaJ/nxcnvnWEnqjdSzVlWG7nDlBFM5AofvYxdxiAO3lXNljcKChaswMmSl
	lVepzpR15DZVaneWOOAqOQ8L28/RPuoxbwIIuzotLpBU15EYjoIUp5aCJ99TrPwgsqNSzF2ZbXTde
	OZe88lyv9WcrscrOEnUUpVLuU+8ZrBI4TSC5o9m+jR/ELEK6a8vq6FQmNBol5KNajuj7L5pHw+5sH
	DcXfT5TA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBF8y-00000000tCG-2GS7;
	Tue, 21 Oct 2025 16:23:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 43048303194; Tue, 21 Oct 2025 15:30:18 +0200 (CEST)
Date: Tue, 21 Oct 2025 15:30:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
	Breno Leitao <leitao@debian.org>,
	Kriish Sharma <kriish.sharma2006@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org, Menglong Dong <menglong8.dong@gmail.com>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Aditya Gollamudi <adigollamudi@gmail.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] sched: remove unused cpumask variable in mm_cid_get()
Message-ID: <20251021133018.GV3419281@noisy.programming.kicks-ass.net>
References: <20251009194818.1587650-1-kriish.sharma2006@gmail.com>
 <v3zyf7pp64yd4kakqniq4thjf2egb3kavkwzgoqt6ye5cuqkys@jmkcwst6lrn2>
 <67e75a68-7a03-46bb-ae40-b1a8f24c0b16@suse.cz>
 <20251014103439.GU3245006@noisy.programming.kicks-ass.net>
 <yc3bcn76b6jcdcbnoegwi6bigccor32fuevg66o2lqdewem7dc@nvujb2gazknq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fxymkO5VxfNQA8+a"
Content-Disposition: inline
In-Reply-To: <yc3bcn76b6jcdcbnoegwi6bigccor32fuevg66o2lqdewem7dc@nvujb2gazknq>


--fxymkO5VxfNQA8+a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 02:01:42PM +0200, Uwe Kleine-K=F6nig wrote:

> There are several other submissions of the same patch with different
> commit logs; I found:
>=20
> https://lore.kernel.org/all/20251002-sched-w1-v1-1-a6fdf549d179@linaro.or=
g/
> https://lore.kernel.org/all/20251009194818.1587650-1-kriish.sharma2006@gm=
ail.com/
> https://lore.kernel.org/all/20251015091935.2977229-1-andriy.shevchenko@li=
nux.intel.com/
> https://lore.kernel.org/all/20251020221728.177983-1-adigollamudi@gmail.co=
m/
> https://lore.kernel.org/all/20251017073050.2411988-1-kevin.brodsky@arm.co=
m/=20

I know right, I seem to be getting at least one a day. If only people
were as good in testing -next I suppose. It also shows people can't be
arsed to search the archive :/

> Also Krzysztof's build bot is very unhappy:
> https://krzk.eu/#/builders/135

Not familiar with that thing.

> > People using W=3D1 and WERROR can keep the pieces. Anyway, this is a mu=
ch
> > more coherent explanation that the original patch.
>=20
> Can we please get this fixed even though you don't bother about W=3D1
> builds? There seem to be others who do. And note that even
>=20
> 	make W=3D1 drivers/pwm/
>=20
> is broken due to that, so it affects also maintainers who only want W=3D1
> for their own subtree.

Only if you have WERROR=3Dy, which really you shouldn't have if you use
W>0.

> Regarding the Fixes line: Vlastimil Babka bisected it to 378b7708194f
> ("sched: Make migrate_{en,dis}able() inline"), but I think this is just
> the commit that made the compiler notice that. IMHO Andy identified the
> more plausible commit with:
>=20
> Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_=
cid")

Right, as said, Thomas is rewriting all that. His first patch is a
revert of that commit:

  https://lkml.kernel.org/r/20251015164952.694882104@linutronix.de

> Note there is a lkp report about Andr=E9's patch (i.e. the first in my
> list above) at
> https://lore.kernel.org/all/202510041546.DvhFLp2x-lkp@intel.com/#t. I
> don't understand the issue found there, but maybe someone should before
> the patch is applied.

That's unrelated to the patch in question -- it is the robot
re-reporting a smatch thing because the code changed and the new report
no longer exactly matches the old report or something.

smatch wasn't able to discover the relation between next->mm and
next->mm_cid_active and warns us that next->mm can be NULL (per a
previous test for that) and that feeding said NULL into mm_cid_get() is
a problem -- it would be, except next->mm_cid_active cannot be set if
!next->mm.

*sigh*, it just means Thomas will have to rebase his series -- not the
end of the world I suppose but I really don't get this obsession with
W=3D1.

The problem is really that I'm now mandated to keep the scheduler W=3D1
clean, and I really, as in *really* don't care for W=3D1. A number of
warnings there are just not sane, like that ludicrous unused static
inline warning.

But sure -- send a patch for this, with a coherent changelog. I'll be a
bigger pain in the arse the moment the 'fix' really doesn't make sense.
I'll probably propose removing the warnings from W=3D1, like here:

  https://lkml.kernel.org/r/20250813152142.GP4067720@noisy.programming.kick=
s-ass.net

--fxymkO5VxfNQA8+a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEv3OU3/byMaA0LqWJdkfhpEvA5LoFAmj3itwACgkQdkfhpEvA
5LqukQ//U6FTdN7g4gs5PZH899K0jewxOjjhSoLXYvBMlfWUuSs3G3UmbvEd6zqy
KiEUtgOkSfuOu6Qe0tvBIX1i/p414KLdielKjukm4zSflHZPLUWIRKv8eQRU/lV3
8dHIPsIpr/K9a+jOg7Yq0uS520yCH5dXKvV4Mjdd7Dq0QakGpVNNyTg67PVV0aoL
j4L7ojLHK8qI2jBUYP2LG4QlA/NXUnzhvkYgq8Tsu/6jKbiD8UTY2YqwUmTGyZRO
fAh4iZsZRG86Fq4iWAz+LpXuxjnW4LFP6aE5bLAZFcV2qYxDrMqvNX3n/0FpXGJI
ibWAvhW8yAWfYF1Ynrr/pfZxgrpTxz3jv5mb6g/Y7hEYniux3JtchvXSV2LJQx/N
e45SpLDuGC4xWVSIeTLR+Offij1vPuTH6AdjbcgJ6qB1DNMp/Xzi38/fB+wgr2Q8
NnMCMF57ePCewqKUFEbHRwiDTdfv30dtYp21y23mCdN8zeBuk+696w4ykoEerq7W
Rs3NNntvgq2tGJeIvqa9MzQssSjRoF4322iOviscKop/re/OJAcQjpr7a0BMhw1e
DnATBPqZjhxsrmOpwcLtSheSZnG1YVt3K39/oYfIjX8PyNH2IuD/Nst2eNut7suh
zR3OdbJYYdLiWy27mhiNQinVyQ9JzSG06lwKiBFwBZe+S2K7/3M=
=B1wy
-----END PGP SIGNATURE-----

--fxymkO5VxfNQA8+a--

