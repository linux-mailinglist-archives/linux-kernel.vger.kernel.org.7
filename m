Return-Path: <linux-kernel+bounces-748383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0857B1407C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A228D7A11F8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE36273D6F;
	Mon, 28 Jul 2025 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GX5Gkh5j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C652218ABD
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753720853; cv=none; b=us94me/5bPU3PX3Z9VEBoqQ80xzPuBGP/Dqja7+q244MtW0hA2hzJG4LX4XOjB6iLkJhF4N5OZJeUSHm4Vm0o7rv3piJTFIhsopXMXVTcYAYug8mPXGAOcJcZqrrXM1mksQ1glawjap/QZdFnfnSBLvYdzf3mgNcb3UOUOhBGR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753720853; c=relaxed/simple;
	bh=6z1DYzhMGiTdo3cVZNQD2vNNg+nClgICYhdNgBn9VzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gF4/3CpacMMeDsivYv1kDKnBVRve8JHbar3qY8xzsnQGEBIYWvXnDuTgSrP+p2YxC1KikZ3CjNSPgI96aMzfbcCwwyX3sHcHSb8T9o8nnPZTS9fei19lSBV9Ym5D29C9XHTWq8JQI1fm60TZFbNy/XT2kcJy2oLiyog20pgUgHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GX5Gkh5j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE75EC4CEE7;
	Mon, 28 Jul 2025 16:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753720852;
	bh=6z1DYzhMGiTdo3cVZNQD2vNNg+nClgICYhdNgBn9VzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GX5Gkh5jlBFQCYiBggX4mknonD0WD8i3HVkm0di+4XvNUN+qaWfPm+pk4RDFWO2HD
	 vuh2novJwVfZhmFFkXuk6IEHOcUOhu2XqOXjr27CY1T/02McewydnZNOlLP0b3BHYr
	 /KPKwIDdpZ4Oh0aXOWL+Esc7jlOLytv5btHgI/EdEUoFetMEfkekaFqH9w8pYK6nwr
	 95epBjUykC7TqTGwgo8iqjtk4YTCSWHZa4uzhd4mAHz3RqkzeO9Sfg7/g7hE84XJ7e
	 C1aHUm9hicQJBknQwQQXNlbf144VgzLqd+jOgkgwOW2SfaIH4z31TsYXIbzMQZfA1i
	 hmKIKgB+3a3ZA==
Date: Mon, 28 Jul 2025 16:40:50 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
	Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add gc_boost_gc_greedy sysfs node
Message-ID: <aIeoEmbeloGR6zdV@google.com>
References: <20250718215003.2283009-1-daeho43@gmail.com>
 <6c26bcaa-7a9d-4b30-b326-90395f55e155@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c26bcaa-7a9d-4b30-b326-90395f55e155@kernel.org>

