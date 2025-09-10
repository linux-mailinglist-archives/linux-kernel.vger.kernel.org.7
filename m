Return-Path: <linux-kernel+bounces-809998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 736B0B51463
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32BC54E322D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1E63191B7;
	Wed, 10 Sep 2025 10:48:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216A82D2496
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501306; cv=none; b=Egx/E4A32sPJtVDGgYbURbPFBELJ5bPaQw2ZKQTm5mexoEePxOgwVUzZhibEVdiwijDQHYkdfm9z46JANFh16RaWpf+VMWH+vto8INYzRiBJ6YHhgCwjxbb0si73ibtj7jvJdyASP9f+FDnVHe5WDUie7kj+ltH7Ts0Z2yUGBME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501306; c=relaxed/simple;
	bh=v3t3dz9WKFUZfR1BayWJSIHs1QiJt5x5lxPwsAnPAmM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sO7/+QbENrrufGWuZmez+T7F8l/VDzBg8hQQYdYcatojWMQKV7e75ynj41xwJZLuKz20TmHkYyCxbBV6rNKIPjfKts5bw4Oq/S64rtp9BXfga1AO9lDcSSKY3qnriPLLJSfPYRXNihjFzVrzpEevIGjdAGrZmD8s0MKUhxX/9NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41F8B16F8;
	Wed, 10 Sep 2025 03:48:15 -0700 (PDT)
Received: from donnerap (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67B503F66E;
	Wed, 10 Sep 2025 03:48:22 -0700 (PDT)
Date: Wed, 10 Sep 2025 11:48:19 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Russell King <linux+etnaviv@armlinux.org.uk>,
 <etnaviv@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, linux-sunxi
 <linux-sunxi@lists.linux.dev>
Subject: Re: drm/etnaviv: detecting disabled Vivante GPU?
Message-ID: <20250910114819.00dfe07a@donnerap>
In-Reply-To: <8192c4d04f1640f140a8f2cb43e694a7476bb0ca.camel@pengutronix.de>
References: <20250904002924.2bc63b73@minigeek.lan>
	<8192c4d04f1640f140a8f2cb43e694a7476bb0ca.camel@pengutronix.de>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 09:28:19 +0200
Lucas Stach <l.stach@pengutronix.de> wrote:

> Hi Andre,
> 
> Am Donnerstag, dem 04.09.2025 um 00:29 +0100 schrieb Andre Przywara:
> > Hi,
> > 
> > the Allwinner A523/A527/T527 family of SoCs feature a Vivante
> > "VIP9000"(?) NPU, though it seems to be disabled on many SKUs.
> > See https://linux-sunxi.org/A523#Family_of_sun55iw3 for a table, the
> > row labelled "NPU" indicates which model has the IP. We suspect it's
> > all the same die, with the NPU selectively fused off on some packages.
> > 
> > Board vendors seem to use multiple SKUs of the SoC on the same board,
> > so it's hard to say which particular board has the NPU or not. We
> > figured that on unsupported SoCs all the NPU registers read as 0,
> > though, so were wondering if that could be considered as a bail-out
> > check for the driver?
> > At the moment I get this, on a SoC with a disabled NPU:
> > [    1.677612] etnaviv etnaviv: bound 7122000.npu (ops gpu_ops)
> > [    1.683849] etnaviv-gpu 7122000.npu: model: GC0, revision: 0
> > [    1.690020] etnaviv-gpu 7122000.npu: Unknown GPU model
> > [    1.696145] [drm] Initialized etnaviv 1.4.0 for etnaviv on minor 0
> > [    1.953053] etnaviv-gpu 7122000.npu: GPU not yet idle, mask: 0x00000000
> > 
> > Chen-Yu got this on his board featuring the NPU:
> >     etnaviv-gpu 7122000.npu: model: GC9000, revision: 9003
> > 
> > If I get the code correctly, then etnaviv_gpu_init() correctly detects
> > the "unsupported" GPU model, and returns -ENXIO, but load_gpu() in
> > etnaviv_drv.c then somewhat ignores this, since it keeps looking for more
> > GPUs, and fails to notice that *none* showed up:
> > /sys/kernel/debug/dri/etnaviv/gpu is empty in my case.
> > 
> > Quick questions:
> > - Is reading 0 from VIVS_HI_CHIP_IDENTITY (or any other of the ID
> >   registers) an invalid ID, so we can use that to detect those disabled
> >   NPUs? If not, can any other register used to check this? The whole
> >   block seems to be RAZ/WI when the NPU is disabled.
> >   
> Yes, 0 is not a valid core ID.

Ah, thanks, that helps to identify the situation (see below).

> > - Would it be acceptable to change the logic to error out of the
> >   driver's init or probe routine when no GPU/NPU has been found, at
> >   best with a proper error message? As it stands at the moment, the
> >   driver is loaded, but of course nothing is usable, so it keeps
> >   confusing users.  
> 
> Yes, I think it would be fine to not expose the DRM device at all if no
> usable GPU core has been found.
> 
> However, I think it would still be good if your bootloader would fix up
> the DT to avoid probing the driver at all if possible. It may work on
> your system but access to a disabled GPU MMIO is not RAZ/WI everywhere.

Yes, I agree, Allwinner is "nice" by using RAZ/WI if possible, but indeed
most other platforms SERROR out when touching an address without a device.

> On i.MX8M* we have a similar situation with disabled peripherals. There
> the bootloader can detect which peripherals are active by looking at
> the SoC fuses and fixes up the DT status property accordingly. Not sure
> if you may have something similar on the Allwinner.

We have code for DT patching in U-Boot, and use that already for some
Allwinner boards. I don't know if we can identify the actual fuse used. We
could use the SoC package identifier (first word of the SID eFUSE device,
cf. the second row in here [1]), but that would require maintenance, as new
IDs will show up, and we don't know every single one even now.
Another method would be to just ungate the clock and de-assert the reset,
then read the NPU ID register (0x18?) to see if it's zero or not. Probably
the most robust, but involves a bit more code, as we probably would need
some pseudo-device to fetch those reset/clock details from the DT.

I guess the current situation works as well, for now, but I will look at a
U-Boot patch, just wanted to check if we can avoid that.

Cheers,
Andre



