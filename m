Return-Path: <linux-kernel+bounces-788077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 714F2B37F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 926951896792
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3A1342CB4;
	Wed, 27 Aug 2025 10:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jV+SY8KV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223EF2AE90;
	Wed, 27 Aug 2025 10:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289284; cv=none; b=puIBbPL0tc5E9M54D39gFuBekvaPUFQVTWnVFjRYs9rTCGL6EObzGpE6fD6OT+kPuaftd1RzpStBzcthGBNFDLAoMTJWoNadGzd0uzsnPnoh89yqneeX8+a+v0Z9LlRCE5v30/JVXh2zaZ1auSfKJFC5fjMJYVyeOyT/U3ysMLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289284; c=relaxed/simple;
	bh=KiGizTKELKsAGoKxMS4KCkY7Hr/uMnzCC5mTyvqi0Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0RxPSVKdKsIgc5FFOZ4oKB/kO5yNdRXXDSDC87nyClhGI5RFiSlpgyM56W4NvOLsdi7nNhHjel807yg1KyHBvqf1NufkSJlo3rGRGRFKRWCiNR+DtDSPYTlN2gZFzeVDUF3RqHkf3VO0UkgSqKjmCu1hLRmYqRfKPS0wqIso+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jV+SY8KV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A057BC4CEEB;
	Wed, 27 Aug 2025 10:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756289282;
	bh=KiGizTKELKsAGoKxMS4KCkY7Hr/uMnzCC5mTyvqi0Oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jV+SY8KV71KFJEKgesNxp80Ah9zFR49xaSzd8tlZWma0vjBbVmuJqrw2OBE8KvP6V
	 rEkr0ieVkjw4D7+c5cSN86mnLzAeNdnOk9Xm24SRbIjVhg/D3okntMJ5ZVHAEUPSz8
	 CYGUiB9Uhdc9oXhh5v7rx/WvWQSop/2goIs+FHk5GEF68lPV896I6J7nPtTwDCOtze
	 QKMQ8p7f4/EkRVZJTQTAJL1lpjDeKihjsMjid5N2t7JbqUmmQYsFF0VPCoo5mjw63J
	 P2llqNumZxtupscpznfMIqrz10cA2QeUUgg/ZeM/+vv1UGDhV4I0rKTygte0raag3u
	 NjOjOB6mXXFuQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1urD4I-000000002dB-166y;
	Wed, 27 Aug 2025 12:07:50 +0200
Date: Wed, 27 Aug 2025 12:07:50 +0200
From: Johan Hovold <johan@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Corentin Labbe <clabbe@baylibre.com>, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	david@ixit.cz
Subject: Re: [PATCH v8 1/2] usb: serial: add support for CH348
Message-ID: <aK7Y9rRIsGBKRFAO@hovoldconsulting.com>
References: <20250204135842.3703751-1-clabbe@baylibre.com>
 <20250204135842.3703751-2-clabbe@baylibre.com>
 <aCHHfY2FkVW2j0ML@hovoldconsulting.com>
 <CAFBinCAUNNfOp4qvn2p8AETossePv2aL7jBkFxVZV_XzzULgVg@mail.gmail.com>
 <aINXS813fmWNJh3A@hovoldconsulting.com>
 <CAFBinCBMTOM-FMgENS-mrnV17HbKzhtPUd44_dDiwnD=+HVMWQ@mail.gmail.com>
 <aIiXyEuPmWU00hFf@hovoldconsulting.com>
 <CAFBinCBZhjs7DGEgxhz54Dg8aW3NX9_LdnoZeUZpm5ohaT_-oQ@mail.gmail.com>
 <aJCoRFe-RFW1MuDk@hovoldconsulting.com>
 <CAFBinCCYsWHsNwi99kFqvLv+xOYtp9u3omhrPdV-hdH+5Cfyew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCCYsWHsNwi99kFqvLv+xOYtp9u3omhrPdV-hdH+5Cfyew@mail.gmail.com>

On Mon, Aug 04, 2025 at 11:35:35PM +0200, Martin Blumenstingl wrote:
> On Mon, Aug 4, 2025 at 2:32 PM Johan Hovold <johan@kernel.org> wrote:
> > On Tue, Jul 29, 2025 at 10:45:20PM +0200, Martin Blumenstingl wrote:

> > > My general flow is:
> > > - check if we have received THRE - if not: don't transmit more data on this port
> > > - submit up to two URBs with up to 512 - 3 (CH348_TX_HDRSIZE) bytes to
> > > not exceed the HW TX FIFO size of 1024 bytes (page 1 in the datasheet)
> > > if the kfifo has enough data
> >
> > If you're going to wait for the device fifo to clear completely you can
> > just use a single urb with larger (1k) buffer too.

> I set .bulk_out_size = 1024 in struct usb_serial_driver. Writing a 1k
> buffer immediately results in:
>    ch348 1-1:1.0: device disconnected
> 
> I don't know if I need to set some kind of flag on the URB to have it
> split or whether the kernel / USB controller does that automatically
> (as you can tell: I'm not familiar with USB).
> If not: 512 byte transfers at a time it is.

The host controller should split the buffer, but apparently this crashes
the device firmware.

> > > > > On my test board the CFG pin is HIGH. From how I understand you, RTS
> > > > > should at least change (even if DTR is in TNOW mode).
> > > > > No matter what I do: both pins are always LOW (right after modprobe,
> > > > > after opening the console, closing the console again, ...).
> > > > > I even set up the vendor driver to test this: it's the same situation there.
> > > >
> > > > I don't think the console code will assert DTR/RTS, you need to open the
> > > > port as a regular tty.
> >
> > Yes, even if the device is configured in hardware for TNOW mode (instead
> > of DTR function) you should still be able to control RTS (at least as
> > long as the device is not configured for automatic hardware flow control).

> I think I made it work, sort of.
> It's a bit annoying because of code I don't understand. It seems that
> R_4 has the following settings:
> 0x00 DTR off
> 0x01 DTR on
> 0x10 RTS off
> 0x11 RTS on
> 0x08 activate (used during port initialization)
> 0x50 HW flow on
> 0x51 no RTS / HW flow off
> 
> That said, poking 0x00, 0x01, 0x10 and 0x11 by themselves didn't do much.
> One also has to write 0x06 to the per-port VEN_R register.
> The vendor driver only does that in .set_termios, which I call
> questionable until someone calls me out on this and is willing to
> share a good reason why that's a good idea ;-)
> 
> However, I'm unable to control the RTS line of port 1. It works for
> port 0, port 2 and 3 but not for port 1.
> Ports 4-7 don't have the TNOW/DTR and RTS lines routed outside the
> package, so I can't test these.

Sounds like good progress. Have you made sure HW flow isn't just enabled
by default on port 1 or similar?

Johan

