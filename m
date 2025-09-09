Return-Path: <linux-kernel+bounces-808649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA96B502CE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7A21C6507F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD6C343D64;
	Tue,  9 Sep 2025 16:38:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C9B274B29
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435909; cv=none; b=eXN9NKKZh+ooajnDdRMz7OE01yeE1HHsgm3Fo5HBfnzpbVruhDvDgxFqQKZlypgvFnraDUPoTry0zKbjTD7cNnMkGGd/4veVr26lfQExZIXYIJ7Zh5ImlX+afdUnUbJekz8asIaTr906YRS2qjar1Lem+AzDoLJs/VR2gjJKePw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435909; c=relaxed/simple;
	bh=QZXMYGDCZElOgGDn1xpY0MCa9AD9WFkrGpYNsxr/Bj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fj2iDwmN/mPxAaWQxAX9crEYBBpPcpBbcUV3dPZ2z1J4bBdZ2B9fzxvqPxhtym/lW3N9NYcdtGfSgzkok7rn51v5sEno4IjUMdyTSO5aI2iBJOtgm/D8W6N4OAHH91UN8gHoCFMAOacebVnexdMF9OTzSe+hdRcr1DgCM6gbMRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D94C4CEF4;
	Tue,  9 Sep 2025 16:38:28 +0000 (UTC)
Date: Tue, 9 Sep 2025 17:38:25 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] irqchip/gic-v5: Fix kmemleak L2 IST table entries false
 positives
Message-ID: <aMBYAbq_dlDB9HLH@arm.com>
References: <20250811135001.1333684-1-lpieralisi@kernel.org>
 <aK4MQ3dur0cyluGl@arm.com>
 <aL7Znv7XgqFPq2Jb@lpieralisi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL7Znv7XgqFPq2Jb@lpieralisi>

On Mon, Sep 08, 2025 at 03:26:54PM +0200, Lorenzo Pieralisi wrote:
> On Tue, Aug 26, 2025 at 08:34:27PM +0100, Catalin Marinas wrote:
> > On Mon, Aug 11, 2025 at 03:50:01PM +0200, Lorenzo Pieralisi wrote:
> > > diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-irs.c
> > > index ad1435a858a4..e8a576f66366 100644
> > > --- a/drivers/irqchip/irq-gic-v5-irs.c
> > > +++ b/drivers/irqchip/irq-gic-v5-irs.c
> > > @@ -5,6 +5,7 @@
> > >  
> > >  #define pr_fmt(fmt)	"GICv5 IRS: " fmt
> > >  
> > > +#include <linux/kmemleak.h>
> > >  #include <linux/log2.h>
> > >  #include <linux/of.h>
> > >  #include <linux/of_address.h>
> > > @@ -117,6 +118,7 @@ static int __init gicv5_irs_init_ist_linear(struct gicv5_irs_chip_data *irs_data
> > >  		kfree(ist);
> > >  		return ret;
> > >  	}
> > > +	kmemleak_ignore(ist);
> > 
> > Nit: if you ever respin, please add a short comment on why this is a
> > false positive (easier to see it in the code than the git logs).
> 
> It was merged as-is (have been away for a couple of weeks) but I can send a
> patch adding the comments to clarify the code as a follow-up.

No need to. One can always do a git blame ;).

-- 
Catalin

