Return-Path: <linux-kernel+bounces-736961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DAFB0A5C8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E554E522A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BDB199931;
	Fri, 18 Jul 2025 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIAe4PMd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6744C14F9D6;
	Fri, 18 Jul 2025 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752847332; cv=none; b=rCV3ZrpI6Jdt7hjAA5+80VIlDHErUhXkaXfXsFUSRKL9UD5jc7S4ZuPcTPEHlepv4oz0sxV03qXUwgvG/WU6pYc6TbuOhX3HfCOHDrUNRthC3eU2R5pugD/K11h7JL4PPI6LPiy7rxNz6OBQhopDvgTz7i+x9LCRdg4vVsp3awY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752847332; c=relaxed/simple;
	bh=rsBNWqlTL8i54Sx9D9C3mxse6uvzSkaPpwO3d+k29qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTKftG5kpHzeDrsQO9hD2ZMiuvi1XOnEMDiQWy+xeTJZE45/5YvT1OIAHD4ROJeueuqBUttlgtfNRsRr9V/Sqhnp1Sp2Yd3M6JX70392Z2sN/IO265V+++21y/Iijs7pPnAFgODc91VsXGEuDxbyhA8h2d7tctugs2+Me26V0XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIAe4PMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354E0C4CEEB;
	Fri, 18 Jul 2025 14:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752847331;
	bh=rsBNWqlTL8i54Sx9D9C3mxse6uvzSkaPpwO3d+k29qE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SIAe4PMdV3yaxsYMtxJtlJsUXv78hPNbsWugENbzbJNPe+RC6VJ1nRWh+0Gf95cdD
	 CluoMoNzjIPb7dRh+ooSu/GNi5xFyM17A322vAI2klq3/F1rWLvnnePfLU3PKp84Yo
	 oZ4xQEfusCXGbZ41hVhlapz6aZqOPZg4jGVE/EuRxr4uVNdRIMGcw4iBOUKc547h+5
	 3VeUOpQC0HIoDWdswLfM+eW1kPkEMZG/MtYUR3ZLTBCO5q3GrZYqcuotslFeI39gve
	 uJ3nyhCjHM4YiAxiae6p09Ka/pgZI0gARXF5tWo2JQahShWWsPDThUoL2Kl5YB7uMw
	 YTdtMZpm+h94Q==
Date: Fri, 18 Jul 2025 15:02:06 +0100
From: Lee Jones <lee@kernel.org>
To: Binbin Zhou <zhoubb.aaron@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Corey Minyard <minyard@acm.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net, jeffbai@aosc.io,
	kexybiscuit@aosc.io, wangyao@lemote.com,
	Chong Qiao <qiaochong@loongson.cn>,
	Corey Minyard <corey@minyard.net>
Subject: Re: [PATCH v7 1/3] mfd: ls2kbmc: Introduce Loongson-2K BMC core
 driver
Message-ID: <20250718140206.GI11056@google.com>
References: <cover.1751617911.git.zhoubinbin@loongson.cn>
 <2252dbc3970264371278182ebaf7669fe77d33a2.1751617911.git.zhoubinbin@loongson.cn>
 <20250710095629.GH1431498@google.com>
 <CAMpQs4JccEmMAguB92jQriwD65Ra+hQKMZnjAsWhNOKhN_Om7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpQs4JccEmMAguB92jQriwD65Ra+hQKMZnjAsWhNOKhN_Om7A@mail.gmail.com>

On Fri, 11 Jul 2025, Binbin Zhou wrote:

> Hi Lee:
> 
> Thanks for your review.
> 
> On Thu, Jul 10, 2025 at 5:56 PM Lee Jones <lee@kernel.org> wrote:
> >
> > On Fri, 04 Jul 2025, Binbin Zhou wrote:
> >
> > > The Loongson-2K Board Management Controller provides an PCIe interface
> > > to the host to access the feature implemented in the BMC.
> > >
> > > The BMC is assembled on a server similar to the server machine with
> > > Loongson-3 CPU. It supports multiple sub-devices like DRM and IPMI.
> > >
> > > Co-developed-by: Chong Qiao <qiaochong@loongson.cn>
> > > Signed-off-by: Chong Qiao <qiaochong@loongson.cn>
> > > Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> > > Acked-by: Corey Minyard <corey@minyard.net>
> > > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > ---
> > >  MAINTAINERS                 |   6 ++
> > >  drivers/mfd/Kconfig         |  13 +++
> > >  drivers/mfd/Makefile        |   2 +
> > >  drivers/mfd/ls2k-bmc-core.c | 156 ++++++++++++++++++++++++++++++++++++
> > >  4 files changed, 177 insertions(+)

[...]

> > > +static int ls2k_bmc_probe(struct pci_dev *dev, const struct pci_device_id *id)
> > > +{
> > > +     struct simplefb_platform_data pd;
> > > +     resource_size_t base;
> > > +     int ret;
> > > +
> > > +     ret = pci_enable_device(dev);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret = ls2k_bmc_parse_mode(dev, &pd);
> > > +     if (ret)
> > > +             goto disable_pci;
> > > +
> > > +     ls2k_bmc_cells[0].platform_data = &pd;
> > > +     ls2k_bmc_cells[0].pdata_size = sizeof(pd);
> >
> > This is fragile.
> >
> > Please identify the elements in ls2k_bmc_cells and use it to index here.
> >
> > See: `static struct mfd_cell as3711_subdevs`
> 
> How about this:
> 
> enum {
>         LS2K_BMC_DISPLAY,
>         LS2k_BMC_IPMI0,
>         LS2k_BMC_IPMI1,
>         LS2k_BMC_IPMI2,
>         LS2k_BMC_IPMI3,
>         LS2k_BMC_IPMI4,
> };
> 
> static struct mfd_cell ls2k_bmc_cells[] = {
>         [LS2K_BMC_DISPLAY] = {
>                 .name = "simple-framebuffer",
>                 .num_resources = ARRAY_SIZE(ls2k_display_resources),
>                 .resources = ls2k_display_resources
>         },
>         [LS2k_BMC_IPMI0] = {
>                 .name = "ls2k-ipmi-si",
>                 .num_resources = ARRAY_SIZE(ls2k_ipmi0_resources),
>                 .resources = ls2k_ipmi0_resources
>         },
>         [LS2k_BMC_IPMI1] = {
>                 .name = "ls2k-ipmi-si",
>                 .num_resources = ARRAY_SIZE(ls2k_ipmi1_resources),
>                 .resources = ls2k_ipmi1_resources
>         },
>         [LS2k_BMC_IPMI2] = {
>                 .name = "ls2k-ipmi-si",
>                 .num_resources = ARRAY_SIZE(ls2k_ipmi2_resources),
>                 .resources = ls2k_ipmi2_resources
>         },
>         [LS2k_BMC_IPMI3] = {
>                 .name = "ls2k-ipmi-si",
>                 .num_resources = ARRAY_SIZE(ls2k_ipmi3_resources),
>                 .resources = ls2k_ipmi3_resources
>         },
>         [LS2k_BMC_IPMI4] = {
>                 .name = "ls2k-ipmi-si",
>                 .num_resources = ARRAY_SIZE(ls2k_ipmi4_resources),
>                 .resources = ls2k_ipmi4_resources
>         },
> };
> 
> and
> 
>         ls2k_bmc_cells[LS2K_BMC_DISPLAY].platform_data = &pd;
>         ls2k_bmc_cells[LS2K_BMC_DISPLAY].pdata_size = sizeof(pd);

Yes, that's it.

-- 
Lee Jones [李琼斯]

