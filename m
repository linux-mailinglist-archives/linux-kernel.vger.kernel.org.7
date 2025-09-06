Return-Path: <linux-kernel+bounces-804210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B39ECB46CDF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72168189438E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 12:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA14E298CA2;
	Sat,  6 Sep 2025 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e1Nnok++"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073BA266EF1;
	Sat,  6 Sep 2025 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757161721; cv=none; b=GvXMMGphDSCqMZqmiDELHEVEAOU9+vMhYpXyU9vfKVSQ6wgMg6G71ByPGuAsR/5P7cGWHykkc/AQOKvnzchLDK9tvnIzpS2xtWOI8sazP0b7RcfP5zkDoyVcART33ugCafrH0zQ8/j5ZQtPI3Ctn7d2PZQyU+b4MVWMlUwK9+Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757161721; c=relaxed/simple;
	bh=I4i+IgJmgw5WM8bIZquAFLkwMBcSojuAyx5U4cuiJxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1LJ4psN4ZNEyk2Cq610DYtfrh+9koaGJBjLuxLaM3cm3ZKRB687ByObnfvA4bJDTIXg0BiKy6JzB/JVAVip4ewDQyMMS+fpjVD261S9VYXLUnqPyZsSp8VfzqOu9szdhvZ3O3VtAHESulvYt+xvfBjCMWljvQ3Mfy59BTxvZ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e1Nnok++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33AA9C4CEE7;
	Sat,  6 Sep 2025 12:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757161720;
	bh=I4i+IgJmgw5WM8bIZquAFLkwMBcSojuAyx5U4cuiJxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e1Nnok++md1RI2K/nanVK36/O5Fze7xgAVc14dXXVDm8SF6b5lGnvSb4QdymqBqkr
	 /T2F63D2VJapngpnsEy+CTldYCah9o68Ue8M8a8rAgVIj6vvhlYiBb/hRfjb5jYt+A
	 /Uvr4Xykb4hTK0MYjfOow60EI8HX8NFDgeGBNkYA=
Date: Sat, 6 Sep 2025 14:28:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Akshay Gujar <Akshay.Gujar@harman.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	naveen.v@harman.com, sankarkumar.krishnasamy@harman.com
Subject: Re: [PATCH] usb: core: notify unrecognized usb device
Message-ID: <2025090610-donation-sprawl-f6f7@gregkh>
References: <2025022131-silo-impeach-3f24@gregkh>
 <20250826165244.22283-1-Akshay.Gujar@harman.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826165244.22283-1-Akshay.Gujar@harman.com>

On Tue, Aug 26, 2025 at 04:52:44PM +0000, Akshay Gujar wrote:
> Sorry for delayed response.
> 
> On Fri, Feb 21, 2025 11:53:01AM +0100, Greg KH wrote:

That was many months :)

> >> As per the usb compliance, USB-IF enforces a "no silent failure" rule.
> >> This means that an implementation of USB must not appear broken to the
> >> consumer. In configurations where the consumer's expectations are not
> >> met, either the peripheral or host must provide appropriate and useful
> >> feedback to the consumer regarding the problem.
> >> 
> >> Link: https://compliance.usb.org/index.asp?UpdateFile=Embedded%20Host&Format=Standard#10
> 
> >Odd, many Linux devices have passed usb-if testing since 2005 when this
> >was made a "rule", how did that happen?  What recently changed to
> >suddenly require this be a kernel issue?
> 
> Previously, OEMs handled this with private kernel patches or custom modifications. 
> However, with Android's Generic Kernel Image (GKI) initiative, vendors can no longer make arbitrary kernel modifications. 
> GKI requires using a common upstream kernel, so functionality like this needs to be up streamed rather than handled with vendor-specific patches.
> This patch provides a standard upstream solution for what was previously handled with custom kernel modifications.

That's good, but that does not mean that what you are attempting to do
really is the correct thing to do.  Here you were trying to say that
this is a requirement of USB-IF, but it really is not.  This is just
wanting to add a new feature to the USB core that previously was only
out-of-tree for your devices.  Please be more specific in your
description of the problem and issues involved.

