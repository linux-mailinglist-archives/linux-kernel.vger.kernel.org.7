Return-Path: <linux-kernel+bounces-777237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40262B2D728
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2F3D1C25E65
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E483D2DC35B;
	Wed, 20 Aug 2025 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpEFMySV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB012DC358
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755679899; cv=none; b=Xtg8bVKYzveU0tdYdx0TBtjUKVKzx7cUBlAlMS1s/qgrbIZcFnJbn2oO1Iu/l1PC4Vme1q0l+wGBhnOdCgycELtTQHBmUTN8SBr13zVk8R7kznr6JezXjZF9iQR6af9+O8fTb1l7sC5GYAMI+gp8drNdEnRLyP8BPAzdOi6UlNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755679899; c=relaxed/simple;
	bh=4oua5PIgVVAEVMnYyVUn4XS1CrIkF9Hwpeex3Quwcb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCz9v0vUpiSuWtW2ScEElaRJ4i/gshVMjDo7r+toITMHADkIcrm4jRlkVejb4E1buQUxfTUdQ149lCmj52aplGNAfsV0nihUGqaVZEgXnfbab3BLbbu3p6463W1gkg5Lessjq6BFIroFZpvlDkubw+RTj2C7rScB/77ieuqR+Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpEFMySV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF10C113D0;
	Wed, 20 Aug 2025 08:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755679898;
	bh=4oua5PIgVVAEVMnYyVUn4XS1CrIkF9Hwpeex3Quwcb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mpEFMySVY9zwdYL/PI0llyD+bGJ3ttBiagkS+mV/jiVtuThzzKk2fNXyUZ/YV/SEN
	 jud6yj5a7E2lgZWsaarCLavnXqr/7TvDAlu/HIvA6V4kJ0rlffInfJykzsMADxZwgS
	 iNX8JQ46rz4ixJnWTwCIouGny8+hkN+8mt4IHyrYNyZzig8twlKVzjXPKoSRwtGQIZ
	 WDvf1OfMtAaNxt8owBPxTp7O1CjBNQZBjJlzFGmYYbSFNSiGqVvpEh3DWcVn/5vkds
	 dK0/HFjg3gFQU569U6Llue74QL7jR7IrYbmhrx3GVxlK3O4WvXLYkJ9/6+LOnuKuoo
	 ZLNaXsXoYWheQ==
Date: Wed, 20 Aug 2025 10:51:34 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] irqchip/gic-v5: Delete a stray tab
Message-ID: <aKWMliisXtcezqrl@lpieralisi>
References: <cover.1752777667.git.dan.carpenter@linaro.org>
 <670bb1dc-7827-4916-84f3-bb46ee408b20@sabinyo.mountain>
 <3a1aa279-718f-4e45-add0-05727ba41706@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a1aa279-718f-4e45-add0-05727ba41706@suswa.mountain>

On Thu, Aug 07, 2025 at 05:55:50PM +0300, Dan Carpenter wrote:
> Hi Thomas,
> 
> Sorry, I screwed up the over letter so it was sent as a different
> thread.  These three patches are still required.  Lorenzo reviewed
> and tested them.

Hi Thomas,

forgive me the bother, just wanted to ask please if patches (2-3) in
this series are on your radar (patch 1 technically isn't a fix) or
should we resend them ?

I am going to be away for 2-weeks and wanted to make sure they did not
get lost (Dan sent them before the GICv5 driver code was queued in -next
for v6.17).

Thanks,
Lorenzo

> Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Tested-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> 
> regards,
> dan carpenter
> 
> On Thu, Jul 17, 2025 at 01:45:24PM -0500, Dan Carpenter wrote:
> > This line is indented one tab too far.  Delete the tab.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > v2: no change
> > 
> >  drivers/irqchip/irq-gic-v5-irs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-irs.c
> > index f845415f9143..ad1435a858a4 100644
> > --- a/drivers/irqchip/irq-gic-v5-irs.c
> > +++ b/drivers/irqchip/irq-gic-v5-irs.c
> > @@ -568,7 +568,7 @@ static void __init gicv5_irs_init_bases(struct gicv5_irs_chip_data *irs_data,
> >  			FIELD_PREP(GICV5_IRS_CR1_IST_RA, GICV5_NO_READ_ALLOC)	|
> >  			FIELD_PREP(GICV5_IRS_CR1_IC, GICV5_NON_CACHE)		|
> >  			FIELD_PREP(GICV5_IRS_CR1_OC, GICV5_NON_CACHE);
> > -			irs_data->flags |= IRS_FLAGS_NON_COHERENT;
> > +		irs_data->flags |= IRS_FLAGS_NON_COHERENT;
> >  	} else {
> >  		cr1 = FIELD_PREP(GICV5_IRS_CR1_VPED_WA, GICV5_WRITE_ALLOC)	|
> >  			FIELD_PREP(GICV5_IRS_CR1_VPED_RA, GICV5_READ_ALLOC)	|
> > -- 
> > 2.47.2

