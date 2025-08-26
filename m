Return-Path: <linux-kernel+bounces-786098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC97B354FE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2A917A77F4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A232C2853F2;
	Tue, 26 Aug 2025 07:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1iWvyg9w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DF6202976
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756191941; cv=none; b=gEaf3L5jqDESBEzq24wo3jIbhy0HauPmjFAv4WSU3JlqVXNyVbBTqwWPMXWy1B5vQP8gb76pw+aoPDRcVSqMX2f9zq8rEhAx1zMe4QyPnREZ/UNDwGRSHff01c586mmrhP4bROtrbqXj2Ga7k8edIMlCVGnQKWsn8f5+0jHYYV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756191941; c=relaxed/simple;
	bh=7qCosOKQzPttR2ozoEnNoiQAcvIcUUwRHGQgkQxhf7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhgDpXRscAxykyeecvtNEJYRAV2fMz/b9nKVuOpc9kTMLEk05beXm2A7XqvMO1+57SAtPF6VS5CyR+Hn66E09//Q0HjYVWBPezW/nFIHtRiesaTyBQuMLZvgLRgAUtip/it1I974nzXEu1YIScXaqpKaNaLPaly5gVJDPsspPds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1iWvyg9w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06816C4CEF1;
	Tue, 26 Aug 2025 07:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756191941;
	bh=7qCosOKQzPttR2ozoEnNoiQAcvIcUUwRHGQgkQxhf7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1iWvyg9wPFRd8wynCUuVyy+JIseZ4oHLPeJd5WTr8fbENzC2dGhUaY3809sgpYkkN
	 X8WHpf7/uft4OQEZjpX7wu98Nc2gyIjOoplh1O63ha3OgNRk8zhtcLeT3cGnDPqwph
	 iHo+IxLl/cpGeyBoFTwa2nNpH/ZBR+w09Cm6/SK8=
Date: Tue, 26 Aug 2025 09:05:37 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Xion Wang =?utf-8?B?KOeOi+mRqyk=?= <Xion.Wang@mediatek.com>
Cc: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	wsd_upstream <wsd_upstream@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Huadian Liu =?utf-8?B?KOWImOWNjuWFuCk=?= <huadian.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/1] misc: Prevent double registration and deregistration
 of miscdevice
Message-ID: <2025082638-parlor-retreat-56ff@gregkh>
References: <20250825084556.10358-1-xion.wang@mediatek.com>
 <20250825084556.10358-2-xion.wang@mediatek.com>
 <2025082533-ranked-simply-4b63@gregkh>
 <d3d0fc0e19f939c093e6df1ff08ce23be71636a3.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3d0fc0e19f939c093e6df1ff08ce23be71636a3.camel@mediatek.com>

On Tue, Aug 26, 2025 at 02:55:59AM +0000, Xion Wang (王鑫) wrote:
> On Mon, 2025-08-25 at 22:28 +0200, Greg Kroah-Hartman wrote:
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> > 
> > 
> > On Mon, Aug 25, 2025 at 04:45:47PM +0800, xion.wang@mediatek.com
> > wrote:
> > > From: Xion Wang <xion.wang@mediatek.com>
> > > 
> > > When repeated calls to misc_register() or misc_deregister() on the
> > > same miscdevice could lead to kernel crashes or misc_list
> > > corruption due to
> > > multiple INIT_LIST_HEAD or list_del operations on the same list
> > > node.
> > > 
> > > This patch improves the robustness of the misc device driver by
> > > preventing
> > > both double registration and double deregistration of miscdevice
> > > instances.
> > > 
> > > Signed-off-by: Xion Wang <xion.wang@mediatek.com>
> > > ---
> > >  drivers/char/misc.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/char/misc.c b/drivers/char/misc.c
> > > index 558302a64dd9..2f8666312966 100644
> > > --- a/drivers/char/misc.c
> > > +++ b/drivers/char/misc.c
> > > @@ -210,6 +210,9 @@ int misc_register(struct miscdevice *misc)
> > >       int err = 0;
> > >       bool is_dynamic = (misc->minor == MISC_DYNAMIC_MINOR);
> > > 
> > > +     if (WARN_ON(misc->this_device))
> > > +             return -EEXIST;
> > 
> > You just crashed the kernel if this ever triggers (remember when
> > panic-on-warn is set)
> > 
> > So please, if this can happen, properly handle it.
> > 
> > > +
> > >       INIT_LIST_HEAD(&misc->list);
> > > 
> > >       mutex_lock(&misc_mtx);
> > > @@ -251,6 +254,7 @@ int misc_register(struct miscdevice *misc)
> > >                       misc->minor = MISC_DYNAMIC_MINOR;
> > >               }
> > >               err = PTR_ERR(misc->this_device);
> > > +             misc->this_device = NULL;
> > >               goto out;
> > >       }
> > > 
> > > @@ -275,12 +279,13 @@ EXPORT_SYMBOL(misc_register);
> > > 
> > >  void misc_deregister(struct miscdevice *misc)
> > >  {
> > > -     if (WARN_ON(list_empty(&misc->list)))
> > > +     if (WARN_ON(!misc->this_device))
> > >               return;
> > > 
> > >       mutex_lock(&misc_mtx);
> > >       list_del(&misc->list);
> > >       device_destroy(&misc_class, MKDEV(MISC_MAJOR, misc->minor));
> > > +     misc->this_device = NULL;
> > 
> > You are overloading the pointer here to mean something, please don't.
> > 
> > Again, why would this ever happen?  What in-tree driver does this?
> > 
> > thanks,
> > 
> > greg k-h
> 
> 
> This issue was encountered during MTK internal stress testing,
> specifically in the WiFi module on/off process. If the WiFi module
> fails during the "on" process, it triggers an "off" process. However,
> if the "off" process also fails, the module may not be properly
> deinitialized, and the misc device may not be correctly deregistered.
> On the next WiFi "on" attempt, repeated registration of the misc device
> leads to corruption of the misc_list. Subsequently, when a device calls
> misc_open, it may acquire the misc_lock and enter an infinite loop in
> list_for_each_entry due to the corrupted list, while other threads
> attempting to access their misc device nodes become blocked waiting for
> the misc_lock.

What driver is this?  And wifi devices should be using the rfkill api,
which only registers a misc device at module load time.  A wifi driver
should not be creating a miscdevice itself, that feels very very wrong.

> This scenario exposes two issues:
> 
> Incomplete failure handling in our internal WiFi module's on/off
> process (which we have already addressed internally).
> The lack of a mechanism in the miscdevice framework to prevent repeated
> registration or deregistration, which would improve its robustness.

Again, this shouldn't be something that any driver should hit as this
usage is not in the kernel tree that I can see.  Attempting to
re-register a device multiple times is normally never a good idea.

thanks,

greg k-h

