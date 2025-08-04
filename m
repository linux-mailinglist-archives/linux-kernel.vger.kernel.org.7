Return-Path: <linux-kernel+bounces-755113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E405AB1A16E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0783A9E91
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFED259CBA;
	Mon,  4 Aug 2025 12:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkTFbYuS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D4C24168D;
	Mon,  4 Aug 2025 12:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754310728; cv=none; b=VA1oDobtdA3/KrPxyBfxtALe5jkeAWZTA/x3DT+JyJDmiaAUNuEhJPJejigKQKJqTMFtrMG1T0cqLzQpIZ2bgB9pSupda/8ST113yqE6VV2hRG4bKD6mNHk43XEnD4/yM5unrnLQdrsmf8JIxE6Pkgl8RI5NpANV5lIjlQy9Ack=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754310728; c=relaxed/simple;
	bh=Nzjw1RKd3EkXnRls86iAscLx+zHGZqQzbkmk29ch5Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sr5N9HwZSI/LwMIteaHmsFhfdfRgigPbrDYxCOcOOLtUJ2Ar1pQ/EyBFxc2XNAHtWKJioi+Q9AJxh8nBmiDA/sqK8buFeFVO/6FkqRGQArDucAjCSeoRS8MyPpYaM5QMkXxYiXq2BLoFeJZE39e7ZZb5TNRFJwRTgoUCm09DMJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkTFbYuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BEFC4CEE7;
	Mon,  4 Aug 2025 12:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754310725;
	bh=Nzjw1RKd3EkXnRls86iAscLx+zHGZqQzbkmk29ch5Ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mkTFbYuSXOua//kivbaKlXhsP4mNSLoWMedtFc3GYa1z1JdrRecQaoRDojOwOAZ/F
	 S9Kv0kJq9iSDg5MJLEeRugdMRFK1bAWtskU9BpkWSFl0vpV0F93k0hjhzr7/LDGxAk
	 XEKJG3VBGv3lpvit0Mx0pQAUzJRTFAJNhGfiX/0PPZ8FwGD/rm3SA3M0xVUAQbwewF
	 pG1WgEVmZKjrJJsuzUfUGzhqBCsdOrk5uhNmXkCCseUqoDqDUa658F3yT6gYfZ3MYF
	 oVDBwCKEAsTU34/RfECVf/7cMfp9aYXZuAsU9ax1/OuXJwZ35QqKYV6/umb84636+l
	 y8uT6w6awngow==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1uiuMG-000000000ED-2Me8;
	Mon, 04 Aug 2025 14:32:05 +0200
Date: Mon, 4 Aug 2025 14:32:04 +0200
From: Johan Hovold <johan@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Corentin Labbe <clabbe@baylibre.com>, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	david@ixit.cz
Subject: Re: [PATCH v8 1/2] usb: serial: add support for CH348
Message-ID: <aJCoRFe-RFW1MuDk@hovoldconsulting.com>
References: <20250204135842.3703751-1-clabbe@baylibre.com>
 <20250204135842.3703751-2-clabbe@baylibre.com>
 <aCHHfY2FkVW2j0ML@hovoldconsulting.com>
 <CAFBinCAUNNfOp4qvn2p8AETossePv2aL7jBkFxVZV_XzzULgVg@mail.gmail.com>
 <aINXS813fmWNJh3A@hovoldconsulting.com>
 <CAFBinCBMTOM-FMgENS-mrnV17HbKzhtPUd44_dDiwnD=+HVMWQ@mail.gmail.com>
 <aIiXyEuPmWU00hFf@hovoldconsulting.com>
 <CAFBinCBZhjs7DGEgxhz54Dg8aW3NX9_LdnoZeUZpm5ohaT_-oQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCBZhjs7DGEgxhz54Dg8aW3NX9_LdnoZeUZpm5ohaT_-oQ@mail.gmail.com>

On Tue, Jul 29, 2025 at 10:45:20PM +0200, Martin Blumenstingl wrote:
> On Tue, Jul 29, 2025 at 11:43 AM Johan Hovold <johan@kernel.org> wrote:
> > On Sat, Jul 26, 2025 at 04:54:17PM +0200, Martin Blumenstingl wrote:

