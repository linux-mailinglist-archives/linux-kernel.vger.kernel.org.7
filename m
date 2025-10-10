Return-Path: <linux-kernel+bounces-847814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 341F0BCBCB2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56CC0189FC28
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 06:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF7B239E61;
	Fri, 10 Oct 2025 06:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b="tCruLc/4"
Received: from cse.ust.hk (cssvr7.cse.ust.hk [143.89.41.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8968F22579E
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 06:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=143.89.41.157
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760078107; cv=pass; b=T5jXukpehBxf8tG33iL8ei5KlMoyAVeb9nCJphuOE6fY7d8qaG6sROOY1nUF8JUUb3+DvSF95iCLVsGv5Vel6qha6rAAiY/yQVTEGRUXsI2sVzKcOTqh1Zl1lPnHBPq3BND3orcFVVX3IFkheeFoc+fP/JSip/hMaivdnGvw49o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760078107; c=relaxed/simple;
	bh=TfXKfGLIgdyqoC0vLmTK/YGBXyzqSeERAXzUxlk71To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CO5/474GoOcdZJcdK97dtt0X+Ddeg1rLQIVQ2gvr432KGvZIN2AufBCOvWh2l8/WARKEICA/tVWqmjSNhNUwiOZ4N/DCvkVvdohUDRWl6H0gf1aJsS/6AtRuW41TjBzadRvgJdEf1udtooim2xqXQi5+AG7HYY6dUk3u/2k7Gco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk; spf=pass smtp.mailfrom=cse.ust.hk; dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b=tCruLc/4; arc=pass smtp.client-ip=143.89.41.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.ust.hk
Received: from osx.local (ecs-119-8-240-33.compute.hwclouds-dns.com [119.8.240.33] (may be forged))
	(authenticated bits=0)
	by cse.ust.hk (8.18.1/8.12.5) with ESMTPSA id 59A6YDcH2442651
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 10 Oct 2025 14:34:19 +0800
ARC-Seal: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse; t=1760078061; cv=none;
	b=iyh4uTH33qzmNtoDxOsdakGME2842mUtVmLWN51a/yKyinCxDIxVJmEYQYyEvSGUfOpn4XMNrZqWl6GIEYq4scd9w1p12keduyncuGV3aFV9GKEt3SdbRELp8apI7y+Re53ObPm6xwXldEMQcHmohYLtAQtDqILChXNjP4Mt9JE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse;
	t=1760078061; c=relaxed/relaxed;
	bh=mlixuZgziH+wjVJSfwbssxjlyT8K5O91PRYV9CIA+nk=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=w7ZddfkYI4L+Q2EOFZPOE1oRWTDGc8ECcVRnBW7X9/NS/p/rbaTS3++y+x/A0F6Yiw8m0vp/Ce30znLiocO52lMmm4ieL56OSjzHBLQBTFgY6ATAAvJ7kvKPE8/xrcBiKzTjL6hWwUTptGk7GnyGibF+A/ZyqFzi3128WdHyvY8=
ARC-Authentication-Results: i=1; cse.ust.hk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cse.ust.hk;
	s=cseusthk; t=1760078061;
	bh=mlixuZgziH+wjVJSfwbssxjlyT8K5O91PRYV9CIA+nk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tCruLc/4VmyGm6a9MIIxurcOVxwTx/Iel0VnEiWBcsHRHBLAazx26FnqJo9z+w1xl
	 5qvgVTWRNwFrdeAjjjFL2vNQzoj2ci1LvpaxZ/3SWZ8vJHpUR58JpBYz6YCGFs1nWP
	 N8tTDQoClniJcd9twSb2tTt7cKNbKmV8UO23vjoM=
Date: Fri, 10 Oct 2025 14:34:08 +0800
From: Shuhao Fu <sfual@cse.ust.hk>
To: Frank Li <Frank.li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: fix refcount inconsistency in i3c_master_register
Message-ID: <aOio4HtjjfXclSW1@osx.local>
References: <aOYSTX5EA_nRoIY_@osx.local>
 <aOfgB6UpBha+pvqa@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOfgB6UpBha+pvqa@lizhi-Precision-Tower-5810>
X-Env-From: sfual

On Thu, Oct 09, 2025 at 12:17:11PM -0400, Frank Li wrote:
> On Wed, Oct 08, 2025 at 03:27:09PM +0800, Shuhao Fu wrote:
> > In `i3c_master_register`, a possible refcount inconsistency has been
> > identified, causing possible resource leak.
> >
> > Function `of_node_get` increases the refcount of `parent->of_node`. If
> > function `i3c_bus_init` fails, the function returns immediately without
> > a corresponding decrease, resulting in an inconsistent refcounter.
> >
> > In this patch, an extra goto label is added to ensure the balance of
> > refcount when `i3c_bus_init` fails.
> >
> > Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
> > Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
> > ---
> >  drivers/i3c/master.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> > index d946db75d..9f4fe98d2 100644
> > --- a/drivers/i3c/master.c
> > +++ b/drivers/i3c/master.c
> > @@ -2885,7 +2885,7 @@ int i3c_master_register(struct i3c_master_controller *master,
> >
> >  	ret = i3c_bus_init(i3cbus, master->dev.of_node);
> >  	if (ret)
> > -		return ret;
> > +		goto err_put_of_node;
> 
> I think it'd better to set release function for master dev to release
> of_node because of_node_put() also missed at i3c_master_unregister()
> 
> you can refer drivers/base/platform.c
> 
> Frank

Do you mean that we should do `of_node_release` in
`platform_device_release`, instead of respecting the refcounting via
`of_node_put`? 

> 
> >
> >  	device_initialize(&master->dev);
> >  	dev_set_name(&master->dev, "i3c-%d", i3cbus->id);
> > @@ -2973,6 +2973,9 @@ int i3c_master_register(struct i3c_master_controller *master,
> >  err_put_dev:
> >  	put_device(&master->dev);
> >
> > +err_put_of_node:
> > +	of_node_put(master->dev.of_node);
> > +
> >  	return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(i3c_master_register);
> > --
> > 2.39.5 (Apple Git-154)
> >
> >
> > --
> > linux-i3c mailing list
> > linux-i3c@lists.infradead.org
> > https://apc01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-i3c&data=05%7C02%7Csfual%40connect.ust.hk%7Cbfee3f910b654276330508de074f5750%7C6c1d415239d044ca88d9b8d6ddca0708%7C1%7C0%7C638956234525799989%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=aTeKcQJDC2Av%2FQ1MjtDuoOYrWJ6ZwhbjQbHs%2Fci90jw%3D&reserved=0

