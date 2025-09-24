Return-Path: <linux-kernel+bounces-830524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9E4B99E7D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4299F17BA31
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93050305966;
	Wed, 24 Sep 2025 12:41:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96195305079;
	Wed, 24 Sep 2025 12:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717676; cv=none; b=uKPtxJxXIZqS6qn1Vl/76KiKLkpyjfTrOqj13sQFvsSnykEKaDyFsQ40nFhKhEUlYRDn6kWHqPWmRyeMQNA5lIrlmAaRetyZHBKlaxfyR7VfKr8Hg7xYv8DcfO4fJ7Csnde9ZVGtV5SimZx/ffSWlzrFTUutpwEtHn6iCgZnYf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717676; c=relaxed/simple;
	bh=ViXFwQPUdN7FsqaWnx8BHSUf0LsN6Dr4PJUVq2VjSWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTWMO30Q5z/hj+JkX2b7J5Ak5j9xvsIc3Fvdm2IU1kxzijNBlKI9+itnO00kkGcZ8M43M3Q0NpgWJNgdAFA/M9f+eTxkzMT/IBH7kb/syZfAhLeFin7tcK583Ze5ILRm+eSBeFGEMYS2JGK/BisSs4dvSRuYg51B/7AscSkYpMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8029106F;
	Wed, 24 Sep 2025 05:41:04 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D75843F66E;
	Wed, 24 Sep 2025 05:41:09 -0700 (PDT)
Date: Wed, 24 Sep 2025 13:40:56 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sebin Francis <sebin.francis@ti.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Brian Masney <bmasney@redhat.com>, Dhruva Gole <d-gole@ti.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] clk: scmi: Support Spread Spectrum for NXP i.MX95
Message-ID: <aNPmydbv6Xm0Tj9B@pluto>
References: <20250915-clk-ssc-version1-v4-0-5a2cee2f0351@nxp.com>
 <20250915-clk-ssc-version1-v4-5-5a2cee2f0351@nxp.com>
 <5f508f1d-2d08-4687-86cd-d1944caa0a49@ti.com>
 <PAXPR04MB8459CE9F22CD56A9BFDB5E78881DA@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <082735e7-956b-4574-952e-06ba69db41f1@ti.com>
 <PAXPR04MB84590D5AAAB56ED7E1CBDE05881CA@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <c34157c5-cd13-4e85-a9ee-22446111f633@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c34157c5-cd13-4e85-a9ee-22446111f633@ti.com>

On Wed, Sep 24, 2025 at 05:45:32PM +0530, Sebin Francis wrote:
> Hi Peng,

Hi ,

> 
> On 24/09/25 17:13, Peng Fan wrote:
> > > Subject: Re: [PATCH v4 5/5] clk: scmi: Support Spread Spectrum for
> > > NXP i.MX95
> > ...
> > > > > >         SCMI_CLOCK_CFG_OEM_START = 0x80,
> > > > > > +     SCMI_CLOCK_CFG_IMX_SSC = 0x80,
> > > > > 
> > > > > TI is also planning to implement the same in our upcoming platform.
> > > > > so can we use a generic ID instead of vender specfic message ID?
> > > > 
> > > > I tried to push to new generic ID [1] in half a year ago, but in the
> > > > end ARM decided not to add generic ID for spread spectrum support.
> > > > 
> > > > To i.MX, it is too late to use a generic ID and waiting spec, i.MX
> > > > firmware has been public for quite some time and passed several
> > > external releases.
> > > > So I need to use what our firmware adds and spec allows: vendor
> > > > extension.
> > > 
> > > Thanks for the quick response,
> > > Since this implementation is specific to i.MX, can you move this to a
> > > vendor specific file, so that it will not break i.MX's firmware and TI can
> > > implement SSC in TI specific file.
> > 
> > i.MX has encountered issue with pinctrl-scmi.c and pinctrl-imx-scmi.c
> > both supports SCMI PINCTRL. Current linux scmi does not support
> > both drivers built in kernel image, because scmi devlink issue.
> >

Yes indeed, BUT the vendor protocol extensions mechanism was meant to
serve the development of vendor custom protocols and drivers, it was
NEVER meant really to allow multiple alternative drivers implementation
on top of the same standard protocols like it happened with pinctrl-imx-scmi...
 
> > Sudeep said he would address the devlink issue in 6.19 cycle.
> > 
> > Given the current situation, I'm hesitant to introduce a new driver
> > saying clk-imx-scmi.c.
> >

Even if the devlink issues will be solved, in THIS case the problem is
handling custom vendor extensions inside a standard protocol, as it is
allowed in this case...

> > What I'm unclear about is whether moving to a vendor-specific file
> > implies creating a new driver (i.e., clk-imx-scmi.c), or if it could be
> > handled via a callback or another mechanism. Could you help
> > clarify the intended direction?
> 
> My intended was to handle it via callback or something similar, so that TI
> can its own callback for the TI's SSC implementation.
> 

This is exactly what is needed, the ability to extend with vendor
extensions callback the behavior of a standard protocol where
allowed....this is NOT currently supported and sincerely that was the
reason months ago I proposed initially that maybe we could have standardized
a new common clock extension SSC instead of using the OEM extensions since:

1. it seemed a pretty generic operation
2. any per-vendor extension callback of std protocol was NOT ready :P

...then this proposal never went anywhere with ATG...AND now looking at
this thread I think that it is good at the end that we did NOT add a new
standard extended clock config instead of the IMX OEM, since now it
seems that TI wants its own non-compatible implementation...

So yes the ideal solutiomn would be to extend in a generic way the SCMI
framework so that you can add in these cases custom handling of vendor
extensions for standard protocols (and then generalize the current
clk-scmi IMX support and add the new TI one...)...but I have not thought
about this and I certainly dont have enough bandwidth now to work on
this...beside having already in the pipeline other stuff/fixes like
a proper fix for vendor drivers coex like Peng askes (rightly so a few
months ago)

Thanks,
Cristian

