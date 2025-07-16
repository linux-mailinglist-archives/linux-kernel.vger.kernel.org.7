Return-Path: <linux-kernel+bounces-733158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F8DB070FE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34321565246
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5E52EF9D1;
	Wed, 16 Jul 2025 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yut63M+R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C71B28DF1F;
	Wed, 16 Jul 2025 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656250; cv=none; b=WASSYUzUhCPo9PL5fBf68rVP/wcGzv9qJbE1Plk2U46SWnnLUHUelcz5H2CDDKk+dEP7zFdgPtA0QyjmvCG29Dh7309w/rI6elagDwSxWqPsIVij6ymPKwuTYfK8BD9aU/jWZj8E2XP+XJJlQTeLuZbIhpaI8qirE6lLCqi4tT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656250; c=relaxed/simple;
	bh=GoN2gw7W1TNKTu+4Ck0e2lWnwM+tJaBOtbfJRLPAHrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nB9Srp+d/GfBXWnFSP5aJ0JwzJdHmmI1Q7KUL/nXKhFeFbkH8p8rGztPRPZHt8bZO9BYo+57QzVKNKZ6ykEkw8/EWxT/PJBOGzN2FR9caeLvkZCBtvWdTxZh67doU0xOItOy1A58Cl7DyvopHbYpndcn77/7qSZT1WzLFsrdqBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yut63M+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65660C4CEF0;
	Wed, 16 Jul 2025 08:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752656249;
	bh=GoN2gw7W1TNKTu+4Ck0e2lWnwM+tJaBOtbfJRLPAHrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yut63M+RDRGY3d5iNocoIzHd5rhTNIBOvfOLXiC8Binl95HS0t+aLJZUlJz+C7a0P
	 9aIdPw7QcRAAvL0Uf6Kef+EzDBHyGOlhMGxiPrQdvY4pepCaXSgh+f9rxbMPnyXz+B
	 N7PB2VkN540xMEBHFJw0T9EFBiegW+SF9ffbBvgI=
Date: Wed, 16 Jul 2025 10:57:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Johan Hovold <johan@kernel.org>, Corentin Labbe <clabbe@baylibre.com>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	david@ixit.cz
Subject: Re: [PATCH v8 1/2] usb: serial: add support for CH348
Message-ID: <2025071613-ethics-component-e56d@gregkh>
References: <20250204135842.3703751-1-clabbe@baylibre.com>
 <20250204135842.3703751-2-clabbe@baylibre.com>
 <aCHHfY2FkVW2j0ML@hovoldconsulting.com>
 <CAFBinCAUNNfOp4qvn2p8AETossePv2aL7jBkFxVZV_XzzULgVg@mail.gmail.com>
 <2025071631-thesaurus-blissful-58f3@gregkh>
 <CAFBinCAMGR2f4M1ARKytOwG1z9ORcD-OMNLH2FqZHb+tOm0tEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCAMGR2f4M1ARKytOwG1z9ORcD-OMNLH2FqZHb+tOm0tEQ@mail.gmail.com>

On Wed, Jul 16, 2025 at 10:28:22AM +0200, Martin Blumenstingl wrote:
> On Wed, Jul 16, 2025 at 9:44 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Jul 15, 2025 at 11:20:33PM +0200, Martin Blumenstingl wrote:
> > > Hi Johan,
> > >
> > > I'm excluding comments that are clear to me in this reply.
> > >
> > > On Mon, May 12, 2025 at 12:03 PM Johan Hovold <johan@kernel.org> wrote:
> > > [...]
> > > > > +     if (ret) {
> > > > > +             dev_err(&port->serial->dev->dev,
> > > > > +                     "Failed to configure UART_MCR, err=%d\n", ret);
> > > > > +             return ret;
> > > > > +     }
> > > >
> > > > The read urbs should be submitted at first open and stopped at last
> > > > close to avoid wasting resources when no one is using the device.
> > > >
> > > > I know we have a few drivers that do not do this currently, but it
> > > > shouldn't be that hard to get this right from the start.
> > > If you're aware of an easy approach or you can recommend an existing
> > > driver that implements the desired behavior then please let me know.
> > >
> > > The speciality about ch348 is that all ports share the RX/TX URBs.
> > > My current idea is to implement this using a ref count (for the number
> > > of open ports) and mutex for locking.
> >
> > How do you know if a port is "open" or not and keep track of them all?
> > Trying to manage that is a pain and a refcount shouldn't need locking if
> > you use the proper refcount_t type in a sane way.
> >
> > Try to keep it simple please.
> I'm currently refcounting from usb_serial_driver.{open,close}
> The additional challenge is that I need to open two URBs at the right
> time to "avoid wasting resources". At least in my head I can't make it
> work without an additional lock.

