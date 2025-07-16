Return-Path: <linux-kernel+bounces-733268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F98B07269
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E175B5039C7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B16E2F2708;
	Wed, 16 Jul 2025 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J+rSTzgs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E3C1E1A17;
	Wed, 16 Jul 2025 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660053; cv=none; b=n1sDab8EprFy6KUyLDtAhSqV5APivhZsWaVW4QHzs+B3cTLc0yKfrt2TPMV9d04ysNktsGv5+Mo0/IGALekRbXGwGPUMsOP6HQWua77NJ2tc3Mj6Vurg7BCA4Q+Ws3C+zW7VimuC+z8VCbb7Mek6XLH6JWjSk+WjpGow495v0Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660053; c=relaxed/simple;
	bh=G6lcWY0d1p8bWzM4tmGlqrNUUn72x9lcJMxsGMphNFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaBFQZZYCyY7ZcqUJYWmT4QtkX9qe+5dYsy61cQBuM7BKbbG4zb7AbsIXTyaGzSkv4ydm8CJcNTeOjsVMpjf2ZrZQiUEbq7V4bA7KzUcM8MaBkev4/jKpHV5adcVlWBZiEwfzZARiz9l2o5OMmLMHcs+6wHXas972kf4F0IhtNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J+rSTzgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E50DC4CEF0;
	Wed, 16 Jul 2025 10:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752660052;
	bh=G6lcWY0d1p8bWzM4tmGlqrNUUn72x9lcJMxsGMphNFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+rSTzgs+wfKgcT66JRwYRyRdfyybjnYbuQAo18wRb3Sp8o6yMPoDzZRzrOn0JBoH
	 SNExiblRDRK8U9bMhfqj4YWXVK/7GpxMbtA5C5hr4ijKxpS8Uha4mF/YhPq6r8C0bP
	 VRRCoRDMRyKeaHpsL2ydtTlFkxngdpFbA2FjAW3I=
Date: Wed, 16 Jul 2025 12:00:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Johan Hovold <johan@kernel.org>, Corentin Labbe <clabbe@baylibre.com>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	david@ixit.cz
Subject: Re: [PATCH v8 1/2] usb: serial: add support for CH348
Message-ID: <2025071639-annotate-huddle-0e11@gregkh>
References: <20250204135842.3703751-1-clabbe@baylibre.com>
 <20250204135842.3703751-2-clabbe@baylibre.com>
 <aCHHfY2FkVW2j0ML@hovoldconsulting.com>
 <CAFBinCAUNNfOp4qvn2p8AETossePv2aL7jBkFxVZV_XzzULgVg@mail.gmail.com>
 <2025071631-thesaurus-blissful-58f3@gregkh>
 <CAFBinCAMGR2f4M1ARKytOwG1z9ORcD-OMNLH2FqZHb+tOm0tEQ@mail.gmail.com>
 <2025071613-ethics-component-e56d@gregkh>
 <CAFBinCA8cMP3o483c40RjHkMAEt4RCmL6uCTTk5DPmrNVN6_NQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCA8cMP3o483c40RjHkMAEt4RCmL6uCTTk5DPmrNVN6_NQ@mail.gmail.com>

On Wed, Jul 16, 2025 at 11:31:49AM +0200, Martin Blumenstingl wrote:
> On Wed, Jul 16, 2025 at 10:57 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jul 16, 2025 at 10:28:22AM +0200, Martin Blumenstingl wrote:
> > > On Wed, Jul 16, 2025 at 9:44 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Jul 15, 2025 at 11:20:33PM +0200, Martin Blumenstingl wrote:
> > > > > Hi Johan,
> > > > >
> > > > > I'm excluding comments that are clear to me in this reply.
> > > > >
> > > > > On Mon, May 12, 2025 at 12:03 PM Johan Hovold <johan@kernel.org> wrote:
> > > > > [...]
> > > > > > > +     if (ret) {
> > > > > > > +             dev_err(&port->serial->dev->dev,
> > > > > > > +                     "Failed to configure UART_MCR, err=%d\n", ret);
> > > > > > > +             return ret;
> > > > > > > +     }
> > > > > >
> > > > > > The read urbs should be submitted at first open and stopped at last
> > > > > > close to avoid wasting resources when no one is using the device.
> > > > > >
> > > > > > I know we have a few drivers that do not do this currently, but it
> > > > > > shouldn't be that hard to get this right from the start.
> > > > > If you're aware of an easy approach or you can recommend an existing
> > > > > driver that implements the desired behavior then please let me know.
> > > > >
> > > > > The speciality about ch348 is that all ports share the RX/TX URBs.
> > > > > My current idea is to implement this using a ref count (for the number
> > > > > of open ports) and mutex for locking.
> > > >
> > > > How do you know if a port is "open" or not and keep track of them all?
> > > > Trying to manage that is a pain and a refcount shouldn't need locking if
> > > > you use the proper refcount_t type in a sane way.
> > > >
> > > > Try to keep it simple please.
> > > I'm currently refcounting from usb_serial_driver.{open,close}
> > > The additional challenge is that I need to open two URBs at the right
> > > time to "avoid wasting resources". At least in my head I can't make it
> > > work without an additional lock.
> >
> > Urbs really aren't all that large of a "resource", so don't worry about
> > that.  Get it working properly first before attempting to care about
> > small buffers like this :)
> I understood that this is a requirement from Johan, he wrote (on May
> 12th in this thread):
> > The read urbs should be submitted at first open and stopped at last
> > close to avoid wasting resources when no one is using the device.
> >
> > I know we have a few drivers that do not do this currently, but it
> > shouldn't be that hard to get this right from the start.
> 
> The original approach was to submit these URBs in .attach (e.g. during
> probe time) and kill them in .detach

