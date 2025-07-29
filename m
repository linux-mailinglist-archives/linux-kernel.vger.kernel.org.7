Return-Path: <linux-kernel+bounces-749216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5753DB14B8A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C8416E7A5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4CA2882D3;
	Tue, 29 Jul 2025 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jj0eAbY2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CA41B0413;
	Tue, 29 Jul 2025 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753782219; cv=none; b=ds9UcKba19Ss2r7SkQG4yFGijHqHIsB0IdcpQswY6/kxkpQj/6NNnqu9epMXNGxwOu+EHEcK5CDi+7jMpbZDmVO76M9QWiosOn274rw8vCMxk9ckq8YRzEwe/hGZN99OzucvG+cO+Gkxy0IDnTpsiV/bu4JWhpqal2D7r3UC0jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753782219; c=relaxed/simple;
	bh=O2QizMi4IT96Tg0rnQsooP1SY7Nrm6qwGNuOhl1eOB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSI9iaWH+hyxqeHl2+f3IDU2LAA7EyUoxR53j05pPJbgfUJ/O4VpO+V4BPAd/6qIqB/n9hfu8DGnLFH3p2wk/nsGt+rHM+N5fldtuxLya3AzkRsrLw9SeJkV9HTukY6gZ/G7sqAO27QCXDIhFXOBKTDYf5u/sz84lS/xmXq7Aqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jj0eAbY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B41C4CEEF;
	Tue, 29 Jul 2025 09:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753782216;
	bh=O2QizMi4IT96Tg0rnQsooP1SY7Nrm6qwGNuOhl1eOB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jj0eAbY2UR7k6rKdvojX+jcKAtQ6eU7cTN/Pwn2XZ1TYJ2k5Pifv/nvpNXhCL8Wkq
	 o6KAwfX6/t5Ks1GbQSGD5ShXyNaWUMS/nzO2BBGNK4k4E1le2Mkz4um+yvv1+PcWWj
	 aZtF5Oe5RxV5vHnyIkR54gLovPsJShiNRZ1hOe2JzErmFHD+yMXwRS4yZXYxpx5ltf
	 OmQyXDp4Ixh26FWKPB3Snyd8Ybt/c4FsWzNZX++Zo/7l2YGQZ9hDSOrtGO1j4dGgmK
	 3lFjZyev8CpyRSQ8lXSEPf3YtB/yfp5c7NpiIuLADIfWK+lTlKLm4kdYxEYwDIZsBn
	 0XYIq0SIGnrOA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1uggrw-000000002yZ-1HyL;
	Tue, 29 Jul 2025 11:43:37 +0200
Date: Tue, 29 Jul 2025 11:43:36 +0200
From: Johan Hovold <johan@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Corentin Labbe <clabbe@baylibre.com>, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	david@ixit.cz
Subject: Re: [PATCH v8 1/2] usb: serial: add support for CH348
Message-ID: <aIiXyEuPmWU00hFf@hovoldconsulting.com>
References: <20250204135842.3703751-1-clabbe@baylibre.com>
 <20250204135842.3703751-2-clabbe@baylibre.com>
 <aCHHfY2FkVW2j0ML@hovoldconsulting.com>
 <CAFBinCAUNNfOp4qvn2p8AETossePv2aL7jBkFxVZV_XzzULgVg@mail.gmail.com>
 <aINXS813fmWNJh3A@hovoldconsulting.com>
 <CAFBinCBMTOM-FMgENS-mrnV17HbKzhtPUd44_dDiwnD=+HVMWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCBMTOM-FMgENS-mrnV17HbKzhtPUd44_dDiwnD=+HVMWQ@mail.gmail.com>

On Sat, Jul 26, 2025 at 04:54:17PM +0200, Martin Blumenstingl wrote:
> On Fri, Jul 25, 2025 at 12:07 PM Johan Hovold <johan@kernel.org> wrote:

> > No, the vendor driver tracks THRE per port
> > (ttyport[portnum].write_empty) and allows writing to more than one port
> > in parallel (e.g. releases the device write_lock while waiting for the
> > transfer to complete).
> >
> > I thought the problem was that you could not submit another urb for the
> > *same* port until the device buffer for that port had been emptied?
> >
> > This seems to be what the vendor driver is preventing.

> I managed to get it to work now without any unnecessary waiting.
> When I switched to just waiting for per-port THRE I accidentally
> re-used the same URB (along with its buffer) for all ports. This of
> course "corrupts" data, but it's my fault instead of the chip/firmware
> causing it.
> That's why I was referring to data corruption earlier.
> Thanks for your persistence and for making me look at my code again
> with a fresh mind.

Glad to hear you got it working. Did you confirm that you really need to
wait for THRE before submitting the next URB too? I don't see why the
vendor driver would be doing this otherwise, but perhaps it only affects
older, broken firmware, or something.

> > > > You should implement dtr_rts() as well.
> >
> > > This will be the first time we need the "package type" information as
> > > CH348Q only supports CTS/RTS on the first four ports, for the last
> > > four the signals aren't routed outside the package.
> > > I need to see if I have other hardware with CTS/RTS pins to test this.
> >
> > Just connect a multimeter to the DTR and RTS pins and verify that they
> > are asserted on open and deasserted on close after issuing those control
> > requests (see ch9344_port_dtr_rts()).

> Do I need to set anything special in termios for this to work?

The TTY layer will assert DTR/RTS on open() and deassert on close() as
long as HUPCL is set. If you implement tiocmset() you can use that to
toggle the lines as well.

> The datasheet has a special note about DTR/TNOW (on page 8 for the CFG pin):
> > Unified configuration: During power-on, if the CFG pin is
> > at a high level or not connected, all DTRx/ TNOWx pins
> > are configured to function as TNOW. CFG pin is low, all
> > DTRx/ TNOWx pins are configured for DTR function.

Got a link to the datasheet? Not sure what they refer to as TNOW.

> On my test board the CFG pin is HIGH. From how I understand you, RTS
> should at least change (even if DTR is in TNOW mode).
> No matter what I do: both pins are always LOW (right after modprobe,
> after opening the console, closing the console again, ...).
> I even set up the vendor driver to test this: it's the same situation there.

I don't think the console code will assert DTR/RTS, you need to open the
port as a regular tty.

> If we need to make the DTR and RTS output something then the only way
> I know of right now is to switch them to GPIO mode (I have code for
> this but it's another ~300 lines patch on top of this).

That should not be needed. It looked like the vendor driver had some
variant of the usual request to control the modem lines. That should be
all that is needed.

Look at the vendor driver implementation of ch9344_tty_tiocmset() and
ch9344_port_dtr_rts().

Johan

