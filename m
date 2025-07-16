Return-Path: <linux-kernel+bounces-733035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9DBB06F46
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B5A17A37F2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E9E28D8CE;
	Wed, 16 Jul 2025 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OgWH3va1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BC01CDFAC;
	Wed, 16 Jul 2025 07:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752651870; cv=none; b=czzufIC3wCWd5Z+Lw5ShhbGmymHJkcL9FFJfDKMsJ/FzATyymwzzroYmto3B7GhSzT4IXee9MmOhUwM3/wz19PXgoMsWCtLPE1JdFkmMrHZxC0uuB83FbuOWXXvHThNeX+LTtA/VLVRfj3iu1/2pyo12h9mKWqjfoa/qXE8ubEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752651870; c=relaxed/simple;
	bh=aBn4qU8do+E0RPlRk72c8oZo3d2eh2a97NPCmMOnGmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zd020wJh9ozdQI5Ad4qlByvx8asP3AZxToiVj6a9Blnre6W2uWHX4FGlQnNJcs7MShfMG6hZ0DzzTQXiNSzu4vfqtviUoJIWOLaPvjroF4PsyIIW/6MF6KLmFTXpRrPanG4l4yf/qS581O8u8bB+BQTn42+3aoMXFNLjytD4KXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OgWH3va1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9826DC4CEF0;
	Wed, 16 Jul 2025 07:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752651869;
	bh=aBn4qU8do+E0RPlRk72c8oZo3d2eh2a97NPCmMOnGmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OgWH3va15YUkyDrfDToLSwL5nhhWc0YXB8kfXMqaOZ7kXcI4CMGJ00brteyz1hifr
	 mkzHWet+7VHW+zCy46OioW7dcVk2SjIWsBmYC+Lm7be9KQHSKCXSaOQLItc79lr7PE
	 8EGebPS5nMwamAFLeZpgoJdxdPWUnnRR/zxyoFRY=
Date: Wed, 16 Jul 2025 09:44:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Johan Hovold <johan@kernel.org>, Corentin Labbe <clabbe@baylibre.com>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	david@ixit.cz
Subject: Re: [PATCH v8 1/2] usb: serial: add support for CH348
Message-ID: <2025071631-thesaurus-blissful-58f3@gregkh>
References: <20250204135842.3703751-1-clabbe@baylibre.com>
 <20250204135842.3703751-2-clabbe@baylibre.com>
 <aCHHfY2FkVW2j0ML@hovoldconsulting.com>
 <CAFBinCAUNNfOp4qvn2p8AETossePv2aL7jBkFxVZV_XzzULgVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCAUNNfOp4qvn2p8AETossePv2aL7jBkFxVZV_XzzULgVg@mail.gmail.com>

On Tue, Jul 15, 2025 at 11:20:33PM +0200, Martin Blumenstingl wrote:
> Hi Johan,
> 
> I'm excluding comments that are clear to me in this reply.
> 
> On Mon, May 12, 2025 at 12:03 PM Johan Hovold <johan@kernel.org> wrote:
> [...]
> > > +     if (ret) {
> > > +             dev_err(&port->serial->dev->dev,
> > > +                     "Failed to configure UART_MCR, err=%d\n", ret);
> > > +             return ret;
> > > +     }
> >
> > The read urbs should be submitted at first open and stopped at last
> > close to avoid wasting resources when no one is using the device.
> >
> > I know we have a few drivers that do not do this currently, but it
> > shouldn't be that hard to get this right from the start.
> If you're aware of an easy approach or you can recommend an existing
> driver that implements the desired behavior then please let me know.
> 
> The speciality about ch348 is that all ports share the RX/TX URBs.
> My current idea is to implement this using a ref count (for the number
> of open ports) and mutex for locking.

How do you know if a port is "open" or not and keep track of them all?
Trying to manage that is a pain and a refcount shouldn't need locking if
you use the proper refcount_t type in a sane way.

Try to keep it simple please.

> > With this implementation writing data continuously to one port will
> > starve the others.
> >
> > The vendor implementation appears to write to more than one port in
> > parallel and track THRE per port which would avoid the starvation issue
> > and should also be much more efficient.
> >
> > Just track THRE per port and only submit the write urb when it the
> > transmitter is empty or when it becomes empty.
> I'm trying as you suggest:
> - submit the URB synchronously for port N
> - submit the URB synchronously for port N + 1
> - ...
> 
> This seems to work (using usb_bulk_msg). What doesn't work is
> submitting URBs in parallel (this is what the vendor driver prevents
> as well).

Why would submitting urbs in parallel not work?  Is the device somehow
broken and can't accept multiple requests at the same time?

thanks,

greg k-h

