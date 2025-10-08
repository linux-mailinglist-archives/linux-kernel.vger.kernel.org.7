Return-Path: <linux-kernel+bounces-845337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BC3BC481F
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 13:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 026AB4F0CBC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 11:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98CE2F618F;
	Wed,  8 Oct 2025 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IhDEvBk1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B472ECE9C;
	Wed,  8 Oct 2025 11:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759921714; cv=none; b=nes9LOssTDBwZHoSwdv846BD1PtBZjYtUJiaL4dk8v6WjI92RyNBdnVGRQKhsjEAGm0iR2p0P92CxyzGlRWvY1J4GgvcIc67x331gz1S8+m2cBWwJ03WJ+noOXWVglJU9tq9ySM1dqvf3pZtN9CBkPQtjzJYts9lWBDLFZT/6gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759921714; c=relaxed/simple;
	bh=skZYeuIwpcqOcK3DodmjQ8nM/TXM5C2KQs1Dnyo9exU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYBwQ0ZZTRdaTDu4ZE0TsMfMLkggLI/pgmIsW1NFA8sKUiyFc6O05MFfX/hB4jamhi4MY6sRkNl1oXHAh9TArIKVWvupeyvPM0Nr7+TQGc5qz7H1j7D9rucygQ++1hl0B7N2NUAx4GqcY5gmGXDXF13V8PfS9cshU19zVURYUJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IhDEvBk1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C05C4CEF4;
	Wed,  8 Oct 2025 11:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759921713;
	bh=skZYeuIwpcqOcK3DodmjQ8nM/TXM5C2KQs1Dnyo9exU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IhDEvBk1jLTtgERD/SCemibZCRCF1a96QcZh2uUyIZmSJumcHBvQFgfqGkbQZe0uF
	 xz7yGMpl+JWZmC9SymZVLD4M9qwawVsdTj8rzAXsXK8mO13XZ1SQ7YA0vzQpzjT66k
	 lbxw3nTazOAXbkP83JICJPFvbLC/8ueMyZ9YpoVg=
Date: Wed, 8 Oct 2025 13:08:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Akshay Gujar <Akshay.Gujar@harman.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	naveen.v@harman.com, sankarkumar.krishnasamy@harman.com,
	oneukum@suse.com
Subject: Re: [PATCH] usb: core: notify unrecognized usb device
Message-ID: <2025100805-resisting-target-419a@gregkh>
References: <2025090610-donation-sprawl-f6f7@gregkh>
 <20250918172355.5118-1-Akshay.Gujar@harman.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918172355.5118-1-Akshay.Gujar@harman.com>

On Thu, Sep 18, 2025 at 05:23:55PM +0000, Akshay Gujar wrote:
> >On Sat, Sep 6, 2025 14:28:37AM +0200, Greg KH wrote:
> 
> > >>> As per the usb compliance, USB-IF enforces a "no silent failure" rule.
> > >>> This means that an implementation of USB must not appear broken to the
> > >>> consumer. In configurations where the consumer's expectations are not
> > >>> met, either the peripheral or host must provide appropriate and useful
> > >>> feedback to the consumer regarding the problem.
> > >>> 
> > >>> Link: https://compliance.usb.org/index.asp?UpdateFile=Embedded%20Host&Format=Standard#10
> > >
> > >Odd, many Linux devices have passed usb-if testing since 2005 when this
> > >was made a "rule", how did that happen?  What recently changed to
> > >suddenly require this be a kernel issue?
> > > 
> > > Previously, OEMs handled this with private kernel patches or custom modifications. 
> > > However, with Android's Generic Kernel Image (GKI) initiative, vendors can no longer make arbitrary kernel modifications. 
> > > GKI requires using a common upstream kernel, so functionality like this needs to be up streamed rather than handled with vendor-specific patches.
> > > This patch provides a standard upstream solution for what was previously handled with custom kernel modifications.
> 
> > That's good, but that does not mean that what you are attempting to do
> > really is the correct thing to do.  Here you were trying to say that
> > this is a requirement of USB-IF, but it really is not.  This is just
> > wanting to add a new feature to the USB core that previously was only
> > out-of-tree for your devices.  Please be more specific in your
> > description of the problem and issues involved.
> 
> To clarify, this patch targets two needs: 
> it helps with USB-IF compliance testing (where enumeration failures must be visible to userspace), 

Why must it be visible to userspace?  How have we passed testing before
now?

> and it provides a generic mechanism for userspace to be notified of USB enumeration failures, 
> which is currently missing in the USB core. This solution standardizes the notification, 
> especially important for Android GKI and similar environments.

But there is no user for this new user/kernel api anywhere.  Android
does not do this today, what is the chance it really will use it?  Do
you have working patches somewhere that will land if this is added?

And where is any of this being documented? :)

> >> that is probably not true. For once you can try another cable in many cases.
> >> Currently we'd log this information. That is a worse way to handle this kind
> >> of failure.
> >> If there is an unrecoverable IO error, user space ought to be notified.
> >> Syslog is not the best way to do so. There ought to be a standardized way
> >> of doing this. However, this makes me say that this issue is not really
> >> confined to USB. Other hotpluggable busses have the same issue.
> 
> >Yes, all busses have this type of issue for when devices can not be
> >enumerated or fail.  We shouldn't make something that only works for
> >USB.  I think PCI reports this type of thing somehow, so maybe
> >generalize that api?
> 
> Agreed, this is a broader issue across hotpluggable busses. Generalizing the API to cover enumeration failures for USB, PCI, and others would be ideal. 
> For now, this patch addresses USB specifically due to immediate needs.

Great, but again, why not make it generic so that all can use it?

Otherwise we end up with a USB-specific solution that no one else can
ever use in the future.

thanks,

greg k-h

