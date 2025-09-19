Return-Path: <linux-kernel+bounces-824096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 123BFB881D9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEAE41C849FF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8782C0F7D;
	Fri, 19 Sep 2025 07:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7xHBPQe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC0D28725E;
	Fri, 19 Sep 2025 07:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758265825; cv=none; b=ksarqCpHQLkqw2N2NDNF9YhBRSTXrYeXK1cJkclo5+M2ghDJrlB8PF1Djf21+MELoEsjWoDzhpEhlILpCQZSrzKA9w1C9tVvQYaQRllewMTPhpVghHX6OXZb4KC6wEVd2ZOW8WOSXFGIV5WDOQ4BZRcKgDhfZhQR7WdvFh3M32A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758265825; c=relaxed/simple;
	bh=yJrpUhZpWQ7g+nM8ZFphh1JYEVOuL4XzO9hsna4Hz0Q=;
	h=Content-Type:Date:Message-Id:From:To:Subject:Cc:References:
	 In-Reply-To; b=VA+VFwA8NMYwEzF40ppPuEb5rgPnz+bOIw+NsIIJ3Fm2X3AM4hX8FpSpZEp2Y6Nz2v58/8xWoK7NpEcjnTsk4UIVy42dawfDuxdQK9GlEO4rIouC9F1s/ibPzDiuXvrEj+XOpFxEr2EEVXO4Frn8VA5iXLF8FMCOUMJbbGYAuyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7xHBPQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD25EC4CEF1;
	Fri, 19 Sep 2025 07:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758265825;
	bh=yJrpUhZpWQ7g+nM8ZFphh1JYEVOuL4XzO9hsna4Hz0Q=;
	h=Date:From:To:Subject:Cc:References:In-Reply-To:From;
	b=i7xHBPQeG+hyxv0j0jBVbNuijmA9WfKr0KnAARmLIxAGA5oIIW5Sd7ja7pvzWPDra
	 9131IG724uQemk5ivVACHIfqTVuRoz4HIWF0+SaSSVhNOVryDIXP8wqH+UsqFUYVc9
	 Qm9/d8I1x4cuQCvJGK0t25MWsad3if4iZaplaaZvPKu51fvg8CNqBh4/itp5WdOmVs
	 smAcb34D5CoMe9c0paHVIplku9NxfUAEQ/Az0TfdBFKitFX2lLawggJ/BCoPJvcoaE
	 M8T+IgPYCuaRNdgyVnwFxLPNl2AfKPMVBN4b46FnrN4z0E9KObxEcKNkag9o9GAPic
	 lfm6tM6Hjv5/Q==
Content-Type: multipart/signed;
 boundary=cb912817ced60c190c00a4a2f04d7c3350a22b93ccded44d7d2e6bb80338;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 19 Sep 2025 09:10:21 +0200
Message-Id: <DCWL7R9MZLH1.2FR5WWQEKB638@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Dhruva Gole" <d-gole@ti.com>
Subject: Re: [PATCH 2/3] clk: keystone: don't cache clock rate
Cc: "Kevin Hilman" <khilman@kernel.org>, "Frank Binns"
 <frank.binns@imgtec.com>, "Matt Coster" <matt.coster@imgtec.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Nishanth Menon" <nm@ti.com>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "Tero Kristo" <kristo@kernel.org>,
 "Santosh Shilimkar" <ssantosh@kernel.org>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Andrew
 Davis" <afd@ti.com>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>
X-Mailer: aerc 0.16.0
References: <20250915143440.2362812-1-mwalle@kernel.org>
 <20250915143440.2362812-3-mwalle@kernel.org> <7hv7lhp0e8.fsf@baylibre.com>
 <DCVTYCVUCXWH.LAMARC8K4UNU@kernel.org>
 <20250918180316.nze5ak3m5pde44uz@lcpd911>
