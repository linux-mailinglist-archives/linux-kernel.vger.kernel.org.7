Return-Path: <linux-kernel+bounces-719048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E3CAFA936
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 03:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2AA188C1D8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 01:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3636B248871;
	Mon,  7 Jul 2025 01:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Zrn8ej2q"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB142472BF
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 01:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751851983; cv=none; b=j9XEdmmBR56dAsNpO7+8zYjnRoXnKAfKJhPSSCDniquyUPzMXsdkC0e0VafCP4iguhZULCXuO9TDXkY3YwD0ThtZv0Jj474rljPhk+M+rBsg0JxCN3/PPGwtqmYDE4Cvp5mi/lDuKANYxlfDXsw4SObbX9VXnDRxkH2VzhZc/VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751851983; c=relaxed/simple;
	bh=VhBAXVHqA2y0PKoVp3MooK8qYZAANLEWHU3SLrh79x0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=evsg8QNfbi0kQjbPNkCA3/FU7cvexhRok0qG0mg9d8/wAoRBxCInxoxIoX6cAuLjyYI5So08gm4SmzHQP96sA/rXUM70wMYbBMXsHBgq0vGKWmLKxqroyqlXUySL6nGo88ZpK1pXZGxHwNxlfYG2zhhrEto3xdqoIdKuiXXKeKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Zrn8ej2q; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751851973; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=O+fTTXT8PE7FD3pk+VZsqgiXBxLh6UlUQp+bxT5zKic=;
	b=Zrn8ej2q246Nmx+M4jLo4Nn3v3jmldh3butCz8KdV71o3GxXpUep6OvxvudfGUFUcN9YAdGWkYM0vFy5y9z1y6Af7M5IIW7Pfaw36BeBYelm5GpMyUp5c5mRspuP9rkaaLH1ySjQK5LzaNQbT2iSEw+HQryEP7/hieZjmLVk73A=
Received: from 30.221.128.189(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WhxrwvO_1751851972 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 07 Jul 2025 09:32:52 +0800
Message-ID: <02850dc3-1827-433a-89f1-b66553efe02a@linux.alibaba.com>
Date: Mon, 7 Jul 2025 09:32:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: avoid potential ABBA deadlock by reordering
 tl_inode lock
To: Ivan Pravdin <ipravdin.official@gmail.com>, mark@fasheh.com,
 jlbec@evilplan.org, ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: syzbot+6bf948e47f9bac7aacfa@syzkaller.appspotmail.com
References: <20250705175315.225246-1-ipravdin.official@gmail.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20250705175315.225246-1-ipravdin.official@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/7/6 01:53, Ivan Pravdin wrote:
> In ocfs2_move_extent(), tl_inode is currently locked after the global
> bitmap inode. However, in ocfs2_flush_truncate_log(), the lock order
> is reversed: tl_inode is locked first, followed by the global bitmap
> inode.
> 
It's indeed buggy here.

> This creates a classic ABBA deadlock scenario if two threads attempt
> these operations concurrently and acquire the locks in different orders.
> 
> To prevent this, move the tl_inode locking earlier in
> ocfs2_move_extent(), so that it always precedes the global bitmap
> inode lock.
> 
> No functional changes beyond lock ordering.
> 
> Reported-by: syzbot+6bf948e47f9bac7aacfa@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67d5645c.050a0220.1dc86f.0004.GAE@google.com/
> Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
> ---
>  fs/ocfs2/move_extents.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
> index 369c7d27befd..ab460cb2c9c8 100644
> --- a/fs/ocfs2/move_extents.c
> +++ b/fs/ocfs2/move_extents.c
> @@ -617,6 +617,8 @@ static int ocfs2_move_extent(struct ocfs2_move_extents_context *context,
>  	 */
>  	credits += OCFS2_INODE_UPDATE_CREDITS + 1;
>  
> +	inode_lock(tl_inode);
> +

The following out_unlock should do the corresponding order changes.

Thanks,
Joseph

>  	/*
>  	 * ocfs2_move_extent() didn't reserve any clusters in lock_allocators()
>  	 * logic, while we still need to lock the global_bitmap.
> @@ -637,8 +639,6 @@ static int ocfs2_move_extent(struct ocfs2_move_extents_context *context,
>  		goto out_unlock_gb_mutex;
>  	}
>  
> -	inode_lock(tl_inode);
> -
>  	handle = ocfs2_start_trans(osb, credits);
>  	if (IS_ERR(handle)) {
>  		ret = PTR_ERR(handle);


