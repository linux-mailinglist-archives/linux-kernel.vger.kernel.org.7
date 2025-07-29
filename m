Return-Path: <linux-kernel+bounces-749238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD441B14BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35A9A16C023
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90C5288C08;
	Tue, 29 Jul 2025 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZ+Z5Bdt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A61288514
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753783304; cv=none; b=giNuFg5v18Ran9Kik/6KUYCChPuR2PrAOyZDXUqsm6M5mvNd0B2R2nZ+ip0kW+a+EI+ZI1+fuHyAhfiuhyBWG5grWeU03Srx/50AT/0nSSC/m9mEzuuM7+pTWXa8EOdujBtfGDk3m/u6Vp5GxxpJ3VoQ0/GDqQ/jbJTWOi6RFNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753783304; c=relaxed/simple;
	bh=dnvGRz9Dc1xJ16lNNeR/pGM2X/eiEfvvJ5SW2f50Mos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OD5VBlj/4nIi7XqUpy9pdfUzkdi8o2wuZUIv0RRE3aDI0h/xmpjH00O6+BODGNN2rXtAnAuCV+RK9HEvEd1o1sDyGSwqhT4s7IDJrxImiCaWARiZm+Ebj4LM/ZlO/crRwMgSUtW0BiGpYnE2oz6SoCnQsCDUPJVwOLZrJMWigHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZ+Z5Bdt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7518C4CEF8;
	Tue, 29 Jul 2025 10:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753783302;
	bh=dnvGRz9Dc1xJ16lNNeR/pGM2X/eiEfvvJ5SW2f50Mos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KZ+Z5BdtnFKNOzAwBu/Im8pd5X6aNRpBLBgdqFJvge8W/Lk/2ClvQfTeSng1dw2td
	 4XxXZi76WQUPmm6xJ6mYccff/6HD5jXGZjLkAJhfAl8YSRNje6Hbmx6s9u8jbuhFuK
	 sJdkFvElQZiXblQpx2OTOKBnCB7vW5yOXVznsKyp/AiSL3OUYyCWPeVnjqICsVWJng
	 WSXNDd4S1BBvPdSybxWEk+1s8UsJTFbnA61d2p6RJXbfnzLnWV+nKah8KqNuQBE9I0
	 apAIk7KJZpSys/kaRAvsoMFKj/M91olIF/V1ymendhx1DqO4Z1PK6+ROP1UYyuNTzv
	 YhNNPAcPIkmcQ==
Date: Tue, 29 Jul 2025 13:01:32 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Dave Ertman <david.m.ertman@intel.com>
Subject: Re: [PATCH] auxiliary: Automatically generate id
Message-ID: <20250729100132.GH402218@unreal>
References: <20250728211022.9165-1-sean.anderson@linux.dev>
 <DBOFRAMQXK27.2EFPC1T807C2F@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBOFRAMQXK27.2EFPC1T807C2F@kernel.org>

On Tue, Jul 29, 2025 at 11:36:27AM +0200, Danilo Krummrich wrote:
> On Mon Jul 28, 2025 at 11:10 PM CEST, Sean Anderson wrote:
> > As it turns out, ids are not allowed to have semantic meaning. Their
> > only purpose is to prevent sysfs collisions. To simplify things, just
> > generate a unique id for each auxiliary device. Remove all references to
> > filling in the id member of the device.
> >
> > Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> > ---
> >
> >  drivers/base/auxiliary.c      | 32 +++++++++++++++++++++++---------
> >  include/linux/auxiliary_bus.h | 26 ++++++++------------------
> >  2 files changed, 31 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
> > index dba7c8e13a53..f66067df03ad 100644
> > --- a/drivers/base/auxiliary.c
> > +++ b/drivers/base/auxiliary.c
> > @@ -264,6 +264,8 @@ static const struct bus_type auxiliary_bus_type = {
> >  	.pm = &auxiliary_dev_pm_ops,
> >  };
> >  
> > +static DEFINE_IDA(auxiliary_id);
> 
> I think this is the correct thing to do, even though the per device IDA drivers
> typically went for so far produces IDs that are easier to handle when debugging
> things.
> 
> > +
> >  /**
> >   * auxiliary_device_init - check auxiliary_device and initialize
> >   * @auxdev: auxiliary device struct
> > @@ -331,20 +333,37 @@ int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname)
> >  		return -EINVAL;
> >  	}
> >  
> > +	ret = ida_alloc(&auxiliary_id, GFP_KERNEL);
> > +	if (ret < 0) {
> > +		dev_err(dev, "auxiliary device id_alloc fauiled: %d\n", ret);
> > +		return ret;
> > +	}
> > +	auxdev->id = ret;
> 
> This overwrites the ID number set by various drivers that (still) use the
> auxiliary_device_init() and auxiliary_device_add() pair.
> 
> While I agree with the general intent, I think it's a very bad idea to just
> perform this change silently leaving drivers with their IDA instances not
> knowing that the set ID numbers do not have an effect anymore.
> 
> I think this should be multiple steps:
> 
>   (1) Remove the id parameter and force an internal ID only for
>       auxiliary_device_create().
> 
>   (2) Convert applicable drivers (and the Rust abstraction) to use
>       auxiliary_device_create() rather than auxiliary_device_init() and
>       auxiliary_device_add().
> 
>   (3) Treewide change to force an internal ID for all auxiliary devices
>       considering this change in all affected drivers.

I would suggest easier approach.
1. Add to the proposal patch, the sed generated line which removes auxdev->id
assignment in the drivers.
Something like this from mlx5:
 - sf_dev->adev.id = id;

2. Add standalone patches to remove not used ida_alloc/ida_free calls
from the drivers.

> 
> > +
> >  	ret = dev_set_name(dev, "%s.%s.%d", modname, auxdev->name, auxdev->id);
> >  	if (ret) {
> >  		dev_err(dev, "auxiliary device dev_set_name failed: %d\n", ret);
> > +		ida_free(&auxiliary_id, auxdev->id);
> >  		return ret;
> >  	}
> >  
> >  	ret = device_add(dev);
> > -	if (ret)
> > +	if (ret) {
> >  		dev_err(dev, "adding auxiliary device failed!: %d\n", ret);
> > +		ida_free(&auxiliary_id, auxdev->id);
> > +	}
> >  
> >  	return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(__auxiliary_device_add);
> >  
> > +void auxiliary_device_delete(struct auxiliary_device *auxdev)
> > +{
> > +	ida_free(&auxiliary_id, auxdev->id);
> 
> Hm...I wonder if we should call this from the device's release callback instead.

Yes, you are right.

Thanks