In-Reply-To: <20250918180316.nze5ak3m5pde44uz@lcpd911>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--cb912817ced60c190c00a4a2f04d7c3350a22b93ccded44d7d2e6bb80338
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> > > > The TISCI firmware will return 0 if the clock or consumer is not
> > > > enabled although there is a stored value in the firmware. IOW a cal=
l to
> > > > set rate will work but at get rate will always return 0 if the cloc=
k is
> > > > disabled.
> > > > The clk framework will try to cache the clock rate when it's reques=
ted
> > > > by a consumer. If the clock or consumer is not enabled at that poin=
t,
> > > > the cached value is 0, which is wrong.
> > >
> > > Hmm, it also seems wrong to me that the clock framework would cache a
> > > clock rate when it's disabled.  On platforms with clocks that may hav=
e
> > > shared management (eg. TISCI or other platforms using SCMI) it's
> > > entirely possible that when Linux has disabled a clock, some other
> > > entity may have changed it.
> > >
> > > Could another solution here be to have the clk framework only cache w=
hen
> > > clocks are enabled?
> >=20
> > It's not just the clock which has to be enabled, but also it's
> > consumer. I.e. for this case, the GPU has to be enabled, until that
> > is the case the get_rate always returns 0. The clk framework already
> > has support for the runtime power management of the clock itself,
> > see for example clk_recalc().
>
> Why did we move away from the earlier approach [1] again?
> [1] https://lore.kernel.org/all/20250716134717.4085567-3-mwalle@kernel.or=
g/

Because that not fixing the root case. Also it probably doesn't work
if there is no assigned-clocks property. Nishanth asked for the
latter and the soc dtsi should rely on the hardware default.

> > > > Thus, disable the cache altogether.
> > > >
> > > > Signed-off-by: Michael Walle <mwalle@kernel.org>
> > > > ---
> > > > I guess to make it work correctly with the caching of the linux
> > > > subsystem a new flag to query the real clock rate is needed. That
> > > > way, one could also query the default value without having to turn
> > > > the clock and consumer on first. That can be retrofitted later and
> > > > the driver could query the firmware capabilities.
> > > >
> > > > Regarding a Fixes: tag. I didn't include one because it might have =
a
> > > > slight performance impact because the firmware has to be queried
> > > > every time now and it doesn't have been a problem for now. OTOH I'v=
e
> > > > enabled tracing during boot and there were just a handful
> > > > clock_{get/set}_rate() calls.
> > >
> > > The performance hit is not just about boot time, it's for *every*
> > > [get|set]_rate call.  Since TISCI is relatively slow (involves RPC,
> > > mailbox, etc. to remote core), this may have a performance impact
> > > elsewhere too.
> >=20
> > Yes of course. I have just looked what happened during boot and
> > (short) after the boot. I haven't had any real application running,
> > though, so that's not representative.
>
> I am not sure what cpufreq governor you had running, but depending on the=
 governor,
> filesystem, etc. cpufreq can end up potentially doing a lot more of
> the clk_get|set_rates which could have some series performance degradatio=
n
> is what I'm worried about. Earlier maybe the clk_get_rate part was
> returning the cached CPU freqs, but now it will each time go query the
> firmware for it (unnecessarily)

There doesn't seem to be a cpufreq compatible for the am67a (which
might make sense to add though). But I'm wondering how much energy
that will save because the SoC can't do voltage scaling.

-michael

> I currently don't have any solid data to say how much of an impact
> for sure but I can run some tests locally and find out...
>
> >=20
> > > That being said, I'm hoping it's unlikely that
> > > [get|set]_rate calls are in the fast path.
> > >
> > > All of that being said, I think the impacts of this patch are pretty
> > > minimal, so I don't have any real objections.
> > >
> > > Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> >=20
> > Thanks!
> >=20
> > -michael


--cb912817ced60c190c00a4a2f04d7c3350a22b93ccded44d7d2e6bb80338
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaM0B3RIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/j93QGAmv8mlcnn/U296qSb5qVlNNhouKQqHfAp
S37O0b5o/H2D++FFDN7P0+8oG6Z/DZslAXsH8+7nsfujBqs7SZbKUgOD8h4X/pHy
iiuG302gZzP0JcSbusNqdTyWSSI3jX/RN88=
=e1rG
-----END PGP SIGNATURE-----

--cb912817ced60c190c00a4a2f04d7c3350a22b93ccded44d7d2e6bb80338--

