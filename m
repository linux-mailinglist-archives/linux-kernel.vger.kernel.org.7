Return-Path: <linux-kernel+bounces-748388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E257CB1408D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C7E17E5B5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8813B274678;
	Mon, 28 Jul 2025 16:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8RbLq7v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2791F5E6
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753721085; cv=none; b=c3AgHlaAITgVwXLl60duDych3cgsiyh91xad65d7lUw/TeEmvqWQ+E/iyZ2wenIAIs2BEyub1FM/er6YV+Ns9x4CfvNlSORZvgTW+MJ0kzDYVgklqLzggOczIT9/vlDrJH4an9N8/qk9M6pwLQAPkqr/W6IxZI4ql9HlEVY6qzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753721085; c=relaxed/simple;
	bh=Rgr92Y/bCOkrWYFO5fPTNpSB2Abyvra8IFBe/Do6Be8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rvi0IjJLUUkP51+OZC/v5AZvef33+aTe9zPyY/3pFGsFNKYXry3GGMm5kNjpBW1nWizndpTAiOvAuFnJUBjagFHe1ZXK//VZLjAd5ZYA1luQCeew9o996bf0dcnkoHKIjQXCQm2kbcBg96BKnwq5GHFUyUHd86OcLnC84IN4SiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8RbLq7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8E9C4CEE7;
	Mon, 28 Jul 2025 16:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753721084;
	bh=Rgr92Y/bCOkrWYFO5fPTNpSB2Abyvra8IFBe/Do6Be8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q8RbLq7vru0JBAQzrTUGjpwURj82H+ha7clts8cKyuxAzJaJcsq5rDtynpRniKg5H
	 4Zm7MFcHvi8CFyOyivmUbn5UFCFKhXWzktK1zr71cj058FKurlmaeT/5ZX8X7qx7Sl
	 dEuBqusg6cRrH2ug21kdRqdi3KkqgaNKOcuMOgug2ng8EP5WAbUc1AZGe0ImBzobfF
	 QYbErvIMejXkrTL+0hA06CTmxDpjng46A9a5c27nvvC5FSjUHNDhirwnYYkoCL4mT+
	 lMXREMTDOUOE2npOaEPVWvwzQ8Xqp3EucOCW7tAm+YJ/T9K2H13gWrSG8Us+OG3Urw
	 rgfTnNjS+IlEA==
Date: Mon, 28 Jul 2025 16:44:42 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH v3] f2fs: add gc_boost_gc_multiple sysfs node
Message-ID: <aIeo-kTFqsUs7L0v@google.com>
References: <20250728163628.1043162-1-daeho43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728163628.1043162-1-daeho43@gmail.com>

Please check

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/log/?h=dev-test

On 07/28, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Add a sysfs knob to set a multiplier for the background GC migration
> window when F2FS Garbage Collection is boosted.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> v3: fix the range check condition
> v2: limit the available value range
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs | 8 ++++++++
>  fs/f2fs/gc.c                            | 3 ++-
>  fs/f2fs/gc.h                            | 1 +
>  fs/f2fs/sysfs.c                         | 9 +++++++++
>  4 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index bf03263b9f46..931c1f63aa2e 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -861,3 +861,11 @@ Description:	This is a read-only entry to show the value of sb.s_encoding_flags,
>  		SB_ENC_STRICT_MODE_FL            0x00000001
>  		SB_ENC_NO_COMPAT_FALLBACK_FL     0x00000002
>  		============================     ==========
> +
> +What:		/sys/fs/f2fs/<disk>/gc_boost_gc_multiple
> +Date:		June 2025
> +Contact:	"Daeho Jeong" <daehojeong@google.com>
> +Description:	Set a multiplier for the background GC migration window when F2FS GC is
> +		boosted.
> +		Default: 5
> +
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 3cb5242f4ddf..de7e59bc0906 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -197,6 +197,7 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
>  
>  	gc_th->urgent_sleep_time = DEF_GC_THREAD_URGENT_SLEEP_TIME;
>  	gc_th->valid_thresh_ratio = DEF_GC_THREAD_VALID_THRESH_RATIO;
> +	gc_th->boost_gc_multiple = BOOST_GC_MULTIPLE;
>  
>  	if (f2fs_sb_has_blkzoned(sbi)) {
>  		gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME_ZONED;
> @@ -1749,7 +1750,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>  					!has_enough_free_blocks(sbi,
>  					sbi->gc_thread->boost_zoned_gc_percent))
>  				window_granularity *=
> -					BOOST_GC_MULTIPLE;
> +					sbi->gc_thread->boost_gc_multiple;
>  
>  			end_segno = start_segno + window_granularity;
>  		}
> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> index 5c1eaf55e127..efa1968810a0 100644
> --- a/fs/f2fs/gc.h
> +++ b/fs/f2fs/gc.h
> @@ -68,6 +68,7 @@ struct f2fs_gc_kthread {
>  	unsigned int no_zoned_gc_percent;
>  	unsigned int boost_zoned_gc_percent;
>  	unsigned int valid_thresh_ratio;
> +	unsigned int boost_gc_multiple;
>  };
>  
>  struct gc_inode_list {
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 75134d69a0bd..b417b655d4e8 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -824,6 +824,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>  		return count;
>  	}
>  
> +	if (!strcmp(a->attr.name, "gc_boost_gc_multiple")) {
> +		if (t < 1 || t > SEGS_PER_SEC(sbi))
> +			return -EINVAL;
> +		sbi->gc_thread->boost_gc_multiple = (unsigned int)t;
> +		return count;
> +	}
> +
>  	*ui = (unsigned int)t;
>  
>  	return count;
> @@ -1050,6 +1057,7 @@ GC_THREAD_RW_ATTR(gc_no_gc_sleep_time, no_gc_sleep_time);
>  GC_THREAD_RW_ATTR(gc_no_zoned_gc_percent, no_zoned_gc_percent);
>  GC_THREAD_RW_ATTR(gc_boost_zoned_gc_percent, boost_zoned_gc_percent);
>  GC_THREAD_RW_ATTR(gc_valid_thresh_ratio, valid_thresh_ratio);
> +GC_THREAD_RW_ATTR(gc_boost_gc_multiple, boost_gc_multiple);
>  
>  /* SM_INFO ATTR */
>  SM_INFO_RW_ATTR(reclaim_segments, rec_prefree_segments);
> @@ -1220,6 +1228,7 @@ static struct attribute *f2fs_attrs[] = {
>  	ATTR_LIST(gc_no_zoned_gc_percent),
>  	ATTR_LIST(gc_boost_zoned_gc_percent),
>  	ATTR_LIST(gc_valid_thresh_ratio),
> +	ATTR_LIST(gc_boost_gc_multiple),
>  	ATTR_LIST(gc_idle),
>  	ATTR_LIST(gc_urgent),
>  	ATTR_LIST(reclaim_segments),
> -- 
> 2.50.1.470.g6ba607880d-goog
> 

