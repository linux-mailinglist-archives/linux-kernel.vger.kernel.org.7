Return-Path: <linux-kernel+bounces-897840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 22360C53C9D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C88E94FFA6F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3910F3469EB;
	Wed, 12 Nov 2025 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OarfSWcR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9431631B82F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762968849; cv=none; b=taZdAY6N22LzQuOgqnl3f2BvoF9OJCdgcpM17ZoHZu8RAPRrnU7M1jc9fInqTnjOxbT3cPmVfEokQRBMAyaDg3VFLNyo9chkN3xHK93L8Kwxhaq2IB/lQ8ZSk8f5yw+Sv7LCeWaUVdODK8LcXbu0HrDo7TqvS6FlwnOzYuOcfe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762968849; c=relaxed/simple;
	bh=DAaxYL3UC58u9iDEuPfd0uEzuupacsBaOg9rSiBKRIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHBxhqdrJRhDzF4GpxUoV1khB7Kbd2GrtcUaRW3zltAQwnmIbDjoHXKZW87HR42TJf1QTknIlDLo2DZaxnAad5i6L2C/jkfUhpbgJCXrkjSORomSKXPKZUuWE9BhwmxfmA3XYcz79tcSWlsvMUc4kpJnxJVd2XbtVo5Cb4EXztE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OarfSWcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F995C19422;
	Wed, 12 Nov 2025 17:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762968847;
	bh=DAaxYL3UC58u9iDEuPfd0uEzuupacsBaOg9rSiBKRIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OarfSWcRCwq5sz+dcXP956dwRMxiuNcRnWSeI7C0EQVfYgJf5Fj/YRh0v20y+vtXz
	 fsXvUpt7KE3VWaezHh2TDJfyjC+wIpVWBxXujUnMOYmD6P3QosvVnniDv2sM7m1dnC
	 SCiVaJc2yA2r0OS4nfti/n/ysGJHZXmeoCMhdS6a/BtgXR1c0WkisuOGu9hxLN1ym/
	 RCMqMYwZoQz8whTN0jR8vatp1oQqCcYClta0XeL6ofEQgB1xAn9Zfvdzy0jIIZcnFv
	 sqUpRtMzOIhJAHgEWUFFbr3/Y0g5VRBc/gB4AvbF5IOwsyyrV6FOdCFxYvjIotr6Am
	 LtXmUmPc74syw==
Date: Wed, 12 Nov 2025 17:34:05 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: mempool_alloc_bulk and various mempool improvements
Message-ID: <20251112173405.GA2935281@google.com>
References: <20251111135300.752962-1-hch@lst.de>
 <48e45106-f76a-421d-8f9c-645469076ad4@suse.cz>
 <20251112155011.GC7209@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112155011.GC7209@lst.de>

On Wed, Nov 12, 2025 at 04:50:11PM +0100, Christoph Hellwig wrote:
> On Wed, Nov 12, 2025 at 01:22:01PM +0100, Vlastimil Babka wrote:
> > On 11/11/25 14:52, Christoph Hellwig wrote:
> > > Hi all,
> > > 
> > > this series adds a bulk version of mempool_alloc that makes allocating
> > > multiple objects deadlock safe.
> > > 
> > > The initial users is the blk-crypto-fallback code:
> > > 
> > >   https://lore.kernel.org/linux-block/20251031093517.1603379-1-hch@lst.de/
> > > 
> > > with which v1 was posted, but I also have a few other users in mind.
> > 
> > How do we handle this then once it's settled?
> 
> Good question.  I think there is enough mm material now for a merge
> through an mm tree.  If we get it sorted out for this merge window just
> merging it through mm even when there is no user yet would be easiest as
> the blk-crypto work is probably not going to make this merge window with
> additional review from Eric and I'll most like have another user for the
> next merge window as well (block bounce buffering for !STABLE_WRITES
> dio).

That sounds good to me.  Sorry for the slow review on the
blk-crypto-fallback changes.  How about I also take the two fscrypt
cleanups "fscrypt: pass a real sector_t to
fscrypt_zeroout_range_inline_crypt" and "fscrypt: keep multiple bios in
flight in fscrypt_zeroout_range_inline_crypt" through the fscrypt tree
for 6.19 to get them out of the way?  They don't depend on anything
else.

- Eric

