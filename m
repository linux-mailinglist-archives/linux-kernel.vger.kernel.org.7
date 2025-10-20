Return-Path: <linux-kernel+bounces-860691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71391BF0B54
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F8543AB1A1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5179D25D1F7;
	Mon, 20 Oct 2025 11:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="n1Frt8Wc"
Received: from smtp126.ord1d.emailsrvr.com (smtp126.ord1d.emailsrvr.com [184.106.54.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C80242910
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958091; cv=none; b=d2iedQwV6ZBYtPFQNLJnpx/Yn7G/Xpvys1cao+nhj4cRLosoN4AhEIAe6U7jCP8FVETyQVOLxlPbyaX/C4ODg0iyxoK/XRSb5uiGxCrirRo8jj6ie06HYlLO+GMDPJnC5eOQDaDarNj8yI0GjHoS3n36m3uPL3GymSsOch9rM8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958091; c=relaxed/simple;
	bh=61hQO/qXa8zqEODsmlr2yXW42ot+AcLXFjLWg7i0Q48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s7fArt2i6xEZ5DWEMMMOzQwH84thEwQuvzpZ1bzBZriZ5jAhjlNKaerqH3UILz80zLQMCoKd57e+vHK6UTByOlbN4XsDv0OYdEc9TNpH0TXp2FYvdyDXyX4vW41OBnd1+ZqXcPiVI+jH1TnYFNoIigEA0sbIU2IWCI97+b5FscA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=n1Frt8Wc; arc=none smtp.client-ip=184.106.54.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1760957140;
	bh=61hQO/qXa8zqEODsmlr2yXW42ot+AcLXFjLWg7i0Q48=;
	h=Date:Subject:To:From:From;
	b=n1Frt8WcHQz3sdQlVAS4CP1xEJWML6vD6ZVbxNUJt3pvflnwQ/1gOPAVpfhQaIExs
	 bwwOxoJrpbz7qfDpF917a2v4Uv8Wa5doPb4IQBF4sOgM/okGJ8z+6stoq0zFIN8yLM
	 7cJWAYeQbnqavZAl0b1uQYpLkhUKwC9B+eRRaKk8=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp24.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id E7647A0242;
	Mon, 20 Oct 2025 06:45:38 -0400 (EDT)
Message-ID: <9c92913c-c04b-4784-9cdc-5d75b10d2ed9@mev.co.uk>
Date: Mon, 20 Oct 2025 11:45:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] divide error in comedi_inc_scan_progress
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 syzbot+af53dea94b16396bc646@syzkaller.appspotmail.com,
 H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20251016110511.3460094-1-n.zhandarovich@fintech.ru>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20251016110511.3460094-1-n.zhandarovich@fintech.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 5a7940aa-556a-4104-880c-eac7900e27c9-1-1

On 16/10/2025 12:05, Nikita Zhandarovich wrote:
>> Oops: divide error: 0000 [#1] SMP KASAN PTI
>> CPU: 0 UID: 0 PID: 11660 Comm: irq/7-comedi_pa Not tainted syzkaller #0 PREEMPT_{RT,(full)}
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
>> RIP: 0010:comedi_inc_scan_progress+0x1a4/0x430 drivers/comedi/drivers.c:563
> 
> Hi,
> 
> I would like to solicit advice on how to properly address this
> issue [1], if no one minds.
> 
> First, I think both [1] and [2] problems are similar in the way
> they are triggered. While there are no syzkaller-side reproducers for
> either of them (even console logs do not have proper traces of what
> combinations of syscalls provoked wrong division), the blame clearly
> lies with comedi driver-specific interrupt handlers
> (parport_interrupt, das16m1_interrupt etc.).
> 
> Syzkaller at its current state manages to fuzz select comedi drivers
> by manually configuring them via COMEDI_DEVCONFIG ioctl. In the course
> of do_devconfig_ioctl() and, for instance, parport_attach() functions,
> specific irq handlers are enabled (parport_interrupt) and these
> handlers in turn interact with async->cmd->XXX values such as
> async->cmd->chanlist_len.
> 
> However, in the absence of ioctls related to cmd setup, simply
> after a single COMEDI_DEVCONFIG, async (and async->cmd) is
> initialized in __comedi_device_postconfig_async() with kzalloc.
> 
> Thus, when there is an irq is to be dealt with, these "empty"
> comedi_async objects and, specifically async->cmd->XXX, are
> processed leading to erroneous divisions like in [1] and [2].
> 
> The easiest solution, similar to one suggested in [2], is to check for
> divisor with zero values. In case of [1], comedi_inc_scan_progress
> would look something like this:
> 
>      ...
>      if (!(s->subdev_flags & SDF_PACKED) && (cmd->chanlist_len != 0)) {
> 	async->cur_chan += comedi_bytes_to_samples(s, num_bytes);
> 	async->cur_chan %= cmd->chanlist_len;
>      }
>      ...
> 
> Any suggestions are greatly appreciated!

I have a plan to deal with these unexpected interrupts, at least within 
the Comedi core functions.  The basic idea would be to for the Comedi 
core functions called by the ISRs to check that the subdevice is in the 
running state and increment a reference counter (either a refcount_t or 
a struct kref) if it is safe to proceed.  Then it will be allowed to 
assume that the struct comedi_async contents are reasonable until it 
decrements the reference counter.  Some other task may be calling 
do_become_nonbusy() in parallel with the above.  After 
do_become_nonbusy() clears the COMEDI_SRF_RUNNING flag to mark the 
subdevice as not being in the running state, it should wait until it is 
safe to continue before calling comedi_buf_reset().  This will make use 
of the reference counter and a struct completion.  The reference counter 
and struct completion can be stored as members of struct comedi_async.

There may be other parts of individual driver ISRs that use struct 
comedi_async directly and may need changing to do similar checks.  The 
checking and final decrement can done by a couple of new exported functions:

bool comedi_get_is_subdevice_running(struct comedi_subdevice *s);
void comedi_put_is_subdevice_running(struct comedi_subdevice *s);

If comedi_get_is_subdevice_running(s) returns true, the ISR can safely 
access s->async and then should call comedi_put_is_subdevice_running(s) 
when it has finished.


> P.S. To reiterate, I've failed to reproduce this error and this flawed
> analysis is theoretical only.
> 
> [1] https://syzkaller.appspot.com/bug?extid=af53dea94b16396bc646
> [2] https://syzkaller.appspot.com/bug?extid=f6c3c066162d2c43a66c
> 
> Regards,
> Nikita


-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

