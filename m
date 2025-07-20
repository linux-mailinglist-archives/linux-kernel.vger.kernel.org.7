Return-Path: <linux-kernel+bounces-737997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBB2B0B2FD
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 02:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D24017894E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 00:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD981DFF7;
	Sun, 20 Jul 2025 00:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iuLOYmCl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28EF9476
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 00:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752971696; cv=none; b=sEl1dM/5Dd025adtnSce3eWxhz8DqVx2UnheKQfJ/D1/2Q0ENE6CZDzTDTP0CTgv0JA1D7gUKxQH+xlWqh0GswlJxbw8C+aCmWl/Q2cPq/BMGtYzqVlZPqiWp50qMvsLJZR6Uv8iUT0J0eIihkTNdHBV1Qt5Z4hobUH8URSX1JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752971696; c=relaxed/simple;
	bh=yqcqSxRJPaa5WcY/AqX5FTjR6HbQANKo217deEzj74w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SiUOBFuxQ9KeAGqlty1ztvMfURWY/UysovP2zXiRG0QJH7G7aKmFjD2ekyycMkYSgWQD7i43P2Cx3+gRvYtvHZttif1P1jaoe4wrQIP7M/wcGJ4yHtPblOUP+MTlakxedmDstreeQqFXVwQAVbENg9DQ8nzGFavuoTMFccj3ofM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iuLOYmCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CB0C4CEE3;
	Sun, 20 Jul 2025 00:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752971696;
	bh=yqcqSxRJPaa5WcY/AqX5FTjR6HbQANKo217deEzj74w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iuLOYmCl+d0Ogn4XM2NMCpdwaj6QHPz1+1O3DXx1N+HYNHRvoO3cAzgHMY+mX2xY5
	 GCRjBDBHGZPdKLh1tLweUTME4SIrySHhhCPDdikvWj9DpVkLsWwse2OeDMS1DN4MSz
	 MixC2cFSntKv10Vetalopb5UtLWYRrJvw89eAWMI=
Date: Sat, 19 Jul 2025 17:34:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com,
 baohua@kernel.org, chrisl@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: swap: correctly use maxpages in swapon syscall to
 avoid potential deadloop
Message-Id: <20250719173455.35f8082916a76a416764d32d@linux-foundation.org>
In-Reply-To: <20250718065139.61989-1-shikemeng@huaweicloud.com>
References: <20250718065139.61989-1-shikemeng@huaweicloud.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Jul 2025 14:51:39 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:

> We use maxpages from read_swap_header() to initialize swap_info_struct,
> however the maxpages might be reduced in setup_swap_extents() and the
> si->max is assigned with the reduced maxpages from the
> setup_swap_extents().
> 
> Obviously, this could lead to memory waste as we allocated memory based on
> larger maxpages, besides, this could lead to a potential deadloop as
> following:
> 
> 1) When calling setup_clusters() with larger maxpages, unavailable
>    pages within range [si->max, larger maxpages) are not accounted with
>    inc_cluster_info_page().  As a result, these pages are assumed
>    available but can not be allocated.  The cluster contains these pages
>    can be moved to frag_clusters list after it's all available pages were
>    allocated.
> 
> 2) When the cluster mentioned in 1) is the only cluster in
>    frag_clusters list, cluster_alloc_swap_entry() assume order 0
>    allocation will never failed and will enter a deadloop by keep trying
>    to allocate page from the only cluster in frag_clusters which contains
>    no actually available page.
> 
> Call setup_swap_extents() to get the final maxpages before
> swap_info_struct initialization to fix the issue.
> 
> After this change, span will include badblocks and will become large
> value which I think is correct value:
> In summary, there are two kinds of swapfile_activate operations.
> 1. Filesystem style: Treat all blocks logical continuity and find
> usable physical extents in logical range. In this way, si->pages
> will be actual usable physical blocks and span will be "1 +
> highest_block - lowest_block".
> 2. Block device style: Treat all blocks physically continue and
> only one single extent is added. In this way, si->pages will be
> si->max and span will be "si->pages - 1".
> Actually, si->pages and si->max is only used in block device style
> and span value is set with si->pages. As a result, span value in
> block device style will become a larger value as you mentioned.
> 
> I think larger value is correct based on:
> 1. Span value in filesystem style is "1 + highest_block -
> lowest_block" which is the range cover all possible phisical blocks
> including the badblocks.
> 2. For block device style, si->pages is the actual usable block
> number and is already in pr_info. The original span value before
> this patch is also refer to usable block number which is redundant
> in pr_info.
>
> Link: https://lkml.kernel.org/r/20250522122554.12209-3-shikemeng@huaweicloud.com
> Fixes: 661383c6111a ("mm: swap: relaim the cached parts that got scanned")
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reviewed-by: Baoquan He <bhe@redhat.com>
> ---
> v1->v2:
> -Fix typo
> -Add description of behavior change of "span" in git log

I queued this change:

> -Ensure si->pages == si->max - 1 after setup_swap_extents()

as a -fix against the v1 patch and updated the base patch's changelog,
thanks.

--- a/mm/swapfile.c~mm-swap-correctly-use-maxpages-in-swapon-syscall-to-avoid-potensial-deadloop-fix
+++ a/mm/swapfile.c
@@ -3357,6 +3357,12 @@ SYSCALL_DEFINE2(swapon, const char __use
 		error = nr_extents;
 		goto bad_swap_unlock_inode;
 	}
+	if (si->pages != si->max - 1) {
+		pr_err("swap:%u != (max:%u - 1)\n", si->pages, si->max);
+		error = -EINVAL;
+		goto bad_swap_unlock_inode;
+	}
+
 	maxpages = si->max;
 
 	/* OK, set up the swap map and apply the bad block list */
_


