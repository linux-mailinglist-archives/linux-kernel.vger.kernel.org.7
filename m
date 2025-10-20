Return-Path: <linux-kernel+bounces-860934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 351EFBF15F7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F7604F45BF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9D32F83DE;
	Mon, 20 Oct 2025 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hzdOHXg8"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0163248883
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965036; cv=none; b=IuKnwoFJQC2LE+0HoRS8nTz0AcMYy2c2WrFJLgR0rdaeF7wwGQjAUxFc+Ft+LD28zyjCOhz9OfJPesa2WJfOg334s7YMyetuBwkiXvBkxfOtuqIqSEHhndAs9a8R0wL8dOT6FPvK2NYq31v09AmHfjJn2afJQiI6+zi+uDegJO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965036; c=relaxed/simple;
	bh=jS4F/EQCuVfoDvcgyi6Dkh/JAq8dbkKj0ab0uRstZFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApYePkGpPFARwGfQ1yfCOuymn11NmdARCj1HEvUeNzIyZf30afC2/GmTTaKNPetXjKJjbpdFx+4/xfXdv9MA82DgzjoGZU1DJpzSYks/kCQsYi7z1zqowMKflVmMJfNv0cZRCcUhBzhtOOdJGqaz5vaVWVzDjgWcQlb2XXOyCmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hzdOHXg8; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 20 Oct 2025 08:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760965031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T6EXoZIASMGNH9SpdtinReibztnVfzgrx2zwj3rN8u0=;
	b=hzdOHXg8xFdwGyNbNdSCuiy++/gESzwKoRryl+FOMsZ2BwH/uqMZMDL6TrVjpFMXT4ftB4
	CNqlKPMzmbs5clw2WPmjSPPBdFM5ucnZL2XUpxL/NGDS8JLj8sMXMecJjbSIEXJA2EummO
	Yn6J+9LcUDlhLAdU9pGXkwDAMJWHlZg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-block@vger.kernel.org
Subject: Re: [GIT PULL] block-bio_iov_iter_export
Message-ID: <lyqal3mcvjwmzoxltydw2aoyhjllwcvv5ix2axpw24kh2iotkx@lygocjo66enh>
References: <ov54jszhism7mbeu74vtyoysxnx3y3tsjbj5esszlrx3edq77s@j2vtyy45gsna>
 <aPHemg-xpVLkiEt9@infradead.org>
 <6strysb6whhovk4rlaujravntyt2umocsjfsaxtl4jnuvjjbsp@sqf6ncn3yrlm>
 <aPYCbIrvAkOf5L3g@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPYCbIrvAkOf5L3g@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 20, 2025 at 02:35:40AM -0700, Christoph Hellwig wrote:
> On Fri, Oct 17, 2025 at 09:31:59AM -0400, Kent Overstreet wrote:
> > On Thu, Oct 16, 2025 at 11:13:46PM -0700, Christoph Hellwig wrote:
> > > Umm,
> > > 
> > > besides adding exports without in-tree users, this is a patch that's
> > > never seen any relevant mailing list, in a pull request that the
> > > maintainer hasn't seen.  That's now exactly how Linux development works,
> > > does it?
> > 
> > Christoph, I wrote that code /for bcachefs/; the rest of you decided it
> > was nice and started using it too.
> 
> In fact this version was written by me, giving you the attribution
> because I stole a cool idea from you.  But none of this actually
> matters, there's not magic exception just because someone wrote the
> code.

The implementation has morphed given multipage bvecs and iov_iters, but
otherwise it looks structurally much the same as the version I
originally introduced.

Please attribute correctly, and that would've included CCing me on the
patch that dropped the EXPORT_SYMBOL().

> > Then you removed the export talking about the "abuse" of bcachefs using
> > it. WTF?
> 
> The random NULL bdev check that breaks the proper splitting.  We told
> told you that's not the way to go, but you just sent it directly to Linus
> instead of reworking it.  And this then got into the way of the rework
> Keith did to support arbitrarily small memory alignments.  Fortunately
> we could clean this up properly now.

So, you "told" the person that originally authored not only this code
but all our modern bio splitting infastructure that this isn't the way
to go?

That's quite the way of framing it.

The way you're doing it with bdev_logical_block_size() is just wrong -
even for single device filesystems! - because it's the filesystem
blocksize that's relevant here and that isn't necessarily going to match
(even if it matched when the filesystem was formatted, filesystems can
be moved to different block devices).

You'll figure this out sooner or later as bs > ps becomes more
prevalent...