On 07/22, Chao Yu wrote:
> On 7/19/25 05:50, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> > 
> > Add this to control GC algorithm for boost GC.
> > 
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> > v2: use GC_GREEDY instead of 1
> > ---
> >  Documentation/ABI/testing/sysfs-fs-f2fs |  8 +++++++-
> >  fs/f2fs/gc.c                            |  3 ++-
> >  fs/f2fs/gc.h                            |  1 +
> >  fs/f2fs/sysfs.c                         | 16 ++++++++++++++++
> >  4 files changed, 26 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> > index 931c1f63aa2e..2158055cd9d1 100644
> > --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> > +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> > @@ -866,6 +866,12 @@ What:		/sys/fs/f2fs/<disk>/gc_boost_gc_multiple
> >  Date:		June 2025
> >  Contact:	"Daeho Jeong" <daehojeong@google.com>
> >  Description:	Set a multiplier for the background GC migration window when F2FS GC is
> > -		boosted.
> > +		boosted. the range should be from 1 to the segment count in a section.
> >  		Default: 5
> >  
> > +What:		/sys/fs/f2fs/<disk>/gc_boost_gc_greedy
> > +Date:		June 2025
> > +Contact:	"Daeho Jeong" <daehojeong@google.com>
> > +Description:	Control GC algorithm for boost GC. 0: cost benefit, 1: greedy
> > +		Default: 1
> > +
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index de7e59bc0906..0d7703e7f9e0 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -141,7 +141,7 @@ static int gc_thread_func(void *data)
> >  					FOREGROUND : BACKGROUND);
> >  
> >  		sync_mode = (F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC) ||
> > -				gc_control.one_time;
> > +			(gc_control.one_time && gc_th->boost_gc_greedy);
> >  
> >  		/* foreground GC was been triggered via f2fs_balance_fs() */
> >  		if (foreground)
> > @@ -198,6 +198,7 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
> >  	gc_th->urgent_sleep_time = DEF_GC_THREAD_URGENT_SLEEP_TIME;
> >  	gc_th->valid_thresh_ratio = DEF_GC_THREAD_VALID_THRESH_RATIO;
> >  	gc_th->boost_gc_multiple = BOOST_GC_MULTIPLE;
> > +	gc_th->boost_gc_greedy = GC_GREEDY;
> >  
> >  	if (f2fs_sb_has_blkzoned(sbi)) {
> >  		gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME_ZONED;
> > diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> > index efa1968810a0..1a2e7a84b59f 100644
> > --- a/fs/f2fs/gc.h
> > +++ b/fs/f2fs/gc.h
> > @@ -69,6 +69,7 @@ struct f2fs_gc_kthread {
> >  	unsigned int boost_zoned_gc_percent;
> >  	unsigned int valid_thresh_ratio;
> >  	unsigned int boost_gc_multiple;
> > +	unsigned int boost_gc_greedy;
> >  };
> >  
> >  struct gc_inode_list {
> > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > index b0270b1c939c..3a52f51ee3c6 100644
> > --- a/fs/f2fs/sysfs.c
> > +++ b/fs/f2fs/sysfs.c
> > @@ -824,6 +824,20 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
> >  		return count;
> >  	}
> >  
> > +	if (!strcmp(a->attr.name, "gc_boost_gc_multiple")) {
> > +		if (t < 1 || t > SEGS_PER_SEC(sbi))
> > +			return -EINVAL;
> > +		sbi->gc_thread->boost_gc_multiple = (unsigned int)t;
> > +		return count;
> > +	}
> 
> This check should be in ("f2fs: add gc_boost_gc_multiple sysfs node"), right?

Applied with the fix.

> 
> Thanks,
> 
> > +
> > +	if (!strcmp(a->attr.name, "gc_boost_gc_greedy")) {
> > +		if (t > GC_GREEDY)
> > +			return -EINVAL;
> > +		sbi->gc_thread->boost_gc_greedy = (unsigned int)t;
> > +		return count;
> > +	}
> > +
> >  	*ui = (unsigned int)t;
> >  
> >  	return count;
> > @@ -1051,6 +1065,7 @@ GC_THREAD_RW_ATTR(gc_no_zoned_gc_percent, no_zoned_gc_percent);
> >  GC_THREAD_RW_ATTR(gc_boost_zoned_gc_percent, boost_zoned_gc_percent);
> >  GC_THREAD_RW_ATTR(gc_valid_thresh_ratio, valid_thresh_ratio);
> >  GC_THREAD_RW_ATTR(gc_boost_gc_multiple, boost_gc_multiple);
> > +GC_THREAD_RW_ATTR(gc_boost_gc_greedy, boost_gc_greedy);
> >  
> >  /* SM_INFO ATTR */
> >  SM_INFO_RW_ATTR(reclaim_segments, rec_prefree_segments);
> > @@ -1222,6 +1237,7 @@ static struct attribute *f2fs_attrs[] = {
> >  	ATTR_LIST(gc_boost_zoned_gc_percent),
> >  	ATTR_LIST(gc_valid_thresh_ratio),
> >  	ATTR_LIST(gc_boost_gc_multiple),
> > +	ATTR_LIST(gc_boost_gc_greedy),
> >  	ATTR_LIST(gc_idle),
> >  	ATTR_LIST(gc_urgent),
> >  	ATTR_LIST(reclaim_segments),
> 

