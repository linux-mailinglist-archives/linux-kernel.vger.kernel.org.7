Return-Path: <linux-kernel+bounces-851386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C96E6BD6541
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93CB24E04EE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1E3296BDE;
	Mon, 13 Oct 2025 21:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b="VNxXJi0O"
Received: from cse.ust.hk (cssvr7.cse.ust.hk [143.89.41.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72EF219E8
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=143.89.41.157
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760389840; cv=pass; b=gum2BnxmsXLt+IUVaxx8QnlEabrVcBR6Ru+fyak/7AOV6+hEUF4HOaOQGYAZ4AxboAgz9j9BLeiMb85ZrWL3hJm6UJBm963KqJgxg+jGKdV0OohoI3wvopkp7h5ctMuiMxbsC/JgJJ+fFn0Vwhqok9uERxcv33267byIwOK9uC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760389840; c=relaxed/simple;
	bh=daH9EcWjbyocgZoWqb9Sst8Rxa37ODWtQkb8BOpn0J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPWBFf4heyDo+Go7KqdfIxvu294WgYpDj4Zk3Aesr14rxxFnmiHCO66layeDR1QL9XQMTgTYZI62xzKlGAAXJtEr9zOD/yFKZRzP35dAUEBulZiJU3PuQBiZxh2vznXu5nAA641GBEPqXZHQPjDawwO+zioVVsFGG66vBKzfVlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk; spf=pass smtp.mailfrom=cse.ust.hk; dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b=VNxXJi0O; arc=pass smtp.client-ip=143.89.41.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.ust.hk
Received: from DESKTOP-2SPVBES.localdomain ([58.82.196.128])
	(authenticated bits=0)
	by cse.ust.hk (8.18.1/8.12.5) with ESMTPSA id 59DL9wVu3228979
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 05:10:04 +0800
ARC-Seal: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse; t=1760389806; cv=none;
	b=tiBsDJT3xpj7NWQcJ2Wx4aXDez0vw6zBerp1NqMjBPswZvy2hk+UAqo45nk/6Gu7e0mOpaobW5uF/38warrrMDrleB6YECaNVww7fRs4PZ2MUFCGxI2NFHEEUZSuDJhjeB7Lg9leOOZ8AWS+SQrLKqA4KbMm0RIoEhHdjuzN9cU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse;
	t=1760389806; c=relaxed/relaxed;
	bh=e/fVirX4xMT9IBEC+zKmVYCyiBDldGxqIaba+5fYEZo=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=DC68Dvyn325nDN+Fjeamkvvqytq3l4oj2hn4YrR/Wdk6RBxPVp34sGZgElFPKJpcDGwMZVvD41SD2gqsIoRR6uRwsJghrLpjCw8CgZtRAvCa7YJIr6AweQHs4R36tgfD2zZMotmzVwzzThls1lZRx095L/8iG3UfvbKqO9rE1mU=
ARC-Authentication-Results: i=1; cse.ust.hk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cse.ust.hk;
	s=cseusthk; t=1760389805;
	bh=e/fVirX4xMT9IBEC+zKmVYCyiBDldGxqIaba+5fYEZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VNxXJi0Omgl029cLUyH3h4I8MKEAn4U8lbj6yvZPfwLxFtdrlnCu9/ZR+7wWCyJZz
	 2YoZj71PhQiEiOXYnJCBUpnoF7dWFF0CSbqvxycAWrwuS4oQ8fu160vjrJo9Z8qksJ
	 0nkx7ZrZ/4zk6r78/rYoDJsExyVl1G7piNgnsGF4=
Date: Tue, 14 Oct 2025 05:09:53 +0800
From: Shuhao Fu <sfual@cse.ust.hk>
To: Frank Li <Frank.li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: fix refcount inconsistency in i3c_master_register
Message-ID: <20251013210953.GA2124@DESKTOP-2SPVBES.localdomain>
References: <aOYSTX5EA_nRoIY_@osx.local>
 <aOfgB6UpBha+pvqa@lizhi-Precision-Tower-5810>
 <aOio4HtjjfXclSW1@osx.local>
 <aO1etATnPSklqdua@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO1etATnPSklqdua@lizhi-Precision-Tower-5810>
X-Env-From: sfual

On Mon, Oct 13, 2025 at 04:19:00PM -0400, Frank Li wrote:
> On Fri, Oct 10, 2025 at 02:34:08PM +0800, Shuhao Fu wrote:
> > On Thu, Oct 09, 2025 at 12:17:11PM -0400, Frank Li wrote:
> > > On Wed, Oct 08, 2025 at 03:27:09PM +0800, Shuhao Fu wrote:
> > > > In `i3c_master_register`, a possible refcount inconsistency has been
> > > > identified, causing possible resource leak.
> > > >
> > > > Function `of_node_get` increases the refcount of `parent->of_node`. If
> > > > function `i3c_bus_init` fails, the function returns immediately without
> > > > a corresponding decrease, resulting in an inconsistent refcounter.
> > > >
> > > > In this patch, an extra goto label is added to ensure the balance of
> > > > refcount when `i3c_bus_init` fails.
> > > >
> > > > Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
> > > > Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
> > > > ---
> > > >  drivers/i3c/master.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> > > > index d946db75d..9f4fe98d2 100644
> > > > --- a/drivers/i3c/master.c
> > > > +++ b/drivers/i3c/master.c
> > > > @@ -2885,7 +2885,7 @@ int i3c_master_register(struct i3c_master_controller *master,
> > > >
> > > >  	ret = i3c_bus_init(i3cbus, master->dev.of_node);
> > > >  	if (ret)
> > > > -		return ret;
> > > > +		goto err_put_of_node;
> > >
> > > I think it'd better to set release function for master dev to release
> > > of_node because of_node_put() also missed at i3c_master_unregister()
> > >
> > > you can refer drivers/base/platform.c
> > >
> > > Frank
> >
> > Do you mean that we should do `of_node_release` in
> > `platform_device_release`, instead of respecting the refcounting via
> > `of_node_put`?
> 
> Sorry, I checked code again.
> 
> static void i3c_masterdev_release(struct device *dev)
> {
>         ...
>         of_node_put(dev->of_node);
> }
> 
> i3c_master_register()
> {
> 	...
> 	master->dev.release = i3c_masterdev_release;
> 	...
> };
> 
> Suppose of_node_put() will be auto called when put_device(&master->dev);
> 
> Do you really meet the problem or just static anaysis?
> 
> Frank

Honestly, it's from static analysis.

My apologies for overlooking the release handle. I checked the code once
again. It still looks suspicious as it would not call `put_device` if it
fails. I also checked call sites related to `i3c_master_register` and
they dont seem to do the clean-up if register fails.

Shuhao
> >
> > >
> > > >
> > > >  	device_initialize(&master->dev);
> > > >  	dev_set_name(&master->dev, "i3c-%d", i3cbus->id);
> > > > @@ -2973,6 +2973,9 @@ int i3c_master_register(struct i3c_master_controller *master,
> > > >  err_put_dev:
> > > >  	put_device(&master->dev);
> > > >
> > > > +err_put_of_node:
> > > > +	of_node_put(master->dev.of_node);
> > > > +
> > > >  	return ret;
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(i3c_master_register);
> > > > --
> > > > 2.39.5 (Apple Git-154)
> > > >
> > > >
> > > > --
> > > > linux-i3c mailing list
> > > > linux-i3c@lists.infradead.org
> > > > https://apc01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-i3c&data=05%7C02%7Csfual%40connect.ust.hk%7C837a825f1f3443950e6a08de0a95cb5f%7C6c1d415239d044ca88d9b8d6ddca0708%7C1%7C0%7C638959835659671475%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=B0ZvY%2FDKW3VdG%2FVamjGUUg%2BVr%2BZbtHIf4otgBKhje1s%3D&reserved=0
> >
> > --
> > linux-i3c mailing list
> > linux-i3c@lists.infradead.org
> > https://apc01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-i3c&data=05%7C02%7Csfual%40connect.ust.hk%7C837a825f1f3443950e6a08de0a95cb5f%7C6c1d415239d044ca88d9b8d6ddca0708%7C1%7C0%7C638959835659696068%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=KpMM%2FsTa6G1o3q%2Bcqx6iTb3VbCDq723lCXgcA9GGetI%3D&reserved=0

