Return-Path: <linux-kernel+bounces-859958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D7BBEF0B5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2631898CB3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 02:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532231CAA7D;
	Mon, 20 Oct 2025 02:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="De83mhfT"
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1156E7260B;
	Mon, 20 Oct 2025 02:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760925744; cv=none; b=dXSFDJD1g2zd0xWbdVQ5tbdVTRJ1+4QzqeaZxJK3ng3t0kqrHozq6vHs9EYRe2cWgPEC0G9sYrwZqdHfC4ObqUuJWNTJV72e6lNrO+DI/gFjSb3yg82G0ltTk+0VJ/9PJA7hGrOENAWSJ906UHJrIleyZsXEi7fcy1CdKCYo14E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760925744; c=relaxed/simple;
	bh=bZpVhHp5/N6pg05JlUoGB10FHYF1j6tBORdhLrGRSxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaP4ZPxORAYtxV0PtR+c6d0RaCvA75tOWrdeBspRjXiSifDl78pEVJj1le/+vwr2r6mzBncmR+jbylSKgI0PMi/YldQQyopv1gmZoiLGXVDC8JRZ8DCl9Hj0sa+tQNR9tkLg9dpcu1t1wgPDA9djQn5oo6AWNsDM/bCbhh28BkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=De83mhfT; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1760925733;
	bh=tDrZLdBW9vlAha4ObE832pRI4SlMcSGwYcFakX4Jvgg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=De83mhfTB+SMEL6FoSqATpUvVrkiDPhKn6HyC6bJVQqN267SDmcEASKZNcKVh7NxT
	 uWvc0rfh+vSDxQspenowFGe8RkdHVQHzUtssil7AlYXxuZdeE90XBVxJKpnxFuc07Y
	 4yw9uuIH/jPfQzOoWtXqLySt5rvk08CQA0mkUA78=
X-QQ-mid: esmtpgz14t1760925726tab82be72
X-QQ-Originating-IP: JztUbLLiixmarjYZDA3tn8Rw/nWdOn2trEbtlH9vQgE=
Received: from = ( [14.123.254.135])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 20 Oct 2025 10:02:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14701641022016592372
EX-QQ-RecipientCnt: 14
Date: Mon, 20 Oct 2025 10:02:04 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Yixun Lan <dlan@gentoo.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] riscv: dts: spacemit: add MusePi Pro board device
 tree
Message-ID: <52A7E982E5B11F53+aPWYHMbImTxJy7pJ@kernel.org>
References: <20251017-k1-musepi-pro-dts-v3-0-40b05491699f@linux.spacemit.com>
 <20251017-k1-musepi-pro-dts-v3-2-40b05491699f@linux.spacemit.com>
 <20251020015204-GYF1506524@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251020015204-GYF1506524@gentoo.org>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OZuCtzQljvyFKuNQakQ7M3sjvikqrVpqIEbHbxF5wYR0meBpsYDvDp1L
	VkJHO4tcXB0zAQcytdg8kzmfcNfPpzmfhRGJrwEcMkT1lsu7ZHy5ljLgkQ+r/HQG649Evzj
	T6RRJlSMaWlaKigKm6tgn6JH/bV/1NZM1+QbvalNkfjx+CRqpiy+IZ41v/dsMdbv5UT9/dO
	51qzuX7zOhmHPCTPfwkBsiqYh9zIAndWtPLAGBzitNyAVtlcQtFWrqHf604AebN72ILHgty
	H3lGa5FUQEVZm7KylWrxZk2eVLB+Hx0kOtgvLocwF0/W6UCcTQ3BdZ0q1/a1uUkA0gVJWJ0
	9g6QUmJezDqiRXNFpWhgplWA7YT5fHTz0fPp/6ZHpj6QZMteWn0HONI4AqC59KrW25LGAHH
	OUdYbtCwm13TOsb/kRk5a1QCy3Ann4B8QV9W0D03ELWj6UoHaGNKO0wDLOvRz3lWIGtl6Xt
	GlTFCos0b0ZZZPlLl590iryuagPn9jvICRHTecT7YmrsE8yOMFGHvCq9FpLoM9TTN/heYMK
	aKlpawBRbCUNLX0xXSxPy7aaWP9nk9Jpk8br04EHpu/KqebAu+EwOccvE+MfwJ5zt4RhgqJ
	AEo+/o1xlHlk1g4d6yiv0yO+bbByct8tpzyd/ph5FtPhViBKd3+gUXympzPoVh5uenmqqLF
	5oH69vViqfqjdVGOXbDEyMUcW5gEm5NgdQ0TxpfRejeLSE1W3rU6Hm+OA2y+NzB6sff34vr
	tIJz7C4O6sLW2xv+07vj2nc5H11NYUtkLfCjfjH9ckghGh/rrLZP0FBJ/lH6lM26WCILOx3
	W4gdy4aOQMQjzdHIGnM7OfAn9scJN9xe8Zwsi2KW9mHWXD4pRguc9K6SHwJ9gyg9sRAXFHQ
	rxnC2CnUv8HsTqh0ARGJNZ/oAFlcyh3wV9cY7L3JDuZKtAm46xvhK17Ss4VFkTEG3hvZeA7
	ImIMkqcvOuaKrkKBPEsaTLlWisZS77XQCRrv319dC2xlI1zEpkE0MDjd8a0/FTq4TWAcX4m
	DR+5RKsusLQ2gSXurmu+AyEUizhJJFfq/cwdBsKghe8Me4hLiZwgSHxMGTR7fekX7I0R6ns
	E1Js0ycw0Il
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Hi Yixun, thanks for your review.

