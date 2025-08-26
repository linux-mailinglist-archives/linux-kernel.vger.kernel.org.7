Return-Path: <linux-kernel+bounces-787340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B45B374E0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 00:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 765787ACECE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 22:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350D529B766;
	Tue, 26 Aug 2025 22:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lYVZxmGA"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B075230CDAE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 22:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756247211; cv=none; b=fR0d0WeTL+nsmc2VBzbzviUGxS0ITD1J48WOv9G7loz6x1LXPPUsJFtO+tFTFwvGLIjm9Ui5eJdwiKKNadp8G6cu1fTEQfWINwzrvyn/koDbGNoe0gO3CMwFEvBfhOnmhfdiuPACSB9MKGSQFfDKW10IJV/dTMSyQ0ZKv3J7uQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756247211; c=relaxed/simple;
	bh=EC++G77e/HS0X/DrQ9ScqfkS2/3Bsl0jUbRNFf28MSo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/jeDhufYoVSZvB8IIEmkYLC5MozelOiJSBoKol69qQFzTEr+aOPOjHvYcgmpGN/yPH4eAr67dtrvn3uZ7Dgo+BghflmEapLDESLhswQJOAoiPeJ8RTCh9yM2nmzPSG+HE9xZxgh0UAlsHEL2WrV8eVMtlXvQz2u/XyozWT26Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lYVZxmGA; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 26 Aug 2025 15:26:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756247205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tzFI8fgj/BdF0obZ/y49hT7uslbpWc7a8KSBkYRAaRM=;
	b=lYVZxmGA6CRCML0HPmZ5H8e/RnWO8lNbW87RG3tFCHjRLBhNsJmrBHjyNXYOCbR2qb+MKV
	vXBWCA1YgYMfibr4YvFtzlAjyete/8w5XQM8MfKVj6/VUT+d+t8/PpgNcE0zxEigqkpQoH
	GFwoxS4TLrfpYA+mZcQgtK7aISDGidk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, zhongjinji <zhongjinji@honor.com>, mhocko@suse.com, 
	rientjes@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, tglx@linutronix.de, liulu.liu@honor.com, feng.han@honor.com
Subject: Re: [PATCH v5 2/2] mm/oom_kill: Have the OOM reaper and exit_mmap()
 traverse the maple tree in opposite order
Message-ID: <oogiwonpxtqurkad7rt2zxc3ffgeujtilivno3ibcybzucsliw@ym7jm6r5kdil>
References: <20250825133855.30229-1-zhongjinji@honor.com>
 <20250825133855.30229-3-zhongjinji@honor.com>
 <002da86b-4be7-41a1-bb14-0853297c2828@lucifer.local>
 <nwh7gegmvoisbxlsfwslobpbqku376uxdj2z32owkbftvozt3x@4dfet73fh2yy>
 <bcabe7cb-d09c-4789-ae39-407b2e0653da@lucifer.local>
 <ip7al6pv3nm54raaptrxq3v4t7cpilqgppkezowzn2sfbjax65@qt72zuotrwnw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ip7al6pv3nm54raaptrxq3v4t7cpilqgppkezowzn2sfbjax65@qt72zuotrwnw>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 26, 2025 at 11:21:13AM -0400, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250826 09:50]:
> > On Tue, Aug 26, 2025 at 09:37:22AM -0400, Liam R. Howlett wrote:
> > > I really don't think this is worth doing.  We're avoiding a race between
> > > oom and a task unmap - the MMF bits should be used to avoid this race -
> > > or at least mitigate it.
> > 
> > Yes for sure, as explored at length in previous discussions this feels like
> > we're papering over cracks here.
> > 
> > _However_, I'm sort of ok with a minimalistic fix that solves the proximate
> > issue even if it is that, as long as it doesn't cause issues in doing so.
> > 
> > So this is my take on the below and why I'm open to it!
> > 
> > >
> > > They are probably both under the read lock, but considering how rare it
> > > would be, would a racy flag check be enough - it is hardly critical to
> > > get right.  Either would reduce the probability.
> > 
> > Zongjinji - I'm stil not sure that you've really indicated _why_ you're
> > seeing such a tight and unusual race. Presumably some truly massive number
> > of tasks being OOM'd and unmapping but... yeah that seems odd anyway.
> > 
> > But again, if we can safely fix this in a way that doesn't hurt stuff too
> > much I'm ok with it (of course, these are famous last words in the kernel
> > often...!)
> > 
> > Liam - are you open to a solution on the basis above, or do you feel we
> > ought simply to fix the underlying issue here?
> 
> At least this is a benign race. 

Is this really a race or rather a contention? IIUC exit_mmap and the oom
reaper are trying to unmap the address space of the oom-killed process
and can compete on page table locks. If both are running concurrently on
two cpus then the contention can continue for whole address space and
can slow down the actual memory freeing. Making oom reaper traverse in
opposite direction can drastically reduce the contention and faster
memory freeing.

> I'd think using MMF_ to reduce the race
> would achieve the same goal with less risk - which is why I bring it up.
> 

With MMF_ flag, are you suggesting oom reaper to skip the unmapping of
the oom-killed process?

> Really, both methods should be low risk, so I'm fine with either way.
> 
> But I am interested in hearing how this race is happening enough to
> necessitate a fix.  Reversing the iterator is a one-spot fix - if this
> happens elsewhere then we're out of options.  Using the MMF_ flags is
> more of a scalable fix, if it achieves the same results.

On the question of if this is a rare situaion and worth the patch. I
would say this scenario is not that rare particularly on low memory
devices and on highly utilized overcommitted systems. Memory pressure
and oom-kills are norm on such systems. The point of oom reaper is to
bring the system out of the oom situation quickly and having two cpus
unmapping the oom-killed process can potentially bring the system out of
oom situation faster.

I think the patch (with your suggestions) is simple enough and I don't
see any risk in including it.