Urbs really aren't all that large of a "resource", so don't worry about
that.  Get it working properly first before attempting to care about
small buffers like this :)

> The following is a simplified/pseudo-code version of what I have at
> the moment (which is called from my ch348_open):
> static int ch348_submit_urbs(struct usb_serial *serial)
> {
>   int ret = 0;
> 
>   mutex_lock(&ch348->manage_urbs_lock);
> 
>   if (refcount_read(&ch348->num_open_ports))
>     goto out_increment_refcount;
> 
>   ret = usb_serial_generic_open(NULL, serial_rx);
>   if (ret)
>     goto out_unlock;
> 
>   ret = usb_serial_generic_open(NULL, status);
>   if (ret) {
>     usb_serial_generic_close(serial_rx); /* undo the first
> usb_serial_generic_open */
>     goto out_unlock;
>   }

That's odd, why use NULL for a tty device?  Ah, we don't even use it for
anything anymore, maybe that should be fixed...

Anyway, just submit the urbs, why use usb_serial_generic_* at all for
the status urb?  That's not normal.

And are you trying to only have one set of urbs out for any port being
opened (i.e. you only have one control, one read, and one write urb for
the whole device, and the port info are multiplexed over these urbs?  Or
do you have one endpoint per port?)

If you are sharing endpoints, try looking at one of the other usb-serial
drivers that do this today, like io_edgeport.c, that has had shared
endpoints for 25 years, it's not a new thing :)

> out_increment_refcount:
>   refcount_inc(&ch348->num_open_ports);
> 
> out_unlock:
>   mutex_unlock(&ch348->manage_urbs_lock);
> 
>   return ret;
> }
> 
> My understanding is that usb-serial core does not provide any locking
> around .open/.close.

Nor should it, these are independent per-port.

> > > > With this implementation writing data continuously to one port will
> > > > starve the others.
> > > >
> > > > The vendor implementation appears to write to more than one port in
> > > > parallel and track THRE per port which would avoid the starvation issue
> > > > and should also be much more efficient.
> > > >
> > > > Just track THRE per port and only submit the write urb when it the
> > > > transmitter is empty or when it becomes empty.
> > > I'm trying as you suggest:
> > > - submit the URB synchronously for port N
> > > - submit the URB synchronously for port N + 1
> > > - ...
> > >
> > > This seems to work (using usb_bulk_msg). What doesn't work is
> > > submitting URBs in parallel (this is what the vendor driver prevents
> > > as well).
> >
> > Why would submitting urbs in parallel not work?  Is the device somehow
> > broken and can't accept multiple requests at the same time?
> I don't know the reason behind this.
> These are requests to the same bulk out endpoint. When submitting
> multiple serial TX requests at the same time then some of the data is
> lost / corrupted.
> 
> The vendor driver basically does this in their write function (very
> much simplified, see [0] for their original code):
>   spin_lock_irqsave(&ch9344->write_lock, flags);
>   usb_submit_urb(wb->urb, GFP_ATOMIC); /* part of ch9344_start_wb */
>   spin_unlock_irqrestore(&ch9344->write_lock, flags);

that's crazy, why the timeout logic in there?  This is a write function,
submit the data to the device and get out of the way, that's all that
should be needed here.

> If you have any suggestions: please tell me - I'm happy to try them out!

Try keeping it simple first, the vendor driver looks like it was written
by someone who was paid per line of code :)

good luck!

greg k-h