Ok, that's fine, but as you are multiplexing stuff, so reference counts
are going to get complex.  I'll defer to Johan, but this seems messy.

> > If you are sharing endpoints, try looking at one of the other usb-serial
> > drivers that do this today, like io_edgeport.c, that has had shared
> > endpoints for 25 years, it's not a new thing :)
> My understanding is that io_edgeport is submits the URBs that are
> shared across ports outside of .open/.close.

Yes it does.

sorry about that, I misunderstood Johan's review comments here.  I'll
defer to him.


> So this will be a question for Johan: am I still good with the
> original approach - or can you convince Greg that a different approach
> is better?
> 
> [...]
> > > > > > With this implementation writing data continuously to one port will
> > > > > > starve the others.
> > > > > >
> > > > > > The vendor implementation appears to write to more than one port in
> > > > > > parallel and track THRE per port which would avoid the starvation issue
> > > > > > and should also be much more efficient.
> > > > > >
> > > > > > Just track THRE per port and only submit the write urb when it the
> > > > > > transmitter is empty or when it becomes empty.
> > > > > I'm trying as you suggest:
> > > > > - submit the URB synchronously for port N
> > > > > - submit the URB synchronously for port N + 1
> > > > > - ...
> > > > >
> > > > > This seems to work (using usb_bulk_msg). What doesn't work is
> > > > > submitting URBs in parallel (this is what the vendor driver prevents
> > > > > as well).
> > > >
> > > > Why would submitting urbs in parallel not work?  Is the device somehow
> > > > broken and can't accept multiple requests at the same time?
> > > I don't know the reason behind this.
> > > These are requests to the same bulk out endpoint. When submitting
> > > multiple serial TX requests at the same time then some of the data is
> > > lost / corrupted.
> > >
> > > The vendor driver basically does this in their write function (very
> > > much simplified, see [0] for their original code):
> > >   spin_lock_irqsave(&ch9344->write_lock, flags);
> > >   usb_submit_urb(wb->urb, GFP_ATOMIC); /* part of ch9344_start_wb */
> > >   spin_unlock_irqrestore(&ch9344->write_lock, flags);
> >
> > that's crazy, why the timeout logic in there?  This is a write function,
> > submit the data to the device and get out of the way, that's all that
> > should be needed here.
> >From what I've seen during my tests:
> - we fire the URB with TX data
> - the device receives it and puts the data into a per-port TX buffer
> - it indicates that it's done processing the URB
> - the TX buffer is then written out (the host can move on do something else)
> - the device signals to the host (via the STATUS endpoint) that it has
> written out all data from the TX buffer
> 
> With that timeout logic my understanding is that they're trying to
> catch cases where the last step (STATUS signal) did not work (for
> whatever reason) so that the host can continue sending more data.

Why can't the host just keep sending data?  Only "stall" if you don't
have an active urb to send?  Or just keep creating new urbs for every
send transaction and then destroying them when finished?  That way the
data gets queued up in the kernel (have a max able to be allocated so
you don't create a DoS accidentally), and you should be ok.  I think
some of the other drivers do this, or used to in the past.

> > > If you have any suggestions: please tell me - I'm happy to try them out!
> >
> > Try keeping it simple first, the vendor driver looks like it was written
> > by someone who was paid per line of code :)
> The original approach when upstreaming the ch348 driver was just to
> submit TX URBs (without any custom code, just letting usb-serial core
> handle it).

Ah, and what happened with that version?  Did it not work?

thanks,

greg k-h