> >And does usb-if even matter these days?  You do know what they think
> >about Linux overall, right (hint, they kicked us out from
> >participating...) so why should we follow their "requirements" when they
> >do not allow us to even participate or provide feedback when they create
> >them?
> 
> I understand your frustration with USB-IF's treatment of Linux.
> Rather than frame this as following USB-IF requirements, this patch addresses a practical Automotive ecosystem need: providing userspace notification of USB enumeration failures.
> However, this patch isn't really about following USB-IF requirements - it's about providing useful functionality.

Then don't say it has anything to do with USB-IF if it does not.

> >> ---
> >>  drivers/usb/core/hub.c | 24 +++++++++++++++++++++++-
> >>  1 file changed, 23 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> >> index c3f839637..d00129b59 100644
> >> --- a/drivers/usb/core/hub.c
> >> +++ b/drivers/usb/core/hub.c
> >> @@ -5343,6 +5343,26 @@ static int descriptors_changed(struct usb_device *udev,
> >>  	return changed;
> >>  }
> >>  
> >> +static void unrecognized_usb_device_notify(struct usb_port *port_dev)
> >> +{
> >> +	char *envp[2] = { NULL, NULL };
> >> +	struct device *hub_dev;
> >> +
> >> +	hub_dev = port_dev->dev.parent;
> >> +
> >> +	if (!hub_dev)
> >> +		return;
> 
> >How can this be true?
> 
> You're absolutely right. This check is unnecessary. I'll remove this in v2.
> 
> >> +
> >> +	envp[0] = kasprintf(GFP_KERNEL, "UNRECOGNIZED_USB_DEVICE_ON_PORT=%s",
> >> +				kobject_name(&port_dev->dev.kobj));
> 
> >Hint, if a driver ever starts calling into kobject or sysfs functions,
> >usually something is wrong.  This should just use dev_name(), right?
> 
> Correct! I'll change this to use dev_name(&port_dev->dev) in v2.
> 
> >> +	if (!envp[0])
> >> +		return;
> >> +
> >> +	kobject_uevent_env(&hub_dev->kobj, KOBJ_CHANGE, envp);
> 
> >Where is this new uevent documented?  What userspace tool will see this
> >and do something about it?  How was this tested?
> 
> I'll add documentation to Documentation/ABI/testing/ describing 
> the uevent format and intended consumers.
> 
> For testing: I used "udevadm monitor --property" to verify uevent 
> generation during enumeration failures.
> 
> For Android usage: Our USB HAL service uses a NetlinkListener to 
> capture these events and provide user feedback for connection issues.
> 
> >> +
> >> +	kfree(envp[0]);
> >> +}
> >> +
> >>  static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
> >>  		u16 portchange)
> >>  {
> >> @@ -5569,9 +5589,11 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
> >>  	if (hub->hdev->parent ||
> >>  			!hcd->driver->port_handed_over ||
> >>  			!(hcd->driver->port_handed_over)(hcd, port1)) {
> >> -		if (status != -ENOTCONN && status != -ENODEV)
> >> +		if (status != -ENOTCONN && status != -ENODEV) {
> >>  			dev_err(&port_dev->dev,
> >>  					"unable to enumerate USB device\n");
> >> +			unrecognized_usb_device_notify(port_dev);
> 
> >This is only if a hub acts up with talking to a device, it does not mean
> >the device was not supported at all.  So this isn't going to meet the
> >standard that you describe above.  Userspace is really the only thing
> >that can know if a device is "supported" or not, not the kernel.
> 
> I mischaracterized this. This detects enumeration failures, not unsupported devices. 

That's a very big difference.  Enumeration failures happen all the time
due to horrible cables and other hardware issues.  If you are now going
to flood userspace with this information, it better be ready to handle
it and do something with it.

But, for an enumeration failure, you can't do anything with it, so why
report it at all?

> Userspace determines device support. I'll rename the function to "usb_enumeration_failure_notify" and update.
> The use case is for USB-IF compliance testing (DevNoResponse tests) where test equipment needs to verify enumeration failure detection. 

There is no such requirement for the kernel to provide this information,
why can't you just do this all in userspace with the information that
you have?  You know if a device is active or bound to a driver properly,
why not just rely on that instead of making the kernel do something
different here?

thanks,

greg k-h

