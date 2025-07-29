Return-Path: <linux-kernel+bounces-749313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2DAB14CC7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C43D7AECBE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018DD28C2C3;
	Tue, 29 Jul 2025 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ml0q76ZB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C1228C03C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753787496; cv=none; b=LzgKAszl/ykAilVtUG2Tj+B34RFkcMLuPu61GY2Vx6GfwppKdpw6Y/EiQPjUZFFvr8iVj9/yy1voILuFTcXUuK8xTq+GDnWNVes+3DQs6GCOSMDLelwE6Wrpf9VM8t8boqr7mfZrp0z1RGiF1VsDUlKT8qevUxXHjB+Z3ISQF6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753787496; c=relaxed/simple;
	bh=9GZ2Bqgl50vld93WsXGVkS36eSn4MgRHsUb561y72X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBXzhmoRnso1kPFSmK2joifNX45ESdfrtA8Jp6KI9Gq1R4MyXMP4yF4bMrlL7Gaa9GvX2eVpLZELFTalBxZMeEdYtOgHinFbwUkv2faUaFG6iIkkMTtXJHx6WkhZyYryawrxfwqu1hiHEmqP3TknEboDxxQzpXK/Han8U1AoWL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ml0q76ZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BD4C4CEEF;
	Tue, 29 Jul 2025 11:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753787495;
	bh=9GZ2Bqgl50vld93WsXGVkS36eSn4MgRHsUb561y72X8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ml0q76ZBoor6h2f9Wc1L9PMra1CWCypMeyY5wEyr9CcU3JqVstiMpqjV4L6ru3ERs
	 Nbm9Vsp3HRkNglHl8FFSsViQnrOCOG0skJw9PfIwAjO+tvcd28GU0oADvliQ/1b2h/
	 QTDKSSKVdUdb6NO5xzMloJaE2FRNs1hWzgrKzMXbdG6xjpySQt/qZpiIcByb6reUez
	 sA94TxOq6HEb8bA+tToghRwzBg1l4fO23AhQ36vZgVX+ei4u0PoeWg3kAcrGNi+2pb
	 PQQARpxSBC10Nj8v9CLHQeeEEwHhtfyPbQPaDHZoOMvXIdjn7RR5VAewmd/1JX48XZ
	 ewhOGH8rojkhA==
Date: Tue, 29 Jul 2025 14:11:30 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Dave Ertman <david.m.ertman@intel.com>
Subject: Re: [PATCH] auxiliary: Automatically generate id
Message-ID: <20250729111130.GI402218@unreal>
References: <20250728211022.9165-1-sean.anderson@linux.dev>
 <DBOFRAMQXK27.2EFPC1T807C2F@kernel.org>
 <20250729100132.GH402218@unreal>
 <DBOHCWV2QIAT.EEGEBRGQ60LX@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBOHCWV2QIAT.EEGEBRGQ60LX@kernel.org>

On Tue, Jul 29, 2025 at 12:51:42PM +0200, Danilo Krummrich wrote:
> On Tue Jul 29, 2025 at 12:01 PM CEST, Leon Romanovsky wrote:
> > On Tue, Jul 29, 2025 at 11:36:27AM +0200, Danilo Krummrich wrote:
> >> On Mon Jul 28, 2025 at 11:10 PM CEST, Sean Anderson wrote:
> >> > As it turns out, ids are not allowed to have semantic meaning. Their
> >> > only purpose is to prevent sysfs collisions. To simplify things, just
> >> > generate a unique id for each auxiliary device. Remove all references to
> >> > filling in the id member of the device.
> >> >
> >> > Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> >> > ---
> >> >
> >> >  drivers/base/auxiliary.c      | 32 +++++++++++++++++++++++---------
> >> >  include/linux/auxiliary_bus.h | 26 ++++++++------------------
> >> >  2 files changed, 31 insertions(+), 27 deletions(-)
> >> >
> >> > diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
> >> > index dba7c8e13a53..f66067df03ad 100644
> >> > --- a/drivers/base/auxiliary.c
> >> > +++ b/drivers/base/auxiliary.c
> >> > @@ -264,6 +264,8 @@ static const struct bus_type auxiliary_bus_type = {
> >> >  	.pm = &auxiliary_dev_pm_ops,
> >> >  };
> >> >  
> >> > +static DEFINE_IDA(auxiliary_id);
> >> 
> >> I think this is the correct thing to do, even though the per device IDA drivers
> >> typically went for so far produces IDs that are easier to handle when debugging
> >> things.
> >> 
> >> > +
> >> >  /**
> >> >   * auxiliary_device_init - check auxiliary_device and initialize
> >> >   * @auxdev: auxiliary device struct
> >> > @@ -331,20 +333,37 @@ int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname)
> >> >  		return -EINVAL;
> >> >  	}
> >> >  
> >> > +	ret = ida_alloc(&auxiliary_id, GFP_KERNEL);
> >> > +	if (ret < 0) {
> >> > +		dev_err(dev, "auxiliary device id_alloc fauiled: %d\n", ret);
> >> > +		return ret;
> >> > +	}
> >> > +	auxdev->id = ret;
> >> 
> >> This overwrites the ID number set by various drivers that (still) use the
> >> auxiliary_device_init() and auxiliary_device_add() pair.
> >> 
> >> While I agree with the general intent, I think it's a very bad idea to just
> >> perform this change silently leaving drivers with their IDA instances not
> >> knowing that the set ID numbers do not have an effect anymore.
> >> 
> >> I think this should be multiple steps:
> >> 
> >>   (1) Remove the id parameter and force an internal ID only for
> >>       auxiliary_device_create().
> >> 
> >>   (2) Convert applicable drivers (and the Rust abstraction) to use
> >>       auxiliary_device_create() rather than auxiliary_device_init() and
> >>       auxiliary_device_add().
> >> 
> >>   (3) Treewide change to force an internal ID for all auxiliary devices
> >>       considering this change in all affected drivers.
> >
> > I would suggest easier approach.
> > 1. Add to the proposal patch, the sed generated line which removes auxdev->id
> > assignment in the drivers.
> > Something like this from mlx5:
> >  - sf_dev->adev.id = id;
> >
> > 2. Add standalone patches to remove not used ida_alloc/ida_free calls
> > from the drivers.
> 
> I assume you suggest this as an alternative to (3) above? If so, that's what I
> meant in (3), I should have written "treewide series" instead of "treewide
> change".

I would say for all steps. Very important reason to use
auxiliary_device_init() and not auxiliary_device_create() is to bind
custom release callback, which is needed to release private data.

In addition, complex devices embed struct auxiliary_device in their
internal struct to rely on container_of to access the data.
See mlx5_sf_dev_add() in drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
as an example.

> 
> Technically (2) is orthogonal, yet I think it's a bit better to do the desired
> change right away. Otherwise we end up converting all applicable drivers to
> implement the auxiliary device release callback (which we need for a common
> ida_free()) first, just to remove it later on when we convert to
> auxiliary_device_create().

My expectation is to see extension of driver/base/core.c. Something like that:

diff --git a/drivers/base/core.c b/drivers/base/core.c
index cbc0099d8ef24..63847c84dbdc0 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2560,8 +2560,10 @@ static void device_release(struct kobject *kobj)

        kfree(dev->dma_range_map);

-       if (dev->release)
+       if (dev->release) {
+               dev->bus_specific_cleanup(dev);
                dev->release(dev);
+       }
        else if (dev->type && dev->type->release)
                dev->type->release(dev);
        else if (dev->class && dev->class->dev_release)
(END)



