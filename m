Return-Path: <linux-kernel+bounces-587149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC04A7A86C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 19:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866E71897B6E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 17:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F374A25179C;
	Thu,  3 Apr 2025 17:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lff1NApR"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C336E2505BC;
	Thu,  3 Apr 2025 17:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743700360; cv=none; b=ptpJnkeioBvDSc5beNvIpLlUWswb1W5UItZ3maHLJysKzHwkbegLJZSfUypA5DcGC3xyAV9oCpAs6BnUBqREvaS0QxIeG1969+BvYtgcPCMVpOjYkF5pi1jYbolXIhX62A3+SmloP1SdvEUNZEgi6Bs+sFnfdqXc129irLJNvUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743700360; c=relaxed/simple;
	bh=n3MLm048L/1tThdw/l7NAqBQKdRTct3UQQPeLerYNkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2oKVskZeY3XiB+LwrydQTnfx2kCKoPDrlKDBUkfI3LUR/N2TPwAe8IeWzOgoIOklsVQzmWRZbRd2wOXnrDX57dQgW6RmwbgKvNuwQQiXuEIvhpdL8P3bgLAJ+SFkoE2ybh5VihUb9UJAalmQSCyji79ovmia0qXfie+S4C5kFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lff1NApR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=F/Huv1u3N8Ic31zYcjSkVat6RRJDswmpX0g1d52/EhY=; b=Lff1NApRveWFI0pHa7VtFfnSIL
	YonUoUpFlqcynPi+DSS5aZ0uLB1NlbC8JB8YynvwvDpFnj4GawFv9pOPtaSeSaxkMkNxez62iitoR
	EGDbRyhQciYbKDm9la7lGll9DZpY1oBCE0S8a/zh6C29reHXyzugC/cvfQa+uws1ft97SuRAdakMD
	AfJgkHa+pxL6mlN+YmivT++4mfax91L2OA83qGV8i/XhbMXgYzolnQP+GZz524JPSw5qeBEyZAWVD
	co0rkj4yRcCk4JsB/Yq9IgWBKlKcg/0mtu3sG86wckKXTI6X2joIolQYIYS9YsLj0uqLn23R4mWrF
	mDapSljg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0O78-0000000DMVH-41Zr;
	Thu, 03 Apr 2025 17:12:27 +0000
Date: Thu, 3 Apr 2025 18:12:26 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Matt Fleming <matt@readmodwrite.com>
Cc: adilger.kernel@dilger.ca, akpm@linux-foundation.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	luka.2016.cs@gmail.com, tytso@mit.edu,
	Barry Song <baohua@kernel.org>, kernel-team@cloudflare.com,
	Vlastimil Babka <vbabka@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Dave Chinner <david@fromorbit.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Subject: Re: Potential Linux Crash: WARNING in ext4_dirty_folio in Linux
 kernel v6.13-rc5
Message-ID: <Z-7BengoC1j6WQBE@casper.infradead.org>
References: <Z8kvDz70Wjh5By7c@casper.infradead.org>
 <20250326105914.3803197-1-matt@readmodwrite.com>
 <CAENh_SSbkoa3srjkAMmJuf-iTFxHOtwESHoXiPAu6bO7MLOkDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAENh_SSbkoa3srjkAMmJuf-iTFxHOtwESHoXiPAu6bO7MLOkDA@mail.gmail.com>

On Thu, Apr 03, 2025 at 01:29:44PM +0100, Matt Fleming wrote:
> On Wed, Mar 26, 2025 at 10:59 AM Matt Fleming <matt@readmodwrite.com> wrote:
> >
> > Hi there,
> >
> > I'm also seeing this PF_MEMALLOC WARN triggered from kswapd in 6.12.19.
> >
> > Does overlayfs need some kind of background inode reclaim support?
> 
> Hey everyone, I know there was some off-list discussion last week at
> LSFMM, but I don't think a definite solution has been proposed for the
> below stacktrace.

Hi Matt,

We did have a substantial discussion at LSFMM and we just had another
discussion on the ext4 call.  I'm going to try to summarise those
discussions here, and people can jump in to correct me (I'm not really
an expert on this part of MM-FS interaction).

At LSFMM, we came up with a solution that doesn't work, so let's start
with ideas that don't work:

 - Allow PF_MEMALLOC to dip into the atomic reserves.  With large block
   devices, we might end up doing emergency high-order allocations, and
   that makes everybody nervous
 - Only allow inode reclaim from kswapd and not from direct reclaim.
   Your stack trace here is from kswapd, so obviously that doesn't work.
 - Allow ->evict_inode to return an error.  At this point the inode has
   been taken off the lists which means that somebody else may have
   started to start constructing it again, and we can't just put it back
   on the lists.

Jan explained that _usually_ the reclaim path is not the last holder of
a reference to the inode.  What's happening here is that we've lost a
race where the dentry is being turned negative by somebody else at the
same time, and usually they'd have the last reference and call evict.
But if the shrinker has the last reference, it has to do the eviction.

Jan does not think that Overlayfs is a factor here.  It may change the
timing somewhat but should not make the race wider (nor narrower).

Ideas still on the table:

 - Convert all filesystems to use the XFS inode management scheme.
   Nobody is thrilled by this large amount of work.
 - Find a simpler version of the XFS scheme to implement for other
   filesystems.


