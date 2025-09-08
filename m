Return-Path: <linux-kernel+bounces-805926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F13A9B48F7C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15C0F7AB7C3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A68730B51A;
	Mon,  8 Sep 2025 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7k3WpDh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048D030B520
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757338020; cv=none; b=hmz10S9RDqFRaEn7m3qoCV542MBLhBESg4Pp41dNcBRsN1IukfRJQfiAXsqwpa2HZMNAqeHDVrTeQCBLa84l8gk4Bmi64A6zYLWNYbkfodwZZlvT/IQA1fs0N5J3alHsjcdyWqYjjj4tDCDAWH2Ue30M8syVQbpWRthhVMv3Mw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757338020; c=relaxed/simple;
	bh=K5YU/SfllwjVRMTHft5NGcsCbcC7qR5QHQ2I/4K/QBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRtOgdGsZAmgeDorvOpyJjJJQRbe6W4GSaUsoVP1suxGpXN5kadqVg1DOY+1XCMRLv2LL1V5OAMQCyShRybgUFMamaq9VlHKpoaS8GwmxIHZKD3DLQyNSsv2X/piY6/MIZqnWCWahyj/HAVAYFGfsIof4jbtu08drhebjDb0jZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7k3WpDh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0101CC4CEF1;
	Mon,  8 Sep 2025 13:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757338018;
	bh=K5YU/SfllwjVRMTHft5NGcsCbcC7qR5QHQ2I/4K/QBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n7k3WpDhlg6x0fgsmQLBmhKS3oYCqbOYBc21up4iOhWkKFzjJg261RsJwZxcHmGxj
	 QaClm1dXvCcJgyUsWYUuAqo+gFjAXFY1egBqWyu4J9P+4bKpxnqBdv8xHYnZ49CLbB
	 iHRGKT214MIZG6jKQKnr/xDXql7TMdyAlLEyvSFDcXG0yaerWmF/Nd5VX3a9JF19yz
	 kLsboesKeznkfg7jkzpaAs5nulSxvQWaj0Sux3PWTwiJfnZH6CmilNcM4XhKoAGeAl
	 Dn2TkRuvHdj+ideEQpPmdBz8jDkrqOqS/qH+cS5FHH7r8qoEWaRKxtJchPcyVLDYyS
	 ObT7LvzWhmsvw==
Date: Mon, 8 Sep 2025 15:26:54 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] irqchip/gic-v5: Fix kmemleak L2 IST table entries false
 positives
Message-ID: <aL7Znv7XgqFPq2Jb@lpieralisi>
References: <20250811135001.1333684-1-lpieralisi@kernel.org>
 <aK4MQ3dur0cyluGl@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK4MQ3dur0cyluGl@arm.com>

On Tue, Aug 26, 2025 at 08:34:27PM +0100, Catalin Marinas wrote:
> On Mon, Aug 11, 2025 at 03:50:01PM +0200, Lorenzo Pieralisi wrote:
> > diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-irs.c
> > index ad1435a858a4..e8a576f66366 100644
> > --- a/drivers/irqchip/irq-gic-v5-irs.c
> > +++ b/drivers/irqchip/irq-gic-v5-irs.c
> > @@ -5,6 +5,7 @@
> >  
> >  #define pr_fmt(fmt)	"GICv5 IRS: " fmt
> >  
> > +#include <linux/kmemleak.h>
> >  #include <linux/log2.h>
> >  #include <linux/of.h>
> >  #include <linux/of_address.h>
> > @@ -117,6 +118,7 @@ static int __init gicv5_irs_init_ist_linear(struct gicv5_irs_chip_data *irs_data
> >  		kfree(ist);
> >  		return ret;
> >  	}
> > +	kmemleak_ignore(ist);
> 
> Nit: if you ever respin, please add a short comment on why this is a
> false positive (easier to see it in the code than the git logs).

It was merged as-is (have been away for a couple of weeks) but I can send a
patch adding the comments to clarify the code as a follow-up.

Thanks,
Lorenzo

> >  
> >  	return 0;
> >  }
> > @@ -232,6 +234,7 @@ int gicv5_irs_iste_alloc(const u32 lpi)
> >  		kfree(l2ist);
> >  		return ret;
> >  	}
> > +	kmemleak_ignore(l2ist);
> 
> Same here.
> 
> -- 
> Catalin

