Return-Path: <linux-kernel+bounces-745558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F69EB11BA5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1F41CE2ABB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACC22D8792;
	Fri, 25 Jul 2025 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Os4Euwvb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB742D4B5A;
	Fri, 25 Jul 2025 10:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438033; cv=none; b=fHpK0Q1ggt8F8crlQDSwZDgy3Smfj9SuVIBC20pBw5bjFw4hN2xvNOcR/30XV++1fAqq2g7P9KUr2EysKEuJRjp2jsJ8OcO7DUzoLLdVPVpXWpHar2XZVj3aNAjWWe0xZr7j677XjkDZyNxAMhFMIi9m584D6JcsOBtwwYYCmns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438033; c=relaxed/simple;
	bh=eP1gdbNAW+XbHhtXIpa0ko94YEcBTTUzvALs0ZuViDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buefVkrujid/2KfCp5Ybehfy1Ow2jZB/uXWDxynt75fmTU077V4d/ePl9UGkD6kozkxm3qiraczh/i4LmS9mU17OXxppLY6YJ5za44DFeshrxBM33d1IRE0XiNdRY6WrLAVG/jxcwTnDK6q4bblW1Voc7PBVGGXdgVmlCbtqjIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Os4Euwvb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B97BC4CEE7;
	Fri, 25 Jul 2025 10:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753438032;
	bh=eP1gdbNAW+XbHhtXIpa0ko94YEcBTTUzvALs0ZuViDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Os4EuwvbUJIIA23sseJtncmirId3c+0LoyNb+VuPTYDihCv7jVfOuWmQRYIun4qow
	 H5wqxYq7ztWwGol2hPHQbyeaFkrPmjuJqQ0FKkHd87914z6T9HxshcCdI9kk8NMnFK
	 lg67Ww62tMRFgPgZRagfobjJjRYA2AJzkF5XNK02jsD68FYrf1WOmFzoj2C12aJPW/
	 zwezz0q9QQAcEnirZhhMdC9ZMFUnDAO8Gtl1ML9i6qwukinWTUcsBQHGIcJFpW8ipT
	 93CmsN0zvCKqA38eB5rVxNV0i3ky/eTLRkR2+rIvstf8yjoNfPBWQPfnj1X24uahtS
	 qtX97z5zvfSwg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ufFKV-0000000057k-3rik;
	Fri, 25 Jul 2025 12:07:08 +0200
Date: Fri, 25 Jul 2025 12:07:07 +0200
From: Johan Hovold <johan@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Corentin Labbe <clabbe@baylibre.com>, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	david@ixit.cz
Subject: Re: [PATCH v8 1/2] usb: serial: add support for CH348
Message-ID: <aINXS813fmWNJh3A@hovoldconsulting.com>
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

> On Mon, May 12, 2025 at 12:03 PM Johan Hovold <johan@kernel.org> wrote:

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

Just use a mutex and integer (not refcount) to count the number of open
ports. Submit the urbs on first open and stop them on last close.

Not doing so, and instead submitting at attach(), means that the host
controller will be wasting power by polling the endpoints continuously
as long as the device is plugged in.

> [...]
> > > +                     /*
> > > +                      * Writing larger buffers can take longer than the
> > > +                      * hardware allows before discarding the write buffer.
> > > +                      * Limit the transfer size in such cases.
> > > +                      * These values have been found by empirical testing.
> > > +                      */
> > > +                     max_bytes = 128;
> >
> > This is a potential buffer overflow if a (malicious) device has
> > endpoints smaller than this (use min()).

> For endpoints smaller than CH348_TX_HDRSIZE we'll also be in trouble.
> Validating against CH348_TX_HDRSIZE size here doesn't make much sense
> to me (as we'd never be able to progress). I think I should validate
> it in ch348_attach() instead - what do you think?

Sure you can do that.

> > > +             else
> > > +                     /*
> > > +                      * Only ingest as many bytes as we can transfer with
> > > +                      * one URB at a time keeping the TX header in mind.
> > > +                      */
> > > +                     max_bytes = hw_tx_port->bulk_out_size - CH348_TX_HDRSIZE;
> > > +
> > > +             count = kfifo_out_locked(&port->write_fifo, rxt->data,
> > > +                                      max_bytes, &port->lock);
> > > +             if (count)
> > > +                     break;
> > > +     }
> >
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

No, the vendor driver tracks THRE per port
(ttyport[portnum].write_empty) and allows writing to more than one port
in parallel (e.g. releases the device write_lock while waiting for the
transfer to complete).

I thought the problem was that you could not submit another urb for the
*same* port until the device buffer for that port had been emptied?

This seems to be what the vendor driver is preventing.

> > You should implement dtr_rts() as well.

> This will be the first time we need the "package type" information as
> CH348Q only supports CTS/RTS on the first four ports, for the last
> four the signals aren't routed outside the package.
> I need to see if I have other hardware with CTS/RTS pins to test this.

Just connect a multimeter to the DTR and RTS pins and verify that they
are asserted on open and deasserted on close after issuing those control
requests (see ch9344_port_dtr_rts()).

I didn't mean that you need to support hw flow control (CRTSCTS).

Johan

