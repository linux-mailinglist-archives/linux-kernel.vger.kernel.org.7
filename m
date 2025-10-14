Return-Path: <linux-kernel+bounces-851665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 018ACBD7046
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB621880665
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 01:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FDB27056D;
	Tue, 14 Oct 2025 01:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b="lDaXZY7X"
Received: from cse.ust.hk (cssvr7.cse.ust.hk [143.89.41.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99793239E9A
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=143.89.41.157
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760406961; cv=pass; b=Z+hVzyWP7CT3RpMbqKyek5ZncitUNIybgr9v9FyydeYDhXDjoeZjW8l3xXDEDzetbUEqh+y6vBrC3TCAfrYQSuc9idDvw8jxwk9vmFSOTd/Hk4U8zs1sKxVHLewilfVed3FXDH45TNxaLSI4zMMYwcEMVXCYxDPBf9K/EFDbxqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760406961; c=relaxed/simple;
	bh=aY1wVyIBu+P/Agy6EzxeV0N9FDZmNyKBt3V+RY8feUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYO1WUGpN1bdLCvXI767v+aF6GACun12uag+dwaRFuIocdSOERN2k+ZENbib/8SVNT/+HNoeSK8si10rTHze1PcDVSEIOq/64cV27toRvqLIHMi/68GAV0FvDh9cnm7cG+qSI1U8TPC1RWKy6sD1neYT05zhw5HXGzfP1sPU7ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk; spf=pass smtp.mailfrom=cse.ust.hk; dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b=lDaXZY7X; arc=pass smtp.client-ip=143.89.41.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.ust.hk
Received: from osx.local (ecs-119-8-240-30.compute.hwclouds-dns.com [119.8.240.30])
	(authenticated bits=0)
	by cse.ust.hk (8.18.1/8.12.5) with ESMTPSA id 59E1tWbH3266543
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 09:55:39 +0800
ARC-Seal: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse; t=1760406940; cv=none;
	b=TG2eDPngy1F+FYyMTrlX6x9XY1uQqFwbkPSCOlvTF/Ifjud9UMkFGMME2umX0DLmHDYOT/pJlKrribTS8cuftD+BNHJyxtKdbRMolyE3Brer19UOlur91nn+IBmP9bQuAylgnsiHcJn61XN0E0EHXXffD8rlBrSFZTWm3I0PDPg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse;
	t=1760406940; c=relaxed/relaxed;
	bh=G++JBLc5OONg4P4tABuFONmwLMMGyA7zCS68NMAH4tE=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=xuDtpo1OE0ISqB+jWu8ylzK7bTAOXc+Rxp/6SiKCQ2aogR6L5Wh1ET4QZY56N6vHjiQj3jW88HfGulGLtvdw5hESfFugKEEmmS08BFVo8eSF/6+zxVBYIIsKgfB4I3+5LmnFTO/7AEtffJYH4J62BVDw9a0Sha2DkTj7wEHCy2I=
ARC-Authentication-Results: i=1; cse.ust.hk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cse.ust.hk;
	s=cseusthk; t=1760406940;
	bh=G++JBLc5OONg4P4tABuFONmwLMMGyA7zCS68NMAH4tE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lDaXZY7XrO+vLBk8Z77JHj8UzAyV9y4RKBSEJecsFCCaacVjyj6Zg6G1i8Mj6d2tt
	 zZKdkfrVWxXyWE7IAW5il+8AE8HqzDKdyRvvqAW0EAqapN1J1Td0vAyQ11tzBz9WlA
	 uVKCKR51ouC8TPV7jzC6W4IyoBUBnp+4hDENL7FI=
Date: Tue, 14 Oct 2025 09:55:26 +0800
From: Shuhao Fu <sfual@cse.ust.hk>
To: Frank Li <Frank.li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: fix refcount inconsistency in i3c_master_register
Message-ID: <aO2tjp_FsV_WohPG@osx.local>
References: <aOYSTX5EA_nRoIY_@osx.local>
 <aOfgB6UpBha+pvqa@lizhi-Precision-Tower-5810>
 <aOio4HtjjfXclSW1@osx.local>
 <aO1etATnPSklqdua@lizhi-Precision-Tower-5810>
 <20251013210953.GA2124@DESKTOP-2SPVBES.localdomain>
 <aO12r9v4xaJKHUQs@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO12r9v4xaJKHUQs@lizhi-Precision-Tower-5810>
X-Env-From: sfual

On Mon, Oct 13, 2025 at 06:01:19PM -0400, Frank Li wrote:
> On Tue, Oct 14, 2025 at 05:09:53AM +0800, Shuhao Fu wrote:
> > On Mon, Oct 13, 2025 at 04:19:00PM -0400, Frank Li wrote:
> > > On Fri, Oct 10, 2025 at 02:34:08PM +0800, Shuhao Fu wrote:
> > > > On Thu, Oct 09, 2025 at 12:17:11PM -0400, Frank Li wrote:
> > > > > On Wed, Oct 08, 2025 at 03:27:09PM +0800, Shuhao Fu wrote:
> > > > > > In `i3c_master_register`, a possible refcount inconsistency has been
> > > > > > identified, causing possible resource leak.
> > > > > >
> > > > > > Function `of_node_get` increases the refcount of `parent->of_node`. If
> > > > > > function `i3c_bus_init` fails, the function returns immediately without
> > > > > > a corresponding decrease, resulting in an inconsistent refcounter.
> > > > > >
> > > > > > In this patch, an extra goto label is added to ensure the balance of
> > > > > > refcount when `i3c_bus_init` fails.
> > > > > >
> > > > > > Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
> > > > > > Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
> > > > > > ---
> > > > > >  drivers/i3c/master.c | 5 ++++-
> > > > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> > > > > > index d946db75d..9f4fe98d2 100644
> > > > > > --- a/drivers/i3c/master.c
> > > > > > +++ b/drivers/i3c/master.c
> > > > > > @@ -2885,7 +2885,7 @@ int i3c_master_register(struct i3c_master_controller *master,
> > > > > >
> > > > > >  	ret = i3c_bus_init(i3cbus, master->dev.of_node);
> > > > > >  	if (ret)
> > > > > > -		return ret;
> > > > > > +		goto err_put_of_node;
> > > > >
> > > > > I think it'd better to set release function for master dev to release
> > > > > of_node because of_node_put() also missed at i3c_master_unregister()
> > > > >
> > > > > you can refer drivers/base/platform.c
> > > > >
> > > > > Frank
> > > >
> > > > Do you mean that we should do `of_node_release` in
> > > > `platform_device_release`, instead of respecting the refcounting via
> > > > `of_node_put`?
> > >
> > > Sorry, I checked code again.
> > >
> > > static void i3c_masterdev_release(struct device *dev)
> > > {
> > >         ...
> > >         of_node_put(dev->of_node);
> > > }
> > >
> > > i3c_master_register()
> > > {
> > > 	...
> > > 	master->dev.release = i3c_masterdev_release;
> > > 	...
> > > };
> > >
> > > Suppose of_node_put() will be auto called when put_device(&master->dev);
> > >
> > > Do you really meet the problem or just static anaysis?
> > >
> > > Frank
> >
> > Honestly, it's from static analysis.
> >
> > My apologies for overlooking the release handle. I checked the code once
> > again. It still looks suspicious as it would not call `put_device` if it
> > fails. I also checked call sites related to `i3c_master_register` and
> > they dont seem to do the clean-up if register fails.
> 
> 
> @@ -2814,10 +2816,6 @@ int i3c_master_register(struct i3c_master_controller *master,
>         INIT_LIST_HEAD(&master->boardinfo.i2c);
>         INIT_LIST_HEAD(&master->boardinfo.i3c);
> 
> -       ret = i3c_bus_init(i3cbus, master->dev.of_node);
> -       if (ret)
> -               return ret;
> -
>         device_initialize(&master->dev);
>         dev_set_name(&master->dev, "i3c-%d", i3cbus->id);
> 
> @@ -2825,6 +2823,10 @@ int i3c_master_register(struct i3c_master_controller *master,
>         master->dev.coherent_dma_mask = parent->coherent_dma_mask;
>         master->dev.dma_parms = parent->dma_parms;
> 
> +       ret = i3c_bus_init(i3cbus, master->dev.of_node);
> +        if (ret)
> +                goto err_put_dev;
> +
> 
> I inject at error at i3c_bus_init(), above code can trigger i3c_masterdev_release,
> which call of_node_put().
> 
> Frank
> 

Thank you for fixing the refcounting issue. May I kindly ask for a
reported-by tag for this fix "Reported-by: Shuhao Fu <sfual@cse.ust.hk>"?

Thanks,
Shuhao

> >
> > Shuhao
> > > >
> > > > >
> > > > > >
> > > > > >  	device_initialize(&master->dev);
> > > > > >  	dev_set_name(&master->dev, "i3c-%d", i3cbus->id);
> > > > > > @@ -2973,6 +2973,9 @@ int i3c_master_register(struct i3c_master_controller *master,
> > > > > >  err_put_dev:
> > > > > >  	put_device(&master->dev);
> > > > > >
> > > > > > +err_put_of_node:
> > > > > > +	of_node_put(master->dev.of_node);
> > > > > > +
> > > > > >  	return ret;
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_GPL(i3c_master_register);
> > > > > > --
> > > > > > 2.39.5 (Apple Git-154)
> > > > > >
> > > > > >
> > > > > > --
> > > > > > linux-i3c mailing list
> > > > > > linux-i3c@lists.infradead.org
> > > > > > https://apc01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-i3c&data=05%7C02%7Csfual%40connect.ust.hk%7Cdbe4f1ecc0c84f304fca08de0aa414ff%7C6c1d415239d044ca88d9b8d6ddca0708%7C1%7C0%7C638959897018898845%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=%2BmCDBh4d6Se%2BuO5xJgSDVupMRir7ZFH7f8RtzGUucoE%3D&reserved=0
> > > >
> > > > --
> > > > linux-i3c mailing list
> > > > linux-i3c@lists.infradead.org
> > > > https://apc01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-i3c&data=05%7C02%7Csfual%40connect.ust.hk%7Cdbe4f1ecc0c84f304fca08de0aa414ff%7C6c1d415239d044ca88d9b8d6ddca0708%7C1%7C0%7C638959897018922222%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=MdqJwKEKImd8UAQ0hyHjWyZx8vX1YSxU%2FqKDgpF0JPA%3D&reserved=0

