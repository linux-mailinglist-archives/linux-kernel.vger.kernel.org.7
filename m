Return-Path: <linux-kernel+bounces-730787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CE4B049CD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B8B17CEBF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19EE26C3A3;
	Mon, 14 Jul 2025 21:57:52 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B3925DAFF
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 21:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752530272; cv=none; b=msPs4s0PAI5kmqtVQsWWcWD0/D2itxuYDDAdS34r0u9aa7ycCGsVKAklrLk1fGV8lKHyj7l8eRVflAYRenOzchijBdQD5Wh9bY0ZlJSEHqo/52uWuOBn95Y/d7UDvCSasAWsC9YmYCgx5GjvNL1xtahjcaqX+HpJUSn8Qaj8/bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752530272; c=relaxed/simple;
	bh=9huY6HMu00Ea+Keyb6WaL10Pypyww3fi6uG7qdncQF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L9AFD1lPO99IU8DIjnlrNvDZ++xRbN71qx4bwIRXLBsOlRg7SehWuWEKUeMZJ0APNOp4PuJ426YLcshK7DJ7vGv/tKExf3ZhJCKXHKStJKoRPlYCu6YS0TTqYgokiLafwkAywZwi5DQuBVeMSGDyVyvNjlXXN+dP8EVaf8+JpIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 56ELvel8037039;
	Tue, 15 Jul 2025 06:57:40 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 56ELvdu1037036
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 15 Jul 2025 06:57:40 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5063eabd-2300-4cf9-b403-3423abf460ac@I-love.SAKURA.ne.jp>
Date: Tue, 15 Jul 2025 06:57:38 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] possible deadlock in ocfs2_try_remove_refcount_tree
To: linux-kernel@vger.kernel.org,
        Diogo Jahchan Koike <djahchankoike@gmail.com>
References: <00000000000032dd730620055fde@google.com>
 <000000000000fe6097062037e361@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000fe6097062037e361@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav402.rs.sakura.ne.jp
X-Virus-Status: clean

Please submit as a formal patch. You can add

Reviewed-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

tag.

On 2024/08/22 6:04, syzbot wrote:
> For archival purposes, forwarding an incoming command email to
> linux-kernel@vger.kernel.org.
> 
> ***
> 
> Subject: possible deadlock in ocfs2_try_remove_refcount_tree
> Author: djahchankoike@gmail.com
> 
> #syz test
> 
> Acquiring the locks in refcounttree should follow
> the ip_alloc --> ip_xattr ordering, as done by multiple
> code paths in ocfs2; otherwise, we risk an ABBA deadlock
> (i.e in the start transaction path).
> 
> Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
> ---
>  fs/ocfs2/refcounttree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
> index 1f303b1adf1a..32c0249ff253 100644
> --- a/fs/ocfs2/refcounttree.c
> +++ b/fs/ocfs2/refcounttree.c
> @@ -927,8 +927,8 @@ int ocfs2_try_remove_refcount_tree(struct inode *inode,
>  	struct ocfs2_inode_info *oi = OCFS2_I(inode);
>  	struct ocfs2_dinode *di = (struct ocfs2_dinode *)di_bh->b_data;
>  
> -	down_write(&oi->ip_xattr_sem);
>  	down_write(&oi->ip_alloc_sem);
> +	down_write(&oi->ip_xattr_sem);
>  
>  	if (oi->ip_clusters)
>  		goto out;
> @@ -944,8 +944,8 @@ int ocfs2_try_remove_refcount_tree(struct inode *inode,
>  	if (ret)
>  		mlog_errno(ret);
>  out:
> -	up_write(&oi->ip_alloc_sem);
>  	up_write(&oi->ip_xattr_sem);
> +	up_write(&oi->ip_alloc_sem);
>  	return 0;
>  }
>  


