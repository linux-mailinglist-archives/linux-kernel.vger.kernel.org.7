Return-Path: <linux-kernel+bounces-712570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA47AF0B6E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 08:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FC4C7A5CCF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 06:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A81921323C;
	Wed,  2 Jul 2025 06:17:38 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EC578F4F;
	Wed,  2 Jul 2025 06:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751437058; cv=none; b=d8Snl21lvDR2QOIvyoolmwjhY0R1ArMdePR62kgQX6C/cDMGWRGuZKOrzAxk9xJGS23F/Iq+k+Qx/HJyZRQyhYBOThB2oG9dH8pD5xWhESVY+b5XqhkSmBINptvv1NJdnkJoycnyl7xNx7xUDrMgZkKmty0oTV1U3Ocbj3Ume8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751437058; c=relaxed/simple;
	bh=wkSag4op++cUlt6HIXv9iZfn0kjA54lgKctVP4tDiqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grN/1LLSMgH5lfFgoxWjvTgCIKc4tO5u7GvIrgvH8x/KSo7Z7384WT2y/7RauLleFIkabgU5Pn3Eh8CpyCm85WiipTKKfVLC3sWf82TZlBcnMM3CDL1posY/NEfBxqIEWKYz3P8m3d89YZlj/jfqyfePZP4hucEW9I1zqQiA9hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 86AE7341F5E;
	Wed, 02 Jul 2025 06:17:35 +0000 (UTC)
Date: Wed, 2 Jul 2025 06:17:17 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Alex Elder <elder@riscstar.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, heylenay@4d2.org, inochiama@outlook.com,
	guodong@riscstar.com, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 0/6] reset: spacemit: add K1 reset support
Message-ID: <20250702061717-GYA304216@gentoo>
References: <20250613011139.1201702-1-elder@riscstar.com>
 <20250618111737-GYA157089@gentoo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618111737-GYA157089@gentoo>

Hi Philipp,

On 11:17 Wed 18 Jun     , Yixun Lan wrote:
> Hi ALL,
>   As the reset driver going through several review cycles,
> it becomes quite calm down now, I'd like to request to merge
> it into v6.17, because various drivers (pwm, emac..) will depend
> on it, even in the worst case if there is problem, I believe Alex
> will help to address..
> 
> Hi Philipp,
>   I'd like to query if you willing to take the reset driver -
> patch [5/6] through the reset tree? It sounds more intuitive,
> which also will avoid potential conflicts with Kconfig/Makefile..
>   I've created a prerequisite immutable tag which could be
> shared between clock and reset subsytem. It's tag -
> spacemit-reset-deps-for-6.17 at SpacemiT's SoC tree [1], which 
> effectively are patches [1-4] of this series.
> But, to make your life easy, I've also applied patch [5/6] at tag
> spacemit-reset-drv-for-6.17 [2] which has a small macro adjustment
> requested by Alex at [3]
>   Let me know what you think of this, thanks
> 
Just want to ping this, what do you want from my side to proceed?

or do you want me to send a more formal Pull-Request for [1],
then you can apply patch [5/6] (still need to fix the macro of [3])


> 
> Link: https://github.com/spacemit-com/linux/releases/tag/spacemit-reset-deps-for-6.17 [1]
> Link: https://github.com/spacemit-com/linux/releases/tag/spacemit-reset-drv-for-6.17 [2]
> Link: https://lore.kernel.org/all/528522d9-0467-428c-820a-9e9c8a6166e7@riscstar.com/ [3]
> 
> On 20:11 Thu 12 Jun     , Alex Elder wrote:
> > This series adds reset controller support for the SpacemiT K1 SoC.
> > A SpacemiT reset controller is implemented as an auxiliary device
> > associated with a clock controller (CCU).  A new header file
> > holds definitions used by both the clock and reset drivers.
> > 
> > In this version several "multi-bit" resets have been redefined as
> > individual ones.  For example, RESET_AUDIO had a mask that included
> > 3 bits.  Now there are 3 separate resets (one for each bit):
> > RESET_AUDIO_SYS; RESET_AUDIO_MCU_CORE; and RESET_AUDIO_APMU.
> > 
> > The reset symbols affected (their previous names) are:
> >     RESET_USB3_0 ->
> >       RESET_USB30_AHB,  RESET_USB30_VCC, RESET_USB30_PHY 
> >     RESET_AUDIO ->
> >       RESET_AUDIO_SYS, RESET_AUDIO_MCU, RESET_AUDIO_APMU
> >     RESET_PCIE0 ->
> >       RESET_PCI0_DBI, RESET_PCI0_SLV, RESET_PCI0_MSTR, RESET_PCI0_GLB
> >     RESET_PCIE1 ->
> >       RESET_PCI1_DBI, RESET_PCI1_SLV, RESET_PCI1_MSTR, RESET_PCI1_GLB
> >     RESET_PCIE2 ->
> >       RESET_PCI2_DBI, RESET_PCI2_SLV, RESET_PCI2_MSTR, RESET_PCI2_GLB
> > 
> > No other code has changed since v10.
> > 
> > All of these patches are available here:
> >   https://github.com/riscstar/linux/tree/outgoing/reset-v11
> > 
> > 					-Alex
> > 
> > Between version 10 and version 11:
> >   - Rebased onto Linux v6.16-rc1
> >   - Redefined several "multi-bit" resets as individual ones.
> > 
> > Here is version 10 of this series.
> >   https://lore.kernel.org/lkml/20250513215345.3631593-1-elder@riscstar.com/
> > 
> > All other history is available via that link, so I won't reproduce
> > it again here.
> > 
> > Alex Elder (6):
> >   dt-bindings: soc: spacemit: define spacemit,k1-ccu resets
> >   soc: spacemit: create a header for clock/reset registers
> >   clk: spacemit: set up reset auxiliary devices
> >   clk: spacemit: define three reset-only CCUs
> >   reset: spacemit: add support for SpacemiT CCU resets
> >   riscv: dts: spacemit: add reset support for the K1 SoC
> > 
> >  .../soc/spacemit/spacemit,k1-syscon.yaml      |  29 +-
> >  arch/riscv/boot/dts/spacemit/k1.dtsi          |  18 ++
> >  drivers/clk/spacemit/Kconfig                  |   1 +
> >  drivers/clk/spacemit/ccu-k1.c                 | 239 +++++++-------
> >  drivers/reset/Kconfig                         |   9 +
> >  drivers/reset/Makefile                        |   1 +
> >  drivers/reset/reset-spacemit.c                | 304 ++++++++++++++++++
> >  .../dt-bindings/clock/spacemit,k1-syscon.h    | 141 ++++++++
> >  include/soc/spacemit/k1-syscon.h              | 160 +++++++++
> >  9 files changed, 775 insertions(+), 127 deletions(-)
> >  create mode 100644 drivers/reset/reset-spacemit.c
> >  create mode 100644 include/soc/spacemit/k1-syscon.h
> > 
> > 
> > base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> > -- 
> > 2.45.2
> > 
> 
> -- 
> Yixun Lan (dlan)

-- 
Yixun Lan (dlan)

