Return-Path: <linux-kernel+bounces-765505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2015BB23946
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9271B66FAA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD23E2FA0DB;
	Tue, 12 Aug 2025 19:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="eMaxHeqi"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DFE12C499;
	Tue, 12 Aug 2025 19:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755028269; cv=pass; b=D/bR9gEFdTv6LWxe3a1WckPEEWS1yo8WOV6o1t/oEWSKwHn7DA0Tzwq2zFY2c/jM47mVocMy9c+/bb87KQr1KTU2ktRK5g2rXvtHbyvMcR76NMUjtZwzn5JB6nc6cCUqqR8Ymu5P8Za5EpktIkwbQIdXXSHslAZa/I3KaViSJEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755028269; c=relaxed/simple;
	bh=zxtnfHjBmtD/lxeHHqZiSVIbM/qGuG4divGdFW2qdi4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ezv7L9Gz0i0SsH2LUCdU9pM9/kUlJcazBIDcytQqT1rED859n1/P8GikcpUA2I9EkmW5j1F7OCjou1OWA41OVDk54hS6hTUZvArG6RVdD8+E7T4TWk4SeacDsLk1ybxTw+Gr9aQyCDzLRo3K6fiwf6/2Ex1PXha9CiUYB1ONmGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=eMaxHeqi; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755028251; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Yu2uMhrYNyWUaUAxeXazZGYnC3OQ+fFsVVXyioRB4l3zGU87q0jdihf0lF8RdXAatkxjDYHB5wzC0tAYBK26tHxrMoyOU7lZSgBQTaHo1WPpicRM7U+0CnN1VZUdGnY9uJL7OVhDraYf+wgtD6ZdLOW6pBMaYi+3wMab5Mvo7ww=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755028251; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zxtnfHjBmtD/lxeHHqZiSVIbM/qGuG4divGdFW2qdi4=; 
	b=LBV1vkfZBkH5KA+5yDrt9f1dGHl+GXtTUACqb/JLXqH7xqcffzywwLe6Lnpnz/zwWRMYrIHd9MuRmeZN8n1x4upmZYjCPKAEr0941g2YNhVWp1qcpNSX0X1Aiw1K+RJPrl2EkHsN7YMYh6z63vCmdKDeEv96ODvyCN0LxGAPjmk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755028251;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=zxtnfHjBmtD/lxeHHqZiSVIbM/qGuG4divGdFW2qdi4=;
	b=eMaxHeqi/xXZKL/Enk0BfHNra7ug75xEgLch8DA1wWP6u7eVWwiu5R+SWQcTjwdW
	hSWxMzgRAu4b8Q6pvL9yLpf9TC9+imJfrVMH7pWoZEMiNh4fYl7U+lc3cKuIwTO9Pav
	98dsHfouGehJ/S1QgxIm6qmpkgiT4JFFiOwtNN0fmjMS/jcBW1gBO/vfXaZ2K/l6agb
	eOSh36HYmKFdkGjrHHa50R+Fq5I4npRJQrBfMwtBslImpci1f2wMWH9ayCaW6PIs0/Z
	Kf2NczJdEpkPu7Af5XlSlCJA9kOq2CwyMAg3rDxmbOhmFBtVoAJjuW73GYTfkZj1M1r
	uqHlEasbIA==
Received: by mx.zohomail.com with SMTPS id 175502824888099.24369588420063;
	Tue, 12 Aug 2025 12:50:48 -0700 (PDT)
Message-ID: <5909560f051cb17bcbdcad4142cf99b03e1a4c3a.camel@icenowy.me>
Subject: Re: [PATCH 0/4] clk: thead: Misc changes to TH1520 clock driver
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Michal
 Wilczynski <m.wilczynski@samsung.com>, linux-riscv@lists.infradead.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 13 Aug 2025 03:50:45 +0800
In-Reply-To: <aJtqrz9y4/hR8fEu@x1>
References: <20250812054258.1968351-1-uwu@icenowy.me>
	 <50a61990b5009217dcc0ed74142c4ffeba137f73.camel@icenowy.me>
	 <aJtqrz9y4/hR8fEu@x1>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2025-08-12=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 09:24 -0700=EF=BC=
=8CDrew Fustini=E5=86=99=E9=81=93=EF=BC=9A
> On Tue, Aug 12, 2025 at 09:42:23PM +0800, Icenowy Zheng wrote:
> > =E5=9C=A8 2025-08-12=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 13:42 +0800=EF=
=BC=8CIcenowy Zheng=E5=86=99=E9=81=93=EF=BC=9A
> > > This patchset is my changes to the TH1520 clock driver, mainly
> > > for
> > > supporting the display controller (the first 3).
> > >=20
> > > The first two are functionality additions, with the first one
> > > adding
> > > support for enabling/disabling PLLs (for DPU PLL) and the second
> > > one
> > > adding support for changing DPU dividers.
> > >=20
> > > The 3rd one is to address hang issues met when testing the DPU
> > > driver
> > > w/o clk_ignore_unused command line option.
> > >=20
> > > The 4th one has no relationship to display, and only exists for
> > > my
> > > need
> > > to change an arbitrary GPIO (well, GPIO3_3, the one controlling
> > > the
> > > fan
> > > on Lichee Pi 4A) with gpioset.
> > >=20
> > > This patchset has a dependency (a 0th one) [1].
> > >=20
> > > [1]
> > > https://lore.kernel.org/linux-riscv/20250809-fix_clocks_thead_aug_9-v=
1-1-299c33d7a593@samsung.com/
> > >=20
> >=20
> > Oops, looks like this patchset deserves a new revision now...
>=20
> Thanks, that does make it easier to apply with 'b4 shazam'.
>=20
> > PATCH 2/4 has a round_rate() implementation, which is considered
> > out-
> > of-date and determine_rate() will replace it.
>=20
> I saw your reply over in the big patchset from Brian Masney. That's
> good
> that we will be able to skip adding round_rate() to the driver.
>=20
> > PATCH 3/4 was broken during rebasing.
> >=20
> > PATCH 4/4 is found to be not working (and even makes padctrl0 an
> > orphan
> > clock). Yao Zi told me that I need to first do some changes to
> > ccu_gate
> > code.
>=20
> Is there a way to test the functionality without additional patches
> from
> your branch?

To be honest I know about little...

The 4th patch is the only one easy to test, but it's broken... (A
refactor must come with it to make it work).

For patch 1~3, if you are brave enough, in file drivers/clk/clk.c,
change the line `#undef CLOCK_ALLOW_WRITE_DEBUGFS` 's `#undef` to
`#define` may give you some testing facility in debugfs -- writing some
clock rate (e.g. 148500000) to /sys/kernel/debug/clk/dpu1-
pixelclk/clk_rate and then 1 to /sys/kernel/debug/clk/dpu1-
pixelclk/clk_prepare_enable in this situation could mimic what the DC
driver does -- I believe in /sys/kernel/debug/clk/clk_summary the
effect can be shown (dpu1-pll hardware enable becomes Y and dpu1-
pixelclk shows the expected rate.

WARNING: THE PARAGRAPH ABOVE IS ONLY BASED ON MY READING OF CODE, NOT
VERIFIED, CAN GET A DRAGON TO BURN YOUR HOUSE.

>=20
> I look forward to v2. Thanks for working on the display.=20
>=20
> -Drew


