Return-Path: <linux-kernel+bounces-847657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A853BCB5D5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F32BB4EBDFF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA1A22425B;
	Fri, 10 Oct 2025 01:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="uxOhuoGB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754314414;
	Fri, 10 Oct 2025 01:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760060243; cv=none; b=oNg10LTN07ntApIK9oXmD38qe1MBmDbTe+uSuBv13ZafCMyDD9QWNvMXVtT4nox24qONiV6Fxylr+H17m9GNlPtIsLYS0Vo/68Bp8tUymKljpmpcYOJyVk6JdrBbbmGB+wDiDHZSYI31j1OUJQWRk+XYVugLcEisbkN6pS4t6dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760060243; c=relaxed/simple;
	bh=ckaE+jv9ON2BOmGUZPgN/iEZNmEmdNrtYO4ymFJ42FA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=P9ZOItgRLESdulIdNimQRAqNfEu00o8i+l/RWOIlLu3YMwsetVPYHkvAVuChEV+yBYElUPl8qw4HDOFuBSZWYlSQ9E4h/RLtnWyGg/fogrH3U955wRbodiA3GZfxNJoRdoBZiqcATJooV2wSaBI0a+6IMkQo7dnj2CFUmCCuimw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=uxOhuoGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB59CC4CEE7;
	Fri, 10 Oct 2025 01:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1760060243;
	bh=ckaE+jv9ON2BOmGUZPgN/iEZNmEmdNrtYO4ymFJ42FA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uxOhuoGBFkoiLkyNIk2WO3OryE/HTz6+txkdgewek9E9yOs4WdTj9iBu5IyMJfROU
	 bVvbYtEX7bPFL+5Ie2KF8/jWHFbmKqasGlF6nlsTI7s1DJaGh3t8uZVrTpVCeCbf0p
	 caKPOAiiTn6YHJNKwd/Yrmgg9P5pWaH2IRrMvg4o=
Date: Thu, 9 Oct 2025 18:37:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
 ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] ocfs2: clear extent cache after moving/defragmenting
 extents
Message-Id: <20251009183722.c81e37002e707135da04c94c@linux-foundation.org>
In-Reply-To: <20251009154903.522339-1-kartikey406@gmail.com>
References: <20251009154903.522339-1-kartikey406@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 Oct 2025 21:19:03 +0530 Deepanshu Kartikey <kartikey406@gmail.com> wrote:

> The extent map cache can become stale when extents are moved or
> defragmented, causing subsequent operations to see outdated extent
> flags. This triggers a BUG_ON in ocfs2_refcount_cal_cow_clusters().

We try to avoid BUG_ONs ;)

>
> ...
>
> The problem occurs when:
>
> ...
>

> --- a/fs/ocfs2/move_extents.c
> +++ b/fs/ocfs2/move_extents.c
> @@ -867,6 +867,11 @@ static int __ocfs2_move_extents_range(struct buffer_head *di_bh,
>  			mlog_errno(ret);
>  			goto out;
>  		}
> +		/*
> +		 * Invalidate extent cache after moving/defragging to prevent
> +		 * stale cached data with outdated extent flags.
> +		 */
> +		ocfs2_extent_map_trunc(inode, cpos);
>  
>  		context->clusters_moved += alloc_size;
>  next:

I assume we should backport this into earlier kernels, so I'll add a
cc:stable to the changelog.

It's very nice (but not essential) to add a Fixes: as well, so -stable
maintainers know how far back in time to backport the fix.


