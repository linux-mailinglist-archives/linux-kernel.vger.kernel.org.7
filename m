Return-Path: <linux-kernel+bounces-818030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5F4B58BCD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5E92A2272
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAD8221FD0;
	Tue, 16 Sep 2025 02:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwg+t5Bf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E371D54FA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757989316; cv=none; b=VKIOjDzCe0sjL18W0MKyyGZ5YOHwh11bSjjpKy1Ksf8ZeT0jodTOLygVAnclIfjjU2OhfVoH2PXjmvVftHyEY8i3PMOBBEaAh/pZjTKWNz4wKvRQI9gxbUDUphR81otauG99RgELLphYkKLFlts38+WRW1bQySjLgAL74Q6OQPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757989316; c=relaxed/simple;
	bh=qFFHU9Ro9y1dW9pkQJIf+o5PCm3RfY+093ZluYDx62w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJqg5Cr0lY4OVGAk79BQgeCRM3suon73yPV+eQc5aDf+sstWsFUHK+Ks1XhR2ZxUrIu2jAXEHOkEsumUu3w0sH+hxWeDyaDqYJEc8KlK2fy1lKKiv6IPAZIv5lxyuAaQ0dqeeO1mNK1UDKDT5J6aEbXgr2UVkNRqd8SxDT+11cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwg+t5Bf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2216C4CEF1;
	Tue, 16 Sep 2025 02:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757989316;
	bh=qFFHU9Ro9y1dW9pkQJIf+o5PCm3RfY+093ZluYDx62w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nwg+t5BfvGtjH2BGhT1xMfM5GkVXBkx8Z7seHJHuf5LGw0Vti7AQI6FnSB9f6natz
	 5mRIOF7BRlgkDS+4wo3ykcsnTzUReBJ2e8zvL0ny8QUf6PGVM7CgBQ5+OWeaVHhj4Y
	 47mYfp14og3rwqFqdmOV2IByRNn8e3OqMZrMM4geCvyI9ss+CSCok50fFAruzzM0Jl
	 TJvPV9qsIyfjhn0IsHGZEYPtPnyQiOD1uEIMiZ1QNuoUbdr7K1ojPKJuT84YWb+EvF
	 iFBSQg02VHSYNoDnTO5LhLAzVE9z9SuKJXGBAXbyzlfCtPPAis1NsWFT5Oc+bkU4Da
	 kJTtChFk/tM4w==
Date: Tue, 16 Sep 2025 02:21:54 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: wangzijie <wangzijie1@honor.com>
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, bintian.wang@honor.com,
	feng.han@honor.com
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: fix infinite loop in
 __insert_extent_tree()
Message-ID: <aMjJwkQ3wQ0uNJXX@google.com>
References: <20250915035246.98055-1-wangzijie1@honor.com>
 <20250915035246.98055-2-wangzijie1@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915035246.98055-2-wangzijie1@honor.com>

On 09/15, wangzijie wrote:
> When we get wrong extent info data, and look up extent_node in rb tree,
> it will cause infinite loop (CONFIG_F2FS_CHECK_FS=n). Avoiding this by
> return NULL.

This is the exact buggy case which we should fix the original one. Have
you seen this error? In that case, can we consider writing some kernel
message and handle the error properly?


> 
> Signed-off-by: wangzijie <wangzijie1@honor.com>
> ---
>  fs/f2fs/extent_cache.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index 199c1e7a8..6ed6f3d1d 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -605,6 +605,7 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
>  			leftmost = false;
>  		} else {
>  			f2fs_bug_on(sbi, 1);
> +			return NULL;
>  		}
>  	}
>  
> -- 
> 2.25.1

