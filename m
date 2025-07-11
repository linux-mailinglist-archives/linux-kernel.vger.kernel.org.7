Return-Path: <linux-kernel+bounces-726943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE731B01317
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937B43A9606
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 05:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EF41D619F;
	Fri, 11 Jul 2025 05:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yWkWH/Mc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2373B1D432D;
	Fri, 11 Jul 2025 05:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752213394; cv=none; b=iG9lbOOmGJBAheTrLC+809cTqlf8gCCub5Iwqw3BjHl+5eyXZPUyQx4ghGOZ6DcY6dQH24s12CDHUMr5Ek0F64qTMMDCBsVT1nhFbpsfXPxzb+9ZlWigLfFoNUhQcCTeAn0fZnVcPlPgLvzIesTfO0XrfFhcxHBaXrRZDvKIaTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752213394; c=relaxed/simple;
	bh=RklvekZM8ya+o53KfTg7gBznMNjJWkT8FhgMwAcycfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDUnF9ripc/ALhC/91Q/P5+h/e9Ldz9lnXyUu2qWfawcaCca1h17YmIEJmH8iNJCWWuT6FleGS9clZDGhMRcLPjCoedRFBSPmw8cqVhc9dA+g5bndv2mBSsGrwUa7ZHuyxM/OambAstyGXcu14/r2ta9zLvXEUbllvi8C6W8J5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yWkWH/Mc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE10C4CEED;
	Fri, 11 Jul 2025 05:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752213393;
	bh=RklvekZM8ya+o53KfTg7gBznMNjJWkT8FhgMwAcycfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yWkWH/McTKYAXQtqUFU0BNRctKOq1AxK/xwimJQurSl1RMomm7vWlpIY2kM8RFP28
	 MEpgOcPUfO7uAv4uTgRdZW1oUgY2mnrrqncGpLAsEqfVQZdO8Uz56vhSfHlpSb5aRp
	 LBeCVXC0G7UEPDp2tUMF3ZNdW6tgQBRPYBzTrQlc=
Date: Fri, 11 Jul 2025 07:56:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Zongmin Zhou <min_halo@163.com>,
	shuah@kernel.org, valentina.manea.m@gmail.com, i@zenithal.me,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	zhouzongmin@kylinos.cn
Subject: Re: [PATCH v2] usbip: convert to use faux_device
Message-ID: <2025071125-islamic-retype-fadf@gregkh>
References: <1a13cf53-ffed-4521-917e-9c2856a5e348@linuxfoundation.org>
 <4fc877f0-b55b-4fa3-8df4-2de4ba1ac51b@163.com>
 <2a901b8a-9052-41d9-a70d-76508ebd819b@linuxfoundation.org>
 <4759911b-8c35-4ca9-bc34-09dd41b14582@163.com>
 <2025070949-activist-mammal-b806@gregkh>
 <dd3659dd-7e45-479d-ab65-9f5c1bab26a0@rowland.harvard.edu>
 <ce96291b-c0b2-41cf-a71c-c13bd8d0f139@linuxfoundation.org>
 <4478924b-fbd7-4a5a-ad0d-4fe0569b4971@linuxfoundation.org>
 <a735f877-e13b-498f-9eee-53ebefa8ebc9@rowland.harvard.edu>
 <9be8b1dc-9af2-4135-9a0f-db2eb7d10f06@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9be8b1dc-9af2-4135-9a0f-db2eb7d10f06@linuxfoundation.org>

On Thu, Jul 10, 2025 at 02:33:42PM -0600, Shuah Khan wrote:
> On 7/10/25 08:06, Alan Stern wrote:
> > On Wed, Jul 09, 2025 at 03:57:35PM -0600, Shuah Khan wrote:
> > > On 7/9/25 15:49, Shuah Khan wrote:
> > > > Right. We have a few too many moving pieces here:
> > > > 
> > > > usbipd (user-space)
> > > > vhci_hcd and the usb devices it creates
> > > > 
> > > > usbip_host, stub driver that proxies between the device
> > > > on the server and vhci_client.
> > > > 
> > > > PM can be complex and it has to do lot more than it currently
> > > > does on both server and client end to support seamlessly.
> > > > 
> > > > The current suspend took the approach of refusing suspend
> > > > which doesn't work since usb devices underneath hang in
> > > > usb_dev_resume(). Looks like this usb device is treated like
> > > > a real device bu usb core. Is there a way to have usb core
> > > > PM (suspend and resume) handle them as virtual? Would it
> > > > help to use "supports_autosuspend" to disable suspend and
> > > > resume?
> > > 
> > > Would it work if usb_disable_autosuspend() on the devices
> > > that hang off its vitual bus?
> > 
> > You have to consider PM on both the host and client.  And you have to
> > consider both runtime PM and system PM (that is, suspend to RAM,
> > hibernate, etc.).
> 
> This would be as a fix for the existing suspend hang issue.
> 
> > 
> > On the server, any sort of suspend will interrupt the connection.
> > usb_disable_autosuspend() will prevent runtime suspends, but you
> > shouldn't try to prevent system suspends.  Instead, the usbip driver on
> > the server should have its suspend routine close the connection to the
> > client (rather as if the server's user had unplugged the device).
> > 
> > On the client, you've got a choice for how to handle runtime PM.  You
> > can leave it enabled, and when the client decides to suspend the device,
> > tell the server's driver.  The server driver can then attempt to do a
> > runtime suspend on the physical device.  (You might need to add a new
> > type of message to the USBIP protocol to accomplish this; I don't know
> > the details.)  Alternatively, you can forbid runtime suspend on the
> > client entirely, although it would be nice if you could avoid this.
> > 
> > System PM on the client can be handled more less the same as runtime PM.
> 
> Correct. This has to be a complete solution that syncs up server and client
> side. I am going to look into implementing this - it might be possible to
> do this in user-space. Either way this will require changes to the protocol
> very likely.
> 
> Greg, Zongmin Zhou, let's hold off on this conversion yo faux bus for now.
> I will spend time looking at if we can find PM solution that works end to end
> for server and client.

Ok, thanks!