> > > I managed to get it to work now without any unnecessary waiting.
> > > When I switched to just waiting for per-port THRE I accidentally
> > > re-used the same URB (along with its buffer) for all ports. This of
> > > course "corrupts" data, but it's my fault instead of the chip/firmware
> > > causing it.
> > > That's why I was referring to data corruption earlier.
> > > Thanks for your persistence and for making me look at my code again
> > > with a fresh mind.
> >
> > Glad to hear you got it working. Did you confirm that you really need to
> > wait for THRE before submitting the next URB too? I don't see why the
> > vendor driver would be doing this otherwise, but perhaps it only affects
> > older, broken firmware, or something.

> I'm using Corentin's test script [0] for sending data and by
> connecting RX6 to TX7 and TX6 to RX7.

May be better to use a second different device (rather than loopback)
for testing so that you can separate any tx issues from rx issues.

> For a 1024 byte buffer:
> [ 3029.068311] ch348 ttyUSB6: submitted 509 bytes for urb 0
> [ 3029.068827] ch348 ttyUSB6: submitted 509 bytes for urb 1
> [ 3029.069363] ch348 ttyUSB7: submitted 5 bytes for urb 0
> [ 3029.069902] ch348 ttyUSB7: UART_IIR_THRI - unknown byte: 0x00
> [ 3029.215272] ch348 ttyUSB6: UART_IIR_THRI - unknown byte: 0x00
> [ 3029.215908] ch348 ttyUSB6: submitted 6 bytes for urb 0
> [ 3029.233628] ch348 ttyUSB6: UART_IIR_THRI - unknown byte: 0x00
> -> data is received without corruption
> 
> With a 2048 byte buffer the general flow seems fine:
> [ 3031.073101] ch348 ttyUSB6: submitted 509 bytes for urb 0
> [ 3031.073777] ch348 ttyUSB6: submitted 509 bytes for urb 1
> [ 3031.220068] ch348 ttyUSB6: UART_IIR_THRI - unknown byte: 0x00
> [ 3031.220697] ch348 ttyUSB6: submitted 509 bytes for urb 0
> [ 3031.221342] ch348 ttyUSB6: submitted 509 bytes for urb 1
> [ 3031.512113] ch348 ttyUSB6: UART_IIR_THRI - unknown byte: 0x00
> [ 3031.512795] ch348 ttyUSB6: submitted 12 bytes for urb 0
> [ 3031.513359] ch348 ttyUSB7: submitted 5 bytes for urb 0
> [ 3031.513859] ch348 ttyUSB7: UART_IIR_THRI - unknown byte: 0x00
> [ 3031.530476] ch348 ttyUSB6: UART_IIR_THRI - unknown byte: 0x00
> However, the receiving end sees different data (at around byte 513-518
> in my tests) than we wanted to send.
> 
> My general flow is:
> - check if we have received THRE - if not: don't transmit more data on this port
> - submit up to two URBs with up to 512 - 3 (CH348_TX_HDRSIZE) bytes to
> not exceed the HW TX FIFO size of 1024 bytes (page 1 in the datasheet)
> if the kfifo has enough data

If you're going to wait for the device fifo to clear completely you can
just use a single urb with larger (1k) buffer too.

> If you want me to test something else then please let me know and I'll try it.
> Otherwise I'll not dig much deeper, given the fact that I don't know
> how the firmware works (e.g. in which order they send the status to
> the host and what kind of state they hold internally) and we can still
> optimize this later.

Yeah, as long as you are certain that the generic implementation does
not work and that you indeed need to track THRE per port.

> [...]
> > > The datasheet has a special note about DTR/TNOW (on page 8 for the CFG pin):
> > > > Unified configuration: During power-on, if the CFG pin is
> > > > at a high level or not connected, all DTRx/ TNOWx pins
> > > > are configured to function as TNOW. CFG pin is low, all
> > > > DTRx/ TNOWx pins are configured for DTR function.
> >
> > Got a link to the datasheet? Not sure what they refer to as TNOW.

> Sure, try the direct link [1] - and if it doesn't work try [2].
> It doesn't document any registers, so it's a high-level datasheet -
> nor a programmers handbook.

Ok, so TNOW is used for RS485 to signal that the device is transmitting.
 
> > > On my test board the CFG pin is HIGH. From how I understand you, RTS
> > > should at least change (even if DTR is in TNOW mode).
> > > No matter what I do: both pins are always LOW (right after modprobe,
> > > after opening the console, closing the console again, ...).
> > > I even set up the vendor driver to test this: it's the same situation there.
> >
> > I don't think the console code will assert DTR/RTS, you need to open the
> > port as a regular tty.

Yes, even if the device is configured in hardware for TNOW mode (instead
of DTR function) you should still be able to control RTS (at least as
long as the device is not configured for automatic hardware flow control).

Johan

