Return-Path: <linux-kernel+bounces-749560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A0DB14FF7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1558016D5FB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B7F1E25F8;
	Tue, 29 Jul 2025 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTvkfjvu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7CF207E1D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753801637; cv=none; b=HZWsPdtx/VyyR64sihRkl1rTJPX652n82f6NmRB8+FlE9tZwLMkinUzXee2pTmZzJc1Vzf4KJHCz2enOzwOkQEg3WEw2GAP6YALjKB1O0m+dZxKUmvnedoARz3lYOekSUrVF/KTAfCYRTVuPJIYVKTQaVGQV1hDtoHtcGx69C4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753801637; c=relaxed/simple;
	bh=Ei4j61++xYai4BK5l+E6lE08w0YyBTZsWiZjNGGayh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zxuny+q0YvuO97n5DRwOXuGe3KPXq9xSoLPe/l2hIva6h5Y2AU9ATgH5vmFGbp6lWZ10rWQkvj70pQSIgU7ivxlW615XrnOaSu6X0Gsgh/86dI6paODRCP+00pobRr0AdqrBnSO13+FL5MwKQTFgGH5rQBuX+XXdJeEvqwzIB0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTvkfjvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870E2C4CEEF;
	Tue, 29 Jul 2025 15:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753801634;
	bh=Ei4j61++xYai4BK5l+E6lE08w0YyBTZsWiZjNGGayh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bTvkfjvuOt5QmZsgVZ+bICfYaIzVvCjhGSn8i2tm85TnsqOxHiBHQi2MR8EcUznT3
	 CS8IQnRLsh++3pzI6RblJg7URscFMAAi8FTV1DG17RcYbGvURxKegnmBReglCfsRHq
	 MYl4dxfFLz3KYKdKIZab2j/TwbaR65LMdpgEjXrZ577NTI3t7I/CSb+qZNIikVhSX/
	 Y3woxHSyi230GmgAv3Z3rosdhuEnGlOAIgriYBgM9AW+Vh0s4kvA9Ethmt8j+WPBzF
	 OS/oR946RLUkZh4USq/4ZOGF2jr90KQajlaDnjRca976/dGV7nQOU8bRgfV5uQw1CL
	 C5PgcrUdIq4Mg==
Date: Tue, 29 Jul 2025 15:07:12 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Jan Prusakowski <jprusakowski@google.com>
Subject: Re: [PATCH] f2fs: dump more information when checkpoint was blocked
 for long time
Message-ID: <aIjjoBJqYjdNv63m@google.com>
References: <20250729063326.435167-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729063326.435167-1-chao@kernel.org>

On 07/29, Chao Yu wrote:
> generic/299 w/ mode=lfs will cause long time latency, let's dump more
> information once we hit case.
> 
> CP merge:
>   - Queued :    0
>   - Issued :    1
>   - Total :    1
>   - Cur time : 7565(ms)
>   - Peak time : 7565(ms)
> 
> F2FS-fs (vdc): checkpoint was blocked for 7565 ms, affecting 1 tasks
> CPU: 8 UID: 0 PID: 1614 Comm: f2fs_ckpt-253:3 Tainted: G           O        6.16.0-rc3+ #406 PREEMPT(voluntary)
> Tainted: [O]=OOT_MODULE
> Call Trace:
>  dump_stack_lvl+0x6e/0xa0
>  __checkpoint_and_complete_reqs+0x1a6/0x1d0
>  issue_checkpoint_thread+0x4b/0x140
>  kthread+0x10d/0x250
>  ret_from_fork+0x164/0x190
>  ret_from_fork_asm+0x1a/0x30

Can we add more information for debugging this?

> 
> Cc: Jan Prusakowski <jprusakowski@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/checkpoint.c | 9 ++++++++-
>  fs/f2fs/f2fs.h       | 3 +++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index db3831f7f2f5..b0dcaa8dc40d 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1788,8 +1788,15 @@ static void __checkpoint_and_complete_reqs(struct f2fs_sb_info *sbi)
>  
>  	spin_lock(&cprc->stat_lock);
>  	cprc->cur_time = (unsigned int)div64_u64(sum_diff, count);
> -	if (cprc->peak_time < cprc->cur_time)
> +	if (cprc->peak_time < cprc->cur_time) {
>  		cprc->peak_time = cprc->cur_time;
> +
> +		if (unlikely(cprc->peak_time >= CP_LONG_LATENCY_THRESHOLD)) {
> +			f2fs_warn_ratelimited(sbi, "checkpoint was blocked for %u ms, affecting %llu tasks",
> +					cprc->peak_time, count);
> +			dump_stack();
> +		}
> +	}
>  	spin_unlock(&cprc->stat_lock);
>  }
>  
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 46d23c2c086c..3130ca6a4770 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -350,6 +350,9 @@ struct ckpt_req_control {
>  	unsigned int peak_time;		/* peak wait time in msec until now */
>  };
>  
> +/* a time threshold that checkpoint was blocked for, unit: ms */
> +#define CP_LONG_LATENCY_THRESHOLD	5000
> +
>  /* for the bitmap indicate blocks to be discarded */
>  struct discard_entry {
>  	struct list_head list;	/* list head */
> -- 
> 2.49.0

