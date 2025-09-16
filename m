Return-Path: <linux-kernel+bounces-818031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3003AB58BD0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E94A248698D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132ED2309B2;
	Tue, 16 Sep 2025 02:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrTQFkQi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701BC19AD48
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757989685; cv=none; b=ILMpfFloxQzv81CF+F8ZTHmefeitjEnneyx7UTSZL+dqW1neuEd/7Y5eMnug2zwEAbXzdL0CnDGLNZQgp5ffKt4naMVPIGilrBMvgnkyeVy3214IwuW+YyAl5CDdQmVr6FidnvBR3iyq2dNwUZiINndxNP62TNtyS8148nH0zw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757989685; c=relaxed/simple;
	bh=cUI+GduIRyVlpYvUYsfmG89UKOgODbBvtSJCHqDtaKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QA8xMXG9ysrFO6ls1BTuBA1lF5XB3IstyPCJLEymlu7TvIOouL3YtI8YEuScRmvYwFYWrRPhxDnDgor+rV3yPHo2yizqEhZ4bSKCPpR1abJUMLU6KbcofuN3ODMEXk9kdo/D0dFXt6QmabzPG1fZ70aDh0xUHsrs5fGdykKDCi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrTQFkQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B9FC4CEF1;
	Tue, 16 Sep 2025 02:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757989685;
	bh=cUI+GduIRyVlpYvUYsfmG89UKOgODbBvtSJCHqDtaKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nrTQFkQi9jBkK0BqRbPVRHBZyi3fKTIRjMbAYnNeJ+jizcWiR1PgMBGuk+vmHHIva
	 U/IvUOU1oyqP8Y27t1o/5hCdrrRTI7qT3NYNNdTqZQ/kHLZE0vTviudJjGQaIyyD+6
	 7p8sjoCaraZFYZisWtA7JFex45QzP+6L2bDIYj5Jathst6GRD0CUrnHaaNknJbTspw
	 2HnLKNeVYpLRoSRwpiRTPokrT7vHMz9wTfCfcjoPWsnCAQK2z3xdwCEVAexRoKFXKw
	 Xep0vcqGSAw6fFJRAWmoGVowzcPUZUM6vxRh1j9aPJW1AgD8l9dHk1VbynFQyNuU7H
	 qFMlfdAgy+04Q==
Date: Tue, 16 Sep 2025 02:28:03 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Chao Yu <chao@kernel.org>,
	"open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] f2fs: Optimize excessive write operations caused by
 continuous background garbage collection in Zoned UFS
Message-ID: <aMjLMwNDjabD8MVH@google.com>
References: <20250909134418.502922-1-liaoyuanhong@vivo.com>
 <20250909134418.502922-2-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909134418.502922-2-liaoyuanhong@vivo.com>

Could you please share some trends of relation between has_enough_free_blocks()
vs. has_enough_dirty_blocks()? I'm wondering whethere there's a missing case
where has_enough_free_blocks() is not enough.

On 09/09, Liao Yuanhong wrote:
> Incorporate a check using has_enough_dirty_blocks() to prevent redundant
> background GC in Zoned UFS. When there are insufficient dirty segments,
> continuous execution of background GC should be avoided, as it results in
> unnecessary write operations and impacts device lifespan. The initial
> threshold is set to 3 * section size (since f2fs data uses three write
> pointers).
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  fs/f2fs/gc.c |  8 ++++++--
>  fs/f2fs/gc.h | 10 +++++++++-
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index ed3acbfc83ca..4a8c08f970e3 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -120,7 +120,9 @@ static int gc_thread_func(void *data)
>  
>  		if (f2fs_sb_has_blkzoned(sbi)) {
>  			if (has_enough_free_blocks(sbi,
> -				gc_th->no_zoned_gc_percent)) {
> +				gc_th->no_zoned_gc_percent) ||
> +				!has_enough_dirty_blocks(sbi,
> +				LIMIT_GC_DIRTY_SECTION_NUM)) {
>  				wait_ms = gc_th->no_gc_sleep_time;
>  				f2fs_up_write(&sbi->gc_lock);
>  				goto next;
> @@ -1750,7 +1752,9 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>  
>  			if (f2fs_sb_has_blkzoned(sbi) &&
>  					!has_enough_free_blocks(sbi,
> -					sbi->gc_thread->boost_zoned_gc_percent))
> +					sbi->gc_thread->boost_zoned_gc_percent) &&
> +					has_enough_dirty_blocks(sbi,
> +					LIMIT_GC_DIRTY_SECTION_NUM))
>  				window_granularity *=
>  					sbi->gc_thread->boost_gc_multiple;
>  
> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> index 24e8b1c27acc..1ef234c2702b 100644
> --- a/fs/f2fs/gc.h
> +++ b/fs/f2fs/gc.h
> @@ -36,6 +36,7 @@
>  #define DEF_MIGRATION_WINDOW_GRANULARITY_ZONED	3
>  #define BOOST_GC_MULTIPLE	5
>  #define ZONED_PIN_SEC_REQUIRED_COUNT	1
> +#define LIMIT_GC_DIRTY_SECTION_NUM	3
>  
>  #define DEF_GC_FAILED_PINNED_FILES	2048
>  #define MAX_GC_FAILED_PINNED_FILES	USHRT_MAX
> @@ -177,6 +178,12 @@ static inline bool has_enough_free_blocks(struct f2fs_sb_info *sbi,
>  	return free_sections(sbi) > ((sbi->total_sections * limit_perc) / 100);
>  }
>  
> +static inline bool has_enough_dirty_blocks(struct f2fs_sb_info *sbi,
> +						unsigned int limit_num)
> +{
> +	return dirty_segments(sbi) > limit_num * SEGS_PER_SEC(sbi);
> +}
> +
>  static inline bool has_enough_invalid_blocks(struct f2fs_sb_info *sbi)
>  {
>  	block_t user_block_count = sbi->user_block_count;
> @@ -197,6 +204,7 @@ static inline bool need_to_boost_gc(struct f2fs_sb_info *sbi)
>  {
>  	if (f2fs_sb_has_blkzoned(sbi))
>  		return !has_enough_free_blocks(sbi,
> -				sbi->gc_thread->boost_zoned_gc_percent);
> +				sbi->gc_thread->boost_zoned_gc_percent) &&
> +				has_enough_dirty_blocks(sbi, LIMIT_GC_DIRTY_SECTION_NUM);
>  	return has_enough_invalid_blocks(sbi);
>  }
> -- 
> 2.34.1