On Mon, Oct 20, 2025 at 09:52:04AM +0800, Yixun Lan wrote:
> Hi Troy,
> 
> On 13:52 Fri 17 Oct     , Troy Mitchell wrote:
> > Add initial device tree support for the MusePi Pro board [1].
> > The board is using the SpacemiT K1/M1 SoC.
> > 
> > The device tree is adapted from the SpacemiT vendor tree [2].
> > 
> > Here's a refined list of its core features for consideration:
> >   - SoC: SpacemiT M1/K1, 8-core 64-bit RISC-V with 2.0 TOPS AI power.
> >          This suggests potential for light AI/ML workloads on-device.
> >   - Memory: LPDDR4X @ 2400MT/s, available in 8GB & 16GB options.
> >             Sufficient for various workloads.
> >   - Storage: Onboard eMMC 5.1 (64GB/128GB options). M.2 M-Key for NVMe
> >              SSD (2230 size), and a microSD slot (UHS-II) for expansion.
> >              Good variety for boot and data.
> >   - Display: HDMI 1.4 (1080P@60Hz) and 2-lane MIPI DSI FPC (1080P@60Hz).
> >              Standard display options.
> >   - Connectivity: Onboard Wi-Fi 6 & Bluetooth 5.2. A single Gigabit
> >                   Ethernet port (RJ45). Given the stated markets,
> >                   this should cover basic networking.
> >   - USB: 4x USB 3.0 Type-A (host) and 1x USB 2.0 Type-C (device/OTG).
> >          Decent host capabilities.
> >   - Expansion: Full-size miniPCIe slot for assorted modules
> >                (4G/5G, wireless etc.). A second M.2 M-Key (2230) for more
> >                general PCIe devices (SSD, PCIe-to-SATA, comm boards).
> >   - GPIO: Standard 40-pin GPIO interface, as expected for an SBC.
> >   - MIPI: Includes 1x 4-lane MIPI CSI FPC and 2x MIPI DSI FPC interfaces
> >           for cameras and displays.
> >   - Clock: Onboard RTC with battery support.
> I think you've already gave an overall description for MusePi board in
> patch [1/2] which is sufficient, in this patch you could better focus on
> what it actually done here? enabling mmc, ethernet, led, pdma, uart..
Yes, I'll remove these.

> 
> > 
> > This minimal device tree enables booting into a serial console with UART
> > output and a blinking LED.
> > 
> > Link: https://developer.spacemit.com/documentation?token=YJtdwnvvViPVcmkoPDpcvwfVnrh&type=pdf [1]
> > Link: https://gitee.com/bianbu-linux/linux-6.6/blob/k1-bl-v2.2.y/arch/riscv/boot/dts/spacemit/k1-x_MUSE-Pi-Pro.dts [2]
> > 
> ditto
> > Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
[...]
> > +++ b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
> > @@ -0,0 +1,78 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
> ..
> > + * Copyright (C) 2025 Troy Mitchell <troy.mitchell@linux.spacemit.com>
> this isn't a big problem, but I think it would be better to use SpacemiT
> Corp's Copyright, to reflect you're not doing as individual contributor..
I understand. Since I originally wrote and now maintain this DTS,
would it still be acceptable to include my own copyright line along with SpacemiT’s?
Or company-only?

                                       - Troy

