Return-Path: <linux-kernel+bounces-728072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC64EB02368
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3B7CA628EF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD6B2F2348;
	Fri, 11 Jul 2025 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NujaHfFY"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E331A13D8B1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752257679; cv=none; b=t45TX1vKh7bhJud6k3IDGta1swjUJxF86C/3nwhCVskrOE66TR7piVFeXziSY40Mp3gxILDZpLqUQ6ytFOhP2heltqz6WtQIZSWt4oV1Mj8ehCv8gfUybLIxNRC4AT4IIR22Em0aODf0S+unyUD57xpbUgCQIbIQIDdJXrQ7BlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752257679; c=relaxed/simple;
	bh=9mVXW4Pf6AcjRJUWu9ye/Zo2Q8L54b690kdvUszFGpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sju+Gkebc79P8CMrSvTVbaug8cW+QXkbtfEbHWq4hY68eCFK0+eZr/szsImUZ7oRHb92Id6RsZTeJmHeVHty8odE2c8ofFMJuYCK9vfcCKbngmLLlRbefwQZvRng8jhRhUpMRJB0ONchVxaMypig0Gc4KvmsSlrTyshXqsmUtVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NujaHfFY; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 11 Jul 2025 14:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752257674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DEDLNqYLAzAlmkyVAoBTURn15UXkdV8M1Di7IsBI+zg=;
	b=NujaHfFYo0+u2MQWXyCxgNDWyZEQzRpRDaGHmuShj8iN7cqW9CmGuqBJYGE2lDLvB4BNWO
	sV8UY+/9vBKiIw/fiUNXWKuIUUyRzTsPO0IN54+c9VZnV7wFq8+cmT7uMGlZ9J/Myfi34e
	KNgWSf8DDE36b+aWjBSrcDbw0tYMkLU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Casey Chen <cachen@purestorage.com>
Cc: akpm@linux-foundation.org, surenb@google.com, corbet@lwn.net, 
	dennis@kernel.org, tj@kernel.org, cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, rientjes@google.com, 
	roman.gushchin@linux.dev, harry.yoo@oracle.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, yzhong@purestorage.com, 
	souravpanda@google.com, 00107082@163.com
Subject: Re: [PATCH v3] alloc_tag: add per-NUMA node stats
Message-ID: <in2dqgf4y3npivzl3vkby6pbjp2dv7f7geeqqsmrfy2pb3rptu@luoquhvf23gg>
References: <20250711002322.1303421-1-cachen@purestorage.com>
 <CALCePG3a6wG+3Nu7-JHha+LMtyRRNF3sXp13sS-=Xv1pvsX09Q@mail.gmail.com>
 <fhy4rcjrwwmlebgoiwepmga3fovxdvqeylsub6lk3opl2fi2td@ucuwdpu4ua7r>
 <CALCePG1h8NE010EGpBh8CxhiWqr4-GantEJ4P0Dnck+cnioBiw@mail.gmail.com>
 <vyguhk4hzhf6zyg6hn77satnmsrsr5hmcl7bifws32bnilqbs2@374p6che72yz>
 <CALCePG0gw9aJM5dWWxrk1Vh850kOB4wDqvmsuwyM-4q0QAz1Qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCePG0gw9aJM5dWWxrk1Vh850kOB4wDqvmsuwyM-4q0QAz1Qw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 11, 2025 at 10:41:36AM -0700, Casey Chen wrote:
> On Thu, Jul 10, 2025 at 8:09 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Thu, Jul 10, 2025 at 06:07:13PM -0700, Casey Chen wrote:
> > > On Thu, Jul 10, 2025 at 5:54 PM Kent Overstreet
> > > <kent.overstreet@linux.dev> wrote:
> > > >
> > > > On Thu, Jul 10, 2025 at 05:42:05PM -0700, Casey Chen wrote:
> > > > > Hi All,
> > > > >
> > > > > Thanks for reviewing my previous patches. I am replying some comments
> > > > > in our previous discussion
> > > > > https://lore.kernel.org/all/CAJuCfpHhSUhxer-6MP3503w6520YLfgBTGp7Q9Qm9kgN4TNsfw@mail.gmail.com/T/#u
> > > > >
> > > > > Most people care about the motivations and usages of this feature.
> > > > > Internally, we used to have systems having asymmetric memory to NUMA
> > > > > nodes. Node 0 uses a lot of memory but node 1 is pretty empty.
> > > > > Requests to allocate memory on node 0 always fail. With this patch, we
> > > > > can find the imbalance and optimize the memory usage. Also, David
> > > > > Rientjes and Sourav Panda provide their scenarios in which this patch
> > > > > would be very useful. It is easy to turn on an off so I think it is
> > > > > nice to have, enabling more scenarios in the future.
> > > > >
> > > > > Andrew / Kent,
> > > > > * I agree with Kent on using for_each_possible_cpu rather than
> > > > > for_each_online_cpu, considering CPU online/offline.
> > > > > * When failing to allocate counters for in-kernel alloc_tag, panic()
> > > > > is better than WARN(), eventually the kernel would panic at invalid
> > > > > memory access.
> > > > > * percpu stats would bloat data structures quite a bit.
> > > > >
> > > > > David Wang,
> > > > > I don't really understand what is 'granularity of calling sites'. If
> > > > > NUMA imbalance is found, the calling site could request memory
> > > > > allocation from different nodes. Other factors can affect NUMA
> > > > > balance, those information can be implemented in a different patch.
> > > >
> > > > Let's get this functionality in.
> > > >
> > > > We've already got userspace parsing and consuming /proc/allocinfo, so we
> > > > just need to do it without changing that format.
> > >
> > > You mean keep the format without per-NUMA info the same as before ?
> > > My patch v3 changed the header and the alignment of bytes and calls. I
> > > can restore them back.
> >
> > I mean an ioctl interface - so we can have a userspace program with
> > different switches for getting different types of output.
> >
> > Otherwise the existing programs people have already written for
> > consuming /proc/allocinfo are going to break.
> 
> What does this IOCTL interface do ? get bytes/calls per allocating
> site ? or get total bytes/calls per module ? or per-NUMA bytes/calls
> for each allocating site or module ?
> Would it be too much work for this patch ? If you can show me an
> example, it would be useful. I can try implementing it.

Since we're adding optional features the ioctl needs to pass in a flags
argument for which features we want - per numa node stats for now, but I
suspect more will come up (maybe we'll want to revisit number of calls
per callsite).

Return -EINVAL if we ask for something the running kernel doesn't
support...

