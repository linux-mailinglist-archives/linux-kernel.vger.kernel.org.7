Return-Path: <linux-kernel+bounces-646853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C58AFAB617E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 06:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60458641D5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 04:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C851F0996;
	Wed, 14 May 2025 04:29:54 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EA4191F92;
	Wed, 14 May 2025 04:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747196994; cv=none; b=Lw9PXv1D4q9v50lFnhjXxFtDFYe4gepkZz0rS8TRnIQeur5mp5Q6cDPkx/SLhfBtskXru+6x+mPRlWe4fN9xHoKXpbTi8uXGe5vTocPVoLV4qFlc0ty3S6SPIXdc7gxzJbUXYc+mKOGH78FeOAKRP4pcyHBG3rtOoZQ7DvDoaoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747196994; c=relaxed/simple;
	bh=ogvARIjT/fGZSdVf3X+YFyH6GYT6djqLRQ++GqbS6OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFMjMylfuOUzhVp6UpneLPLpLf+ivvNaYMAntsdV1AdI/QMVUqOtuTTVHG6pj4vaYzwOqrS2JG7h981pFzccrtosPJ9YLIJzqowIQ6ID2gJSXCLvHu+BISO25uI9yfsPLe/h3LbD6vLlmbC1gDi253dVY+LWZXY1Uy/OV5y2Bg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8925168AA6; Wed, 14 May 2025 06:29:46 +0200 (CEST)
Date: Wed, 14 May 2025 06:29:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>, cem@kernel.org,
	linux-xfs@vger.kernel.org, cen zhang <zzzccc427@gmail.com>,
	lkmm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: mark the i_delayed_blks access in
 xfs_file_release as racy
Message-ID: <20250514042946.GA23355@lst.de>
References: <20250513052614.753577-1-hch@lst.de> <aCO7injOF7DFJGY9@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCO7injOF7DFJGY9@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 14, 2025 at 07:37:14AM +1000, Dave Chinner wrote:
> On Tue, May 13, 2025 at 07:26:14AM +0200, Christoph Hellwig wrote:
> > We don't bother with the ILOCK as this is best-effort and thus a racy
> > access is ok.  Add a data_race() annotation to make that clear to
> > memory model verifiers.
> 
> IMO, that's the thin edge of a wedge. There are dozens of places in
> XFS where we check variable values without holding the lock needed
> to serialise the read against modification.

Yes. And the linux kernel memory consistency model ask us to mark them,
see tools/memory-model/Documentation/access-marking.txt.

This fails painful at first, but I'd actually wish we'd have tools
enforcing this as strongly as possible as developers (well me at least)
seem to think a racy access is just fine more often than they should, and
needing an annotation and a comment is a pretty good way to sure that.

> Hence my question - are we now going to make it policy that every
> possible racy access must be marked with data_race() because there
> is some new bot that someone is running that will complain if we
> don't? Are you committing to playing whack-a-mole with the memory
> model verifiers to silence all the false positives from these
> known-to-be-safe access patterns?

It's not really a "new bot".  It has been official memory consistency
policy for a while, but it just hasn't been well enforced.  For new code
asking if the review is racy and needs a marking or use READ_ONCE() and
WRITE_ONCE() has been part of the usual review protocol.  Reviewing old
code and fixing things we got wrong will take a while, but I'm actually
glad about more bots for that.

