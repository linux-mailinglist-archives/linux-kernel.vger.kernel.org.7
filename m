Return-Path: <linux-kernel+bounces-844271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF50BC16DC
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 548691888FD0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4672E041A;
	Tue,  7 Oct 2025 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dccjintk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E44BEACD;
	Tue,  7 Oct 2025 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759842085; cv=none; b=Dm0qhJpz1ONY/PjF8QjfEL/h7+f6F/VeXbu8A1sDRHGsijifec2e+ue22lLtYoOI6BHmxj+GHRc3esgQlgJ1AuHDnaMKW0T+HeqJz9gDLjmoRbdl1J9H6zY50Xkh4LG5Sz83eHmTH6NsxhpWyNMYwKZM/dOvOsy2TX3RhrN3bUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759842085; c=relaxed/simple;
	bh=kVC1LNi5dxNRrs4jfmvsaMm9nf9S2AkQAnXbIrWipFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNw58eDhNmIX0KKFr21M+pkjXGhg1mW1uJeKddhxE6q4pFTvGX0P+Ru3/SvCqiEddzP2Ap4GygnVr2aC5A8zUkwMF6F1q4luqa/dHmLq5Quvjljp75TYBqx7Y4XrZ7ZOnKluAawDQbOS3Vly+UziFNpgpcpFEIV4T1oaghe0O7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dccjintk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91410C4CEF1;
	Tue,  7 Oct 2025 13:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759842084;
	bh=kVC1LNi5dxNRrs4jfmvsaMm9nf9S2AkQAnXbIrWipFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dccjintkuu+q8KmUuUo6m2K8crI+liPUdlxKl2ujrq3dZpny/rAMq9QIWtow73Sdl
	 AQiF+Nz8Qoldu5F9fW81khrMa5IwQhaP4voPDho6uCeFwYrRBZ1azZfrWdlSDmzDD9
	 Y0F2+1WNO5Z6izPpprbU+iKSlD20vFcXzYwTQHOQ=
Date: Tue, 7 Oct 2025 15:01:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Murad Sadigov <sdgvmrd@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: fix integer overflow in write()
Message-ID: <2025100729-voltage-boondocks-d8da@gregkh>
References: <CAEuvNs2b-_Q=dazKjhUwJoZ5XUpjRsf-FrCOTR_j24T+EG-f=g@mail.gmail.com>
 <2025100757-proximity-unlighted-6ad4@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025100757-proximity-unlighted-6ad4@gregkh>

On Tue, Oct 07, 2025 at 02:18:47PM +0200, Greg KH wrote:
> On Tue, Oct 07, 2025 at 03:58:13PM +0400, Murad Sadigov wrote:
> > Fix integer overflow in axis_fifo_write() that allows local users
> > to bypass buffer validation, potentially causing hardware FIFO
> > buffer overflow and system denial of service.
> > 
> > The axis_fifo_write() function converts user-controlled size_t 'len'
> > (64-bit) to unsigned int 'words_to_write' (32-bit) without overflow
> > checking at line 322:
> > 
> >     words_to_write = len / sizeof(u32);
> > 
> > On 64-bit systems, when len equals 0x400000000 (16 GiB):
> >   - Division: 0x400000000 / 4 = 0x100000000 (requires 33 bits)
> >   - Truncation: Result stored in 32-bit variable = 0 (overflow)
> >   - Validation bypass: if (0 > fifo_depth) evaluates to false
> >   - Impact: Hardware FIFO overflow, system crash
> > 
> > This allows unprivileged local users with access to /dev/axis_fifo*
> > to trigger denial of service.
> > 
> > The fix adds overflow check before type conversion to ensure len
> > does not exceed the maximum safe value (UINT_MAX * sizeof(u32)).
> > 
> > Affected systems include embedded devices using Xilinx FPGA with
> > AXI-Stream FIFO IP cores.
> > 
> > Signed-off-by: Murad Sadigov <sdgvmrd@gmail.com>
> > ---
> >  drivers/staging/axis-fifo/axis-fifo.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/staging/axis-fifo/axis-fifo.c
> > b/drivers/staging/axis-fifo/axis-fifo.c
> > index 1234567890ab..abcdef123456 100644
> > --- a/drivers/staging/axis-fifo/axis-fifo.c
> > +++ b/drivers/staging/axis-fifo/axis-fifo.c
> > @@ -319,6 +319,13 @@ static ssize_t axis_fifo_write(struct file *f,
> > const char __user *buf,
> >   return -EINVAL;
> >   }
> > 
> > + /* Prevent integer overflow in words calculation */
> > + if (len > (size_t)UINT_MAX * sizeof(u32)) {
> > + dev_err(fifo->dt_device,
> > + "write length %zu exceeds maximum %zu bytes\n",
> > + len, (size_t)UINT_MAX * sizeof(u32));
> > + return -EINVAL;
> > + }
> > +
> 
> Something went wrong here, your email client dropped all of the leading
> spaces :(
> 
> Also, you do not want to allow userspace to cause a DoS on the kernel
> log, so don't log this information, just return an error, no need to
> print anything.

Also, look at this function in the linux-next branch.  It has been
rewritten and I think will not fail in the same way you are thinking it
will fail here.  I'll get those changes to Linus by the end of this
week, sorry for not noticing they were not flushed out to his tree yet.

thanks,

greg k-h

