Return-Path: <linux-kernel+bounces-830563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363FEB99FC6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E603C171EF9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8490F301477;
	Wed, 24 Sep 2025 13:13:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4C0502BE;
	Wed, 24 Sep 2025 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758719606; cv=none; b=NKjVOiJ10mQt+sXXu2S7qBQBEDS2ILiudbzafsId/04jYgMPvMeY8WkBstRpS3fGpNCxW88R+PpsGmqUQeD7gZybryOVAv8qXJnsZuHsf+soWftHNzVnBSLwj84S/5HRky51dlj5BgTOq1DOj5z1KV5LUClRkv0pcfZ47BI/KLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758719606; c=relaxed/simple;
	bh=PaVdJZ/PeqgEBbm90xkNqO1qgjBPVF79+jKWROcFGY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EP49ki1hjQXSEd5+/QSIa1t2Pq9EzH8TixU0VZpXhRl0rMXCPjJcyaxwhbP6A7OjPNIz+j3qrrbK7v1ZKQjpNDoQPXtIEPC0rSuGFOPYSTgGYY3Yt8+mJBNTHL6FGoOI9OozkPzfVhMYEcWlfSWkTX10jyFxdH+mFnUOkVKmANQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD41C106F;
	Wed, 24 Sep 2025 06:13:15 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C7953F5A1;
	Wed, 24 Sep 2025 06:13:20 -0700 (PDT)
Date: Wed, 24 Sep 2025 14:13:18 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Sebin Francis <sebin.francis@ti.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	"Marco Felsch" <m.felsch@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Brian Masney" <bmasney@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] clk: scmi: Support Spread Spectrum for NXP i.MX95
Message-ID: <20250924-dark-super-gharial-246400@sudeepholla>
References: <20250915-clk-ssc-version1-v4-0-5a2cee2f0351@nxp.com>
 <20250915-clk-ssc-version1-v4-5-5a2cee2f0351@nxp.com>
 <5f508f1d-2d08-4687-86cd-d1944caa0a49@ti.com>
 <PAXPR04MB8459CE9F22CD56A9BFDB5E78881DA@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <082735e7-956b-4574-952e-06ba69db41f1@ti.com>
 <PAXPR04MB84590D5AAAB56ED7E1CBDE05881CA@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR04MB84590D5AAAB56ED7E1CBDE05881CA@PAXPR04MB8459.eurprd04.prod.outlook.com>

On Wed, Sep 24, 2025 at 11:43:56AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH v4 5/5] clk: scmi: Support Spread Spectrum for
> > NXP i.MX95
> ...
> > >>>        SCMI_CLOCK_CFG_OEM_START = 0x80,
> > >>> +     SCMI_CLOCK_CFG_IMX_SSC = 0x80,
> > >>
> > >> TI is also planning to implement the same in our upcoming platform.
> > >> so can we use a generic ID instead of vender specfic message ID?
> > >
> > > I tried to push to new generic ID [1] in half a year ago, but in the
> > > end ARM decided not to add generic ID for spread spectrum support.
> > >
> > > To i.MX, it is too late to use a generic ID and waiting spec, i.MX
> > > firmware has been public for quite some time and passed several
> > external releases.
> > > So I need to use what our firmware adds and spec allows: vendor
> > > extension.
> > 
> > Thanks for the quick response,
> > Since this implementation is specific to i.MX, can you move this to a
> > vendor specific file, so that it will not break i.MX's firmware and TI can
> > implement SSC in TI specific file.
> 
> i.MX has encountered issue with pinctrl-scmi.c and pinctrl-imx-scmi.c
> both supports SCMI PINCTRL. Current linux scmi does not support
> both drivers built in kernel image, because scmi devlink issue.
> 
> Sudeep said he would address the devlink issue in 6.19 cycle.
>

Yes it is a different issue IMO and nothing related to this.

> Given the current situation, I'm hesitant to introduce a new driver
> saying clk-imx-scmi.c.
>

Yes please don't, and I don't see a strong reason for that(yet).

Unlike vendor protocol, there is no way we can no upfront how the vendors
can use this in their own colourful way. So I am not sure if we start
building something generic from the start or refactor as more vendors start
using it. Hard to decide 🙁. Lets see, need to think a bit.

If Peng or Sebin or others have some idea, please propose or start the
discussion so that we can evaluate the approach.

-- 
Regards,
Sudeep

