Return-Path: <linux-kernel+bounces-847651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4602DBCB5AB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34F704EF008
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D2521C16A;
	Fri, 10 Oct 2025 01:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vmMnu0rc"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB8D21A95D
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 01:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760059282; cv=none; b=jj6O25LKucv0iBTGNF7cfR214X74hPos/X10CHpvv0Fnv16vf4v0mpxe/D8PN715KopkT5gYBzBt9VByLTzoly93wUFk8MSv2ypyhUorGE394lSJnIEOKWJX6MX6THp+ni/WyikjLoowbZywJ5BPKoOH056N9SDKTD4L7SdgCnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760059282; c=relaxed/simple;
	bh=xUtmWe67ZqFeLIiEL9eePSKMyiEK2CmZPDmwXazHsD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/C27OE39gzyk9miE7D3wa+ckk+I8g9gdQ8SoHc04EbAP+RrCd3UdD0WhXLEhXkXUHLnlPJg94suswLgkijqJwFwfVdcj6xyLhQ9RQ7XStVNARRlgdCL0aXVXS6vX+V0t7i5NPaZRugPkWktslQbR+5uKsfIq4Y7yIcIW2YrLh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vmMnu0rc; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760059271; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=2ao8FChmO4IoZqDlweIZMfaW7a93d3gZNFGiNAvuUFk=;
	b=vmMnu0rck7NL0iHyEJFLt2iUuEQoB+I7PmItRn1PlJvUp9FPCHnc0GLokqU1wuM5I0aOMZGpYRwNd0lwYQ+jc7YZKrQzAlj74kQ8AkskAZWOM5DqbdPM+gozqp6V5UX653DzRuXR9lT1p29JPomOWJU2q86s3wZv1vU4ZBjShEc=
Received: from 30.221.128.133(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Wpr7EAm_1760059270 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Oct 2025 09:21:10 +0800
Message-ID: <94c9efca-2805-4fcb-a52b-e26eac8f58e1@linux.alibaba.com>
Date: Fri, 10 Oct 2025 09:21:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ocfs2: clear extent cache after moving/defragmenting
 extents
To: Deepanshu Kartikey <kartikey406@gmail.com>, mark@fasheh.com,
 jlbec@evilplan.org, akpm <akpm@linux-foundation.org>
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com
References: <20251009154903.522339-1-kartikey406@gmail.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20251009154903.522339-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/10/9 23:49, Deepanshu Kartikey wrote:
> The extent map cache can become stale when extents are moved or
> defragmented, causing subsequent operations to see outdated extent
> flags. This triggers a BUG_ON in ocfs2_refcount_cal_cow_clusters().
> 
> The problem occurs when:
> 1. copy_file_range() creates a reflinked extent with OCFS2_EXT_REFCOUNTED
> 2. ioctl(FITRIM) triggers ocfs2_move_extents()
> 3. __ocfs2_move_extents_range() reads and caches the extent (flags=0x2)
> 4. ocfs2_move_extent()/ocfs2_defrag_extent() calls __ocfs2_move_extent()
>    which clears OCFS2_EXT_REFCOUNTED flag on disk (flags=0x0)
> 5. The extent map cache is not invalidated after the move
> 6. Later write() operations read stale cached flags (0x2) but disk has
>    updated flags (0x0), causing a mismatch
> 7. BUG_ON(!(rec->e_flags & OCFS2_EXT_REFCOUNTED)) triggers
> 
> Fix by clearing the extent map cache after each extent move/defrag
> operation in __ocfs2_move_extents_range(). This ensures subsequent
> operations read fresh extent data from disk.
> 
> Link: https://lore.kernel.org/all/20251009142917.517229-1-kartikey406@gmail.com/T/
> Reported-by: syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com
> Tested-by: syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=2959889e1f6e216585ce522f7e8bc002b46ad9e7
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

Looks fine.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
> Changes in v2:
>   - Fix moved to __ocfs2_move_extents_range() instead of ocfs2_refcount_cow()
>   - The real issue is in FITRIM/move_extents code path, not COW path
>   - COW path already clears cache at end of ocfs2_refcount_cow_hunk()
> 
>  fs/ocfs2/move_extents.c | 5 +++++
>  1 file changed, 5 insertions(+)
> ---
>  fs/ocfs2/move_extents.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
> index 86f2631e6360..10923bf7c8b8 100644
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


