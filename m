Return-Path: <linux-kernel+bounces-726939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DA5B0130F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73A61CA0AAE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 05:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200B61CF5C0;
	Fri, 11 Jul 2025 05:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1gU7VAiH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E7A1A072C;
	Fri, 11 Jul 2025 05:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752213281; cv=none; b=cXERONs9GmTZprxVNDnyy68PuHtGSotatTRP3c9870B0PgLFrjtLYbArBLJM2d/f5ax6qmALvj9rAh8ZkL56Wd6JbHTwkwS8QzvG6X5pzOj8OmarVXSH8elMKMZTKrTE+kikNHjDRwe50LEFCS5l+NMwuhwluHb1tMIIx48cr44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752213281; c=relaxed/simple;
	bh=eqWnKG3MF5KX7NMIW+VON6kbeFOWkXB3/t3CEyagZQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKUqn3mNLhVc+6excpSu/Rdv4ZZoWlacS2t8Tk5i7W5/NURAKrsC1csdjcV5K5ght1l88WCLUMB2fITbY7G+6DlEo3xCQBW2fIkZx3QxoNQIw0uhXv27VLcPp3aHhGzNvS+/Fwqd58j+h/Xo4KPz3w/YQW3avM+65jdUYqDVlkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1gU7VAiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6514CC4CEED;
	Fri, 11 Jul 2025 05:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752213280;
	bh=eqWnKG3MF5KX7NMIW+VON6kbeFOWkXB3/t3CEyagZQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1gU7VAiHmEqHbbe0EAdPpiNprw1hh8vpeP6VlYSUy30kO5eAUaU3lG0F6GM3h6/Ci
	 c94rveK5obAolJAvutAkfl+3SpgzFnAjETdcKJhBU5Ns0Zkt0V5Yat082u0ISLHudN
	 kA//yNMDegHXcNkwsGEKwqqgOWw6wrAh+oPO7L1c=
Date: Fri, 11 Jul 2025 07:54:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: jackysliu <1972843537@qq.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] usb: gadget: functioni: Fix a oob problem in rndis
Message-ID: <2025071150-removal-bullring-5649@gregkh>
References: <2025071010-outlet-stencil-663d@gregkh>
 <tencent_19AE390D05232D1C97E336C05F35A9F1BD05@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_19AE390D05232D1C97E336C05F35A9F1BD05@qq.com>

On Fri, Jul 11, 2025 at 11:46:35AM +0800, jackysliu wrote:
> On Thu, 10 Jul 2025 14:19:47 +0200, greg k-h wrote
> 
> >In digging in this further, I don't see how this actually changes
> >anything.  BufLength is used for nothing that I can determine, except in
> >some debugging code that is always compiled out (i.e. you can NOT enable
> >it unless you modify the kernel source.)
> >
> >So what exactly is this check checking?
> >
> >I can see that we really should be checking if the buffer is too small,
> >but that's not what you are doing here at all.
> >
> >And all this buffer is used for is to read a 32bit value out of, so
> >verifying that the buffer really is big enough to hold that value SHOULD
> >be what we do here, not check to see if the buffer is too big.
> >
> >Also, you can't trust that BufLength is even correct as it comes from
> >the other side, right?  Because of that, we should just be ignoring it
> >entirely and verifying that the message size really is as big as the
> >structure is supposed to be.  But that means passing down the message
> >size to the lower layers here, which gets into the issues that I have
> >raised before many years ago about this protocol, and this
> >implementation of this protocol.  I.e, it is COMPLETELY INSECURE and
> >should ONLY be used on systems where you trust both sides of the wire.
> >
> >Again, how was this change tested?  And what exactly does it fix?  I'm
> >missing how this change is going to actually catch anything, can you
> >spell it out in detail for me?
> 
> BufOffset + BufLength can exceed buffer size even if each is < RNDIS_MAX_TOTAL_SIZE

Sure, but again, BufLength is not used for anything, so the value of
that variable means nothing as far as I can tell.

> oob is triggered by a function call to gen_ndis_set_resp.

How exactly?  Again, BufLength isn't even used in that function.

> I supposed to add an additional boundry check to avoid this issue.But That 
> doesn't seem to be enough to fix the bug.I'll try to figure it out.

How was this tested?

And even more importantly, how did you find this bug?  What triggered
it?

thanks,

greg k-h

